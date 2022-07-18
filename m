Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49DE577D72
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiGRI0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiGRI0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:26:18 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319ED11808;
        Mon, 18 Jul 2022 01:26:17 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26I7bu0X011573;
        Mon, 18 Jul 2022 10:26:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=BfPiABITD7uYe270apArKx4X3woahNqN8ZZ+BShAQm0=;
 b=8Z/gVg9fWZa5/htpwfER1UhAB9a/lDD2dGUnf7j+Cs8VZ7p1sxk7szEz49wsGAPM3FnG
 AJRUBYRoyHYMAkn93oikOFXDd4gjRbHMUwVeqaPwd9Fh77b4nA7vw1fTWvC8ha/SiVY8
 PT7Cs+IHyCJthvQMewXzG86DM8KB7hCtx5ZvgSYRfJv586Nj//E559tBCKFbpmv/g9B6
 EKHe5Tas4yC5nIASfUJLTAJkQHNFYpDTO9/Isn3O6P9zfTbpH+NjRUGDpF7RjEUgb9RU
 mpfklEmLz54iuiHDxVwnjYqWRmbVbMzSzHA7kGS88eZyiQX5zM8LZkLlzI3kDhAXiaO4 7g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3hbnq27y77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 10:26:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 320B510002A;
        Mon, 18 Jul 2022 10:26:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 22DC82138C4;
        Mon, 18 Jul 2022 10:26:11 +0200 (CEST)
Received: from [10.252.21.88] (10.75.127.45) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 18 Jul
 2022 10:26:08 +0200
Message-ID: <0eaabd6c-07bd-eb83-da9d-6195b350bc9a@foss.st.com>
Date:   Mon, 18 Jul 2022 10:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/4] Introduction of rpmsg_rx_done
Content-Language: en-US
To:     Chris Lew <quic_clew@quicinc.com>, <bjorn.andersson@linaro.org>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <1654651005-15475-1-git-send-email-quic_clew@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_04,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chris,

On 6/8/22 03:16, Chris Lew wrote:
> This series proposes an implementation for the rpmsg framework to do
> deferred cleanup of buffers provided in the rx callback. The current
> implementation assumes that the client is done with the buffer after
> returning from the rx callback.
> 
> In some cases where the data size is large, the client may want to
> avoid copying the data in the rx callback for later processing. This
> series proposes two new facilities for signaling that they want to
> hold on to a buffer after the rx callback.
> They are:
>  - New API rpmsg_rx_done() to tell the rpmsg framework the client is
>    done with the buffer
>  - New return codes for the rx callback to signal that the client will
>    hold onto a buffer and later call rpmsg_rx_done()
> 
> This series implements the qcom_glink_native backend for these new
> facilities.

The API you proposed seems to me quite smart and adaptable to the rpmsg
virtio backend.

My main concern is about the release of the buffer when the endpoint
is destroyed.

Does the buffer release should be handled by each services or by the
core?

I wonder if the buffer list could be managed by the core part by adding
the list in the rpmsg_endpoint structure. On destroy the core could call
the rx_done for each remaining buffers in list...

I let Bjorn and Mathieu advise on this...

Thanks,
Arnaud

>  
> Chris Lew (4):
>   rpmsg: core: Add rx done hooks
>   rpmsg: char: Add support to use rpmsg_rx_done
>   rpmsg: glink: Try to send rx done in irq
>   rpmsg: glink: Add support for rpmsg_rx_done
> 
>  drivers/rpmsg/qcom_glink_native.c | 112 ++++++++++++++++++++++++++++++--------
>  drivers/rpmsg/rpmsg_char.c        |  50 ++++++++++++++++-
>  drivers/rpmsg/rpmsg_core.c        |  20 +++++++
>  drivers/rpmsg/rpmsg_internal.h    |   1 +
>  include/linux/rpmsg.h             |  24 ++++++++
>  5 files changed, 183 insertions(+), 24 deletions(-)
> 

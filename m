Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8DD4E5034
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiCWKTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbiCWKTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:19:43 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736022AE9;
        Wed, 23 Mar 2022 03:18:09 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22N9Wdiv000571;
        Wed, 23 Mar 2022 11:18:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=cscpJKP+YTpsfI2Xqs/WsEvpgV755qDqbGsryfxbRHE=;
 b=KU5LShSdGc20mPYFyN/qzFqFyIXdiEv8TE1cx0/TX3cYJGwZ4LH3o3jSE1I4y8WKEmMy
 y8JxSTH8VHPTBTKA0JHJkq55TaVuwWTNtiy0jnxlH/9sM5+XTB7hy6YazSahXa9NTRb4
 ZkrBsrcP6k53yv4f/F3ttxW0N/Vv9GnEjwNmJx8tDWgviKVg5n0R69sgrsCYbET0v0bX
 E+uVCceStHRleh49wQqoWJaE8Ju+ML54cbvhD4IckkhvGrpD2tEnO4a/qHRA11MmU/c+
 CuOGxK2aFKQKyVWv41mGDE5tzSzlwG6kWGpL4/uAspFyJ3FdrdYoihtLMmm4isLOOU6s kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ew6xkhup7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 11:18:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C079100034;
        Wed, 23 Mar 2022 11:17:59 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 13F5A221793;
        Wed, 23 Mar 2022 11:17:59 +0100 (CET)
Received: from [10.201.20.246] (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 23 Mar
 2022 11:17:58 +0100
Message-ID: <5cde9477-d73c-03c4-4dc0-c63fa0f8c8d9@foss.st.com>
Date:   Wed, 23 Mar 2022 11:17:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 0/3] rpmsg and glink signaling API support
Content-Language: en-US
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>,
        <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
References: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <1642534993-6552-1-git-send-email-quic_deesin@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-23_05,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 1/18/22 20:43, Deepak Kumar Singh wrote:
> [Change from V1]
> Fixed most of the review comments in V1.

This implementation works for the glink transport,
But how to manage such flow control for other transport
layer?
From my POV it is important that it is also usable for
by transport backends which doe not have such signaling.
The idea here is not to implement in other backends yet, but
at least to determine how it could be handled to avoid that
tomorrow this has to be reworked. 

More than that I wonder if the flow control could also be used
to solve the RPmsg protocol issue related to the channel
announcement [1][2]

[1] https://github.com/OpenAMP/open-amp/pull/160
[2] https://lore.kernel.org/lkml/20220316153001.662422-1-arnaud.pouliquen@foss.st.com/

Thanks,
Arnaud

> 
> Deepak Kumar Singh (3):
>   rpmsg: core: Add signal API support
>   rpmsg: glink: Add support to handle signals command
>   rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
> 
>  drivers/rpmsg/qcom_glink_native.c | 77 +++++++++++++++++++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_char.c        | 47 ++++++++++++++++++++++--
>  drivers/rpmsg/rpmsg_core.c        | 21 +++++++++++
>  drivers/rpmsg/rpmsg_internal.h    |  2 +
>  include/linux/rpmsg.h             | 14 +++++++
>  5 files changed, 157 insertions(+), 4 deletions(-)
> 

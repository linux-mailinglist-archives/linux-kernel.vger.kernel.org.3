Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF060483FE4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiADK1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:27:22 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38222 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229604AbiADK1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:27:22 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20496YJu029256;
        Tue, 4 Jan 2022 11:27:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=UrKEQV90GZqzNO1RYyVS5khwIn//xoa1ZDH+Xbw8PWo=;
 b=wh/+YS9PNrXX+yOeBOWsOHGMPWG5ya0n8P61SHPvaTbsQo5mRADDgzFiQ4hovVrbZNDM
 93lmc1IwhMiJ6BYloqYUZCbUmrfClwhlHUstFDjJoOwtVj15Ipo2Ouz1DrUKsxMYAGTH
 sELQAMR8vx6sL8uOzgT7p7xICSMlF+aELphPOsSOJ0bS4cdxdyRovWj/gVbc1JUjD988
 qa39I/fN4MhcjysI+Sob0edjbkRdeS+AiUYsV9MR2W3rp2VKteKx8FKvQqul1pjQ2R6/
 CAwcCAwvTwCidW2+g0dxIEqsl8+5ubnA1djyD4GaEy860LOOtTrdyimsdv6fJnPjIR6s sA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dcagraamm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 11:27:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 88D3E100034;
        Tue,  4 Jan 2022 11:27:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 63DF0233C94;
        Tue,  4 Jan 2022 11:27:12 +0100 (CET)
Received: from lmecxl0993.lme.st.com (10.75.127.45) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 4 Jan
 2022 11:27:11 +0100
Subject: Re: [PATCH 4/5] drm/stm: ltdc: add support of flexible pixel formats
To:     Yannick Fertre <yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211215214835.20593-1-yannick.fertre@foss.st.com>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
Message-ID: <ce982156-3e67-835d-4de6-bb3cfc70fe5b@foss.st.com>
Date:   Tue, 4 Jan 2022 11:27:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215214835.20593-1-yannick.fertre@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_05,2022-01-04_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/21 10:48 PM, Yannick Fertre wrote:
> This feature allows the generation of any RGB pixel format.
> The list of supported formats is no longer linked to the
> register LXPFCR_PF, that the reason why a list of drm formats is
> defined for each display controller version.
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 196 ++++++++++++++++++++++++++-----------
>   drivers/gpu/drm/stm/ltdc.h |   5 +-
>   2 files changed, 145 insertions(+), 56 deletions(-)
> 

Hi Yannick,
many thanks for your patch.
Nice hw feature.
Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>
Reviewed-by: Philippe Cornu <philippe.cornu@foss.st.com>
Philippe :-)

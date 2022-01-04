Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C51483FD4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiADKYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:24:14 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36134 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229983AbiADKYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:24:13 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204921b0032531;
        Tue, 4 Jan 2022 11:24:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=vU8wlgG3uQoG6uJWKm6MRMT64cI1Gk2FfXZd1oRYUHc=;
 b=aKQWJd6lq6Ui9a96VlluHcqpjrLK/yiD50Gzt4zusv83gW4HHGxGOEKforw3pCjrOXsw
 7FeB0mhbbuybZi5ZhgmT3EvTrvVtlS8O/kS1LfKs1TTc1GztszxEYduGdCU6okPlcVXm
 AHmx/oPVcUhEe4hoGiT9bzbAPtbAY+XwTSu/WEwYacjpE5KAKZPeaT8byMo/LMpFPCGM
 uRzzcRzrTKjhLP/89o+mS2HiW5goorgB0CNYX2kSqgPZDS19ffZ26tyjIxoTPFqSKeMy
 Rz/1um/XDYWJDmL0105lt3+pB+1YrW3h/TsdyvhBRFp/iDtAzxnHIQlo0GVXDn9nzbju bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dcagraa7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 11:24:04 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 45C1110002A;
        Tue,  4 Jan 2022 11:24:03 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3D313233C81;
        Tue,  4 Jan 2022 11:24:03 +0100 (CET)
Received: from lmecxl0993.lme.st.com (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 4 Jan
 2022 11:24:02 +0100
Subject: Re: [PATCH 2/5] drm/stm: ltdc: add YCbCr 422 output support
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
References: <20211215214750.20105-1-yannick.fertre@foss.st.com>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
Message-ID: <e324c3cc-6109-7862-1cdf-2f8e3cc50cca@foss.st.com>
Date:   Tue, 4 Jan 2022 11:24:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215214750.20105-1-yannick.fertre@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_05,2022-01-04_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/21 10:47 PM, Yannick Fertre wrote:
> LTDC 40100 hw version supports the YCbCr 422 output,
> reducing the output pins from 24 to 16. This feature
> is useful for some external devices like HDMI bridges.
> 
> Both ITU-R BT.601 & ITU-R BT.709 are supported.
> 
> It is also possible to choose the chrominance order between
> * Cb is output first (Y0Cb, then Y1Cr, Y2Cb and so on).
> * Cr is output first (Y0Cr, then Y1Cb, Y2Cr and so on).
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 44 +++++++++++++++++++++++++++++++++++++-
>   drivers/gpu/drm/stm/ltdc.h |  1 +
>   2 files changed, 44 insertions(+), 1 deletion(-)
> 

Hi Yannick,
many thanks for your patch.
Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>
Reviewed-by: Philippe Cornu <philippe.cornu@foss.st.com>
Philippe :-)

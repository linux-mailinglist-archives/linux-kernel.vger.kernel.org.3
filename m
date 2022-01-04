Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366B8484017
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiADKr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:47:28 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:44944 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbiADKr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:47:28 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2049qTPv017114;
        Tue, 4 Jan 2022 11:47:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=+0dKcIbRZYgIqNsKgrQSZxJk3Ze4ZWIPAtapms3XYxM=;
 b=lNVmeWRzAB+acr2CHEJ7kZ1xCZSZJMu54kJ/en6Y+pVfIdEuCz0EO3s4TCTNyHgVuZ/m
 yU3Cj/l/qVFrPCcnHThunGsNLH4sTj8bmrKhpbvfbQ4iT6Uz7VJeFp8r8/zCFU0Gsbbz
 rzfGV+KR5aW9ssfj1+sa4zIss0AQ5vDYA+pZuIOfxbuslDzcPjcPT9ydaiUqAPsWvygL
 BRuii6Upb38M8c+oW4iF3jchQh7boA1ZLNcWsjMaaUCZpVNQCdFtMbQIq8w28+SE6b5q
 CNsCWScPzbmi8TDVauWV4+z8Fnh0V3uBMYrHWhrzVLj2wWh7zxVJGNFYPSzR+uGrZkDb Hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dccdnt0n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 11:47:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E3E810002A;
        Tue,  4 Jan 2022 11:47:05 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 16989235F20;
        Tue,  4 Jan 2022 11:47:05 +0100 (CET)
Received: from lmecxl0993.lme.st.com (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 4 Jan
 2022 11:47:03 +0100
Subject: Re: [PATCH 1/3] drm/stm: dsi: move lane capability detection in
 probe()
To:     Antonio Borneo <antonio.borneo@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20211218215055.212421-1-antonio.borneo@foss.st.com>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
Message-ID: <20c77dc1-7e7e-ec0e-f545-593d1cfeb3b3@foss.st.com>
Date:   Tue, 4 Jan 2022 11:47:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211218215055.212421-1-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_04,2022-01-01_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/21 10:50 PM, Antonio Borneo wrote:
> There is no need to re-compute the dsi lane capability because it
> only depends on dsi hw version.
> Since dsi hw version is detected at probe(), move there also the
> assignment of dsi lane capability.
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> ---
> To: David Airlie <airlied@linux.ie>
> To: Daniel Vetter <daniel@ffwll.ch>
> To: Andrzej Hajda <a.hajda@samsung.com>
> To: Neil Armstrong <narmstrong@baylibre.com>
> To: Robert Foss <robert.foss@linaro.org>
> To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> To: Jonas Karlman <jonas@kwiboo.se>
> To: Jernej Skrabec <jernej.skrabec@gmail.com>
> To: Yannick Fertre <yannick.fertre@foss.st.com>
> To: Philippe Cornu <philippe.cornu@foss.st.com>
> To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> To: Alexandre Torgue <alexandre.torgue@foss.st.com>
> To: Philipp Zabel <p.zabel@pengutronix.de>
> To: dri-devel@lists.freedesktop.org
> To: linux-stm32@st-md-mailman.stormreply.com
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 

Hi Antonio,
many thanks for your patch.
Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>
Reviewed-by: Philippe Cornu <philippe.cornu@foss.st.com>
Philippe :-)

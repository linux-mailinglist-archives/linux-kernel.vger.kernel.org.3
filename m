Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B22A48D555
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiAMKAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:00:10 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:54984 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232227AbiAMKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:00:09 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20D9lxFW031889;
        Thu, 13 Jan 2022 10:59:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=qpXYHkIcDxax05WYtw6onutWSxVatlONQz5hO4PIxAA=;
 b=I6CkSaWEDQCZo1Zig2pHXg6gtLUx5n+LPhyho7jtY0V2/CtmZaMKpxxdAk1X2hiMrcMy
 +zBKCmaH8pfzkqnMKRUMM/ys+v63DsMKznYzqTZTwlNWjbyzEWsBBWUjOomWbS5JYckK
 kqd8+IscJhBxmUUO1J6hGRCDCtVieUsrD+O6Hu0wGNFVeUmcxbK1YO5UEHxkDXFrgO/H
 6ovWIejspy9UZMf4hxzMxB4tp9RLTWlngzPW4WpuA/LntDSwMYImq505/oxOOTqD7PNF
 7mbT0SjD7V71zcPrGYWU4cG1bAheGVavATuSkEix5JKUWlVoaoGjvua5YuBgUcuKrzV7 GA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dj25b3vfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 10:59:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 548DA100034;
        Thu, 13 Jan 2022 10:59:55 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D0D320C8EA;
        Thu, 13 Jan 2022 10:59:55 +0100 (CET)
Received: from lmecxl1137.lme.st.com (10.75.127.46) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 13 Jan
 2022 10:59:54 +0100
Subject: Re: [PATCH 3/5] drm/stm: ltdc: add per plane update support
To:     Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20211215214817.20310-1-yannick.fertre@foss.st.com>
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Message-ID: <c86e1338-c8d6-f3b7-698c-73d8f04219cb@foss.st.com>
Date:   Thu, 13 Jan 2022 10:59:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211215214817.20310-1-yannick.fertre@foss.st.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_02,2022-01-13_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/15/21 10:48 PM, Yannick Fertre wrote:
> Recent ltdc hardware versions offer the ability
> to update a plane independently of others planes.
> This is could be useful especially if a plane is
> assigned to another OS.
>
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
>  drivers/gpu/drm/stm/ltdc.c | 26 +++++++++++++++++++++++---
>  drivers/gpu/drm/stm/ltdc.h |  1 +
>  2 files changed, 24 insertions(+), 3 deletions(-)

Hello Yannick,

Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

Thank you for this patch,
Raphaël


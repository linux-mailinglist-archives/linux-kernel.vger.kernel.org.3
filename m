Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F7E535ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiE0H5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbiE0H5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:57:43 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703BF3136F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:57:41 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24R6JKfu016200;
        Fri, 27 May 2022 02:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=N+a9sb4xyr+qi8RTEZxVC+qM4rBN4R20YOVvSGD6lo8=;
 b=j8PKh2u6yDGf2+VO5JdvM2Mt0rP0d05xL/Rmg18BbqJJyMzHXfKvbRIoesohK9khzSwp
 Pn1qFNa7n0noe/ZjbsCiB8Kx5Ug+XfiTjzNgSVZlDKFZh1S3gT2eLrfY3zSEfZTP9LIE
 lqr9k7uwL0GIoX/bGKtZuC9w0j63p70YXTvpteBkaWK+SyRM3akUw0Uv/fIxWoCAxiA6
 uFD4rvrzguUGue0QRLjQWDhzaMbNIbwcyCUNi/isJEs3fxDmK6tC1VupCb1P4ffuhBxW
 CLUMhFoYgUhhE4sZFCNILUndvjZK5VfKtO14AejZhbaFENsHGM3/rQk5AnsEZFPI9IIW WQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3g93u4k9ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 May 2022 02:56:25 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 27 May
 2022 08:56:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 27 May 2022 08:56:22 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E6CCE46C;
        Fri, 27 May 2022 07:56:22 +0000 (UTC)
Date:   Fri, 27 May 2022 07:56:22 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Adam Ford <aford173@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <aford@beaconembedded.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Stephen Kitt <steve@sk2.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        "open list:WOLFSON MICROELECTRONICS DRIVERS" 
        <patches@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Fix suspend while playing music
Message-ID: <20220527075622.GR38351@ediswmail.ad.cirrus.com>
References: <20220526182129.538472-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220526182129.538472-1-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: CdI6fm166QBGAmMEVa5QrgUYS6Ve4eqZ
X-Proofpoint-GUID: CdI6fm166QBGAmMEVa5QrgUYS6Ve4eqZ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 01:21:28PM -0500, Adam Ford wrote:
> If the audio CODEC is playing sound when the system is suspended,
> it can be left in a state which throws the following error:
> 
> wm8962 3-001a: ASoC: error at soc_component_read_no_lock on wm8962.3-001a: -16
> 
> Once this error has occurred, the audio will not work again until rebooted.
> 
> Fix this by configuring SET_SYSTEM_SLEEP_PM_OPS.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

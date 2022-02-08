Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5C74ADA66
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbiBHNut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376702AbiBHNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:50:46 -0500
X-Greylist: delayed 639 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 05:50:45 PST
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CD4C03FED7;
        Tue,  8 Feb 2022 05:50:45 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2187tlkh007467;
        Tue, 8 Feb 2022 07:50:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=/8VOHFZR1O1aA/Ads8wUp8bVwUNLX0h1y0p5epau7LY=;
 b=QmP/PjgcS5R1CDQ66O0C5BfXffWOurFqRcDBFVFpil1BOqpwpQQ44VgF8XC/CvhjR0if
 aQPEKFlhylWrcFpXfqXvidJVgQEdHqmKlrf25wwGl8qewUw4aZliV0HI4wXqkDBCstY7
 2fTVxAsR4Iy/lJHoleEdunq+gquEwyl86CZx5KZB/djOm1IaDJqktGFTV+yjMyNI0q5h
 hBNn4iU1pDUVXal2piycqjsHDGCEFZRfIAv29aumx03EwnZ5pAmC5lDuq8camp67mNNq
 8RxP0itBhsmFgsvDh1aVe8gnknZXSyzGfeCPwR6/5iRtpIKLK5640j79zifEVak8+2D2 PQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3e34y5scf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 07:50:38 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 13:50:36 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 8 Feb 2022 13:50:36 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id ACA0511D7;
        Tue,  8 Feb 2022 13:50:36 +0000 (UTC)
Date:   Tue, 8 Feb 2022 13:50:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
CC:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2] regmap-irq: Use regmap_irq_update_bits instead of
 regmap_write
Message-ID: <20220208135036.GD112838@ediswmail.ad.cirrus.com>
References: <20220119142953.1804-1-quic_pkumpatl@quicinc.com>
 <CGME20220208122955eucas1p2d4e32f51224242e9ebd0bce58b9c04ca@eucas1p2.samsung.com>
 <39f1b598-58ca-1e3d-3065-8dd692ee7c9f@samsung.com>
 <20220208133957.GC112838@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220208133957.GC112838@ediswmail.ad.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: IviAGyL3NSJelSl5gE0d9NZwqB_mNN7Z
X-Proofpoint-ORIG-GUID: IviAGyL3NSJelSl5gE0d9NZwqB_mNN7Z
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 01:39:57PM +0000, Charles Keepax wrote:
> On Tue, Feb 08, 2022 at 01:29:55PM +0100, Marek Szyprowski wrote:
> > Hi Prasad,
> > 
> > On 19.01.2022 15:29, Prasad Kumpatla wrote:
> > > With the existing logic by using regmap_write() all the bits in
> > > the register are being updated which is not expected. To update only the
> > > interrupt raised bit and not tocuhing other bits, replace regmap_write()
> > > with regmap_irq_update_bits().
> > >
> > > This patch is to fix the issue observed in MBHC button press/release events.
> > >
> > > Fixes: 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
> > > Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> > 
> > There is something wrong with this patch. Since it landed in linux-next 
> > (20220204) I get an interrupt storm on two of my test devices:
> > 
> > 1. ARM 32bit Exynos4412-based Trats2 ("wm8994-codec wm8994-codec: FIFO 
> > error" message)
> > 
> > 2. ARM 64bit Exynos5433-based TM2e ("arizona spi1.0: Mixer dropped 
> > sample" message)
> > 
> > Definitely the interrupts are not acknowledged properly. Once I find 
> > some spare time, I will check it further which regmap configuration 
> > triggers the issue, but it is definitely related to this patch. 
> > Reverting it on top of current linux-next fixes the issue.
> > 
> 
> Yeah I was just looking at this patch it looks a bit weird. Like
> most IRQ acks are write 1 to clear, so doing an update_bits seems
> unlikely to work, as it will ack every pending interrupt. As the
> whole idea of doing a regmap_write was to only write 1 to the bits
> that need ACKed.
> 
> I suspect what is needed here is the inverted case wants an
> update bits but the normal case needs to stay as a regmap_write.
> 

Apologies for the multiple emails, yeah looking at this I think
need some more information on how the hardware that patch was
addressing works. I don't quite understand what was wrong with
the old code even in the inverted case, the old code wrote a 1 to
every bit except the interrupt being cleared which gets a 0. This
feels like how I would have thought a write 0 to clear IRQ would
work, you don't want to clear any other bits so you write 1 to
them.

The update_bits is really problematic as even in the write 0 to
clear case, if a new interrupt asserts between the regmap_read
and regmap_write that make up the update_bits, you will clear that
new interrupt without ever noticing it.

Thanks,
Charles

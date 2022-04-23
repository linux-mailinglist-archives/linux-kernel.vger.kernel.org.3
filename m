Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E12B50C5DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 03:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiDWBDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 21:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiDWBD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 21:03:28 -0400
X-Greylist: delayed 39070 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 18:00:31 PDT
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C3D5C671;
        Fri, 22 Apr 2022 18:00:30 -0700 (PDT)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 553EF3ECDF;
        Sat, 23 Apr 2022 03:00:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id A2F5E2A374;
        Sat, 23 Apr 2022 01:00:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Zdi33cixN-Om; Sat, 23 Apr 2022 01:00:24 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Sat, 23 Apr 2022 01:00:24 +0000 (UTC)
Received: from [172.16.34.145] (unknown [113.67.11.122])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 6B041401C4;
        Sat, 23 Apr 2022 01:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1650675623; bh=N4i/1Sl8XBZEoIx04G8sQIpXEjM3YdS6eNFHmG+4P2c=;
        h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
        b=j8JylXwwyvys35BdMKnA21asyRFKv5QAT5RyRJye1BcC4s4ZxAYq3xb4ALCDLsVxJ
         yXrpji/F3661RFq/bT/yfPsdoJc8gwd28N2Fa41NhKFWxvDqTk7uxBtZo/NedaZcSt
         fcg4g4Jn7K+v+hH5i+xOX1dSZtSlmfsOP3DQD4JM=
Message-ID: <41a8e5353f95ec1031f5700588313d379b63ec78.camel@aosc.io>
Subject: Re: [PATCH 4/4] spi: sun6i: add support for R329 SPI controllers
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Samuel Holland <samuel@sholland.org>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
In-Reply-To: <0b5b586a-3bc7-384e-103c-e40d0b2fac23@sholland.org>
References: <20220422155639.1071645-1-icenowy@outlook.com>
         <BYAPR20MB2472717D5AC20E7702329996BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
         <0b5b586a-3bc7-384e-103c-e40d0b2fac23@sholland.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Sat, 23 Apr 2022 08:07:10 +0800
User-Agent: Evolution 3.40.4 
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,T_SPF_PERMERROR,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022-04-22星期五的 18:59 -0500，Samuel Holland写道：
> On 4/22/22 10:56 AM, icenowy@outlook.com wrote:
> > From: Icenowy Zheng <icenowy@aosc.io>
> > 
> > R329 has two SPI controllers. One of it is quite similar to
> > previous
> > ones, but with internal clock divider removed; the other added MIPI
> > DBI
> > Type-C offload based on the first one.
> > 
> > Add basical support for these controllers. As we're not going to
> > support the DBI functionality now, just implement the two kinds of
> > controllers as the same.
> 
> I'm curious what speeds you were able to use SPI at. On D1, with
> effectively
> these same changes, I would always get corrupted data when reading
> from the
> onboard SPI NAND on the Nezha board. However, if I enabled the "new
> mode of
> sample timing" (bit 2 in GBL_CTL_REG), I got the correct data.

See 7.3.3.10 of R329_User_Manual_v1.0.pdf ? (named SPI sample mode and
Run Clock configuration)

> 
> Regards,
> Samuel



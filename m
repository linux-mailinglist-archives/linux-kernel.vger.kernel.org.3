Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3294AB71D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244952AbiBGIyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiBGIuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:50:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DA1C043181;
        Mon,  7 Feb 2022 00:50:05 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p24so2216165ejo.1;
        Mon, 07 Feb 2022 00:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kp8nZg26AuEMvm8QEtueCcP+FrKWg8a9EQmnI5dKMtc=;
        b=i9NmlbplMBKyJptoV+0Ap8F9ZDNfpzM54h3O+whKY55ghEvHjqUCIQCPE3Vc9y4XfN
         SdPnc1zwArIgWqV9fIhoPMKyO73MpLg5XV/24wUbnMuveF3DCkgjjXZZPmMZa/BqjdmO
         kXV+wu2MlLamw4IqRXaFIQ1JWx95IvHQUJhIxh0QUodKAIeE7+qQD86oPdTQjmthaC1n
         HRl4F/EuM83ftwuIKQORLweYYBiWXs/Nh2Hfj0XuPSy0ehR8X4rCHvMQgct1nulZmpEc
         PqpRfpNMmc6oH4pKLjFX5f4aSKl/+WKldpaxPh9IP8Oi3H1NC5cP6acRJ5KG4muZ8KwE
         RayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kp8nZg26AuEMvm8QEtueCcP+FrKWg8a9EQmnI5dKMtc=;
        b=Q6eoJDINIMj7XB2oAkUORyeu66MPMYVc/NPPN/yoXpTusTYhcx+SnoCDHO7Tbln33L
         /cj5gn3KmgdphuXB37zofOszZudMycIqSjn0op5zQiMCZt3j15MCINKkhZNrHkIZbD/b
         rYnDPnxsg7gtJTOnuTh//yWYB9BWJgApQs7u1wRgM4v2IKI32dc8uTf9kqPEjNv7DZBF
         IqjXpYe7AgdqkelQ/+htwVafSqktnn2P3Ez5N5AiFj76sTu6t6sRa+ZHnh0N2hGGoGdW
         xp5Pg3IQrZcTdff9F0ouNLrv+nyx0k1e5rkLN8swlOwWTaOFcDhKrdrvpuBjmUEyohvY
         K+gw==
X-Gm-Message-State: AOAM530Jz5Nboawpz9oGhglyJfvCE1/A4s2kInMpR2mnsbIxDR9hLKwa
        TzWKbD6eZpMKjsQZls1myaI=
X-Google-Smtp-Source: ABdhPJxIrJn4H6z5Uh+XugYTFQFkEqQT/xm3/GRroGI4nndtytFjOtPRhPBD8MtsV1QLALi1vZOmmQ==
X-Received: by 2002:a17:906:619:: with SMTP id s25mr9129849ejb.341.1644223803512;
        Mon, 07 Feb 2022 00:50:03 -0800 (PST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id hq28sm3417230ejc.204.2022.02.07.00.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 00:50:02 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Samuel Holland <samuel@sholland.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-staging@lists.linux.dev,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 02/66] dt-bindings: interconnect: sunxi: Add V3s mbus compatible
Date:   Mon, 07 Feb 2022 09:50:00 +0100
Message-ID: <8021451.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <YgDbv8aQEOOjwTb0@aptenodytes>
References: <20220205185429.2278860-1-paul.kocialkowski@bootlin.com> <5386b1f5-9e75-4ce3-6641-bd7667c85d42@sholland.org> <YgDbv8aQEOOjwTb0@aptenodytes>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Dne ponedeljek, 07. februar 2022 ob 09:43:43 CET je Paul Kocialkowski 
napisal(a):
> Hi,
> 
> On Sat 05 Feb 22, 14:14, Samuel Holland wrote:
> > On 2/5/22 12:53 PM, Paul Kocialkowski wrote:
> > > Since the V3s uses the internal mbus, document its compatible.
> > > 
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > > 
> > >  .../devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml  | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.
> > > yaml
> > > b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.
> > > yaml index 29c9961ee2d8..b67bf9261a6a 100644
> > > ---
> > > a/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.
> > > yaml +++
> > > b/Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.
> > > yaml> > 
> > > @@ -31,6 +31,7 @@ properties:
> > >        - allwinner,sun5i-a13-mbus
> > >        - allwinner,sun8i-h3-mbus
> > >        - allwinner,sun8i-r40-mbus
> > > 
> > > +      - allwinner,sun8i-v3s-mbus
> > 
> > Please enable the expanded binding added in commit 245578ba9f03
> > ("dt-bindings: arm: sunxi: Expand MBUS binding")[1] by adding the new
> > compatible to the "if" block lower in the file. That way we can add V3S
> > devfreq support in the future without changing that binding.
> 
> I had missed that new driver but surely I will expand the updated binding.
> 
> By the way do you have an explanation about the cell index given to the
> interconnects (after &mbus)?

This is mbus channel. You can find appropriate one checking DRAM driver in U-
Boot, where mbus is configured.

Best regards,
Jernej

> 
> Paul
> 
> > Regards,
> > Samuel
> > 
> > [1]: https://git.kernel.org/torvalds/c/245578ba9f03
> > 
> > >        - allwinner,sun50i-a64-mbus
> > >    
> > >    reg:





Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFE44E902E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbiC1Ibv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbiC1Ibt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:31:49 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Mar 2022 01:30:06 PDT
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362D413D32;
        Mon, 28 Mar 2022 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1648456208;
  x=1679992208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6lodqU722XqqMCnjzMd3/cpwy1KHIQLMRjx1NSCdEKA=;
  b=dK0NkDNIrE+1O1Mr6UHChku4GO1I8+QNjRKCSdMBzYDCBIo8jD2EcKqa
   MbrwOk5EwyMQZmga5eBqxqdLtzBsN0o7D+4YCB7Gp8TTGw0FEhC8zFWFI
   dSduFBklVQ4xJThQbSNCaC8TlJ4NIchnQf2BANEr8lZ02NJZlH1JYOTva
   pdVgIoTx/umKDQ6MAffb9e47m0fx74YMfO+wrFknWVFtjGeWbHi7M9grQ
   fLDy5RRCiClaLJ3yZb6kCsVx+dpkmpeAKAXoyL7dc85od4NQ8ehN+yVpr
   65ABdKdAeITuZeNCa+8Zy3YhCMn3MAbxgghjW4q52RLjeDEAyoYn2DXu6
   g==;
Date:   Mon, 28 Mar 2022 10:28:58 +0200
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Ansuel Smith <ansuelsmth@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-actions@lists.infradead.org" 
        <linux-actions@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@axis.com>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "kernel@dh-electronics.com" <kernel@dh-electronics.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-unisoc@lists.infradead.org" <linux-unisoc@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Subject: Re: [RFC PATCH 1/1] ARM/arm64: categorize dts in arm dir and fix
 dependency in arm64
Message-ID: <20220328082858.GJ7371@axis.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <20220328000915.15041-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220328000915.15041-2-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ansuel,

On Mon, Mar 28, 2022 at 02:09:15AM +0200, Ansuel Smith wrote:
> - Categorize every dts in arm directory in subdirectory
> - Fix Makefile to address for the arm subdirectory
> - Fix any arm64 dependency
> [...]
>  arch/arm/boot/dts/axix/Makefile               |    3 +
>  .../boot/dts/{ => axix}/artpec6-devboard.dts  |    0
>  arch/arm/boot/dts/{ => axix}/artpec6.dtsi     |    0

All ARTPEC platforms should be in a directory called "axis".
Otherwise LGTM.

Thanks!

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

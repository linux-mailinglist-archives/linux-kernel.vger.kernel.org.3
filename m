Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9443B564FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiGDIrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiGDIqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:46:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE81BC1C;
        Mon,  4 Jul 2022 01:46:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C6506601638;
        Mon,  4 Jul 2022 09:46:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656924399;
        bh=R+jPQDQz31uGzbA+I3t13TC7Pm3CHBJfMIbtLFynbJc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZwEVDT7bh3ClwE4hCtFrRK6QldluIZRtMf28iTUXRQRKSFkhv2a3BrK+CGYZ6GhU5
         opneRPXrHGdo+Plj26UwH1nvGlFARPU+d5A75BgZj+nGBMSnzvvxJ95MTlY9Nmk200
         gg68cKKkLBxdNLu9iuCIm63B5NdWYVyRRnKiOB4nC384Pq3SnNXE2pEdTk/CKMIb+7
         1+/P7cjuttfiqgRk2F0cXhYwX6Zz3F72VuhPnMvXBWTzuEGC5IWoVCmUlhw0uV/AW5
         7GvDY1VexZ7o5pZ19J0m65UcYjC6oTRH+YT5A4YKzpow0GDJeRvsAthjYM+lipUwtq
         RDYQuzwe8h/3g==
Message-ID: <e18333d0-e69b-4ab9-68ca-31b69ef043f5@collabora.com>
Date:   Mon, 4 Jul 2022 10:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/3] clk: mediatek: mt8183: Simplify with
 mtk_clk_simple_*()
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220701145133.1152387-1-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220701145133.1152387-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/07/22 16:51, Chen-Yu Tsai ha scritto:
> As part of clk driver support for MT8192, a pair of "simple"
> probe/remove functions was introduced that provided boilerplate
> driver functions for clk drivers that fit a simple model: they only
> needed to register clock gates. Using them reduces the redundant
> boilerplate code needed for each driver. Instead, only a data structure
> pointing to the clock gate array and the number of clocks is needed.
> 
> This series converts all the MT8183 clock drivers that only contain
> clock gates over to these wrapper functions. For instances where the
> clk driver not only registers clock gates, the extra action is properly
> sequenced with the wrapper functions instead of outright replacing
> the probe functions. The converted drivers also get removal support.
> This also reduces the overall size by nearly 600 bytes.
> 
> Patch 1 converts the MT8183 clk drivers that only do clock gate
> registration.
> 
> Patch 2 converts the audio clk driver, which also populates sub-devices.
> 
> Patch 3 converts the mfgcfg (GPU wrapper) clk driver, which also needs
> to enable runtime PM, as it is tied to a power domain.
> 
> Please have a look, and merge if possible.

Hello Chen-Yu,
great cleanup there!

...I *particularly like* the mfgcfg commit :-) :-)

For the entire series:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

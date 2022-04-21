Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA1A509DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388429AbiDUKgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiDUKgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:36:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FE32982B;
        Thu, 21 Apr 2022 03:33:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C15801F4555C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650537238;
        bh=q3xCURJeXpVp7nXTJCMDC/WN0t4IsJySZXDpsN3C7X0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JYHXY+4kyEuJoN0AMOX+NtpU5S6jCDuV+XPuSgm27PF8iK8xudxwnOX7HEwfFy57c
         OMwZdgAup7zDOlpPequQYghojYp+y0oG2/2KhPTBsWho+ZvCXt6vjwRwTDR4a8OQQT
         ek9eV2tuehJONEA2uqcZ1yVSRa1wERiqTwRzfscdg118C7AdEZ8Rn0b625UIEpzqHD
         mXSIE3BTVPIA2tWEWcaYvhN547qRKZAFrQmXdyyz+QUbx1hE8VbHvHCOzzlS1FKKuF
         RX9D9JmXSAJMl7zykR7U+pKPTuWzUk256nQ/HZckGxx01hTamu+UrHy7k0Y7wDbq3x
         Po4CS2CqJlAog==
Message-ID: <068165d5-6c25-2a65-0191-957b6b1d0680@collabora.com>
Date:   Thu, 21 Apr 2022 12:33:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 7/7] arm64: dts: mediatek: mt6359: add node for PMIC keys
 support
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220415153629.1817202-1-fparent@baylibre.com>
 <20220415153629.1817202-8-fparent@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220415153629.1817202-8-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/04/22 17:36, Fabien Parent ha scritto:
> Add node for the MT6359 PMIC keyboard in mt6359.dtsi.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Hello Fabien,
I agree that all MT6359 PMICs do support pmic-keys, but not all devices using
this PMIC have physical keys connected to that.

Besides, even if all of them did, it wouldn't be guaranteed that key-0 would be
always KEY_POWER, as much as it wouldn't be guaranteed that key-1 would be always
KEY_HOME.

In my opinion, it *is* correct to add mediatek,mt6359-keys to the PMIC dtsi, but
you should do that without declaring any key, hence it's enough to do:

		mt6359_keys: mtk-pmic-keys {
			compatible = "mediatek,mt6359-keys";
		};

... then, any machine that *actually does* have these keys connected and manageable
in Linux should declare its own keys in its own dts/dtsi.

Of course, this means that you'll have to remove your input.h inclusion as well.

Regards,
Angelo


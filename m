Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380695761EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbiGOMjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbiGOMi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:38:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518494BD26;
        Fri, 15 Jul 2022 05:38:57 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 798836601A63;
        Fri, 15 Jul 2022 13:38:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657888736;
        bh=4odVySl8pWewK1o1UhRQgFiK9HBU3pt7kkRhWhez+u4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GgYqG+SEp90ovJMobU7UHDcMz/224ePRnuaROw6cYe0RF4RO2WU4duXWCpsK2A9YT
         W71ir2V11ZSRsQAtbgzEfaYlufSOTODqf+fgaMboWPecGBPP+AhvRv2czjOUptz2tN
         B2urPDynmhRgZqVBZi6QMcrfEALT1Cb91OO+uGXMnnXeAIr6ZFFvuKGXNNaEgktS6o
         bFGXggJiEX0e0zjeo6a/5xEaCXOpv2rAHb1muKHJLkFX/pVbwRmbFw2wdrOZ3HJ3Bc
         nQfLwjC3JbL/JjnmpwibGmwnizFwe8TtjNE0aK+ZZKluHsjiQStlZavr5zYazH6Ul4
         9Cg5NQehNAVBA==
Message-ID: <c28c6f73-56ce-8f59-a3a7-1c2bd018826e@collabora.com>
Date:   Fri, 15 Jul 2022 14:38:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 08/13] usb: typec: tcpci_mt6370: Add MediaTek MT6370
 tcpci driver
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
References: <20220715112607.591-1-peterwu.pub@gmail.com>
 <20220715112607.591-9-peterwu.pub@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220715112607.591-9-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/07/22 13:26, ChiaEn Wu ha scritto:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> The MT6370 is a highly-integrated smart power management IC, which
> includes a single cell Li-Ion/Li-Polymer switching battery charger,
> a USB Type-C & Power Delivery (PD) controller, dual Flash LED current
> sources, a RGB LED driver, a backlight WLED driver, a display bias
> driver and a general LDO for portable devices.
> 
> This commit add support for the Type-C & Power Delivery controller in
> MediaTek MT6370 IC.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


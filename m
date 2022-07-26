Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AD7580F45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbiGZIkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbiGZIj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:39:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6E42FFDD;
        Tue, 26 Jul 2022 01:39:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6CD1B6601B15;
        Tue, 26 Jul 2022 09:39:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658824794;
        bh=o8COaf1WnhJ6CshvmVXvwffuBdxhwn1zG6mdYwCYbMM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KfouyMIC5PPMPw26mf23O0tIb+iVGaFLkR/kg5SB28fo7Osxl7Accy9z/wZHXYQnk
         L24vXFgaA/XYKaa3IsxSYyKsnKEgyYL9jTnRyVpsEmVVwA5oULUZF3k2f+dsxmVoow
         HBzyIv3HeNEtJUR8UjGTME0UWjueCXvKQ8oroEOvbbfZ0PyoX5gm3+Z5dXo/W6lJKE
         jc5QZ5DOiYEpHd8GC9S77tdmqazQZNWTe4B/UmSfHmwBW7UsgodnHlgD7jQaNzvIT+
         jQK3EFXz8bj+zPlxYitKVRByCuewBJMP3J8YKoERVUMevT9FBVBhTxotsCXUxbmJ7C
         K8812Sfxz5JEg==
Message-ID: <14ddcdb5-cbfc-1215-ffdd-85df8d9d6acb@collabora.com>
Date:   Tue, 26 Jul 2022 10:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v14 1/3] dt-bindings: mmc: mtk-sd: extend interrupts and
 pinctrls properties
Content-Language: en-US
To:     Axe Yang <axe.yang@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rob Herring <robh@kernel.org>
References: <20220726062842.18846-1-axe.yang@mediatek.com>
 <20220726062842.18846-2-axe.yang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220726062842.18846-2-axe.yang@mediatek.com>
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

Il 26/07/22 08:28, Axe Yang ha scritto:
> Extend interrupts and pinctrls for SDIO wakeup interrupt feature.
> This feature allow SDIO devices alarm asynchronous interrupt to host
> even when host stop providing clock to SDIO card. An extra wakeup
> interrupt and pinctrl states for SDIO DAT1 pin state switching are
> required in this scenario.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

P.S.: R-b tags go after S-o-b tags!

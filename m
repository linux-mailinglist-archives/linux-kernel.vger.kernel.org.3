Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4E75511F9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbiFTH6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbiFTH6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:58:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C8725D8;
        Mon, 20 Jun 2022 00:58:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF5CB660166E;
        Mon, 20 Jun 2022 08:58:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655711884;
        bh=B+xTwEj2LWopnY2Mek8C1LH6BBhcx/zrcxMtLnoeiVA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Bx3CK9FAayRadGaBkxRj+jDh8Ivqjyz8uLq8JVnqfkvTTAcl7dsjQlbZ3H6jE5FoC
         vqcJ7Rgji2FSDrJFY+TW96nMRslPkAGFK0FkBemRiCkNwa2XEz4iSqGW+GmxYKaAaL
         oU6vnJi9MfLd4v1+cdzHl4XP14h5yhVrctSjyd+eRKIzJ08+38kW7WAhTrzzwdlQIj
         KRxr0LSjZv4u6Y+qAo36FuMDq1XHtz2hdy+cYVS2U1aOLxxbIJYcbxst/+CMmikcrj
         nLxkkoZPPPAI8JRcs+O52gs2Nork5+RJqR9rKhhq3G7vj9IhLi8+5BMI9XHjyYBVr4
         mpHugrqh4gHHQ==
Message-ID: <8956bb3e-60d7-a882-3672-f2a2f0bf858d@collabora.com>
Date:   Mon, 20 Jun 2022 09:58:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] media: mediatek: vcodec: Drop
 platform_get_resource(IORESOURCE_IRQ)
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220617203906.2422868-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220617203906.2422868-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/06/22 22:39, Nícolas F. R. A. Prado ha scritto:
> Commit a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource
> from DT core") removed support for calling platform_get_resource(...,
> IORESOURCE_IRQ, ...) on DT-based drivers, but the probe() function of
> mtk-vcodec's encoder was still making use of it. This caused the encoder
> driver to fail probe.
> 
> Since the platform_get_resource() call was only being used to check for
> the presence of the interrupt (its returned resource wasn't even used)
> and platform_get_irq() was already being used to get the IRQ, simply
> drop the use of platform_get_resource(IORESOURCE_IRQ) and handle the
> failure of platform_get_irq(), to get the driver probing again.
> 
> Fixes: a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource from DT core")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> Tested on mt8192-asurada-spherion.

Yep, that's totally necessary... Except the Fixes tag should be wrong here,
as you're not fixing that commit, but the mtk-vcodec driver in relation to
what's happening due to said commit.

I get that you're trying to tell everyone "this is an urgent fix", though,
and I agree that this *has to* get in v5.19 to avoid breaking this driver.

Finally, for the code:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...but I think that you have to send a v2 that drops that Fixes tag.

Cheers,
Angelo

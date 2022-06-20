Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC83551FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242924AbiFTPJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241187AbiFTPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:09:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36EA13EAC;
        Mon, 20 Jun 2022 07:53:00 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4726F66016AC;
        Mon, 20 Jun 2022 15:52:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655736779;
        bh=xp4iD9VvxWQO3iGiqNjrIMxyQ6VBElMaMUahY/LVwS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNPFGstPolfiS0TNNLwD/ZuqLGWms3hLfb0mCuHXIBvhlPkfrbiHDXTKwQBkzrQo2
         GnYcz5WCgY3LpG4tM1pnJ80w207ca795BCIQWOFF8KndwzN6Kd9UhZ5inCJlvlsqpX
         D/w4hzylaPUB/JC+HZxJ51rima4VzY6PdhPgWJ9gmzKV+KpZ5tVJriJQQGW5pS5rPT
         VLpt/6/BPRVw+Tlc74Fr9krCwGkk+WP0i2vsrACx9Kroamo82JveYuWTsAlcFPQO9O
         yCDXTFeHuZEXH4CwbUlL2qDYsnorpIdaDe0CqiseTi5iG944mKGUHReQ3R7YUXc0eA
         JW5IM7pU3haBg==
Date:   Mon, 20 Jun 2022 10:52:54 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] media: mediatek: vcodec: Drop
 platform_get_resource(IORESOURCE_IRQ)
Message-ID: <20220620145254.p52iqrfloteof7py@notapiano>
References: <20220617203906.2422868-1-nfraprado@collabora.com>
 <8956bb3e-60d7-a882-3672-f2a2f0bf858d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8956bb3e-60d7-a882-3672-f2a2f0bf858d@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 09:58:01AM +0200, AngeloGioacchino Del Regno wrote:
> Il 17/06/22 22:39, Nícolas F. R. A. Prado ha scritto:
> > Commit a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource
> > from DT core") removed support for calling platform_get_resource(...,
> > IORESOURCE_IRQ, ...) on DT-based drivers, but the probe() function of
> > mtk-vcodec's encoder was still making use of it. This caused the encoder
> > driver to fail probe.
> > 
> > Since the platform_get_resource() call was only being used to check for
> > the presence of the interrupt (its returned resource wasn't even used)
> > and platform_get_irq() was already being used to get the IRQ, simply
> > drop the use of platform_get_resource(IORESOURCE_IRQ) and handle the
> > failure of platform_get_irq(), to get the driver probing again.
> > 
> > Fixes: a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource from DT core")
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > ---
> > Tested on mt8192-asurada-spherion.
> 
> Yep, that's totally necessary... Except the Fixes tag should be wrong here,
> as you're not fixing that commit, but the mtk-vcodec driver in relation to
> what's happening due to said commit.
> 
> I get that you're trying to tell everyone "this is an urgent fix", though,
> and I agree that this *has to* get in v5.19 to avoid breaking this driver.

The commit I'm pointing to in the Fixes tag [1] says "Now that all the DT
drivers have switched to platform_get_irq() we can now safely drop the static
setup of IRQ resource from DT core code.", and while there were patches by the
author [2] to do the required changes on some drivers beforehand, some were
missed, including the mtk-vcodec-enc driver which I fix here. I see at least one
other driver that was missed [3], and it also used the same Fixes tag.

I know that my change isn't meant to be part of the commit in the Fixes, but I
still think it makes the most sense to keep this tag, since its meaning is that
that commit broke the support for this driver and this commit fixes it. Wherever
that commit is applied, this one should too to make sure the mtk-vcodec driver
keeps working.

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[2] https://lore.kernel.org/all/20211220011524.17206-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
[3] https://lore.kernel.org/all/20220609161457.69614-1-jean-philippe@linaro.org/

> 
> Finally, for the code:
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ...but I think that you have to send a v2 that drops that Fixes tag.
> 
> Cheers,
> Angelo

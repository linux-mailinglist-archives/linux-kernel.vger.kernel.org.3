Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F9F4F8A22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiDGWLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 18:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiDGWKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 18:10:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D25829AE03;
        Thu,  7 Apr 2022 15:03:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 965F41F41F77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649369018;
        bh=7REwnRCWL+X+/erOVACD0vx8O/QM9s4GDT9qZ654vt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fvM/2hwlOx04mVlDKKzyF4XI6AmYyyNtmpW5+LxeIgJOFPind/vscDXxG1ZUJcckX
         yhppYDiGwrNHaK2i+k+q1+Y7mUOBHPi7+tabnHQtgo3eaaWr2zGISidJfpleXo3XK8
         EUPUvNFoyelpDOLXbHz0nJfjw3we9J3Nx5WAmA5590UEOAHozbz34rWcKtof5A3Vi5
         BjNU1oTfFgv0lHK4CNQq16YAnOmmoTEsZqK/B79nWawlc1V5QR/7OxFkoZ/NlFYoWE
         Bn1R2mZ7u9w4aMGepLglH0twlvSnhdL6+uQKkmFhhYv1jP7BKcV/gt7WJUuCdpprvc
         wE60jue281WFQ==
Date:   Thu, 7 Apr 2022 18:03:33 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, tzungbi@google.com,
        angelogioacchino.delregno@collabora.com, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [v9 4/4] ASoC: mediatek: mt8192: support rt1015p_rt5682s
Message-ID: <20220407220333.v4enuv3mqzyrawkb@notapiano>
References: <20220406100514.11269-1-jiaxin.yu@mediatek.com>
 <20220406100514.11269-5-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406100514.11269-5-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxin,

On Wed, Apr 06, 2022 at 06:05:14PM +0800, Jiaxin Yu wrote:
> To support machine that only choose one of the rt5682s and rt5682 as
> headset codec, adds new compatible string "mt8192_mt6359_rt1015p_rt5682s".
> Meanwhile, using macros to simplifies card name and compatible name.

That first sentence is particularly confusing to me. Suggestion for the commit
message:

Add support for using the rt5682s codec together with rt1015p on mt8192-mt6359
machines. All configurations are shared with the rt5682 codec variant, so simply
select the SND_SOC_RT5682S config to ensure the codec is present and set the
correct card name. The codec will be linked to by pointing to it in the
headset-codec property in the devicetree.

While at it, also create macros for the names of the different codec variants
supported by this driver, as well as rename occurrences of rt1015p_rt5682 to
rt1015p_rt5682x, since they are shared between rt5682 and rt5682s.

> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

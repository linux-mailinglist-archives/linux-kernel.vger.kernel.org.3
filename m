Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6366530F70
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiEWMcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbiEWMcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E80B869;
        Mon, 23 May 2022 05:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BD6161303;
        Mon, 23 May 2022 12:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CD5C385A9;
        Mon, 23 May 2022 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653309128;
        bh=kFxFcM5U7DCGygs0xc9/IorhdzyDD33c1AOEJSIDPxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dwi1CRSYrd3+5S93sveEHTjANFjxe/hxsE95ccumwnmZ250ozaMe52yPEOcxQfhtE
         MuMxPEoXIIB+bdV7aaQHLUAqURCaA83aIXoqMdgKckhNa4tPgEH2iTkTMR5VxHBpHa
         CtYiqhUsVS6+gLOpCmHDw0iICCWMO4d+MLH2DuuU=
Date:   Mon, 23 May 2022 14:32:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, jirislaby@kernel.org,
        matthias.bgg@gmail.com, zhiyong.tao@mediatek.com,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org
Subject: Re: [PATCH] Revert "serial: 8250_mtk: Make sure to select the right
 FEATURE_SEL"
Message-ID: <Yot+xTBus04O9TUu@kroah.com>
References: <20220510122620.150342-1-angelogioacchino.delregno@collabora.com>
 <YnpeYGbo7JJK0lDk@sirena.org.uk>
 <b13b019f-f766-60df-3764-d375f64ea7d3@collabora.com>
 <YnphFjs4E4EYafT4@sirena.org.uk>
 <63169e65-cbfa-d495-754f-023dc8befa42@collabora.com>
 <d91977d2-ebc6-de6e-5eeb-61c25ba0cc64@collabora.com>
 <Yot5uls/3vLzZu7I@kroah.com>
 <da1e4b31-de71-1fda-eff7-2e70fe1331ac@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1e4b31-de71-1fda-eff7-2e70fe1331ac@collabora.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 02:13:35PM +0200, AngeloGioacchino Del Regno wrote:
> Il 23/05/22 14:10, Greg KH ha scritto:
> > On Mon, May 23, 2022 at 12:17:06PM +0200, AngeloGioacchino Del Regno wrote:
> > > Il 10/05/22 17:29, AngeloGioacchino Del Regno ha scritto:
> > > > Il 10/05/22 14:56, Mark Brown ha scritto:
> > > > > On Tue, May 10, 2022 at 02:46:28PM +0200, AngeloGioacchino Del Regno wrote:
> > > > > 
> > > > > > Sorry for missing this tag, and also I'm sorry for the noise.
> > > > > 
> > > > > Hey, if nobody broke anything all this testing stuff wouldn't be worth
> > > > > it!
> > > > 
> > > > 
> > > > Haha! That's true :-)
> > > > 
> > > > Thank you!
> > > 
> > > 
> > > Hello Mark, Greg
> > > 
> > > I've just noticed that v5.18 was released, but without this revert.
> > 
> > What is "this revert"?
> > 
> 
> "this revert" == "this commit", reverting
> 
> 6f81fdded0d0 ("serial: 8250_mtk: Make sure to select the right FEATURE_SEL")
> 
> > > Can you schedule this for backport on v5.18?
> > 
> > I need more context here, sorry.
> > 
> 
> As stated in the commit description, some MediaTek SoCs are incompatible with
> this change, hence it's actually breaking late serial for some machines.

Did I already apply this change to my tree?  If so, once it hits Linus's
tree we can backport it to 5.18.1.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360FC4D8F45
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245457AbiCNWIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245569AbiCNWIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:08:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C226C3D1E5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:07:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AA4F6139D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8A0C340E9;
        Mon, 14 Mar 2022 22:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647295621;
        bh=ICh66fxhgwpO5RAgPSp5R1pdsftDqr3eOFQyVmWHtv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewtWIpqRSmFuZEjh0N2QSwALxm6+U0Dcpyd0/GCmrj8/e96YkBXvkAOpRN41qtXZe
         FrjPPTasHuiKnzXt9wSSF9xN73o4JmGeJIpNqdTdunttJkzEeJIZiPpizTYB1denO/
         ooXrac87wrTxrdPWCX+gjfsPwNjS9XgWBQ1nFuj36qj5WfqvxeKkl7yzktYBK0zKwi
         dcxGX+Injh2W+y1MZFN6xB/da0luNDV0h/EbFFtbNpZN17fgLAbAAmRKdN/2unKQnj
         brlzeMRn3T3LTAAMr0gVk8bbcW7AfmkRaj9kyDBDLdPZQSwy+7z7hOuFVRxdIoC0Vc
         GtBO/0AtMuQDQ==
Date:   Mon, 14 Mar 2022 15:06:54 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gmail.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Nugraha <richiisei@gmail.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, gwml@vger.gnuweeb.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: atmel: mchp-pdmc: Fix `-Wpointer-bool-conversion`
 warning
Message-ID: <Yi+8ft7yXrNN4+Yx@dev-arch.thelio-3990X>
References: <202203091430.MLY27Bif-lkp@intel.com>
 <20220309065849.96165-1-alviro.iskandar@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309065849.96165-1-alviro.iskandar@gnuweeb.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alviro,

On Wed, Mar 09, 2022 at 06:58:49AM +0000, Alviro Iskandar Setiawan wrote:
> In function mchp_pdmc_af_put(), Intel's kernel test robot reports the
> following warning:
> 
>   sound/soc/atmel/mchp-pdmc.c:186:34: warning: address of array \
>   'uvalue->value.integer.value' will always evaluate to 'true' \
>   [-Wpointer-bool-conversion]
> 
> This is because we are using `uvalue->value.integer.value` which its
> type is `long value[128];` for conditional expression and that array
> will always decay to a non-NULL pointer. Using a non-NULL pointer for
> conditional expression will always evaluate to true.
> 
> Fix this by changing it to `uvalue->value.integer.value[0]` as that's
> what the mchp_pdmc_af_get() function sets.
> 
> To: Mark Brown <broonie@kernel.org>
> Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Cc: Nugraha <richiisei@gmail.com>
> Cc: llvm@lists.linux.dev
> Cc: kbuild-all@lists.01.org
> Cc: gwml@vger.gnuweeb.org
> Cc: linux-kernel@vger.kernel.org

I would recommend removing these and just setting those values via git
send-email flags. In other words:

git send-email --to "..." --cc "..." --cc "..." <path to .patch>

and so on. It can cause a lot of spam if this patch is ever backported
or needed in other trees.

> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202203091430.MLY27Bif-lkp@intel.com
> Fixes: 50291652af5269813baa6024eb0e81b5f0bbb451 ("ASoC: atmel: mchp-pdmc: add PDMC driver")

This should be simplified to:

Fixes: 50291652af52 ("ASoC: atmel: mchp-pdmc: add PDMC driver")

I don't think the automated checkers will complain about that but the
short form is preferred.

> Signed-off-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>

Thanks a lot for the patch!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

I don't know if those nits are worth resending but I do not see this
applied to Mark's tree yet. It might have gotten lost because this was
sent as a reply to the build report, rather than its own thread, which
has caused issues for me in the past:

https://lore.kernel.org/r/20210903162639.GM4932@sirena.org.uk/

If there is no action on this patch in the next couple of days, please
consider resending with the above nits addressed with Codrin's tag and
my tag.

> ---
>  sound/soc/atmel/mchp-pdmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
> index c44636f6207d..7b87f75c284c 100644
> --- a/sound/soc/atmel/mchp-pdmc.c
> +++ b/sound/soc/atmel/mchp-pdmc.c
> @@ -183,7 +183,7 @@ static int mchp_pdmc_af_put(struct snd_kcontrol *kcontrol,
>  {
>  	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
>  	struct mchp_pdmc *dd = snd_soc_component_get_drvdata(component);
> -	bool af = uvalue->value.integer.value ? true : false;
> +	bool af = uvalue->value.integer.value[0] ? true : false;
>  
>  	if (dd->audio_filter_en == af)
>  		return 0;
> 
> base-commit: 50291652af5269813baa6024eb0e81b5f0bbb451
> -- 
> 2.27.0
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7BB57D5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiGUVWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiGUVWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:22:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F6D9284B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F6DACE25B3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 21:22:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD762C3411E;
        Thu, 21 Jul 2022 21:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658438552;
        bh=2csh2IPzZB9Q9+L8yOL8SYU7r0lrEKvI5elBmtDV4/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b6dgBxwPawsXvrs8FUNrO+XL/BjA70/JzCpatMpkSzj7k4H1NCNOiotZyhdFxGAVC
         PP0TouGwpOyksZ+JkyaViKZi3wwSpRxAUa4jll8RuuLciixdPnP+QJ8lxUivlSpKsB
         IZaLl9ccELLbadWEDYu2IUFTzanj8FANZM1pKkqE8MnVhWfswSrv0nZn71HKHlkutm
         rTvsprQlzBRrdkkI6jlkYjSpIZgIRtAsx7h78aYQqKCBAMIfBoZolXCk9gp8uaOVoL
         jXUd9dVTvLgfSfSAipukCS4ycfOPt6bw0Whg/TNDhpzYHimHr2ZCe/fZQOmVqeudAP
         26pIQWRO6TIwQ==
Date:   Thu, 21 Jul 2022 14:22:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Tom Rix <trix@redhat.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] soc: sof: fix clang -Wformat warnings
Message-ID: <YtnDltqEVeJQQkbW@dev-arch.thelio-3990X>
References: <20220721211218.4039288-1-justinstitt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721211218.4039288-1-justinstitt@google.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 02:12:18PM -0700, Justin Stitt wrote:
> When building with Clang we encounter these warnings:
> | sound/soc/sof/ipc3-topology.c:2343:4: error: format specifies type
> | 'unsigned char' but the argument has type 'int' [-Werror,-Wformat]
> |                  SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
> |                  ^~~~~~~~~~~~~~~^~~~~~~~~~~~~~~^~~~~~~~~~~~~
> 
> Use correct format specifier `%d` since args are of type int.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Indeed, decimal integer literals with no suffix are of type 'int' when
they can fit in an 'int'. In this case, there shouldn't be a bug since
the values of these macros can fit in an 'unsigned char' (so no
truncation) but it is still correct to use '%d' instead of '%hhu', which
matches the stance of commit cbacb5ab0aa0 ("docs: printk-formats: Stop
encouraging use of unnecessary %h[xudi] and %hh[xudi]").

This was introduced by commit 323aa1f093e6 ("ASoC: SOF: Add a new IPC op
for parsing topology manifest"), not sure it warrants a fixes tag for
the reason I outlined above, but it might be helpful for other
reviewers.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Reported by Nathan here:
> https://lore.kernel.org/all/YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X/
> 
>  sound/soc/sof/ipc3-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
> index b2cc046b9f60..65923e7a5976 100644
> --- a/sound/soc/sof/ipc3-topology.c
> +++ b/sound/soc/sof/ipc3-topology.c
> @@ -2338,7 +2338,7 @@ static int sof_ipc3_parse_manifest(struct snd_soc_component *scomp, int index,
>  	}
>  
>  	dev_info(scomp->dev,
> -		 "Topology: ABI %d:%d:%d Kernel ABI %hhu:%hhu:%hhu\n",
> +		 "Topology: ABI %d:%d:%d Kernel ABI %d:%d:%d\n",
>  		 man->priv.data[0], man->priv.data[1], man->priv.data[2],
>  		 SOF_ABI_MAJOR, SOF_ABI_MINOR, SOF_ABI_PATCH);
>  
> -- 
> 2.37.1.359.gd136c6c3e2-goog
> 

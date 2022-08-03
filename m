Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33235589372
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 22:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbiHCUr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 16:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiHCUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:47:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7556619298
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25FA5B8227E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 20:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6920C433D7;
        Wed,  3 Aug 2022 20:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659559669;
        bh=RlTuo1i+4pM+HN9bjpGtA2gdc9l9lCSXBNKfstXa1hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F9xW+EwZlQM6GsSRwgwAl3ZwmobV2Bpr/q4Xy1rnM3X4IHDq0DnRt6KS0zBldqArc
         Ji7olAuzo8Obj/C3B4XPVGU44Q4nxbKBDRDfKisDuPt1Tdviu4HgF7at4MmblLwWYl
         dHmNWyH2TMkaUflkwsHGz49seToq+J0k290UwpAnwZHRcAn3vtmT2dw93ywyw3kcWt
         NNGZfFA60pmdDyxrZ7We3AGEAURVak0dQOQC3bfKRzV6v38Wq7cD36i6gH51+GCaAz
         X0XjQ+ftN3/4jjUSYcwVu7YG0N5LJR/IxH02JfiD+iO+Qd20tYfjFUDooDJdEfgjA3
         mnoeof0xeM9RQ==
Date:   Wed, 3 Aug 2022 13:47:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH resend] ASoC: SOF: ipc3-topology: Fix clang -Wformat
 warning
Message-ID: <Yure82N7/4NLEMsW@dev-arch.thelio-3990X>
References: <20220803204442.2996580-1-justinstitt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803204442.2996580-1-justinstitt@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 01:44:42PM -0700, Justin Stitt wrote:
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

Thanks for resending!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Note: resending with the subject corrected, this patch fixes a build
> warning that will break the Clang build when CONFIG_WERROR=y.
> 
> Original patch: https://lore.kernel.org/all/20220721211218.4039288-1-justinstitt@google.com/
> Reported by Nathan here: https://lore.kernel.org/all/YtmrCJjQrSbv8Aj1@dev-arch.thelio-3990X/
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

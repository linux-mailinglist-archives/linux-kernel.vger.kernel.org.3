Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08A75403D9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345043AbiFGQgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiFGQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3DF34B88
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:36:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1904F61499
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 16:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5726AC385A5;
        Tue,  7 Jun 2022 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654619796;
        bh=8i5haULdeB2Ou8xLNgGyaqjpMUp/nNMdFFzefBtFQus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJOYP5lV5TwG9gnAjthINUaJCRhaAv5ayjybpS0BpNazzoGwVMj1SxQg/skv+eP2j
         efB3JHODISGBtLWUuzpgVu+c7ki/+9fNOmc/qm31lf8ENLQGu6USScXIR7Zd28pTdR
         I7xQe05KIYnjlzNRc9/HGJCmoftFlmEgqMYyxEpLsOT44uN6EThAx4V3w78k8oEVLl
         Mg/nn5b6OJwEzh6oB1f2a94OudqtGDnidgkmdmRttS3p3DWqamPeIm2veizy34Wt+b
         BYJXF201xvI3qlVaiD4trtkK1XnW2mq9C9RymqaGNWW8XM8nl6LEyESSq45YPdZeDL
         AsE7PUYfzdm3w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nycBz-0002GQ-7u; Tue, 07 Jun 2022 18:36:31 +0200
Date:   Tue, 7 Jun 2022 18:36:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jared Kangas <kangas.jd@gmail.com>
Cc:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: audio: fix loop cursor use after
 iteration
Message-ID: <Yp9+j7xrjDQWkem3@hovoldconsulting.com>
References: <20220605231806.720085-1-kangas.jd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605231806.720085-1-kangas.jd@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 05, 2022 at 04:18:06PM -0700, Jared Kangas wrote:
> gbaudio_dapm_free_controls() iterates over widgets using
> list_for_each_entry_safe(), which leaves the loop cursor pointing to a
> meaningless structure if it completes a traversal of the list. The
> cursor was set to NULL at the end of the loop body, but would be
> overwritten by the final loop cursor update.
> 
> Because of this behavior, the widget could be non-null after the loop
> even if the widget wasn't found, and the cleanup logic would treat the
> pointer as a valid widget to free.
> 
> To fix this, introduce a temporary variable to act as the loop cursor
> and copy it to a variable that can be accessed after the loop finishes.
> 
> This was detected with the help of Coccinelle.

Please add the missing Fixes tag and a CC stable tag here as Dan
mentioned.

> Signed-off-by: Jared Kangas <kangas.jd@gmail.com>
> ---
>  drivers/staging/greybus/audio_helper.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
> index 843760675876..07461a5d97c7 100644
> --- a/drivers/staging/greybus/audio_helper.c
> +++ b/drivers/staging/greybus/audio_helper.c
> @@ -115,7 +115,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
>  			       int num)
>  {
>  	int i;
> -	struct snd_soc_dapm_widget *w, *next_w;
> +	struct snd_soc_dapm_widget *w, *next_w, *tmp_w;
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *parent = dapm->debugfs_dapm;
>  	struct dentry *debugfs_w = NULL;
> @@ -124,13 +124,14 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
>  	mutex_lock(&dapm->card->dapm_mutex);
>  	for (i = 0; i < num; i++) {
>  		/* below logic can be optimized to identify widget pointer */
> -		list_for_each_entry_safe(w, next_w, &dapm->card->widgets,
> +		w = NULL;
> +		list_for_each_entry_safe(tmp_w, next_w, &dapm->card->widgets,

This should be list_for_each_entry() as w is not unlinked in this loop.

>  					 list) {
> -			if (w->dapm != dapm)
> -				continue;
> -			if (!strcmp(w->name, widget->name))
> +			if (tmp_w->dapm == dapm &&
> +			    !strcmp(tmp_w->name, widget->name)) {
> +				w = tmp_w;
>  				break;
> -			w = NULL;
> +			}
>  		}
>  		if (!w) {
>  			dev_err(dapm->dev, "%s: widget not found\n",

Looks good otherwise:

Reviewed-by: Johan Hovold <johan@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A4A56A074
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiGGKwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiGGKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:52:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742EA5721E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 251B6B8213D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 10:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2942EC3411E;
        Thu,  7 Jul 2022 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657191169;
        bh=cRZmEvhq3mkvO9CFf2gncqX2zdzXsEPflfQTcsk6ojM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=owrk7JzN0soODypmpkaL+lysRCGSQc06WnHyCmBP92nkBhUf9yLZo9mj+RQ+wEE7q
         /yY7+Zai3DNrujSqlPQVe8w3Qaq8mUoN+S+awMvU3PKZVqhuSD4hro6aDXvNBJ3rkO
         vpucQn2Hp8wsfumfI/OEQBDsmua0KW/yS+MUS9Yo=
Date:   Thu, 7 Jul 2022 12:52:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Karthik Alapati <mail@karthek.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: don't use index pointer after iter
Message-ID: <Ysa6/gEg1VV4mEq1@kroah.com>
References: <Ysa1oopf0ELw+OfB@karthik-strix-linux.karthek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysa1oopf0ELw+OfB@karthik-strix-linux.karthek.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 03:59:54PM +0530, Karthik Alapati wrote:
> There are some usages of index pointer of list(w) which may not point to
> the right entry when the required entry is not found and the list traversal
> completes with index pointer pointing to the last entry. So, use w_found
> flag to track the case where the entry is found.

That is already being done here with the use of the w variable.

Look at commit 80c968a04a38 ("staging: greybus: audio: fix loop cursor
use after iteration") and then d2b47721a100 ("staging: greybus: audio:
replace safe list iteration").

> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
> index 843760675876..7c04897a22a2 100644
> --- a/drivers/staging/greybus/audio_helper.c
> +++ b/drivers/staging/greybus/audio_helper.c
> @@ -116,6 +116,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
>  {
>  	int i;
>  	struct snd_soc_dapm_widget *w, *next_w;
> +	bool w_found = false;
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *parent = dapm->debugfs_dapm;
>  	struct dentry *debugfs_w = NULL;
> @@ -124,15 +125,18 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
>  	mutex_lock(&dapm->card->dapm_mutex);
>  	for (i = 0; i < num; i++) {
>  		/* below logic can be optimized to identify widget pointer */
> +		w_found = false
>  		list_for_each_entry_safe(w, next_w, &dapm->card->widgets,
>  					 list) {

You are working off of an old kernel version here, please see the above
commits which do not seem to be in your tree.  Always work on linux-next
for issues so that you do not duplicate work that others have completed.

thanks,

greg k-h

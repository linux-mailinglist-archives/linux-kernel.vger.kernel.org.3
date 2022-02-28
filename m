Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C9E4C6271
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 06:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiB1FVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 00:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiB1FVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 00:21:31 -0500
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A58939B83
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 21:20:54 -0800 (PST)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id F2F3FE15;
        Mon, 28 Feb 2022 05:20:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id BECCA60010;
        Mon, 28 Feb 2022 05:20:13 +0000 (UTC)
Message-ID: <e5c1ba2f7db29b78066d12dab812b7a1c0a37a81.camel@perches.com>
Subject: Re: [PATCH v4 2/2] ALSA: core: Remove redundant variable and return
 the last statement
From:   Joe Perches <joe@perches.com>
To:     Meng Tang <tangmeng@uniontech.com>, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Sun, 27 Feb 2022 21:20:45 -0800
In-Reply-To: <20220228050253.1649-2-tangmeng@uniontech.com>
References: <20220228050253.1649-1-tangmeng@uniontech.com>
         <20220228050253.1649-2-tangmeng@uniontech.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: BECCA60010
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: hruc7nct77mkwtg4ah8jw8qrpgawattj
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19B4PH4dJJF2uojux2T7euYun9bMLaYrIU=
X-HE-Tag: 1646025613-188090
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-28 at 13:02 +0800, Meng Tang wrote:
> Return the result from file->f_op->open() directly instead of
> taking this in another redundant variable. Make the typical
> return the last statement, return early and reduce the indentation
> too.
> 
> Signed-off-by: Meng Tang <tangmeng@uniontech.com>
> Signed-off-by: Joe Perches <joe@perches.com>

Hi Meng Tang.

For the next time: it's not necessary (or even good) to add a sign-off
for another person unless they specifically authorize one.

You wrote and are submitting these changes, I merely gave you simple
suggestions as to how you could improve them.

cheers, Joe

> ---
>  sound/sound_core.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/sound_core.c b/sound/sound_core.c
> index aa4a57e488e5..3332fe321737 100644
> --- a/sound/sound_core.c
> +++ b/sound/sound_core.c
> @@ -577,20 +577,20 @@ static int soundcore_open(struct inode *inode, struct file *file)
>  			new_fops = fops_get(s->unit_fops);
>  	}
>  	spin_unlock(&sound_loader_lock);
> -	if (new_fops) {
> -		/*
> -		 * We rely upon the fact that we can't be unloaded while the
> -		 * subdriver is there.
> -		 */
> -		int err = 0;
> -		replace_fops(file, new_fops);
>  
> -		if (file->f_op->open)
> -			err = file->f_op->open(inode,file);
> +	if (!new_fops)
> +		return -ENODEV;
>  
> -		return err;
> -	}
> -	return -ENODEV;
> +	/*
> +	 * We rely upon the fact that we can't be unloaded while the
> +	 * subdriver is there.
> +	 */
> +	replace_fops(file, new_fops);
> +
> +	if (!file->f_op->open)
> +		return -ENODEV;
> +
> +	return file->f_op->open(inode, file);
>  }
>  
>  MODULE_ALIAS_CHARDEV_MAJOR(SOUND_MAJOR);



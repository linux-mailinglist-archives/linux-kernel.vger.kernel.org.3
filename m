Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E924C6221
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 05:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiB1EVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 23:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbiB1EVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 23:21:54 -0500
Received: from relay.hostedemail.com (relay.a.hostedemail.com [64.99.140.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9945A3EA8B
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 20:21:16 -0800 (PST)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay13.hostedemail.com (Postfix) with ESMTP id 5CDB060D10;
        Mon, 28 Feb 2022 04:21:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id CF7892000E;
        Mon, 28 Feb 2022 04:20:35 +0000 (UTC)
Message-ID: <486925d77d6c9f06b7b89e2c575a004bbda5bc3c.camel@perches.com>
Subject: Re: [PATCH v2 2/2] ALSA: core: Remove redundant 'err' variable
From:   Joe Perches <joe@perches.com>
To:     Meng Tang <tangmeng@uniontech.com>, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Date:   Sun, 27 Feb 2022 20:21:07 -0800
In-Reply-To: <20220228030614.10606-2-tangmeng@uniontech.com>
References: <20220228030614.10606-1-tangmeng@uniontech.com>
         <20220228030614.10606-2-tangmeng@uniontech.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: CF7892000E
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: 1n9phyytqiwzrkhid4ude7o4uu41zksi
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+4XlN2/MthucwEh1rUlHXAInh5Juwx+Pc=
X-HE-Tag: 1646022035-405178
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-28 at 11:06 +0800, Meng Tang wrote:
> Return the result from file->f_op->open() directly instead of
> taking this in another redundant variable.
[]
> diff --git a/sound/sound_core.c b/sound/sound_core.c
[]
> @@ -582,13 +582,12 @@ static int soundcore_open(struct inode *inode, struct file *file)
>  		 * We rely upon the fact that we can't be unloaded while the
>  		 * subdriver is there.
>  		 */
> -		int err = 0;
>  		replace_fops(file, new_fops);
>  
>  		if (file->f_op->open)
> -			err = file->f_op->open(inode,file);
> +			return file->f_op->open(inode, file);
>  
> -		return err;
> +		return 0;
>  	}
>  	return -ENODEV;
>  }

Perhaps clearer would be to make the typical return the last statement,
return early and reduce the indentation too.

i.e.:

---
 sound/sound_core.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 90d118cd91641..9f2cd6d91a034 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -581,22 +581,20 @@ static int soundcore_open(struct inode *inode, struct file *file)
 			new_fops = fops_get(s->unit_fops);
 	}
 	spin_unlock(&sound_loader_lock);
-	if (new_fops) {
-		/*
-		 * We rely upon the fact that we can't be unloaded while the
-		 * subdriver is there.
-		 */
-		int err = 0;
-		replace_fops(file, new_fops);
+	if (!new_fops)
+		return -ENODEV;
 
-		if (file->f_op->open)
-			err = file->f_op->open(inode,file);
+	/*
+	 * We rely upon the fact that we can't be unloaded while the
+	 * subdriver is there.
+	 */
+	replace_fops(file, new_fops);
 
-		return err;
-	}
-	return -ENODEV;
-}
+	if (!file->f_op->open)
+		return -ENODEV;
 
+	return file->f_op->open(inode,file);
+}
 MODULE_ALIAS_CHARDEV_MAJOR(SOUND_MAJOR);
 
 static void cleanup_oss_soundcore(void)



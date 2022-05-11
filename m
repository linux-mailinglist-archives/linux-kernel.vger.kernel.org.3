Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059AF523F20
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347930AbiEKUzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347923AbiEKUzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:55:02 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8521C767A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:55:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w17-20020a17090a529100b001db302efed6so3101932pjh.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E+tE8jOYitJVRGmHjUOL7gxMXV553nM3OymWffscmCw=;
        b=aN8AkgO9m6hcPEoWi9FOK2fGUgAY/HoAtbsgtE4qq3+Hs77mXBeykomQWpqIOxlwXl
         mTraVuQaQgsi1PCB7J996/kIpyFKD1UkZKa6s//+lmsQvMMsA0Is9MdECkIR9kYiDf0u
         HFDyvuJc0PIpMNS3Tn8GXBhbZBVno9cEY/XqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E+tE8jOYitJVRGmHjUOL7gxMXV553nM3OymWffscmCw=;
        b=T4AAicbL2EK5UjTWCRjtRgS8UoqOLrlAzCXBnLGCA1HdASdYy3+x0rrq0DJ+XdrXxJ
         ETnkKts51EPC6ja1cVNTwo+jK5SGpyoBRszxBh2NayStLzql9ntLBbhhS39lFWM8tdBS
         W7m4zFVLJMHEeY0LrPb1P6ulZMk26wdGOwtw0LlAd15Z7NEngdwUu5Hyppd6R3YVkcZM
         3wj4tFzmQYjorxse1s7R7X/eijgXg0+paQ+euCz19beUO9HijXYRZu0fKszg3u+csURF
         +gniSVCAVE9YlZqrHdVrh9E7Ic06OH41RhfdieW6xLSqZRf1IbqtUPvyWwR/T+QO2/LE
         YtWg==
X-Gm-Message-State: AOAM530n+5L6MxL4z/HgMshR17ufqRzWZggwp/y6xWAsoNwjRw1lLF9K
        2UYauuKVokJxSmUUDisRlwwuSg==
X-Google-Smtp-Source: ABdhPJz1UXitekjbAHFYJrRunpwcE5/JCPpxSDxXqhs9z0YoBcIwPzSqhAxn+C5vDu35395T7aExgQ==
X-Received: by 2002:a17:90b:610:b0:1d9:4008:cfee with SMTP id gb16-20020a17090b061000b001d94008cfeemr7313092pjb.71.1652302499794;
        Wed, 11 May 2022 13:54:59 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:c586:bf93:e960:73b4])
        by smtp.gmail.com with UTF8SMTPSA id y24-20020a63de58000000b003c14af50643sm277201pgi.91.2022.05.11.13.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 13:54:59 -0700 (PDT)
Date:   Wed, 11 May 2022 13:54:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dm: Add verity helpers for LoadPin
Message-ID: <YnwioaRiVmYevo8i@google.com>
References: <20220504195419.1143099-1-mka@chromium.org>
 <20220504125404.v3.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220504125404.v3.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdar/Mike, I'd be interested in your take on adding these functions
to verity/DM, to get an idea whether this series has a path forward to
landing upstream.

Thanks

Matthias

On Wed, May 04, 2022 at 12:54:17PM -0700, Matthias Kaehlcke wrote:
> LoadPin limits loading of kernel modules, firmware and certain
> other files to a 'pinned' file system (typically a read-only
> rootfs). To provide more flexibility LoadPin is being extended
> to also allow loading these files from trusted dm-verity
> devices. For that purpose LoadPin can be provided with a list
> of verity root digests that it should consider as trusted.
> 
> Add a bunch of helpers to allow LoadPin to check whether a DM
> device is a trusted verity device. The new functions broadly
> fall in two categories: those that need access to verity
> internals (like the root digest), and the 'glue' between
> LoadPin and verity. The new file dm-verity-loadpin.c contains
> the glue functions.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - none
> 
>  drivers/md/Makefile               |  6 +++
>  drivers/md/dm-verity-loadpin.c    | 80 +++++++++++++++++++++++++++++++
>  drivers/md/dm-verity-target.c     | 33 +++++++++++++
>  drivers/md/dm-verity.h            |  4 ++
>  include/linux/dm-verity-loadpin.h | 27 +++++++++++
>  5 files changed, 150 insertions(+)
>  create mode 100644 drivers/md/dm-verity-loadpin.c
>  create mode 100644 include/linux/dm-verity-loadpin.h
> 
> diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> index 0454b0885b01..e12cd004d375 100644
> --- a/drivers/md/Makefile
> +++ b/drivers/md/Makefile
> @@ -100,6 +100,12 @@ ifeq ($(CONFIG_IMA),y)
>  dm-mod-objs			+= dm-ima.o
>  endif
>  
> +ifeq ($(CONFIG_DM_VERITY),y)
> +ifeq ($(CONFIG_SECURITY_LOADPIN),y)
> +dm-mod-objs			+= dm-verity-loadpin.o
> +endif
> +endif
> +
>  ifeq ($(CONFIG_DM_VERITY_FEC),y)
>  dm-verity-objs			+= dm-verity-fec.o
>  endif
> diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
> new file mode 100644
> index 000000000000..972ca93a2231
> --- /dev/null
> +++ b/drivers/md/dm-verity-loadpin.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/list.h>
> +#include <linux/kernel.h>
> +#include <linux/dm-verity-loadpin.h>
> +
> +#include "dm.h"
> +#include "dm-verity.h"
> +
> +static struct list_head *trusted_root_digests;
> +
> +/*
> + * Sets the root digests of verity devices which LoadPin considers as trusted.
> + *
> + * This function must only be called once.
> + */
> +void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests)
> +{
> +	if (!trusted_root_digests)
> +		trusted_root_digests = digests;
> +	else
> +		pr_warn("verity root digests trusted by LoadPin are already set!!!\n");
> +}
> +
> +static bool is_trusted_verity_target(struct dm_target *ti)
> +{
> +	u8 *root_digest;
> +	unsigned int digest_size;
> +	struct trusted_root_digest *trd;
> +	bool trusted = false;
> +
> +	if (!dm_is_verity_target(ti))
> +		return false;
> +
> +	if (dm_verity_get_root_digest(ti, &root_digest, &digest_size))
> +		return false;
> +
> +	list_for_each_entry(trd, trusted_root_digests, node) {
> +		if ((trd->len == digest_size) &&
> +		    !memcmp(trd->data, root_digest, digest_size)) {
> +			trusted = true;
> +			break;
> +		}
> +	}
> +
> +	kfree(root_digest);
> +
> +	return trusted;
> +}
> +
> +/*
> + * Determines whether a mapped device is a verity device that is trusted
> + * by LoadPin.
> + */
> +bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md)
> +{
> +	int srcu_idx;
> +	struct dm_table *table;
> +	unsigned int num_targets;
> +	bool trusted = false;
> +	int i;
> +
> +	if (!trusted_root_digests || list_empty(trusted_root_digests))
> +		return false;
> +
> +	table = dm_get_live_table(md, &srcu_idx);
> +	num_targets = dm_table_get_num_targets(table);
> +	for (i = 0; i < num_targets; i++) {
> +		struct dm_target *ti = dm_table_get_target(table, i);
> +
> +		if (is_trusted_verity_target(ti)) {
> +			trusted = true;
> +			break;
> +		}
> +	}
> +
> +	dm_put_live_table(md, srcu_idx);
> +
> +	return trusted;
> +}
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 80133aae0db3..6f07b849fcb2 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -19,6 +19,7 @@
>  #include <linux/module.h>
>  #include <linux/reboot.h>
>  #include <linux/scatterlist.h>
> +#include <linux/string.h>
>  
>  #define DM_MSG_PREFIX			"verity"
>  
> @@ -1310,6 +1311,38 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
>  	return r;
>  }
>  
> +/*
> + * Check whether a DM target is a verity target.
> + */
> +bool dm_is_verity_target(struct dm_target *ti)
> +{
> +	return ti->type->module == THIS_MODULE;
> +}
> +EXPORT_SYMBOL_GPL(dm_is_verity_target);
> +
> +/*
> + * Get the root digest of a verity target.
> + *
> + * Returns a copy of the root digest, the caller is responsible for
> + * freeing the memory of the digest.
> + */
> +int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned int *digest_size)
> +{
> +	struct dm_verity *v = ti->private;
> +
> +	if (!dm_is_verity_target(ti))
> +		return -EINVAL;
> +
> +	*root_digest = kmemdup(v->root_digest, v->digest_size, GFP_KERNEL);
> +	if (*root_digest == NULL)
> +		return -ENOMEM;
> +
> +	*digest_size = v->digest_size;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dm_verity_get_root_digest);
> +
>  static struct target_type verity_target = {
>  	.name		= "verity",
>  	.version	= {1, 8, 0},
> diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
> index 4e769d13473a..c832cc3e3d24 100644
> --- a/drivers/md/dm-verity.h
> +++ b/drivers/md/dm-verity.h
> @@ -129,4 +129,8 @@ extern int verity_hash(struct dm_verity *v, struct ahash_request *req,
>  extern int verity_hash_for_block(struct dm_verity *v, struct dm_verity_io *io,
>  				 sector_t block, u8 *digest, bool *is_zero);
>  
> +extern bool dm_is_verity_target(struct dm_target *ti);
> +extern int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest,
> +				     unsigned int *digest_size);
> +
>  #endif /* DM_VERITY_H */
> diff --git a/include/linux/dm-verity-loadpin.h b/include/linux/dm-verity-loadpin.h
> new file mode 100644
> index 000000000000..12a86911d05a
> --- /dev/null
> +++ b/include/linux/dm-verity-loadpin.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __LINUX_DM_VERITY_LOADPIN_H
> +#define __LINUX_DM_VERITY_LOADPIN_H
> +
> +#include <linux/list.h>
> +
> +struct mapped_device;
> +
> +struct trusted_root_digest {
> +	u8 *data;
> +	unsigned int len;
> +	struct list_head node;
> +};
> +
> +#if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
> +void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests);
> +bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md);
> +#else
> +static inline void dm_verity_loadpin_set_trusted_root_digests(struct list_head *digests) {}
> +static inline bool dm_verity_loadpin_is_md_trusted(struct mapped_device *md)
> +{
> +	return false;
> +}
> +#endif
> +
> +#endif /* __LINUX_DM_LOADPIN_H */
> -- 
> 2.36.0.464.gb9c8b46e94-goog
> 

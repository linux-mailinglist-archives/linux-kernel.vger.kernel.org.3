Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9D452DA6E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbiESQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242079AbiESQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 196D2DE310
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652978359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I53QjqK9knPSZgQrLxB+sWMD/vHWzk2y+pP08p6DGX8=;
        b=YmZCY74lxAKPkmm//l5qOhLBOXchBtz/UWRqIRaEOSXEvk1/V6vXxePqwFE9XGKBsmS43L
        m5xZm43ni1kSMokjgwpcMdbfe9BinMeteFx6F3cTcnr+mgPWzPUJ4gWm2VoGc2FahBy5NC
        iLR6G/ltHooVnAuaCfXLAw3/kWzMbQo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-rkJOwHYUMgqXyQCAAtmF2A-1; Thu, 19 May 2022 12:39:18 -0400
X-MC-Unique: rkJOwHYUMgqXyQCAAtmF2A-1
Received: by mail-qk1-f198.google.com with SMTP id c84-20020a379a57000000b0069fcf83c373so4527049qke.20
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I53QjqK9knPSZgQrLxB+sWMD/vHWzk2y+pP08p6DGX8=;
        b=e2bnIjhhtlpH1CdOZMc5+mLUzkrjCdkexcOFm9yLqC/ssAOB0iDudSmDjkWgOgkJ22
         vGGxEam45NAr/c0gEqPDJw574dsXsGhKBe5037qNg87vrTFCwDQzC/obZCGUx6ndSAa9
         GToN6HFqf4dXJPbhV0yv/ES8IKTw3tOWgJPiRbgpuWcv4Bxm5Vs/GKdcToikAC3+zcDE
         EKjrG02fPaSw2D83ne/rLSd62IAm/QSTQNNlNNsDlS/A+8G45HOunjRzP4sdClACvvcl
         UVIxvdVrHwIkmYXKDhxiMU6DGG/vl2/EocfnhR28Qz44BENo/WY7pYCK2T5KQpqT7GtH
         +HAQ==
X-Gm-Message-State: AOAM532gi8F2aiYadO4ah1MNxaREqY5ZgauHmolpAXhrt/J24jo/Xb0W
        3Eb1hICaD4Kww6Kk7iicm2WSjzORXhB+h6c6dNdB/7B+b+9By44hOKyLU2fMHxKpEEPmZ31z1ed
        4Kd3UHX+YgDanFWp28QzUxp4=
X-Received: by 2002:a05:6214:23c8:b0:45f:b582:346e with SMTP id hr8-20020a05621423c800b0045fb582346emr4489059qvb.109.1652978356060;
        Thu, 19 May 2022 09:39:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyE4XvzRyyQ/iH98/VEW5SSAuQNUjP5i1KzJAXBbn/TV1kHaL1Umpu/2C6RLKySNENODzMMiQ==
X-Received: by 2002:a05:6214:23c8:b0:45f:b582:346e with SMTP id hr8-20020a05621423c800b0045fb582346emr4489026qvb.109.1652978355768;
        Thu, 19 May 2022 09:39:15 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u124-20020ae9d882000000b0069fc13ce226sm1492716qkf.87.2022.05.19.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 09:39:15 -0700 (PDT)
Date:   Thu, 19 May 2022 12:39:14 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, dm-devel@redhat.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH v5 1/3] dm: Add verity helpers for LoadPin
Message-ID: <YoZysmcnU6o2scFI@redhat.com>
References: <20220519004754.2174254-1-mka@chromium.org>
 <20220518174739.v5.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518174739.v5.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18 2022 at  8:47P -0400,
Matthias Kaehlcke <mka@chromium.org> wrote:

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
> Acked-by: Kees Cook <keescook@chromium.org>
> ---
> 
> Changes in v5:
> - changed dm_verity_loadpin_is_sb_trusted() to
>   dm_verity_loadpin_is_bdev_trusted()
> - bumped version number to 1.8.1
> - deleted bad semicolon in declaration of stub for
>   dm_verity_loadpin_is_bdev_trusted()
> - added 'Acked-by' tag from Kees
> 
> Changes in v4:
> - a trusted verity device must have a single target of
>   type 'verity'
> - share list of verity digests with loadpin, deleted
>   dm_verity_loadpin_set_trusted_root_digests()
> - dm_verity_loadpin_is_md_trusted() is now dm_verity_loadpin_is_sb_trusted(),
>   it receives a super_block instead of mapped_device. Updated kernel doc.
> - changed struct trusted_root_digest to have an unsized
>   u8 array instead of a pointer
> - extend 'dm-verity-objs' instead of 'dm-mod-objs'
> 
> Changes in v3:
> - none
> 
> Changes in v2:
> - none
> 
>  drivers/md/Makefile               |  6 +++
>  drivers/md/dm-verity-loadpin.c    | 74 +++++++++++++++++++++++++++++++
>  drivers/md/dm-verity-target.c     | 35 ++++++++++++++-
>  drivers/md/dm-verity.h            |  4 ++
>  include/linux/dm-verity-loadpin.h | 27 +++++++++++
>  5 files changed, 145 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/md/dm-verity-loadpin.c
>  create mode 100644 include/linux/dm-verity-loadpin.h
> 
> diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> index 0454b0885b01..71771901c823 100644
> --- a/drivers/md/Makefile
> +++ b/drivers/md/Makefile
> @@ -108,6 +108,12 @@ ifeq ($(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG),y)
>  dm-verity-objs			+= dm-verity-verify-sig.o
>  endif
>  
> +ifeq ($(CONFIG_DM_VERITY),y)
> +ifeq ($(CONFIG_SECURITY_LOADPIN),y)
> +dm-verity-objs			+= dm-verity-loadpin.o
> +endif
> +endif
> +
>  ifeq ($(CONFIG_DM_AUDIT),y)
>  dm-mod-objs			+= dm-audit.o
>  endif
> diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
> new file mode 100644
> index 000000000000..49616ea93317
> --- /dev/null
> +++ b/drivers/md/dm-verity-loadpin.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/list.h>
> +#include <linux/kernel.h>
> +#include <linux/dm-verity-loadpin.h>
> +
> +#include "dm.h"
> +#include "dm-verity.h"
> +
> +#define DM_MSG_PREFIX	"verity-loadpin"
> +
> +LIST_HEAD(loadpin_trusted_verity_root_digests);
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
> +	list_for_each_entry(trd, &loadpin_trusted_verity_root_digests, node) {
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
> + * Determines whether the file system of a superblock is located on
> + * a verity device that is trusted by LoadPin.
> + */
> +bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
> +{
> +	struct mapped_device *md;
> +	struct dm_table *table;
> +	struct dm_target *ti;
> +	int srcu_idx;
> +	bool trusted = false;
> +
> +	if (list_empty(&loadpin_trusted_verity_root_digests))
> +		return false;
> +
> +	md = dm_get_md(bdev->bd_dev);
> +	if (!md)
> +		return false;
> +
> +	table = dm_get_live_table(md, &srcu_idx);
> +
> +	if (dm_table_get_num_targets(table) != 1)
> +		goto out;
> +
> +	ti = dm_table_get_target(table, 0);
> +
> +	if (is_trusted_verity_target(ti))
> +		trusted = true;
> +
> +out:
> +	dm_put_live_table(md, srcu_idx);
> +	dm_put(md);
> +
> +	return trusted;
> +}

This should have:
EXPORT_SYMBOL_GPL(dm_verity_loadpin_is_bdev_trusted);

> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index 80133aae0db3..d6a7903e91e6 100644
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
> @@ -1310,9 +1311,41 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
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

Why is this exported?

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

Why is this exported?

Both of these should be internal to dm-verity module.

Have you built a modular kernel to test?


>  static struct target_type verity_target = {
>  	.name		= "verity",
> -	.version	= {1, 8, 0},
> +	.version	= {1, 8, 1},
>  	.module		= THIS_MODULE,
>  	.ctr		= verity_ctr,
>  	.dtr		= verity_dtr,
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
> index 000000000000..d37146dbb1a8
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
> +struct block_device;
> +
> +extern struct list_head loadpin_trusted_verity_root_digests;

s/loadpin_trusted_verity_root_digests/dm_verity_loadpin_trusted_root_digests/ ?

> +
> +struct trusted_root_digest {
> +	struct list_head node;
> +	unsigned int len;
> +	u8 data[];
> +};

s/trusted_root_digest/dm_verity_loadpin_trusted_root_digest/ ?

Long names, but more consistent and informative.

> +#if IS_ENABLED(CONFIG_SECURITY_LOADPIN) && IS_BUILTIN(CONFIG_DM_VERITY)
> +bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev);
> +#else
> +static inline bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
> +{
> +	return false;
> +}
> +#endif
> +
> +#endif /* __LINUX_DM_VERITY_LOADPIN_H */
> -- 
> 2.36.1.124.g0e6072fb45-goog
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 


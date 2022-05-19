Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E92452DCBD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243883AbiESS2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243876AbiESS2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:28:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC09DFF4E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:28:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n10so6027836pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xUSkW5L5SdeK9bspy74CxP8gR2AbxFPEz0xW/WWqv9k=;
        b=bSUhoZQA4ahN4+pYe6LpGRlSy0x5KpiQTbtVKb8LMYt39rQMwD9s3A6Mh0svJOaRPN
         mUlQC7ospSMi/CtbSQ26ttS233+3xoU/HFn1OOEfKBT33IjnF0agpzRMnUsqexNNmOoO
         AwE1f7bbcbJ7hnPdJ2VK7sHgCfGPoGlBJCRpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xUSkW5L5SdeK9bspy74CxP8gR2AbxFPEz0xW/WWqv9k=;
        b=UfcGzsbIk1odM5u2erdCsqWB8AJNrYjFnPcy4cDrupwAYfuTt52HZPD7ecFAf07f3j
         1G5TBc/WCrJ9Hax0kmamRQn0xmG7KE0x8tOHwVYvxeZ0eiBMvPYqeNs49rG4UWz8omd2
         QreOAko73RGJjOuaFMkfq61+PU5GKybpJEudoEnb0SVbiw/OyMnOeM9o6iGzwqOU+8tV
         JeKz78Y/PMQk5EsBgL63uH0Q2Ph05awQHxxhm+Y2SItdfzG8rYUntf5HBRalU+p+kN/1
         8px7vB833VkHMLexErpsAX5ImUrjJkBTxkRekDUOEq+xquREQ6TwabikKp2gxmw42vlS
         kjNQ==
X-Gm-Message-State: AOAM533EuA39C2aLuAEPysi7NfvqJ/XjbA4jDVepprXw8NGcmg0OcZRY
        ZYWou9vAC/5zyn+xA2yglcVAJg==
X-Google-Smtp-Source: ABdhPJxZTGaQEAjUFEyGm7xPppGzbnaxQcp/SSm+5uyz4jGC+ty+Os8lmGRIuTLIVkJUVMv64oGCzQ==
X-Received: by 2002:a17:903:44e:b0:161:58c6:77e5 with SMTP id iw14-20020a170903044e00b0016158c677e5mr6102404plb.81.1652984890374;
        Thu, 19 May 2022 11:28:10 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:e229:79ea:227e:d9dd])
        by smtp.gmail.com with UTF8SMTPSA id t10-20020a17090340ca00b0015e8d4eb29esm3930323pld.232.2022.05.19.11.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 11:28:10 -0700 (PDT)
Date:   Thu, 19 May 2022 11:28:08 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mike Snitzer <snitzer@redhat.com>
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
Message-ID: <YoaMOEGwWw4wzuct@google.com>
References: <20220519004754.2174254-1-mka@chromium.org>
 <20220518174739.v5.1.I3e928575a23481121e73286874c4c2bdb403355d@changeid>
 <YoZysmcnU6o2scFI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoZysmcnU6o2scFI@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 12:39:14PM -0400, Mike Snitzer wrote:
> On Wed, May 18 2022 at  8:47P -0400,
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > LoadPin limits loading of kernel modules, firmware and certain
> > other files to a 'pinned' file system (typically a read-only
> > rootfs). To provide more flexibility LoadPin is being extended
> > to also allow loading these files from trusted dm-verity
> > devices. For that purpose LoadPin can be provided with a list
> > of verity root digests that it should consider as trusted.
> > 
> > Add a bunch of helpers to allow LoadPin to check whether a DM
> > device is a trusted verity device. The new functions broadly
> > fall in two categories: those that need access to verity
> > internals (like the root digest), and the 'glue' between
> > LoadPin and verity. The new file dm-verity-loadpin.c contains
> > the glue functions.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Acked-by: Kees Cook <keescook@chromium.org>
> > ---
> > 
> > Changes in v5:
> > - changed dm_verity_loadpin_is_sb_trusted() to
> >   dm_verity_loadpin_is_bdev_trusted()
> > - bumped version number to 1.8.1
> > - deleted bad semicolon in declaration of stub for
> >   dm_verity_loadpin_is_bdev_trusted()
> > - added 'Acked-by' tag from Kees
> > 
> > Changes in v4:
> > - a trusted verity device must have a single target of
> >   type 'verity'
> > - share list of verity digests with loadpin, deleted
> >   dm_verity_loadpin_set_trusted_root_digests()
> > - dm_verity_loadpin_is_md_trusted() is now dm_verity_loadpin_is_sb_trusted(),
> >   it receives a super_block instead of mapped_device. Updated kernel doc.
> > - changed struct trusted_root_digest to have an unsized
> >   u8 array instead of a pointer
> > - extend 'dm-verity-objs' instead of 'dm-mod-objs'
> > 
> > Changes in v3:
> > - none
> > 
> > Changes in v2:
> > - none
> > 
> >  drivers/md/Makefile               |  6 +++
> >  drivers/md/dm-verity-loadpin.c    | 74 +++++++++++++++++++++++++++++++
> >  drivers/md/dm-verity-target.c     | 35 ++++++++++++++-
> >  drivers/md/dm-verity.h            |  4 ++
> >  include/linux/dm-verity-loadpin.h | 27 +++++++++++
> >  5 files changed, 145 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/md/dm-verity-loadpin.c
> >  create mode 100644 include/linux/dm-verity-loadpin.h
> > 
> > diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> > index 0454b0885b01..71771901c823 100644
> > --- a/drivers/md/Makefile
> > +++ b/drivers/md/Makefile
> > @@ -108,6 +108,12 @@ ifeq ($(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG),y)
> >  dm-verity-objs			+= dm-verity-verify-sig.o
> >  endif
> >  
> > +ifeq ($(CONFIG_DM_VERITY),y)
> > +ifeq ($(CONFIG_SECURITY_LOADPIN),y)
> > +dm-verity-objs			+= dm-verity-loadpin.o
> > +endif
> > +endif
> > +
> >  ifeq ($(CONFIG_DM_AUDIT),y)
> >  dm-mod-objs			+= dm-audit.o
> >  endif
> > diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
> > new file mode 100644
> > index 000000000000..49616ea93317
> > --- /dev/null
> > +++ b/drivers/md/dm-verity-loadpin.c
> > @@ -0,0 +1,74 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#include <linux/list.h>
> > +#include <linux/kernel.h>
> > +#include <linux/dm-verity-loadpin.h>
> > +
> > +#include "dm.h"
> > +#include "dm-verity.h"
> > +
> > +#define DM_MSG_PREFIX	"verity-loadpin"
> > +
> > +LIST_HEAD(loadpin_trusted_verity_root_digests);
> > +
> > +static bool is_trusted_verity_target(struct dm_target *ti)
> > +{
> > +	u8 *root_digest;
> > +	unsigned int digest_size;
> > +	struct trusted_root_digest *trd;
> > +	bool trusted = false;
> > +
> > +	if (!dm_is_verity_target(ti))
> > +		return false;
> > +
> > +	if (dm_verity_get_root_digest(ti, &root_digest, &digest_size))
> > +		return false;
> > +
> > +	list_for_each_entry(trd, &loadpin_trusted_verity_root_digests, node) {
> > +		if ((trd->len == digest_size) &&
> > +		    !memcmp(trd->data, root_digest, digest_size)) {
> > +			trusted = true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	kfree(root_digest);
> > +
> > +	return trusted;
> > +}
> > +
> > +/*
> > + * Determines whether the file system of a superblock is located on
> > + * a verity device that is trusted by LoadPin.
> > + */
> > +bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
> > +{
> > +	struct mapped_device *md;
> > +	struct dm_table *table;
> > +	struct dm_target *ti;
> > +	int srcu_idx;
> > +	bool trusted = false;
> > +
> > +	if (list_empty(&loadpin_trusted_verity_root_digests))
> > +		return false;
> > +
> > +	md = dm_get_md(bdev->bd_dev);
> > +	if (!md)
> > +		return false;
> > +
> > +	table = dm_get_live_table(md, &srcu_idx);
> > +
> > +	if (dm_table_get_num_targets(table) != 1)
> > +		goto out;
> > +
> > +	ti = dm_table_get_target(table, 0);
> > +
> > +	if (is_trusted_verity_target(ti))
> > +		trusted = true;
> > +
> > +out:
> > +	dm_put_live_table(md, srcu_idx);
> > +	dm_put(md);
> > +
> > +	return trusted;
> > +}
> 
> This should have:
> EXPORT_SYMBOL_GPL(dm_verity_loadpin_is_bdev_trusted);

Actually the export shouldn't be needed as long as LoadPin is the only
caller:

config SECURITY_LOADPIN_VERITY
        bool "Allow reading files from certain other filesystems that use dm-verity"
        depends on DM_VERITY=y && SECURITYFS

LoadPin can't be built as a module, hence for the verity integration to work
verity needs to be built into the kernel.

> > diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> > index 80133aae0db3..d6a7903e91e6 100644
> > --- a/drivers/md/dm-verity-target.c
> > +++ b/drivers/md/dm-verity-target.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/module.h>
> >  #include <linux/reboot.h>
> >  #include <linux/scatterlist.h>
> > +#include <linux/string.h>
> >  
> >  #define DM_MSG_PREFIX			"verity"
> >  
> > @@ -1310,9 +1311,41 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> >  	return r;
> >  }
> >  
> > +/*
> > + * Check whether a DM target is a verity target.
> > + */
> > +bool dm_is_verity_target(struct dm_target *ti)
> > +{
> > +	return ti->type->module == THIS_MODULE;
> > +}
> > +EXPORT_SYMBOL_GPL(dm_is_verity_target);
> 
> Why is this exported?

It's remainder from an early version that I forgot to remove, agreed it's not
needed.

> > +
> > +/*
> > + * Get the root digest of a verity target.
> > + *
> > + * Returns a copy of the root digest, the caller is responsible for
> > + * freeing the memory of the digest.
> > + */
> > +int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned int *digest_size)
> > +{
> > +	struct dm_verity *v = ti->private;
> > +
> > +	if (!dm_is_verity_target(ti))
> > +		return -EINVAL;
> > +
> > +	*root_digest = kmemdup(v->root_digest, v->digest_size, GFP_KERNEL);
> > +	if (*root_digest == NULL)
> > +		return -ENOMEM;
> > +
> > +	*digest_size = v->digest_size;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dm_verity_get_root_digest);
> 
> Why is this exported?
>
> Both of these should be internal to dm-verity module.

Agreed, will change.

> Have you built a modular kernel to test?

I didn't, since LoadPin is always builtin and hence verity needs to be builtin
too for CONFIG_SECURITY_LOADPIN_VERITY.

> >  static struct target_type verity_target = {
> >  	.name		= "verity",
> > -	.version	= {1, 8, 0},
> > +	.version	= {1, 8, 1},
> >  	.module		= THIS_MODULE,
> >  	.ctr		= verity_ctr,
> >  	.dtr		= verity_dtr,
> > diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
> > index 4e769d13473a..c832cc3e3d24 100644
> > --- a/drivers/md/dm-verity.h
> > +++ b/drivers/md/dm-verity.h
> > @@ -129,4 +129,8 @@ extern int verity_hash(struct dm_verity *v, struct ahash_request *req,
> >  extern int verity_hash_for_block(struct dm_verity *v, struct dm_verity_io *io,
> >  				 sector_t block, u8 *digest, bool *is_zero);
> >  
> > +extern bool dm_is_verity_target(struct dm_target *ti);
> > +extern int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest,
> > +				     unsigned int *digest_size);
> > +
> >  #endif /* DM_VERITY_H */
> > diff --git a/include/linux/dm-verity-loadpin.h b/include/linux/dm-verity-loadpin.h
> > new file mode 100644
> > index 000000000000..d37146dbb1a8
> > --- /dev/null
> > +++ b/include/linux/dm-verity-loadpin.h
> > @@ -0,0 +1,27 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __LINUX_DM_VERITY_LOADPIN_H
> > +#define __LINUX_DM_VERITY_LOADPIN_H
> > +
> > +#include <linux/list.h>
> > +
> > +struct block_device;
> > +
> > +extern struct list_head loadpin_trusted_verity_root_digests;
> 
> s/loadpin_trusted_verity_root_digests/dm_verity_loadpin_trusted_root_digests/ ?

ok

> > +
> > +struct trusted_root_digest {
> > +	struct list_head node;
> > +	unsigned int len;
> > +	u8 data[];
> > +};
> 
> s/trusted_root_digest/dm_verity_loadpin_trusted_root_digest/ ?
> 
> Long names, but more consistent and informative.

Sounds good, I'll change it in the next version.

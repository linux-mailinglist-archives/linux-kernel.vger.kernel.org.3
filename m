Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB225267CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382643AbiEMRB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 13:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382777AbiEMRBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 13:01:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ACE546A0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:01:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i1so8519229plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iDSh0Mq4giBjDXuEjDs1oB99KRT+jEM69GY64GlYuqo=;
        b=J6jZ4fpI65YspqHfDrsJdVgplnIZHzpyJG4CTF9EB7T13Ed+EcxbXV0tS5hX1wrTdK
         95miDOy3mBtJO6jdvc0GKKg25M1iyUcMBGNOi1uNY1lZvGa8vbpTS5JWk+Ic3lFjUva7
         S7czsAbgylQIMQkBOiRf2OpNiKffdfiiLKYp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iDSh0Mq4giBjDXuEjDs1oB99KRT+jEM69GY64GlYuqo=;
        b=G6ITXPCaskxYAEiv6Jr/aCdG8bqdhyO9/4dRw6WDYRb8CtURr0GorP5VkUuAkDVNQ5
         R9iJoGILtZRvDYrAmvucxUVw+I1ZYajXUqRGEb026VR6enthrf0ja7A9gVVyVOHPlkiH
         GF4eQERj3w36nu7G/LQIAiXEqx+xHZp/8DrSbttgH3IJTAJhyfNZeCz8MnZwNlC5D5Np
         9AGPQa8a6iPXp/O1m3hLrqjz+UY2xuKFKP0Td2/uPmByFR+pMmRStjrf1uLDa15QaXcb
         A7rRy/eOIlF8f7yrAp/HKlL6YbpRX6mvCzzSvmhw0d4MK1ru3eg24YMzuvPtWyONXoQV
         63og==
X-Gm-Message-State: AOAM531F7I1Kt8fxpToICGK7GozCs3Lr1q2NFd2OqNRvlP9xsvXYfZWn
        DuLQ34CwF5iINBSq6IGVkL/7Sw==
X-Google-Smtp-Source: ABdhPJySKhTT2GaHdsFJBuSCXtc60COGMFiU4k8QMHhLeOxfWg0Nq/feCbdPXnhRoBekWzLFUIO6Jg==
X-Received: by 2002:a17:902:7144:b0:15f:3d88:d79 with SMTP id u4-20020a170902714400b0015f3d880d79mr5489644plm.86.1652461308538;
        Fri, 13 May 2022 10:01:48 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:bc87:9632:bcce:8e17])
        by smtp.gmail.com with UTF8SMTPSA id v1-20020a056a00148100b0050dc76281b5sm2133826pfu.143.2022.05.13.10.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 10:01:48 -0700 (PDT)
Date:   Fri, 13 May 2022 10:01:46 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <Yn6O+l0fJMJO8Oh2@google.com>
References: <20220504195419.1143099-1-mka@chromium.org>
 <20220504125404.v3.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
 <Yn6IDNgG+/ySOdmy@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yn6IDNgG+/ySOdmy@redhat.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 12:32:12PM -0400, Mike Snitzer wrote:
> On Wed, May 04 2022 at  3:54P -0400,
> Matthias Kaehlcke <mka@chromium.org> wrote:
> 
> > Extend LoadPin to allow loading of kernel files from trusted dm-verity [1]
> > devices.
> > 
> > This change adds the concept of trusted verity devices to LoadPin. LoadPin
> > maintains a list of root digests of verity devices it considers trusted.
> > Userspace can populate this list through an ioctl on the new LoadPin
> > securityfs entry 'dm-verity'. The ioctl receives a file descriptor of
> > a file with verity digests as parameter. Verity reads the digests from
> > this file after confirming that the file is located on the pinned root.
> > The list of trusted digests can only be set up once, which is typically
> > done at boot time.
> > 
> > When a kernel file is read LoadPin first checks (as usual) whether the file
> > is located on the pinned root, if so the file can be loaded. Otherwise, if
> > the verity extension is enabled, LoadPin determines whether the file is
> > located on a verity backed device and whether the root digest of that
> > device is in the list of trusted digests. The file can be loaded if the
> > verity device has a trusted root digest.
> > 
> > Background:
> > 
> > As of now LoadPin restricts loading of kernel files to a single pinned
> > filesystem, typically the rootfs. This works for many systems, however it
> > can result in a bloated rootfs (and OTA updates) on platforms where
> > multiple boards with different hardware configurations use the same rootfs
> > image. Especially when 'optional' files are large it may be preferable to
> > download/install them only when they are actually needed by a given board.
> > Chrome OS uses Downloadable Content (DLC) [2] to deploy certain 'packages'
> > at runtime. As an example a DLC package could contain firmware for a
> > peripheral that is not present on all boards. DLCs use dm-verity to verify
> > the integrity of the DLC content.
> > 
> > [1] https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/verity.html
> > [2] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/dlcservice/docs/developer.md
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> > Changes in v3:
> > - added securityfs for LoadPin (currently only populated when
> >   CONFIG_SECURITY_LOADPIN_VERITY=y)
> > - added uapi include for LoadPin
> > - changed the interface for setting up the list of trusted
> >   digests from sysctl to ioctl on securityfs entry
> > - added stub for loadpin_is_fs_trusted() to be used
> >   CONFIG_SECURITY_LOADPIN_VERITY is not select
> > - depend on CONFIG_SECURITYFS instead of CONFIG_SYSTCL
> > - updated Kconfig help
> > - minor changes in read_trusted_verity_root_digests()
> > - updated commit message
> > 
> > Changes in v2:
> > - userspace now passes the path of the file with the verity digests
> >   via systcl, instead of the digests themselves
> > - renamed sysctl file to 'trusted_verity_root_digests_path'
> > - have CONFIG_SECURITY_LOADPIN_VERITY depend on CONFIG_SYSCTL
> > - updated Kconfig doc
> > - updated commit message
> > 
> >  include/uapi/linux/loadpin.h |  19 ++++
> >  security/loadpin/Kconfig     |  16 +++
> >  security/loadpin/loadpin.c   | 184 ++++++++++++++++++++++++++++++++++-
> >  3 files changed, 218 insertions(+), 1 deletion(-)
> >  create mode 100644 include/uapi/linux/loadpin.h
> 
> I would certainly need some Reviewed-by:s from security and/or loadpin
> experts if I were to pick this patch up.

Yes, I think Kees (LoadPin maintainer) is generally on board with the idea,
but a more in depth review is still pending.

I'll send out a new revision which addresses the current outstanding
comments soon.

> Did you see the issues the kernel test robot emailed about?
> 
> You'd do well to fix those issues up when submitting another revision
> of this patchset.

Yes, I plan to address those in the next revision. Thanks for the reminder!

> > 
> > diff --git a/include/uapi/linux/loadpin.h b/include/uapi/linux/loadpin.h
> > new file mode 100644
> > index 000000000000..d303a582209b
> > --- /dev/null
> > +++ b/include/uapi/linux/loadpin.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Copyright (c) 2022, Google LLC
> > + */
> > +
> > +#ifndef _UAPI_LINUX_LOOP_LOADPIN_H
> > +#define _UAPI_LINUX_LOOP_LOADPIN_H
> > +
> > +#define LOADPIN_IOC_MAGIC	'L'
> > +
> > +/**
> > + * LOADPIN_IOC_SET_TRUSTED_VERITY_DIGESTS - Set up the root digests of verity devices
> > + *                                          that loadpin should trust.
> > + *
> > + * Takes a file descriptor from which to read the root digests of trusted verity devices.
> > + */
> > +#define LOADPIN_IOC_SET_TRUSTED_VERITY_DIGESTS _IOW(LOADPIN_IOC_MAGIC, 0x00, unsigned int)
> > +
> > +#endif /* _UAPI_LINUX_LOOP_LOADPIN_H */
> > diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> > index 91be65dec2ab..e319ca8e3f3d 100644
> > --- a/security/loadpin/Kconfig
> > +++ b/security/loadpin/Kconfig
> > @@ -18,3 +18,19 @@ config SECURITY_LOADPIN_ENFORCE
> >  	  If selected, LoadPin will enforce pinning at boot. If not
> >  	  selected, it can be enabled at boot with the kernel parameter
> >  	  "loadpin.enforce=1".
> > +
> > +config SECURITY_LOADPIN_VERITY
> > +	bool "Allow reading files from certain other filesystems that use dm-verity"
> > +	depends on DM_VERITY=y && SECURITYFS
> > +	help
> > +	  If selected LoadPin can allow reading files from filesystems
> > +	  that use dm-verity. LoadPin maintains a list of verity root
> > +	  digests it considers trusted. A verity backed filesystem is
> > +	  considered trusted if its root digest is found in the list
> > +	  of trusted digests.
> > +
> > +	  The list of trusted verity can be populated through an ioctl
> > +	  on the LoadPin securityfs entry 'dm-verity'. The ioctl
> > +	  expects a file descriptor of a file with verity digests as
> > +	  parameter. The file must be located on the pinned root and
> > +	  contain a comma separated list of digests.
> > diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> > index b12f7d986b1e..c29ce562a366 100644
> > --- a/security/loadpin/loadpin.c
> > +++ b/security/loadpin/loadpin.c
> > @@ -18,6 +18,9 @@
> >  #include <linux/path.h>
> >  #include <linux/sched.h>	/* current */
> >  #include <linux/string_helpers.h>
> > +#include <linux/device-mapper.h>
> > +#include <linux/dm-verity-loadpin.h>
> > +#include <uapi/linux/loadpin.h>
> >  
> >  static void report_load(const char *origin, struct file *file, char *operation)
> >  {
> > @@ -43,6 +46,9 @@ static char *exclude_read_files[READING_MAX_ID];
> >  static int ignore_read_file_id[READING_MAX_ID] __ro_after_init;
> >  static struct super_block *pinned_root;
> >  static DEFINE_SPINLOCK(pinned_root_spinlock);
> > +#ifdef CONFIG_SECURITY_LOADPIN_VERITY
> > +static LIST_HEAD(trusted_verity_root_digests);
> > +#endif
> >  
> >  #ifdef CONFIG_SYSCTL
> >  
> > @@ -118,6 +124,24 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
> >  	}
> >  }
> >  
> > +#ifdef CONFIG_SECURITY_LOADPIN_VERITY
> > +static bool loadpin_is_fs_trusted(struct super_block *sb)
> > +{
> > +	struct mapped_device *md = dm_get_md(sb->s_bdev->bd_dev);
> > +	bool trusted;
> > +
> > +	if (!md)
> > +		return false;
> > +
> > +	trusted = dm_verity_loadpin_is_md_trusted(md);
> > +	dm_put(md);
> > +
> > +	return trusted;
> > +}
> > +#else
> > +static inline bool loadpin_is_fs_trusted(struct super_block *sb) { return false; };
> > +#endif
> > +
> >  static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
> >  			     bool contents)
> >  {
> > @@ -174,7 +198,8 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
> >  		spin_unlock(&pinned_root_spinlock);
> >  	}
> >  
> > -	if (IS_ERR_OR_NULL(pinned_root) || load_root != pinned_root) {
> > +	if (IS_ERR_OR_NULL(pinned_root) ||
> > +	    ((load_root != pinned_root) && !loadpin_is_fs_trusted(load_root))) {
> >  		if (unlikely(!enforce)) {
> >  			report_load(origin, file, "pinning-ignored");
> >  			return 0;
> > @@ -240,6 +265,7 @@ static int __init loadpin_init(void)
> >  		enforce ? "" : "not ");
> >  	parse_exclude();
> >  	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
> > +
> >  	return 0;
> >  }
> >  
> > @@ -248,6 +274,162 @@ DEFINE_LSM(loadpin) = {
> >  	.init = loadpin_init,
> >  };
> >  
> > +#ifdef CONFIG_SECURITY_LOADPIN_VERITY
> > +
> > +enum loadpin_securityfs_interface_index {
> > +	LOADPIN_DM_VERITY,
> > +};
> > +
> > +static int read_trusted_verity_root_digests(unsigned int fd)
> > +{
> > +	struct fd f;
> > +	void *data;
> > +	int rc;
> > +	char *p, *d;
> > +
> > +	/* The list of trusted root digests can only be set up once */
> > +	if (!list_empty(&trusted_verity_root_digests))
> > +		return -EPERM;
> > +
> > +	f = fdget(fd);
> > +	if (!f.file)
> > +		return -EINVAL;
> > +
> > +	data = kzalloc(SZ_4K, GFP_KERNEL);
> > +	if (!data) {
> > +		rc = -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	rc = kernel_read_file(f.file, 0, &data, SZ_4K - 1, NULL, READING_POLICY);
> > +	if (rc < 0)
> > +		goto err;
> > +
> > +	((char *)data)[rc] = '\0';
> > +
> > +	p = strim(data);
> > +	while ((d = strsep(&p, ",")) != NULL) {
> > +		int len = strlen(d);
> > +		struct trusted_root_digest *trd;
> > +
> > +		if (len % 2) {
> > +			rc = -EPROTO;
> > +			goto err;
> > +		}
> > +
> > +		len /= 2;
> > +
> > +		trd = kzalloc(sizeof(*trd), GFP_KERNEL);
> > +		if (!trd) {
> > +			rc = -ENOMEM;
> > +			goto err;
> > +		}
> > +
> > +		trd->data = kzalloc(len, GFP_KERNEL);
> > +		if (!trd->data) {
> > +			kfree(trd);
> > +			rc = -ENOMEM;
> > +			goto err;
> > +		}
> > +
> > +		if (hex2bin(trd->data, d, len)) {
> > +			kfree(trd);
> > +			kfree(trd->data);
> > +			rc = -EPROTO;
> > +			goto err;
> > +		}
> > +
> > +		trd->len = len;
> > +
> > +		list_add_tail(&trd->node, &trusted_verity_root_digests);
> > +	}
> > +
> > +	kfree(data);
> > +	fdput(f);
> > +
> > +	if (!list_empty(&trusted_verity_root_digests))
> > +		dm_verity_loadpin_set_trusted_root_digests(&trusted_verity_root_digests);
> > +
> > +	return 0;
> > +
> > +err:
> > +	kfree(data);
> > +
> > +	{
> > +		struct trusted_root_digest *trd, *tmp;
> > +
> > +		list_for_each_entry_safe(trd, tmp, &trusted_verity_root_digests, node) {
> > +			kfree(trd->data);
> > +			list_del(&trd->node);
> > +			kfree(trd);
> > +		}
> > +	}
> > +
> > +	fdput(f);
> > +
> > +	return rc;
> > +}
> > +
> > +/******************************** securityfs ********************************/
> > +
> > +static long dm_verity_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> > +{
> > +	void __user *uarg = (void __user *)arg;
> > +	unsigned int fd;
> > +	int rc;
> > +
> > +	switch (cmd) {
> > +	case LOADPIN_IOC_SET_TRUSTED_VERITY_DIGESTS:
> > +		rc = copy_from_user(&fd, uarg, sizeof(fd));
> > +		if (rc)
> > +			return rc;
> > +
> > +		return read_trusted_verity_root_digests(fd);
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct file_operations loadpin_dm_verity_ops = {
> > +	.unlocked_ioctl = dm_verity_ioctl,
> > +	.compat_ioctl = compat_ptr_ioctl,
> > +};
> > +
> > +/**
> > + * init_loadpin_securityfs - create the securityfs directory for LoadPin
> > + *
> > + * We can not put this method normally under the loadpin_init() code path since
> > + * the security subsystem gets initialized before the vfs caches.
> > + *
> > + * Returns 0 if the securityfs directory creation was successful.
> > + */
> > +static int __init init_loadpin_securityfs(void)
> > +{
> > +	struct dentry *loadpin_dir, *dentry;
> > +
> > +	loadpin_dir = securityfs_create_dir("loadpin", NULL);
> > +	if (IS_ERR(loadpin_dir)) {
> > +		pr_err("LoadPin: could not create securityfs dir: %d\n",
> > +		       PTR_ERR(loadpin_dir));
> > +		return PTR_ERR(loadpin_dir);
> > +	}
> > +
> > +	dentry = securityfs_create_file("dm-verity", 0600, loadpin_dir,
> > +					(void *)LOADPIN_DM_VERITY, &loadpin_dm_verity_ops);
> > +	if (IS_ERR(dentry)) {
> > +		pr_err("LoadPin: could not create securityfs entry 'dm-verity': %d\n",
> > +		       PTR_ERR(dentry));
> > +		return PTR_ERR(dentry);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +fs_initcall(init_loadpin_securityfs);
> > +
> > +#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
> > +
> >  /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
> >  module_param(enforce, int, 0);
> >  MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
> > -- 
> > 2.36.0.464.gb9c8b46e94-goog
> > 
> 

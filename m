Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C008C526CF6
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbiEMWgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiEMWgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:36:33 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1C938194
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:36:29 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g184so8749399pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=5gA/z5w3iSZBhMGL4NGMxYvM+06CCYMA733n8qghoV8=;
        b=Kp5u4/CM0YQ2KQq5OsxAXepvwvZdx5O2/gLoWa1K/zJm+KgMoVemmr6ZO5ms2bBWxB
         MFhshJjvZob1rJ6M1wEFqyuGQscI3Rer4cVoAwHloLdE4OLC2RsqxoJUDUsoAMQbdkeN
         kktH9Ey9YNW+hpYreY7t4FSY2x9qp4cORAKl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=5gA/z5w3iSZBhMGL4NGMxYvM+06CCYMA733n8qghoV8=;
        b=U1vkBh7sGLI28fMzCIMXzw4EJ23Bi0i22t4jEdqJ7GHNMY8LkP980kgQUObCQkdSWS
         IMa3QUsjtBmUfIh8WsnL9jqNGvR37A31FXYPFiUw9YUcxeKY3YHaqtUfIjbkfNb55b9w
         UmekXsULCYrtVeZnH9axidXtGTy3Ni4/f+l4XnrK8s8bkSBsio0jnXSP0F4ptJTv+WFs
         PmQI5Un+KXIqz3aFytSjShhXW/b0lHXTNdT7+imXAVtruBgx+XDP11R4wRHAG5Hm51Q2
         90N4rTf2xBEOSvAkO/Q09sur7iwwcgC3jYg2E8hRimN12u+tOYBumroLYKahkAqAFegR
         JQ8w==
X-Gm-Message-State: AOAM530hrAEQNMK8a9MkIEnBbkinzsSFAoCV1PKcdBlifT2+9vFd5xAC
        H9nS9xi4fPVzaLo6JCA9jdE8CQ==
X-Google-Smtp-Source: ABdhPJxBG6e3E9oNiJFfeBHLppZK7vFJX4UY0lZeJxSrEESj5nfl/PMVKHRcA3ds9aAvC7+znYeatA==
X-Received: by 2002:a05:6a00:10cc:b0:4fe:3f1c:2d1 with SMTP id d12-20020a056a0010cc00b004fe3f1c02d1mr6472165pfu.0.1652481388955;
        Fri, 13 May 2022 15:36:28 -0700 (PDT)
Received: from ?IPv6:::1? ([2607:fb90:3322:7d68:6474:9b3c:2c42:56f1])
        by smtp.gmail.com with ESMTPSA id r15-20020a17090a940f00b001cd8e9ea22asm4025665pjo.52.2022.05.13.15.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 15:36:28 -0700 (PDT)
Date:   Fri, 13 May 2022 15:36:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
CC:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-security-module@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/3=5D_LoadPin=3A_Enable_l?= =?US-ASCII?Q?oading_from_trusted_dm-verity_devices?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20220504125404.v3.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
References: <20220504195419.1143099-1-mka@chromium.org> <20220504125404.v3.2.I01c67af41d2f6525c6d023101671d7339a9bc8b5@changeid>
Message-ID: <B7FB2BE6-DF1C-414A-B4C2-0C15FD1CBF75@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 4, 2022 12:54:18 PM PDT, Matthias Kaehlcke <mka@chromium=2Eorg> wro=
te:
>Extend LoadPin to allow loading of kernel files from trusted dm-verity [1=
]
>devices=2E
>
>This change adds the concept of trusted verity devices to LoadPin=2E Load=
Pin
>maintains a list of root digests of verity devices it considers trusted=
=2E
>Userspace can populate this list through an ioctl on the new LoadPin
>securityfs entry 'dm-verity'=2E The ioctl receives a file descriptor of
>a file with verity digests as parameter=2E Verity reads the digests from
>this file after confirming that the file is located on the pinned root=2E
>The list of trusted digests can only be set up once, which is typically
>done at boot time=2E
>
>When a kernel file is read LoadPin first checks (as usual) whether the fi=
le
>is located on the pinned root, if so the file can be loaded=2E Otherwise,=
 if
>the verity extension is enabled, LoadPin determines whether the file is
>located on a verity backed device and whether the root digest of that

I think this should be "=2E=2E=2E on an already trusted device =2E=2E=2E"

>device is in the list of trusted digests=2E The file can be loaded if the
>verity device has a trusted root digest=2E
>
>Background:
>
>As of now LoadPin restricts loading of kernel files to a single pinned
>filesystem, typically the rootfs=2E This works for many systems, however =
it
>can result in a bloated rootfs (and OTA updates) on platforms where
>multiple boards with different hardware configurations use the same rootf=
s
>image=2E Especially when 'optional' files are large it may be preferable =
to
>download/install them only when they are actually needed by a given board=
=2E
>Chrome OS uses Downloadable Content (DLC) [2] to deploy certain 'packages=
'
>at runtime=2E As an example a DLC package could contain firmware for a
>peripheral that is not present on all boards=2E DLCs use dm-verity to ver=
ify
>the integrity of the DLC content=2E
>
>[1] https://www=2Ekernel=2Eorg/doc/html/latest/admin-guide/device-mapper/=
verity=2Ehtml
>[2] https://chromium=2Egooglesource=2Ecom/chromiumos/platform2/+/HEAD/dlc=
service/docs/developer=2Emd
>
>Signed-off-by: Matthias Kaehlcke <mka@chromium=2Eorg>
>---
>
>Changes in v3:
>- added securityfs for LoadPin (currently only populated when
>  CONFIG_SECURITY_LOADPIN_VERITY=3Dy)
>- added uapi include for LoadPin
>- changed the interface for setting up the list of trusted
>  digests from sysctl to ioctl on securityfs entry
>- added stub for loadpin_is_fs_trusted() to be used
>  CONFIG_SECURITY_LOADPIN_VERITY is not select
>- depend on CONFIG_SECURITYFS instead of CONFIG_SYSTCL
>- updated Kconfig help
>- minor changes in read_trusted_verity_root_digests()
>- updated commit message
>
>Changes in v2:
>- userspace now passes the path of the file with the verity digests
>  via systcl, instead of the digests themselves
>- renamed sysctl file to 'trusted_verity_root_digests_path'
>- have CONFIG_SECURITY_LOADPIN_VERITY depend on CONFIG_SYSCTL
>- updated Kconfig doc
>- updated commit message
>
> include/uapi/linux/loadpin=2Eh |  19 ++++
> security/loadpin/Kconfig     |  16 +++
> security/loadpin/loadpin=2Ec   | 184 ++++++++++++++++++++++++++++++++++-
> 3 files changed, 218 insertions(+), 1 deletion(-)
> create mode 100644 include/uapi/linux/loadpin=2Eh
>
>diff --git a/include/uapi/linux/loadpin=2Eh b/include/uapi/linux/loadpin=
=2Eh
>new file mode 100644
>index 000000000000=2E=2Ed303a582209b
>--- /dev/null
>+++ b/include/uapi/linux/loadpin=2Eh
>@@ -0,0 +1,19 @@
>+/* SPDX-License-Identifier: GPL-2=2E0 WITH Linux-syscall-note */
>+/*
>+ * Copyright (c) 2022, Google LLC
>+ */
>+
>+#ifndef _UAPI_LINUX_LOOP_LOADPIN_H
>+#define _UAPI_LINUX_LOOP_LOADPIN_H
>+
>+#define LOADPIN_IOC_MAGIC	'L'
>+
>+/**
>+ * LOADPIN_IOC_SET_TRUSTED_VERITY_DIGESTS - Set up the root digests of v=
erity devices
>+ *                                          that loadpin should trust=2E
>+ *
>+ * Takes a file descriptor from which to read the root digests of truste=
d verity devices=2E

Maybe add to the comment the securityfs node path here as a helpful hint t=
o the reader, and mention the format (comma separated?)

>+ */
>+#define LOADPIN_IOC_SET_TRUSTED_VERITY_DIGESTS _IOW(LOADPIN_IOC_MAGIC, 0=
x00, unsigned int)
>+
>+#endif /* _UAPI_LINUX_LOOP_LOADPIN_H */
>diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
>index 91be65dec2ab=2E=2Ee319ca8e3f3d 100644
>--- a/security/loadpin/Kconfig
>+++ b/security/loadpin/Kconfig
>@@ -18,3 +18,19 @@ config SECURITY_LOADPIN_ENFORCE
> 	  If selected, LoadPin will enforce pinning at boot=2E If not
> 	  selected, it can be enabled at boot with the kernel parameter
> 	  "loadpin=2Eenforce=3D1"=2E
>+
>+config SECURITY_LOADPIN_VERITY
>+	bool "Allow reading files from certain other filesystems that use dm-ve=
rity"
>+	depends on DM_VERITY=3Dy && SECURITYFS
>+	help
>+	  If selected LoadPin can allow reading files from filesystems
>+	  that use dm-verity=2E LoadPin maintains a list of verity root
>+	  digests it considers trusted=2E A verity backed filesystem is
>+	  considered trusted if its root digest is found in the list
>+	  of trusted digests=2E
>+
>+	  The list of trusted verity can be populated through an ioctl
>+	  on the LoadPin securityfs entry 'dm-verity'=2E The ioctl
>+	  expects a file descriptor of a file with verity digests as
>+	  parameter=2E The file must be located on the pinned root and
>+	  contain a comma separated list of digests=2E
>diff --git a/security/loadpin/loadpin=2Ec b/security/loadpin/loadpin=2Ec
>index b12f7d986b1e=2E=2Ec29ce562a366 100644
>--- a/security/loadpin/loadpin=2Ec
>+++ b/security/loadpin/loadpin=2Ec
>@@ -18,6 +18,9 @@
> #include <linux/path=2Eh>
> #include <linux/sched=2Eh>	/* current */
> #include <linux/string_helpers=2Eh>
>+#include <linux/device-mapper=2Eh>
>+#include <linux/dm-verity-loadpin=2Eh>
>+#include <uapi/linux/loadpin=2Eh>
>=20
> static void report_load(const char *origin, struct file *file, char *ope=
ration)
> {
>@@ -43,6 +46,9 @@ static char *exclude_read_files[READING_MAX_ID];
> static int ignore_read_file_id[READING_MAX_ID] __ro_after_init;
> static struct super_block *pinned_root;
> static DEFINE_SPINLOCK(pinned_root_spinlock);
>+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
>+static LIST_HEAD(trusted_verity_root_digests);
>+#endif
>=20
> #ifdef CONFIG_SYSCTL
>=20
>@@ -118,6 +124,24 @@ static void loadpin_sb_free_security(struct super_bl=
ock *mnt_sb)
> 	}
> }
>=20
>+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
>+static bool loadpin_is_fs_trusted(struct super_block *sb)
>+{
>+	struct mapped_device *md =3D dm_get_md(sb->s_bdev->bd_dev);
>+	bool trusted;
>+
>+	if (!md)
>+		return false;
>+
>+	trusted =3D dm_verity_loadpin_is_md_trusted(md);
>+	dm_put(md);
>+
>+	return trusted;
>+}
>+#else
>+static inline bool loadpin_is_fs_trusted(struct super_block *sb) { retur=
n false; };
>+#endif
>+
> static int loadpin_read_file(struct file *file, enum kernel_read_file_id=
 id,
> 			     bool contents)
> {
>@@ -174,7 +198,8 @@ static int loadpin_read_file(struct file *file, enum =
kernel_read_file_id id,
> 		spin_unlock(&pinned_root_spinlock);
> 	}
>=20
>-	if (IS_ERR_OR_NULL(pinned_root) || load_root !=3D pinned_root) {
>+	if (IS_ERR_OR_NULL(pinned_root) ||
>+	    ((load_root !=3D pinned_root) && !loadpin_is_fs_trusted(load_root))=
) {
> 		if (unlikely(!enforce)) {
> 			report_load(origin, file, "pinning-ignored");
> 			return 0;
>@@ -240,6 +265,7 @@ static int __init loadpin_init(void)
> 		enforce ? "" : "not ");
> 	parse_exclude();
> 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin")=
;
>+
> 	return 0;
> }
>=20
>@@ -248,6 +274,162 @@ DEFINE_LSM(loadpin) =3D {
> 	=2Einit =3D loadpin_init,
> };
>=20
>+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
>+
>+enum loadpin_securityfs_interface_index {
>+	LOADPIN_DM_VERITY,
>+};
>+
>+static int read_trusted_verity_root_digests(unsigned int fd)
>+{
>+	struct fd f;
>+	void *data;

Probably easier if this is u8 *?

>+	int rc;
>+	char *p, *d;
>+
>+	/* The list of trusted root digests can only be set up once */
>+	if (!list_empty(&trusted_verity_root_digests))
>+		return -EPERM;
>+
>+	f =3D fdget(fd);
>+	if (!f=2Efile)
>+		return -EINVAL;
>+
>+	data =3D kzalloc(SZ_4K, GFP_KERNEL);
>+	if (!data) {
>+		rc =3D -ENOMEM;
>+		goto err;
>+	}
>+
>+	rc =3D kernel_read_file(f=2Efile, 0, &data, SZ_4K - 1, NULL, READING_PO=
LICY);
>+	if (rc < 0)
>+		goto err;
>+
>+	((char *)data)[rc] =3D '\0';
>+
>+	p =3D strim(data);
>+	while ((d =3D strsep(&p, ",")) !=3D NULL) {

Maybe be flexible and add newline as a separator too?

>+		int len =3D strlen(d);
>+		struct trusted_root_digest *trd;
>+
>+		if (len % 2) {
>+			rc =3D -EPROTO;
>+			goto err;
>+		}
>+
>+		len /=3D 2;
>+
>+		trd =3D kzalloc(sizeof(*trd), GFP_KERNEL);

With the struct change, this could be:

kzalloc(struct_size(trd, data, len), =2E=2E=2E)

>+		if (!trd) {
>+			rc =3D -ENOMEM;
>+			goto err;
>+		}
>+
>+		trd->data =3D kzalloc(len, GFP_KERNEL);
>+		if (!trd->data) {
>+			kfree(trd);
>+			rc =3D -ENOMEM;
>+			goto err;
>+		}
>+
>+		if (hex2bin(trd->data, d, len)) {
>+			kfree(trd);
>+			kfree(trd->data);
>+			rc =3D -EPROTO;
>+			goto err;
>+		}
>+
>+		trd->len =3D len;
>+
>+		list_add_tail(&trd->node, &trusted_verity_root_digests);
>+	}
>+
>+	kfree(data);
>+	fdput(f);
>+
>+	if (!list_empty(&trusted_verity_root_digests))
>+		dm_verity_loadpin_set_trusted_root_digests(&trusted_verity_root_digest=
s);
>+
>+	return 0;
>+
>+err:
>+	kfree(data);
>+

Maybe add a comment that any load failure will invalidate the entire list?

>+	{
>+		struct trusted_root_digest *trd, *tmp;
>+
>+		list_for_each_entry_safe(trd, tmp, &trusted_verity_root_digests, node)=
 {
>+			kfree(trd->data);
>+			list_del(&trd->node);
>+			kfree(trd);
>+		}
>+	}
>+
>+	fdput(f);
>+
>+	return rc;
>+}
>+
>+/******************************** securityfs ***************************=
*****/
>+
>+static long dm_verity_ioctl(struct file *filp, unsigned int cmd, unsigne=
d long arg)
>+{
>+	void __user *uarg =3D (void __user *)arg;
>+	unsigned int fd;
>+	int rc;
>+
>+	switch (cmd) {
>+	case LOADPIN_IOC_SET_TRUSTED_VERITY_DIGESTS:
>+		rc =3D copy_from_user(&fd, uarg, sizeof(fd));
>+		if (rc)
>+			return rc;
>+
>+		return read_trusted_verity_root_digests(fd);
>+
>+	default:
>+		return -EINVAL;
>+	}
>+}
>+
>+static const struct file_operations loadpin_dm_verity_ops =3D {
>+	=2Eunlocked_ioctl =3D dm_verity_ioctl,
>+	=2Ecompat_ioctl =3D compat_ptr_ioctl,
>+};
>+
>+/**
>+ * init_loadpin_securityfs - create the securityfs directory for LoadPin
>+ *
>+ * We can not put this method normally under the loadpin_init() code pat=
h since
>+ * the security subsystem gets initialized before the vfs caches=2E
>+ *
>+ * Returns 0 if the securityfs directory creation was successful=2E
>+ */
>+static int __init init_loadpin_securityfs(void)
>+{
>+	struct dentry *loadpin_dir, *dentry;
>+
>+	loadpin_dir =3D securityfs_create_dir("loadpin", NULL);
>+	if (IS_ERR(loadpin_dir)) {
>+		pr_err("LoadPin: could not create securityfs dir: %d\n",
>+		       PTR_ERR(loadpin_dir));
>+		return PTR_ERR(loadpin_dir);
>+	}
>+
>+	dentry =3D securityfs_create_file("dm-verity", 0600, loadpin_dir,
>+					(void *)LOADPIN_DM_VERITY, &loadpin_dm_verity_ops);
>+	if (IS_ERR(dentry)) {
>+		pr_err("LoadPin: could not create securityfs entry 'dm-verity': %d\n",
>+		       PTR_ERR(dentry));
>+		return PTR_ERR(dentry);
>+	}
>+
>+	return 0;
>+}
>+
>+fs_initcall(init_loadpin_securityfs);
>+
>+#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
>+
> /* Should not be mutable after boot, so not listed in sysfs (perm =3D=3D=
 0)=2E */
> module_param(enforce, int, 0);
> MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");

Otherwise looks good! The only other thing I can think of is pondering mor=
e about more carefully failing closed=2E E=2Eg=2E instead of just throwing =
away all the other hashes on a file load failure, maybe lock out future att=
empts to set it too? I'm not sure this is actually useful, though=2E :P it =
shouldn't be possible to corrupt the file, etc=2E But in the universe where=
 things like DirtyCOW happens, I've gotten even more paranoid=2E ;)

--=20
Kees Cook

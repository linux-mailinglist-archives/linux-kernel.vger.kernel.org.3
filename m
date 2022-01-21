Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4FB495C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379619AbiAUI6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:58:43 -0500
Received: from linux.microsoft.com ([13.77.154.182]:49218 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiAUI6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:58:38 -0500
Received: from machine.localnet (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 722ED20B6C61;
        Fri, 21 Jan 2022 00:58:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 722ED20B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642755518;
        bh=WbOLIRm6CwlXPDaoqOPOSwuwUAxz//nxPmXnsK4U1t8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gBJfkgTtdT4cMk6aQoitHvxKSumu/p36mNUFvRFM/x9k1Wm3sIjKyVXch78WUKdDP
         Ip87j6Z2hgmYjkb7+X6UlXaIPib9/WxhqCNnaAZ0+W+NoZqm425ukfSXntNDOtT0kY
         JipKhMdFGx9EBRSmOFya9QncgjLb0TnOBmHjYS6c=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH v3 2/2] security/inode.c: Add capabilities file.
Date:   Fri, 21 Jan 2022 09:58:34 +0100
Message-ID: <7787651.jkfHb4QSSr@machine>
In-Reply-To: <20220120180116.167702-3-flaniel@linux.microsoft.com>
References: <20220120180116.167702-1-flaniel@linux.microsoft.com> <20220120180116.167702-3-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Le jeudi 20 janvier 2022, 19:01:16 CET Francis Laniel a =E9crit :
> This new read-only file prints the capabilities values with their names:
> cat /sys/kernel/security/capabilities
> 0       CAP_CHOWN
> 1       CAP_DAC_OVERRIDE
> ...
> 40      CAP_CHECKPOINT_RESTORE
>=20
> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> ---
>  security/inode.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/security/inode.c b/security/inode.c
> index 6c326939750d..cef78b497bab 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -21,6 +21,7 @@
>  #include <linux/security.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/magic.h>
> +#include <linux/capability.h>
>=20
>  static struct vfsmount *mount;
>  static int mount_count;
> @@ -328,6 +329,19 @@ static const struct file_operations lsm_ops =3D {
>  };
>  #endif
>=20
> +static struct dentry *capabilities_dentry;
> +static ssize_t capabilities_read(struct file *unused, char __user *buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	return simple_read_from_buffer(buf, count, ppos, cap_string,
> +				       strlen(cap_string));
> +}
> +
> +static const struct file_operations capabilities_ops =3D {
> +	.read =3D capabilities_read,
> +	.llseek =3D generic_file_llseek,
> +};
> +
>  static int __init securityfs_init(void)
>  {
>  	int retval;
> @@ -345,6 +359,8 @@ static int __init securityfs_init(void)
>  	lsm_dentry =3D securityfs_create_file("lsm", 0444, NULL, NULL,
>  						&lsm_ops);
>  #endif
> +	capabilities_dentry =3D securityfs("capabilities", 0444, NULL, NULL,
> +					 capabilities_ops);

Sorry, I sent the old version of the patch and did not fixup this...
Kernel robot kindly show me this error.
I swear the output in the cover letter was done on the compiled kernel with=
in=20
a VM.

I will send a v4 correcting this but I will wait to get some reviews on v3 =
to=20
not send to not generate too much traffic here.

>  	return 0;
>  }
>  core_initcall(securityfs_init);

Best regards.



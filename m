Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF0D5AFF6B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiIGImj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiIGIm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:42:29 -0400
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33265A405C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662540030;
        bh=y4kIgtQPtGcaTLix7/b9UgIvzCzVlz8RYoCegiAKrYs=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=hIO/Z1DmPUFOCz8BjDF0Qi4lhs9zLjoYX8GefqloUrwyMQ7qcjaWMt0Nq7oB7P72g
         IbxI7TaFGTm2XnYc7q2iKQo6hWIHgxu0rqK1BR5vgm5XafdaVUGgozbR0pu24GSTrP
         5goEZlKOeii+lxk+wPx+j7ygpj7eIcdxQplHoUO0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.32.110.9] ([143.244.36.59]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbg4-1omGzi1NKW-00L1Xn; Wed, 07
 Sep 2022 10:40:30 +0200
Message-ID: <367f52c9-f224-c538-ff74-10ef88dd1f2c@gmx.com>
Date:   Wed, 7 Sep 2022 08:40:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] ntfs3: fix junction point resolution
To:     Daniel Pinto <danielpinto52@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
References: <7839ac04-f93c-a897-70eb-2505d72f936c@gmail.com>
From:   "Artem S. Tashkinov" <aros@gmx.com>
In-Reply-To: <7839ac04-f93c-a897-70eb-2505d72f936c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oqSOKwdeWYSlFHlzsA7+XdvMFfOpV7akyDQjBUZ8/fAZQ9vrA9B
 Jb6RXNmX7TYwofEIs03WjNyXTDxu5N8d3C9oMqX1aZAVRnf7/6LkKSmRYf6Ye9imtL7emcq
 q3SY/DHNemLlecEuZSCCFDbBEPJTvBs9bp6r1Xx/3c8uARiURIs0BmKeULNPuprMWaIwPsN
 4EiXZteol1vrg6ju9kwIw==
X-UI-Out-Filterresults: junk:10;V03:K0:bK9tjBTUnvA=:DiSuk0YH4yc0su7DdKsZumFJ
 nMhgEt/QEW6g0ixAyG8Jht7kCrJTQHQhetT+nBEQ+rps0sSfRHLmWfEiKTm7/Mgy21dKbtqMl
 PLnGQeJ0Fcp3dUBGPB/F7+RTfwqnjTjCoQEP0zj87qTFQQH4PiwGmpiiA9Z4deoGTaliwIT75
 vHgPlmKlNEd5r2Q+Hmw1djGTiWIgin4qjYcelbCnnOUPrQz4XEfU6PJddcxJWo3uWMg27lOcf
 lU7Kr6GcaozVeDBWTUo8JAeXCh6agwLPvw5PTk7N/SdFIP1pJeEyvjyfGJXJ3RHttRRaRqQIT
 Hh3Sb0zqxWWvM6mW2CuoDUQBNODAjIC9SlcBboFd5sT7LvG1mKXYpmptRXSeEcCHQB3RvnIkb
 Khvsgsf/5dAqrtcD/vlpoubzqwLscUr12zWZk8cX8i9fY0dzA3X4cWWYWgXF9aPvjtYYUWzOc
 TDZq9uccAXj9e119R3h8UxOMU1PzNNQLt+cpC5KYqaRVJ8xPruZfp+0eBIfVpvzPIWw6MnVIO
 vYIK4Tl3mNObxDCyvvAm6v5wWMV/r2RHZAficKPg1FOa3LPE5iMpasbcis60x14N6oCV1j5M3
 lS6z/lrz0OKoMC92z1KzPZzlfBz1qPFyopHVwF4BQGRwG4irKuUrAHAYppVZ/iD7Du1IUAWJk
 +ogGjTniK7qcn53iPAVOie1zGNP7SaC371TAT50/VoaQPg0hnfwxb4xlRPgsS4PSIfL908NA2
 C4yq+7Q3UOT9jLGuG97RbOef1sosjZg64vGQLPk3NrV/0Gf3EvNN2tZVXdAjuc4/WY4FcwvJj
 NAbA+JQIdEoEkdl+3BQDYq3EyzNrv/vLqDLsAR7WSHUAMU6FKujpUlxE22XC02kLY1MDbfjy+
 iERMYNczs0hiCnyEGhbI3/svCnuU3vyLgplRDSDxptV4LRmi4aVlw4TOQIhjeQci7s1YviESL
 IDK0mDNmw+e4i0ACVkZf8COdn7WMjoLC4tBa1w2F7tNpynzenJZQzEqCGUsD8eez/MX87X+nt
 700Z1s7HtMFasPtN+OmlhFYxptGtSuf6F2hbljjLYXK4DWWkYMjllBnY7hRIBPj/5kLF0EPAS
 rQvmQLcH9w4RHFlnhJE27Spq8qSXCA1g4g7/Dmjd7uqoqJG44Jm/tZ7rBedu2Iu/gsXd4idcF
 gEHXrRJLDhItb8xLFZ9XRmXgE2Kgi8Sd/shLEQgkxTPl6w==
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_BL_SPAMCOP_NET,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/22 01:45, Daniel Pinto wrote:
> The ntfs3 file system driver does not convert the target path of
> junction points to a proper Linux path. As junction points targets
> are always absolute paths (they start with a drive letter), all
> junctions will result in broken links.
>
> Translate the targets of junction points to relative paths so they
> point to directories inside the mounted volume. Note that Windows
> allows junction points to reference directories in another drive.
> However, as there is no way to know which drive the junctions refer
> to, we assume they always target the same file system they are in.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D214833
> Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
> ---
>   fs/ntfs3/inode.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 101 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index 51363d4e8636..f7e8876f56d3 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1749,7 +1749,101 @@ void ntfs_evict_inode(struct inode *inode)
>   	ni_clear(ntfs_i(inode));
>   }
>
> -static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer=
,
> +/*
> + * ntfs_translate_junction
> + *
> + * Translate a Windows junction target to the Linux equivalent.
> + * On junctions, targets are always absolute (they include the drive
> + * letter). We have no way of knowing if the target is for the current
> + * mounted device or not so we just assume it is.
> + */
> +static int ntfs_translate_junction(const struct super_block *sb,
> +				   const struct dentry *link_de, char *target,
> +				   int target_len, int target_max)
> +{
> +	int tl_len, err =3D target_len;
> +	char *link_path_buffer =3D NULL, *link_path;
> +	char *translated =3D NULL;
> +	char *target_start;
> +	int copy_len;
> +
> +	link_path_buffer =3D kmalloc(PATH_MAX, GFP_NOFS);
> +	if (!link_path_buffer) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
> +	/* Get link path, relative to mount point */
> +	link_path =3D dentry_path_raw(link_de, link_path_buffer, PATH_MAX);
> +	if (IS_ERR(link_path)) {
> +		ntfs_err(sb, "Error getting link path");
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	translated =3D kmalloc(PATH_MAX, GFP_NOFS);
> +	if (!translated) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Make translated path a relative path to mount point */
> +	strcpy(translated, "./");
> +	++link_path;	/* Skip leading / */
> +	for (tl_len =3D sizeof("./") - 1; *link_path; ++link_path) {
> +		if (*link_path =3D=3D '/') {
> +			if (PATH_MAX - tl_len < sizeof("../")) {
> +				ntfs_err(sb, "Link path %s has too many components",
> +					 link_path);
> +				err =3D -EINVAL;
> +				goto out;
> +			}
> +			strcpy(translated + tl_len, "../");
> +			tl_len +=3D sizeof("../") - 1;
> +		}
> +	}
> +
> +	/* Skip drive letter */
> +	target_start =3D target;
> +	while (*target_start && *target_start !=3D ':')
> +		++target_start;
> +
> +	if (!*target_start) {
> +		ntfs_err(sb, "Link target (%s) missing drive separator", target);
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Skip drive separator and leading /, if exists */
> +	target_start +=3D 1 + (target_start[1] =3D=3D '/');
> +	copy_len =3D target_len - (target_start - target);
> +
> +	if (PATH_MAX - tl_len <=3D copy_len) {
> +		ntfs_err(sb, "Link target %s too large for buffer (%d <=3D %d)",
> +			 target_start, PATH_MAX - tl_len, copy_len);
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	/* translated path has a trailing / and target_start does not */
> +	strcpy(translated + tl_len, target_start);
> +	tl_len +=3D copy_len;
> +	if (target_max <=3D tl_len) {
> +		ntfs_err(sb, "Target path %s too large for buffer (%d <=3D %d)",
> +			 translated, target_max, tl_len);
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> +	strcpy(target, translated);
> +	err =3D tl_len;
> +
> +out:
> +	kfree(link_path_buffer);
> +	kfree(translated);
> +	return err;
> +}
> +
> +static noinline int ntfs_readlink_hlp(const struct dentry *link_de,
> +				      struct inode *inode, char *buffer,
>   				      int buflen)
>   {
>   	int i, err =3D -EINVAL;
> @@ -1892,6 +1986,11 @@ static noinline int ntfs_readlink_hlp(struct inod=
e *inode, char *buffer,
>
>   	/* Always set last zero. */
>   	buffer[err] =3D 0;
> +
> +	/* If this is a junction, translate the link target. */
> +	if (rp->ReparseTag =3D=3D IO_REPARSE_TAG_MOUNT_POINT)
> +		err =3D ntfs_translate_junction(sb, link_de, buffer, err, buflen);
> +
>   out:
>   	kfree(to_free);
>   	return err;
> @@ -1910,7 +2009,7 @@ static const char *ntfs_get_link(struct dentry *de=
, struct inode *inode,
>   	if (!ret)
>   		return ERR_PTR(-ENOMEM);
>
> -	err =3D ntfs_readlink_hlp(inode, ret, PAGE_SIZE);
> +	err =3D ntfs_readlink_hlp(de, inode, ret, PAGE_SIZE);
>   	if (err < 0) {
>   		kfree(ret);
>   		return ERR_PTR(err);
>

The patch works here, thanks a ton. Tested-by me.

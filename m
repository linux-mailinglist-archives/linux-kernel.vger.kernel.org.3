Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA305930E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiHOOm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiHOOmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:42:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79B71572D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:42:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t5so9826005edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jof2N1iEfYV37LDrPYxrY/5EEQHPjeHoyCRHq5VfC5Y=;
        b=mpFtgAILA8kt5KRom+uJfi10GVXDXshLvnbM927dyX9LZx2Fx6wyB+t4jaxV5GaF9l
         0hOb9Jza9cqMXO7fjZAZVLg3iCclMkphv+sC1afIiD7ev2kgDkuaHPOQHR8NV1n+TIBz
         s3Ond8NPtbCP3gHnfwGDCwj2lTL1txPQzvZ9004RkOGqo2vA5IZKT+SBqwgX17rRKwT1
         NEMAAjSHJq/bV5GySyPsKC1E5h1W7kD99dd7URzsUhZteYRhrl2xUlezQXh0vgTJ4/yf
         gMJqyfOda9AmujvEyNztK3JKUfbdK3UgA0LegYEEHtaNsHgaD2/KSR4FNFTBB8sHUUBh
         pGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jof2N1iEfYV37LDrPYxrY/5EEQHPjeHoyCRHq5VfC5Y=;
        b=isxF4iZZVHxld22pFecoVKfSlOHjmiB7Ybmc+Y1Uv8nH6ck6F5djK2CFs83e0u/S1F
         3ocXkVvtPl5j4aDts4qNJl0bt5810XFmY+4nl63fHV7Pzpd2keHFnfX3BdyCngoJ23HS
         +gVVMS+mSq6MVdRmvvgvA5qASryVxSv50pokPScnuZMEQfgPQBPjdwKFUCKvKRgKUu/q
         GypgLhO+N1E/ZQyYLE546EEmeTi/rbz1gPxaRsVPDFRD30CnIdpCavGh7DQjJJcto8e5
         RWdozKPmpNRIj68jn/sLePbSNPgIZXd5VMf9D9Cm3nhnkvBmOIrD1H80+nCCEBMCjTdx
         HYsw==
X-Gm-Message-State: ACgBeo12Pz/zvMfzKLoS3rSR8zlQvHNht0C1gIjQBtZxdG9/VkoZkWzV
        E0vQBvx248Ksw07ytHmqOjY=
X-Google-Smtp-Source: AA6agR7bd/zGLA4ALKllKHzRtAchu874EwVSeNFi/lTGp5/Hqq/FSE+pkXIVmaHF4BvAFSS+xkPgNw==
X-Received: by 2002:a05:6402:50cb:b0:440:87d4:3ad2 with SMTP id h11-20020a05640250cb00b0044087d43ad2mr14875248edb.219.1660574542520;
        Mon, 15 Aug 2022 07:42:22 -0700 (PDT)
Received: from opensuse.localnet (host-95-250-231-56.retail.telecomitalia.it. [95.250.231.56])
        by smtp.gmail.com with ESMTPSA id d20-20020aa7d5d4000000b0043c92c44c53sm6651235eds.93.2022.08.15.07.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:42:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com,
        zhaoxiao <zhaoxiao@uniontech.com>
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhaoxiao <zhaoxiao@uniontech.com>, ira.weiny@intel.com
Subject: Re: [PATCH] afs: convert kmap() to kmap_local_page() in mntpt.c
Date:   Mon, 15 Aug 2022 16:42:19 +0200
Message-ID: <1752846.TLkxdtWsSY@opensuse>
In-Reply-To: <20220812080432.14909-1-zhaoxiao@uniontech.com>
References: <20220812080432.14909-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=C3=AC 12 agosto 2022 10:04:32 CEST zhaoxiao wrote:
> kmap() is being deprecated in favor of kmap_local_page().
>=20
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap's pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled.  Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, the
> kernel virtual addresses are restored and are still valid.
>=20
> Since its use in mntpt.c is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() with kmap_local_page() in mntpt.c.
>=20
> Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.
>=20
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
> ---
>  fs/afs/mntpt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
> index 97f50e9fd9eb..7e3cacb11780 100644
> --- a/fs/afs/mntpt.c
> +++ b/fs/afs/mntpt.c
> @@ -132,11 +132,11 @@ static int afs_mntpt_set_params(struct fs_context *=
fc,
> struct dentry *mntpt) if (IS_ERR(page))
>  			return PTR_ERR(page);
>=20
> -		buf =3D kmap(page);
> +		buf =3D kmap_local_page(page);
>  		ret =3D -EINVAL;
>  		if (buf[size - 1] =3D=3D '.')
>  			ret =3D vfs_parse_fs_string(fc, "source", buf,=20
size - 1);
> -		kunmap(page);
> +		kunmap_local(buf);
>  		put_page(page);
>  		if (ret < 0)
>  			return ret;
> --
> 2.20.1

I doubt that zhaoxiao is your legal name.
If I'm not wrong, can you please submit a v2 with the name that you use to=
=20
sign documents with legal value? Otherwise, please discard this warning.

Aside from the above, this conversion looks good to me, so feel free to=20
forward my tag to next version...

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

=46abio

P.S.: I'm adding Ira to the list of recipients. Ira and I have been
working through converting kmap() calls to kmap_local_page(). Please let Ir=
a=20
or me know if you plan on tacking more conversions so we can mark it
off the list and avoid duplicate works.



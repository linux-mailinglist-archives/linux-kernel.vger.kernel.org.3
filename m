Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84704E49B5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbiCVXkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241442AbiCVXjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044B432996;
        Tue, 22 Mar 2022 16:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 903A261252;
        Tue, 22 Mar 2022 23:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08B1C340F2;
        Tue, 22 Mar 2022 23:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647992301;
        bh=Rl6UbQHgIDuIZXTEr3KxFphz2xVsXFACCwsYJCc9Foc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=RMkO1k1uRrd3MYz1fVVoo8rvu6nTTwWo663BI3cKuT52leGP+D0YnSctOwlj21wZu
         o+oAFV22egqV5SDCINjimBkejMfAd5tZz4FE05WN65Jgumb933lMsxuxyN+9P58iuR
         9O5/gtgSS3oM3/AnB8jDcBb7FVMeNj44bhEp6ipa5Xm13MgGv9XHEgn12f21SswIlw
         u9oNU59NRqSG+grclBXTDtRZ8uwMxqX/baYRfLQYGgpjpPlH15jXBSwb2oEqQdJrzt
         mJ7ThjNTXVHz9oyrZGrPnp2gYtN20Kq8MSziJnyhwGnbDmr6PSno50pbp3PY6d/DD1
         HUN5LWQuQv0tA==
Received: by mail-wr1-f42.google.com with SMTP id u3so2414976wrg.3;
        Tue, 22 Mar 2022 16:38:20 -0700 (PDT)
X-Gm-Message-State: AOAM531DmzxbkmYjBslnNSfrQa4e8zTS7i6KZ8Ur1eYXRhkgvqrrzT9x
        aAW3oU+EsS3ZeY8/EmPKdvcKkcMV5U7ECEsx5kY=
X-Google-Smtp-Source: ABdhPJzcg278ZxDjnI+PAPQsTD7HvxcDXuSxkbmldiXfC2g12QTbS7y7QzXW7ZoN8ScCP1YK8myMYXNVUavbho2ce9I=
X-Received: by 2002:a5d:47a5:0:b0:203:d4fd:4653 with SMTP id
 5-20020a5d47a5000000b00203d4fd4653mr24623747wrb.229.1647992299262; Tue, 22
 Mar 2022 16:38:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:2c1:0:0:0:0 with HTTP; Tue, 22 Mar 2022 16:38:18
 -0700 (PDT)
In-Reply-To: <f8f1f383c4533a91a6025b1db5827ed6aaab002f.1647980983.git.christophe.jaillet@wanadoo.fr>
References: <f8f1f383c4533a91a6025b1db5827ed6aaab002f.1647980983.git.christophe.jaillet@wanadoo.fr>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 23 Mar 2022 08:38:18 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9uGsASkCSuKS7NW0MsME2n9Bhk8Sf=L0_uvs1qXU1wLg@mail.gmail.com>
Message-ID: <CAKYAXd9uGsASkCSuKS7NW0MsME2n9Bhk8Sf=L0_uvs1qXU1wLg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: Remove a redundant zeroing of memory
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-03-23 5:29 GMT+09:00, Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
> fill_transform_hdr() already call memset(0) on its 1st argument, so there
> is no need to clear it explicitly before calling this function.
>
> Use kmalloc() instead of kzalloc() to save a few cycles.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Alternatively, fill_transform_hdr() has only one caller. So its memset()
> could be removed instead and this kzalloc() left as is.
I prefer this. Could you update the patch ?

Thanks!
> ---
>  fs/ksmbd/smb2pdu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index bcb98109bac9..0e4f819e5859 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -8434,7 +8434,7 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
>  	if (ARRAY_SIZE(iov) < rq_nvec)
>  		return -ENOMEM;
>
> -	work->tr_buf = kzalloc(sizeof(struct smb2_transform_hdr) + 4,
> GFP_KERNEL);
> +	work->tr_buf = kmalloc(sizeof(struct smb2_transform_hdr) + 4,
> GFP_KERNEL);
>  	if (!work->tr_buf)
>  		return rc;
>
> --
> 2.32.0
>
>

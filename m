Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8C94FEB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiDLX35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiDLX20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:28:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EA5A0BDE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:32:16 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b21so114200ljf.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FsJYLxOhIxt3rQLA+O/P6SUgZEOQeFz25qq7q/fcHi8=;
        b=lTexwf1HxdZGAcVTWoD0ugTlac61PvCWW3F8HQtXKOmX3JezT10nb4HZtZdWAwyAwK
         JAdEJHFK9RQ/adANwbDQRAaFvoWqugCSX+rmZpNxYgLLIvBDFcubPsVUTYWzT2US476a
         Kn4Syv5auhCIo1tQNRvXnWTtVK/P4WbvG+TOUgy5Q2N1L1Wfqdfw5uxG1aLNJA2OceYV
         8aIWX1aPlJcZRtT6uyUE55A1cT1nC1sNHsziyzGUCqvrktoKiX14f2a20EX+erSlVdie
         Ho4JypLz4jjjI+vJwFUGBiYcsPyGkJJC2E13XFQoTGMcO9aL6gUabeo6bomqYDjTn/XL
         MfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FsJYLxOhIxt3rQLA+O/P6SUgZEOQeFz25qq7q/fcHi8=;
        b=6zwdPRWrWLK9+5oQRRs8IhALXvlc3PZwsZuRI+VtLuYqGMbkb3kQCY/1SEsMXc+4no
         EVF+zZCFxwi2I+vBrUUWFzRJtl6/VAkbtDrtn2vkkppEvbNUCxn5ej2+o5PmUuonBuxa
         pyFj2AOAouK0TPgAjnqhesVlOshxGjRaGrt3aVBvEDSP1wKevA/foQiXYpZ9audtl8pi
         st9gOEMxGmvHeE3kY4zkmrpJSbB+7dPWCQmAGFGaQ/LVGWYVdryvZV3AYVBYZvm3eUQz
         SCFh+Thphu70mbgKtP+L6zT+0QKnZJ+13XHKFf0dK6Ob/H+4NpSDUQtGILEzv5YaPujs
         e1Dg==
X-Gm-Message-State: AOAM532pGGeGuf2P7lexUTAqFuHjTMNrWuxe72Qyp/uqhkj+VMKrAcU9
        h5DtiiupJ0MTo0zT48ViQcMkUNJYyHcbCFziXQ8=
X-Google-Smtp-Source: ABdhPJyotQc5lx8nzjPYQvWzHV1dNOIG+D0mdNU459MdDr2om1lc6UhX9ewBqaAIaX3WVyEVwQZVknBGkIfV+hqY9gg=
X-Received: by 2002:a05:651c:ba0:b0:24b:6046:3f24 with SMTP id
 bg32-20020a05651c0ba000b0024b60463f24mr8499467ljb.460.1649802734687; Tue, 12
 Apr 2022 15:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220412043823.57037-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20220412043823.57037-1-harshit.m.mogalapalli@oracle.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 12 Apr 2022 17:32:03 -0500
Message-ID: <CAH2r5mvBH8wO9rS2UwCpgjbhcLp89-RLbr1wxK76Pj=OprKwOA@mail.gmail.com>
Subject: Re: [PATCH] cifs: potential buffer overflow in handling symlinks
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <sfrench@samba.org>,
        Stefan Metzmacher <metze@samba.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wouldn't it be easier and clearer to do the compare vs the maximum len ie

if (link_len > CIFS_MF_SYMLINK_LINK_MAXLEN)

instead of

if (link_len > buf_len - CIFS_MF_SYMLINK_LINK_OFFSET)

since buf_len is  CIFS_MF_SYMLINK_FILE_SIZE and looking at link.c line
26 and 27 this means we can use CIFS_MF_SYMLINK_LINK_OFFSET for the
comparison:

#define CIFS_MF_SYMLINK_LINK_MAXLEN (1024)
#define CIFS_MF_SYMLINK_FILE_SIZE \
        (CIFS_MF_SYMLINK_LINK_OFFSET + CIFS_MF_SYMLINK_LINK_MAXLEN)

On Tue, Apr 12, 2022 at 1:01 AM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> Smatch printed a warning:
>         arch/x86/crypto/poly1305_glue.c:198 poly1305_update_arch() error:
>         __memcpy() 'dctx->buf' too small (16 vs u32max)
>
> It's caused because Smatch marks 'link_len' as untrusted since it comes
> from sscanf(). Add a check to ensure that 'link_len' is not larger than
> the size of the 'link_str' buffer.
>
> Fixes: c69c1b6eaea1 ("cifs: implement CIFSParseMFSymlink()")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  fs/cifs/link.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/cifs/link.c b/fs/cifs/link.c
> index 852e54e..ebfedae 100644
> --- a/fs/cifs/link.c
> +++ b/fs/cifs/link.c
> @@ -85,6 +85,9 @@
>         if (rc != 1)
>                 return -EINVAL;
>
> +       if (link_len > buf_len - CIFS_MF_SYMLINK_LINK_OFFSET)
> +               return -EINVAL;
> +
>         rc = symlink_hash(link_len, link_str, md5_hash);
>         if (rc) {
>                 cifs_dbg(FYI, "%s: MD5 hash failure: %d\n", __func__, rc);
> --
> 1.8.3.1
>


-- 
Thanks,

Steve

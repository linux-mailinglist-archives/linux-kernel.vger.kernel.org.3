Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA9E55DCB3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345454AbiF1MHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345373AbiF1MHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4114B33364
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656418012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1kd7GH8+lVH8XJU2bub/L8ZRbbYTkBopp5Wt8QcoRg=;
        b=BoXLZmi+BVONwCBMqY6hoU7Ff4hLkUEom6MPLkxbdWao4OLd0o7P12YNpRkOHP/a+isSKJ
        CHXSEocMlz6QOv/YFGHzndRNceK4XRDNU/NI9M8nZzkGHo/mnld3WD6xi2yoh8hE9ZEHAN
        T27ggGe5JvzpKou4ZvJ8ROoDnBdf4zQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-cJS-dI6KNUCtOauQ1YeEUQ-1; Tue, 28 Jun 2022 08:06:51 -0400
X-MC-Unique: cJS-dI6KNUCtOauQ1YeEUQ-1
Received: by mail-wm1-f69.google.com with SMTP id m20-20020a05600c4f5400b003a03aad6bdfso4931764wmq.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X1kd7GH8+lVH8XJU2bub/L8ZRbbYTkBopp5Wt8QcoRg=;
        b=rv1TxXa2ey2Gw2OaAIbitcG0vqkv043q5gOjTzpf1ZQdprj5dxAtRhAp5olVx/0OCZ
         YSL1Xaugsjb/pEDWVIUcSTtWK+MYY94c3s2h6FqCDwz46pU/o2jkfspEmjvOVgluhnUx
         ffkMvJ7s/zzR4hVkt2HbMk+iuHB8gJjGqCMPMWT/v3NoVvMX0AbGP1BWmeY3G4FBzauB
         34d3MSyImGic/Jthaigd/dve80TfKs5VyHv9JOUptjNmy4wGV2wubLrEotOEue/hgYlh
         aYqEQHdDMmJKTYDvriGcFeg9buv5zzKbv5IJZ+wDSmAKvKxu+5As8RHP0jk+usbD0pjo
         8AIQ==
X-Gm-Message-State: AJIora954nf/POR1CbwX38QCcuy8b9CZSGta6qcKUUI2LbrXMmZwR90F
        zXyo2cl8MsyNdJ2LsSIbVqihhaGkygjBCQpz/zXcWohFIB8xMTOkpYlsEZnm03Yq6O3VrTvKsIg
        O47e8nqpqTid53MAJ5OkOM0mcPIAh5HjQ8N7c0T2Q
X-Received: by 2002:a7b:c4ce:0:b0:3a0:2ac4:3233 with SMTP id g14-20020a7bc4ce000000b003a02ac43233mr25474233wmk.92.1656418010520;
        Tue, 28 Jun 2022 05:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uEXqbE6Sx0oikJPL2taoS9a5Pn8LiRB1rZvvRDicOju3qGxubgDoT47Zm1luHzWqTldwi7wRNsqyLrmcEcJcM=
X-Received: by 2002:a7b:c4ce:0:b0:3a0:2ac4:3233 with SMTP id
 g14-20020a7bc4ce000000b003a02ac43233mr25474206wmk.92.1656418010273; Tue, 28
 Jun 2022 05:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220628055949.566089-1-dzm91@hust.edu.cn>
In-Reply-To: <20220628055949.566089-1-dzm91@hust.edu.cn>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 28 Jun 2022 14:06:38 +0200
Message-ID: <CAHc6FU4PR9hwBY1NxdyAMAAh4rY+KHvO26PTSsDBXJ=yHK2msQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix overread in the strlcpy of init_names
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jean Delvare <khali@linux-fr.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongliang Mu,

On Tue, Jun 28, 2022 at 8:10 AM Dongliang Mu <dzm91@hust.edu.cn> wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
>
> In init_names, strlcpy will overread the src string as the src string is
> less than GFS2_FSNAME_LEN(256).
>
> Fix this by modifying strlcpy back to snprintf, reverting
> the commit 00377d8e3842.

... if the source string isn't NULL-terminated. But in that case, the
code will still do the same thing with this patch. In other words,
this doesn't fix anything. So let's check for NULL termination
instead.

Thanks,
Andreas

> Fixes: 00377d8e3842 ("[GFS2] Prefer strlcpy() over snprintf()")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  fs/gfs2/ops_fstype.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> index c9b423c874a3..ee29b50d39b9 100644
> --- a/fs/gfs2/ops_fstype.c
> +++ b/fs/gfs2/ops_fstype.c
> @@ -383,8 +383,8 @@ static int init_names(struct gfs2_sbd *sdp, int silent)
>         if (!table[0])
>                 table = sdp->sd_vfs->s_id;
>
> -       strlcpy(sdp->sd_proto_name, proto, GFS2_FSNAME_LEN);
> -       strlcpy(sdp->sd_table_name, table, GFS2_FSNAME_LEN);
> +       snprintf(sdp->sd_proto_name, GFS2_FSNAME_LEN, "%s", proto);
> +       snprintf(sdp->sd_table_name, GFS2_FSNAME_LEN, "%s", table);
>
>         table = sdp->sd_table_name;
>         while ((table = strchr(table, '/')))
> --
> 2.35.1
>


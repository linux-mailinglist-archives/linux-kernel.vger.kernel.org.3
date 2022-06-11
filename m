Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2A2547176
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 04:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349006AbiFKC4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 22:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiFKC4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 22:56:40 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B579441633
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 19:56:39 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r206so1486476oib.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 19:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jctRilESZhviTKf/9k9B8kFmXNclCH0IwN1Q3ytmaBU=;
        b=RiO89JynyAWJauusXlni0Uw+tWhpwg6Zkd/CQF2VrK1+ef2N8wg3fHJ5mz1wKCoXks
         75C9yB/WN8MCz6x126AgrvnPwX7AKFY26wYhjdwS4oGMWWvFyPWBiGe4m78KzswP+5xc
         ciRy8KqsJ2OyOiZwOmOwBl1qCSUY1ppYXS48yE5/CSFUsteVQHDqrwd3oonh2cAmctsS
         C5A0jAQ4he2iR630XM2YxQI4QiUvQ3GtK/JM88o41TqictJ97jdfFeIdmzwzIBTUAU62
         XypxGesXdr9RRdzlRkeAU8hWe28YII5zuuiUMVXBO6LaJPsnUX2hKRZhyHnOtCL9gE1s
         qC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jctRilESZhviTKf/9k9B8kFmXNclCH0IwN1Q3ytmaBU=;
        b=LKFop8CkxOm6iDsIYehJJM6T06eV/S3EPCakejMrM/DmUwFxiErCPvZjQ6HZbrM4Li
         hGlPT6Q36eTZT9BAVlKIkEfQ/NQDtT7GJUZM9Y7CyoGPOZuizDrIGGTyQNSXsfqst3i4
         kIj8yYLGijXlyjN5qzkOgZXQYYLNAhnxnPf9lKWL+y2JqG0lXj122CxFj327e2MTq/4G
         88UXwAZ/WJCLJ6ECPwJTKWBlcGEn/N00mge4db19YvKr61lmT04QwXCsdvmosUzRia4M
         0XgZ5S+mF6Vvr0dODOo4LFeO60SDzZeLe0drl4oB1Z9z8/Sex9jxftBuQcYpcahzBPpR
         7Yjg==
X-Gm-Message-State: AOAM532K3QsdWj717MuNi9L5SvravSdz3mxulQL00cR0aJhx+UG9f1sF
        nYX+uZRxAmkiy9asTuaRLLdJjMSXl8aahFACeHQ=
X-Google-Smtp-Source: ABdhPJwagasm37nc90xZijauKcqv8CyeDsKyStRUZS9nTXaJal8nJwj3QxzCRfvTuFSFXt9jQfe2BKsFexjpeVvOW/o=
X-Received: by 2002:aca:6c5:0:b0:325:5bce:bbc1 with SMTP id
 188-20020aca06c5000000b003255bcebbc1mr1434585oig.221.1654916198714; Fri, 10
 Jun 2022 19:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220506034656.50038-1-jjm2473@gmail.com> <14b2ae23-2f7b-401a-dcee-cc6114849022@paragon-software.com>
 <CAP_9mL7O7YyW56HBorZ7727m22NjbQcfcu_J4_XOBoXigQvGCg@mail.gmail.com> <e40981eb-8243-4bb1-44ef-5393cc464c03@paragon-software.com>
In-Reply-To: <e40981eb-8243-4bb1-44ef-5393cc464c03@paragon-software.com>
From:   =?UTF-8?B?57uD5Lqu5paM?= <jjm2473@gmail.com>
Date:   Sat, 11 Jun 2022 10:56:27 +0800
Message-ID: <CAP_9mL45iewg0Y_cDYdNZbv11RZfJtcbOia_GU+9=9paXV7zaQ@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs3: fix null pointer dereference in d_flags_for_inode
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

If ntfs_file_inode_operations is ok for $Extend, that's fine with me.

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
=E4=BA=8E2022=E5=B9=B46=E6=9C=881=E6=97=A5=E5=91=A8=E4=B8=89 00:34=E5=86=99=
=E9=81=93=EF=BC=9A
>
> Hello.
>
> In the end of ntfs_read_mft function we must assign correct i_op:
> inode->i_op =3D &ntfs_dir_inode_operations;
> <...>
> inode->i_op =3D &ntfs_link_inode_operations;
> <...>
> inode->i_op =3D &ntfs_file_inode_operations;
> <...>
> inode->i_op =3D &ntfs_special_inode_operations;
>
> In this if .. else if .. else is an error:
> records in $Extend doesn't get correct i_op.
> This was fixed in my patch.
>
> Line in beginning of ntfs_read_mft function
> inode->i_op =3D NULL;
> triggered null pointer dereference because
> inode->i_op =3D &ntfs_file_inode_operations;
> is missing for records in $Extend.
>
> If I just remove inode->i_op =3D NULL,
> then in i_op will be some previous value.
> Sometimes this value is correct, sometimes it's not.
>
> I'm thankful, that you've spent time to find and debug this issue.
> This was reflected in line Reported-by: Liangbin Lian <jjm2473@gmail.com>
> I hope I've made more clear my previous message.
>
>
> On 5/28/22 16:42, =E7=BB=83=E4=BA=AE=E6=96=8C wrote:
> > Hello.
> > `inode->i_op` already initialized when inode alloc, this bug was
> > introduced by `inode->i_op =3D NULL;`, just delete this line.
> > Please check my patch, maybe it's a better one, I have tested it on my =
project.
> >
> > On 5/26/22 18:23, Almaz Alexandrovich wrote:
> >>
> >> Hello.
> >>
> >> Thank you for reporting this bug.
> >> The bug happens because we don't initialize i_op for records in $Exten=
d.
> >> We tested patch on our side, let me know if patch helps you too.
> >>
> >>       fs/ntfs3: Fix missing i_op in ntfs_read_mft
> >>
> >>       There is null pointer dereference because i_op =3D=3D NULL.
> >>       The bug happens because we don't initialize i_op for records in =
$Extend.
> >>       Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super bloc=
k")
> >>
> >>       Reported-by: Liangbin Lian <jjm2473@gmail.com>
> >>       Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-s=
oftware.com>
> >>
> >> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> >> index 879952254071..b2cc1191be69 100644
> >> --- a/fs/ntfs3/inode.c
> >> +++ b/fs/ntfs3/inode.c
> >> @@ -430,6 +430,7 @@ static struct inode *ntfs_read_mft(struct inode *i=
node,
> >>           } else if (fname && fname->home.low =3D=3D cpu_to_le32(MFT_R=
EC_EXTEND) &&
> >>                      fname->home.seq =3D=3D cpu_to_le16(MFT_REC_EXTEND=
)) {
> >>                   /* Records in $Extend are not a files or general dir=
ectories. */
> >> +               inode->i_op =3D &ntfs_file_inode_operations;
> >>           } else {
> >>                   err =3D -EINVAL;
> >>                   goto out;
> >>
> >>
> >> On 5/6/22 06:46, Liangbin Lian wrote:
> >>> ntfs_read_mft may return inode with null i_op, cause null pointer der=
eference in d_flags_for_inode (inode->i_op->get_link).
> >>> Reproduce:
> >>>    - sudo mount -t ntfs3 -o loop ntfs.img ntfs
> >>>    - ls ntfs/'$Extend/$Quota'
> >>>
> >>> The call trace is shown below (striped):
> >>>    BUG: kernel NULL pointer dereference, address: 0000000000000008
> >>>    CPU: 0 PID: 577 Comm: ls Tainted: G           OE     5.16.0-0.bpo.=
4-amd64 #1  Debian 5.16.12-1~bpo11+1
> >>>    RIP: 0010:d_flags_for_inode+0x65/0x90
> >>>    Call Trace:
> >>>    ntfs_lookup
> >>>    +--- dir_search_u
> >>>    |    +--- ntfs_iget5
> >>>    |         +--- ntfs_read_mft
> >>>    +--- d_splice_alias
> >>>         +--- __d_add
> >>>              +--- d_flags_for_inode
> >>>
> >>> Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
> >>> ---
> >>>    fs/ntfs3/inode.c | 1 -
> >>>    1 file changed, 1 deletion(-)
> >>>
> >>> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> >>> index 9eab11e3b..b68d26fa8 100644
> >>> --- a/fs/ntfs3/inode.c
> >>> +++ b/fs/ntfs3/inode.c
> >>> @@ -45,7 +45,6 @@ static struct inode *ntfs_read_mft(struct inode *in=
ode,
> >>>        struct MFT_REC *rec;
> >>>        struct runs_tree *run;
> >>>
> >>> -     inode->i_op =3D NULL;
> >>>        /* Setup 'uid' and 'gid' */
> >>>        inode->i_uid =3D sbi->options->fs_uid;
> >>>        inode->i_gid =3D sbi->options->fs_gid;

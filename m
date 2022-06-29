Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE7155F2D4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiF2Be3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiF2Be1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:34:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BAA25C7C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:34:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id mf9so29574906ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIhlFiRLTeYDajDFixtlLrmUsyayl0HijGJY+Ov1teI=;
        b=dInfvLhFqD80OSMjcdIXIwxqsZ0OxIRfxIxJKDP2RCtkO7IOfrBejrA454rQqdWxfY
         a5PadiFHJ0qqvhgz17zXlaifLpILDBBcd8CmfH/4Ojlk43kDd5Dq5UuuA89M0z15gr/J
         9OzmnYu3wXd2UPA5kSTBY39kbRTiQuNM6M6tCupdwF6UdlgW0yjDULz6Adw7W+8HkalI
         7pSCWE1WT9OziivUMvmxGOdlEPb5e/XDsK4vtHdCaSeDld7wigZ+t4gS1dVekCQqzMBr
         ey/UfGiNrARgRHfjXH0GLMfYrQzrbEGam+RwSkkXUZ0lUR1J4mroXf/AQW5QJa7QDEuo
         C1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIhlFiRLTeYDajDFixtlLrmUsyayl0HijGJY+Ov1teI=;
        b=5NliE23mONa9fXyj15Ql1TXJ7cABGMPqfaJfANlp+vJsu8O5r9eOD6FOn0/cUTUJ1z
         v283mMzGh2j6tGeqkHIkLyKbLR0A52VThnOYaWEDDIUhq9C8OGX2sShX/WB16hF+aGHN
         PcyN/cAq4ieQzBMsespywnCDhKVxTw7YlBouGf5kKoekBKcyM5b3DsEGfhTh12wTyM12
         3kRi+SKt0PdJlfy0V9BrVihbHx+f4XzDg0POFbJvK5eFY1M4X6l94Fgnx4hE9RXLDJsu
         DbX6s1BmE2NSIbEdIHR4NEDb+sXf83W96JjtnSxs9XKNIPDtwo1moboiL1qHUZgjFxL8
         qHTw==
X-Gm-Message-State: AJIora9sRhjJr5+iDA6gkMTUoW6K0Qc7mxh5Tp5dbD2cT14vK0Juhk5x
        5wpIYYK1oR28QtwKjKwCaz0esI5YUbnIvI0CAFo=
X-Google-Smtp-Source: AGRyM1vVJcyaqr2XFOiRYKIC1my7c8I2SDWqT4BkNkx+WwHN0GJcO5U8wMNfY0dQLa15+dw2e0OBOfRaIEIDTouY7UM=
X-Received: by 2002:a17:907:6ea8:b0:726:a8bb:5a3e with SMTP id
 sh40-20020a1709076ea800b00726a8bb5a3emr883622ejc.753.1656466464303; Tue, 28
 Jun 2022 18:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220628055949.566089-1-dzm91@hust.edu.cn> <CAHc6FU4PR9hwBY1NxdyAMAAh4rY+KHvO26PTSsDBXJ=yHK2msQ@mail.gmail.com>
In-Reply-To: <CAHc6FU4PR9hwBY1NxdyAMAAh4rY+KHvO26PTSsDBXJ=yHK2msQ@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 29 Jun 2022 09:33:43 +0800
Message-ID: <CAD-N9QXikfrnjD-4a8pnLYUFfcm0LdpBaXjO4=CXU5MNS-jvSQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix overread in the strlcpy of init_names
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Bob Peterson <rpeterso@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jean Delvare <khali@linux-fr.org>,
        syzkaller <syzkaller@googlegroups.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, Jun 28, 2022 at 8:06 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> Dongliang Mu,
>
> On Tue, Jun 28, 2022 at 8:10 AM Dongliang Mu <dzm91@hust.edu.cn> wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > In init_names, strlcpy will overread the src string as the src string is
> > less than GFS2_FSNAME_LEN(256).
> >
> > Fix this by modifying strlcpy back to snprintf, reverting
> > the commit 00377d8e3842.
>
> ... if the source string isn't NULL-terminated. But in that case, the
> code will still do the same thing with this patch. In other words,
> this doesn't fix anything. So let's check for NULL termination
> instead.

Partially yes. Even if the source string is NULL-terminated, strlcpy
will invoke memcpy to overread the adjacent memory of source string as
the specified length is longer than source string.

>
> Thanks,
> Andreas
>
> > Fixes: 00377d8e3842 ("[GFS2] Prefer strlcpy() over snprintf()")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  fs/gfs2/ops_fstype.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
> > index c9b423c874a3..ee29b50d39b9 100644
> > --- a/fs/gfs2/ops_fstype.c
> > +++ b/fs/gfs2/ops_fstype.c
> > @@ -383,8 +383,8 @@ static int init_names(struct gfs2_sbd *sdp, int silent)
> >         if (!table[0])
> >                 table = sdp->sd_vfs->s_id;
> >
> > -       strlcpy(sdp->sd_proto_name, proto, GFS2_FSNAME_LEN);
> > -       strlcpy(sdp->sd_table_name, table, GFS2_FSNAME_LEN);
> > +       snprintf(sdp->sd_proto_name, GFS2_FSNAME_LEN, "%s", proto);
> > +       snprintf(sdp->sd_table_name, GFS2_FSNAME_LEN, "%s", table);
> >
> >         table = sdp->sd_table_name;
> >         while ((table = strchr(table, '/')))
> > --
> > 2.35.1
> >
>

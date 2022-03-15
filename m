Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77AA4D9AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348119AbiCOMBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348090AbiCOMBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:01:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BFB52B3C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:59:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w4so23857275edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0IagKtBfxcpixmoMTBMoMWqgkvRfAgiw9IXMcNoH3GM=;
        b=Jc9BG6ebO65hDOwsgATtbOXJvK1Nwh0MvD9yTfeAlBn09fSSqU5uLdc0yYMD/CzYjF
         JnA11+NIRsQUEwt9kiwjEFDlZwfCrWxDFwUDSNYSXIhoDCPaIyZIKuL27gkfcOFZiCQm
         z9FBxmOYVeOM0ikZxPziEZMZ8mdLjim6v/ApfuIpGgWeDuBUmdY0DId/ie9x+DfpIGcg
         nPPGw6ALMItE3tm6tnPloiV4VNVxqYBmbjS9zwf4NDHUirNgj/B5SEw3QIF2tMCvKZ8k
         oMcOJ+Xuc38ORVemUSrVid3OJZTTygqvkM7UeN9391ASp0+4BaJ2h//dGllAYKUp6FA3
         TutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0IagKtBfxcpixmoMTBMoMWqgkvRfAgiw9IXMcNoH3GM=;
        b=yRgRPu/9Qns1V2CJid3NkaikgIzI3sY55fwopxNZSct7O5kyvSDri6kIZJgngXO0bI
         MAYylvbUrW7JlxxbbPVVKQc0kSASOHTQzmK7dK6vDQ8FRgr1XlXdq6pk91PWkNEfSqDz
         iHSS5G95ztttTw7jQoCRNO9QTY9geSzNwmzhkoCCMJK5+70Ft0J91co3Vro4yIFFIJKj
         6kJuLNGZtl5qmY74rGIZoVMEY4qeeMJRRlpD+3+ORbS36oNCJbFoBTCsendj6XwSaBOH
         3BqM3VQfh0aWqD3PW73HDd5mmBhpQofiJ7PKXti6EJho93M4flsRgFtoG2tfBYpBCE4U
         NRtw==
X-Gm-Message-State: AOAM5334rAGn2YZ6iXEntPl3sTfEapsf+bDx+V/9gNF6/nK3cbRjsElc
        NqG6hyvOSwM8+TlUpWmSKHq3U4qs2owoIIUEgRk=
X-Google-Smtp-Source: ABdhPJw3vTWKpyc85/05ZqjGiVLTuKEo7jyXrBXqyusgxTgudMfdBBD+qF4ycHQkWAL3HNHktvM2aSHO8cd+cELAabI=
X-Received: by 2002:a05:6402:5cb:b0:415:e04a:5230 with SMTP id
 n11-20020a05640205cb00b00415e04a5230mr25066821edx.352.1647345595723; Tue, 15
 Mar 2022 04:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220315075152.63789-1-dzm91@hust.edu.cn> <bca8f865-bc3e-44d7-7298-c2c7e8973580@gmail.com>
 <YjBwtqsEOZ5JbqvS@B-P7TQMD6M-0146.local> <8d832e7a-c8da-d2fa-571a-ea150b8deb1b@gmail.com>
In-Reply-To: <8d832e7a-c8da-d2fa-571a-ea150b8deb1b@gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 15 Mar 2022 19:59:26 +0800
Message-ID: <CAD-N9QX2cajf0LXKcOji_Em26-0bw9wfhx7KDV_TLDWhgQ90hQ@mail.gmail.com>
Subject: Re: [PATCH] fs: erofs: remember if kobject_init_and_add was done
To:     Huang Jianan <jnhuang95@gmail.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-erofs@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 7:05 PM Huang Jianan <jnhuang95@gmail.com> wrote:
>
> =E5=9C=A8 2022/3/15 18:55, Gao Xiang =E5=86=99=E9=81=93:
> > On Tue, Mar 15, 2022 at 06:43:01PM +0800, Huang Jianan wrote:
> >> =E5=9C=A8 2022/3/15 15:51, Dongliang Mu =E5=86=99=E9=81=93:
> >>> From: Dongliang Mu <mudongliangabcd@gmail.com>
> >>>
> >>> Syzkaller hit 'WARNING: kobject bug in erofs_unregister_sysfs'. This =
bug
> >>> is triggered by injecting fault in kobject_init_and_add of
> >>> erofs_unregister_sysfs.
> >>>
> >>> Fix this by remembering if kobject_init_and_add is successful.
> >>>
> >>> Note that I've tested the patch and the crash does not occur any more=
.
> >>>
> >>> Reported-by: syzkaller <syzkaller@googlegroups.com>
> >>> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> >>> ---
> >>>    fs/erofs/internal.h | 1 +
> >>>    fs/erofs/sysfs.c    | 9 ++++++---
> >>>    2 files changed, 7 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> >>> index 5aa2cf2c2f80..9e20665e3f68 100644
> >>> --- a/fs/erofs/internal.h
> >>> +++ b/fs/erofs/internal.h
> >>> @@ -144,6 +144,7 @@ struct erofs_sb_info {
> >>>     u32 feature_incompat;
> >>>     /* sysfs support */
> >>> +   bool s_sysfs_inited;
> >> Hi Dongliang,
> >>
> >> How about using sbi->s_kobj.state_in_sysfs to avoid adding a extra mem=
ber in
> >> sbi ?
> > Ok, I have no tendency of these (I'm fine with either ways).
> > I've seen some usage like:
> >
> > static inline int device_is_registered(struct device *dev)
> > {
> >          return dev->kobj.state_in_sysfs;
> > }
> >
> > But I'm still not sure if we need to rely on such internal
> > interface.. More thoughts?
>
> Yeah... It seems that it is better to use some of the interfaces
> provided by kobject,
> otherwise we should still maintain this state in sbi.
>

I am fine with either way. Let me know if you reach to an agreement.

> Thanks,
> Jianan
>
> > Thanks,
> > Gao Xiang
> >> Thanks,
> >> Jianan
> >>
> >>>     struct kobject s_kobj;          /* /sys/fs/erofs/<devname> */
> >>>     struct completion s_kobj_unregister;
> >>>    };
> >>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
> >>> index dac252bc9228..2b48a4df19b4 100644
> >>> --- a/fs/erofs/sysfs.c
> >>> +++ b/fs/erofs/sysfs.c
> >>> @@ -209,6 +209,7 @@ int erofs_register_sysfs(struct super_block *sb)
> >>>                                "%s", sb->s_id);
> >>>     if (err)
> >>>             goto put_sb_kobj;
> >>> +   sbi->s_sysfs_inited =3D true;
> >>>     return 0;
> >>>    put_sb_kobj:
> >>> @@ -221,9 +222,11 @@ void erofs_unregister_sysfs(struct super_block *=
sb)
> >>>    {
> >>>     struct erofs_sb_info *sbi =3D EROFS_SB(sb);
> >>> -   kobject_del(&sbi->s_kobj);
> >>> -   kobject_put(&sbi->s_kobj);
> >>> -   wait_for_completion(&sbi->s_kobj_unregister);
> >>> +   if (sbi->s_sysfs_inited) {
> >>> +           kobject_del(&sbi->s_kobj);
> >>> +           kobject_put(&sbi->s_kobj);
> >>> +           wait_for_completion(&sbi->s_kobj_unregister);
> >>> +   }
> >>>    }
> >>>    int __init erofs_init_sysfs(void)
>

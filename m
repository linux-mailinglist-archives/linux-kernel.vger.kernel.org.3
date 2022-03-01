Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F7C4C9211
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiCARmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236563AbiCARmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:42:12 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6777B5D64D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:41:29 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i14so1302194ilv.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzZvVi922T75isz8NxHRDBEd/bacTDleNJgeNaOuuwU=;
        b=A+QN9Lw51KgIirVm/jd5r7h5v7DlVunCQPZT/vHkFC84QQKV3AiAP2dSuxvnBoZlkp
         dJxvboW3aUGiJDhyqt6+Junjhk1PioF77cuhqWA1GA0wfulSqAlVbLXZQLnmJyoDHkDT
         Jfo/RFrUXhpkVOgYzlFLkTI2bE6NvzjkEDX4QFEHgFcacDOhTE4bvLeQ8CHckQJ8zsEg
         rlVOE2UyWQJw9VCxhMXFluoQBGEUd/5VUhfFq8E1+rQl4ZDPWNZ/bd6qK7IH2JsUVZWE
         dgmg60qm6kW0W0+ay6GXmD3vf0XD65z+PipAUsNARFOskfctpcX4LIvyhrbzcVhk1lrD
         bu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzZvVi922T75isz8NxHRDBEd/bacTDleNJgeNaOuuwU=;
        b=0C2gBjD0TLKpA7i0DV2/OK8bTWg93fbIX8HsX+cu8pfAJNqMSyknf50Vz5kM5V2Uve
         gC1MLBq0xaPptU2jWu9Dr8LtxPm5jiiKO4ufSdehV3XVZiVscXe9GCS8B6FBVMZeMupw
         R9yqnaGaDu61+R+qrmw6Ev1BLim+johvI+ZnPbmScuRd2e+bA9kvryf8/EJADgtVexH2
         y3xuZ8hLWJBH/ul8eF8j3EXcmSsdA65pRMW9x31ZEd11z8MeMZJAjfKcwoIKsdx9oMDE
         q4E8yXM/dOnK4WfochgPpS4o+m8wMN6tPRzdrPqsYfvMlaqo3uE1FuIsKG2365l2U1Ip
         MqIQ==
X-Gm-Message-State: AOAM533iIkXV0jwrUc/VfQ1ak7S4ujJwrzGO3CDNViK2hJA6ZrVNLJ/2
        Cen9KPi5waegOKabzoI7x54w57Ve6h5AkDtvG3Q9BPsc8JZRGw==
X-Google-Smtp-Source: ABdhPJzfHut8l12qBtXsJUlkKX/JS6cw27zCLOfjR4fffTT7liHEJdyPjBXsQDUX28hyiq8uF4a86VZs81Ml15mp6Vo=
X-Received: by 2002:a92:c242:0:b0:2c2:857c:b695 with SMTP id
 k2-20020a92c242000000b002c2857cb695mr24190484ilo.208.1646156488694; Tue, 01
 Mar 2022 09:41:28 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009ee0ca05d9288b83@google.com> <20220301093348.0eb7071cab3d8f0e49613fdf@linux-foundation.org>
In-Reply-To: <20220301093348.0eb7071cab3d8f0e49613fdf@linux-foundation.org>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 1 Mar 2022 18:41:17 +0100
Message-ID: <CANp29Y77+GDjoc0H_tr9DzDYTCSaqq14R2Ghy=bF7Ens+366Jg@mail.gmail.com>
Subject: Re: [syzbot] kernel BUG in hugepage_add_anon_rmap
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+d7ed29a6231d3747fb31@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 6:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 01 Mar 2022 05:57:27 -0800 syzbot <syzbot+d7ed29a6231d3747fb31@syzkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    196d330d7fb1 Add linux-next specific files for 20220222
>
> This seems to be a relatively old kernel?

Yes, syzbot was unfortunately unable to switch to the newer linux-next
versions for several days because they triggered the "WARNING in
__mod_memcg_lruvec_state" error during boot.
https://syzkaller.appspot.com/bug?id=f7421a1372deecbdb46bd6fb35ce84b16024b7f5

Now the problem is gone and syzbot is running the latest 20220301 version.

>
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15b0618a700000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=45b71d0aea81d553
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d7ed29a6231d3747fb31
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+d7ed29a6231d3747fb31@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > kernel BUG at mm/rmap.c:2330!
>
> BUG_ON(!PageLocked(page)) in hugepage_add_anon_rmap()
>
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/20220301093348.0eb7071cab3d8f0e49613fdf%40linux-foundation.org.

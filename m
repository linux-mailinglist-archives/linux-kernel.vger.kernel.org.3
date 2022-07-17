Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DDA5777D8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiGQS4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGQS4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:56:19 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBAB101ED
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 11:56:18 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id t127so8712602vsb.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 11:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Viak6lSn2kJgUe9h85PHOAfHYL7IvX6+ABISel5Ixsc=;
        b=IMbnZTA8KJgNtHupHvHPolLVXAOMLpe8ln7wRElRqdhveeGZvEj/GMw2/4v6eGrGLo
         n6QsycV2RtbNSc1YoPTkymCHjzPzkwiaMVZ3DP79hOajtuxSCMnhREhvZQUw6iaJ273t
         Se70pZO/yp1ok7aFm4UGf2B/tAlgrLn+e9XLNxd7rMW/qljth8d8zMTrCaCMF6H3JJX7
         fXwte/FH9KXXWZYcs719HQWTS4tuw+sfa7gcblsni/nxZAReQfAuKrbOTjs/EvxEKh8h
         elxeHzaA7pEG/nm7hJugciXnEua3v0MYJaQUUWCEdfyuqK6uX+HEjZavOAICvx2R8gXq
         xFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Viak6lSn2kJgUe9h85PHOAfHYL7IvX6+ABISel5Ixsc=;
        b=TwbvcgDXLq6V4ZFOzU9DPjzT1zDypn7WJTbVBIx0XbMiW1zYMYVgu+akU+nOo4eSzk
         J7sNnmxYZrtT0SIvEHa/sHsTaVpGwcvMRimpr1uhSFOwRsA/4OEYyvf/A1JES5URMg2P
         Qh7dV4AV9+a3KSTHa+Cpf7OHr/UjQIco2kfh6jtSPejXj7FWnihd1hQYjcgs4GYJFxKD
         O0GuyZiXVXiAdSci2mOxywHlHWkGNxZGignRPqlWyXWWaeHrIvkSVxpxEm+ncsNOQTWr
         zi31cfypuobxJ0UkexomTVVXxzgHSX4xS4lo30gIjYmD9V9SdU/giCHUKiHRJhyCDeLI
         pB3g==
X-Gm-Message-State: AJIora/M23wK0mTKsJvBuFBy0M6n5RKaOoVYEa6qF4PSEz06cOr3nH4k
        H/cmP3xQPut0H52/KUsJ6eUoBs9/xXmaPgRxwVYHCvwNdyuN9w==
X-Google-Smtp-Source: AGRyM1tC/ZjwZ/HtO1NtYvNWKJN7qZpBReSIojb4aAvolkgbKWvAuso5S8SmOBA4yCU8EGxmDX0wYoXzGET/tWJ9I1w=
X-Received: by 2002:a67:b246:0:b0:357:c2e8:480e with SMTP id
 s6-20020a67b246000000b00357c2e8480emr1420917vsh.9.1658084177337; Sun, 17 Jul
 2022 11:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
 <20220716212050.562604df2a48683dfbcc7e57@linux-foundation.org>
 <CAOUHufaxubu3_Ee-G8q3o02fkRoTf6M7-5=85_B_PUtsWbNa8Q@mail.gmail.com> <20220717124221.qwc4pvx6xsiwgefn@revolver>
In-Reply-To: <20220717124221.qwc4pvx6xsiwgefn@revolver>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 17 Jul 2022 12:55:41 -0600
Message-ID: <CAOUHufYg83ooSFY8eDYjLmBL=fevt1yrd2HcVnKzYWJhKeDkYA@mail.gmail.com>
Subject: Re: [PATCH v11 00/69] Introducing the Maple Tree
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 6:42 AM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Yu Zhao <yuzhao@google.com> [220717 01:58]:
> > On Sat, Jul 16, 2022 at 10:20 PM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Sun, 17 Jul 2022 02:46:32 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > ...
> > >         gap = mas.index;
> > >         gap += (info->align_offset - gap) & info->align_mask;
> > > -       VM_BUG_ON(gap + info->length > info->high_limit);
> > > -       VM_BUG_ON(gap + info->length > mas.last);
>
> What arch did you hit these on?

This is x86_64. Full trace:

  kernel BUG at mm/mmap.c:1584!
  invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
  CPU: 108 PID: 107064 Comm: stress-ng Tainted: G S      W  O
5.19.0-dbg-DEV #1
  RIP: 0010:vm_unmapped_area+0xdb/0x1c0
  Code: b0 4c 8b 73 28 49 29 c6 4c 23 73 20 49 01 c6 48 8b 43 08 4c 01
f0 48 3b 43 18 0f 87 da 00 00 00 48 3b 45 b8 0f 86 a5 00 00 00 <0f> 0b
48 c7 45 e0 00 00 00 00 65 48 8b 04 25 40 ff 01 00 48 8b 80
  RSP: 0018:ffff968562137c00 EFLAGS: 00010212
  RAX: 0000000040da1000 RBX: ffff968562137c88 RCX: 00000000025a8000
  RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff968562137c00
  RBP: ffff968562137c58 R08: ffff968562137c28 R09: ffff8f3a8d958f80
  R10: 0000000000000001 R11: 000000000000000f R12: 0000000000249000
  R13: 0000000000000000 R14: 0000000040b58000 R15: ffff8f3aafb741c0
  FS:  0000000002586340(0000) GS:ffff8f989fd00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000000000064aff0 CR3: 00000061d15ba006 CR4: 00000000003706e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   arch_get_unmapped_area+0x1ee/0x220
   arch_get_unmapped_area_topdown+0x25a/0x290
   get_unmapped_area+0x92/0x100
   do_mmap+0x13f/0x560
   vm_mmap_pgoff+0xcd/0x170
   ksys_mmap_pgoff+0xd8/0x200
   __x64_sys_mmap+0x3c/0x40
   do_syscall_64+0x44/0xa0
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

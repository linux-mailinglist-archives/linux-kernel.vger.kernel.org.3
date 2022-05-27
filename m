Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3497053633F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351730AbiE0NSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiE0NSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:18:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD712B021
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:18:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s20so4906664ljd.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/ubRkGNzoAnaLrfe1Abk/gSZHaSvaWBOlXMLf4fhxE=;
        b=qxI8FKs5YCF+nPhIHGwtmf/do+40NJTWiL8jY/1r+JC2YHNwuQE7AtSmbt+TE07a2T
         sJ965/d3i0pi4Zl8T0/U3qs3nBJvnqBwupMYttux8Rl95qjAJ6tVXXIuIYEsXt/RXDbl
         DEhf4nwYkSWvQZpzX19ulHfbg9qo/ED182IQ0Lt1ht/XeOrTwyQe8B+DF49Hkk1sTDTl
         cRtMfc6SP9vLZyA//JNCRt1HbKrcs0IUYXhDc9Zm1BxPlEAs4oph6ICD7p4G9fkL6a8m
         2axKTamDztWIqrpzNYYLS4YA4amAl9y5lq6OsllD8nllpeiOhl3iul1vHqux1QBVAQbT
         hk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/ubRkGNzoAnaLrfe1Abk/gSZHaSvaWBOlXMLf4fhxE=;
        b=jR4nRHDLP1WX1QU5ZkbNIcBoCgUi0DKG+ALrE515kXN25ZMdcVvk350Yu26B1leX5d
         60d4CLml4gOdUubQ0MJoZVZR70uwZWwXBPKGKOk+TrKx5hSRvBTiOM7JLhl79Snx/hx5
         hDyu98Km8SHt6Dw8t82DdbCzvi5vKy08vFt2J99+IZ5JV+lTj9yxCCOiL9HJQ4V/vmlT
         9QSSS0hs17WsfRbs2GjbTHlYF+9fBAe2Qb44UPLbKKOkVOmTIYn8MOZLH5UV/F2B3wpC
         RxHQkTv6Qk4XAGo1hvvq0ZFa/bs495OqHqLnNl50MHjYnLuD6hBi+mtBO4g2I6Uo1cTY
         4Dqw==
X-Gm-Message-State: AOAM533M2o7yshiTA9XKrpKNZ8SkkZNHcrwTJPPp3xyc+1EHtMSZZlMi
        /PzzBu+7zT0Vpk5yvTWiTvKKfhIFFthak0ixGqw5vg==
X-Google-Smtp-Source: ABdhPJyf+s/RXaMaf+BP/TioY1XYgPBgIYeDNSNedKH4kFfoKeI1tZrESV1NaQJFutxHLoGI/LVolEYICOxhGhAMBio=
X-Received: by 2002:a05:651c:1502:b0:253:ed7e:5778 with SMTP id
 e2-20020a05651c150200b00253ed7e5778mr14018377ljf.47.1653657525877; Fri, 27
 May 2022 06:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220525111756.GA15955@axis.com> <20220526010111.755166-1-davidgow@google.com>
 <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
 <CACT4Y+ZVrx9VudKV5enB0=iMCBCEVzhCAu_pmxBcygBZP_yxfg@mail.gmail.com> <6fa1ebe49b8d574fb1c82aefeeb54439d9c98750.camel@sipsolutions.net>
In-Reply-To: <6fa1ebe49b8d574fb1c82aefeeb54439d9c98750.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 May 2022 15:18:34 +0200
Message-ID: <CACT4Y+bhBMDn80u=W8VBbn4uZg1oD8zsE3RJJC-YJRS2i8Q2oA@mail.gmail.com>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     David Gow <davidgow@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 at 15:15, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2022-05-27 at 15:09 +0200, Dmitry Vyukov wrote:
> > > I did note (this is more for kasan-dev@) that the "freed by" is fairly
> > > much useless when using kfree_rcu(), it might be worthwhile to annotate
> > > that somehow, so the stack trace is recorded by kfree_rcu() already,
> > > rather than just showing the RCU callback used for that.
> >
> > KASAN is doing it for several years now, see e.g.:
> > https://groups.google.com/g/syzkaller-bugs/c/eTW9zom4O2o/m/_v7cOo2RFwAJ
> >
>
> Hm. It didn't for me:

Please post a full report with line numbers and kernel version.

> > BUG: KASAN: use-after-free in ieee80211_vif_use_reserved_context+0x32d/0x40f [mac80211]
> > Read of size 4 at addr 0000000065c73340 by task kworker/u2:1/17
>
> Yes.
>
> > CPU: 0 PID: 17 Comm: kworker/u2:1 Tainted: G           O      5.18.0-rc1 #5
> > Workqueue: phy0 ieee80211_chswitch_work [mac80211]
> > Stack:
> >  60ba783f 00000000 10000c268f4e 60ba783f
> >  60e60847 70dc9928 719f6e99 00000000
> >  71883b20 60bb0b42 60bb0b19 65c73340
> > Call Trace:
> >  [<600447ea>] show_stack+0x13e/0x14d
> >  [<60bb0b42>] dump_stack_lvl+0x29/0x2e
> >  [<602ef7c0>] print_report+0x15d/0x60b
> >  [<602efdc0>] kasan_report+0x98/0xbd
> >  [<602f0cc2>] __asan_report_load4_noabort+0x1b/0x1d
> >  [<719f6e99>] ieee80211_vif_use_reserved_context+0x32d/0x40f [mac80211]
>
> This is the user, it just got freed during a function call a few lines
> up.
>
> > Allocated by task 16:
> >  save_stack_trace+0x2e/0x30
> >  stack_trace_save+0x81/0x9b
> >  kasan_save_stack+0x2d/0x54
> >  kasan_set_track+0x34/0x3e
> >  ____kasan_kmalloc+0x8d/0x99
> >  __kasan_kmalloc+0x10/0x12
> >  __kmalloc+0x1f6/0x20b
> >  ieee80211_alloc_chanctx+0xdc/0x35f [mac80211]
>
> This makes sense too.
>
> > Freed by task 8:
> >  save_stack_trace+0x2e/0x30
> >  stack_trace_save+0x81/0x9b
> >  kasan_save_stack+0x2d/0x54
> >  kasan_set_track+0x34/0x3e
> >  kasan_set_free_info+0x33/0x44
> >  ____kasan_slab_free+0x12b/0x149
> >  __kasan_slab_free+0x19/0x1b
> >  slab_free_freelist_hook+0x10b/0x16a
> >  kfree+0x10d/0x1fa
> >  kvfree+0x38/0x3a
> >  rcu_process_callbacks+0x2c5/0x349
>
> This is the RCU callback.
>
> > Last potentially related work creation:
> >  save_stack_trace+0x2e/0x30
> >  stack_trace_save+0x81/0x9b
> >  kasan_save_stack+0x2d/0x54
> >  __kasan_record_aux_stack+0xd5/0xe2
> >  kasan_record_aux_stack_noalloc+0x12/0x14
> >  insert_work+0x50/0xd7
> >  __queue_work+0x805/0x95c
> >  queue_work_on+0xba/0x131
> >  call_usermodehelper_exec+0x242/0x361
> >  kobject_uevent_env+0xe46/0xeaf
> >  kobject_uevent+0x12/0x14
> >  driver_register+0x37e/0x38d
> >  pcie_port_service_register+0x19d/0x1a5
>
> This stuff is completely unrelated.
>
> > The buggy address belongs to the object at 0000000065c73300
> >  which belongs to the cache kmalloc-192 of size 192
> > The buggy address is located 64 bytes inside of
> >  192-byte region [0000000065c73300, 0000000065c733c0)
> >
>
> and that's it?
>
> johannes
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/6fa1ebe49b8d574fb1c82aefeeb54439d9c98750.camel%40sipsolutions.net.

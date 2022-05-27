Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503B153633C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349877AbiE0NPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiE0NPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:15:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31BA127195
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=okBy2z0SI8JCqUVCUlOTjpJ/WMcl6Mo/G8RcOliMI6k=;
        t=1653657342; x=1654866942; b=St4AIl4lQffv4bIMO/sArdeTIIXEXMsW39ltsQy65yw1H0I
        b9hQmh5gz3U+0DZg1G3l1QBCKV13Fyufxw8niOTWKHRsrOJ6Yq8leu4yJFQlMakTRZtJRPzCeHITU
        uRXgY6j31UnAGkRWK0Yg+8yswqxdgHNdp6v+e1bfV2ctrJmtePEop3ZYLE4/l34Nz+c/X+PYAzQBP
        rQxY6/0cb0pREoyYyGfjGcMZvj23iatif2ZzL2h8DknMPqS0Gh7ICXm34iOTQPG4/e3gc4OJOpqdb
        cfjMMcpyd3eTALt2lLkbCOcmz4MYaP8peciLkkqXd39gyFCYSt6ZmOZoSB6j9img==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuZoU-0063Iv-Di;
        Fri, 27 May 2022 15:15:34 +0200
Message-ID: <6fa1ebe49b8d574fb1c82aefeeb54439d9c98750.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Vyukov <dvyukov@google.com>
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
Date:   Fri, 27 May 2022 15:15:33 +0200
In-Reply-To: <CACT4Y+ZVrx9VudKV5enB0=iMCBCEVzhCAu_pmxBcygBZP_yxfg@mail.gmail.com>
References: <20220525111756.GA15955@axis.com>
         <20220526010111.755166-1-davidgow@google.com>
         <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
         <CACT4Y+ZVrx9VudKV5enB0=iMCBCEVzhCAu_pmxBcygBZP_yxfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-27 at 15:09 +0200, Dmitry Vyukov wrote:
> > I did note (this is more for kasan-dev@) that the "freed by" is fairly
> > much useless when using kfree_rcu(), it might be worthwhile to annotate
> > that somehow, so the stack trace is recorded by kfree_rcu() already,
> > rather than just showing the RCU callback used for that.
>=20
> KASAN is doing it for several years now, see e.g.:
> https://groups.google.com/g/syzkaller-bugs/c/eTW9zom4O2o/m/_v7cOo2RFwAJ
>=20

Hm. It didn't for me:

> BUG: KASAN: use-after-free in ieee80211_vif_use_reserved_context+0x32d/0x=
40f [mac80211]
> Read of size 4 at addr 0000000065c73340 by task kworker/u2:1/17

Yes.

> CPU: 0 PID: 17 Comm: kworker/u2:1 Tainted: G           O      5.18.0-rc1 =
#5
> Workqueue: phy0 ieee80211_chswitch_work [mac80211]
> Stack:
>  60ba783f 00000000 10000c268f4e 60ba783f
>  60e60847 70dc9928 719f6e99 00000000
>  71883b20 60bb0b42 60bb0b19 65c73340
> Call Trace:
>  [<600447ea>] show_stack+0x13e/0x14d
>  [<60bb0b42>] dump_stack_lvl+0x29/0x2e
>  [<602ef7c0>] print_report+0x15d/0x60b
>  [<602efdc0>] kasan_report+0x98/0xbd
>  [<602f0cc2>] __asan_report_load4_noabort+0x1b/0x1d
>  [<719f6e99>] ieee80211_vif_use_reserved_context+0x32d/0x40f [mac80211]

This is the user, it just got freed during a function call a few lines
up.

> Allocated by task 16:
>  save_stack_trace+0x2e/0x30
>  stack_trace_save+0x81/0x9b
>  kasan_save_stack+0x2d/0x54
>  kasan_set_track+0x34/0x3e
>  ____kasan_kmalloc+0x8d/0x99
>  __kasan_kmalloc+0x10/0x12
>  __kmalloc+0x1f6/0x20b
>  ieee80211_alloc_chanctx+0xdc/0x35f [mac80211]

This makes sense too.

> Freed by task 8:
>  save_stack_trace+0x2e/0x30
>  stack_trace_save+0x81/0x9b
>  kasan_save_stack+0x2d/0x54
>  kasan_set_track+0x34/0x3e
>  kasan_set_free_info+0x33/0x44
>  ____kasan_slab_free+0x12b/0x149
>  __kasan_slab_free+0x19/0x1b
>  slab_free_freelist_hook+0x10b/0x16a
>  kfree+0x10d/0x1fa
>  kvfree+0x38/0x3a
>  rcu_process_callbacks+0x2c5/0x349

This is the RCU callback.

> Last potentially related work creation:
>  save_stack_trace+0x2e/0x30
>  stack_trace_save+0x81/0x9b
>  kasan_save_stack+0x2d/0x54
>  __kasan_record_aux_stack+0xd5/0xe2
>  kasan_record_aux_stack_noalloc+0x12/0x14
>  insert_work+0x50/0xd7
>  __queue_work+0x805/0x95c
>  queue_work_on+0xba/0x131
>  call_usermodehelper_exec+0x242/0x361
>  kobject_uevent_env+0xe46/0xeaf
>  kobject_uevent+0x12/0x14
>  driver_register+0x37e/0x38d
>  pcie_port_service_register+0x19d/0x1a5

This stuff is completely unrelated.

> The buggy address belongs to the object at 0000000065c73300
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 64 bytes inside of
>  192-byte region [0000000065c73300, 0000000065c733c0)
>=20

and that's it?

johannes

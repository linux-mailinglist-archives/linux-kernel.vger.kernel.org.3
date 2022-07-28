Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE67B58398C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiG1Hem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiG1Hej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:34:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3434C5FAEB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:34:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E922D33A20;
        Thu, 28 Jul 2022 07:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658993676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bNidsR0p1xyDX6IFAYEZX8Yv7vk0YXivGgQvV4ylVv0=;
        b=aaC4u3Suh3mW8YlM8QkRb+dD7I1g2nGJi8LnktSdTaJWvqILuCmO7vMAgeajPpWZDLpO6D
        uhsQIyiP5naW/fhD8JsHXjdsr4JdEUFZyJ9jr/Zr1qwQ9a7NWNpXJhih2drXMuQMATz2LP
        xEt1i9EmqspomOdb2HXeUlrQ+g1nsJA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEC9E13A7E;
        Thu, 28 Jul 2022 07:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vZWLLAw84mK+FgAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 28 Jul 2022 07:34:36 +0000
Date:   Thu, 28 Jul 2022 09:34:36 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     =?utf-8?B?6ZSm5rGf5bGg?= <tujinjiang@bytedance.com>
Cc:     Yang Shi <shy828301@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] vmscan: fix potential arbitrary pointer
 passed to kfree in unregister_shrinker
Message-ID: <YuI8DPnRBeqd87QB@dhcp22.suse.cz>
References: <20220727090700.3238-1-tujinjiang@bytedance.com>
 <YuFPKDx90+R3Qc6v@dhcp22.suse.cz>
 <CAHbLzkpu91gEDzep76iRT+yFxLFaTf4fn3=bmP-fs-UP4i3NEg@mail.gmail.com>
 <CAF77dw_D5ZD74Sy9UBmQjxNO8ShHzBdVAgRKHv-z-4RKdO=C3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF77dw_D5ZD74Sy9UBmQjxNO8ShHzBdVAgRKHv-z-4RKdO=C3g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-07-22 10:37:26, 锦江屠 wrote:
> On Wed, Jul 27, 2022 at 11:50 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Wed, Jul 27, 2022 at 7:43 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > [Cc Yang Shi]
> >
> > Thanks, Michal.
> >
> > > On Wed 27-07-22 17:07:00, tujinjiang@bytedance.com wrote:
> > > > From: Jinjiang Tu <tujinjiang@bytedance.com>
> > > >
> > > > when shrinker is registered with SHRINKER_MEMCG_AWARE flag,
> > > > register_shrinker will not initialize shrinker->nr_deferred,
> > > > but the pointer will be passed to kfree in unregister_shrinker
> > > > when the shrinker is unregistered. This leads to kernel crash
> > > > when the shrinker object is dynamically allocated.
> > >
> > > Is this a real life problem? I thought shrinkers were pre-zeroed
> > > already. Not that we should be relying on that but it would be good to
> > > mention whether this is a code fortification or something that we should
> > > be really worried about.
> >
> > Yes, all memcg aware shrinkers are actually pre-zeroed. The fs
> > shrinkers (embedded in super_block) are allocated by kzalloc, all
> > other shrinkers are static declared. So I don't think it will cause
> > any crash in real life.
> >
> 
> Yes, the shrinkers in the current kernel will not cause crash, but a new
> memcg aware shrinker may be added in the future,  and I think we
> should not assume the shrinker is pre-zeroed.

Agreed. Especially when that is not documented anywhere.

> Function free_prealloced_shrinker does not assume the shrinker is pre-zeroed,
> and does not call kfree(shrinker->nr_deferred) if the shrinker is memcg aware.
> So I think it is better for unregister_shrinker to call kfree only
> when the shrinker
> is not memcg aware.

It would be really great to mention this intention in the changelog.
Your initial wording might make an impression this is a fix for an
existing problem.

> > > > To fix it, this patch initialize shrinker->nr_deferred at the
> > > > beginning of prealloc_shrinker.
> > >
> > > It would be great to add
> > > Fixes: 476b30a0949a ("mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers")

Do not use Fixes tag as this is not a real problem currently.
-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B8F4CA204
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiCBKUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiCBKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:20:16 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0225490CE5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:19:33 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id h126so2375374ybc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 02:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WlqGFWJIOROt6HvJYICcdI5niJKFhFEteG6s0kfs0KU=;
        b=O7xY7KJAdq28gbJPs4LH6h67cbxCW1UceDh420jtLXPwSPnflK+wnH8sYm1rT6jgYX
         0ib2YlPx6ciCOPj4q7byRvnNz2n/S80uspnQCFMOViA2mD/bDaUb0xl+ByeZWVL0Fvkj
         tTbR2MaqZxSQM1VD03m/mE7vCqUvHMSkdkF9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WlqGFWJIOROt6HvJYICcdI5niJKFhFEteG6s0kfs0KU=;
        b=iImIdhuI1ZGdtQRZMahm1scOtBxXIHYfDFaoEFTIutiPMw8cA25iZKd9UlXE83uqPf
         fzA9wov4Qbt62n1sKBkm9WsQL57YfsxTwEzXhDjcvusHRDscoYudOt3pyTMHY6ECuzXp
         09dtno8F40wIgZhMDK29FTnjJQRmV9U/s+TdKN/Ktasq8+c9A6IO5yAaqyhBwvuRjez3
         +Igi9uPfXnJasKD5//0pfQOcwbfg0w1eLhqY+ZmPjF+1twQAGVpMnoUlegWfPY1lrA8w
         ghTLab1Sb5zCIEKRIS2wNfGkoRe3I6IvYas3utBjHyyLF3Dgk4aAg/Vl1d583h9beEEo
         Wbow==
X-Gm-Message-State: AOAM533vKcQLaDABKXxwLNbKQBvWuvW54uTPeLR2nzu3PgdkP0HkAaPY
        CAA+F91mze6wLPl91g+drLWyPu/okFgwaRWDyxQGvA==
X-Google-Smtp-Source: ABdhPJxuV2CZu3mj7pCXEwiI7lRsEcUWLTPalJlPIByUtsPvsZXyaNWgfYkVNLQYPJTBW8W9oYqzhcqm8koWcJW9rfI=
X-Received: by 2002:a25:ef08:0:b0:628:8d01:870 with SMTP id
 g8-20020a25ef08000000b006288d010870mr5134153ybd.610.1646216372224; Wed, 02
 Mar 2022 02:19:32 -0800 (PST)
MIME-Version: 1.0
References: <20220219092533.12596-1-linmiaohe@huawei.com> <20220219092533.12596-7-linmiaohe@huawei.com>
 <dba43259e1fe4e36a0bdbe97efaaca2f@AcuMS.aculab.com> <baeab92c-d966-2dc2-d952-c7f3faf2a229@huawei.com>
 <03647389a32045f38ec18b090548a26d@AcuMS.aculab.com> <CAM4kBBLoaESLRr28kZ901e-nikDbnQnUu9h47OsA2phxp-pvuA@mail.gmail.com>
 <bd5c8187c4034016a22977c9ca54c1b0@AcuMS.aculab.com>
In-Reply-To: <bd5c8187c4034016a22977c9ca54c1b0@AcuMS.aculab.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 2 Mar 2022 11:19:21 +0100
Message-ID: <CAM4kBB+oHqn=AAqKrxgN=e7iyRiZs0HDx8J585Vugf4kyWfF5Q@mail.gmail.com>
Subject: Re: [PATCH 6/9] mm/z3fold: move decrement of pool->pages_nr into __release_z3fold_page()
To:     David Laight <David.Laight@aculab.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 10:12 AM David Laight <David.Laight@aculab.com> wrote:
>
> > > Atomic operations aren't magic.
> > > Atomic operations are (at best) one slow locked bus cycle.
> > > Acquiring a lock is the same.
> > > Releasing a lock might be cheaper, but is probably a locked bus cycle.
> > >
> > > So if you use state_lock to protect pages_nr then you lose an atomic
> > > operation for the decrement and gain one (for the unlock) in the increment.
> > > That is even or maybe a slight gain.
> > > OTOH a 64bit atomic is a PITA on some 32bit systems.
> > > (In fact any atomic is a PITA on sparc32.)
> >
> > It's actually *stale_lock* and it's very misleading to use it for this.
> > I would actually like to keep atomics but I have no problem with
> > making it 32-bit for 32-bit systems. Would that work for you guys?
>
> It would be better to rename the lock.

No it would not because that lock is protecting the list of entries
that could not be immediately freed.

~Vitaly

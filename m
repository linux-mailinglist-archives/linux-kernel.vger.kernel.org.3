Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89C1551173
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbiFTHZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiFTHZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:25:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9FE0B5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 00:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GknsFK+VQvbvBoXcSN4fBAb3XQTkYXKw7ZS5wOPD6ew=; b=BETG7RV9b4LWu9gZuGI1ZO8E0i
        0CglwQHR6dZ313fPSJUDDU6J1cJ2hFtmg1aMKKXY/6toN0mu8nUq+3m4L0vHG4aI2bYsc96eWachA
        1sSR+AePDnP5ACk9O7hPXRCeUjiSjuNhjjyjig/yf/LIEBOP1L1sh1vgSSxA2axMk8+g++x94VLpi
        czVg+EZU5RH7EtsxRZVi+NiLqDMW6RRZxKI0hK/0wRpbIq5O99x1NBg04iXVR5gZEyMykXecF/zPD
        H5CeV4kAQt0g+6lXfDha4mCChbVSFdQfMbOoMJtRMvDwFBpbAhhXwHSnetpLc0sFiesNDO+9+ljhT
        ZQEwLfMw==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3BmW-009PbF-MT; Mon, 20 Jun 2022 07:25:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B3BBE300268;
        Mon, 20 Jun 2022 09:25:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E6F5299D22F0; Mon, 20 Jun 2022 09:25:06 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:25:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will@kernel.org>, Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH] locking/rwlocks: do not starve writers
Message-ID: <YrAg0p+snFXCkGz1@hirez.programming.kicks-ass.net>
References: <CANn89iJLWJMmNrLYQ0EU7_0Wri6c3Kn9vYMOiWu1Ds8Af2KOnw@mail.gmail.com>
 <7499dd05-30d1-669c-66b4-5cb06452b476@redhat.com>
 <CANn89iLxX_bqD8PvAkZXGWzKBKYxB3qaqQjxxdmoG91PfmvRnA@mail.gmail.com>
 <YqzQKER4JRoudTJE@hirez.programming.kicks-ass.net>
 <CANn89iKO1koPa5R_mvK0k2dkFaq+F0PgcbvpVt+JpzzR5xsu6g@mail.gmail.com>
 <CAHk-=wjLOLWV2NvBPozUj0krF6fvWv6mrC4xpCBVXc=e2+dqPQ@mail.gmail.com>
 <CANn89i+wBM+ewcP9u+ZWDqv3zQeK7ovKB+YJf9S6Om5QkqhLHA@mail.gmail.com>
 <CAHk-=wi9ut1VkB=Ja_gYtH67DZ7cc5QBG-uJCPkOpU=MZDJSUw@mail.gmail.com>
 <CANn89iJXeUJRV2+8reUdaeARxYPPbCoG+9atmRFfy4kv0XX00A@mail.gmail.com>
 <CAHk-=wiEZmzBUFkZkBrJv3JSJkQ+qxaMZU_Sx1WTpMHs2SOAiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiEZmzBUFkZkBrJv3JSJkQ+qxaMZU_Sx1WTpMHs2SOAiQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 02:48:08PM -0500, Linus Torvalds wrote:

> I'd love to see the tasklist_lock be converted to RCU too.  But that
> locks predates RCU (and probably 99% of all kernel code), and it's
> messy, so nobody sane has ever willingly tried to do that afaik.

Thomas actually tried a few years ago (for RT, which also hates on RW
type locks). At the time he converted most users to RCU (since the
tasklist itself is also RCU protected), but there's a bunch of users
(more than you'd like) that really need to be exclusive vs fork.

IIRC the most prominent problem is that RCU iteration can miss incoming
tasks and they'll miss getting updated. But like said, it's a few years
ago so I'm a bit hazy on the details.

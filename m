Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4505886D8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 07:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiHCFli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 01:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiHCFlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:41:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13AB4333C;
        Tue,  2 Aug 2022 22:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F38CB8211D;
        Wed,  3 Aug 2022 05:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA396C433C1;
        Wed,  3 Aug 2022 05:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659505293;
        bh=ASwcL9MUCRLvs4Fx3Q5d20iEV+AfPh4/M2OnWZiOYBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h6/1FG4At3DoxSQGaBiVHI8jUPtURqIb7Ryw43T3J3nB6+fqsRcYQiGl9uhDmRjLX
         ryTEHbDURUONPCgCQT08BDrkoxxRtBoOX7F5YaHH33RbqHPkYi7zGgmiWNg1OdBhzc
         omhzuNROmzSU7ITlCmmMUkHr0PzVW+YBmpkmDndBiw2wEalo406tknLnSUCruKbec/
         C7V94Cv0rLTipztzakPs3J7bGSYCMCH1P/ZQOO+4NSrdaBE2OUW2SzQ/K8l2nVpLrh
         JH9UvhG/6qwS5mFGRKNwWYWKHzIO83P8ZbzsA67ywhGdf/a2EAYdtp9HNHJQwTrh7q
         7XhEkfYoMPNrA==
Date:   Tue, 2 Aug 2022 22:41:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        syzbot+c70d87ac1d001f29a058 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
Message-ID: <YuoKi0GigXm/Hcb+@sol.localdomain>
References: <20220728155121.12145-1-code@siddh.me>
 <YunKlJCDlmyn2hJ4@sol.localdomain>
 <18261d8a63a.33799d2a402802.7512018232560408914@siddh.me>
 <Yun1rC59USrgd0fu@sol.localdomain>
 <182621f8dca.1e0e6161130907.1470656861897824669@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <182621f8dca.1e0e6161130907.1470656861897824669@siddh.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 10:43:31AM +0530, Siddh Raman Pant wrote:
> On Wed, 03 Aug 2022 09:42:28 +0530  Eric Biggers <ebiggers@kernel.org> wrote:
> > Under what circumstances is the pipe pointer still being dereferenced after the
> > pipe has been freed?  I don't see how it can be; see my explanation above.
> 
> It really didn't fix the crash. It caused the same crash reported here, which
> I was already locally getting:
> https://syzkaller.appspot.com/bug?extid=03d7b43290037d1f87ca

I tested the syzbot reproducer
https://syzkaller.appspot.com/text?tag=ReproC&x=174ea97e080000, and it does
*not* trigger the bug on the latest upstream.  But, it does trigger the bug if I
recent Linus's recent watch_queue fixes.

So I don't currently see any evidence of an unfixed bug.  If, nevertheless, you
believe that a bug is still unfixed, then please provide a reproducer and a fix
patch that clearly explains what it is fixing. 

> There is a null check in post_one_notification for the pipe, most probably
> because it *expects* the pointer to be NULL'd. Also, there is no reason to have
> a dangling pointer stay, it's just a recipe for further bugs.

If you want to send a patch or patches to clean up the code, that is fine, but
please make it super clear what is a cleanup and what is a fix.

- Eric

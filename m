Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A85888C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiHCIkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiHCIku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:40:50 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB127AE6C;
        Wed,  3 Aug 2022 01:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659516018; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=EuKLCRaI1LyNZ1ZUVDVeBdcNyp8QVEhNaYtYxPfBAuP4rBplyn9n37+xUVc4YPuoZ9+3ZQecw1rWGF5dCAjpi2aYvUV6PZ4FVEevsX3kSpSxasu/WQ+RT65Yp+b36IjiTTVPXTpcOgv8+sipwZ2AF7tMnUi1prsr/p7DVTMWGYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659516018; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=+HJj+JToUolbtOl3JgpsAZUz1406bfNqHiQh4CFyvjY=; 
        b=RnTpx+dsjfOsWOBbQzNq/kOZTfh4EhPprWn3mQnqXJhMF2XCFBs0mh4AdXs46kTUec7TELlagFRQQwY+Vyq95352OC7u8YTtoxfUazB1WxqPt+ak6SCWtxhvSQ+OoR2OOVELbowoWo3Ji+2stMkYB26p8/dd8e//WBNu6617XpA=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659516018;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=+HJj+JToUolbtOl3JgpsAZUz1406bfNqHiQh4CFyvjY=;
        b=aFDqL25Qak4dJbogXnSrvupuWBgODiVTP/KEHhGmy6QfugNhe65g3Gq7ZLq1HeI4
        J+zTiyVjyoz3t1TvNOkQW0//qfpT3T9kYNiNwG9EIUv1Xxn3S8wfyaQKCFkUSqsbWoM
        HDrv44+EdV5K1KQI7F4qWP4wXG79S1VXWeJBI2IY=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1659516006945210.23588174332167; Wed, 3 Aug 2022 14:10:06 +0530 (IST)
Date:   Wed, 03 Aug 2022 14:10:06 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Eric Biggers" <ebiggers@kernel.org>
Cc:     "David Howells" <dhowells@redhat.com>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        "linux-security-modules" <linux-security-module@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "syzbot+c70d87ac1d001f29a058" 
        <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>
Message-ID: <18262dcb20e.4bf31faa421018.1228982721921458740@siddh.me>
In-Reply-To: <YuoKi0GigXm/Hcb+@sol.localdomain>
References: <20220728155121.12145-1-code@siddh.me>
 <YunKlJCDlmyn2hJ4@sol.localdomain>
 <18261d8a63a.33799d2a402802.7512018232560408914@siddh.me>
 <Yun1rC59USrgd0fu@sol.localdomain>
 <182621f8dca.1e0e6161130907.1470656861897824669@siddh.me> <YuoKi0GigXm/Hcb+@sol.localdomain>
Subject: Re: [PATCH v3] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Aug 2022 11:11:31 +0530  Eric Biggers <ebiggers@kernel.org> wrote:
> I tested the syzbot reproducer
> https://syzkaller.appspot.com/text?tag=ReproC&x=174ea97e080000, and it does
> *not* trigger the bug on the latest upstream.  But, it does trigger the bug if I
> recent Linus's recent watch_queue fixes.
> 
> So I don't currently see any evidence of an unfixed bug.  If, nevertheless, you
> believe that a bug is still unfixed, then please provide a reproducer and a fix
> patch that clearly explains what it is fixing. 
> 
> > There is a null check in post_one_notification for the pipe, most probably
> > because it *expects* the pointer to be NULL'd. Also, there is no reason to have
> > a dangling pointer stay, it's just a recipe for further bugs.
> 
> If you want to send a patch or patches to clean up the code, that is fine, but
> please make it super clear what is a cleanup and what is a fix.
> 
> - Eric
> 

I honestly feel like I am repeating myself yet again, but okay.

Of course, the race condition has been solved by a patch upstream, which I had
myself mentioned earlier.

But what I am saying is that it did *not* address *what* that race condition
had triggered, i.e. the visible cause of the UAF crash, which, among other
things, is *because* there is a dangling pointer to the freed pipe, which
*caused* the crash in post_one_notification() when it tried to access
&pipe->rd.wait_lock as an argument to spin_lock_irq(), a path it reached
after checking if wqueue->pipe is NULL and proceeded when it was not the case.

And the upstream commit was made *after* I had posted this patch, hence this
was a fix for the syzkaller issue. While I am *not* saying to accept it just
because this was posted earlier, I am saying this patch addresses a parallel
issue, i.e. the *actual use-after-free crash* which was reproduced by those
reproducers, i.e., what was attempted to be used after getting freed and
detected by KASAN.

We don't need to wait for another similar syzbot report to pop up before doing
this change, and say let's not fix a dangling pointer reference because now
another commit apparately fixes the specific syzkaller issue, causing the given
specific reproducer with its specific way of reproducing to fail, when we in
fact now know it *can* be a valid problem in practice and doing this change
too causes the specific reproducer under consideration to fail reproducing, as
was reported by the reproducer itself.

I really don't know how to create stress tests / reproducers like how syzkaller
makes, so if a similar new reproducer is really required for showing this
patch's validity disregarding any earlier reproducers, I unfortunately cannot
make it due to skill issue as I just started in kernel dev, and I am deeply
sorry for wasting the time of everyone, and I am thankful for your criticism of
my patch.

Thanks,
Siddh

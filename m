Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2338588630
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiHCEMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbiHCEMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:12:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D143A1CB37;
        Tue,  2 Aug 2022 21:12:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F34BB80DCA;
        Wed,  3 Aug 2022 04:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265B4C433C1;
        Wed,  3 Aug 2022 04:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659499950;
        bh=/5bvzOm7MhNymrzvwwNIjMW1hlBKd/c+bwCabXKjulY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TK/kg7XborVlqtD+QqcnVGtcUkNADw5IfNGaVYfYqXXFNmHLq2d6ujPQltcJryKVy
         TJUUj0OcYfsnwGLNdJoAY7uX//5ypfeFaN/R80zJ/EaIfwWYPQWHii5iUAAhT2en0R
         iX8v6rUlrH4dxBIVXu+sIb4OwsBTZjIj0qQyr6vEMi61EFnzezcfWro3xriRyGlN2k
         3YhYeotmg8/cx2Ub6T9Ff8VrTgEoBw+WvqIcw6VbxB7PngQ/IN+NfoDFmLvvkqC2ks
         boPrrM2kyXg+Svr15sRFW7Cn0xr/BooFpyBAQUFmOdKe4Z8VIS64huSLc49P4GR5Rm
         oiw/l80kfo5Uw==
Date:   Tue, 2 Aug 2022 21:12:28 -0700
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
Message-ID: <Yun1rC59USrgd0fu@sol.localdomain>
References: <20220728155121.12145-1-code@siddh.me>
 <YunKlJCDlmyn2hJ4@sol.localdomain>
 <18261d8a63a.33799d2a402802.7512018232560408914@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18261d8a63a.33799d2a402802.7512018232560408914@siddh.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:26:04AM +0530, Siddh Raman Pant wrote:
> On Wed, 03 Aug 2022 06:38:36 +0530  Eric Biggers <ebiggers@kernel.org> wrote:
> > On Thu, Jul 28, 2022 at 09:21:21PM +0530, Siddh Raman Pant wrote:
> > > If not done, a reference to a freed pipe remains in the watch_queue,
> > > as this function is called before freeing a pipe in free_pipe_info()
> > > (see line 834 of fs/pipe.c).
> > > 
> > > This causes a UAF when post_one_notification() tries to access the pipe
> > > on a key update, which is reported by syzbot.
> > > 
> > > We also need to use READ_ONCE() in post_one_notification() to prevent the
> > > compiler from optimising and loading a non-NULL value from wqueue->pipe.
> > 
> > Didn't this already get fixed by the following commit?
> > 
> >     commit 353f7988dd8413c47718f7ca79c030b6fb62cfe5
> >     Author: Linus Torvalds <torvalds@linux-foundation.org>
> >     Date:   Tue Jul 19 11:09:01 2022 -0700
> > 
> >         watchqueue: make sure to serialize 'wqueue->defunct' properly
> > 
> > With that, post_one_notification() only runs while the watch_queue is locked and
> > not "defunct".  So it's guaranteed that the pipe still exists.  Any concurrent
> > free_pipe_info() waits for the watch_queue to be unlocked in watch_queue_clear()
> > before proceeding to free the pipe.  So where is there still a bug?
> 
> It doesn't fix the dangling pointer to the freed pipe in the watch_queue, which
> had caused this crash.
> 

Under what circumstances is the pipe pointer still being dereferenced after the
pipe has been freed?  I don't see how it can be; see my explanation above.

- Eric

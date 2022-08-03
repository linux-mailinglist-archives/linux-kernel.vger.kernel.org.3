Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC1258862A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 06:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiHCEJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 00:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHCEJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 00:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31E725C78
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 21:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65845612AC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B06C433C1;
        Wed,  3 Aug 2022 04:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659499775;
        bh=7IbobPPIX3Vzf8Jpo8GKur5xflthRgqIQ+AaGpXTX+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V24iMXsYTQWwgJ4n1FVn7wTAgz5twUAaI8PGSY1OfomvFI/BlvrJtVIZPeiPtPlr+
         Nc2gYCOcLnEsAScAKzhBHlPURI37u9jUUDYNAYSwpwWntDCslwu6+ywzsPW9DboL97
         vBhoE5rF6TG6ynyN8hL7eTJsuY6LYj4bzlIPlXB9snJ+ou3k+h46As9t1K6kACJA1O
         TL/YWLYLcXQTwHNlFwB1WHAtLiJ9MTadJMZIQ4S8b1iDXxuR1WeAlUPLVd1ZH13KuG
         8RWpiop0cXYgl8jaIYpTO3/Knr+tAbdEJwOOqKiWhEQO5CzmRBQZlp97tix1e+JyjZ
         iGAiffYzIolQA==
Date:   Tue, 2 Aug 2022 21:09:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     syzbot <syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com>,
        hdanton <hdanton@sina.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in post_one_notification
Message-ID: <Yun0/rDv4ptBl65S@sol.localdomain>
References: <20220801103533.972-1-hdanton@sina.com>
 <000000000000c7a83905e52bd127@google.com>
 <Yumkx4Nc5ZyPGYMz@sol.localdomain>
 <18261e01068.4a2910f2403165.1226720997594524412@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18261e01068.4a2910f2403165.1226720997594524412@siddh.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 09:34:10AM +0530, Siddh Raman Pant wrote:
> On Wed, 03 Aug 2022 03:57:19 +0530  Eric Biggers <ebiggers@kernel.org> wrote:
> > It appears this was already fixed, so no need for any more activity on this bug:
> > 
> > #syz fix: watchqueue: make sure to serialize 'wqueue->defunct' properly
> > 
> > - Eric
> 
> It doesn't address the dangling pointer remaining in the watch_queue,
> which was the root cause of this crash. The use-after-free happened
> because the pipe was freed but a dangling pointer of it remained in
> a watch_queue, and an attempt to dereference it was there.
> 

I don't think that's true; the pointer doesn't get dereferenced after
watch_queue::defunct is set.  See my message on the other thread where I
explained this: https://lore.kernel.org/lkml/YunKlJCDlmyn2hJ4@sol.localdomain

Of course, if you actually have a reproducer, or a KASAN report, or anything at
all that shows there is still a problem, then please post it.

- Eric

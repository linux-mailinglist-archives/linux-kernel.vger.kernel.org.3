Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66EC59AD77
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344400AbiHTLaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiHTL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:29:57 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB0E240A7
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 04:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1660994946; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=Nqty8JFgrOxBVH4CzVzB+JLvRqKOQ+RaeObPKiZC2L9vPXlSECC8VEXrWnJw1eDvelBhZHz3sOt7EdaITmBT9F/y/hZ3SC3SNxzFENbOuDRRO+2JTZORa3HicaGPBzAZ5iBHq84T39dgAKEFoErCHjzWFyVgVErvbQQBNtVcQDE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1660994946; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=/i1BQuBFaVZtsaNVV0P5lReOS+nc8mcEOK2Ji36Irn8=; 
        b=X/FuWa0BtbmySalV7QY8s2gAJo7eQWBW6isSBshOwhmYGuNWg5tvCRC+rnyg65AqhDlMd1MI2eGRcKywq14k+vroDXbfImk/kz4oGEs+7Wa3bpZ8T8Yd/pvXjEXj+e7CP3GPLBEETwaowVQKCzfVd1p0rkcgifdq/jpaOOglt74=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660994946;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=/i1BQuBFaVZtsaNVV0P5lReOS+nc8mcEOK2Ji36Irn8=;
        b=czsdL8kbKjKitm2RKCXEdbc0de0vVu2hjz+GQYUzDnZF1A+n72JXfkOwOlx+q3v+
        FwaPLRBx4vuNISqNrmXYH3KrMbDd95XqtN0k1zOvkVysxvhvo6iwGVcFnNnkqiw/2aF
        FWqwxc73EubYj0S/Dsexd+/344zE/Z0X6hBJs5rI=
Received: from mail.zoho.in by mx.zoho.in
        with SMTP id 1660994935866227.9120167406926; Sat, 20 Aug 2022 16:58:55 +0530 (IST)
Date:   Sat, 20 Aug 2022 16:58:55 +0530
From:   Siddh Raman Pant <code@siddh.me>
To:     "Eric Biggers" <ebiggers@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "David Howells" <dhowells@redhat.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        "Eric Dumazet" <edumazet@google.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <182bb035c23.6b1246ee44934.6791244868891887905@siddh.me>
In-Reply-To: <cover.1659771577.git.code@siddh.me>
References: <cover.1659771577.git.code@siddh.me>
Subject: Re: [PATCH v2 0/2] watch_queue: Clean up some code
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Aug 2022 13:13:40 +0530  Siddh Raman Pant  wrote:
> There is a dangling reference to pipe in a watch_queue after clearing it.
> Thus, NULL that pointer while clearing.
> 
> This change renders wqueue->defunct superfluous, as the latter is only used
> to check if watch_queue is cleared. With this change, the pipe is NULLed
> while clearing, so we can just check if the pipe is NULL.
> 
> Extending comment for watch_queue->pipe in the definition of watch_queue
> made the comment conventionally too long (it was already past 80 chars),
> so I have changed the struct annotations to be kerneldoc-styled, so that
> I can extend the comment mentioning that the pipe is NULL when watch_queue
> is cleared. In the process, I have also hopefully improved documentation
> by documenting things which weren't documented before.
> 
> Changes in v2:
> - Merged the NULLing and removing defunct patches.
> - Removed READ_ONCE barrier in lock_wqueue().
> - Improved and fixed errors in struct docs.
> - Better commit messages.
> 
> Siddh Raman Pant (2):
>   include/linux/watch_queue: Improve documentation
>   kernel/watch_queue: NULL the dangling *pipe, and use it for clear
>     check
> 
>  include/linux/watch_queue.h | 100 ++++++++++++++++++++++++++----------
>  kernel/watch_queue.c        |  12 ++---
>  2 files changed, 79 insertions(+), 33 deletions(-)
> 
> -- 
> 2.35.1

Hello,

Maybe the above quoted patch was missed due to the
then-ongoing merge window. This can be found on:
https://lore.kernel.org/lkml/cover.1659771577.git.code@siddh.me/

This patch was posted 2 weeks ago, with changes as requested.

With the merge window closed, may I request for another look at
this patch?

Thanks,
Siddh

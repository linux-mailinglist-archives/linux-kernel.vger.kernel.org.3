Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F43A5292DB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347038AbiEPV2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiEPV2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:28:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DF83EBA8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B6556155D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 21:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F128C385AA;
        Mon, 16 May 2022 21:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652736481;
        bh=EM6ZQkiQKgpAaDYaA6WjPhnZvN0fVUJjX1XitUtMIs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZncUOfR5ydNppphNM7bCyHaeeVtoa/cDcINUcafTV2G5pjni+bwaDQQd96t7ZAIml
         DJqkX8XWxDIoclFzgJk6S7FBgdujsfRsJW/ADQ8+B+NoCfPLUx4HTrR3p67q0PWa4O
         sIF+9ZBSf3FfS7U9tYVzcJY4KBnC9vyPhGkO5++Q=
Date:   Mon, 16 May 2022 14:28:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] random: move randomize_page() into mm where it belongs
Message-Id: <20220516142800.4730a41ec1498d5e3d7863c0@linux-foundation.org>
In-Reply-To: <20220514120556.363559-1-Jason@zx2c4.com>
References: <20220514120556.363559-1-Jason@zx2c4.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 May 2022 14:05:56 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> randomize_page is an mm function. It is documented like one. It contains
> the history of one. It has the naming convention of one. It looks
> just like another very similar function in mm, randomize_stack_top().
> And it has always been maintained and updated by mm people. There is no
> need for it to be in random.c. In the "which shape does not look like
> the other ones" test, pointing to randomize_page() is correct.
> 
> So move randomize_page() into mm/util.c, right next to the similar
> randomize_stack_top() function.
> 
> This commit contains no actual code changes.

hm, does it make sense?

Probably randomize_page() (which used to be called randomize_range())
should have been called randomize_address().  Is it an MM function
then?  Not really - it's simply an application of the random number
generator.  So I think it's more a random thing than an MM thing.

> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -343,6 +343,38 @@ unsigned long randomize_stack_top(unsigned long stack_top)
>  #endif
>  }
>  
> +/**
> + * randomize_page - Generate a random, page aligned address

The patch assumes that drivers/char/random.o is always built into
vmlinux, which appears to be the case.  If some space-conscious person
goes and makes random.o build-time optional then they'll need to make
the appropriate adjustments in util.c.  I see no problems with this.


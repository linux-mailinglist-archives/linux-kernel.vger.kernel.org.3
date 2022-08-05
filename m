Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B934758A6DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbiHEHQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiHEHQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:16:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9E0F35
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A35DEB827E6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 07:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03770C433C1;
        Fri,  5 Aug 2022 07:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659683779;
        bh=pVVmulI7yI4CK6aTV3QyaslBwmz+G2X9eavrx06cU6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZENF4PlyknV8Xq4eLRWpsaLD7k9DL03M0OnEm0ZgeJCG2e+C6c2FmQkRpGxfhaKN
         QcI4O9H6v/VteiJjXbPcgf8ZUteF1Qv0r6/R5Y8iJ+y+IxUacyCYxpM4L6pEdheJyU
         9xq0FzrcSo8SvSLiEMdcNqpkII2iIX6Y+A6H0vW7mZ9EB/s2rTNECqbaGxsat4r4uF
         nk2wbd0UxQjqcD+TsL7Jswa/J7rucfCM4L5MNzCtvnB9E/RnyLU1p9FISFrhhF7S9F
         GiICqKj0QHURF7momLdJtgg3inVCOKbmN7GNhVNHhBWnCAv/sg/ef4t4RuDkLU7Msf
         m6lC29AsLlR5Q==
Date:   Fri, 5 Aug 2022 00:16:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH 0/3] kernel/watch_queue: Clean up some code
Message-ID: <YuzDwa4otHkImo10@sol.localdomain>
References: <cover.1659618705.git.code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659618705.git.code@siddh.me>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 07:00:21PM +0530, Siddh Raman Pant wrote:
> There is a dangling reference to pipe in a watch_queue after clearing it.
> Thus, NULL that pointer while clearing. This can be thought of as a v4 of
> the patches I had sent earlier.
> 
> This change renders wqueue->defunct superfluous, as the latter is only used
> to check if watch_queue is cleared. With this change, the pipe is NULL'd
> while clearing, so we can just check if the pipe is NULL.
> 
> Extending comment for watch_queue->pipe in the definition of watch_queue
> made the comment conventionally too long (it was already past 80 chars),
> so I have changed the struct annotations to be doxygen-styled, so that
> I can extend the comment mentioning that the pipe is NULL when watch_queue
> is cleared.
> 
> Siddh Raman Pant (3):
>   kernel/watch_queue: Remove dangling pipe reference while clearing
>     watch_queue
>   kernel/watch_queue: Improve struct annotation formatting
>   kernel/watch_queue: Remove wqueue->defunct and use pipe for clear
>     check
> 
>  include/linux/watch_queue.h | 95 +++++++++++++++++++++++++++----------
>  kernel/watch_queue.c        | 11 ++---
>  2 files changed, 75 insertions(+), 31 deletions(-)

I think patches 1 and 3 should be merged together.

Also, please use a consistent version number for all patches in the series.  You
have a version 1, version 2, and version 4 patch all in the same series, which
is very confusing.

- Eric

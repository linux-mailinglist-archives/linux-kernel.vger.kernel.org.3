Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEC25173F3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbiEBQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386111AbiEBQPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:15:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD9EBC93;
        Mon,  2 May 2022 09:12:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27141B8187D;
        Mon,  2 May 2022 16:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA36C385A4;
        Mon,  2 May 2022 16:12:08 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZTIUL47t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651507927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JthCT2QbwaNt2DB/F/sxRyKukGJ0r6w86ZPxmmA4K2I=;
        b=ZTIUL47tvZtuvCUjjZMxKFfCRkY8sopVe/HQ8NTwyO2noS3cv31HHMJV6NvUrCSpQ5dHy8
        EjGU0nc0qviHQVdS3wDIY9FPoGDdY52b6Axrn3EkE76PlJx6kWhx1v6LPgD05WgaAxEkV+
        YSxaN3oHZ8Khpp6ZW3HdGY+r4UpC91k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d724f6c4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 16:12:06 +0000 (UTC)
Date:   Mon, 2 May 2022 18:12:03 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Graf <graf@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Message-ID: <YnAC00VtU8MGb7vO@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ym/7UlgQ5VjjC76P@gardel-login>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 05:40:02PM +0200, Lennart Poettering wrote:
> On Mo, 02.05.22 16:06, Jason A. Donenfeld (Jason@zx2c4.com) wrote:
> 
> > In order to inform userspace of virtual machine forks, this commit adds
> > a "fork_event" sysctl, which does not return any data, but allows
> > userspace processes to poll() on it for notification of VM forks.
> >
> > It avoids exposing the actual vmgenid from the hypervisor to userspace,
> > in case there is any randomness value in keeping it secret. Rather,
> > userspace is expected to simply use getrandom() if it wants a fresh
> > value.
> 
> Wouldn't it make sense to expose a monotonic 64bit counter of detected
> VM forks since boot through read()? It might be interesting to know
> for userspace how many forks it missed the fork events for. Moreover it
> might be interesting to userspace to know if any fork happened so far
> *at* *all*, by checking if the counter is non-zero.

"Might be interesting" is different from "definitely useful". I'm not
going to add this without a clear use case. This feature is pretty
narrowly scoped in its objectives right now, and I intend to keep it
that way if possible. (And yes, I realize that is likely considerably
different from your development philosophy.)

> 
> (Ideally that counter file would even be mmapable...)

You missed the last year of discussion about this and why we have wound
up here as a first step. Check the archives for extensive discussion.

Jason

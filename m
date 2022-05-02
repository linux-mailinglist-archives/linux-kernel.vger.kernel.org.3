Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F751776E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387134AbiEBTav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387129AbiEBTao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74B01146;
        Mon,  2 May 2022 12:27:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6250A614D9;
        Mon,  2 May 2022 19:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48A7C385A4;
        Mon,  2 May 2022 19:27:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VcPWwzFD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651519631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nMU43gluS+1wHrTp7XvGGK0hJNwlZnBeuP8FRPsIIP4=;
        b=VcPWwzFDQbe1738CAVI33DzgPQ8h7IfjWIeZGQCrQOYW8xrGQ+9v2bGlUC5mRNkQkmYG0m
        +NdkfXexHtFu+ldCTJXGQ9pFFKruiSBahp1qGXGNrOBvagOUir0UJU+cCvJcRhnkiHZnZB
        rHfdB0Ib4Fx6vsIdI4EdXq8b0N9w8W0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cad2ecb8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 19:27:10 +0000 (UTC)
Date:   Mon, 2 May 2022 21:27:05 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Message-ID: <YnAwiZv8n6Rzc5+O@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
 <YnAc4hwPyByF4kZ5@zx2c4.com>
 <480469e6-0eb0-8d76-0b8d-111579e73701@amazon.com>
 <YnAnCgxmPBrMdKt5@zx2c4.com>
 <cef2694f-d6cc-70e0-1d31-0c9dbd038ce2@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cef2694f-d6cc-70e0-1d31-0c9dbd038ce2@amazon.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 08:56:05PM +0200, Alexander Graf wrote:
> 
> On 02.05.22 20:46, Jason A. Donenfeld wrote:
> > On Mon, May 02, 2022 at 08:34:38PM +0200, Alexander Graf wrote:
> >> Michael, since we already changed the CID in the spec, can we add a
> >> property to the device that indicates the first 4 bytes of the UUID will
> >> always be different between parent and child?
> >>
> >> That should give us the ability to mmap the vmgenid directly to user
> >> space and act based on a simple u32 compare for clone notification, no?
> > That is not a good idea. We want an _additional_ 4 bytes, so that we can
> > keep the first 16 bytes (128 bits) as a kernel space secret.
> 
> 
> An additional 4 bytes would be an additional 4kb (or 64kb on ARM) page. 
> Do we really rely on these 16 bytes to reseed after clone? If so, we'd 
> need to bite the bullet and provide an additional page, yes.
 
Ugh, you're right; memory mapping is pages. The other option would be
relying on RDRAND (both existing and being trusted by the user etc), but
generally people aren't too jazzed about that. We pretty much have to
assume that the existing pool is compromised, since people share cloned
VMs casually. The 128-bit vmgenid is a nice input to have.

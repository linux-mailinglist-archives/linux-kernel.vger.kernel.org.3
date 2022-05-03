Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0B517F17
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiECHqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiECHqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:46:16 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB92537BF0;
        Tue,  3 May 2022 00:42:43 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 9CEF6E804AA;
        Tue,  3 May 2022 09:42:41 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id C8309160011; Tue,  3 May 2022 09:42:40 +0200 (CEST)
Date:   Tue, 3 May 2022 09:42:40 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Graf <graf@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Message-ID: <YnDc8A+oTxsQs/hq@gardel-login>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
 <YnAc4hwPyByF4kZ5@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnAc4hwPyByF4kZ5@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 02.05.22 20:04, Jason A. Donenfeld (Jason@zx2c4.com) wrote:

> > I can just tell you, that in systemd we'd have a usecase for consuming
> > such a generation counter: we try to provide stable MAC addresses for
> > synthetic network interfaces managed by networkd, so we hash them from
> > /etc/machine-id, but otoh people also want them to change when they
> > clone their VMs. We could very nicely solve this if we had a
> > generation counter easily accessible from userspace, that starts at 0
> > initially. Because then we can hash as we always did when the counter
> > is zero, but otherwise use something else, possibly hashed from the
> > generation counter.
>
> This doesn't work, because you could have memory-A split into memory-A.1
> and memory-A.2, and both A.2 and A.1 would ++counter, and wind up with
> the same new value "2".

Yes, that's why I as vague about what to switch to if the counter is
non-zero, i.e. "something else, *possibly* hashed…".

For this MAC address usecase it's entirely sufficient to be able to
distinguish if the system was closed at all, i.e. if the counter is
zero or is non-zero. Because that would already be great for a policy
of "hash it in a stable way from /etc/machine-id, if counter == 0" +
"use random MAC once counter > 0".

Such a MAC address policy I think should probably even be the new
default in networkd, if we could implement it. For that we'd need a
single bit of info from the kernel, indicating whether the sysem was
cloned at all. i.e. if the vmgenid uuid is different from the one the
system booted up first.

Lennart

--
Lennart Poettering, Berlin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0B0517322
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385976AbiEBPtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbiEBPt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:49:27 -0400
X-Greylist: delayed 352 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 08:45:58 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8195E011;
        Mon,  2 May 2022 08:45:58 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 18318E804AA;
        Mon,  2 May 2022 17:40:04 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 005B3160011; Mon,  2 May 2022 17:40:02 +0200 (CEST)
Date:   Mon, 2 May 2022 17:40:02 +0200
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
Message-ID: <Ym/7UlgQ5VjjC76P@gardel-login>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220502140602.130373-2-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 02.05.22 16:06, Jason A. Donenfeld (Jason@zx2c4.com) wrote:

> In order to inform userspace of virtual machine forks, this commit adds
> a "fork_event" sysctl, which does not return any data, but allows
> userspace processes to poll() on it for notification of VM forks.
>
> It avoids exposing the actual vmgenid from the hypervisor to userspace,
> in case there is any randomness value in keeping it secret. Rather,
> userspace is expected to simply use getrandom() if it wants a fresh
> value.

Wouldn't it make sense to expose a monotonic 64bit counter of detected
VM forks since boot through read()? It might be interesting to know
for userspace how many forks it missed the fork events for. Moreover it
might be interesting to userspace to know if any fork happened so far
*at* *all*, by checking if the counter is non-zero.

(Ideally that counter file would even be mmapable...)

does this file really belong below the `kernel.random` sysctl
hierarchy? shouldn't this rather be something like
/sys/kernel/vmclone_event or so?

Most people see sysctl as a place to tweak settings with. But this
sysctl you proposed here cannot be written, and (so far…) not even be
read! So it sounds like a weird thing to place into /proc/sys/.

Note that in userspace there's a whole infrastructure for managing
sysctls, but this one doesn't look like it would be managable at all
by userspace with these tools.

Lennart

--
Lennart Poettering, Berlin

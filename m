Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BD5517FC1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 10:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiECIdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiECIdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:33:25 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37E532058;
        Tue,  3 May 2022 01:29:52 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 74F43E804AA;
        Tue,  3 May 2022 10:29:50 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 8B74A160011; Tue,  3 May 2022 10:29:49 +0200 (CEST)
Date:   Tue, 3 May 2022 10:29:49 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Alexander Graf <graf@amazon.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
Message-ID: <YnDn/d6iB0aUZkWJ@gardel-login>
References: <20220502140602.130373-1-Jason@zx2c4.com>
 <20220502140602.130373-2-Jason@zx2c4.com>
 <Ym/7UlgQ5VjjC76P@gardel-login>
 <YnAC00VtU8MGb7vO@zx2c4.com>
 <YnAMBzhcJhGR5XOK@gardel-login>
 <7a1cfd1c-9f0e-f134-e544-83ee6d3cd9c9@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a1cfd1c-9f0e-f134-e544-83ee6d3cd9c9@amazon.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 02.05.22 19:59, Alexander Graf (graf@amazon.com) wrote:

> Lennart, looking at the current sysctl proposal, systemd could poll() on the
> fork file. It would then be able to generate a /run/fork-id file which it
> can use for the flow above, right?

I am not to keen on making sytemd such a proxy. Sounds like something
the kernel could do on its own, better and resulting in an ultimately
simpler system...

If systemd its the proxy this adds in extra raciness. i.e. in a ideal
world, if we have some form of notification fd, then it would be great
if that fd is guaranteed to have POLLIN set and its contents updated
the instant the clone happened. But if we proxy this through
userspace, there's necessarily a latency involved that it it takes
userspace to catch up and effect the POLLIN and updated contents
towards its client apps.

I understand the underlying VM hypervisor APIs currently are designed
to always imply some notification latency. Which sucks, but I think we
should be very careful with replicating this design mistake with any
userspace APIs we add.

i.e. I am pretty sure that even if the underlying VM hypervisor
primitive isn't as good as we wanted, the Linux kernel→userspace API
should be built so that if one day a better VM hypervisor interface
exists it can be plugged behind it without such limitations.

> Overall, it sounds to me like the sysctl poll based kernel interface in this
> patch in combination with systemd inhibitors gives us an answer to most of
> the flows above.

As mentioned earlier, I am not convinced sysctl is the right place for
this. sysctls are understood by most people as being the place for
tweaking kernel settings. This is not a kernel setting, but a
notification concept, and the way Jason defined it there's nothing to
read nor write, which strongly suggests to move it elsewhere, but not
/proc/sys/.

Use /sys/kernel/ or so. Or maybe O_NOTIFICATION_PIPE or whatever, but
/proc/sys/ looks really wrong.

> I can see attractiveness in providing the /run/fork-id directly from the
> kernel though, to remove the dependency on systemd for poll-less
> notification of libraries.

I agree.

Lennart

--
Lennart Poettering, Berlin

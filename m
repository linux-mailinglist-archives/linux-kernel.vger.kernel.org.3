Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086AC4CA8CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbiCBPJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiCBPJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:09:00 -0500
X-Greylist: delayed 496 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 07:08:15 PST
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9474A60AA6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:08:14 -0800 (PST)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4K7y2k2NJxzF74l
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:59:58 -0800 (PST)
X-Riseup-User-ID: 45BFFCFB4AB6A46B24AA5A9D0C6FD4FD300E827376533DDFC5C9F0806F4E0E5A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4K7y2k0h9kz5w0N
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:59:58 -0800 (PST)
Message-ID: <2fb2902d-f844-d018-aa4c-94009886ad1d@torproject.org>
Date:   Wed, 2 Mar 2022 08:59:56 -0600
MIME-Version: 1.0
Content-Language: en-US
From:   Jim Newsome <jnewsome@torproject.org>
Organization: The Tor Project, Inc
To:     linux-kernel@vger.kernel.org
Subject: sigaltstack from signal handler succeeds but is overwritten on
 sigreturn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Context: I recently came across this behavior while developing [shadow], 
where we're using seccomp to trap syscalls to an LD_PRELOAD'd signal 
handler, as a fallback for syscalls we weren't able to intercept more 
efficiently at the libc API level via LD_PRELOAD. When a new thread is 
created, we do some self-initialization on its first intercepted 
syscall, including setting up a signal stack with sigaltstack. When the 
first syscall is trapped via seccomp, this initialization happens in the 
sigsys signal handler, and the sigaltstack configuration is lost on 
return. We can work around this behavior by initializing explicitly 
immediately after returning from clone in the child thread (which is 
probably a better design anyway), but it took a while to figure out what 
was going wrong.

[shadow]: https://github.com/shadow/shadow

Here is a simplified demonstration of the issue: 
https://godbolt.org/z/Mrxe119oj

 From the [sigaltstack man page], I'd only expect sigreturn to restore 
the sigaltstack configuration if there was already a sigaltstack 
configured for the thread on entry to the handler, and it had 
SS_AUTODISARM set.

[sigaltstack man page]: 
https://man7.org/linux/man-pages/man2/sigaltstack.2.html

I discovered this on x86-64 Ubuntu and their modified kernel 
5.13.0-30-generic and am not currently set up to try reproducing on a 
vanilla kernel, but if I'm reading the source correctly, this behavior 
exists in the latest kernel, at least on x86-64. The x86-64 [sigreturn] 
always calls [restore_altstack], which always restores the old 
sigaltstack config.

[sigreturn]: 
https://github.com/torvalds/linux/blob/5bfc75d92efd494db37f5c4c173d3639d4772966/arch/x86/kernel/signal.c#L656

[restore_altstack]: 
https://github.com/torvalds/linux/blob/a4fd49cdb5495f36a35bd27b69b3806e383c719b/kernel/signal.c#L4246

Is this unconditional restore intended? If so, maybe it could be 
documented more explicitly in the sigaltstack and/or sigreturn man pages?


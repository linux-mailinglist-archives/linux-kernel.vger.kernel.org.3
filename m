Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A449C9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbiAZMmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:42:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56766 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234178AbiAZMmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:42:37 -0500
Date:   Wed, 26 Jan 2022 13:42:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643200956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4Z3/9H3m0tgy9S7Cn+tHZ7uEy9cj/q5+j+ZZeCfQFQ=;
        b=jKMLGHRKXERkqVWuObOXmlgVE/lhS+RReXlLhn6vAfdOjMFPb7Uv2bCIAU4+t0H8o+mSzl
        tfTmEKGiiZNMI+9ez1bJ2tPU/nip1SdWOVVJEccA4xQZv6Qvo5ApS4mxh1UYjqwfnBa7Dp
        xEn6o30nAXl77pbPWLwUwro1EeSQvHEariWlpHUh0gXH/8Pbw2ZII8fUZpRA+vLmv6ecWS
        vOcNgD+apxZpYsHoidnUVsXPa0Amcq/YrFALygwbb9DMKLkcYSdRfUMhUiLQ5b2Q2il92B
        nCKePj9fSLF7tgGwj5htJt09RxOO6hhDXf2lGg6YH76npcZ3bSizOaS61ledjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643200956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p4Z3/9H3m0tgy9S7Cn+tHZ7uEy9cj/q5+j+ZZeCfQFQ=;
        b=B3aJ8TgeEcHWPbMY63fScX6yaeo+fHxAeyJcLdwqAcpfzlbDjSE8IiSx+dj6jWm6hDgWFi
        7EGFiUM2DEcfKQDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     John Ogness <john.ogness@linutronix.de>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [rt-devel:linux-5.16.y-rt-rebase 8/132]
 kernel/printk/printk.c:2628:2: error: implicit declaration of function
 'boot_delay_msec'
Message-ID: <YfFBuyZstHF1zx+q@linutronix.de>
References: <202201220950.sysXbxm5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202201220950.sysXbxm5-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-22 09:13:20 [+0800], kernel test robot wrote:
=E2=80=A6
>    kernel/printk/printk.c: In function 'console_emit_next_record':
> >> kernel/printk/printk.c:2628:2: error: implicit declaration of function=
 'boot_delay_msec' [-Werror=3Dimplicit-function-declaration]
>     2628 |  boot_delay_msec(r.info->level);
>          |  ^~~~~~~~~~~~~~~
> >> kernel/printk/printk.c:2629:2: error: implicit declaration of function=
 'printk_delay'; did you mean 'print_dev_t'? [-Werror=3Dimplicit-function-d=
eclaration]
>     2629 |  printk_delay();
>          |  ^~~~~~~~~~~~
>          |  print_dev_t
>    cc1: some warnings being treated as errors

I'm going to fold this in:

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 60c351afe7aa0..ae0cccf66b3cb 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2265,6 +2265,8 @@ static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
 static void call_console_driver(struct console *con, const char *text, siz=
e_t len) {}
 static bool suppress_message_printing(int level) { return false; }
+static inline void boot_delay_msec(int level) { }
+static inline void printk_delay(void) { }
=20
 #endif /* CONFIG_PRINTK */
=20
Sebastian

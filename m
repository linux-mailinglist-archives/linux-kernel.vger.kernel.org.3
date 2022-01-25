Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCFE49B43C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1454580AbiAYMpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:45:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55266 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452800AbiAYMmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:42:09 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E39101F380;
        Tue, 25 Jan 2022 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643114524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YLtlKuPoADWCEZcM/RaMVq/xOpaxcT6tevD1Rm+nUYA=;
        b=RpTppQc4leOl0T0HMyo5gixVuROCn5E/wZm/UJ3ydVYLXpETYI5XxkPWN8iGeYGvk6V54D
        NzTIVRjBTDVvht330nSPUP5ZudYliwjY9xILG9GIngoY3Lrhi/6ex4RUsLinCGc95O5u2d
        Sowt7oZFbRzjOLBJ158+QkuzD0chcjg=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9DB02A3B81;
        Tue, 25 Jan 2022 12:42:04 +0000 (UTC)
Date:   Tue, 25 Jan 2022 13:42:03 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] printk: disable optimistic spin during panic
Message-ID: <Ye/wG5IsIYer7akH@alley>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-3-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121190222.572694-3-stephen.s.brennan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-01-21 11:02:20, Stephen Brennan wrote:
> A CPU executing with console lock spinning enabled might be halted
> during a panic. Before the panicking CPU calls console_flush_on_panic(),
> it may call console_trylock(), which attempts to optimistically spin,
> deadlocking the panic CPU:
> 
> CPU 0 (panic CPU)             CPU 1
> -----------------             ------
>                               printk() {
>                                 vprintk_func() {
>                                   vprintk_default() {
>                                     vprintk_emit() {
>                                       console_unlock() {
>                                         console_lock_spinning_enable();
>                                         ... printing to console ...
> panic() {
>   crash_smp_send_stop() {
>     NMI  -------------------> HALT
>   }
>   atomic_notifier_call_chain() {
>     printk() {
>       ...
>       console_trylock_spinnning() {
>         // optimistic spin infinitely
> 
> This hang during panic can be induced when a kdump kernel is loaded, and
> crash_kexec_post_notifiers=1 is present on the kernel command line. The
> following script which concurrently writes to /dev/kmsg, and triggers a
> panic, can result in this hang:
> 
>     #!/bin/bash
>     date
>     # 991 chars (based on log buffer size):
>     chars="$(printf 'a%.0s' {1..991})"
>     while :; do
>         echo $chars > /dev/kmsg
>     done &
>     echo c > /proc/sysrq-trigger &
>     date
>     exit
> 
> To avoid this deadlock, ensure that console_trylock_spinning() does not
> allow spinning once a panic has begun.
> 
> Fixes: dbdda842fe96 ("printk: Add console owner and waiter logic to load balance console writes")
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

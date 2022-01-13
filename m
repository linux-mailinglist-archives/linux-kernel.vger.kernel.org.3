Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4F448DA8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiAMPPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:15:44 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:58508 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiAMPPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7U5GAp1ITx6KmvqRheWjRNK9gMJZD9llEqVhywwoFT0=; b=hVF8oV7eoWxXicrOJrXj3M91tj
        7ctAVRCo+yiyzrajRcmutGTXbgAqNTEHMRE/QEBUgUs1s2/bVPU4dhfEeeYtWwaOp9KDkIB4Xua7n
        vaKpaqLcCq+KpFvuAswsSsu+Ht1d+mc12AOkmf0xHzPb2wgBXZrfaiVJCN4GMg/MRt9tZ+v4vwj/K
        atXR57thAEHd/ubKhKwRGEILT2h/7LUR0tvsUqklcPeVhgb5s58A0D+VW4C3/bQ9CM6sy/aoqLgGQ
        E/ss8VrekFxoxp8wlx8TRfikFSNOlLbyOXH0K2HxQhdFNZ/7vIBzypefqru+I/xiMeeN2iUq1N1zP
        wIkPrFHQ==;
Received: from [179.113.53.20] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n81p1-000Bfa-Ou; Thu, 13 Jan 2022 16:15:27 +0100
Message-ID: <f25672a4-e4dd-29e8-b2db-f92dd9ff9f8a@igalia.com>
Date:   Thu, 13 Jan 2022 12:15:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V2] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kernel@gpiccoli.net, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, feng.tang@intel.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
References: <20220106212835.119409-1-gpiccoli@igalia.com>
 <Yd/0K1x7ILw3Qa46@alley> <ba0e29ba-0e08-df6e-ade5-eb58ae2495e3@igalia.com>
 <YeA1pXz7f0wqSnah@alley>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YeA1pXz7f0wqSnah@alley>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 11:22, Petr Mladek wrote:
> [...]
> OK, do we have any specific reason why panic_print_sys_info()
> should get called right before kmsg_dump() when this code patch
> is used?
> 
> Alternative solution would be to remove the check of
> kexec_crash_loaded() and always call panic_print_sys_info(false)
> at the beginning (after kgdb_panic(buf)).
> 
> The advantage is that panic_print_sys_info(false) will be always
> called on the same location. It will give the same results
> in all code paths so that it will be easier to interpret them.
> And it will have the same problems so it should be easier
> to debug and maintain.
> 
> It is possible that it will not work for some users. Also it is
> possible that it might cause some problems. But it is hard to
> guess at least for me.
> 
> I think that we might try it and see if anyone complains.
> Honestly, I think that only few people use panic_printk_sys_info().
> And your use-case makes sense.
> 
> Best Regards,
> Petr

Hi Petr, thanks for your idea - it's simple and effective, would resolve
the problems in a straightforward way. But there are some cons, let me
detail more.

Currently (in linux-next), if users set panic_print but not kdump, the
panic_print_sys_info() is called *after* the panic notifiers. If user
has kdump configured and still sets panic_print (which is our use case),
then panic_print_sys_info() is called _before_ the panic notifiers. In
other words, the behavior for non-kdump users is the same as before,
since the merge of panic_print functionality.

Your idea brings the printing earlier, always before the panic
notifiers. This isn't terrible, but might lead to unfortunate and
hard-to-debug problems; for example, some panic notifiers are
rcu_panic() and hung_task_panic(), both are simple functions to disable
RCU warnings and hung task detector in panic scenarios. If we go with
your idea, these won't get called before panic_print_sys_info(), even if
kdump is not set. So, since the panic_print triggers a lot of printing
in the console, we could face a stall and trigger RCU messages, maybe
intermixed with the panic_print information.

Again, this is not the end of the world, we could live with that. But
keeping two calls - and guarding against double print using
kexec_crash_loaded() as per your idea - is completely non-invasive and
doesn't change the current behavior.

So, let me know if we should go with your idea or keep both calls but
guarding against double printing to keep the current behavior untouched.
Both ways work for me, I'm slightly inclined to the latter, but I can
rework the patch if you prefer and use your idea!
Cheers,


Guilherme

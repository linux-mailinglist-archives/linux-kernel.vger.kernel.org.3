Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF8749B69F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388575AbiAYOkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:40:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:63378 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578140AbiAYOfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643121319; x=1674657319;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fZpRi7/n3jktDDT1JXT1mbo2A4Bg6HzZ1mzBBxuVaL8=;
  b=jsexsbHu6IL1WTfJqnDx3/9ynALR2FF3aU+VrPo1DL/+Sl3LLYnnjgMq
   Mz1n++b02SYUIKUYuGGvIejoWRfPOSiB6UNGAY8NSqrXAVECM+z35hPLk
   3QjnUF83IOayer+d0mOApwlzJJXZvb6/t3Oj7XC8/IOrwxLGDbX/ltdCE
   pcMwzxaaTFUiUayKEhn64KFWJ4AZEEv0wLQ1L+xzql9gLS+cMgBTBOh1J
   Aj9/UnBb9Oc1fzjSfYNBZliUutqITziVGetmj98+XBatUzVZuCIBR9beX
   VWY3hXmskGbpwfvSXfzNQtr5etoM/Rz3IQYocyayMA2OosB1+npbOZ62A
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="309628254"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="309628254"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 06:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="674005266"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 25 Jan 2022 06:32:25 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 25 Jan 2022 16:32:25 +0200
Date:   Tue, 25 Jan 2022 16:32:25 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pmalani@chromium.org, rafael@kernel.org,
        sakari.ailus@linux.intel.com
Subject: Re: 'Re: [PATCH v5 4/5] usb: typec: port-mapper: Convert to the
 component framework'
Message-ID: <YfAJ+b0G6Yvzhpxp@kuha.fi.intel.com>
References: <20211223082422.45637-1-heikki.krogerus@linux.intel.com>
 <20220125140033.1403-1-mike@fireburn.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125140033.1403-1-mike@fireburn.co.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:00:33PM +0000, Mike Lothian wrote:
> Hi
> 
> This patch is stopping my ASUS G513QY from booting correctly
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0 
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 1 PID: 116 Comm: kworker/1:1 Not tainted 5.16.0-rc6-tip+ #2991
> Hardware name: ASUSTeK COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.316 11/29/2021
> Workqueue: events_long ucsi_init_work
> RIP: 0010:component_master_add_with_match+0x11/0x190
> Code: cc cc 00 00 cc cc 00 00 cc 49 89 c9 49 89 d0 31 d2 31 c9 e9 c1 fe ff ff 00 55 41 57 41 56 41 54 53 48 89 d3 49 89 f4 49 89 ff <48> 8b 72 08 48 89 d7 e8 73 01 00 00 89 c5 85 c0 0f 85 55 01 00 00
> RSP: 0018:ffff8881029f7d48 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> RDX: 0000000000000000 RSI: ffffffff83095658 RDI: ffff888117658c08
> RBP: 0000000000000000 R08: ffff88810158e258 R09: ffffea00045d9e00
> R10: 0000001000000000 R11: ffffffff81be3720 R12: ffffffff83095658
> R13: ffff888117630a68 R14: ffff888117658c08 R15: ffff888117658c08
> FS:  0000000000000000(0000) GS:ffff888fde440000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 00000000ac20c000 CR4: 0000000000150ee0
> Call Trace:
>  <TASK>
>  ? typec_link_ports+0x45/0x50
>  ? typec_register_port+0x20f/0x260
>  ? ucsi_register_port+0x33c/0x700
>  ? __kmalloc+0x14e/0x2a0
>  ? ucsi_init_work+0x15a/0x330
>  ? process_one_work+0x1dd/0x380
>  ? worker_thread+0x26d/0x4a0
>  ? kthread+0x182/0x1a0
>  ? worker_clr_flags+0x40/0x40
>  ? kthread_blkcg+0x30/0x30
>  ? ret_from_fork+0x22/0x30
>  </TASK>
> Modules linked in:
> CR2: 0000000000000008
> ---[ end trace 9c7dfbb7c9eaa418 ]---
> RIP: 0010:component_master_add_with_match+0x11/0x190
> Code: cc cc 00 00 cc cc 00 00 cc 49 89 c9 49 89 d0 31 d2 31 c9 e9 c1 fe ff ff 00 55 41 57 41 56 41 54 53 48 89 d3 49 89 f4 49 89 ff <48> 8b 72 08 48 89 d7 e8 73 01 00 00 89 c5 85 c0 0f 85 55 01 00 00
> RSP: 0018:ffff8881029f7d48 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
> RDX: 0000000000000000 RSI: ffffffff83095658 RDI: ffff888117658c08
> RBP: 0000000000000000 R08: ffff88810158e258 R09: ffffea00045d9e00
> R10: 0000001000000000 R11: ffffffff81be3720 R12: ffffffff83095658
> R13: ffff888117630a68 R14: ffff888117658c08 R15: ffff888117658c08
> FS:  0000000000000000(0000) GS:ffff888fde440000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000008 CR3: 00000000ac20c000 CR4: 0000000000150ee0
> 
> Is it due to the USB-C port on the Radeon 6800M?

No. There is a fix pending:
https://lore.kernel.org/linux-usb/20220124090228.41396-3-heikki.krogerus@linux.intel.com/

-- 
heikki

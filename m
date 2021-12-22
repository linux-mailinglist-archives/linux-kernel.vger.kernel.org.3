Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9449247D31C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245462AbhLVNlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:41:00 -0500
Received: from foss.arm.com ([217.140.110.172]:45876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245436AbhLVNk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:40:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2729DD6E;
        Wed, 22 Dec 2021 05:40:58 -0800 (PST)
Received: from bogus (unknown [10.57.36.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADFD33F5A1;
        Wed, 22 Dec 2021 05:40:56 -0800 (PST)
Date:   Wed, 22 Dec 2021 13:40:53 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-acpi@vger.kernel.org, Justin He <justin.he@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] mailbox: pcc: Handle all PCC subtypes correctly in
 pcc_mbox_irq
Message-ID: <20211222134053.7yibtok42iluc5go@bogus>
References: <20211209092146.620024-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209092146.620024-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

On Thu, Dec 09, 2021 at 09:21:46AM +0000, Sudeep Holla wrote:
> Commit c45ded7e1135 ("mailbox: pcc: Add support for PCCT extended PCC
> subspaces(type 3/4)") enabled the type3/4 of PCCT, but the change in
> pcc_mbox_irq breaks the other PCC subtypes.
> 
> The kernel reports a warning on an Ampere eMag server
> 
> -->8
>  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-rc4 #127
>  Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 0.14 02/22/2019
>  Call trace:
>   dump_backtrace+0x0/0x200
>   show_stack+0x20/0x30
>   dump_stack_lvl+0x68/0x84
>   dump_stack+0x18/0x34
>   __report_bad_irq+0x54/0x17c
>   note_interrupt+0x330/0x428
>   handle_irq_event_percpu+0x90/0x98
>   handle_irq_event+0x4c/0x148
>   handle_fasteoi_irq+0xc4/0x188
>   generic_handle_domain_irq+0x44/0x68
>   gic_handle_irq+0x84/0x2ec
>   call_on_irq_stack+0x28/0x34
>   do_interrupt_handler+0x88/0x90
>   el1_interrupt+0x48/0xb0
>   el1h_64_irq_handler+0x18/0x28
>   el1h_64_irq+0x7c/0x80
> ---
> 
> The main reason for that is the command complete register is read as 0
> if the GAS register doesn't exist for the same which is the case for
> PCC subtypes 0-2. Fix it by checking for non-zero value before masking
> with the status flag and checking for command completion.
> 
> Fixes: c45ded7e1135 ("mailbox: pcc: Add support for PCCT extended PCC subspaces(type 3/4)")

Can you take this patch and [1] for v5.17 ? This one is a bug fix and good
to get it merged ASAP.

-- 
Regards,
Sudeep

[1]  https://lore.kernel.org/r/20211209082143.619354-1-sudeep.holla@arm.com

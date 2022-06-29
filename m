Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B21560335
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiF2Oh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiF2Ohz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:37:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39F7034BBB;
        Wed, 29 Jun 2022 07:37:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1AF0152B;
        Wed, 29 Jun 2022 07:37:53 -0700 (PDT)
Received: from [192.168.122.164] (U203867.austin.arm.com [10.118.30.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99A7C3F792;
        Wed, 29 Jun 2022 07:37:53 -0700 (PDT)
Message-ID: <df200560-9beb-0f11-ff5e-8186d81897bf@arm.com>
Date:   Wed, 29 Jun 2022 09:37:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/2] BUG, more dw8259 ACPI crashes
Content-Language: en-US
To:     linux-serial@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, miquel.raynal@bootlin.com,
        phil.edworthy@renesas.com, kernel@esmil.dk,
        linux-kernel@vger.kernel.org
References: <20220629000232.3440704-1-jeremy.linton@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20220629000232.3440704-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/28/22 19:02, Jeremy Linton wrote:
> 5.19rc4 crashes with:
> 
> [    4.441703] Internal error: Oops: 96000004 [#1] SMP
> [    4.446601] Modules linked in:
> [    4.449668] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.19.0-0.rc4.33.fc37.aarch64 #1
> [    4.457532] Hardware name: Marvell                         Armada 7k/8k Family Board      /Armada 7k/8k Family Board      , BIOS EDK II Jun  4 2019
> [    4.470800] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    4.477791] pc : dw8250_handle_irq+0x58/0x190
> [    4.482170] lr : dw8250_handle_irq+0x38/0x190
> [    4.486544] sp : ffff800008003e40
> [    4.489869] x29: ffff800008003e40 x28: ffffbe13be183980 x27: 00000000b46bd3d0
> [    4.497036] x26: ffffbe13bdbc3008 x25: ffff6f1447910f80 x24: ffff6f1447910f94
> [    4.504204] x23: 0000000000000012 x22: ffff6f144218fc80 x21: 0000000000000000
> [    4.511372] x20: 0000000000000007 x19: ffffbe13be7628d0 x18: ffff80000918b528
> [    4.518540] x17: ffffb103c0343000 x16: ffff800008004000 x15: 0000000000004000
> [    4.525706] x14: 0000000000000000 x13: 0000000000000030 x12: 0101010101010101
> [    4.532872] x11: ffffbe13be16f6d8 x10: 0000000000001d90 x9 : ffffbe13bc6b4f0c
> [    4.540040] x8 : ffffbe13be185770 x7 : 0000000000000000 x6 : 00000000296b5f4a
> [    4.547206] x5 : 00ffffffffffffff x4 : 0000000000010002 x3 : ffffbe13be7628d0
> [    4.554373] x2 : 0000000000000007 x1 : 0000000000000000 x0 : 0000000000000000
> [    4.561539] Call trace:
> [    4.563994]  dw8250_handle_irq+0x58/0x190
> [    4.568020]  serial8250_interrupt+0x68/0x140
> [    4.572307]  __handle_irq_event_percpu+0x68/0x230
> [    4.577034]  handle_irq_event+0x58/0x120
> [    4.580973]  handle_fasteoi_irq+0xcc/0x1c4
> [    4.585086]  generic_handle_domain_irq+0x38/0x50
> [    4.589723]  gic_handle_irq+0x50/0xe0
> [    4.593399]  call_on_irq_stack+0x2c/0x38
> [    4.597338]  do_interrupt_handler+0xdc/0xe0
> [    4.601539]  el1_interrupt+0x34/0x70
> [    4.605131]  el1h_64_irq_handler+0x18/0x24
> [    4.609244]  el1h_64_irq+0x68/0x6c
> [    4.612658]  arch_cpu_idle+0x18/0x2c
> [    4.616246]  default_idle_call+0x34/0x18c
> [    4.620273]  cpuidle_idle_call+0x154/0x1a0
> [    4.624388]  do_idle+0xa4/0xf4
> [    4.627455]  cpu_startup_entry+0x34/0x3c
> [    4.631394]  kernel_init+0x0/0x150
> [    4.634808]  arch_post_acpi_subsys_init+0x0/0x30
> [    4.639445]  start_kernel+0x474/0x490
> [    4.643121]  __primary_switched+0xc0/0xc8
> [    4.647148] Code: 7100305f 1a9f17f5 f100003f 7a400aa4 (b9400817)
> [    4.653267] ---[ end trace 0000000000000000 ]---
> 
> On an ACPI enabled Mcbin. This is again the result
> of the pdata information not being available on an
> ACPI machine. But since there are multiple commits
> I've broken this into to fixes. The first
> simply reverts the USR register change because it
> should be functionality transparent and I don't
> have a good way to tie ACPI ids to the hardware
> and the second fixes the later patch which uses it
> in the interrupt handler.

Hi,

I missed cd16044d7c38 ("serial: 8250: dw: enable using pdata with ACPI") 
in tty-linus, which fixes this. So please ignore this set, sorry about 
the noise.


Thanks,

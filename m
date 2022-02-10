Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BD64B0C50
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbiBJL1x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Feb 2022 06:27:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbiBJL1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:27:51 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D141AFFA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:27:51 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-93-R6hvbMvxNTmae4So0E8txw-1; Thu, 10 Feb 2022 11:27:49 +0000
X-MC-Unique: R6hvbMvxNTmae4So0E8txw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.28; Thu, 10 Feb 2022 11:27:48 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.028; Thu, 10 Feb 2022 11:27:48 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Stack backtrace is using the user RIP to read kernel instructions
Thread-Topic: Stack backtrace is using the user RIP to read kernel
 instructions
Thread-Index: AdgebqTuF8rficBfTb+qkw5iJAowgw==
Date:   Thu, 10 Feb 2022 11:27:48 +0000
Message-ID: <ba26737a487946718d7632fdc77988db@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following 'splat' on a 5.17.0-rc3 kernel:

BUG: scheduling while atomic: xxx
Modules linked in: xxx
Preemption disabled at:
xxx+0x3c/0xd0 [xxx]
CPU: 5 PID: 28197 Comm: xxx Tainted: P           OE     5.16.0-rc7+ #29
Hardware name: Supermicro X11SSV-Q/X11SSV-Q, BIOS 2.2b 02/12/2018
Call Trace:
 <TASK>
 dump_stack_lvl+0x4c/0x63
 (valid kernel stack)
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f90ea1febd6
Code: Unable to access opcode bytes at RIP 0x7f90ea1febac.
RSP: 002b:00007ffde8cd8188 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f90ea501740 RCX: 00007f90ea1febd6
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
R10: 00007f90ea1152a0 R11: 0000000000000246 R12: 00007f90ea501740
R13: 0000000000000001 R14: 00007f90ea50a708 R15: 0000000000000000
 </TASK>

The problem is all mine :-)
(Someone added a spin_lock_irqsave() around code that does msleep(1).)

But the dump of the opcode bytes is missing.
I think these would be the user code for the syscall (so boring).
OTOH I can't really imagine the code got swapped out.

I can't quite decide whether copy_code() (in dumpstack.c) tried to call
copy_from_kernel_nofault() and failed because of the user address,
or copy_from_user_nmi() failed.

But something is awry somewhere.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


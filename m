Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A84521626
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242127AbiEJNCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242129AbiEJNCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:02:49 -0400
Received: from mail.pcs.gmbh (mail.pcs.gmbh [89.27.162.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4BA25C2A9;
        Tue, 10 May 2022 05:58:50 -0700 (PDT)
Received: from mail.csna.de (mail.csna.de [89.27.162.50])
        by mail.pcs.gmbh with ESMTPA
        ; Tue, 10 May 2022 14:58:48 +0200
Received: from EXCHANGE2019.pcs.ditec.de (mail.pcs.com [89.27.162.5])
        by mail.csna.de with ESMTPA
        ; Tue, 10 May 2022 14:58:47 +0200
Received: from EXCHANGE2019.pcs.ditec.de (192.168.8.214) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 14:58:48 +0200
Received: from lxtpfaff.pcs.ditec.de (192.168.9.96) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22
 via Frontend Transport; Tue, 10 May 2022 14:58:48 +0200
Date:   Tue, 10 May 2022 14:58:48 +0200
From:   Thomas Pfaff <tpfaff@pcs.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v3] irq/core: synchronize irq_thread startup
In-Reply-To: <87mtfppqi8.ffs@tglx>
Message-ID: <b8e4951a-212a-ea30-662-b13a65cad3b7@pcs.com>
References: <552fe7b4-9224-b183-bb87-a8f36d335690@pcs.com> <87mtg0m2jb.ffs@tglx> <e64aa9cb-a1ae-7534-8bf1-446d9d8c512@pcs.com> <87pmklpqod.ffs@tglx> <87mtfppqi8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-KSE-ServerInfo: EXCHANGE2019.pcs.ditec.de, 9
X-KSE-AntiSpam-Interceptor-Info: white sender email list
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10.05.2022 10:11:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 May 2022, Thomas Gleixner wrote:

> It does matter whether the synchronization is done via
> __synchronize_hardirq() or via synchronize_irq(). The latter ensured
> that the thread reached the thread function and handled the pending
> wakeup _before_ kthread_stop() become true.
> 
> So the fix is required to undo the damage created by 519cc8652b3a.
> 
> The synchronize_irq() after free_irq() is a completely different
> problem.

Thank you for the clarification.
I was unsure if I missed something.

    Thomas



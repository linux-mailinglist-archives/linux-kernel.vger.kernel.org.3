Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9556D5213F5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241109AbiEJLlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241097AbiEJLlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:41:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42F81E02A1;
        Tue, 10 May 2022 04:37:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652182672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZSfFmrkwvSS3eqPLQm0swvWT7J06O/4HwkliRm/F5SM=;
        b=OEiCbePtGN9R41EOW696ItL6C4v7YwKobu5uOVsB+L+o+iwswSqbzIdwvnOziDbZ/VvoZU
        dOyb+BpTrmbpa+nlf0l1p/98oqfVvrbO3G/ssGco8YHzPLy7B/m6yG2xzm0mRVZmE2kvP6
        QrZ2A52cNzvhHgwKZbTkVNmLd+t1Zm49zIzaMGYqztZKGIINFKV0q0rk7oB7k683RF+EGU
        W/kkIrC5nysY83FAUW84NjiJH5hHfFJmEAsMrC/zzG94wkuarbvtg6t1iW+wvre9xztaoZ
        rndYiVERG2rjQrRQnY7Ip35MrVVS6xwC+gYN6tmICzc2qH7cJ0BHwFs4LYrI7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652182672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZSfFmrkwvSS3eqPLQm0swvWT7J06O/4HwkliRm/F5SM=;
        b=NScDfioIUhsbAhEVbrY6xPt32+yRjKpYvluxU1W6Kd7vfWHLaAGWWlIY/pD9y/R6fNiPcp
        etPv5GBX4lUEqlBw==
To:     Thomas Pfaff <tpfaff@pcs.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3] irq/core: synchronize irq_thread startup
In-Reply-To: <87pmklpqod.ffs@tglx>
References: <552fe7b4-9224-b183-bb87-a8f36d335690@pcs.com>
 <87mtg0m2jb.ffs@tglx> <e64aa9cb-a1ae-7534-8bf1-446d9d8c512@pcs.com>
 <87pmklpqod.ffs@tglx>
Date:   Tue, 10 May 2022 13:37:51 +0200
Message-ID: <87mtfppqi8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10 2022 at 13:34, Thomas Gleixner wrote:
> On Tue, May 10 2022 at 10:43, Thomas Pfaff wrote:
>> It can be done only before the interrupt thread is stopped, and free_irq() 
>> itself is already taking care about synchronizing, no matter if its done by 
>> __synchronize_hardirq() or by synchronize_irq(), like it was before commit 
>> 519cc8652b3a.
>
> No, it does not really take care about it. It can return with
> irq_desc::threads_active > 0 due to the interrupt thread being stopped
> before reaching the thread function. Think about shared interrupts.

Duh. Hit send too fast.

It does matter whether the synchronization is done via
__synchronize_hardirq() or via synchronize_irq(). The latter ensured
that the thread reached the thread function and handled the pending
wakeup _before_ kthread_stop() become true.

So the fix is required to undo the damage created by 519cc8652b3a.

The synchronize_irq() after free_irq() is a completely different
problem.

Thanks,

        tglx

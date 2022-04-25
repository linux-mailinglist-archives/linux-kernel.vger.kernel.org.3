Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7709150E25F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbiDYNyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238228AbiDYNyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:54:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC555A082;
        Mon, 25 Apr 2022 06:51:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AF77B8180A;
        Mon, 25 Apr 2022 13:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E302C385A7;
        Mon, 25 Apr 2022 13:51:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Z8dcto5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650894698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jIgd/PKWEzsWj3P5DRugWZ6j3osZ7OCTzMJj+6jxPmg=;
        b=Z8dcto5O+eDr7AHq4YeOfCJY3gUT3DE1z67dCpgQRonnlVYObKX4ITBlJAg05iG1eY5MId
        n0oNYHBpHuniyd6a+A+oYRpaJUzvzIgYWEPacSml21G/1Li4poweEZAz73SkIeuNthVens
        MHFMa7Cw0Y4pYPQGVBSNJwqE1zGt8mc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d0db84be (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 25 Apr 2022 13:51:38 +0000 (UTC)
Date:   Mon, 25 Apr 2022 15:51:35 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de, Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCH v6 13/17] x86: use fallback for random_get_entropy()
 instead of zero
Message-ID: <YmanZ3Gw5mIXSebE@zx2c4.com>
References: <20220423212623.1957011-1-Jason@zx2c4.com>
 <20220423212623.1957011-14-Jason@zx2c4.com>
 <871qxl2vdw.ffs@tglx>
 <Ymak7LJd6GnFxsOo@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ymak7LJd6GnFxsOo@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 03:41:00PM +0200, Jason A. Donenfeld wrote:
> .text:0000000000001A70 add_interrupt_randomness proc near
> .text:0000000000001A70                 movsxd  rcx, edi
> .text:0000000000001A73                 rdtsc
> .text:0000000000001A75                 shl     rdx, 20h
> .text:0000000000001A79                 mov     rdi, [rsp+0]
> .text:0000000000001A7D                 or      rax, rdx
> .text:0000000000001A80                 mov     rdx, offset irq_randomness
> .text:0000000000001A87                 mov     rsi, gs:__irq_regs
> .text:0000000000001A8F                 add     rdx, gs:this_cpu_off

For context, here's what your suggested change looks like:

.text:0000000000001AF0 add_interrupt_randomness proc near
.text:0000000000001AF0                 push    rbx
.text:0000000000001AF1                 movsxd  rbx, edi
.text:0000000000001AF4                 jmp     loc_25AA
.text:0000000000001AF9 loc_1AF9:                               ; CODE XREF: add_interrupt_randomness+AC1↓j
.text:0000000000001AF9                 rdtsc
.text:0000000000001AFB                 shl     rdx, 20h
.text:0000000000001AFF                 or      rax, rdx
.text:0000000000001B02
.text:0000000000001B02 loc_1B02:                               ; CODE XREF: add_interrupt_randomness+12C↓j
.text:0000000000001B02                 mov     rdx, offset irq_randomness
.text:0000000000001B09                 mov     rcx, gs:__irq_regs
.text:0000000000001B11                 add     rdx, gs:this_cpu_off
[...]
.altinstr_aux:00000000000025AA loc_25AA:                               ; CODE XREF: add_interrupt_randomness+4↑j
.altinstr_aux:00000000000025AA                 test    byte ptr cs:boot_cpu_data+20h, 10h
.altinstr_aux:00000000000025B1                 jnz     loc_1AF9
.altinstr_aux:00000000000025B7                 jmp     loc_1C17

So an extra push, and then that jmp gets nop'd out (I hope). Plus the
altinstr area. I guess that's not awful, but I fail to see what we
actually gain here over the existing code, which doesn't bother messing
with this at runtime when the kernel builder opts out. The ifdef has
always been there; what's the reason for adding it now in 2022?
Virtualization cannot be it.

Jason

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1151F5362BD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348566AbiE0Mkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348161AbiE0Mjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:39:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344039168
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:26:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L8kYz6fyQz4xZB;
        Fri, 27 May 2022 22:26:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1653654392;
        bh=8kHf9FvKoHisBOT3iB2GGapbJm7MtDFPMUhFTVufFU4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=h6xTWr/xIbNE5MMIhiyYm/Ksq4u7oSNskaIOA2dh4qtrXrJF6EBw1CiDynfHqRenx
         tXNri7tGcG+wzkUrdSRUTnZwJI9ydqvyoFvOMhdY8AutAUHUFaXKTkpvmafINEZflS
         JAwQFJ5y9KvXdq5CGPqvr1fFNI8XaKb0M+CfMHKiKQ6gsOnN/ifF0Jk/eLm7nfowl5
         8X0KCK7QeYSbq6JaoNNqdRIQnZHwKG/vhu2nU+sV54yPy521lkeaocrDaMLC54cPpJ
         kgCTuXNh9747S8/IL3L+jwK2KYSVTcqaA1TGdkhCmuevzBzEXISQN07ANLOM3xARsd
         vgcARLrxqufGg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Guenter Roeck <linux@roeck-us.net>,
        Peter Collingbourne <pcc@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] printk: stop including cache.h from printk.h
In-Reply-To: <20220523142452.GA3164183@roeck-us.net>
References: <20220427195820.1716975-1-pcc@google.com>
 <20220523142452.GA3164183@roeck-us.net>
Date:   Fri, 27 May 2022 22:26:28 +1000
Message-ID: <87y1ynkvpn.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:
> On Wed, Apr 27, 2022 at 12:58:19PM -0700, Peter Collingbourne wrote:
>> An inclusion of cache.h in printk.h was added in 2014 in
>> commit c28aa1f0a847 ("printk/cache: mark printk_once test variable
>> __read_mostly") in order to bring in the definition of __read_mostly. The
>> usage of __read_mostly was later removed in commit 3ec25826ae33 ("printk:
>> Tie printk_once / printk_deferred_once into .data.once for reset")
>> which made the inclusion of cache.h unnecessary, so remove it.
>> 
>> We have a small amount of code that depended on the inclusion of cache.h
>> from printk.h; fix that code to include the appropriate header.
>> 
>> This fixes a circular inclusion on arm64 (linux/printk.h -> linux/cache.h
>> -> asm/cache.h -> linux/kasan-enabled.h -> linux/static_key.h ->
>> linux/jump_label.h -> linux/bug.h -> asm/bug.h -> linux/printk.h) that
>> would otherwise be introduced by the next patch.
>> 
>> Build tested using {allyesconfig,defconfig} x {arm64,x86_64}.
>
> But not powerpc:corenet64_smp_defconfig, where it results in lots of
> build errors such as
>
> powerpc64-linux-ld: fs/freevxfs/vxfs_fshead.o:(.bss+0x0):
> 	multiple definition of `____cacheline_aligned';
> 	fs/freevxfs/vxfs_bmap.o:(.bss+0x0): first defined here

I sent a patch to fix it, and will merge the fix via my tree:

http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220527112035.2842155-1-mpe@ellerman.id.au/

cheers

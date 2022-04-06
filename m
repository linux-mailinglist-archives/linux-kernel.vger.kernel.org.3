Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E24F5CBE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiDFLop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiDFLoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:44:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CE65857E8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:30:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id p15so2786684lfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SCKZqgCi3PtFGSDXkz/WMuyQV3cdA+J7prWZVg1YWbs=;
        b=TyvMpMUbt31Ysj9Fc/+vh86RKCcvo6OnmtNUmwrsCaotOfR8DkxNghoTyLAX/7axC1
         hqHINnGcyQvd9Xyu2uwXExFdhI+G0CdR6x7UEW1WTrJbbLZ3flcVUTmWZvdGbuPrJ9rC
         Mg/g1Qd+9u/TzZgzi7zumvP35+tC52NUIfV60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SCKZqgCi3PtFGSDXkz/WMuyQV3cdA+J7prWZVg1YWbs=;
        b=RCiLmHQB4x/U1FjK3lBS19i5ZMfB7o5b5Jsgf0PGHLy4zXvDLmDJhbED7sMaX7M04m
         mTa+NDZ5YXIS1wqJDYDApMOVILu3V4gMPl5UUKxyd+Y+r+WLAzpFEEXWOOFezJyzCTPh
         cUTHGwrlZM0m4cKzQoa73dVmiDl6ZkD6gbUb/Xzp/HSshYsaosuZgYoeLKkJloUIhR4E
         UxCDJit15FdE0pwjcV3CuADiZu3Bbzuxa+wN4FEc7YbpwUcHgHFpZcKyjfARgQT77c4a
         ConHW5nnWSXbqbbU7joRZ89lKWq3ImU+Tqvayyeq3Lu+SzsiD/i5aPo80GgikVq1eFzp
         rPyw==
X-Gm-Message-State: AOAM5317J8STNPeVrrTgsoX56kjYj1oBtuasRqVSfkLZ/39R3XKZLWHT
        EUKB4U9aoljJ69X8nyKs9cdTEQ==
X-Google-Smtp-Source: ABdhPJx8TPy213ruGo/58y5WqOOIerENqAQR6I3YAx6hbCBNhViJxXFVnzCyEKsCLHONvWCl6kcUxQ==
X-Received: by 2002:a05:6512:1045:b0:44a:6422:4c8 with SMTP id c5-20020a056512104500b0044a642204c8mr5505234lfb.253.1649233834119;
        Wed, 06 Apr 2022 01:30:34 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o3-20020a198c03000000b00448b7b1780csm1765878lfd.63.2022.04.06.01.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 01:30:33 -0700 (PDT)
Message-ID: <cf7449c2-71ef-aed1-c871-c9ae7202b3fc@rasmusvillemoes.dk>
Date:   Wed, 6 Apr 2022 10:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/5] x86/alternative: record .altinstructions section
 entity size
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
References: <20220311144312.88466-1-adobriyan@gmail.com>
 <20220311144312.88466-3-adobriyan@gmail.com>
 <20220312211740.GG28057@worktop.programming.kicks-ass.net>
 <Yi4ybwog/H4gk5Ts@localhost.localdomain> <87o81f1gh9.ffs@tglx>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <87o81f1gh9.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2022 21.24, Thomas Gleixner wrote:
> On Sun, Mar 13 2022 at 21:05, Alexey Dobriyan wrote:

> That does not matter. M merges any duplications in sections with the
> same [section] name, entity size and flags.
> 
>      .pushsection .bar "aM" @progbits, 4
>      .byte 0x01, 0x02, 0x03, 0x04
>      .popsection
> 
>      .pushsection .bar "aM" @progbits, 4
>      .byte 0x01, 0x02, 0x03, 0x04
>      .popsection
> 
> Will create a section .bar with lenght 4 and the content:
>      0x1,0x2,0x3,0x4
> 
> What saves you here is the fact that the altinstruction entries are
> guaranteed to be unique, but that wants a big fat comment.

Actually, I think what saves this is that the linker at least currently
ignores the merge flag for sections with relocations; from binutils
bfd/merge.c:

  if ((sec->flags & SEC_RELOC) != 0)
    {
      /* We aren't prepared to handle relocations in merged sections.  */
      return true;
    }

I do think it is theoretically possible for two altinstruction entries
to end up being identical after relocations have been applied (same
relative offsets to both the .text section and their replacement
instructions).

Rasmus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D44ADB7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 15:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377790AbiBHOqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 09:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351484AbiBHOqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 09:46:37 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B809C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 06:46:36 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v47so25521776ybi.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 06:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pXLh2jk1Z5DyKwbaDzU4ZXUm9KkKKdIX40yYnKqb7yU=;
        b=cnvuxvrhvCSz2YmLeAMBE3Hkn3heyjZmftsHbRe8SM5jMXKaeRDWGmnoiJ4LdP45fs
         cmoNsUcPmqdKYy7P/7A2H2rELJspjJYoTzrw1YeseidbjIExfym9T04B4ATWwLd/eax8
         xaA7Zn3fEHzzxCDuQc8Gx6VaIs4Ll3nRB2FHFxVuir63eVR2FRDDq2VZda/ptZQz+IlJ
         I3FXBGv4xmfaVXl59O0k6wdq7ppKKCwwCz++WOwFeh5qiRmunHsPKNsJw7f5o+zxz2dV
         a68oS23gXJsfngJlXc+SQqn4l8s+iJhmqR93xwXxOFpnVSMcqZ60XBiqcQ1SyRge3+Qf
         oeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pXLh2jk1Z5DyKwbaDzU4ZXUm9KkKKdIX40yYnKqb7yU=;
        b=7euR3XMN5nsv7DJWjHoH2YVmJp9e8UwMDHWt8TeB0xgMsQtAn8ckD6pl3LA89CEYcr
         uoB6130EXB3G4YJb+RvXIeFOA6zZ87Ahvy6AXK7cXpqp+8cZfyfUMEKMBn+Jl7NNdJOn
         H6xY7qfVkdD0SjiZZmk1tycTRyf3bGCh5ZpkLucqhMssrjIo2FMWfE5acEiR+3bZVcRb
         XX55R/hzB/QOiyI+2Tt9NWrDTLpl+RL3E3PSgYnMZgRJH8CZGRu+Q4lHhPwCb1SGXti3
         41nt7ZYm9eiizOZfJLOFvm5v1AO38S7ZY06XSMIX1zbJF7zlQZlDOMKD72oyDzjJVszA
         cebA==
X-Gm-Message-State: AOAM532wAxAtQdpxUC/atXGoWOKTefPixBYzAcIHU1PEecBbbFxKBGfW
        QdThqLo3epOFh4KrUEOwbdUESxHd9mpsEL+D/uCHvw==
X-Google-Smtp-Source: ABdhPJw3zLZ5rb2vMvO+voneN64QRVGVtNXPYGq81Iy7mzFGfJ7V55MCZB4lYrvRxvM1YX+ZdXb5MaH4Hac/AkZKLXc=
X-Received: by 2002:a05:6902:120f:: with SMTP id s15mr5231070ybu.612.1644331595542;
 Tue, 08 Feb 2022 06:46:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:174d:0:0:0:0:0 with HTTP; Tue, 8 Feb 2022 06:46:35 -0800 (PST)
In-Reply-To: <202202071351.AEEEA92@keescook>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-5-martin.fernandez@eclypsium.com> <202202071351.AEEEA92@keescook>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 8 Feb 2022 11:46:35 -0300
Message-ID: <CAKgze5YORW6b4ePx=0v22gKcEEh2iF6eh+W5pYv+OprmfsucqQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] x86/e820: Tag e820_entry with crypto capabilities
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Feb 03, 2022 at 01:43:26PM -0300, Martin Fernandez wrote:
>> Add a new enum for crypto capabilities.
>>
>> Add a new member in e820_entry to hold whether an entry is able to do
>> hardware memory encryption or not.
>>
>> Add a new function e820__range_set_crypto_capable to mark all the
>> entries in a range of addresses as encryptable. This will be called
>> when initializing EFI.
>>
>> Change e820__update_table to handle merging and overlap problems
>> taking into account crypto_capable.
>>
>> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
>> ---
>>  arch/x86/include/asm/e820/api.h   |   1 +
>>  arch/x86/include/asm/e820/types.h |  12 +++-
>>  arch/x86/kernel/e820.c            | 114 ++++++++++++++++++++++++++++--
>>  3 files changed, 119 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/e820/api.h
>> b/arch/x86/include/asm/e820/api.h
>> index e8f58ddd06d9..4b3b01fafdd1 100644
>> --- a/arch/x86/include/asm/e820/api.h
>> +++ b/arch/x86/include/asm/e820/api.h
>> @@ -17,6 +17,7 @@ extern bool e820__mapped_all(u64 start, u64 end, enum
>> e820_type type);
>>  extern void e820__range_add   (u64 start, u64 size, enum e820_type
>> type);
>>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type
>> old_type, enum e820_type new_type);
>>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type
>> old_type, bool check_type);
>> +extern u64  e820__range_set_crypto_capable(u64 start, u64 size);
>>
>>  extern void e820__print_table(char *who);
>>  extern int  e820__update_table(struct e820_table *table);
>> diff --git a/arch/x86/include/asm/e820/types.h
>> b/arch/x86/include/asm/e820/types.h
>> index 314f75d886d0..aef03c665f5e 100644
>> --- a/arch/x86/include/asm/e820/types.h
>> +++ b/arch/x86/include/asm/e820/types.h
>> @@ -46,6 +46,11 @@ enum e820_type {
>>  	E820_TYPE_RESERVED_KERN	= 128,
>>  };
>>
>> +enum e820_crypto_capabilities {
>> +	E820_NOT_CRYPTO_CAPABLE	= 0,
>> +	E820_CRYPTO_CAPABLE	= 1,
>> +};
>
> Is this expected to grow beyond a bool?
>

People commented that maybe it was a good idea to have the source of
the cryptographic capabilities, in this case that would be the EFI
memmap. So this could grow in that case.

Also the enum makes it self explanatory while using it in the code.

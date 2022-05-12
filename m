Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA42525309
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356721AbiELQzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356729AbiELQy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:54:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA24268E81
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:54:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652374491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g9OGQXFAdNRLEL0zQyUEGtTMfeAi/qDPt3Ou0IhrCyA=;
        b=humB9ohVLnjzd2kRNuT8ycEQB3h9tIwwGsvI43HGZ7uU6RozFrxyYg0LzVFMYJVPRxemDl
        Ax2c+QiMKrTeCoFHAkPPMYky92ENjr78VTxLzu1SFlARzpp+bSeUssVIf2a7g5YjUtLHNy
        9cq8hLK/PbUMUhrtsKxHCp2JGxd74ObXPOzvn2quAiUtEEDXdtSaUX+PmpNdKAu/xLaJ5H
        y63d0n1T0NW+M888d0zM1EYDXHpUQ914DuUvzzgOjf1AOcm4J+FbGIMZbBzhu9du3wSVEO
        29tS+6CWbeAQLfOYSiNqN8QSTxza49pYwwPJr/AxeIrPQOJXCxQusoJgruh5JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652374491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g9OGQXFAdNRLEL0zQyUEGtTMfeAi/qDPt3Ou0IhrCyA=;
        b=GEeW32UrEoUxxZjjq6f1C6V9X3+MVLoiOcoOUqpXdmbWLD6TYJMYNiexOlmlUi4rIiuvF8
        AasoTkPkiZS3unCg==
To:     David Hildenbrand <david@redhat.com>,
        Adrian-Ken Rueegsegger <ken@codelabs.ch>,
        dave.hansen@linux.intel.com, osalvador@suse.de
Cc:     luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Fix marking of unused sub-pmd ranges
In-Reply-To: <8f2af450-1080-2dcd-9c85-6190e7e14f27@redhat.com>
References: <20220509090637.24152-1-ken@codelabs.ch>
 <20220509090637.24152-2-ken@codelabs.ch>
 <8f2af450-1080-2dcd-9c85-6190e7e14f27@redhat.com>
Date:   Thu, 12 May 2022 18:54:50 +0200
Message-ID: <87bkw2vgh1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12 2022 at 11:04, David Hildenbrand wrote:
> On 09.05.22 11:06, Adrian-Ken Rueegsegger wrote:
>>  static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
>>  {
>> +	const unsigned long page = ALIGN_DOWN(start, PMD_SIZE);
>> +
>>  	vmemmap_flush_unused_pmd();
>>  
>>  	/*
>> @@ -914,8 +916,7 @@ static void __meminit vmemmap_use_new_sub_pmd(unsigned long start, unsigned long
>>  	 * Mark with PAGE_UNUSED the unused parts of the new memmap range
>>  	 */
>>  	if (!IS_ALIGNED(start, PMD_SIZE))
>> -		memset((void *)start, PAGE_UNUSED,
>> -			start - ALIGN_DOWN(start, PMD_SIZE));
>> +		memset((void *)page, PAGE_UNUSED, start - page);
>>  
>>  	/*
>>  	 * We want to avoid memset(PAGE_UNUSED) when populating the vmemmap of
>
> As the x86 code was based on my s390x code, I assume that this was
> accidentally introduced in the x86 variant.
>
> We'd be marking the wrong range PAGE_UNUSED.
>
> Your fix looks correct to me:
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
> Do we want to cc stable?

Yes, we'll add it when picking it up.

I really have to ask why this duplicated code exists in the first
place. There is zero architecture specific code neither in the s390 nor
in the x86 version.

The x86 version is just copy & pasta & fatfinger, if I'm not missing
something here.

Thanks,

        tglx


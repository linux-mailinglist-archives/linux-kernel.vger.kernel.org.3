Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940D0562AB0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiGAE46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiGAE44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:56:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77DD677ED
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 21:56:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y16so1858544lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 21:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ts7/6XIgqtm7zFWkYl/wnII7pFGk0McWbhODvlvNc3g=;
        b=3x6oe1TF4J9u2O6G4YQqUgNdqjqsFOTnH7T2uLWVm9GDxnE0+x6i8TSF55vziafIax
         dPZkRsjSLNsn/CVTt/rftMKXf4EcJr07uMyqUHaW0TmfkfE1U0j8or0sQWUxnRrch5wI
         O5ko7fIgxJiKEhh5Atf0P0fhDq3mz3JatCiBIiiB8tNRs++K/pvGCnA0qVOdV5GxD4BH
         XAUazCQQa9G/7Aej2Gog6308DkrsXToAHZUlL/cIs/7Uok5tSfyRfdZaJ8L/U5Yr/0Ma
         EoWYuzBskbBlZ4SlMB42JEOc/4MVK4iSXBbDrzgL0W8Ea+SbiwqZ13vnt72nF7CtPm1j
         HywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ts7/6XIgqtm7zFWkYl/wnII7pFGk0McWbhODvlvNc3g=;
        b=K7YD/Nj2tylI6d7EMpB54ozX/hPsVPvuoI1Ug3qhCldC15F7kt1eXcPIPgZq2ZVyAx
         z9aahPBvE2tZVaA4SzTkDraviKKgkfiR219iosVl3o5v0w6QxvzYz6DRX/IYedV2oSae
         z3DT+yXXj8lAwKaOERuf2SkYCrvDthziakLgs3tOLcnG8xyO0ZczVD8ZqwLFRubOEVyW
         +DPFMI0J5bGQlcpX/cBF6lRs5Hx//eKe2sgl8pfZPZs3IYAx0EOn1OOKGGUdML4W9ZKs
         WDLOqYZcZG35qGyZw39gxvX94yAkiA8v1rr/zYVKQokcTQmZVhax8QxIL0/D7Gz9PzSS
         uBcQ==
X-Gm-Message-State: AJIora9LUg5v8rPNX4gJ7ke8hI38Ge51/A5isw6ivzY7nWmEb9jlzevO
        5cuy0TzLXd6opxRSaJeeO9KvsQ==
X-Google-Smtp-Source: AGRyM1s/yQOhwOSg1pgy4pjzXpXTd2JZW9opcpb+sYEIteOw5Rl7hifFh8D/H+n2CzOBxArrgYIQtg==
X-Received: by 2002:a19:674a:0:b0:47f:863d:5bc2 with SMTP id e10-20020a19674a000000b0047f863d5bc2mr7856482lfj.92.1656651413138;
        Thu, 30 Jun 2022 21:56:53 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id q15-20020a19f20f000000b0047f6b8c2127sm3428940lfh.186.2022.06.30.21.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 21:56:52 -0700 (PDT)
Message-ID: <0d722c7f-8004-2bff-6645-95ca337292e7@openvz.org>
Date:   Fri, 1 Jul 2022 07:56:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/fault: ignore RSVD flag in error code if P flag is 0
Content-Language: en-US
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        steve.sipes@comandsolutions.com
References: <9bc8de5f-fd80-57fe-0169-0ec942638299@openvz.org>
 <85bd8614-9a55-3113-e5a8-b7e73f636135@openvz.org>
 <AA872C07-ED54-4497-8255-F67F40EB8179@zytor.com>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <AA872C07-ED54-4497-8255-F67F40EB8179@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 03:42, H. Peter Anvin wrote:
> On June 29, 2022 10:58:36 PM PDT, Vasily Averin <vvs@openvz.org> wrote:
>> Some older Intel CPUs have errata:
>> "Not-Present Page Faults May Set the RSVD Flag in the Error Code
>>
>> Problem:
>> An attempt to access a page that is not marked present causes a page
>> fault. Such a page fault delivers an error code in which both the
>> P flag (bit 0) and the RSVD flag (bit 3) are 0. Due to this erratum,
>> not-present page faults may deliver an error code in which the P flag
>> is 0 but the RSVD flag is 1.
>>
>> Implication:
>> Software may erroneously infer that a page fault was due to a
>> reserved-bit violation when it was actually due to an attempt
>> to access a not-present page.
>>
>> Workaround: Page-fault handlers should ignore the RSVD flag in the error
>> code if the P flag is 0."
>>
>> This issues was observed on several nodes crashed with messages
>> httpd: Corrupted page table at address 7f62d5b48e68
>> PGD 80000002e92bf067 PUD 1c99c5067 PMD 195015067 PTE 7fffffffb78b680
>> Bad pagetable: 000c [#1] SMP
>>
>> Let's follow the recommendation and will ignore the RSVD flag in the
>> error code if the P flag is 0
>>
>> Link: https://lore.kernel.org/all/aae9c7c6-989c-0261-470a-252537493b53@openvz.org
>> Signed-off-by: Vasily Averin <vvs@openvz.org>
>> ---
>> arch/x86/mm/fault.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index fe10c6d76bac..ffc6d6bd2a22 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -1481,6 +1481,15 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
>> 	if (unlikely(kmmio_fault(regs, address)))
>> 		return;
>>
>> +	/*
>> +	 * Some older Intel CPUs have errata
>> +	 * "Not-Present Page Faults May Set the RSVD Flag in the Error Code"
>> +	 * It is recommended to ignore the RSVD flag (bit 3) in the error code
>> +	 * if the P flag (bit 0) is 0.
>> +	 */
>> +	if (unlikely((error_code & X86_PF_RSVD) && !(error_code & X86_PF_PROT)))
>> +		error_code &= ~X86_PF_RSVD;
>> +
>> 	/* Was the fault on kernel-controlled part of the address space? */
>> 	if (unlikely(fault_in_kernel_space(address))) {
>> 		do_kern_addr_fault(regs, error_code, address);
> 
> Are there other bits we could/should mask.out in the case P = 0? The
> only bits that should be able to appear are ones that are independent
> of the PTE content.
In accordance with the "Intel® 64 and IA-32 Architectures Software Developer’s
Manual Volume 3A: System Programming Guide, Part 1" there are several other
similar bits:
http://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-manual-325462.pdf

"4.7 PAGE-FAULT EXCEPTIONS
...
• HLAT (bit 7).
This flag is 1 if there is no translation for the linear address using HLAT 
paging because, in one of the paging structure entries used to translate that
address, either the P flag was 0 or a reserved bit was set. An error code will
set this flag only if it clears bit 0 or sets bit 3. This flag will not be set
by a page fault resulting from a violation of access rights, nor for one
encountered during ordinary paging, including the case in which there has been
a restart of HLAT paging.

• SGX flag (bit 15).
This flag is 1 if the exception is unrelated to paging and resulted from 
violation of SGX-specific access-control requirements. Because such a violation
can occur only if there is no ordinary page fault, this flag is set only if
the P flag (bit 0) is 1 and the RSVD flag (bit 3) and the PK flag (bit 5)
are both 0."

However, only the RSVD flag has errata in real processors.
So I don't think any other bits should be masked in some way.

Thank you,
	Vasily Averin

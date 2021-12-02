Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3DF466124
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346091AbhLBKJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:09:37 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38633 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346149AbhLBKJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:09:13 -0500
Received: by mail-ed1-f54.google.com with SMTP id x6so113387476edr.5;
        Thu, 02 Dec 2021 02:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=HbzldBUJP1MUNJZO4fQ5VmGc+gsf1iO1NZb/2FiG3ZU=;
        b=QkWdqGoARfffpqf43O5lUKVB3yoan59dg0OY0tXai/mQRRAnfXZrBHKatrzZ5phXIH
         epUfjHSb2GODcni5WfEm8/zC0coyriJ6VO1DhnkzFQna0zhAP5H579busqSoZ1O1x9+3
         OSZD8kY061DWQOWAtMKA0qiGpSGetMMAiSZzjnSqZM0txXNoj+dkXUmr87BoJVdjzRZR
         4Vncl7FHnrsKnXT+ZqDymDe3cOyoSt1qmM+OsuP2AsLjA9z8ABLDHVP9Mp1hRJvj5LfX
         fjb67LLrzezL4MJSoFbytIVMHWgIkCiEsVZ4V/Qn+czg3vDd1SPi7olEl3FA9t4fR8eH
         S9tg==
X-Gm-Message-State: AOAM532pghtSrx3VEBfqbXW3DLbkU/DF8mpT/YvN9+YQQly1ZrkglhO4
        3u3Q0MnB2G7dQ5fotm+ua8I=
X-Google-Smtp-Source: ABdhPJzNq+N4jwOuPIoCKvpLKKUDpk/ZJj48UecZF/uHnYX1nTHZUhIjFXa8yjVHQt/bB469ZPQ9yg==
X-Received: by 2002:a17:907:8a1a:: with SMTP id sc26mr14134432ejc.402.1638439549320;
        Thu, 02 Dec 2021 02:05:49 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id f7sm1780835edl.33.2021.12.02.02.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 02:05:48 -0800 (PST)
Message-ID: <172f894c-01ab-cd9f-3292-1ba811f7222a@kernel.org>
Date:   Thu, 2 Dec 2021 11:05:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 3/3] x86: mm: add x86_64 support for page table check
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, masahiroy@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        frederic@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com>
 <20211123214814.3756047-4-pasha.tatashin@soleen.com>
 <f81a6434-9f38-947e-02a8-9a9191285e52@kernel.org>
 <cadf2582-3004-92b9-ab5a-cb39259fa36c@kernel.org>
 <CA+CK2bBfcrxDyxnV+xc680AP+sJGHSpong6a+b_vvWcRsB2CcA@mail.gmail.com>
 <a0968570-a25a-a7e3-3ee5-b7275286c9d1@kernel.org>
In-Reply-To: <a0968570-a25a-a7e3-3ee5-b7275286c9d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 12. 21, 10:59, Jiri Slaby wrote:
> On 01. 12. 21, 14:55, Pasha Tatashin wrote:
>> On Wed, Dec 1, 2021 at 3:44 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>>
>>> On 01. 12. 21, 9:00, Jiri Slaby wrote:
>>>> On 23. 11. 21, 22:48, Pasha Tatashin wrote:
>>>>> Add page table check hooks into routines that modify user page tables.
>>>>
>>>> Hi,
>>>>
>>>> I bisected to this as this causes crashes during modules load:
>>>
>>> And it's not enough to unset CONFIG_PAGE_TABLE_CHECK_ENFORCED. I had to
>>> unset CONFIG_PAGE_TABLE_CHECK completely to get rid of this.
>>
>> Hi,
>>
>> Thanks for reporting this. Seems like module load for some reasons
>> does not like the static branches. However, I was not able to repro
>> this. Could you please share your config and the module that you were
>> loading?
> 
> It's the openSUSE's -next config:
> https://raw.githubusercontent.com/openSUSE/kernel-source/linux-next/config/x86_64/vanilla 
> 
> 
> But with CONFIG_IWLMEI=n (as that fails to link).
> 
> One has to load i915, other modules (71 on my system) are apparently fine.
> 
> i915 tries to patch your `page_table_check_disabled' which is defined as 
> `DEFINE_STATIC_KEY_TRUE_RO':
>  > jump_label_add_module: key=__tracepoint_mmap_lock_released 
> (ffffffff93f36d88) mod=0000000000000000
>  > jump_label_add_module: key=hugetlb_free_vmemmap_enabled_key 
> (ffffffff94873560) mod=0000000000000000
>  > jump_label_add_module: key=devmap_managed_key (ffffffff94902700) 
> mod=0000000000000000
>  > jump_label_add_module: key=page_table_check_disabled 
> (ffffffff939da760) mod=0000000000000000
>  > BUG: unable to handle page fault for address: ffffffff939da768

Provided you EXPORT page_table_check_disabled and it can be used from 
modules, it can be barely marked as RO. So the below indeed fixes the 
problem for me:

--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -18,7 +18,7 @@ struct page_table_check {
  static bool __page_table_check_enabled __initdata =
 
IS_ENABLED(CONFIG_PAGE_TABLE_CHECK_ENFORCED);

-DEFINE_STATIC_KEY_TRUE_RO(page_table_check_disabled);
+DEFINE_STATIC_KEY_TRUE(page_table_check_disabled);
  EXPORT_SYMBOL(page_table_check_disabled);

  static int __init early_page_table_check_param(char *buf)

> 
> regards,


-- 
js
suse labs

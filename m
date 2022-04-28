Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FF0513AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbiD1RQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 13:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiD1RQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 13:16:21 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294B05B3CB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:13:06 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id k25-20020a056830169900b00605f215e55dso187835otr.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UBP7y2RvEXxVN92BvqAi7m+pLWAZ5atsFjO8+tg56fk=;
        b=Vcv2k97RR1epKhR1NUb5TDyl7ffQ1Gs/U2EaOWViBSxBV2K5mnoTB5Dk7V8rgEsnzA
         Xh9twu69XPL3owjHPgs5K57Dq1UH4/7JUWsjLn98QLs43+U7mAUW0/33O7buWhhnvVjw
         HjYfxbtbuBtzNqyn1y39tXpMn6AU+Gz3C/FmVTUCX4mKHO3TETxqe2xtUOOEBdansDGm
         2+kdDl/4yRszPMS5PVPaOz+IXghdzI9Hie1E4xFN5jT97E71Ma+JvES94/1S99h/VKor
         EPl23NnvKb1SrBAZIuHoSwWcIVwPdaC0aOfjdJu61qAGz+4bQH1bE7KOoGL14zd2HHig
         pnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UBP7y2RvEXxVN92BvqAi7m+pLWAZ5atsFjO8+tg56fk=;
        b=2mXfyFHFMDbYQF0iafnG3GnIlQHxRI8ARLMv/qV7gGaVhR5z7+WJGjXn/nFLeOhgDQ
         5EBxBptWXMaq0a7V2uoztOWF9GbHE4zS0nc2rblxhZ8EOf6DkSHCWd7uqyoQzCfIn+eP
         CJhFvESZWtvs3kF1O807qNa8rj0mNhhi0JzdGMAIYwcqjIKL1j9ukDrbZzCOw7NghlcZ
         sMpM4mGcmTWw57DTHSE4qkcluKrEbf/c9AwtVlv81JWg0703z8lp8Ad/v+lIecgsuh4t
         1SC6KPLxSpoDFYLqKfqhNa3h2mIH5r6s8Vec2F1OIhIboiXgPPpQeCecmUz1ffFp+lxk
         9oQA==
X-Gm-Message-State: AOAM533exvUvElxMJ9gLA9oBcmhAUlhQdFZSzO4rz7qR3PakFp3teJVA
        NsnwcwdGHJ9absp8JTdn880Nf7UI8iw=
X-Google-Smtp-Source: ABdhPJz0k1H5zMmO7FeRxSiziHAs6QXmdLS0h3iz7iXvgx+oRMvqv/AD2IwfdjeL00lzP2YnBECbCg==
X-Received: by 2002:a05:6830:1d55:b0:5ff:7c6f:ba6a with SMTP id p21-20020a0568301d5500b005ff7c6fba6amr12302592oth.240.1651165985510;
        Thu, 28 Apr 2022 10:13:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g2-20020a9d6b02000000b00605e077186asm196392otp.11.2022.04.28.10.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 10:13:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dd494b32-c374-888f-b7e3-24cc388a9717@roeck-us.net>
Date:   Thu, 28 Apr 2022 10:13:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 23/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
 <20220426150616.3937571-24-Liam.Howlett@oracle.com>
 <20220428160949.GA2923383@roeck-us.net>
 <20220428163512.kmx3yvghn3txpjee@revolver>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220428163512.kmx3yvghn3txpjee@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 09:35, Liam Howlett wrote:
> * Guenter Roeck <linux@roeck-us.net> [220428 12:10]:
>> On Tue, Apr 26, 2022 at 03:06:35PM +0000, Liam Howlett wrote:
>>> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>>>
>>> Avoid allocating a new VMA when it a vma modification can occur.  When a
>>> brk() can expand or contract a VMA, then the single store operation will
>>> only modify one index of the maple tree instead of causing a node to split
>>> or coalesce.  This avoids unnecessary allocations/frees of maple tree
>>> nodes and VMAs.
>>>
>>> Move some limit & flag verifications out of the do_brk_flags() function to
>>> use only relevant checks in the code path of bkr() and vm_brk_flags().
>>>
>>> Set the vma to check if it can expand in vm_brk_flags() if extra criteria
>>> are met.
>>>
>>> Drop userfaultfd from do_brk_flags() path and only use it in
>>> vm_brk_flags() path since that is the only place a munmap will happen.
>>>
>>> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
>>
>> This patch results in boot failures on alpha. Trying to revert it results
>> in conflicts, so I was unable to cross-check. Bisect log attached. The failure
>> is silent - boot simply stalls after "random: crng init done", so attaching
>> a boot log doesn't add value.
> 
> Thanks.  I can only find Gentoo iso for testing, is there any other
> options?
> 

You could try with images from https://github.com/groeck/linux-build-test.

Guenter

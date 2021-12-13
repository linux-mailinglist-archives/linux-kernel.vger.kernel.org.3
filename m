Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C17F47222B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhLMINS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:13:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232775AbhLMINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639383197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/3iB/zKi0PyIlg1o7i0gS1duaM1MeUfZzW1zYzkl28I=;
        b=cPSe8ajmWWwVsSrg3eiXKGSgWcK8aLst6geWq3jhnKNuYkt1YEmdgZdmBAxKPgQg0QmRut
        4sLkhsmd6QsMQA5Ypf7PaWUqKLag2JdwdANFyyXHBMvlkvfvDN95Pp/PLNLu6sMIMN235Z
        Iqzxl+ZF2YGSVtkAxH1gtA4i92cDb0s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-Za6U8mI7PYSx9MulbK9eeA-1; Mon, 13 Dec 2021 03:13:15 -0500
X-MC-Unique: Za6U8mI7PYSx9MulbK9eeA-1
Received: by mail-wm1-f69.google.com with SMTP id a64-20020a1c7f43000000b003335e5dc26bso9244087wmd.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:13:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/3iB/zKi0PyIlg1o7i0gS1duaM1MeUfZzW1zYzkl28I=;
        b=rUEoZyUYQm+N1pvnXHi8IzFKxudC74L/BkVu4mKRwZVnUinntl0WZN4hSUbWznHqEr
         LW6HduruZCbzmka3sNY9umwga7kCF53I/UpzAxiapf+CUB5EZX4zOiV/pVNwGDZT/Iuh
         DeF+syVyNY55EVscYzKQGKkuyLR1rd/F6BZm+EA5nUr0BqjO3RuJQlk6FS0AJRblXefa
         9Wa/nsFECLR+v28DuT2xGzRKbQSbtEHOkSLxJ0xUr/2IhpTdrkxU4VJNvTjUHgofQuSA
         YIvATmGTEq0eXCONcNjCpqzIM8sXKBMJJGRbWMEUdlEaSEI8+kA8cz32UnoNdYmvRprC
         6K8A==
X-Gm-Message-State: AOAM533lD+AVqDRPbTuNaY766cyZdaqOv+hu85weqTQXnkokTqs4qdtL
        VmfHdULMjRqsYtdBmfjyHN1pPdUj0l8QeXg+ChLTPpecMfXuniKzKx559INdjHBiOoPE3vPmDym
        Wa3JcmB1ctm+NsM/LuhcHWhps
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr35276051wmh.115.1639383194219;
        Mon, 13 Dec 2021 00:13:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8RFxtRHM8EmsSpg/Jl/8VHTsQ3bKvvArCloLDCmmljg69DEyzomQlDun/aiUF7XXsSaePYQ==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr35276029wmh.115.1639383193909;
        Mon, 13 Dec 2021 00:13:13 -0800 (PST)
Received: from [192.168.0.185] (ip-89-176-188-175.net.upcbroadband.cz. [89.176.188.175])
        by smtp.gmail.com with ESMTPSA id d7sm9821677wrw.87.2021.12.13.00.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Dec 2021 00:13:13 -0800 (PST)
Message-ID: <5c02587d-86fd-8851-dc2c-104fb2c52ee9@redhat.com>
Date:   Mon, 13 Dec 2021 09:13:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] recordmcount.pl: look for jgnop instruction as well as
 bcrl on s390
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>, Miroslav Benes <mbenes@suse.cz>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211210093827.1623286-1-jmarchan@redhat.com>
 <alpine.LSU.2.21.2112101054070.5704@pobox.suse.cz> <YbMyvJ6gz7LvoXgE@osiris>
From:   Jerome Marchand <jmarchan@redhat.com>
In-Reply-To: <YbMyvJ6gz7LvoXgE@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2021 11:58, Heiko Carstens wrote:
> On Fri, Dec 10, 2021 at 10:57:00AM +0100, Miroslav Benes wrote:
>> On Fri, 10 Dec 2021, Jerome Marchand wrote:
>>
>>> On s390, recordmcount.pl is looking for "bcrl 0,<xxx>" instructions in
>>> the objdump -d outpout. However since binutils 2.37, objdump -d
>>> display "jgnop <xxx>" for the same instruction. Update the
>>> mcount_regex so that it accepts both.
>>>
>>> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
>>
>> Yes, we ran into exactly this issue too...
>>
>>> ---
>>>   scripts/recordmcount.pl | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
>>> index 7d631aaa0ae1..52a000b057a5 100755
>>> --- a/scripts/recordmcount.pl
>>> +++ b/scripts/recordmcount.pl
>>> @@ -219,7 +219,7 @@ if ($arch eq "x86_64") {
>>>   
>>>   } elsif ($arch eq "s390" && $bits == 64) {
>>>       if ($cc =~ /-DCC_USING_HOTPATCH/) {
>>> -	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*brcl\\s*0,[0-9a-f]+ <([^\+]*)>\$";
>>> +	$mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*c0 04 00 00 00 00\\s*(bcrl\\s*0,|jgnop\\s*)[0-9a-f]+ <([^\+]*)>\$";
>>>   	$mcount_adjust = 0;
>>>       }
>>>       $alignment = 8;
>>
>> ...and we have exactly the same fix in SLES. I haven't got to submit it
>> to upstream yet :(, many thanks for doing it.
>>
>> So at least
>>
>> Reviewed-by: Miroslav Benes <mbenes@suse.cz>
> 
> Just out of curiosity: am I right if I assume that both of you have
> kernel sources without upstream commit
> d983c89cc96a ("s390/ftrace: Add -mfentry and -mnop-mcount support")
> and the commits directly preceding that one?

That is correct. As a matter of fact, the first thing I did to fix the 
issue was to backport it, but that didn't work since it requires gcc 9 
and that particular kernel is build with gcc 8.5.

Jerome

> 
> Otherwise I would be surprised that this would make any difference.
> 
> Applied to s390 tree + added a stable tag.
> 
> Thank you!
> 


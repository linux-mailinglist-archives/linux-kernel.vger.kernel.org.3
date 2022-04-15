Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A5B502EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347457AbiDOS4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344439AbiDOS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:56:13 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06835AF1C0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:53:44 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id k10so9133402oia.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 11:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fu1lGl7KUsvDaTbuVWYLbekm8YyPZlc63692CIkIOQ4=;
        b=kqvea8iiRG8zzVfBOX5D9/92tO/jUsNRwm8NhE4XILL2h++pMU788D91v8CUG5ab3L
         nQui74RKeviFn6UtUTJmy1XTkDdPkjsQAAKpkc8mZfqj9wYM6ieI2ezHfMc3zxd+UEfI
         fjMvAA9s4ZCIEwFISUBRqPx+JXwyiI4Jzkd3AUcoirDfKqi8A8TkX0mkXsAWbykJWhYW
         YvWh53jZM/kHtsVMCxt/0ay45rl8NFummy1hFReLcJwDUGuOEeH9M6vJPxkKGUqfFzZQ
         LbwwcxR3kw6evTwT0B/E92PD7EuFE+0PiEJPA98/2M+XdrpITfQtwNytGrQDpy2E+gru
         16aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fu1lGl7KUsvDaTbuVWYLbekm8YyPZlc63692CIkIOQ4=;
        b=Welw2f8WP0VIJisvNHG+QHhAqSnh5kMdHQGOkD5qRFYGyqU0Y9AMSi4k7Pzngv3gNv
         iivt9g2a40TN5f512VjAXSbpiVvR5o6mv0pUUS/LpV38XuC723yvBb4arAiwMGEe9SqS
         itTvapC5lMjSoneH6VUdn9h1HXxKP4bPdv9gu1qtgOIeaOxe266vhEZcATTR3kIYvEI+
         cE/IeljBVsTHFd+uaNxIiJwlDn75j0njG+vMlXH5EBaDPn2bv1Pf72p4sg+hsbQh0+NH
         sKiIkMqFAXp7ssJGrlpm1obPT4rGFYLcdDU4zL0ZxCm2wJ+n5/uUNtqrEqrnamBfGjME
         rA/Q==
X-Gm-Message-State: AOAM532pnZJupCJvQO1J8zY375q42EJICzkpVTUGFL90qab59hx96219
        IeAoC8TbpmuD3Sl7JtlSbLk=
X-Google-Smtp-Source: ABdhPJznuDVyropBxNhH5yTKZPNKWm7Cidno3n2BjA4yf3avgq+kAyHoURBEJ50hEZGRJwJRbj5FAA==
X-Received: by 2002:a05:6808:2023:b0:2da:5b6a:a526 with SMTP id q35-20020a056808202300b002da5b6aa526mr181185oiw.264.1650048823338;
        Fri, 15 Apr 2022 11:53:43 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::100e? (2603-8090-2005-39b3-0000-0000-0000-100e.res6.spectrum.com. [2603:8090:2005:39b3::100e])
        by smtp.gmail.com with ESMTPSA id m5-20020a056870194500b000d9a0818925sm1828218oak.25.2022.04.15.11.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 11:53:42 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <dc1e02b4-1cb6-5f7c-b612-7d2dd21cbda6@lwfinger.net>
Date:   Fri, 15 Apr 2022 13:53:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/8] staging: r8188eu: clean up comments in struct
 rt_firmware_hdr
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220415121023.11564-1-straube.linux@gmail.com>
 <20220415121023.11564-4-straube.linux@gmail.com>
 <f4f8d381-9ee1-c504-c41c-97a9332066c9@lwfinger.net>
 <bd1b3310-3867-5b3c-cce1-cdb374b3d819@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <bd1b3310-3867-5b3c-cce1-cdb374b3d819@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/22 13:05, Michael Straube wrote:
> On 4/15/22 17:44, Larry Finger wrote:
>> On 4/15/22 07:10, Michael Straube wrote:
>>> The comments in struct rt_firmware_hdr are not needed.
>>> Remove them.
>>>
>>> Signed-off-by: Michael Straube <straube.linux@gmail.com>
>>> ---
>>> v3:
>>> - no changes
>>>
>>> v2:
>>> - no changes
>>>
>>>   drivers/staging/r8188eu/core/rtw_fw.c | 37 ++++++++-------------------
>>>   1 file changed, 11 insertions(+), 26 deletions(-)
>>>
>>> diff --git a/drivers/staging/r8188eu/core/rtw_fw.c 
>>> b/drivers/staging/r8188eu/core/rtw_fw.c
>>> index 7cd08268f3b9..323e0c634c4e 100644
>>> --- a/drivers/staging/r8188eu/core/rtw_fw.c
>>> +++ b/drivers/staging/r8188eu/core/rtw_fw.c
>>> @@ -14,37 +14,22 @@
>>>       (le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x2300 ||    \
>>>       (le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88E0)
>>> -/*  This structure must be careful with byte-ordering */
>>> -
>>>   struct rt_firmware_hdr {
>>> -    /*  8-byte alinment required */
>>> -    /*  LONG WORD 0 ---- */
>>> -    __le16        Signature;    /* 92C0: test chip; 92C,
>>> -                     * 88C0: test chip; 88C1: MP A-cut;
>>> -                     * 92C1: MP A-cut */
>>> -    u8        Category;    /*  AP/NIC and USB/PCI */
>>> -    u8        Function;    /*  Reserved for different FW function
>>> -                     *  indcation, for further use when
>>> -                     *  driver needs to download different
>>> -                     *  FW for different conditions */
>>> -    __le16        Version;    /*  FW Version */
>>> -    u8        Subversion;    /*  FW Subversion, default 0x00 */
>>> +    __le16        Signature;
>>> +    u8        Category;
>>> +    u8        Function;
>>> +    __le16        Version;
>>> +    u8        Subversion;
>>>       u8        Rsvd1;
>>> -
>>> -    /*  LONG WORD 1 ---- */
>>> -    u8        Month;    /*  Release time Month field */
>>> -    u8        Date;    /*  Release time Date field */
>>> -    u8        Hour;    /*  Release time Hour field */
>>> -    u8        Minute;    /*  Release time Minute field */
>>> -    __le16        RamCodeSize;    /*  The size of RAM code */
>>> +    u8        Month;
>>> +    u8        Date;
>>> +    u8        Hour;
>>> +    u8        Minute;
>>> +    __le16        RamCodeSize;
>>>       u8        Foundry;
>>>       u8        Rsvd2;
>>> -
>>> -    /*  LONG WORD 2 ---- */
>>> -    __le32        SvnIdx;    /*  The SVN entry index */
>>> +    __le32        SvnIdx;
>>>       __le32        Rsvd3;
>>> -
>>> -    /*  LONG WORD 3 ---- */
>>>       __le32        Rsvd4;
>>>       __le32        Rsvd5;
>>>   };
>>
>> The comments "LONG WORD" are useless, but the comments describing the fields 
>> are still useful. I do not like this patch.
>>
> 
> Hi Larry,
> 
> You are right the in-line comments are useful. I'll send v4 keeping
> them.
> 
> You only mentioned the in-line comments, just to get it right this
> time:
> 
> What about the "8-byte alignment required" comment? You said in another
> thread that the __le16 references need alignment 4. Should I make the
> struct __aligned(8) or at least __aligned(4)?

Routines cpu_to_le16() and le16_to_cpu() require two-byte alignment. Similarly, 
the 32-bit versions need 4-byte alignment. The layout of the struct will ensure 
that as long as the entire struct has 4-byte alignment.

This struct is only used in rtl8188e_firmware_download() where it is created on 
the stack. That means it will be 8-byte aligned for x86_64 and 4-byle aligned on 
32-bit systems. I'm sure that Dan or GregKH will correct me if I got this wrong, 
but that should be sufficient. Making it __aligned(8) could waste 4 bytes on the 
stack for 32-bit systems. Using __aligned(4) would have no effect on any system.

I say remove the comment.

> 
> And about "/*  This structure must be careful with byte-ordering */" ?
> I think it's obvious because of the __le16 and __le32 fields and can be
> removed. Do you agree on that?

Using the __leNN implies little-endian, thus that comment is useless. Yes, I agree.


Larry

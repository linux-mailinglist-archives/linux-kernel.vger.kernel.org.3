Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1464C9A76
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 02:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiCBBex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 20:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiCBBew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 20:34:52 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCCB5748B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 17:34:10 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id q11so237670pln.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 17:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WvbfaPTFctx/ZBq/LbbOp5Y1TVJ+xSqnWCCTA+Z/BLo=;
        b=hVDRrGDlFebSSqMoxkVgXMfbIhKd7vB31icR6jp+FDN9jEoc3/f+hhT+TfYm+yQ113
         Jao9U9WNhS+eUSrPnCAgyIh2K/n4cE3RCee/HhVr1YAZqW7v4wI9fQO09xsp5BKqAD2x
         VsIh7Jhw6uh0B6Zv8uP635f7wJ4TgE+HGZZaGtuZLe+FWzbQPEBSVdhTgSyaCpR65IJ8
         lM7+mmgMkj1OBNAHJXFgAkl1MtpMJnCX4V0v+lfSCoNKvVPpjfWPkEEj6hO0BbYzn6r8
         In/Ck5es2mK8aZ5AAiOammC+fCQmE346I+zs/Xj406NX2ds9JyBk+vSgx8RvC4bhqesG
         SryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WvbfaPTFctx/ZBq/LbbOp5Y1TVJ+xSqnWCCTA+Z/BLo=;
        b=EkD5BNUtSu8R+iC19iWW2B7x0+gJVAeYJXAObj0gYDSj8gpVis0208bdH7aIKsluaH
         lT9xU8VIMI2npOtMnglRwocL/Lvm/tVP8HTwNcZMvDg2TwUAnOdN95zd5MxGE9RVzzpw
         5fXGP0cpAHYIKq0PRScK8Gvn2j2inUgoWdITnOwPcsab3d4Xz1SxZyLImvYlpxv9rea5
         3rMc9tezcMvwcYQDU+y36AXZN2rkZDF3GEwpRI1XjbmYahVd19Rzf4ioaQrbmxCTMuvB
         m4OU0lE5y3XOFTcJm3Q7pXGkdcxXmOyUK9pXoivS85yYCuoWdXltPvyRCGRut4b+NZV4
         RcDw==
X-Gm-Message-State: AOAM531numlevJvUX6m5cr3mVbVsrKbtcln5LL2GPstHbET2/9I2Q9uX
        DoHF47tiP7dwuBjujEnqukI=
X-Google-Smtp-Source: ABdhPJz6zxh10Pr83NPul6JjmZR+Q9CQqGzwlbLF8IduW22KXvc3PsJaORPgaxeL5JcmWfaefjyRfg==
X-Received: by 2002:a17:90b:10b:b0:1bc:6f86:b209 with SMTP id p11-20020a17090b010b00b001bc6f86b209mr24660317pjz.33.1646184850280;
        Tue, 01 Mar 2022 17:34:10 -0800 (PST)
Received: from [10.11.37.162] ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id b187-20020a621bc4000000b004f3c8f3b560sm16963844pfb.129.2022.03.01.17.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 17:34:09 -0800 (PST)
Message-ID: <43e1dba5-2af7-658b-ae45-c7a6c1c0dc6d@gmail.com>
Date:   Wed, 2 Mar 2022 09:34:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] powerpc: kernel: fix a refcount leak in format_show()
Content-Language: en-US
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220228091103.39749-1-hbh25y@gmail.com>
 <87o82pomrc.fsf@mpe.ellerman.id.au>
 <825f5cba-a62b-a691-225e-22f6bb9b10a8@linux.ibm.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <825f5cba-a62b-a691-225e-22f6bb9b10a8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. I will resubmit my patch latter.

On 2022/3/2 03:50, Tyrel Datwyler wrote:
> On 3/1/22 04:55, Michael Ellerman wrote:
>> Hangyu Hua <hbh25y@gmail.com> writes:
>>> node needs to be dropped when of_property_read_string fails. So an earlier call
>>> to of_node_put is required here.
>>
>> That's true but ...
>>
>>> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
>>> index a0a78aba2083..cd0fa7028d86 100644
>>> --- a/arch/powerpc/kernel/secvar-sysfs.c
>>> +++ b/arch/powerpc/kernel/secvar-sysfs.c
>>> @@ -30,13 +30,12 @@ static ssize_t format_show(struct kobject *kobj, struct kobj_attribute *attr,
>>>   		return -ENODEV;
>>
>> There's also a reference leak there ^
>>
>> So if you're going to touch this code I'd like you to fix both reference
>> leaks in a single patch please.
>>
>> Having the error cases set rc and then goto "out" which does the
>> of_node_put() is the obvious solution I think.
> 
> update_kobj_size() in the same source file provides a good example of the
> suggested solution.
> 
> -Tyrel
> 
>>
>> cheers
>>
>>>   	rc = of_property_read_string(node, "format", &format);
>>> +	of_node_put(node);
>>>   	if (rc)
>>>   		return rc;
>>>   
>>>   	rc = sprintf(buf, "%s\n", format);
>>>   
>>> -	of_node_put(node);
>>> -
>>>   	return rc;
>>>   }
>>>   
>>> -- 
>>> 2.25.1
> 

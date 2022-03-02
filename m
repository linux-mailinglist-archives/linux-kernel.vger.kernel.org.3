Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A19E4CAE62
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbiCBTPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244935AbiCBTP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:15:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7412251317
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646248484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiPVDUBebs7EB1B9i8U5kkuWPnwl3uCi7XbX0p51YuI=;
        b=PmoXzez90gjGqH5AFCOBzc0ZDO2A6nNhOybBKB1QFXTfvTYy60gx8ZEe8sPGk+FPpCm79O
        xc1Jl4CD+CoqjrV/rMZwX/vs11yo2/UXGXX7RS0iF29g4Yu+aLvw8TzE79YY2VnBLhLkhG
        SwsNw7fksGoQe0FJ9Rbit70bsz8P+rM=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-5Hb6xVNGMO2tb1Qlm4XxBQ-1; Wed, 02 Mar 2022 14:14:43 -0500
X-MC-Unique: 5Hb6xVNGMO2tb1Qlm4XxBQ-1
Received: by mail-oo1-f71.google.com with SMTP id p1-20020a4adfc1000000b0031cfa60836dso1856940ood.19
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YiPVDUBebs7EB1B9i8U5kkuWPnwl3uCi7XbX0p51YuI=;
        b=dg2EYRxizpUT+exq+Ak1X7PG9Dj2446gNraXzokBun+IfR3nl4t/16bjvbzsS7YVNW
         I4h9GKzqZbKOwW8IgAYgxVDosOzk28rHczfHNoSAbcgDI5lzMKxtpEwUwWtxi33EnXV2
         3jQMChGu1eZbJR73ZUeY2OvGH3mpW5KR0ihgixsYeiJ5AqESBtdEBZLAjc+MkzKPc5/K
         E/VajnuNx6cONtt/nOYTznQMnLnj7ZJexNpT1SshgxoZrUrb7PLy08EiWYxJ9TG/71Ae
         9EXOk8fk6KL0GnFZ2YenkxHCP1nBsBI3EygT9zNwW89JGAQOx8vt+WCaPM0G5swAmb3X
         qkPA==
X-Gm-Message-State: AOAM532InQBQn7Jl0i4iK6f8wGnEtUFtUfFew1Mmk9KQYehpF+5MMbIz
        muMaPQ8cJthTmMB0zo4XN7SBi7S6SpVNnOFe3agHIEmTVThp5msnrptuT7oKoiJNlM7udT3+EBm
        tf9haHoTuqi5Rk6hta8edDaPp
X-Received: by 2002:a9d:6f82:0:b0:5af:1555:5a9b with SMTP id h2-20020a9d6f82000000b005af15555a9bmr17592478otq.289.1646248482733;
        Wed, 02 Mar 2022 11:14:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxB4KkiaJYio4742IBRrbpirlsfY7jDTJSDYE0Y2LApyDfwNM6nimi0+dhckWOYXqK7oHp9AA==
X-Received: by 2002:a9d:6f82:0:b0:5af:1555:5a9b with SMTP id h2-20020a9d6f82000000b005af15555a9bmr17592453otq.289.1646248482460;
        Wed, 02 Mar 2022 11:14:42 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id q13-20020a0568080ecd00b002d44f01f1d7sm10093409oiv.40.2022.03.02.11.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 11:14:42 -0800 (PST)
Subject: Re: [PATCH] scsi: megaraid: cleanup formatting of megaraid
From:   Tom Rix <trix@redhat.com>
To:     Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, Konrad Kleine <kkleine@redhat.com>
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20220127151945.1244439-1-trix@redhat.com>
 <d26d4bd8-b5e1-f4d5-b563-9bc4dd384ff8@acm.org>
 <0adde369-3fd7-3608-594c-d199cce3c936@redhat.com>
 <e3ae392a16491b9ddeb1f0b2b74fdf05628b1996.camel@perches.com>
 <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com>
Message-ID: <8dd05afd-0bb9-c91b-6393-aff69f1363e1@redhat.com>
Date:   Wed, 2 Mar 2022 11:14:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <46441b86-1d19-5eb4-0013-db1c63a9b0a5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/28/22 11:37 AM, Tom Rix wrote:
>
> On 1/28/22 11:11 AM, Joe Perches wrote:
>> On Fri, 2022-01-28 at 09:59 -0800, Tom Rix wrote:
>>> On 1/28/22 9:42 AM, Bart Van Assche wrote:
>>>> On 1/27/22 07:19, trix@redhat.com wrote:
>>>>> From: Tom Rix <trix@redhat.com>
>>>>>
>>>>> checkpatch reports several hundred formatting errors.
>>>>> Run these files through clang-format and knock off
>>>>> some of them.
>>>> Isn't this the kind of patches that carries more risk than value?
>> Risk for whitespace style reformatting patches is quite low.
>>
>> Nominally, clang-format changes should not produce a different
>> compiled object file unless __LINE__/__DATE__/__TIME__ style
>> changes occur.
>>
>> If it does, the clang-format tool is broken.
>>
>>>> Additionally, this patch conflicts with a patch series that I plan to
>>>> post soon.
>> []
>>> Long term, it would be good have a reliable way to automatically fix
>>> either new files or really broken old files.
>> That's really a maintainer preference no?
>>
>> Especially so for any automation.
>
> In practice everything is up to the maintainer.
>
> If some maintainer wants fix their formatting then clang-format should 
> just work
>
> It isn't likely they will have time to hand fix every file.

A follow up issue in the clang project has been raised by Konrad, here

https://github.com/llvm/llvm-project/issues/54137

Tom


>
> Tom
>
>>
>>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD1E467D23
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382539AbhLCSXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:23:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230059AbhLCSXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638555616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qp4pzqcovXo9/75a+fOVBz8sXHQU3hxHlnuUjFxWvy0=;
        b=OwJEAOoFVlyuIZ0j7BJTvWgX/92f61CWsURsDuSZGHo8HG5332ZA4Ad1s4pQS5yVDjKGXC
        LLbEZJcGWy7RkQSyJT2npCUNg7k+QzxS0W1YFB2AGGZ2jkG4ymEA1ch0PTQKsYQD4lD4lF
        7tPHHIvgLP4rFMkG9o1XS/CjOCysDpM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-q2zgEIM8MDWZFNC8E2CD-A-1; Fri, 03 Dec 2021 13:20:15 -0500
X-MC-Unique: q2zgEIM8MDWZFNC8E2CD-A-1
Received: by mail-wm1-f72.google.com with SMTP id r129-20020a1c4487000000b00333629ed22dso3799875wma.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 10:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Qp4pzqcovXo9/75a+fOVBz8sXHQU3hxHlnuUjFxWvy0=;
        b=WKmVePkq/GRLyp3NUMx7H128UTDbFmEqLM3qDUnICzI+XM3aNFoFc/1qS43VX+nnJi
         hu9tPKKu2ycUUEico2dowCcB7dMuGcACr2dCLZWZlURsO8ZG9aIKg11gD/r2cifIwjh6
         0k0AyHwY/VI8Zn/kCAv0vZIZ8J9LkFXOlpa1Vl8U0gSW1tx/5rO9IsClllwZ8Lceiy5m
         e0o9xd9ksj1jprQL9GWWyJu+vpsNrBAxS0uZ5NgGvYFtLlIWJIXQ1UBCGn2o6MtYDj5h
         ZuwaFwEbBYT6qM5CRX1nVcmUjEunQtLu1++5JdJMemjc2SDYjocB9VCDj1VIaBYLjSyC
         7nMg==
X-Gm-Message-State: AOAM533AfOcM7L23Pbsj8P+T37bsTQGNVWRj8W3jMtQsi+DTx0BsytcW
        vrUBNehOP8ZJhhdM0bb6R+QzB9kPEcSfjMsNGY8EjlTYLaz10FFTH0vtGW5rpET8BtWJMGw3Sqr
        dKJapZMYWiun7JJjsBpgnXFH0
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr17069254wmk.27.1638555614158;
        Fri, 03 Dec 2021 10:20:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8xAEiGFx9TsgLW9UA2xjJDvafWSl28XDQ3r53p/Xb3u9csBM68fI+lfU+MsaZKJ/z3RYnlg==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr17069223wmk.27.1638555613996;
        Fri, 03 Dec 2021 10:20:13 -0800 (PST)
Received: from ?IPV6:2003:d8:2f44:9200:3344:447e:353c:bf0b? (p200300d82f4492003344447e353cbf0b.dip0.t-ipconnect.de. [2003:d8:2f44:9200:3344:447e:353c:bf0b])
        by smtp.gmail.com with ESMTPSA id a1sm4522257wri.89.2021.12.03.10.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 10:20:13 -0800 (PST)
Message-ID: <d5d854de-d59d-47d5-35ce-fe3a924a5a93@redhat.com>
Date:   Fri, 3 Dec 2021 19:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFD] clear virtual machine memory when virtual machine is turned
 off
Content-Language: en-US
To:     fei luo <morphyluo@gmail.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, xiaofeng.yan2012@gmail.com
References: <CAMgLiBskDz7XW9-0=azOgVJ00t8zFOXjdGaH7NLpKDfNH9wsGQ@mail.gmail.com>
 <673c5628-da97-83d3-028f-46219f203caf@redhat.com>
 <CAMgLiBsGcTq8yoa1Rud0-qiRk11uChyS=CU8+5KTw35c2YmyBw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAMgLiBsGcTq8yoa1Rud0-qiRk11uChyS=CU8+5KTw35c2YmyBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, this feature needs to consider when page migration, the content
> of the old page needs to be cleared, and the swap space needs to
> be cleared before swap. Of course, for security reasons, swap can be
> prohibited. Here I just listed some of the changes involved, not all
> aspects. This feature is mainly aimed at clearing the memory of
> the virtual machine after shutdown, so it is more aimed at anonymous
> mapping and huge page mapping
> 
>>>
>>>
>>> When reusing the page that has been cleared, there is no need to clear it
>>>
>>> again, which also speeds up the memory allocation of user-mode programs.
>>>
>>>
>>> Is this feature feasible?
>>
>> "init_on_free=1" for the system as a whole, which might sounds like what
>> might tackle part of your use case.
>>
> 
> This feature is mainly to prevent the used memory information from leaking,
> not to clear the memory before use.

That's the whole purpose of init_on_free -- maybe you should give that a
second look.

I don't think MAP_UNMAPZERO is what we want.

-- 
Thanks,

David / dhildenb


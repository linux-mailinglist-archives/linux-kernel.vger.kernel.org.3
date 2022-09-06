Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDAF5AEEF3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiIFPf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbiIFPeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5614E62A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662475464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zk4tT/sTQIn6h0bFOLVjj/y+xayeBLMBAFWx6yVN1pM=;
        b=JT0diHb59PWzKCS7pnZfn2RiQW4wHJcuy8rby8tT1NY4qEfakXTb7xS5K3kC9gljSPzDPZ
        oAMZ5WTvmsVk/A7HKM6iXuaDqwbSAlE0zylhMfky9UOjusACtHMBeKAVoMvBXDHrl3x+uD
        +6Sp8HoOcqsIrYG8iZPVBNMl/veFGGU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-547-hxH_vS7IPuaLEuLkqSHvmQ-1; Tue, 06 Sep 2022 10:44:23 -0400
X-MC-Unique: hxH_vS7IPuaLEuLkqSHvmQ-1
Received: by mail-wr1-f70.google.com with SMTP id k17-20020adfb351000000b00228853e5d71so1784956wrd.17
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=zk4tT/sTQIn6h0bFOLVjj/y+xayeBLMBAFWx6yVN1pM=;
        b=XMPwTBvzoJZnHq/BbQBR/D0PZr5bZHRrfnRILI/U83CEQ7EDHp4MPuff+G0AKPBo1c
         jpYx9lXPeAm3fi8EB1rOeDx16A5/jBiu1yWOp1hogbAX3QEgk2yri41Ybieg3pqeKPgA
         +BMZmO2EhI5FzCNWui4/TsTBuzgn/ulL4CwhZB6QlEBU3t0baYT2kEcNJf14m+6Gu6hc
         9bN4zwaVXLG/2kaRx0pJVgBXrCjOsit+acfoXbwmLOyIZI2TtPm3x4PLkBFGNt0ApUGZ
         bIYSdO1EBQHg5WkPgF8y+OZw3DuW4RRXnSwqUIxKNXoHuYI04VVxKbx0016uWpXTsSis
         6NAw==
X-Gm-Message-State: ACgBeo0p8A2V3tvXGPVTCc+URxc1Pop3Gn3kBp98xc59OZPLHUW21p+N
        yp6wOsJKy4J+su+fn3IA3ArKpTtPFYMk4ICtyj0ZYVBkr+XFZqvhwFY3vcyHmn/SHur3jhBaDSk
        Jzt2fXryk07HaPVhymhMVD6/A
X-Received: by 2002:a5d:6d03:0:b0:226:eb13:c906 with SMTP id e3-20020a5d6d03000000b00226eb13c906mr17744630wrq.325.1662475462123;
        Tue, 06 Sep 2022 07:44:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4uz7+OPx4RNqBc8NRUWHOejnV6UayRVD4MQwgmIzSYf9kiR3yQYUlSX7gzenUhLQyreN2PgA==
X-Received: by 2002:a5d:6d03:0:b0:226:eb13:c906 with SMTP id e3-20020a5d6d03000000b00226eb13c906mr17744608wrq.325.1662475461832;
        Tue, 06 Sep 2022 07:44:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00226dedf1ab7sm7619868wrt.76.2022.09.06.07.44.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 07:44:21 -0700 (PDT)
Message-ID: <40486dbb-9f19-6fa6-d46d-99d2b033883d@redhat.com>
Date:   Tue, 6 Sep 2022 16:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        peterx@redhat.com, kirill.shutemov@linux.intel.com,
        hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
 <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
 <YxdPi2E63aO0Dgyd@nvidia.com>
 <4516a349-49cb-fd7b-176a-f1a9479906d9@redhat.com>
 <YxdZlCly2ad1rtcI@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
In-Reply-To: <YxdZlCly2ad1rtcI@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.22 16:30, Jason Gunthorpe wrote:
> On Tue, Sep 06, 2022 at 03:57:30PM +0200, David Hildenbrand wrote:
> 
>>> READ_ONCE primarily is a marker that the data being read is unstable
>>> and that the compiler must avoid all instability when reading it. eg
>>> in this case the compiler could insanely double read the value, even
>>> though the 'if' requires only a single read. This would result in
>>> corrupt calculation.
>>
>> As we have a full memory barrier + compile barrier, the compiler might
>> indeed do double reads and all that stuff. BUT, it has to re-read after we
>> incremented the refcount, and IMHO that's the important part to detect the
>> change.
> 
> Yes, it is important, but it is not the only important part.
> 
> The compiler still has to exectute "if (*a != b)" *correctly*.
> 
> This is what READ_ONCE is for. It doesn't set order, it doesn't
> implement a barrier, it tells the compiler that '*a' is unstable data
> and the compiler cannot make assumptions based on the idea that
> reading '*a' multiple times will always return the same value.
> 
> If the compiler makes those assumptions then maybe even though 'if (*a
> != b)' is the reality, it could mis-compute '*a == b'. You enter into
> undefined behavior here.
> 
> Though it is all very unlikely, the general memory model standard is
> to annotate with READ_ONCE.

The only thing I could see going wrong in the comparison once the stars 
alingn would be something like the following:

if (*a != b)

implemented as

if ((*a).lower != b.lower && (*a).higher != b.higher)


This could only go wrong if we have more than one change such that:

Original:

*a = 0x00000000ffffffffull;


First modification:
*a = 0xffffffffffffffffull;

Second modification:
*a = 0x00000000eeeeeeeeull;


If we race with both modifications, we could see that ffffffff matches, 
and could see that 00000000 matches as well.


So I agree that we should change it, but not necessarily as an urgent 
fix and not necessarily in this patch. It's best to adjust all gup_* 
functions in one patch.

... I do wonder if we want to reuse ptep_get_lockless() instead of the 
READ_ONCE(). CONFIG_GUP_GET_PTE_LOW_HIGH is confusing.

-- 
Thanks,

David / dhildenb


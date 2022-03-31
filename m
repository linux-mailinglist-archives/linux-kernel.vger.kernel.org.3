Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19054EDC13
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237820AbiCaOwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiCaOwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECD7E5576F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648738211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4syl0TwIcCPylaIS1VmorYj2ruIeY8S5BvvyNsDOjJk=;
        b=QBiNVPttpyI6WWE1mN4Zp9wOPPjxCReIah9wFqPUvnUpJ38J0cMwsQ1CxH8+tA9PBKSBNW
        XHoB5r42u3Z+X3T/jHeW/dq/QvKXx5/OUlRiw6fFpSJdGuNucps5IFIpe/Oa6ToDsKhTfZ
        3kvKKVlsU7dmB6vtjtD2dbOwy9BmyGk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-suqcaFMMN9WXaIxKzEgHWQ-1; Thu, 31 Mar 2022 10:50:10 -0400
X-MC-Unique: suqcaFMMN9WXaIxKzEgHWQ-1
Received: by mail-wr1-f70.google.com with SMTP id l19-20020adf9f13000000b00203f7f64c7bso4991wrf.18
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4syl0TwIcCPylaIS1VmorYj2ruIeY8S5BvvyNsDOjJk=;
        b=ox4HxKkRjlkV2Ab+CDa6S6gtI1HHYGxcFVUJo2kqg+SCWxPdK+HHqtkCZat/NXKUqh
         xHcBj5O+LPqisS50tcUlx7IkSfQi7bHZaAKMtdleqt/yenWl6qsXcH9FNm++5ZWbkxGU
         tG4kwCRTbRmrACb+SC+N3mQx/cbrxTk5B78et9ATUoulBbDJgsApXgU9Xb3kI9TTl96B
         oWxrBJdgK0iCSk2LVzIM6FbTOyQwD0D9BeC+KS6dduwH5wMLrSFLqup4aYFhtsYhR06H
         jBvNCRCZCRgaDwbnNTQxmuI1a3sJOoa5+k7PT3vnjwPcDw1MO+kX8uz3A6VERprnb7uz
         Vcmg==
X-Gm-Message-State: AOAM533gIjwRldzkk0JjjmriPCXYcwtJbkhhSUByD6z6I/1xQyRRx0cE
        Y5H/znY0Rmb7a+ZcK/9YnbIXmUUeVF/L5s/LGZePTeTUEJJCQ89fIVe0a/KUVjE4qn8MLMdb7we
        tBwPEUPVZk3mFHSARAXFhiDS6
X-Received: by 2002:a05:600c:4f48:b0:38c:a460:cb6 with SMTP id m8-20020a05600c4f4800b0038ca4600cb6mr5110936wmq.96.1648738208911;
        Thu, 31 Mar 2022 07:50:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9T76Bw0cdtCwgENOVXbVuS/cZmvBb3Y3BI44bqjp7y5iekmFPLn5U6GIX8wGmn8RPjylCzQ==
X-Received: by 2002:a05:600c:4f48:b0:38c:a460:cb6 with SMTP id m8-20020a05600c4f4800b0038ca4600cb6mr5110912wmq.96.1648738208650;
        Thu, 31 Mar 2022 07:50:08 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p11-20020a5d638b000000b002048a77636dsm19369398wru.97.2022.03.31.07.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 07:50:08 -0700 (PDT)
Message-ID: <7178244c-fcfb-01d8-f678-565401cabca0@redhat.com>
Date:   Thu, 31 Mar 2022 16:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] efi: Allow to enable EFI runtime services with PREEMPT_RT
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Al Stone <ahs3@redhat.com>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220331141038.171204-1-javierm@redhat.com>
 <YkW3EmURxE1+kOu5@linutronix.de>
 <ce8d975e-d9dd-f9b8-793d-234258021169@redhat.com>
 <YkW9T2xRSI9e4BFv@linutronix.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YkW9T2xRSI9e4BFv@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 16:40, Sebastian Andrzej Siewior wrote:
> On 2022-03-31 16:25:40 [+0200], Javier Martinez Canillas wrote:
>> Hello Sebastian,
> Hi Javier,
> 
>> Yes, it is but the motivation is to be able to have EFI runtime services
>> by default without the need for any kernel command line parameter.
> 
> This part wasn't clear. It is not mentioned by the description but now
> that I look at Kconfig, it is there.
>

Sure, I can post a v2 with better wording in the description to make it clear.
 
>> In the same vein, I could ask if efi=noruntime wasn't enough instead of
>> commit ("efi: Disable runtime services on RT").
> 
> No, it is not because it should not lead to any surprise latencies by
> default.
>

Yes, it was a rhetorical question. I understand the motivation of that commit
and agree with it. That's why $SUBJECT doesn't change the current behaviour,
and the EFI runtime services will still be disabled by default for RT.

It's just to allow a way to enable for RT users that may want to. But having
a separate boolean symbol also allow non RT users to disable it by default.
 
> Sebastian
> 

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5344903A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbiAQIWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238032AbiAQIWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642407732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sg8p8AHi3UJdK9z4yX9nhx3FRx/VOIBzKvjT8S0Q3JM=;
        b=BLYO01mWMZQfbK88AihTaKEINUI0Y5nJMTwkvUxYoNJu0SV/XqZmrSH9azCjxeAQ6nOHG+
        /9O8bkv0p3HRazOQtPFTtXoxNGSxi1I9ZNIcX+CTxfA6YEi2sQB5hzkB/Rad6fapoU/HfA
        n3JWU3MXLfapU1AqRinE2hXJzeLgZBQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-AlQXLA8ZPUWP2WKVl-OGSQ-1; Mon, 17 Jan 2022 03:22:10 -0500
X-MC-Unique: AlQXLA8ZPUWP2WKVl-OGSQ-1
Received: by mail-wm1-f69.google.com with SMTP id x10-20020a7bc20a000000b0034c3d77f277so2708237wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 00:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sg8p8AHi3UJdK9z4yX9nhx3FRx/VOIBzKvjT8S0Q3JM=;
        b=OtPgoBKlbLND2OzKbRK+exU7ojZn6dyeGpvWK4KVxPOjiXrzgTwPOJ90q7SNUbOPOg
         879K6AictJhw9V4XoIHqY5z4DQv/12XPqOj4wWFiMvDP6IdFw4/JxBqQCe0w/zIgmVZw
         L14q3g64olN6AinOUaJZ5NUq5Vn5wY7pilHoTNNcYriuGoDPZpsfYnBoXxAt26Dt+6ab
         aFwOxgtjUAYuYyMbZpoobFaR9WpyJdif4XbJt/hqXVKSMi/9+J+pBJdx/xw5uLO1uZXi
         i8O0Kct3V8BI26PxZaYAn9LfSkKAljW1aFyp197uwd+VSQWgKmaA4Q62grxfUvR0Ybhy
         jZMA==
X-Gm-Message-State: AOAM530JsiBsa/YxlOCpunRBbXq4Eq1D/8ceZIaH1F+m2Wznky1Tp2V/
        yXwzZI4/LYgyn1kC4PjjtmmdgJRnIo+jhYEVMlXbbQ6KrsTA4e1b6m5kWoYqvc/LT9+378T61iA
        eN+XxxaqLlYeoAKeOGZb5c74a
X-Received: by 2002:adf:e78e:: with SMTP id n14mr18512276wrm.631.1642407729385;
        Mon, 17 Jan 2022 00:22:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfX6DyGdjNVfeccUpaF9Hfqtqa45OuD18xrFo42Uf+iDexJ9TwGxZgQm8IYyKvOJYF6w6HHw==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr18512267wrm.631.1642407729203;
        Mon, 17 Jan 2022 00:22:09 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id u1sm7671679wrs.97.2022.01.17.00.22.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 00:22:08 -0800 (PST)
Message-ID: <b8c2663b-69df-913f-8da1-de6b7bd189ce@redhat.com>
Date:   Mon, 17 Jan 2022 09:22:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: linux-next: manual merge of the kvm tree with the risc-v tree
Content-Language: en-US
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Paul Walmsley <paul@pwsan.com>, KVM <kvm@vger.kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <20220112114024.7be8aac6@canb.auug.org.au>
 <20220117085431.7bef9ebc@canb.auug.org.au>
 <CAAhSdy3gEW+SC1GCH0V4iVA9h1sxeVV-V=x4kG7w_9tcVTtamw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <CAAhSdy3gEW+SC1GCH0V4iVA9h1sxeVV-V=x4kG7w_9tcVTtamw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/22 05:13, Anup Patel wrote:
> The commit c62a76859723 ("RISC-V: KVM: Add SBI v0.2 base extension")
> is already merged in Linus' tree.
> 
> Since you are yet to send PR for 5.17, we have two options:
> 1) Rebase your for-next branch upon latest Linus' tree master branch
> 2) Send "RISC-V: Use SBI SRST extension when available" in the
> next batch of changes for 5.17 after 5.17-rc1
> 
> Let me know if you want me to rebase and send v8 patch of
> "RISC-V: Use SBI SRST extension when available"
> 
> In future, we should coordinate and use a shared tag for such
> conflicting changes.

Palmer should just send it to Linus and note "enum sbi_ext_id has a 
trivial conflict" in the pull request message.

We'll sort it out better in the future, but it's such a minor conflict 
that it is not even a nuisance.

Paolo


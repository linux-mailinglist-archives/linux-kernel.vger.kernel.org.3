Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82A94843A0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbiADOpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:45:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234341AbiADOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641307499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y90lW9XmNLqfe3N1HpT0kR+V/FIjNg1yVaD+klmiyww=;
        b=BDBzlG6eLp0U/ZnLURYPz11wvpc5TsZrY8vMhLH8UbbCiesIruAZGyDbBfbNLMZzwCakjV
        0Y5fEYyaIjH+oHuSEUXiEleFlu/t85mSSIrEmamYwOdApv0DVGHUhHNSnmlkGHixi0JnF2
        p1152PHbJiDKvhs0QnPp4UcyJ6q4OkI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-nE8PwU3oMWaHkAeo0hv1SA-1; Tue, 04 Jan 2022 09:44:58 -0500
X-MC-Unique: nE8PwU3oMWaHkAeo0hv1SA-1
Received: by mail-wm1-f71.google.com with SMTP id c5-20020a1c3505000000b00345c92c27c6so15397408wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Y90lW9XmNLqfe3N1HpT0kR+V/FIjNg1yVaD+klmiyww=;
        b=i2mgkuXFeM9Fjd4pLxWSiCGoYsPc+yLUp+6OCkNqHNdjQUbnwHxM9YF+/3VCR2Hk4T
         OlmwlIZuvKhWz8W7oGEZMNoZVeXjulUuPfWtBwHIrckg6Q5qKdd5S2+wamWpBqN8IDO/
         KEMmKojAP3Z6e03Y5Ir+r+L1ugBDF//ZQdffFBN3HO+y6aeOs4dpr1k6KkjCCbFbjTAB
         gZvH2L4LbKJxbpr+cXlJniWeGKkrTFyDfJbfw4pF0mYDdmQayfA9QEyevna2XH1Eor3a
         1kqnGgJe7hmU/iFTT/azDbV/d7i6gmXnRpg6/DiFp7BWdY4rvaVvXHnJE2VlFyFLPC+j
         fQCg==
X-Gm-Message-State: AOAM530fdrwZjSpdAgqIRGFqAsS6slVas8SBJ9OJWMBMiAWpfILUmffh
        g9w4y306Dfdc4Q28SIJ5v/mQ7uluo9d2R0rw9f3BGOkThMJxkLdNOyXb3UpbOBjAmqYDxXJ5pzY
        OyaAD9jMpIPoWSptKizLuF8j0
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr43693144wmj.191.1641307497003;
        Tue, 04 Jan 2022 06:44:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy38Q/9u8LOHOsrUTzf3fHKPrilzJAKujndpWPoU4Syl/QxEJaGRpIbZH9NGE+YeD52mVPG5A==
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr43693130wmj.191.1641307496791;
        Tue, 04 Jan 2022 06:44:56 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62bd.dip0.t-ipconnect.de. [91.12.98.189])
        by smtp.gmail.com with ESMTPSA id 9sm48470738wrz.90.2022.01.04.06.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 06:44:56 -0800 (PST)
Message-ID: <01e42346-5b4d-8ccc-d485-5d866da7cf8d@redhat.com>
Date:   Tue, 4 Jan 2022 15:44:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Peng Liang <liangpeng10@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, hughd@google.com,
        xiexiangyou@huawei.com, zhengchuan@huawei.com,
        wanghao232@huawei.com, "dgilbert@redhat.com" <dgilbert@redhat.com>
References: <20211222123400.1659635-1-liangpeng10@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC 0/1] memfd: Support mapping to zero page on reading
In-Reply-To: <20211222123400.1659635-1-liangpeng10@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.21 13:33, Peng Liang wrote:
> Hi all,
> 
> Recently we are working on implementing CRIU [1] for QEMU based on
> Steven's work [2].  It will use memfd to allocate guest memory in order
> to restore (inherit) it in the new QEMU process.  However, memfd will
> allocate a new page for reading while anonymous memory will map to zero
> page for reading.  For QEMU, memfd may cause that all memory are
> allocated during the migration because QEMU will read all pages in
> migration.  It may lead to OOM if over-committed memory is enabled,
> which is usually enabled in public cloud.

Hi,

it's the exact same problem as if just migrating a VM after inflating
the balloon, or after reporting free memory to the hypervisor via
virtio-balloon free page reporting.

Even populating the shared zero page still wastes CPU time and more
importantly memory for page tables. Further, you'll end up reading the
whole page to discover that you just populated the shared zeropage, far
from optimal. Instead of doing that dance, just check if there is
something worth reading at all.

You could simply sense if a page is actually populated before going
ahead and reading it for migration. I actually discussed that recently
with Dave Gilbert.

For anonymous memory it's pretty straight forward via
/proc/self/pagemap. For files you can use lseek.

https://lkml.kernel.org/r/20210923064618.157046-2-tiberiu.georgescu@nutanix.com

Contains some details. There was a discussion to eventually have a
better bulk interface for it if it's necessary for performance.

-- 
Thanks,

David / dhildenb


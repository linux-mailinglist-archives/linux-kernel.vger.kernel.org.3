Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98F548DC32
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiAMQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:48:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234714AbiAMQsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642092534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CP8RXj45JsrXKvLXobja12t+tuHF1y1kRh+2Obu+Fs=;
        b=RfO4R6S1sIQJ/DYzaS+KIYT/uVYjU2UPu+3ZOy0ZZv0Lq2JUel02NDol6YUNI3ChHSYo1d
        WkOi6etAbQB8TSLwj+hEz28brDsFwHF/Cy3eoxwrn5Nh+xmnx+9nkBm9ZabkBRKOLV52av
        ZwFYKG/vnXygbKdA7yTJ3qDz12Q4TpQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-ehkqK8ysPAq_x4FRiJSmWw-1; Thu, 13 Jan 2022 11:48:52 -0500
X-MC-Unique: ehkqK8ysPAq_x4FRiJSmWw-1
Received: by mail-ed1-f71.google.com with SMTP id o20-20020a056402439400b003f83cf1e472so5875218edc.18
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=4CP8RXj45JsrXKvLXobja12t+tuHF1y1kRh+2Obu+Fs=;
        b=O4c5X2xnMGNf7mXss2VfZqeN12wVl+1MhQjZCIFwphXaH2KO7rfpp/Wf716dPLfaCU
         EkBavg1uobTCUsu5rib1zUtIotp4Y/yFYJmArTL9k2pjKf1sbX+h8RcRH/QgMTxUHL8x
         DgmU3AFem24SOUWRrs+5BK7qKiHggwxW19Rp7VneV74WbR25z9zKTGW/GyJMEQ3Wqx9W
         QsaDJtE/CoQvuLVZufsxQM5NK3oq6rEgBXznhEsWj9Q/amHgjail5rPrWkc1I1bQU9OY
         XteDdW/BkVvyP6Lwtmrx2L/WjJpiOklcqU0UcK7QBqkBL5nltBOuvnb27Dlu2sTFY46c
         /NQg==
X-Gm-Message-State: AOAM533fApZmce5Bmo3w0AdoROXW72KzdqgkUCXBaA7WMvzWbUpmUfCh
        y+2fwvsPXKLWfW/U/IGsfNxUuhFtdPIr1OaTAbb0mbh7O1U/ORCDDiJKbayOwQiRbMXxY7Bim7e
        wIbP5t2yH091i3Mz/xJ3SnVbM
X-Received: by 2002:aa7:c7cf:: with SMTP id o15mr5019208eds.176.1642092530982;
        Thu, 13 Jan 2022 08:48:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/vRcGkOKmm25+gp3DEhhhNaMEVPYdtS7M1Nxz5zxBCvTUiLiq6IyZ0Ch0q2yCk1Lm/iQpPw==
X-Received: by 2002:aa7:c7cf:: with SMTP id o15mr5019199eds.176.1642092530810;
        Thu, 13 Jan 2022 08:48:50 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:e200:8511:ed0f:ac2c:42f7? (p200300cbc703e2008511ed0fac2c42f7.dip0.t-ipconnect.de. [2003:cb:c703:e200:8511:ed0f:ac2c:42f7])
        by smtp.gmail.com with ESMTPSA id hq35sm1039972ejc.54.2022.01.13.08.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 08:48:50 -0800 (PST)
Message-ID: <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
Date:   Thu, 13 Jan 2022 17:48:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Liang Zhang <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
In-Reply-To: <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.22 17:37, Linus Torvalds wrote:
> On Thu, Jan 13, 2022 at 6:39 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> Let's bring Linus in on this, but I think this reintroduces all of the
>> mapcount problems that we've been discussing recently.
>>
>> How about this as an alternative?
> 
> No, at that point reuse_swap_page() is the better thing to do.
> 
> Don't play games with page_count() (or even worse games with
> swap_count). The page count is only stable if it's 1. Any other value
> means that it can fluctuate due to concurrent lookups, some of which
> can be done locklessly under RCU.

I'm pretty sure the patch as is will reintroduce the CVE. So I think in
addition to the reuse_swap_page() check we need more.

I'm wondering if we can get rid of the mapcount checks in
reuse_swap_page() and instead check for page_count() and swapcount only.

We don't care if it's unstable in a sense than it will be bigger than
what we expect. In that case we COW as we would already do.

Thoughts?

-- 
Thanks,

David / dhildenb


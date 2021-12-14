Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756D1474CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbhLNVD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhLNVD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:03:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADA3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:03:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c4so34563796wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 13:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aset2ikDotS3hcbpPPk7kj6RXe+C5lMKImjQj7BFUoI=;
        b=PE8uPggn/Y6TIJcjvKDJSVDZ9R2JuGX97cUD+2U7upZPBE7hTlCjCGc6HcXo+Zmrk3
         iigvZc8wp8AzftbZj47F1OKfDnUeX7/iXhNGI34sanQGL5bIFPIBtI91fLc1O3HscVTb
         tH30hvcECoenPvG38+FFFFWR0yX0niwo8l7lG8lxXEXwBpIFFKQOXjMLgQ8N83XZflvD
         Z316RCfOYoqlhWGpMkePqTPzQlmhTJCqIpDzxNQiLn1IL+hJUqNYXTSky0TkOxHzMLVq
         D7f/2ynCjLxo6y65x2UPBmRKupdazNSBa+O4w65wIIFPv6wTmXggvRaFP4RcGWXksIFY
         7Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aset2ikDotS3hcbpPPk7kj6RXe+C5lMKImjQj7BFUoI=;
        b=EQp/bt1db6S5RqVfmYSsNnc3WqEIMNroIK3MHTF9XOKKCR9RtDZfLmjktgBhtd5mpJ
         Kk7UUUWooFovD4NaXxtJ7vGc3wDyNMz0PggZFFgV/YJDILfI5oKBj++T3CLh85Q/ec/l
         YnFz4ZxlA+Nl6BPMbaKpRcmB/Wj+iB9TbVz1c2n3dF8HF0jH0SLF3gMQuJmLk+lP/sOW
         4NWB6qnO/YGRRvpu/aBk4bQQ/ILpj1Xx9Z97tFntRN+7F5HZ/rYxOq8KXl8lpZYPq8ed
         BJ6cz2RuoBuiQlhMNajB3VmnFNufOyFF/TxCNZnybwNx5aJxTyadfBzEUukj9gFrv+o5
         LB2Q==
X-Gm-Message-State: AOAM5302UDuww0FDZZKycMMGvqHrZHHncqLhqw4wvEe+sISXiYJIiBeB
        YWdfq2jtki7Y893Gne/aa0NqcA==
X-Google-Smtp-Source: ABdhPJzhhx1xv3ASG5UERixM2EHHJj6eLVoR3L4jYD4/oGFpht6VDmyRH9UNp9Y1NjwlHG52gzylMA==
X-Received: by 2002:a05:6000:1688:: with SMTP id y8mr1517654wrd.420.1639515806600;
        Tue, 14 Dec 2021 13:03:26 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f9c2:fca2:6c2e:7e9f])
        by smtp.gmail.com with ESMTPSA id f18sm20520wre.7.2021.12.14.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 13:03:25 -0800 (PST)
Date:   Tue, 14 Dec 2021 22:03:19 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm v3 29/38] kasan, vmalloc: add vmalloc tagging for
 HW_TAGS
Message-ID: <YbkGl/tmvEczufrk@elver.google.com>
References: <cover.1639432170.git.andreyknvl@google.com>
 <af3819749624603ed5cb0cbd869d5e4b3ed116b3.1639432170.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3819749624603ed5cb0cbd869d5e4b3ed116b3.1639432170.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:54PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
[...]
> +
> +	/* Skip unpoisoning and assigning a pointer tag for non-VM_ALLOC
> +	 * mappings as:

This is networking comment style, probably unintended here.

Thanks,
-- Marco

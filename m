Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391C347C10B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbhLUNxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:53:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235373AbhLUNxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:53:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640094791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cCiojVDqGo+GA9Om01qZmyV7vdC4IeemArE8M5swnAY=;
        b=hZ7O/Tel9Qx3KYNdVAifJ+9+WbqnDzx00oPS1rOEg+UJuyI/ggpUuRD5tVc+SsI4PR2KCe
        tALgzrNifDYIIZlQzoMrcCnBpnlXwMagiF/YTRESGnJFNNLBluGkv3CxKMgb1KUnmIS004
        xFen0+AD3isEFLdcW5ugOKfkveZs6XE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-dbVM8oSzPUuyrznQsRRY6A-1; Tue, 21 Dec 2021 08:53:10 -0500
X-MC-Unique: dbVM8oSzPUuyrznQsRRY6A-1
Received: by mail-wm1-f69.google.com with SMTP id l20-20020a05600c1d1400b003458e02cea0so1291914wms.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=cCiojVDqGo+GA9Om01qZmyV7vdC4IeemArE8M5swnAY=;
        b=Uipq+augpgtSNuIV8S9qJysU03SzCxI9AiiX6M9wnpla5HGNx+tRgpNyqZfJX36Cgw
         lZ1xUSdlykB+QohQGnxJXEga3VAS96SzGBEPU/UzhcTZ1Op+r/LRsqOYnEO8VZVf+m+2
         uBRtFmQaaNb0OALLZ7aneKsuaDZo9o1CzD5fdJ8qwKXxD+FPCSbLvSIsgipSS5wbLdZI
         8w8/AJY875O2FtahVNgBgFByBVdrMz7nz6+awEDiPH89bUl5AuYhFb7FZOphSRop5jSk
         kB8R0UgeVwd5M7GQ4zQ6lLZFlj6zDIwDD5xUYPTjOKI3zTEi/0e/oC7XkcEtOzlpLnts
         Q3rA==
X-Gm-Message-State: AOAM532WgK3tqHFuh+wdi0sRH/c/+68d1exREiFGkePaxL4i0aVuklol
        kvtqbm2SNKRmcjcR30RVemswC5D0fy9sP10Q6AszEhMv7VFZv2ZNSfekCrYNYTtDqbmP5Aa0G5j
        EQw5XrEkhTq53Y6Tj5id6Mimi
X-Received: by 2002:a1c:a755:: with SMTP id q82mr2867246wme.157.1640094789620;
        Tue, 21 Dec 2021 05:53:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymrqOMnWVIghYULt/19bqOhyflrDIfPhGY3YuCDa9jFkM6ghV+lGo44Ehjij64PeIAF5En5w==
X-Received: by 2002:a1c:a755:: with SMTP id q82mr2867236wme.157.1640094789440;
        Tue, 21 Dec 2021 05:53:09 -0800 (PST)
Received: from [192.168.3.132] (p5b0c64a4.dip0.t-ipconnect.de. [91.12.100.164])
        by smtp.gmail.com with ESMTPSA id 88sm15425562wrc.53.2021.12.21.05.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 05:53:08 -0800 (PST)
Message-ID: <14ac1cb4-1cf0-03a3-d412-c35fa9eeea59@redhat.com>
Date:   Tue, 21 Dec 2021 14:53:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] virtio_mem: fix panic on mb_states indexing overflow
Content-Language: en-US
To:     Eric Ren <renzhengeek@gmail.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, ziy@nvidia.com
References: <e60a66f60c059237bbf5cec3623c162a1bb1cbcb.1640005703.git.renzhen.rz@alibaba-inc.com>
 <32103255-7eba-08c1-8ab8-0730486332c1@redhat.com>
 <c7f5f829-5f2f-0c57-0599-6fc20fc8f1d7@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c7f5f829-5f2f-0c57-0599-6fc20fc8f1d7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

> _vm->sbm.first_mb_id == 0

^ that's precisely what I meant.

How could it *ever* be safe on x86-64 to let a virtio-mem device start
on physical address 0, eventually overlapping essentially all DMA, the
BIOS and the PCI hole.

Thus my question: Is this a "fix" for x86-64 or is this a "prepare for"
for !x86-64 (e.g., arm64).

If it's a fix, we want proper "Fixes:" and "Cc: stable" tags. But I
assume this is much rather a preparation for another architecture than
x86-64.

Thanks!

-- 
Thanks,

David / dhildenb


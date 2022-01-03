Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A06482FB2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiACJzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:55:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38141 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229742AbiACJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641203740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReOqXD+I8EyxszvuD588jUh/3Odrf45o569M2bnByyE=;
        b=fQ4627iBNAwxYqRtJ4pGXjZiA2iI+MaPKNpisyCz4aU7mmZ0CKuew5VeTxwyqKLM+WOh5g
        Tf8wN4bgtapiDjJTt+sisU9rcdHj3DhU1hDjkikwOUo9Qu+yZYQBgKISzTP0MRHs2AL9b5
        qTpsOeKUx3ZnbOZ6wb86SBc1nFhnyXk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-lcDwRDR0P9aTZ_Q9ld1_DQ-1; Mon, 03 Jan 2022 04:55:39 -0500
X-MC-Unique: lcDwRDR0P9aTZ_Q9ld1_DQ-1
Received: by mail-wr1-f70.google.com with SMTP id d13-20020adf9b8d000000b001a2aa837f8dso10105131wrc.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 01:55:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=ReOqXD+I8EyxszvuD588jUh/3Odrf45o569M2bnByyE=;
        b=V5doJONGDA0vbOh90d31VdWs1gPr4TgXFe5pSdwbVtY3hpgkm/ckAXiU+bsBHc/XhV
         d4iBq7RE3cbvYNyzfTkmDBccxrK/IsiA5jLyBvurTJgezfaNH+By1T4M6S75iLmxHm9u
         ROp+DKS0UvaPYAZNWrnq0mqkFf7kXnXFN9Gr9ZwDHCFvogVnOLxvtgNlKDLrQvQ2usVV
         Zp0/uNYsXGC4B1Cgynm+EZMYL3enNdxWf0B2sUYeq8sfspMFeExY6WPKebXpg/fOo2HD
         neZ+sOO3RYEsP9XfCosyL2hi7bpfYF50QM9/cDBfqvsHHDJ6rL+rSdD4KeaFPL4MumKE
         tfbQ==
X-Gm-Message-State: AOAM5321h95PxMld4IMCuBlvKu1nkvu5rlw5TqBOhmG99P46n/k/gpoq
        Ee23iXqBQsw4HEmHlq8AZB+wwgax+frJRHlHfxZbO63FVo4n8bC/SJRNL4o8UO49TXNqGW89MRu
        gVvRn7JkyUhEVFcLMI7axbLJp
X-Received: by 2002:a1c:2049:: with SMTP id g70mr38337852wmg.185.1641203737922;
        Mon, 03 Jan 2022 01:55:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsKF6Ldiw5VPh4VaceKSdWSZAr8Hhol9QI5QqOUpdW/HDGYogWEq6s8Pvno6wGSms6P9ktBQ==
X-Received: by 2002:a1c:2049:: with SMTP id g70mr38337847wmg.185.1641203737737;
        Mon, 03 Jan 2022 01:55:37 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6974.dip0.t-ipconnect.de. [91.12.105.116])
        by smtp.gmail.com with ESMTPSA id u20sm40059377wml.45.2022.01.03.01.55.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 01:55:37 -0800 (PST)
Message-ID: <bd3f2157-858c-b091-0982-12c425b2029a@redhat.com>
Date:   Mon, 3 Jan 2022 10:55:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
References: <1641190916-24751-1-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH V2] arm64/mm/hotplug: Warn when memory limit has been
 reduced
In-Reply-To: <1641190916-24751-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.01.22 07:21, Anshuman Khandual wrote:
> If the max memory limit has been reduced with 'mem=' kernel command line
> option, there might be UEFI memory map described memory beyond that limit
> which could be hot removed. This might be problematic for subsequent kexec
> kernel which could just access such removed memory.
> 
> Memory offline notifier exists because there is no other way to block the
> removal of boot memory, only the offlining (which isn't actually a problem)
> But with 'mem=', there is no chance to stop such boot memory being offlined
> as it where never in use by the kernel. As 'mem=' is a debug only option on
> arm64 platform, just warn for such a situation and move on.
> 

Hi,

but why warn on the offlining path?

IIUC, you'd have a layout like


[ boot memory ][ unused memory ]
               ^memory_limit

Let's assume "unused memory" corresponds to exactly one DIMM that can
get hotunplugged. The complete DIMM isn't added to Linux and not online,
so the offline notifier will never trigger.

Via which mechanism would the unplug of that memory happen? On arm64,
this should only be possible via ACPI, when unplugging a DIMM that was
available since boot.

But won't acpi_memory_enable_device() try adding that memory while
ignoring the memory limit? And adding should work, no?

Can you share some details on how to trigger this on arm64?

-- 
Thanks,

David / dhildenb


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D00483132
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiACM5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:57:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229514AbiACM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:57:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641214652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtHRy5Ohnx4vTqt4HL3s0oEFof8g2wOpu2Bww26wH0o=;
        b=ehUWYfwEjTpNAmCPB9RoP+yvw5CLv+nWgE6C5Wjq+dDIvxybtuMf2HfoXCbyEo/ge1QyLi
        Pfd8k1slc06+Z4LO3y1yh7dZsZVm16Sm5BmvHj4IEoZ7CXzmzCamufn9OAtmG3oXgU5hzg
        PPMBXy/UOeANxvUvnTfULM2yueU4cQ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-GgLgf2lTNbOM93Ot7bc6bQ-1; Mon, 03 Jan 2022 07:57:30 -0500
X-MC-Unique: GgLgf2lTNbOM93Ot7bc6bQ-1
Received: by mail-wm1-f69.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso16500590wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 04:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=rtHRy5Ohnx4vTqt4HL3s0oEFof8g2wOpu2Bww26wH0o=;
        b=Aj2owjEGRXGFYQatpSeysQnoLUn2nWHlROjtz/+k4UNwz+468doVMKpHl9juLEcj6Z
         +6j7D2Fdi9dBpNIOTr4pqXZbOuYGgpJa8GwjttDj65Japu7/msDGjLiNz9DclRoWR5xR
         aw3BmnsXdiLspoURnKDVdtJtPp7znqAdZBizSIJRq5r2PkZkRB3+EkBoP8YYQXV7fHGc
         WSdWuGYWxt5QUHu7bw2vm+Q/IDYEDdpT1r5913O349BTcz136JLYA3ERZEdAxURHfSih
         X/5VE8o1Q4uTDhWiH+lZwztABSNbM8zp0Tf65A9zxBWvLYzfj2Q2A/TuALUDBc7ZLyPE
         ChYg==
X-Gm-Message-State: AOAM531Dw2VTKwtdu5wDqoOtNxCxT5HOjvU0Vq4dZRnTY43a9W/NlVcz
        aK/ZUWNaQRdihTW0YFwFFeKtdELrQLiQ+TgnPhFwytPq2SatfCwmZiOB0UVEGQUtLUIlpDAqMEa
        dj9xIWFLwsNFyXIPGS8MbNc1U
X-Received: by 2002:a1c:9897:: with SMTP id a145mr38431876wme.194.1641214649667;
        Mon, 03 Jan 2022 04:57:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNFbRHlX3+JW2UIwAlHQfqEFbGkmkSTy1UKAUDkqCOFXRNx+q34gCIQqJQagxKEQ61e3r2uA==
X-Received: by 2002:a1c:9897:: with SMTP id a145mr38431865wme.194.1641214649414;
        Mon, 03 Jan 2022 04:57:29 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6974.dip0.t-ipconnect.de. [91.12.105.116])
        by smtp.gmail.com with ESMTPSA id a2sm39164107wri.17.2022.01.03.04.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 04:57:29 -0800 (PST)
Message-ID: <d8753c88-95f3-75ec-d6b6-27105a9a5968@redhat.com>
Date:   Mon, 3 Jan 2022 13:57:28 +0100
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
 <bd3f2157-858c-b091-0982-12c425b2029a@redhat.com>
 <c4104b5d-45b8-732a-45e9-0a1cb4954dde@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH V2] arm64/mm/hotplug: Warn when memory limit has been
 reduced
In-Reply-To: <c4104b5d-45b8-732a-45e9-0a1cb4954dde@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Via which mechanism would the unplug of that memory happen? On arm64,
>> this should only be possible via ACPI, when unplugging a DIMM that was
>> available since boot.
>>
>> But won't acpi_memory_enable_device() try adding that memory while
>> ignoring the memory limit? And adding should work, no?
> 
> Adding that memory via hotplug into the kernel first ? In that case
> removal would still go via the kernel and user would know about it.

Can we please add details on how to actually trigger it (below) to the
patch description? Otherwise it's really hard to get about which senario
we do care, and about which we don't care.

> 
>>
>> Can you share some details on how to trigger this on arm64?
> 
> The primary scenario this proposal is targeted towards is when boot
> memory is set aside from the host, hot-plugged back into the kernel
> and repurposed (via hotplug-hotremove path) for guest kernel usage.
> This new warning would reassert that "mem=" cmdline option is debug
> only on arm64 platform, and should not be used for production.
Let me get this straight:

1. Restrict physical memory to use via "mem="

-> Some boot memory is !present and, therefore !early

2. Hotplug that memory to the kernel

-> How?

a) dax/kmem? Does not apply I think.
b) DIMM? Does not apply I think.
c) CONFIG_ARCH_MEMORY_PROBE ?

3. Trigger physical hotunplug and actually remove the memory

-> How?

4. kexec; will try using hotunplugged memory


-- 
Thanks,

David / dhildenb


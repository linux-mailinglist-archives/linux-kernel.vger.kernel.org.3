Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2DD47C4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbhLURWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhLURWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:22:35 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4C4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:22:35 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id x15so10738109ilc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r4TtaoKR6+w2BbxrXfBzscheepGCVX5dJ59bu2XE0Ds=;
        b=VnBhSWQefpBVT2b0pz/7ZeOTyrjEp+Xkn0YvQb6PfeqyL2jdnvXYHwCh4ncvHolT3j
         G1+e63VfqwWBG273ftrqUdWfFETc5oftMo+x5Z1dj3H6Qj2/D3hncdiXtRRKbYlZAu4E
         p8X9HLJKF2MXGjIjMta++QR3KDTDbyOG4LSGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r4TtaoKR6+w2BbxrXfBzscheepGCVX5dJ59bu2XE0Ds=;
        b=Y8m8sC1eqz+N7Gw86Mi+j8SRL8Ei1cVpV1+9VEUlldg/eyL0G7UDI6U3ClcdUwwcQD
         omgnoDSzQHTG8L0UUBU3y0oeVcBH75tw9X+kqblfgkQkMfUATug7tQd4H/dzb9WzYdWA
         RJvVQl4kAb4ZB7USAjfCbNdkaF6kzdKstRYoNdsJPBVrEZs3zxnXp04IhLzq7Sq28kdv
         Sbj21bRpok/1//HXrBA/O/bc/v5US3C6rpVXus1Vk7aikCNB3OjHGxcDWZYk8Dt7LzEu
         0G8vG2elLmwHT302q57mn2zfpP67irUAfMdKVjRto7S5TPMzFM6tjydnD6PgP6lhDHtD
         zleA==
X-Gm-Message-State: AOAM5300dx5yWD4am8pyzyUvghc9UXXknsNDn6XpPLdPjQu5VuzvCEWG
        S0gwFvx++zywqeQjMpGLdOzsEw==
X-Google-Smtp-Source: ABdhPJyI1IqcAXOfBvHsRSlq/TpODWZldpSt+9i96f0MwjG04pQlNqa7NSStvHzPlbcSKVsZOodgUA==
X-Received: by 2002:a05:6e02:12e5:: with SMTP id l5mr2169481iln.316.1640107354480;
        Tue, 21 Dec 2021 09:22:34 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j6sm11288938ilc.8.2021.12.21.09.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 09:22:34 -0800 (PST)
Subject: Re: [PATCH] KVM: selftests: Fix compile error for non-x86
 vm_compute_max_gfn()
To:     Anup Patel <anup.patel@wdc.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211221125617.932371-1-anup.patel@wdc.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3e3b5295-f6fb-1ff9-acfe-1a4c47c6ba20@linuxfoundation.org>
Date:   Tue, 21 Dec 2021 10:22:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211221125617.932371-1-anup.patel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 5:56 AM, Anup Patel wrote:
> The inline version of vm_compute_max_gfn() in kvm_util.h directly
> access members of "struct kvm_vm" which causes compile errors for
> non-x86 architectures because lib/elf.c includes "kvm_util.h" before
> "kvm_util_internal.h".
> 
> This patch fixes above described compile error by converting inline
> version of vm_compute_max_gfn() into a macro.

Thank you for the patch. Please include the actual compile error in the
change log and send v2,

thanks,
-- Shuah

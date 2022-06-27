Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BC055E30B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbiF0PU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236789AbiF0PTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:19:22 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21432B7DB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:19:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id t21so9346953pfq.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YaZf+iuRf5VcdUABylMh/I8zxebuNZqSPzEggA0QsB8=;
        b=EAZiPo1z5Oj055MNcLne6utIxA3+KNzAFdg+8cktsPfsaEj9t+alS08Gh9t/KvWzfJ
         MNEVhFUpDFSbSWqT1iKKSAuOYTXK8siJi1QzE9kbM0TGnNmPsOYBQX3jTLA/yBIp6onh
         rXK0DS2rmHFfxfgT3Mgeq7ObsFasLHWqqbUFKLWtZO1mIXSDvb8pJ9wVBOQk8hxwpB4m
         A9u841zQ/QP/0xkYJbpiVw0l2qQiwa8OvZLZyXR+mLK0VyyKaXxVYC8R/pad2jfp5wwD
         c3HlXmdX3bsjsQUb7jaCyTxAFEs95x9V1NtkWJ1+bcQPrr4mDuV6Bd1kbrTgmOacdfk8
         Wfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YaZf+iuRf5VcdUABylMh/I8zxebuNZqSPzEggA0QsB8=;
        b=2bknJPXvhmP8JkAzZZIRVF6dC3a3QP1653VfHp3LtFjVEIGBLNml27KTzOqmlTYYcu
         J628E94KT2Oz10uJSvytDKOMgXxo53ome9ns4zvjrq5oFxoX1NENYsjGMboeDbtcTP7h
         MRIgBe/BT0ftSSuxxIt7svjARyoAHQVVKovmTDkiZL6loj+6EKnVoK3hUXKpgZDAyz9u
         Di7taLK2z1xsv1DQZbAHhpAVOfXKwCtFT5YM5UAaJ17QQ5/Ji9iN1ijIfWdYFnqqzAE1
         jeaJ2409XjVQPFi7HHAAw5yikfOH8wI+0hb+PEFzCyEo3KWmX3G2fLdJcVEP6AS09mc/
         hJzQ==
X-Gm-Message-State: AJIora8Gs2KdmIr/NNmvWfPT+fmyBcD1TTaEZTrQhJRdbtkmFBdrxvvR
        cRSNeSQop9iGbIYNwUV7dH2sAg==
X-Google-Smtp-Source: AGRyM1vHuTM6ZgX8JalSiT8QyeSxhAVGc/h5+tA5iASu1cjNANEQXeoNehpvLiPcclhIac/WHxozOg==
X-Received: by 2002:a63:90c7:0:b0:40d:3c0d:33f4 with SMTP id a190-20020a6390c7000000b0040d3c0d33f4mr13116674pge.334.1656343159459;
        Mon, 27 Jun 2022 08:19:19 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id bf20-20020a056a000d9400b00525392cb386sm7451670pfb.201.2022.06.27.08.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 08:19:19 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:19:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paul Durrant <pdurrant@amazon.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4] KVM: x86/xen: Update Xen CPUID Leaf 4 (tsc info)
 sub-leaves, if present
Message-ID: <YrnKc6RoqDM/At3T@google.com>
References: <20220622151728.13622-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622151728.13622-1-pdurrant@amazon.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022, Paul Durrant wrote:
> The scaling information in subleaf 1 should match the values set by KVM in
> the 'vcpu_info' sub-structure 'time_info' (a.k.a. pvclock_vcpu_time_info)
> which is shared with the guest, but is not directly available to the VMM.
> The offset values are not set since a TSC offset is already applied.
> The TSC frequency should also be set in sub-leaf 2.
> 
> Cache pointers to the sub-leaves when CPUID is updated by the VMM and
> populate the relevant information prior to entering the guest.

All of my comments about the code still apply.

https://lore.kernel.org/all/YrMqtHzNSean+qkh@google.com

> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> ---
> Cc: David Woodhouse <dwmw2@infradead.org>

Cc: can go in the changelog, it's helpful info to carry with the commit as it
documents who was made aware of the patch, e.g. show who may have had a cance to
object/review.

> 
> v2:
>  - Make sure sub-leaf pointers are NULLed if the time leaf is removed
> 
> v3:
>  - Add leaf limit check in kvm_xen_set_cpuid()
> 
> v4:
>  - Update commit comment

Please start with the most recent verison and work backardwards, that way reviewers
can quickly see the delta for _this_ version.  I.e.


v4:

v3:

v2:

v1:

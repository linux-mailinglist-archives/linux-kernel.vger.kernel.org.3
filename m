Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5E650F015
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 07:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbiDZFIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 01:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiDZFIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 01:08:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194C1E6466
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:04:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a11so5671860pff.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 22:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lPXsvXXGB7VzRP9ej4ptpjaenvWfGjQbLRTTAEwWda0=;
        b=jo/48cGIu/kMQ9mRy2bQKU5eHnn/f92jmtF0iR9CR/UrRqME7GNoU7GYIMgI8mEhep
         zy/VQmUa6lucV+0vu1gJgW4tHzaz04opC1mJ2FiRFyMXaRelrZ+YB5A+20X/GRbuvVXS
         HPS0Odmf6sHfqmg6mGn75ywZuE1xlpccshGRpsNW5TnadiRYQWb0xDG50+N1yNlccYu6
         +SpTX75xVCKHQm3sCTAgkI/ovpLb/oXsxUpcu20usNovyXK+FvegmPnGaYZ9jMW51mmI
         jc17P0+S1c2HxwgDIMrqfkYc0c4PdupZzr/dBxxVT1kJkL8Zj/X+c/qphcqvAdlLZZPB
         PXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lPXsvXXGB7VzRP9ej4ptpjaenvWfGjQbLRTTAEwWda0=;
        b=Mk9zbq76DcMpI7oNFzabp+WEsqhXTTVmU22l/obXMV//4oWZuzl//kr81vUXKefDsW
         xCXjLug0RB0r7lxJjA95uBKyemPX6w9oMrDgMWk92FvzbEqNAuasoQTSCzziUtGyWdwY
         a38f0I3NWABxxF9V0AB0yhNgaxlJHWPYZtr83peUrhsX5chmCI/eu8RH2LLpgmAUWpKb
         xkiUXweJ9jBKgMoM2pxPi37UiiMOjGLCBkgwNwcue1yFjDOMNAXfwvLCf8rlFZC0y/cw
         ZeA6rUiyBwN/1sO2mFq36iEl02oXrsJ7H3++wx7QbPbBrNZvgOh7Zp8pV27o4R0ij38K
         id8g==
X-Gm-Message-State: AOAM530EiSC3OVeh8Aps7ltR3Ip6VrExX3MET+NFby4qD1GfgBxaKW9l
        mzsJ9AyPugUFLT5ZFsG12pePsw==
X-Google-Smtp-Source: ABdhPJx/qAZq2zf7Iyqg3U1jZcXi6gNTqwfkvznUFbMm5a7xwNnu4FewaA8aIJv1P1nd8KUwWw2DOQ==
X-Received: by 2002:a63:40c6:0:b0:39d:9463:94ac with SMTP id n189-20020a6340c6000000b0039d946394acmr17583134pga.289.1650949497556;
        Mon, 25 Apr 2022 22:04:57 -0700 (PDT)
Received: from [10.69.0.6] ([94.177.118.37])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090a718b00b001cd4989feb9sm1108161pjk.5.2022.04.25.22.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 22:04:57 -0700 (PDT)
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
References: <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica> <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <51514a02-0de9-2f9e-ec0e-c86e147fa74c@linaro.org>
Date:   Tue, 26 Apr 2022 13:04:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/26 下午12:20, Fenghua Yu wrote:
> Hi, Jean and Zhangfei,
>
> On Mon, Apr 25, 2022 at 05:13:02PM +0100, Jean-Philippe Brucker wrote:
>> Could we move mm_pasid_drop() to __mmdrop() instead of __mmput()?  For Arm
>> we do need to hold the mm_count until unbind(), and mmgrab()/mmdrop() is
>> also part of Lu's rework [1].
> Is this a right fix for the issue? Could you please test it on ARM?
> I don't have an ARM machine.
>
> Thanks.
>
> -Fenghua
>
>  From 84aa68f6174439d863c40cdc2db0e1b89d620dd0 Mon Sep 17 00:00:00 2001
> From: Fenghua Yu <fenghua.yu@intel.com>
> Date: Fri, 15 Apr 2022 00:51:33 -0700
> Subject: [PATCH] iommu/sva: Fix PASID use-after-free issue
>
> A PASID might be still used on ARM after it is freed in __mmput().
>
> process:
> 	open()->sva_bind()->ioasid_alloc() = N; // Get PASID N for the mm
> 	exit();
> 	exit_mm()->__mmput()->mm_pasid_drop()->mm->pasid = -1; // PASID -1
> 	exit_files()->release(dev)->sva_unbind()->use mm->pasid; // Failure
>
> To avoid the use-after-free issue, free the PASID after no device uses it,
> i.e. after all devices are unbound from the mm.
>
> sva_bind()/sva_unbind() call mmgrab()/mmdrop() to track mm->mm_count.
> __mmdrop() is called only after mm->mm_count is zero. So freeing the PASID
> in __mmdrop() guarantees the PASID is safely freed only after no device
> is bound to the mm.
>
> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")
>
> Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Thanks for the fix.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>


> ---
>   kernel/fork.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9796897560ab..35a3beff140b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
>   	mmu_notifier_subscriptions_destroy(mm);
>   	check_mm(mm);
>   	put_user_ns(mm->user_ns);
> +	mm_pasid_drop(mm);
>   	free_mm(mm);
>   }
>   EXPORT_SYMBOL_GPL(__mmdrop);
> @@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
>   	}
>   	if (mm->binfmt)
>   		module_put(mm->binfmt->module);
> -	mm_pasid_drop(mm);
>   	mmdrop(mm);
>   }
>   


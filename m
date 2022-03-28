Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1262A4EA149
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344420AbiC1UUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344410AbiC1UUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:20:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2DA22527
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:18:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g9-20020a17090ace8900b001c7cce3c0aeso314550pju.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zEO73/klvJY0XxHebACPXmzj87UKrtx/E5ofQ5laclI=;
        b=BJAjHvV8b5+6vXki2ZavfOGiTz+fQzVf6GH0KLCn8oWPZj8Xv17daoOP3mLHYUmOAY
         4Zz+BBZfO+4GcsfIxt5gROivUg8hjIkEXrqgS+GnVHY42ulcI+eXZErbEYH+SB7dChAF
         Bs1CfsRO/+OfdOtJFrHzrNrJVoQVJGEoZ8T8rVehX6v+qKFxu+J1Y9jDBuVWo6UKjZ3G
         jKqAPXuiUG2B/NLjsNyaOHZ+7/lvm5cmT/ovWVirGSctJYD29ODlWxx+LweM3V/zZ5nN
         i3S4hf2LII6zqXZZPvF1WrNNDsD7iftRN9mM9MGHrkbjl06JygwBAuJAaJmiA5ZR/dwB
         Ek6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zEO73/klvJY0XxHebACPXmzj87UKrtx/E5ofQ5laclI=;
        b=ipfECn1+Fzi8j6sXxNigkj5Xlryx4Gnl2DZW2xWMuDZnLUgZ5e/Pmnm/gAvjEE5Th6
         A2by5ivnQb8M1pAS5iAptzDRwuxg759aXQONinFQZMQ6ggOGRd+aOrXpI1h4krnlPqaP
         juDcTbVZ/Z68uPcmx++Vnhr+baN8n4wGCPudxo5aJAJqLoOpFb1A+FmJuxDSucRiA4qU
         Dc/zSGZW8pZGCWt6NWofkLj3K/DMnsvZ2E332shWAH4G56EPIjkYxJgn7kqE8HQw7EC2
         ZIzsb60e/SOv9kS2GpIQzNiVTy1TYd62nkaoKKr98XV0SkfYWrvV4OHvIE2QlaY0msLm
         Atfg==
X-Gm-Message-State: AOAM531tALumQzUzN8W/25i9YKVqVGPtUJXloVlSCvc/JPfysc/jbI3T
        bND/YHLUQeDhtNflUESv/r9a7Q==
X-Google-Smtp-Source: ABdhPJx1XdHg366ztNik62gGZ7COHZ7IZzQ7cjiOLii9D6aAlRskMzBPqX02oU/FSQnuaFD1HroyKA==
X-Received: by 2002:a17:902:d2c6:b0:156:2b2c:ab54 with SMTP id n6-20020a170902d2c600b001562b2cab54mr621389plc.52.1648498716333;
        Mon, 28 Mar 2022 13:18:36 -0700 (PDT)
Received: from google.com (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7920d000000b004fa94f26b48sm16471350pfo.118.2022.03.28.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 13:18:35 -0700 (PDT)
Date:   Mon, 28 Mar 2022 20:18:31 +0000
From:   David Matlack <dmatlack@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v2 07/11] KVM: x86/MMU: Factor out updating NX hugepages
 state for a VM
Message-ID: <YkIYF6HzLy+l6tu8@google.com>
References: <20220321234844.1543161-1-bgardon@google.com>
 <20220321234844.1543161-8-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321234844.1543161-8-bgardon@google.com>
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

On Mon, Mar 21, 2022 at 04:48:40PM -0700, Ben Gardon wrote:
> Factor out the code to update the NX hugepages state for an individual
> VM. This will be expanded in future commits to allow per-VM control of
> Nx hugepages.
> 
> No functional change intended.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 3b8da8b0745e..1b59b56642f1 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6195,6 +6195,15 @@ static void __set_nx_huge_pages(bool val)
>  	nx_huge_pages = itlb_multihit_kvm_mitigation = val;
>  }
>  
> +static int kvm_update_nx_huge_pages(struct kvm *kvm)
> +{
> +	mutex_lock(&kvm->slots_lock);
> +	kvm_mmu_zap_all_fast(kvm);
> +	mutex_unlock(&kvm->slots_lock);
> +
> +	wake_up_process(kvm->arch.nx_lpage_recovery_thread);
> +}
> +
>  static int set_nx_huge_pages(const char *val, const struct kernel_param *kp)
>  {
>  	bool old_val = nx_huge_pages;
> @@ -6217,13 +6226,8 @@ static int set_nx_huge_pages(const char *val, const struct kernel_param *kp)
>  
>  		mutex_lock(&kvm_lock);
>  

nit: This blank line is asymmetrical with mutex_unlock().

> -		list_for_each_entry(kvm, &vm_list, vm_list) {
> -			mutex_lock(&kvm->slots_lock);
> -			kvm_mmu_zap_all_fast(kvm);
> -			mutex_unlock(&kvm->slots_lock);
> -
> -			wake_up_process(kvm->arch.nx_lpage_recovery_thread);
> -		}
> +		list_for_each_entry(kvm, &vm_list, vm_list)
> +			kvm_set_nx_huge_pages(kvm);

This should be kvm_update_nx_huge_pages() right?

>  		mutex_unlock(&kvm_lock);
>  	}
>  
> -- 
> 2.35.1.894.gb6a874cedc-goog
> 

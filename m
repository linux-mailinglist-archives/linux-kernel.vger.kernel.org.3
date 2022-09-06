Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FBA5AEEA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiIFPZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239878AbiIFPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:24:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1C424BDC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:36:19 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l14so273366eja.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rMmt2TPlkwTJa1Vj/UqXw4OPfF6SV2ruzHSSjtSG6gI=;
        b=p8gTx3uOF4/ovmXPFVRTuzyCMLlLLhT4cULIky1/IL8+iHMHN/Vt9kisTT0x13y5y6
         1JrMubmWdS3RiAIdUBO3BzsfLe93IIXY2jVDIsDfOzVyq86Dk+K8V2v9nl1aYoEDOqzO
         v4BmSEkFlehCfvhThoWnOBq4wXZLuZG4tGqjgg3iQIBi2WhnLil3QOGlU+jcm0dvTxdb
         FBDNP3wkiukuDA9WlvUR289cSqbCdxmcqmidlmPrHl0GKV9BhrStliKQ0zbklVtzcvVg
         bW9RYHZlO/Ymx1i7ZL2HN7OGRdn6pV+RqJ6HLVkZg4niM2nbzxR7mHgCEEiZeD8UW7ET
         nBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rMmt2TPlkwTJa1Vj/UqXw4OPfF6SV2ruzHSSjtSG6gI=;
        b=S6W+0gcdAyAZ3SAj7bU1cAQ/A9d3rTn9OflMQ55bHuYPYkvjofJUvdoEJYPTtTqDwI
         BBNocjxvme5plnXRmv5EKeWbsPYnknFI4GdtuJc1KvzY2SE8WN5RgkBzLDmziaWszF0p
         zrKfa8+64cb9UXMDlDWHUQiAtg2U4L6kf9VdOixAdhuVlN/XrQXUv+sGPpKwn12X6duA
         ZOT17yRJPb5RXYeJO4vAWpHCmaub2g3iyS+3Hiz5Tr19NQi9oKz1tC2uhlG+Q5cHEXHA
         cF3K6TPLg11GzBtWUatDdr1O5qbiem7asWYdVzJtSr3C6HN9HpEeTTTF83CjsefDEIlh
         YdMg==
X-Gm-Message-State: ACgBeo2FH4aO5fwiTevi9sfyoxJDvmpxlAIbNNQrm3hacD3JytkukDFu
        jrbDUBVYS0ejOfm8v8z/ugu/ug==
X-Google-Smtp-Source: AA6agR5np46sPXKIJ6mj4xhD1w/LSNMP/pZ9ZrZilKDS7z6Q4hPFRehMAa3RPeEVWH2GeFCQf1WWwQ==
X-Received: by 2002:a17:907:2cd4:b0:73c:9fa8:3ddc with SMTP id hg20-20020a1709072cd400b0073c9fa83ddcmr30463131ejc.40.1662474950709;
        Tue, 06 Sep 2022 07:35:50 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id h41-20020a0564020ea900b0044629b54b00sm8561495eda.46.2022.09.06.07.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:35:49 -0700 (PDT)
Date:   Tue, 6 Sep 2022 14:35:47 +0000
From:   Quentin Perret <qperret@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] KVM: arm64: Tear down unlinked stage-2 subtree
 after break-before-make
Message-ID: <Yxdaw1qng/Or0LLA@google.com>
References: <20220830194132.962932-1-oliver.upton@linux.dev>
 <20220830194132.962932-3-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830194132.962932-3-oliver.upton@linux.dev>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Tuesday 30 Aug 2022 at 19:41:20 (+0000), Oliver Upton wrote:
>  static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
>  				     kvm_pte_t *ptep,
>  				     struct stage2_map_data *data)
>  {
> -	if (data->anchor)
> -		return 0;
> +	struct kvm_pgtable_mm_ops *mm_ops = data->mm_ops;
> +	kvm_pte_t *childp = kvm_pte_follow(*ptep, mm_ops);
> +	struct kvm_pgtable *pgt = data->mmu->pgt;
> +	int ret;
>  
>  	if (!stage2_leaf_mapping_allowed(addr, end, level, data))
>  		return 0;
>  
> -	data->childp = kvm_pte_follow(*ptep, data->mm_ops);
>  	kvm_clear_pte(ptep);
>  
>  	/*
> @@ -782,8 +786,13 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
>  	 * individually.
>  	 */
>  	kvm_call_hyp(__kvm_tlb_flush_vmid, data->mmu);
> -	data->anchor = ptep;
> -	return 0;
> +
> +	ret = stage2_map_walk_leaf(addr, end, level, ptep, data);
> +
> +	mm_ops->put_page(ptep);
> +	mm_ops->free_removed_table(childp, level + 1, pgt);

By the look of it, __kvm_pgtable_visit() has saved the table PTE on the
stack prior to calling the TABLE_PRE callback, and it then uses the PTE
from its stack and does kvm_pte_follow() to find the childp, and walks
from there. Would that be a UAF now?

> +	return ret;
>  }

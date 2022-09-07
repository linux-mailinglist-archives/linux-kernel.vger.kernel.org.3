Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938615B0EB0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 22:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiIGU5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 16:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiIGU53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 16:57:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C30FAEDB7
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 13:57:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so164760pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=D3RjQ0ycHa7B/7TKXUqNYyCf5lxoaaHEC6kuhsk3puQ=;
        b=idXPP15TJ7IS7iOdTlcgO/fcRqVHkI5cBChgxzLuZESpPUM6XsRZaDDRlyZt5BL5jA
         NnDWTztN/R3V3J5Z1YZuFWvgmRdivTwGx7C0YTX8U3GFYFDSyYNpSXVfEvPcf6DA88z9
         8kLgdpa7Q4m7CU2vRCW6SLTrKfYckFsVNWOY2H42ZOxS7KeLUcJ7gnpWeG5GGIX+7+U1
         TFWxa2aATU45JtkYWSOrYquLa9hMQdzhjn7oTetBNz+hF31OaKxN3BgxaWlaxzW2WqmT
         wPPWvIoyABeiowfiSdUX1HROmgtTeBq4Kjy6fIipWcmDCYtgsG9s9yt5yytaexuEMaX1
         PSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=D3RjQ0ycHa7B/7TKXUqNYyCf5lxoaaHEC6kuhsk3puQ=;
        b=pLe1MZuXf54Bzxwt1efB40+J3d3XZ914mQ9Hjo3Kom9UCPzcVmcj1kNjlAQ+IGnqfb
         Mhm8mOPwbg7sn89oSVlonfI8WFBbvuVZt88eF4hr+UDS7KhYrnRn3pNgA0CnlYYwCJIu
         h1pZ/Ojf38TwSlB4Wh+DsPOY64oFJytl6RLvlsc6ILuPwREVsVSjYZX9V6g2/tzZMKiP
         /nznp/9aECONqqh8yEPqkXEyv5YlVSvQEN4U9sVBOL6UvXKu7XWZhrCrq4ATkFmgjRhh
         LNHEd9LPQzkjqIWUtaAxLD26cqSHcFrejpOq4hevyoDNdSkr8Xj9rGfuaRZ4/9s4KjAC
         ZYJQ==
X-Gm-Message-State: ACgBeo0vLhRipqHMXkV011jouTUTXD0r3GoQedyudAu7vJkqV9anDpXW
        Aaa4QpIWDA/uEeu4EhVnFK9H0A==
X-Google-Smtp-Source: AA6agR4y0YI6Do787IPnCmL86e80gRfI6CK4dTypbO17kG+PMFuHSAWq0jEGksDH17TMqhJ3tnUYKg==
X-Received: by 2002:a17:90b:33c9:b0:200:a0ca:e6c8 with SMTP id lk9-20020a17090b33c900b00200a0cae6c8mr357636pjb.147.1662584244248;
        Wed, 07 Sep 2022 13:57:24 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id v6-20020a1709029a0600b00176a47e5840sm8258330plp.298.2022.09.07.13.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 13:57:22 -0700 (PDT)
Date:   Wed, 7 Sep 2022 13:57:17 -0700
From:   David Matlack <dmatlack@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Ben Gardon <bgardon@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] KVM: arm64: Tear down unlinked stage-2 subtree
 after break-before-make
Message-ID: <YxkFrSmSKdBFEoZp@google.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 07:41:20PM +0000, Oliver Upton wrote:
[...]
>  
> +static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> +				struct stage2_map_data *data);
> +
>  static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
>  				     kvm_pte_t *ptep,
>  				     struct stage2_map_data *data)
>  {
> -	if (data->anchor)

Should @anchor and @childp be removed from struct stage2_map_data? This
commit removes the only remaining references to them.

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
[...]
>  static int stage2_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>  			     enum kvm_pgtable_walk_flags flag, void * const arg)
> @@ -883,11 +849,9 @@ static int stage2_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>  		return stage2_map_walk_table_pre(addr, end, level, ptep, data);
>  	case KVM_PGTABLE_WALK_LEAF:
>  		return stage2_map_walk_leaf(addr, end, level, ptep, data);
> -	case KVM_PGTABLE_WALK_TABLE_POST:
> -		return stage2_map_walk_table_post(addr, end, level, ptep, data);

kvm_pgtable_stage2_set_owner() still uses stage2_map_walker() with
KVM_PGTABLE_WALK_TABLE_POST.

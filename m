Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BE35B21B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiIHPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiIHPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:11:38 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8717D13B11E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:11:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 202so17028500pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=aTBij0MKfHujyUmk5AcvjcEPDYsuhsMOVk1UDlCpwHM=;
        b=M8sDj3UF6N8I7JnxOD5qpHcBpkICJr+jJbnZkTKusip2DzAxWgiNLQ6mj7h8OEkpD6
         7fubBL7T9kK7c3AohI7ypbXz811/OZvC5CTxzgbqPwOybqN9tFi6uw95Zcd5vSciyPK4
         S+W7qD3SR4im8zMU0XHmJV/sA6tAILo//CEVix9HLeB9cKQUbxOKii2rsTpxve1LMRmx
         5FFykgBQ2jC1ECefm4B0Xb/aBy+8hjxOghGPi8x3hmyqP5wIoPkS8aXgm2XC5x1Dnxt4
         BPW0xb5jRAoqOXGUXO/9jXwGdfBAV11vjdL1x2Ewj6q4oFlLSU6ZWuyxR/86W9GK6GRG
         dpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aTBij0MKfHujyUmk5AcvjcEPDYsuhsMOVk1UDlCpwHM=;
        b=GtHgNmmWMzFU3EKv65qKjvbaaSurqBRSRebFhLP7uPfqj9ksMCUDZn6WDtI+ILuHpu
         cXc2DtQjTKsome1GGnF54aBMspEED7xyoAnYBMZLAsgIug50X/jwVJniIoVNGwZJYcT9
         Vkq5+k5UPV+TH+suQwHEJ7avkAy3TVkBp5Yt+ax3eZf+2l8W+ffBqZmN8B8bNrjB64ea
         AYFaAOgpPCGARocIVMT2eKHkgKd7zRA7TcOekUqj1lAB8ipyzzelISUOKFit5LT5sLP4
         5QCyNyk6HePrZaBhQU2hB6kIxFELKeWwlqDFneez7JZk0cO8k4/P1z/W9mlgpOE3C8Xw
         m1XA==
X-Gm-Message-State: ACgBeo3IuPqD1oKC4+jbHosm62kRUCuDFME6fsuI7KPbeJSLWxA6Iz4Q
        xS+jizOVrJQp8w/to+n2YvlMMw==
X-Google-Smtp-Source: AA6agR52H9GqkwF66V9j3sYZCEhIamP67gNhXAIhkPKoFl7VQPznDhLiYGxoAwhmixzGU+O0GNIEfA==
X-Received: by 2002:a05:6a00:2395:b0:536:8296:51d5 with SMTP id f21-20020a056a00239500b00536829651d5mr9625772pfc.84.1662649894875;
        Thu, 08 Sep 2022 08:11:34 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id jc3-20020a17090325c300b00174abcb02d6sm10263695plb.235.2022.09.08.08.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:11:34 -0700 (PDT)
Date:   Thu, 8 Sep 2022 15:11:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Harald Hoyer <harald@profian.com>
Cc:     ashish.kalra@amd.com, ak@linux.intel.com, alpergun@google.com,
        ardb@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        dgilbert@redhat.com, dovmurik@linux.ibm.com, hpa@zytor.com,
        jarkko@kernel.org, jmattson@google.com, jroedel@suse.de,
        kirill@shutemov.name, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        marcorr@google.com, michael.roth@amd.com, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org, pgonda@google.com,
        rientjes@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        slp@redhat.com, srinivas.pandruvada@linux.intel.com,
        tglx@linutronix.de, thomas.lendacky@amd.com, tobin@ibm.com,
        tony.luck@intel.com, vbabka@suse.cz, vkuznets@redhat.com,
        x86@kernel.org
Subject: Re: [[PATCH for v6]] KVM: SEV: fix snp_launch_finish
Message-ID: <YxoGItJDTEjfctaS@google.com>
References: <6a513cf79bf71c479dbd72165faf1d804d77b3af.1655761627.git.ashish.kalra@amd.com>
 <20220908145557.1912158-1-harald@profian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908145557.1912158-1-harald@profian.com>
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

On Thu, Sep 08, 2022, Harald Hoyer wrote:
> The `params.auth_key_en` indicator does _not_ specify, whether an
> ID_AUTH struct should be sent or not, but, wheter the ID_AUTH struct
> contains an author key or not. The firmware always expects an ID_AUTH block.
> 
> Link: https://lore.kernel.org/all/cover.1655761627.git.ashish.kalra@amd.com/

Please provide feedback by directly responding to whatever patch/email is buggy.
Or if that's too complicated for some reason (unlikely in this case), provide the
fixup patch to the author *off-list*.

> Signed-off-by: Harald Hoyer <harald@profian.com>
> ---
>  arch/x86/kvm/svm/sev.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 85357dc4d231..5cf4be6a33ba 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -2242,17 +2242,18 @@ static int snp_launch_finish(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  
>  		data->id_block_en = 1;
>  		data->id_block_paddr = __sme_pa(id_block);
> -	}
>  
> -	if (params.auth_key_en) {
>  		id_auth = psp_copy_user_blob(params.id_auth_uaddr, KVM_SEV_SNP_ID_AUTH_SIZE);
>  		if (IS_ERR(id_auth)) {
>  			ret = PTR_ERR(id_auth);
>  			goto e_free_id_block;
>  		}
>  
> -		data->auth_key_en = 1;
>  		data->id_auth_paddr = __sme_pa(id_auth);
> +
> +		if (params.auth_key_en) {

While I'm here though...  Single line if-statements don't need curly braces.

> +			data->auth_key_en = 1;
> +		}
>  	}
>  
>  	data->gctx_paddr = __psp_pa(sev->snp_context);
> -- 
> 2.37.1
> 

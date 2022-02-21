Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154DC4BDD5F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346212AbiBULh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:37:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiBULh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:37:56 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09651AD98
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:37:32 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id e8so6243374ljj.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 03:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7bcBxxLvB8a1gVwhcGni5GvVkzOKi4tvu2bJMKdqE90=;
        b=Q2SAOB0ZREJE0qo/SdMw4x0BGmiyIo4ZMbg7gVev3Jzn4Y+n9TNBaITUIGJzNzXosD
         RoGnQkXHAIqji9mrejxuCSNksbV0OZuNlTHXPnn37NpXBHLPp9qiRktZt113kdbS49Z/
         Aim0ieQHUnDmK/sCuOhHgKLkoL++tcbcsPobDEX8oUTe6LC1afmn13dzcSru+iapnk6h
         9pYaud0gig8KmV+cLguuFvL8mAsdQejnrtWZkBX2gRBXuOYU3DF2JX1TNa/ujrXeCKRL
         UImL6FybvrrFdeWztnwkthtQyqaaLOiD4H1zxk43gZo4mJ7VykDLTxo5LCs2EoMDvQV4
         aZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7bcBxxLvB8a1gVwhcGni5GvVkzOKi4tvu2bJMKdqE90=;
        b=dtT/kQf1se1BLvUuDWXFk4J8O0em/R+2O0R01+s9c47FuH09oG7COFj+FS9wCGT4vS
         VfHEZHuiGpjCGSYbrCBCQfu/2gclI2buJTDWknj0BwYzV/6uCiIjHqcF6+2AeKpDq0SA
         NvzLCV1gOl2e8EEi5Yvicj99dveE4dwjhBnqCj+1DLMDdqhP9TL0K+M9Oz9tK+QrdRT7
         eWQgaCgj5R3G9YUGEt+Ih6g5JMC0WylS1Or5kCUehopLbqXfFTgtfDsRKFTa1I+VFCSe
         yBY7pqFmccsqCI5wNVrc6itc1MKHGvaUHGPk4Uio2WQICjjuSZVY2sixhZO3hpOsCuDC
         DBsw==
X-Gm-Message-State: AOAM530/I1gVk1mxHjZx0TUeXz+Ms10PZ0grD6+DDvX9LNfmDLXQ24zx
        e23gyDMo6Tk84sFXuHQzo7Q=
X-Google-Smtp-Source: ABdhPJx6QMCTVPlgNuDZunl1YOP2ccaC02UF2+Ahd7ddv93HdGlWRZ5YeCmdJr2YU6mRkRUXImcm2g==
X-Received: by 2002:a2e:9c94:0:b0:244:4ec3:3313 with SMTP id x20-20020a2e9c94000000b002444ec33313mr14180060lji.281.1645443451135;
        Mon, 21 Feb 2022 03:37:31 -0800 (PST)
Received: from grain.localdomain ([5.18.251.97])
        by smtp.gmail.com with ESMTPSA id a22sm1092533lfr.24.2022.02.21.03.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 03:37:30 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 79E005A0020; Mon, 21 Feb 2022 14:37:29 +0300 (MSK)
Date:   Mon, 21 Feb 2022 14:37:29 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 13/32] x86/tdx: Detect TDX at early kernel
 decompression time
Message-ID: <YhN5edJQ+LkVc0us@grain>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-14-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218161718.67148-14-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/2.1.5 (2021-12-30)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 07:16:59PM +0300, Kirill A. Shutemov wrote:
...
> 
> +
> +void early_tdx_detect(void)
> +{
> +	u32 eax, sig[3];
> +
> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
> +
> +	if (memcmp(TDX_IDENT, sig, 12))
> +		return;

Maybe worth to guard ourself, like

	BUILD_BUG_ON(sizeof(sig) != (sizeof(TDX_IDENT)-1));
	if (memcmp(TDX_IDENT, sig, sizeof(sig))
		return;

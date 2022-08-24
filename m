Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D84259FEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbiHXPrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbiHXPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:46:38 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578169CCF8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:44:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p185so2388286pfb.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=2pPtfMEoZDm3WYXQlzOmfOlCxFAjiTkNGfWAjxlIOxM=;
        b=afdirNYp5krv4z3K3/WY/agF8lE75RVBe2jY5/KAOda/8S3JpR8w86X93+To0eEjOd
         uFROoqBcWZvlAhqWsieUHDqSPOhs1DXxsGy5uka/HfajELHdXLcLip5zMYoNmWYqWwPq
         /Co3mrQtrIw6Q2siFM+N0Z5Rcw9h7ftgWeQDCs8m2ow1XIekj/fbbUNMQ2VARuNlT/Dk
         VHqkRAgZiO4XWqyTKPW89JfhDYWIr8mAHJnE2pYokD//binR9WMoKcii/q57r6tULLeh
         vCuehgjSzBV2jda0Wh7L3zGJhHVjmB40G1pDF9fMO3Zh7BqqUKWzhzlc7CkbJUuLROUL
         hlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2pPtfMEoZDm3WYXQlzOmfOlCxFAjiTkNGfWAjxlIOxM=;
        b=6EUy/7zOWIhTzzF+oue9CddGjNkEPe+ol4GbhGISbkMAkxr5ViBk+Yo6GbWNzOcyx3
         /Xduaz+tgvXQhT7o6p6dg4JSj67mca77/pwINpugfXSUAiUReBfJcTv3E2jZ2vpVGH4V
         cQCbXMos89I2qmWi4buj26v9nCImlUaOCnc8qrM5mhhIXL2cXYOc57SGY9eBDB8lqh9O
         H4gZL50tmdQ/vFGYDhW2MD4S9ens4NyqrnQeK/AdmfyWSryJO5t3jh90SgYhxr5gydXM
         UfnYAThCrFj2bAuTNJfalJKCh2ApZzm+fwVbAXfYN6EyaWne6d492IQJwoi3WWVGLwLU
         4gyQ==
X-Gm-Message-State: ACgBeo1enKWxo/bRqKT2kgZYYWM62yl1erxS9L3e7KIMUmAVAO1tyxBV
        GQfve9pFs5RSEqkVA3qW0WjhLA==
X-Google-Smtp-Source: AA6agR5h33LQ7obhj8YPbwYHA1KIj00HcSnYRZqrWQiu25FM829oQKEjLdqhCqq3jfixr/uwSSjnvA==
X-Received: by 2002:a63:81c8:0:b0:429:ea8c:3afa with SMTP id t191-20020a6381c8000000b00429ea8c3afamr24502319pgd.22.1661355877881;
        Wed, 24 Aug 2022 08:44:37 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u10-20020a17090341ca00b001730f3f4ab4sm2620181ple.217.2022.08.24.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 08:44:37 -0700 (PDT)
Date:   Wed, 24 Aug 2022 15:44:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: x86: mmu: fix memoryleak in
 kvm_mmu_vendor_module_init()
Message-ID: <YwZHYZFj5Q8NzZha@google.com>
References: <20220823063237.47299-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823063237.47299-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nit for future patches, please use

  KVM: x86/mmu:

for the scope.

On Tue, Aug 23, 2022, Miaohe Lin wrote:
> When register_shrinker() fails, we forgot to release the percpu counter
> kvm_total_used_mmu_pages leading to memoryleak. Fix this issue by calling
> percpu_counter_destroy() when register_shrinker() fails.
> 
> Fixes: ab271bd4dfd5 ("x86: kvm: propagate register_shrinker return code")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

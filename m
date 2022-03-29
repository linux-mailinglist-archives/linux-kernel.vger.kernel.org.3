Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4D64EB643
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiC2XBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbiC2XBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:01:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C5C473B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:59:32 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mp6-20020a17090b190600b001c6841b8a52so314825pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mf3QS3aKf3OHFfM5f9hNYG9RXB66tqh8JCr2CM0gjzg=;
        b=hcCXx4lxQRydW8fhhYenNxDF9eCX3D5z22cl3TUAF0ArEkpyvnaFkMUrZiTD+uxW1b
         fzLKlTjb1ER8GWLeqEv/GZM0JD2pr+clNaclG5dJYK+b+OsFKiKbi/fiKXt2QtlqAe6d
         +WiGb1fe7LBdenaLFRkCNV4O+/wq9C21bQ3/7mTUj0rTRnM7IxvhIdWFPbpgwh5lqN77
         0CuyMzE32y5PIm4wt69WLLkEs74QUcnESHmZShRiegnwC+AbQ3L07AYSyWfuSxkEnn22
         VpbLYMJeFUxNPAw8sfMq9QxBI8YUuuqfgjXUebc+Trzn0+CrT7vuHi5v0ir7uW0ntOp/
         AIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mf3QS3aKf3OHFfM5f9hNYG9RXB66tqh8JCr2CM0gjzg=;
        b=mDtu0WBjg3NQsixdJrEisB+An4bN9dhSUNk8Zky69ItP3pCgqRcPT7t2goc3wtARWF
         BwEMsdbB/wzDL1BcUtr8MdsFBx9RgeMSiILd9QkKaOZsQOUwthZiAa1rfJAa0fdS6o90
         Y21pkZomCFbLqEXJrshO6v7yoe3Ic+hAlr7sZXjYd/OFVIXZHjDw0qfOdZidpoOi3OFF
         GbVtsgaqGjCqJixJkD22LuRblYudiKjyO2//Yup1jLnDbGI3zIqsqQVlNkSmVm9z6SCg
         Du0uydJQe5efIHf/S9JnaLOCbvpLh3255tTCOgNXOVnjmKIgV9nBTFApomaZq1cqSK8/
         2drQ==
X-Gm-Message-State: AOAM531p1x3lI3iD8XQ1CHvIzWSYhcDd3w0Qnq/Ncs+2aJW172MoeJAT
        sxwrRK/eUGnVwy6jYGUosc9dJg==
X-Google-Smtp-Source: ABdhPJzHMuNYqPgKGcciAnrghVvSghsdodOQmBc2A0L2W3nlDYsD7Ul8QdYdevQmBRSuUZeRU5/X+w==
X-Received: by 2002:a17:90b:2248:b0:1c9:87d5:11eb with SMTP id hk8-20020a17090b224800b001c987d511ebmr1509844pjb.114.1648594771874;
        Tue, 29 Mar 2022 15:59:31 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b004fb02a7a45bsm17321859pfc.214.2022.03.29.15.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 15:59:31 -0700 (PDT)
Date:   Tue, 29 Mar 2022 22:59:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] KVM: x86: Move kvm_ops_static_call_update() to
 x86.c
Message-ID: <YkOPT7TJf74C2Wq8@google.com>
References: <20220307115920.51099-1-likexu@tencent.com>
 <20220307115920.51099-2-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307115920.51099-2-likexu@tencent.com>
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

On Mon, Mar 07, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> The kvm_ops_static_call_update() is defined in kvm_host.h. That's
> completely unnecessary, it should have exactly one caller,
> kvm_arch_hardware_setup().  As a prep match, move
> kvm_ops_static_call_update() to x86.c, then it can reference
> the kvm_pmu_ops stuff.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

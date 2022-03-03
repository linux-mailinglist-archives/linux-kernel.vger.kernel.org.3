Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57924CC6D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiCCUNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiCCUMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:12:54 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F027159280
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:12:05 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id i1so5786764plr.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 12:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=74mI5brqou3RUxTj+v2SBWWpS/KYRzu9iwcD5bBTkwY=;
        b=tEQr+tebSKrR5fFwdqe6r21auuROLTSUTl02V6Vp0HbvnjFWZiDdcSMxBSJI3OgGQh
         CL2VlDuK4w1TfodyTflvCweg/f9y6Jifp+8nQHqbIRpjO4H2FSbH1Sq3umM2xgw53Fkc
         cxkxd4SSjOI3vIg6T4OnOBrcngzbz8uawCaErKg5SnTXwryPfeakK+Gzx2cPeM6CeGBQ
         qKVIqdLsjOrRyEQbgF6BS2DerCVhIEzIVO3gFUHGZ+j0FK1mddOtMt9tl6YxbNlbbx0k
         aztRU7/Iy9zIjelzd5tl3M+Q/CJYfP9i6oG133zLaPqUuExGuGO2cwQqgxRQsViqZ3mw
         //ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=74mI5brqou3RUxTj+v2SBWWpS/KYRzu9iwcD5bBTkwY=;
        b=OMZ7x2W2a269cq1xM3Drd84vl29ZjYA0F3HgWE49IIRdZ9y8KDA2hTJwcasL3WCvEA
         Ut03FiEJ04yAjQruGnsygVozk/qEGzC2ghjUfrj1JqMFZddM6gfFafk7yNwf+pp2h+gC
         fSrFowplDxjq2Wrorwlr0ljb98Ldh8srKCa97yNXvaY2gIzaOilkBytR0rmffHupBRzS
         g0/CDFei9+1+ZrrTOiYw5l10DQfjrtXD4R4OPWcMk5eizzRorIcxDl9jbW8wLh54dxxJ
         KJ14QZ6fsN4bL297S1bTt72PV01i+2DvzGs5HK87rd0yIKEh57TMfB0CT23HTdlaW7f4
         VAbA==
X-Gm-Message-State: AOAM530yRtnxTVBL2gw3c/QpVqihls6jJ1pKHbmxl/VkCKjwoh3JTnTg
        Yi2OjJf9Z2jENXMFazRKBIEeYA==
X-Google-Smtp-Source: ABdhPJxpoGdJZNuV5Uv9w+Fr1NUn9u1znC64pYXgJJyWBXyxaOmBT6Lu13femBMXlv3h6k4oHq3DeA==
X-Received: by 2002:a17:902:9687:b0:151:7b31:9a57 with SMTP id n7-20020a170902968700b001517b319a57mr16853363plp.146.1646338324364;
        Thu, 03 Mar 2022 12:12:04 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 15-20020a63174f000000b00368e62da013sm2736387pgx.56.2022.03.03.12.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 12:12:03 -0800 (PST)
Date:   Thu, 3 Mar 2022 20:12:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH v4 07/30] KVM: x86/mmu: do not allow readers to acquire
 references to invalid roots
Message-ID: <YiEhEJtKyRAVtlRP@google.com>
References: <20220303193842.370645-1-pbonzini@redhat.com>
 <20220303193842.370645-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303193842.370645-8-pbonzini@redhat.com>
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022, Paolo Bonzini wrote:
> Remove the "shared" argument of for_each_tdp_mmu_root_yield_safe, thus ensuring
> that readers do not ever acquire a reference to an invalid root.  After this
> patch, all readers except kvm_tdp_mmu_zap_invalidated_roots() treat
> refcount=0/valid, refcount=0/invalid and refcount=1/invalid in exactly the
> same way.  kvm_tdp_mmu_zap_invalidated_roots() is different but it also
> does not acquire a reference to the invalid root, and it cannot see
> refcount=0/invalid because it is guaranteed to run after
> kvm_tdp_mmu_invalidate_all_roots().
> 
> Opportunistically add a lockdep assertion to the yield-safe iterator.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

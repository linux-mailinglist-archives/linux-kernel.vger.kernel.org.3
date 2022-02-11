Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251124B2C02
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352284AbiBKRpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:45:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352263AbiBKRpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:45:53 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EF0CD3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:45:52 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id w1so5256604plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7OhELNAZc3TOJeSebzBa8h+NjAVlB4j32u+J9pGa0mQ=;
        b=HC6gMYy833GZt19pNMXZFEfyU9/hlmUxT5ARWqw5kY7K5sj74wJRPz710m54Y5fOtU
         QVMshG6/ggSkRojiL5VPeMDUNhPUB3fmthzii/AC0zVibIp9CcLGutf/y5uXaokkvVGn
         bAZSOIeqkr8SZ6tEibDr2kqfZHkwtv5+qUNnQ33zn3yCmWnQ8xZ/t0qAvILCELD5U41o
         BJkpCx3EpV+27F8Obx6BF7GZJveLEi7JzZPAl+mkxb408v+06w9cSx/N5TK/+KxShQhG
         UGOnWq5Q5qzeT5TafJiBCm21jZFEGlIaXYAOE1mwLWQarZSM4qf2B1t4FQzmMA4LVOPS
         dYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7OhELNAZc3TOJeSebzBa8h+NjAVlB4j32u+J9pGa0mQ=;
        b=PhUfpo6noGU62PcPwkXGSKDNB+UZVPQcZpJ7kkEmdMm3KWw2l+Oeu48GkyGEhWnPRV
         J3+Qs8tEZ23jpCSi+saq0yp2vLtAkqrp+jnhrsnuFkVUXLtElBEZfrIxx9pX3hcTJLxf
         8Gp4vuE2Q6BMefMAAY2GUD9gV1ZjNI+JRdwza/ECA5cjoTWibCdVpR3XSEf1Da90sJtQ
         ZVr3Ii6Am7jnmDPr8uSffp+2hsfGNti2FKXNQLFk2Y2MTT5CT/+Hx2csp5nVdhdJG8qU
         e5fc+TYH6lNLAvlyE9Ny8RcVcfhyLaBHWyu1FjZ6+LYRifIfM0E7cLLBldVoxN4ne0ZR
         sRug==
X-Gm-Message-State: AOAM533M7nZm3TEaC8WV4jrNGs4WoNZI+ti2BUGJiew+L15HBbb+ntXh
        TkPo2HaSMgkKqMXtYGrGsrKb/A==
X-Google-Smtp-Source: ABdhPJwqaWYUPoG9DCbKECsMGCj3kFvoVdhN0O26F+drhbIlJJ1AOIGWdKK5wgRixRvlNaj0/Biu8w==
X-Received: by 2002:a17:902:e843:: with SMTP id t3mr2518500plg.19.1644601551796;
        Fri, 11 Feb 2022 09:45:51 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s14sm28674302pfk.174.2022.02.11.09.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 09:45:51 -0800 (PST)
Date:   Fri, 11 Feb 2022 17:45:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
Subject: Re: [PATCH 10/12] KVM: MMU: load new PGD after the shadow MMU is
 initialized
Message-ID: <Ygagy355RARlppQ4@google.com>
References: <20220209170020.1775368-1-pbonzini@redhat.com>
 <20220209170020.1775368-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209170020.1775368-11-pbonzini@redhat.com>
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

On Wed, Feb 09, 2022, Paolo Bonzini wrote:
> Now that __kvm_mmu_new_pgd does not look at the MMU's root_level and
> shadow_root_level anymore, pull the PGD load after the initialization of
> the shadow MMUs.
> 
> Besides being more intuitive, this enables future simplifications
> and optimizations because it's not necessary anymore to compute the
> role outside kvm_init_mmu.  In particular, kvm_mmu_reset_context was not
> attempting to use a cached PGD to avoid having to figure out the new role.
> It will soon be able to follow what nested_{vmx,svm}_load_cr3 are doing,
> and avoid unloading all the cached roots.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

If you add a sanity check as described in the other thread[*],

Reviewed-by: Sean Christopherson <seanjc@google.com>


[*] https://lore.kernel.org/all/1e8c38eb-d66a-60e7-9432-eb70e7ec1dd4@redhat.com

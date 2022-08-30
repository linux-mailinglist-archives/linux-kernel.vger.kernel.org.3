Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD65A5AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 06:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiH3E1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 00:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiH3E1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 00:27:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7174A9E0F5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:27:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f24so7201618plr.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 21:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=tveQCNdrcl8zzZ90FYJSAQp/xoPHwNHO3f5B145IGDY=;
        b=jz5ryMUneNPtN7GgAbdob+y42sDrVxRuBlqA3QA9oeD1pieZtFXjP021CLo/r+B8bv
         MYbJ7ecSXA82j8N0LGSRSWGBEUhc3gl753fZP/eq9G6cgLilZiGUBe9U0WkOOEPuzjZF
         1K3HPtO4P5guX5tEHivGDwt+5tsoSrBpSv2YMAohOLencXK9GT5KAEjxZPzgLhtXs8hu
         gQg912iU7/NlDTQXrg/CEmP/aR5c+40JbNsB0FzAY+4nR+pg565IYviyzm5c/PrLrHLt
         42P316IO38WW173exoDa9F/uBYTC0uVc+zDhMVmIYiRyS2CFUFzmi4Iwz9ul83sq02Yi
         qJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tveQCNdrcl8zzZ90FYJSAQp/xoPHwNHO3f5B145IGDY=;
        b=P1otVBKD8HkV8ZXtVPPGLv9Uz9+fiXQGfISbqwQVJW2FVOXq+iHlmPAeBeRESfM0Bg
         k7cNrnkLAvfPiGhYj8q5V2mRhLs5yMZnp6VGV15LkiBtIdktwhRGlnJDEo1wjQ0OE9mI
         7s1nhuS8x1/zEybRE6HVtUfDlnVGUiSUyIavmXMX4wTSFsHbd944mQKf5j4BGc/bxWhf
         7e2QEZGMvPAisGMFYfIgUIe1vXYx2vn1ceL+U56v/oF99tHooYs6f6sCkj/YubDhhGq5
         y0rfvBbgUVR276VK3LITXf4WYAk4iIwvQzRhip2q4PXW3RideK9n8IDGweKkVOv8oE0X
         AdIQ==
X-Gm-Message-State: ACgBeo3xUm1xhfy4aF/HfLPZZIlic/5X6awaoV9RIPdz3QxPHmFUEh/B
        ajgJZ/+gmSu/hAyVT8d/Q8c3yg==
X-Google-Smtp-Source: AA6agR6j3CrMGk4TPMCPwBvaE51o8QHOWIUKsxAkxuonGlXOsZKabqIh/v6aYfhgn/tTEr+AwX2Jlw==
X-Received: by 2002:a17:902:efca:b0:174:c901:aa8d with SMTP id ja10-20020a170902efca00b00174c901aa8dmr7736459plb.164.1661833628777;
        Mon, 29 Aug 2022 21:27:08 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id nm21-20020a17090b19d500b001eee8998f2esm7541792pjb.17.2022.08.29.21.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 21:27:08 -0700 (PDT)
Date:   Tue, 30 Aug 2022 04:27:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Jones <andrew.jones@linux.dev>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>,
        Tom Rix <trix@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Colton Lewis <coltonlewis@google.com>,
        Peter Gonda <pgonda@google.com>
Subject: Re: [PATCH v5 7/7] KVM: selftests: Add ucall pool based
 implementation
Message-ID: <Yw2RmCujuaOczFTY@google.com>
References: <20220825232522.3997340-1-seanjc@google.com>
 <20220825232522.3997340-8-seanjc@google.com>
 <20220829163627.qbafyl4qz5cxxue5@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829163627.qbafyl4qz5cxxue5@kamzik>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022, Andrew Jones wrote:
> On Thu, Aug 25, 2022 at 11:25:22PM +0000, Sean Christopherson wrote:
> > +static struct ucall *ucall_alloc(void)
> > +{
> > +	struct ucall *uc;
> > +	int i;
> > +
> > +	GUEST_ASSERT(ucall_pool && ucall_pool->in_use);
> 
> ucall_pool->in_use will never be null.
> 
> > +
> > +	for (i = 0; i < KVM_MAX_VCPUS; ++i) {
> > +		if (!atomic_test_and_set_bit(i, ucall_pool->in_use)) {
> > +			uc = &ucall_pool->ucalls[i];
> > +			memset(uc->args, 0, sizeof(uc->args));
> > +			return uc;
> > +		}
> > +	}
> 
> nit: blank line

Got 'em.  Thanks for the reviews, much appreciated!

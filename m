Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E7B57AA74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 01:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbiGSX1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 19:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbiGSX1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:27:37 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B020552DDC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:27:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w7so13376883ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ya1aQWm95sa1HPQF3jM5eAY4ic1SiLh5SHULBA/lY58=;
        b=ZPJjhk8kIfFspDU4FV+1TVFxenO8dBQ8jBRn0tmtCasZurj60lNzh15lnAixrDXMVu
         aUJ640y4b9L9Nn3063hRoicBxywLoOsj5oRxv04ISoc+B51EU8q/7C+yAJ6yxuBCfQaQ
         4Dax+BDFxN7BVovsbY1/2lXgPyPsrCKmgu3so03fhJCrCbuDkeaC6mFOc8TFX+ztB2KK
         8o0zJnDyh+cQpL3/a4WbJDQnuRWm5dFwzSNf3ny6cpaBOhUInspNHVV2UcPar6UgfRcH
         1YNmhBAeI8QTlyfrn1GkFn3hq8R+hqlses9R4HQuy7iHzZUUDOW/RpHrRJVvyNwUQ5UJ
         csow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ya1aQWm95sa1HPQF3jM5eAY4ic1SiLh5SHULBA/lY58=;
        b=IZh6hh3i/1fmK30ocjYhJW1nE1pRmDyk3NIpl/bjgeOWmM97s83uOrkOEozZG91tIz
         Lcp0z8F+cWOzlhlRujuMiUgQBPja7Onc9UE0AkSCciNWQjkTsAe8fN0TxWs2n9s8dAuU
         jIICvI0GffuCxaYhON33WAWsOc4+l3mkBSgkWcfOA/7JMZjJ8e6OrtLV91k1WmL8jchO
         FD836K6UgHXVOBXbLFMKgSRETrnUp1eWw2XE/TyQ9hUwQuP/Z1J7t1UFVateyuEEyTN7
         GzfCJzJw6v/3fisUOJk5K5EGxYVLOpRuXZI120o8GpvqrmMsmIjhPGHT/lJbe+Hsj3N8
         zJFA==
X-Gm-Message-State: AJIora/2VSVLlpGCTMRbC3HAyFEAzJXqALMsrXYKms5kY+AqsqTsnFTA
        MCi+h/zHdquOJNKYd0x/dn2Z3g==
X-Google-Smtp-Source: AGRyM1soW4VjfF+FPjavy5upGoUE6k6uxN3PxNwlKWN5HycdX0MKtInayFUKnhAXzrQz1GOECe6iiQ==
X-Received: by 2002:a17:902:e213:b0:16c:4292:9f57 with SMTP id u19-20020a170902e21300b0016c42929f57mr35820308plb.143.1658273256094;
        Tue, 19 Jul 2022 16:27:36 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b0016befc83c6bsm12274100pls.165.2022.07.19.16.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 16:27:35 -0700 (PDT)
Date:   Tue, 19 Jul 2022 23:27:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH V3 11/12] KVM: X86/MMU: Don't use mmu->pae_root when
 shadowing PAE NPT in 64-bit host
Message-ID: <Ytc948/8kK18/d0d@google.com>
References: <20220521131700.3661-1-jiangshanlai@gmail.com>
 <20220521131700.3661-12-jiangshanlai@gmail.com>
 <Ytc9j/ayzTfm6Rti@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytc9j/ayzTfm6Rti@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022, Sean Christopherson wrote:
> On Sat, May 21, 2022, Lai Jiangshan wrote:
> Actually, I think the series is buggy.  That patch, which precedes this one, does
> 
> 	if (vcpu->arch.mmu->root_role.level != PT32E_ROOT_LEVEL)
> 		return 0;
> 
> i.e. does NOT allocate pae_root for a 64-bit host, which means that running KVM
> against the on-demand patch would result in the WARN firing and bad things happening.

Gah, I take that back, pae_root is allocated by mmu_alloc_special_roots().

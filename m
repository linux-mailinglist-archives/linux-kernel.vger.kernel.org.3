Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE555A4F5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 01:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiFXXln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 19:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXXll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 19:41:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A393489D33
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:41:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id jb13so3334541plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3xnBvzrRmX/ejhmjRn6AoNfZ6p3RCpkOG+Vy08xprps=;
        b=AS3DaGG61PYQBaU/p+BC2EOrkBhfu3MaqbJkNmutFIQKb6hE58NVV2T2HN5MPwWFKa
         cRf7njThcQFyvGXySMvrsvwCo02+qfboGW1pVKbYwZ24zTxDlM4SdkOlaaDFVJvDXPIL
         OetXbsRtBoPDnOt5HdCQ3Q5JqWpf8ZVwSOnb3+xYio8ZK4/NjtBacXonZ1fqjV8WXYXl
         WU3NZOiVBo3AsoXU3X5dmZemrU+NDtUm4b9Yn4FBO/V9W87+Q3OJ5LZc/Nwe2iFLrDsE
         ZinA615CpiS5kp60zPU5bVWNiOI19/qMTyJP5t7KTw/k98Pz4cOoPF8LyMsswOMQr1cy
         oMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3xnBvzrRmX/ejhmjRn6AoNfZ6p3RCpkOG+Vy08xprps=;
        b=lVpKbKdfBIsnJs3tvcbgLIcIRuAdB5wLmchBHi9UvhuM2VADlETjrl1wZ4JU62n9A6
         rD1jCGjVcR8Fg2EvBwGiIMkMXvt+eHfthVf2UOGxJpk0CldBt3DrAHZHrav50nph4I0U
         Q0pJ9rY4Fs7PIYPTYk0WAAwN/vZQgZkiNN5k15sCij1agvQCaabgQ+SH5vG6Qm1Pli5S
         Y3cLXrwspoZdJfJSSZYdd5sXHQ2st/awiRHfjh/zyRnhBTmtdLgdMDBEbbPC9y5wh2Yv
         3kqutMeNuaYUdCyi5hpkRmfg7x6ij/F9C9CPXyg52cTvgleEoDp7jTJul8UwlYp8SToe
         Ke2w==
X-Gm-Message-State: AJIora/8D0/LLMUqZxqrqN7eTxrlaTa1wJD8MaLwHmhjhHKF8wBYFsQP
        DPKnXdMSTK7cgaKxISFJDtUZsg==
X-Google-Smtp-Source: AGRyM1uzvJMxrnVztGfw3Vxr8c4HN/RJBw6KcIENR+surAs1biy9lt0CP8HFqlurE+rRWKy50934fQ==
X-Received: by 2002:a17:902:d712:b0:167:757c:a6f4 with SMTP id w18-20020a170902d71200b00167757ca6f4mr1476590ply.5.1656114100011;
        Fri, 24 Jun 2022 16:41:40 -0700 (PDT)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c24200b0016a6130128bsm2352299plg.211.2022.06.24.16.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:41:39 -0700 (PDT)
Date:   Fri, 24 Jun 2022 23:41:34 +0000
From:   David Matlack <dmatlack@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] KVM: x86/mmu: Add optimized helper to retrieve an
 SPTE's index
Message-ID: <YrZLriNw1CElOKbz@google.com>
References: <20220624213039.2872507-1-seanjc@google.com>
 <20220624213039.2872507-2-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624213039.2872507-2-seanjc@google.com>
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

On Fri, Jun 24, 2022 at 09:30:36PM +0000, Sean Christopherson wrote:
> Add spte_index() to dedup all the code that calculates a SPTE's index
> into its parent's page table and/or spt array.  Opportunistically tweak
> the calculation to avoid pointer arithmetic, which is subtle (subtract in
> 8-byte chunks) and less performant (requires the compiler to generate the
> subtraction).
> 
> Suggested-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Thanks for the cleanup. I did a git-grep to look for any other users to
convert to spte_index() and didn't find any.

Reviewed-by: David Matlack <dmatlack@google.com>

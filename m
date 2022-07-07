Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1825C56A869
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiGGQkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiGGQkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:40:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38012DC7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:40:12 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e16so7720730pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 09:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yD9JOmzp/dFDreTYsU04JyTwToOKdMohWmxTbaY6njU=;
        b=DKgr4DUtPFkc2YDiqeIjerue3AdI7QvRfGK/IvbHd5WNTyaO9jlMo3t7VDNIsgycBd
         t6lQ87zUS2Pl9GJwRhjoGWGceAce6eVnnyxitqo+Eu/Xz6OmKcSmrDovq2/kK3RmsXdV
         4Zfim6Y0ZksMG/veV2zgbBBog0DqiGhbWO+r9Zf1/uquXY+OPCTFiD69FwWkhS4iQPWc
         isKhI1Ls+LByweIbakofzyOp7saougvp7qWNGpDu/aFrNFfG2Q7M4lH04daUChzK80Hu
         Nb4IOaA1dNWe/SQrp94mkgbyfb8qGJO4J5uEYBdK49Z06hXbDSRWKRiMd89ea36xMfa6
         FH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yD9JOmzp/dFDreTYsU04JyTwToOKdMohWmxTbaY6njU=;
        b=URzpiNFZamLf9KDCF24mSU8p/ILVNc3injsRFvp5oRmgy7eco++0maefV5b59wwSX8
         OVQ27eBBxSu6bNG/3JSpFzymL0GxGKPNryRMLaUUikzuSXxCARHJd6H9hKiLRohLv/Xw
         Hk3GpLxNvfmxjYt6iJ//ZEKZwU99EXuB3SvH8QQTBahTJQFTyaXAU4iJzPDYByxfEzja
         V1zKpkcBgN4x6BWD8oxh73vfgvmGF8cMnQHeRsM1tY4uAoCjpD4K7US7JNwGA2JAkQhr
         Y0J18EdLS08ctdFWLRw4Y8s4DfJMavl7ETLlGx8n8ILtjxS5ILh5qi0wbccyuxB6chQF
         iE7w==
X-Gm-Message-State: AJIora+XaEZycOFds9PW6VubDvl4sNHhm7Uak+38AdIMhZicj1AzL363
        9wFW2Hmv+In980ika+BxCZGokA==
X-Google-Smtp-Source: AGRyM1uRun8/gyQJJismerB54U/dXNI8KUubj/l+07lYiNiUSieBPfgfo3nCJCkX+KWvZ5rnxkhc/Q==
X-Received: by 2002:a17:90b:4f4e:b0:1ef:ab40:b345 with SMTP id pj14-20020a17090b4f4e00b001efab40b345mr6235651pjb.226.1657212012079;
        Thu, 07 Jul 2022 09:40:12 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id oa1-20020a17090b1bc100b001ec84b0f199sm3505764pjb.1.2022.07.07.09.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:40:11 -0700 (PDT)
Date:   Thu, 7 Jul 2022 16:40:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/28] KVM: nVMX: Introduce
 KVM_CAP_HYPERV_ENLIGHTENED_VMCS2
Message-ID: <YscMZ2eU92fkDowB@google.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-7-vkuznets@redhat.com>
 <YsYAPL1UUKJB3/MJ@google.com>
 <87o7y1qm5t.fsf@redhat.com>
 <YscHNur0OsViyyDJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YscHNur0OsViyyDJ@google.com>
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

On Thu, Jul 07, 2022, Sean Christopherson wrote:
> On Thu, Jul 07, 2022, Vitaly Kuznetsov wrote:
> > luckily, Microsoft added a new PV CPUID feature bit inidicating the support
> > for the new features in eVMCSv1 so KVM can just observe whether the bit was
> > set by VMM or not and filter accordingly.
> 
> If there's a CPUID feature bit, why does KVM need to invent its own revision scheme?

Doh, just saw your other mail.

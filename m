Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0824E4CD86D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbiCDQDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiCDQDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:03:03 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0583F1B0BCC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:02:16 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so7209747pju.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 08:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iKXCjtCLyBd5SB18xoMWfCbBK72dJBo8wk/xWeD+1ow=;
        b=NPSSv1f3NiH3nTbPR/NPI7t4q8iZbNmkZSqGP9caRbEBz5GMNW0dupYVnfkr37GxHS
         uFRR9axd85c3A3GQCeoJhLNRGbuxmdhoAcMDmoyqJzz2oRZCQw6e1paiySPVS6maVjPJ
         z56hr2HqCwbGSKMjr8VVTO57uRlOcFK9ZcpG95v5Tnja6WV6VrdtZVr170asTMeevLmD
         dDtqEFxoENq2TJp1f5ug93p6pcYTrMrhkjT800eDh4d93ZQ9VZh3mQIF6gNoy8KEEmTN
         BZfTAleX/3o18B5/t/PuP1d2ULiF0mSXHp2xD9T37gcWn6coO+NCArTWDz15iq/fuwLO
         CqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKXCjtCLyBd5SB18xoMWfCbBK72dJBo8wk/xWeD+1ow=;
        b=aG+U2YqMQ2+wRw4snjYEs1SSw8g59GFcfo3+un+annk//53jUXOUR43qwcDdhwmylw
         utQwrlVnqyqCptqr/JciDpWNCj5erAwwpShgwuBswEIHkL+dJmKL276ghdplGxu4ahnt
         +DIYpLjRYXBqQsDRa5AJF/sbYBD5MS5l0gGTgvAvLJVW/xtbhgcBgAojZ/OjZnekcVTe
         CoPnfNkHX9p6JNXoIQC2lZiXRYxpC066VU6NVlAwh6rZH8GvfFsVw9yAB9/PKUb6deyv
         lYUPqvbjbSsTDqNlItoOxho56fuVAbt8WrkvpbSlwnMXEL2wUnFI76n1DP2FzQEV9LPJ
         Ku2g==
X-Gm-Message-State: AOAM531Z+QYpDb5Qtl/9FJsieCDS+M0NZalwYM2EdJewpEBDPGjnoyhA
        SUQsfEF8MH7bj+I1ENqdsS8Uug==
X-Google-Smtp-Source: ABdhPJzeXnsVXGYYR1+7nVhiTHXCnWwr/9Bmg9y2srKh/JAflfqdxZMKubdlTRKrOS03r16N1ZvbBw==
X-Received: by 2002:a17:902:6841:b0:150:9b8c:3a67 with SMTP id f1-20020a170902684100b001509b8c3a67mr36997799pln.151.1646409735126;
        Fri, 04 Mar 2022 08:02:15 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 66-20020a620445000000b004f6c30d84cfsm1641711pfe.155.2022.03.04.08.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 08:02:14 -0800 (PST)
Date:   Fri, 4 Mar 2022 16:02:10 +0000
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
Subject: Re: [PATCH v4 21/30] KVM: x86/mmu: Zap invalidated roots via
 asynchronous worker
Message-ID: <YiI4AmYkm2oiuiio@google.com>
References: <20220303193842.370645-1-pbonzini@redhat.com>
 <20220303193842.370645-22-pbonzini@redhat.com>
 <YiExLB3O2byI4Xdu@google.com>
 <YiEz3D18wEn8lcEq@google.com>
 <eeac12f0-0a18-8c63-1987-494a2032fa9d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeac12f0-0a18-8c63-1987-494a2032fa9d@redhat.com>
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022, Paolo Bonzini wrote:
> On 3/3/22 22:32, Sean Christopherson wrote:
> I didn't remove the paragraph from the commit message, but I think it's
> unnecessary now.  The workqueue is flushed in kvm_mmu_zap_all_fast() and
> kvm_mmu_uninit_tdp_mmu(), unlike the buggy patch, so it doesn't need to take
> a reference to the VM.
> 
> I think I don't even need to check kvm->users_count in the defunct root
> case, as long as kvm_mmu_uninit_tdp_mmu() flushes and destroys the workqueue
> before it checks that the lists are empty.

Yes, that should work.  IIRC, the WARN_ONs will tell us/you quite quickly if
we're wrong :-)  mmu_notifier_unregister() will call the "slow" kvm_mmu_zap_all()
and thus ensure all non-root pages zapped, but "leaking" a worker will trigger
the WARN_ON that there are no roots on the list.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFF15AF3D4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIFSiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIFSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:38:40 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A53C9C2E8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 11:38:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f124so3113287pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 11:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=E9k+DekvPqCyEfJ57hGn14U8clOdojaXZR0lBsYnNU0=;
        b=Lpv2gTp5kKu4vwEqcCL+7Nqun/lu8ZiOgR9j9vkfzdFHbyVXEusirVzrEO2CUbKPT/
         HiuYO//edu2A/HUYCamKWzhiP26F1BvTYcEblbQEu63etjTQU31UR9k6dBg11GomS//t
         LzH6iscCegYGvSC3zEOd8NheodkxIiswcQ+0Vc/BYoY/rdVMN5/00xwo3flRccpNkpXw
         mYduULHGs/ezoAzKpbnif9msdH8wh/uEfxCm7lzIPNe0sz0RT9RG/42RG8u3b6Cv1nYr
         ppnl5WPZYS0Vmi3XleHNdAPVu5W099SjYsqFtPeC84pISwSd3NbKYgX4P+D5bH8Dk07q
         /QCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=E9k+DekvPqCyEfJ57hGn14U8clOdojaXZR0lBsYnNU0=;
        b=yNRWhqTlUCzXbSkmm0nxzXZwSEMSVWSizrhSj2YMap0WAyT89DQHme6CBFbH9OfBXp
         94L8luBaOEp/xaqfOmkg+KvI8VyCx7dhtVBiffHzQvDChbY3e0ef1wn8p6Uo+AmsgM11
         pEC/61LkMJiA9eCLYQfitR/Fd6rU+iNEFFc9dmgrur23ygQQDJA2/OO1KfwBHJRcozyN
         uwVF7TBxi/rfqIaefFcXlTFMhwZBSdGvFVkOFR+2ecU8QyAujZ9PISj/+L77Zpf9Jy1d
         X15NQpTTwu8P6pJUmAygof5DmJRr9dEXCSHaMsT7RhojQS5k0z5x7nAiWpwrFTJJIvmN
         wwlg==
X-Gm-Message-State: ACgBeo2sfifPbSRCJ1+aOqR5M+mFqsKHOn2m0M5evvvlvuiVE0zHuCx5
        foHL8+nC97BMUZdezWwMmQFS6Q==
X-Google-Smtp-Source: AA6agR40YbfMEzMYnzY4KerAXYJ6bZuDiNNQIEJK+/hZv/vcdvPZ0QNOZCDHWasDm6Xi/b0MbVoFkQ==
X-Received: by 2002:a62:e91a:0:b0:537:e307:fab0 with SMTP id j26-20020a62e91a000000b00537e307fab0mr52273151pfh.37.1662489515927;
        Tue, 06 Sep 2022 11:38:35 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a6-20020a1709027e4600b00176da1aae5asm1539847pln.70.2022.09.06.11.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 11:38:35 -0700 (PDT)
Date:   Tue, 6 Sep 2022 18:38:32 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v4 0/9] KVM: x86: Apply NX mitigation more precisely
Message-ID: <YxeTqPJjgIANWc3A@google.com>
References: <20220830235537.4004585-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830235537.4004585-1-seanjc@google.com>
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

On Tue, Aug 30, 2022, Sean Christopherson wrote:
> Note, this applies on Yosry's stats series (there's a trivial-but-subtle
> conflict in the TDP MMU shadow page accounting).
> https://lore.kernel.org/all/20220823004639.2387269-1-yosryahmed@google.com
> 
> Precisely track (via kvm_mmu_page) if a non-huge page is being forced
> and use that info to avoid unnecessarily forcing smaller page sizes in
> disallowed_hugepage_adjust().
> 
> KVM incorrectly assumes that the NX huge page mitigation is the only
> scenario where KVM will create a non-leaf page instead of a huge page.
> As a result, if the original source of huge page incompatibility goes
> away, the NX mitigation is enabled, and KVM encounters an present shadow
> page when attempting to install a huge page, KVM will force a smaller page
> regardless of whether or not a smaller page is actually necessary to
> satisfy the NX huge page mitigation.
> 
> Unnecessarily forcing small pages can result in degraded guest performance,
> especially on larger VMs.  The bug was originally discovered when testing
> dirty log performance, as KVM would leave small pages lying around when
> zapping collapsible SPTEs.  That case was indadvertantly fixed by commit
> 5ba7c4c6d1c7 ("KVM: x86/MMU: Zap non-leaf SPTEs when disabling dirty
> logging"), but other scenarios are still affected, e.g. KVM will not
> rebuild a huge page if the mmu_notifier zaps a range of PTEs because the
> primary MMU is creating a huge page.
> 
> v4:
>  - Collect reviews. [Mingwei]
>  - Add comment to document possible_nx_huge_pages. [Mingwei]
>  - Drop extra memory barriers. [Paolo]
>  - Document ordering providing by TDP SPTE helpers. [Paolo]

Hi Paolo and folks,

Just a gentle ping. Are we good on this version? It seems the ordering
concern in TDP MMU has been addressed.

Thanks.
-Mingwei

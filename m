Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3335B0739
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIGOlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIGOl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:41:27 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D663A92F59
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 07:41:26 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q63so13772755pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=O/aOMtkhlEcrOJc7BLnoRciKLeD8Mw+oP9OkzByv0EU=;
        b=OkmMlnWJtuAD6HEt3dXwrjmSJkE0DnYnwr/g9qb0bGOJX+sSfF74urXHQFUUVe/PO5
         brZeUtN3JzqYLnordkYFikLwREPMdogShkxz4607dpIHbQVNh0muSV8zravPP8DqS0Hx
         WragHDbB6vx6WM16Gw+39LK5RKq/5qrSCJXM84l5r4VWLGOk0STNIQuogWY/cLv61G74
         yYDd/ao9IeaC1J57GTkUBq4U/Tp1TqkOdBFUYaRpkpmLq+CQpPh/YkND/iEE2/xixqtI
         d7BbHbsJTts1qu0o3yvQ/iIOklXhZbKBU/VcNksud4wH1Mu/yGyN2vNqXoEiuehggMEp
         uQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=O/aOMtkhlEcrOJc7BLnoRciKLeD8Mw+oP9OkzByv0EU=;
        b=Fd8K+cLBjJKM+9AFCOOprLWkPAeAtJv8E/fbsjepcJ5aCkOvVHPqV3kBld5X6n/nE4
         bc273txdn/Bd2YbzMkGGd11TZq2tA8yBrtCi9OG/tgo51Nzf5XXN/lZYdtgvuw9VhIeR
         qU2z/8JkVsYBeFP9SXii4aHNflaKzo1y/SjwNnO1wam3BWn4ESHA33Jte1pagA/YLf4f
         WSkXM2NFp/ecp/fOlKc8a4wXJlPvzB//KMI3E/2nKtiGXi0krbTppu7l6vByaj9bHLJ1
         K1ltYGqeYZyoeEEsQAOdRk02KSmacyhAT4h9hkArHBsjzxtWPsTEfZ9di9QLoCcyyjcr
         Qzuw==
X-Gm-Message-State: ACgBeo1O8haFhhE06lVcXvzp3MfOId+u5IyP0wt7boIUvJ0upTmg34KV
        xjEtmw8zp8yiNwDmvjJJ5mxx3g==
X-Google-Smtp-Source: AA6agR5tWYzs+BcMBLLe6he5QXEIegT4UMxHDZ+KE1aBut/fBy//1967eHmzGTpC7F0dHrhsDCtQMg==
X-Received: by 2002:a05:6a00:814:b0:538:1d7b:1322 with SMTP id m20-20020a056a00081400b005381d7b1322mr4162730pfk.66.1662561686216;
        Wed, 07 Sep 2022 07:41:26 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u66-20020a626045000000b0053812f35a41sm4267748pfb.194.2022.09.07.07.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:41:25 -0700 (PDT)
Date:   Wed, 7 Sep 2022 14:41:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: arch/x86/kvm/mmu/paging_tmpl.h:106:24: sparse: sparse: cast
 truncates bits from constant value (ffffffffff000 becomes fffff000)
Message-ID: <Yxitkre4VEwMAMwj@google.com>
References: <202209051509.RDisCzFu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209051509.RDisCzFu-lkp@intel.com>
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

On Mon, Sep 05, 2022, kernel test robot wrote:
> Hi Sean,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7e18e42e4b280c85b76967a9106a13ca61c16179
> commit: 70e41c31bc7776b262cd9f524df3dfc2b5869a0a KVM: x86/mmu: Use common logic for computing the 32/64-bit base PA mask
> date:   3 months ago
> config: i386-randconfig-s001-20220905 (https://download.01.org/0day-ci/archive/20220905/202209051509.RDisCzFu-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.4-39-gce1a6720-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=70e41c31bc7776b262cd9f524df3dfc2b5869a0a
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 70e41c31bc7776b262cd9f524df3dfc2b5869a0a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kvm/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> sparse warnings: (new ones prefixed by >>)
>    arch/x86/kvm/mmu/mmu.c:2550:9: sparse: sparse: context imbalance in 'mmu_try_to_unsync_pages' - different lock contexts for basic block
>    arch/x86/kvm/mmu/mmu.c: note: in included file:
> >> arch/x86/kvm/mmu/paging_tmpl.h:106:24: sparse: sparse: cast truncates bits from constant value (ffffffffff000 becomes fffff000)
>    arch/x86/kvm/mmu/paging_tmpl.h:426:24: sparse: sparse: cast truncates bits from constant value (ffffffffff000 becomes fffff000)
>    arch/x86/kvm/mmu/mmu.c:4618:57: sparse: sparse: cast truncates bits from constant value (ffffff33 becomes 33)
>    arch/x86/kvm/mmu/mmu.c:4620:56: sparse: sparse: cast truncates bits from constant value (ffffff0f becomes f)
>    arch/x86/kvm/mmu/mmu.c:4622:57: sparse: sparse: cast truncates bits from constant value (ffffff55 becomes 55)
> 
> vim +106 arch/x86/kvm/mmu/paging_tmpl.h
> 
> b3fcdb04a98035 arch/x86/kvm/mmu/paging_tmpl.h Sean Christopherson 2022-06-14  103  
> e04da980c35d75 arch/x86/kvm/paging_tmpl.h     Joerg Roedel        2009-07-27  104  static gfn_t gpte_to_gfn_lvl(pt_element_t gpte, int lvl)
> 5fb07ddb183eb4 drivers/kvm/paging_tmpl.h      Avi Kivity          2007-11-21  105  {
> e04da980c35d75 arch/x86/kvm/paging_tmpl.h     Joerg Roedel        2009-07-27 @106  	return (gpte & PT_LVL_ADDR_MASK(lvl)) >> PAGE_SHIFT;

This truncation is expected and intentional in this case (guest is using 32-bit PTEs).

> 5fb07ddb183eb4 drivers/kvm/paging_tmpl.h      Avi Kivity          2007-11-21  107  }
> 5fb07ddb183eb4 drivers/kvm/paging_tmpl.h      Avi Kivity          2007-11-21  108  
> 
> :::::: The code at line 106 was first introduced by commit
> :::::: e04da980c35d75fa050ba4009ad99025432d8d7d KVM: MMU: make page walker aware of mapping levels
> 
> :::::: TO: Joerg Roedel <joerg.roedel@amd.com>
> :::::: CC: Avi Kivity <avi@redhat.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

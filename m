Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE145B22C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiIHPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiIHPrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:47:10 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EE3F9FA2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:47:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 9so15080384plj.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1DW9ekK7ZfIRVmBX3XkaRqMimxAEoQNBzvR51+1a3FQ=;
        b=nn0ODGGAWW5nPDKY7tJYp7RjSK5EDaHJjuf2+RNvW4a16Pk0bmwb1CaWodfhtP9bK3
         vk0Ech87OWvpZ5c9u35GKXzUsr9UWt9YsSlNoP7ikH0D87JMTbTCsa4f8OCIl1Y7vsTT
         4IFmieQ1bWWANg7jDDHm8UpXfN9PDecMT2c7b3ffc4hz9xdl1wSOxwiWwMAEYBMkqzK5
         kcNR+gaEfZPXov7sodRy9iIhkKcDWQqO6fzvAgniW4IAtkChws7L2uvnqO3OFEMyNhR9
         fmT8i46SOniTShnKvDLTJN1DfGi0mWA/VeRK2UAg2YbyJsZG6fpcPP5r6MPi/TCLVHLm
         Ah9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1DW9ekK7ZfIRVmBX3XkaRqMimxAEoQNBzvR51+1a3FQ=;
        b=Ih+5NirStWfkxMD2yUxlwKK2LFf4B3CHsTr90az9bO61jqg5EQxdqaRXDwaXPmHc4g
         fUqWNLmcBked6RUHoGy/jaC2vc9Ss/Q37SIZyRLTk05boc5tjXX07j5eVd7TLOvNzQqj
         VO7z8c4R7ASY6QT/dV/nJHPmC25zLLHaY264NLRgDti6jl5FlezcXjKCLVkc5KWjXPIl
         iPMOoQgYRLKcWmPmq8b0/BksqD0pQ6wnRjjnNQIB94xChqOAWTaEO9W6qatz6PJFBnZc
         pr0h5ZPm18jyEJp6kRoYQGr6cVikJ+BJ09zafeMj4VhcdRG4GGVo/zLaDtg2Nf8xgpBV
         nL9w==
X-Gm-Message-State: ACgBeo2wp1lc7fSR0wG/7q9DkfT6dGRoXwocroJz0qNe2tJkMvy0JHVu
        Hb5d8AZ2hMk+2gM9Bo4izjKD6g==
X-Google-Smtp-Source: AA6agR5KEkAr3jSfrOhdR/TmiilUO3HfMGMD4NoQAhMxEXOZYTpbPj4Tad/bT/bqwm3FdE/zWuQ8dw==
X-Received: by 2002:a17:90a:588c:b0:1fd:a1bc:ff71 with SMTP id j12-20020a17090a588c00b001fda1bcff71mr4738335pji.134.1662652028483;
        Thu, 08 Sep 2022 08:47:08 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e1-20020aa798c1000000b0053eec4bb1b1sm2334707pfm.64.2022.09.08.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:47:08 -0700 (PDT)
Date:   Thu, 8 Sep 2022 15:47:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] KVM/VMX: Do not declare vmread_error asmlinkage
Message-ID: <YxoOeGzI9sht/Afy@google.com>
References: <20220817144045.3206-1-ubizjak@gmail.com>
 <Yv0QFZUdePurfjKh@google.com>
 <CAFULd4bVQ73Cur85Oj=oXHiMRvfrxkAVy=V4TfHcbtNWbqOQzw@mail.gmail.com>
 <YxDRquTx2piSX66J@google.com>
 <CY5PR11MB636505ECC6D27486065E5CE0DC7E9@CY5PR11MB6365.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR11MB636505ECC6D27486065E5CE0DC7E9@CY5PR11MB6365.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022, Wang, Wei W wrote:
> On Thursday, September 1, 2022 11:37 PM, Sean Christopherson wrote:
> > > > And vmread_error() isn't the only case where asmlinkage appears to be a
> > burden, e.g.
> > > > schedule_tail_wrapper() => schedule_tail() seems to exist purely to
> > > > deal with the side affect of asmlinkage generating -regparm=0 on 32-bit
> > kernels.
> > >
> > > schedule_tail is external to the x86 arch directory, and for some
> > > reason marked asmlinkage. So, the call from asm must follow asmlinkage
> > > ABI.
> > 
> > Ahhh, it's a common helper that's called from assembly on other architectures.
> > That makes sense.
> 
> I still doubt the necessity. The compilation is architecture specific, and we don't
> build one architecture-agnostic kernel binary to run on different architectures,
> right?

Right, it's not strictly necessary, e.g. wrapping schedule_tail()'s asmlinkage in
"#ifndef CONFIG_X86" would allow for the removal of schedule_tail_wrapper().  But
that's arguably worse than forcing i386 to use a wrapper given that the few extra
instructions are unlikely to add meaningful overhead, and since i386 is a rather
uncommon configuration these days.

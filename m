Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34CF5136F9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348442AbiD1Oga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiD1Og2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:36:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D94AAE3E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:33:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i24so4399831pfa.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BuOTqKc9sqFd+ASkPxmorv168u2FksHgKMK0GFD3aGQ=;
        b=YqaNvZ7/aCJqDhRJhCBs70cMsPakYNrz1UntfpjxnLvPHbRr7iZCG1JEZGZjblmTt/
         km3XqonzOCSEJtxdQOCu0rV4miGWEhjUiJ/O9Z6aj2vKVtJ9ZKraHTeB/qMhAbYjfmoD
         CFgsTwQmuagVPmuBYE3XzMIQeyewGsY2yQhPGrMlKqi6qop6vR/43BAcxE5XeGgMoWBd
         mEiQenGsvxDZhKFY6HrMxnk1aA7PCRmS7SJhgA/M4wdf2FQWP/dKlppc8QJzr4jXCKLb
         CdqnD9hBL7Fcz086P5vbK4BgQCBGT2SFvA/Uq6SquJvGxC3G6rPJRoEurG4llhu+gM01
         ECAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BuOTqKc9sqFd+ASkPxmorv168u2FksHgKMK0GFD3aGQ=;
        b=oxorC6/PJJVAvSWjK5yKU89d361mlKUF8KB9j7n6ax2xx4qYJ2Yhc8qB+askGBgzcZ
         8NbOHChFlokOcfhvHPL7C/Qjt8ipu/ZGOYn/8Za0kurSI8gkGsWFM7JSiK1tDrFT4f/5
         HxiURYDKWx7KLL/6TFZJQA9SmyU/axk1njjmBFHdV5uCx2OiuqcaWRov3wYyTkPWhzrU
         ylgYL8VWfVTtxrS8KV581HBvaPN4OMV/LCkJvIx2KC7Z8h+L1vmYB0qJFrsFc1oRHChk
         JfDU8JBp4NUYq2p6fbdXtoHoDJbMUeck3XwHbtg/alsE/wmsjKJPLxe5WOa5ybyqxoCY
         mr2w==
X-Gm-Message-State: AOAM5303IbLDnyemo//ijguHth0w6HoTbyGtEl2xNEr6MLBem8sEm/xX
        7QMARvjdb6KeBQyGaL4ixgkXRQ==
X-Google-Smtp-Source: ABdhPJxq6bzKApArCJ8hwnuvcE1d1i8whx/RLcvuw8uep9J2dflc6Bb/JzAD2oItd84sVyAC4KTLWw==
X-Received: by 2002:a63:5b0c:0:b0:3ab:358a:3b16 with SMTP id p12-20020a635b0c000000b003ab358a3b16mr17745860pgb.306.1651156393674;
        Thu, 28 Apr 2022 07:33:13 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y26-20020a056a00181a00b004fe3a6f02cesm93936pfa.85.2022.04.28.07.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:33:13 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:33:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Mingwei Zhang <mizhang@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 6/8] KVM: Fix multiple races in gfn=>pfn cache refresh
Message-ID: <YmqlpgE5iCBTdbnk@google.com>
References: <20220427014004.1992589-1-seanjc@google.com>
 <20220427014004.1992589-7-seanjc@google.com>
 <CAJhGHyB4RwNekpKNQu_KsGTZCyz2EoZMt0V9+PF=p43EksD_6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyB4RwNekpKNQu_KsGTZCyz2EoZMt0V9+PF=p43EksD_6Q@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022, Lai Jiangshan wrote:
> On Wed, Apr 27, 2022 at 7:16 PM Sean Christopherson <seanjc@google.com> wrote:
> 
> > @@ -159,10 +249,23 @@ int kvm_gfn_to_pfn_cache_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
> >
> 
> The following code of refresh_in_progress is somewhat like mutex.
> 
> + mutex_lock(&gpc->refresh_in_progress); // before write_lock_irq(&gpc->lock);
> 
> Is it fit for the intention?

Yeah, I mutex should work.  Not sure why I shied away from a mutex...

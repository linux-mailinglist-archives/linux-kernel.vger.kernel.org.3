Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B77B4D1CB6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245315AbiCHQFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245280AbiCHQFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:05:37 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BE648E56
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:04:40 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id e15so16117696pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6IjtX8KQzXo9XiXFL0STmflDppjUzaJS4b0YZTK1fA8=;
        b=aLz2eKAcl+5/LVmy2/3j8bQJhp24Zv38cpqA+YG4Hpj6XfiVsqV+maSMMF+58kp37Q
         7BtzqUL64mIeK8dVRfsdGjcN1ftgXGzRUM/T4xN9N0ABDcFxYvSFVVT5S2RvDanWQsi4
         Kr2Ra8U8G9qyudOxJlZhynvQC8as9hOWBCYdImIKsx47RyFco4Pc7QMcxf7lUwNgYeCX
         XQPYp3cbF3zCbjUyVKUTarEaqskhN/zf6l++JWHqlkiXQi9iDPkQ7E8y5gWSeLX9iUKh
         1hfb9PTheYZ/wfTS4N4XpjqOUsbD78yQwyVBjA2DFSjxCWwCqxUWNQuebA218O5EoiSA
         +vPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6IjtX8KQzXo9XiXFL0STmflDppjUzaJS4b0YZTK1fA8=;
        b=y7T+HVmd14Cea/iPWso1/4txd0NB4+TbZpcCjkgSigY30gQG2/Y3PfITdxkZpPGgt/
         w9gh7xuvBPz8YOZApCM+QTXzoCq1x1Ztzz3Zt9c2uyfPKd7mg9k31tJ4dJAq83CAhj+d
         95qcY249cP6soU+jzJuSCcLnHQU+mBHRpVDn37eLWHR7h7IJCy2fN0ZUdjf6XaZz59qf
         Zlebk7nLPne7+Q9YigTlzMfAxYRA2iUl0LAR1uKnKbj9Sg8xad0RUtvryXARu+mekozM
         4U50dHnJJwcYdnyzqy5Y1Wv00c2yIEYlWJLs7kwODBsRZkrAB9bqxqdh+9m7GTUFWEE+
         sJQQ==
X-Gm-Message-State: AOAM530H9Cm81jHiRc05TiaJEq6MlhKAPvZrcuECPcTSxWLe9OxynKs7
        265e5uW5sFmJt3YuKz8xDbkQAw==
X-Google-Smtp-Source: ABdhPJzpzhqNW7g2gl8JP8xuodqL+mDOBGd5aeAVDP2IKP53nvr5g2HACaKL3nAlzIjMhHqHwQvq7g==
X-Received: by 2002:a62:ee08:0:b0:4f6:b522:ca with SMTP id e8-20020a62ee08000000b004f6b52200camr18994300pfi.48.1646755479988;
        Tue, 08 Mar 2022 08:04:39 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o66-20020a17090a0a4800b001bf388fc96esm3357804pjo.21.2022.03.08.08.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:04:39 -0800 (PST)
Date:   Tue, 8 Mar 2022 16:04:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Hao Peng <flyingpenghao@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: x86: Improve virtual machine startup performance
Message-ID: <Yid+ky+1sPJpyelQ@google.com>
References: <20220301063756.16817-1-flyingpeng@tencent.com>
 <Yh5d7XBD9D4FhEe3@google.com>
 <CAPm50a+p2pSjExDwPmGpZ_aTuxs=x6RZ4-AAD19RDQx2o-=NCw@mail.gmail.com>
 <YiAZ3wTICeLTVnJz@google.com>
 <CAPm50aLJ51mm9JVpTMQCkNENX_9-Do5UeH5zxu-5byOcOFsJBg@mail.gmail.com>
 <Yia5hsoq2ZZJM8gx@google.com>
 <5cb1e32e-c880-fa48-aa25-7660d8ad0cdd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cb1e32e-c880-fa48-aa25-7660d8ad0cdd@redhat.com>
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

On Tue, Mar 08, 2022, Paolo Bonzini wrote:
> On 3/8/22 03:03, Sean Christopherson wrote:
> > On Thu, Mar 03, 2022, Hao Peng wrote:
> > > On Thu, Mar 3, 2022 at 9:29 AM Sean Christopherson <seanjc@google.com> wrote:
> > > > 
> > > > On Wed, Mar 02, 2022, Hao Peng wrote:
> > > > > Thanks for pointing this out. However, other than shadow_root_level,
> > > > > other fields of context will not
> > > > > change during the entire operation, such as
> > > > > page_fault/sync_page/direct_map and so on under
> > > > > the condition of tdp_mmu.
> > > > > Is this patch still viable after careful confirmation of the fields
> > > > > that won't be modified?
> > > > 
> > > > No, passing around the "init" flag is a hack.
> > > > 
> > > > But, we can achieve what you want simply by initializing the constant data once
> > > > per vCPU.  There's a _lot_ of state that is constant for a given MMU now that KVM
> > > > uses separate MMUs for L1 vs. L2 when TDP is enabled.  I should get patches posted
> > > > tomorrow, just need to test (famous last words).
> > 
> > Famous last words indeed.  Long story short, the patches were mostly easy, but I
> > wandered deep into a rabbit hole when trying to make ->inject_page_fault() constant
> > per MMU.  I'll get something posted this week, though exactly what that something is
> > remains to be seen :-)
> 
> This is exactly what I have posted a few weeks ago:
> 
> https://patchew.org/linux/20220221162243.683208-1-pbonzini@redhat.com/

Heh, guess who's woefully behind on reviews...  I'll respond to those threads.
Thanks for the heads up!

> See in particular
> 
>   KVM: nVMX/nSVM: do not monkey-patch inject_page_fault callback
>   KVM: x86/mmu: initialize constant-value fields just once

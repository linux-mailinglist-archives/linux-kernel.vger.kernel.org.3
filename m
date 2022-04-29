Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FBD514CF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377373AbiD2OeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377389AbiD2Odz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:33:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DD3F7A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:30:36 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id j8so7278560pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OnYazrMvgjAnK39Hwy/HWHAyF1qxYkIiwXZn1EY9XSk=;
        b=UMUIQSPWcLSx8MA2om6Gv5iUt7MrgelgAhKlFugl76vVYAQGPwqRKwwHcfQ+b5VK73
         HiN0r1ku46T2ATBuu0T8FBelYeZbpLetOcbZl/WeU2tOeEgbHe45Y0Zs/Lhgni8cqSzY
         iHhY4v8CMUD9lTZ+zxhMlBDZowBCbw+6kbimf1H98jOyhE8jmBz/3SC0UQONAnjZqkWZ
         IrRjBjnktRSJO2hc3rcC159T7nLvNfTmz8JWq4t79pvRFFlf9DQtYW0TsFu5LKYScifI
         05fGmZYs3Y+i2TS1skz/WaOR6iLZOgUVzWkvm9XN/YZ8SP2m2ZLltJu8oJyIu+bGkxyx
         TrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OnYazrMvgjAnK39Hwy/HWHAyF1qxYkIiwXZn1EY9XSk=;
        b=3JQgdyeQpiWU5kZzN1ebTbqdce1tNpIwUCuc+FYTxE+VeMP4zXyo6qt/Q1J4Wr8S28
         Qfpt5fYteQx0U5Ry2bBq1ZDr2qxSI0EOFHGKd5Cj8qxifnPl9U9uNEV9fvNJHsHdpdAi
         tH6LoqicZ8r38kHjAtVsn3CE0LNf+2tmO7fbZl1I69Cw/uRZMX3iMkG73MQyrqccGJKu
         oY7UwFj+8LUJ2mTvhoNU6KvcwywbaPVwayXFN1SzwZVuCJBtdYILN4UM4MDvW4gvPpdT
         FN+qy6E9OFW7t0ePv74jnlXk3jRNkTYZWbM48Zwb+PKroL7ZPnzMHOJEKiOKA4LTIfv4
         Cqqw==
X-Gm-Message-State: AOAM532+dMRgS8vgksKI6mbkGfVcTGs2o0EJ6oVrUAd70MQRbRJ5h6Tk
        B5S880qSVb4NiCq6AAsFn+L3qg==
X-Google-Smtp-Source: ABdhPJxx/6q4M5pQVLbiOxgKSk5/1UctrLuzMw5GpFLW1mpeAjQfc3C8juCbrpDJZpT7k1eEH3K+kA==
X-Received: by 2002:a17:90a:d082:b0:1ca:be58:c692 with SMTP id k2-20020a17090ad08200b001cabe58c692mr4274403pju.238.1651242635899;
        Fri, 29 Apr 2022 07:30:35 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z21-20020a631915000000b003c14af5062dsm5628933pgl.69.2022.04.29.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 07:30:35 -0700 (PDT)
Date:   Fri, 29 Apr 2022 14:30:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, pbonzini@redhat.com, len.brown@intel.com,
        tony.luck@intel.com, rafael.j.wysocki@intel.com,
        reinette.chatre@intel.com, dan.j.williams@intel.com,
        peterz@infradead.org, ak@linux.intel.com,
        kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        isaku.yamahata@intel.com
Subject: Re: [PATCH v3 13/21] x86/virt/tdx: Allocate and set up PAMTs for
 TDMRs
Message-ID: <Ymv2h1GYCMQ9ZQvJ@google.com>
References: <cover.1649219184.git.kai.huang@intel.com>
 <ffc2eefdd212a31278978e8bfccd571355db69b0.1649219184.git.kai.huang@intel.com>
 <c9b17e50-e665-3fc6-be8c-5bb16afa784e@intel.com>
 <3664ab2a8e0b0fcbb4b048b5c3aa5a6e85f9618a.camel@intel.com>
 <5984b61f-6a4a-c12a-944d-f4a78bdefc3d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5984b61f-6a4a-c12a-944d-f4a78bdefc3d@intel.com>
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

On Fri, Apr 29, 2022, Dave Hansen wrote:
> On 4/29/22 00:46, Kai Huang wrote:
> > On Thu, 2022-04-28 at 10:12 -0700, Dave Hansen wrote:
> >> This is also a good place to note the downsides of using
> >> alloc_contig_pages().
> > 
> > For instance:
> > 
> > 	The allocation may fail when memory usage is under pressure.
> 
> It's not really memory pressure, though.  The larger the allocation, the
> more likely it is to fail.  The more likely it is that the kernel can't
> free the memory or that if you need 1GB of contiguous memory that
> 999.996MB gets freed, but there is one stubborn page left.
> 
> alloc_contig_pages() can and will fail.  The only mitigation which is
> guaranteed to avoid this is doing the allocation at boot.  But, you're
> not doing that to avoid wasting memory on every TDX system that doesn't
> use TDX.
> 
> A *good* way (although not foolproof) is to launch a TDX VM early in
> boot before memory gets fragmented or consumed.  You might even want to
> recommend this in the documentation.

What about providing a kernel param to tell the kernel to do the allocation during
boot?  Or maybe a sysfs knob to reserve/free the memory, a la nr_overcommit_hugepages?

I suspect that most/all deployments that actually want to use TDX would much prefer
to eat the overhead if TDX VMs are never scheduled on the host, as opposed to having
to deal with a host in a TDX pool not actually being able to run TDX VMs.

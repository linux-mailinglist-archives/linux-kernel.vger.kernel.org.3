Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECCD509856
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbiDUHAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385541AbiDUHAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:00:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F55715A32;
        Wed, 20 Apr 2022 23:57:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id j17so4140112pfi.9;
        Wed, 20 Apr 2022 23:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o/ozdBc2EnetQZby0Dq0arg/wM1fGuqmYXDc/fS+iKE=;
        b=kV3mEYMRZCjIuz1tsNE+1ob8/s/kL83lxOJG9DUy5xJj7JL8SVYhJlojfHvx7cFwgO
         Oecl0Og28SvzCiEO5O3tg+l140mcjhtOvaFlX5ejJAfASMTfOiZmkohDsST14SSqKTEy
         gI2GGj/oWKSKr5npPdFAZBnYpUTo9GLjj0PdDECjOCpVV68FfWTZu5C1oIR0hMWest8g
         3dN6/AVkelgrY5keUOwkUfsipojB7+oqi0p/5Jm9DQpIIqaK5qhBIRhCHVv6ivg3N8Ir
         L3sZC8phJt62v36rKBc8nRqMxar5oOSE2ldBHTBOl7fPx7R6wb4gMXCQJXO/iHzH7bJV
         jsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o/ozdBc2EnetQZby0Dq0arg/wM1fGuqmYXDc/fS+iKE=;
        b=NbTdxWec8lkvG29gxif/esdCZ+1kWnkZrBaXlDGiMu92fSrArC78JGpx9SGv7m7aFL
         3p0WBpemBFlDUEgtyTMjAvrBc+8rtVwkeNbDAcMZzeRkSHjQOFtJAM2KEksbSdMun3ZI
         D976hL1rkltmRo7i0OnP3hQhvjDoTIDWYY7fzj8AaD3DfwoWJyA/ADjZ7S3AQg+NBfum
         EGHBPhWjM62fEJIZtVMywDIQ92AA689T0iSIpEQIUBgbSQ1iZARoLLa7gZ2pBvZlfDXd
         uzm4dqDUR3amZKW3faw+pYZSnqE//j8lxma+Vjpws3674livCAccVR6NV46N3NTtzjcx
         e1Kg==
X-Gm-Message-State: AOAM53387yIckTrdB21EfmK2QonJRP2U/JCVfcaJvKmXlFlk++ItiHOs
        Jm1pQre8WK8ktAD2r+ayxYU=
X-Google-Smtp-Source: ABdhPJyu4eRa97cpqRY5VQJTojJ3owbuG+DINpRNZFO51Z8kHWTLQLLQZmiw9Bsm+h1qVnlcGXWeWg==
X-Received: by 2002:a05:6a00:2883:b0:509:322f:685f with SMTP id ch3-20020a056a00288300b00509322f685fmr27259825pfb.60.1650524233790;
        Wed, 20 Apr 2022 23:57:13 -0700 (PDT)
Received: from localhost (c-107-3-154-88.hsd1.ca.comcast.net. [107.3.154.88])
        by smtp.gmail.com with ESMTPSA id w7-20020aa79547000000b0050ad0e82e6dsm2847893pfq.215.2022.04.20.23.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 23:57:13 -0700 (PDT)
Date:   Wed, 20 Apr 2022 23:57:07 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, isaku.yamahata@gmail.com
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Message-ID: <20220421065707.GA1423762@private.email.ne.jp>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <b209ee09b74394ab7aed85e0244e2191ee3d4171.camel@intel.com>
 <e0e2e399-2cac-cf75-2a64-9d017e6d7189@linux.intel.com>
 <420a4d689f73f9f7dc1ef71c61da75b7c9777a3f.camel@intel.com>
 <1e184b44-8024-b8ae-98a8-cf2b6f78df61@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e184b44-8024-b8ae-98a8-cf2b6f78df61@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 07:42:06PM -0700,
Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> 
> 
> On 4/20/22 5:11 PM, Kai Huang wrote:
> > On Wed, 2022-04-20 at 16:45 -0700, Sathyanarayanan Kuppuswamy wrote:
> > > If we want to support multiple GetQuote requests in parallel, then we
> > > need some way to uniquely identify the GetQuote requests. So that when
> > > we get completion notification, we can understand which request is
> > > completed. This part is not mentioned/discussed in ABI spec. So we want
> > > to serialize the requests for now.
> > > 
> > 
> > Yes it's unfortunate that this part (whether concurrent GetQuote requests are
> > supported by TDX architecture) is not explicitly mentioned in GHCI spec.  I am
> > fine with only supporting GetQuote requests one by one.  AFAICT there's no
> > request to support concurrent GetQuote requests anyway.  What concerns me is
> > exactly how explain this.
> > 
> > As I said, we have GET_QUOTE_IN_FLIGHT flag now.  Theoretically, you can queue
> > multiple GetQuote requests, and when you receive the interrupt, you check which
> > buffer has GET_QUOTE_IN_FLIGHT cleared.  That buffer is the one with Quote
> > ready.  However I am not 100% sure whether above will always work.  Interrupt
> > can get lost when there are multiple Quotes ready in multiple buffer in very
> > short time period, etc?  Perhaps Isaku can provide more input here.
> 
> Either supported or not, it should be mentioned in the GHCI spec. Currently,
> there are no details related to it. If it is supported, the specification
> should include the protocol to use.
> 
> I will check with Isaku about it.

The spec says that TD can call multiple GetQuote requests in parallel.

  TDG.VP.VMCALL<GetQuote> API allows one TD to issue multiple requests. It's
  implementation specific that how many concurrent requests are allowed. The TD
  should be able to handle TDG.VP.VMCALL_RETRY if it chooses to issue multiple
  requests simultaneously

As Kai said, there is no requirement for multiple GetQuote in parallel, it's
okay to support only single request at the same time.

While the status is GET_QUOTE_IN_FLIGHT, VMM owns the shared GPA.  The
attestation driver should wait for GET_QUOTE_IN_FLIGHT to be cleared before
sending next request.
-- 
Isaku Yamahata <isaku.yamahata@gmail.com>

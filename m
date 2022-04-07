Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9914F8534
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiDGQxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiDGQxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:53:04 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12904DEB3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:51:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so6810024pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 09:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/RrXicsH39NLSGqlsA1rdyOOb3sBOTJTYcFKAHj7Y2M=;
        b=h91sIPqDhwEMIBByRMTauG86zydG1joZ/sHizm89CwbEHridYpIccIxtEQvnBUD37K
         VHOQvJmO5WL0UIYOvYpl5JBDRD8wB4iaajbiWVII+mQSTAN8/KXOUivEDXZORLeVRU3J
         PZIabbitIFoSBkrvB/gPYpHumnvOLRpRooZlfyrEp8vvUGRfP1Gh2D6D/uTUmW5dMAAr
         NCkfsX+m2T7RAPpRhG0sb67xvQ+TDVPpiICiVb+yLtQipOp1Q8iWpJ590Yx5oCI0R71q
         lJ8xicQtuHejkHOyeElicDs1iYboVZ0SsEHmq3feQ3m0B2CIn3QELziCVACAyilJ2Q/E
         6u2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/RrXicsH39NLSGqlsA1rdyOOb3sBOTJTYcFKAHj7Y2M=;
        b=sVQ9vUiHa3vggcQMtk/sWcwrq09+UOU+sg+rF3xmMcWKNkbfzL849Tku4WugtVVd3V
         a3SklcVsxO5J4YSS8kBgNtZmivdNakplBvSv8yVRMYDg5+QnaXCt+1tFJrlm3I+8eZjD
         QmsRNaA810q6UX8CJUkSoytTzABZvUAgDo1SmUkb//b6S07X2bR0fCUIS+OQ5zWzvgUU
         GoZJC9YlBTavtn66ULbIYPqlD5zqNdfUin8C13plc2wD1yiSCvKI+Dqi/bwkdpzvEgcR
         xOqJaGsTpMp5z7x1ixy8VOiI57Bt0HmufKD2kX+hQ87x6K7jSGJiiAzst7PzJm15GxIE
         ASZw==
X-Gm-Message-State: AOAM533wMPKnTMAN3GK+vLklmvwAEQ4dj/kcmtlDyarEqGo6kLVs0rj4
        tPDu5x5mi3Y8V8UMfV0LKwAnlA==
X-Google-Smtp-Source: ABdhPJyubc9LgTlHp3fZLUFykKN6t55PrRAH6rrjoAVKrAoi6wQQYDQsPCqHvA7FPBOTzO7gb6qjoA==
X-Received: by 2002:a17:902:bb90:b0:156:2c05:b34f with SMTP id m16-20020a170902bb9000b001562c05b34fmr14998030pls.53.1649350251155;
        Thu, 07 Apr 2022 09:50:51 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g17-20020a625211000000b005056a6313a7sm2517974pfb.87.2022.04.07.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 09:50:50 -0700 (PDT)
Date:   Thu, 7 Apr 2022 16:50:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8 00/30] TDX Guest: TDX core support
Message-ID: <Yk8WZn+etpj/o0OM@google.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
 <b43720c6-0763-f4bb-64a0-7745c6ad920a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b43720c6-0763-f4bb-64a0-7745c6ad920a@intel.com>
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

On Thu, Apr 07, 2022, Dave Hansen wrote:
> On 4/5/22 16:29, Kirill A. Shutemov wrote:
> ...
> >  arch/x86/coco/Makefile                   |   2 +
> >  arch/x86/coco/core.c                     |  22 +-
> >  arch/x86/coco/tdx/Makefile               |   3 +
> >  arch/x86/coco/tdx/tdcall.S               | 204 +++++++
> >  arch/x86/coco/tdx/tdx.c                  | 692 +++++++++++++++++++++++
> 
> This coco/ code currently doesn't have a specific MAINTAINERS entry.
> That makes me a bit worried that folks like Kirill won't get cc'd on
> patches.
> 
> Should we just do a MAINTAINERS entry like this?  It would also be
> really nice to get some SEV folks on the list as well.  I suspect the
> coco/ directory will grow more common SEV/TDX code over time.
> 
> X86 CONFIDENTIAL COMPUTING
> M:      x86@kernel.org
> R:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ...
> S:      Supported
> F:      arch/x86/coco/
> ...

And/or a dedicated vger list?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5204B01E7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 02:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiBJBVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 20:21:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBJBV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:21:28 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA237651
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:21:29 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso6936309pjt.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 17:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XWLLyk1K8bfKzJedzmC1sFWb4iWL67xU1QxSZHF4aB8=;
        b=XNShvWlg/NeIyAfYGVaBcqrHzDAVDur9USDuZi3W2M5ist2p48UKF0SSmAIWRx9wDo
         8SuzqVc+BIerw6jPCIV0yUBdXchxww2HrVKE1lNEyIkMswe/x/GsaWQzpmw8fiyc3/q+
         xMRWamP5cVmJJWotaAu36q56YK4qUivk/30r4RgQCSfoKaG5S4a5TwohPlhtbGaWcn1I
         nYD8jQ0yWvZIApbFUvwWgkTaWksTIj8gPLjKB8Wx/+ml6o70SyXSjUMNAXJwKeqtiKmk
         8OYvtF+YZ3rv+kGAulEmNDWUV34YH2IhuhykgRzRAQKUCvv4WbHrGHjrT8szM5MZqAnp
         nPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XWLLyk1K8bfKzJedzmC1sFWb4iWL67xU1QxSZHF4aB8=;
        b=z9Wt58fvGOV6J4ob3nB59WGMN5fD4G3Y9J374Y9sy+5YM4U9AKy0Tl+4Nzp/h/1+r+
         xP0RZdML3JWNYfSQ1x2LCAPMZJvAYvfCDIYJiIos+vUw+J0T82gDiqMNdv1Hnev8L6V1
         ig3cdj8g9w1073DbsZepIw+ZXgkttzjs+T+EJlZSB1rMGBMLeIC8PLgAInhs8G9BeLg+
         hgsWxTfyLw3ENjWYihCI5M/lvFudtq76d7UCzRrR2KlwXcYoXy0JTcMhGIWvys1FJnp9
         oCWccWhNeSJazIBjMMcQlmzBnSTFbZNd8fhuTFXO08hMuAHGRX1rbrZh9YZOkuio6iXX
         D0Zw==
X-Gm-Message-State: AOAM533t+AeOUhvcEpkUC+/VcDcxmRLzHepTMVd4zEZ1Q261J4La3gks
        UNGgOw/iK3VDElXJ9nVwbOH6MQ==
X-Google-Smtp-Source: ABdhPJxcVoAd/rRot/wAvwCLs9lrgjobRNVk7/4ehykJKy+6HfjWIozsUP5gp1UukUKaBm/i3EoAjg==
X-Received: by 2002:a17:903:234f:: with SMTP id c15mr4902041plh.50.1644456088551;
        Wed, 09 Feb 2022 17:21:28 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l13sm14816202pgs.16.2022.02.09.17.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 17:21:27 -0800 (PST)
Date:   Thu, 10 Feb 2022 01:21:24 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: [PATCHv2.1 05/29] x86/tdx: Add HLT support for TDX guests
Message-ID: <YgRolJPJ0bGk4N12@google.com>
References: <YfVU01dBD36H0EIv@zn.tnic>
 <20220129223021.29417-1-kirill.shutemov@linux.intel.com>
 <874k5iz3ih.ffs@tglx>
 <20220202124830.yd4vkmy56j67tyz4@black.fi.intel.com>
 <875ypxur1n.ffs@tglx>
 <20220204165539.oqw7bj3ri4hzjiy6@black.fi.intel.com>
 <YgGioxo4hnJBJUgT@google.com>
 <20220209143407.by4s2h4zybfbvlhv@black.fi.intel.com>
 <YgQCgCx0R+RvFkyE@google.com>
 <20220209222327.5c2gv5owhhgzg2rs@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209222327.5c2gv5owhhgzg2rs@black.fi.intel.com>
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

On Thu, Feb 10, 2022, Kirill A. Shutemov wrote:
> On Wed, Feb 09, 2022 at 06:05:52PM +0000, Sean Christopherson wrote:
> > On Wed, Feb 09, 2022, Kirill A. Shutemov wrote:
> > > On Mon, Feb 07, 2022 at 10:52:19PM +0000, Sean Christopherson wrote:
> > > .Lskip_sti:
> > > 	tdcall
> > > 
> > > 	/*
> > > 	 * TDVMCALL leaf does not suppose to fail. If it fails something
> > > 	 * is horribly wrong with TDX module. Stop the world.
> > > 	 */
> > > 	test %rax, %rax
> > > 	je .Lsuccess
> > > 	ud2
> > 
> > If the ud2 or call to an external "do panic" helper is out-of-line, then the happy
> > path avoids a taken branch.  Not a big deal, but it's also trivial to do.
> 
> Something like this?

Yep.

> I assume FRAME_END is irrelevent after UD2.

Not irrelevant, but we don't want to do FRAME_END in this case.  Keeping the current
frame pointer (setup by FRAME_BEGIN, torn down by FRAME_END) will let the unwinder
do its thing when its using frame pointers.

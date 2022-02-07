Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4254ACC0B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244497AbiBGW11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBGW1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:27:25 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703C0C0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:27:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y7so6980476plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 14:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dxXiujdV1Ye+Cmvn3SWeLCaDnS5aOnzlIhHA3x8Gejo=;
        b=UYI6kZ037l3T0VF8gYm/wUEepKooca1xA8Iag8c+2cw+3BoivpO+UrFvl6hUJfwYge
         I9HnHdPq4Z2XwX8Wi41y7Wae5z3pTvuqo616go/DNmSLyL1AQZJVpp31W4cQVERXi/Di
         /qbsOuvm3/8zIU07ERU0sM+P3QCmPgf5OnJei/PE54jPMnIIdyFC8xeVNb04auyslH/t
         Pinu47Cmq6j5sQPNe/CzQDKMjuri4ec/yEyR09HgZf7JQAYhkpRfNfX9NbDSR+WM96YA
         YCbNZijfULS8Y9lHoOcgGOyAknNneGDbJ9HwhEQk61y9o2K4dc+Toxc28Albb88IZfuU
         96XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dxXiujdV1Ye+Cmvn3SWeLCaDnS5aOnzlIhHA3x8Gejo=;
        b=5Du2sMUs0KsXWjJfshulM2U2geA3KaB/sABOSqVaPeDOTpJadCU69Y78ooGd3CiLu8
         x6nOOEQgGwVo753Xf+E1JIfcYAhcDMNzHyR3SnUAl/1su4CsuihsI4NuNTh9TmWOuz5r
         PyqrWD9NTPN9ju70Atm4/x7m3FH3oCvRpJtqNmqhe2m1PNz4jWx6W6wm4SUwFuG9OwpS
         F/zZyKJxE0/E4w9PTpR7hWZNFLq69+O+A9QU8MOZtXU3etR6sD5xMrAr0xYjhnGkIFcr
         13mjKeTdEY9OvMNYEszfyACZlPORO87xQqAVTKN1fIfsywOXQqVeVPkiYIO6bYx6rqnE
         exBA==
X-Gm-Message-State: AOAM530V4XmPrzRhCMwwu3ZRCbfaU/E2oTtES/1KCwL6G+1HnIEktf/z
        3SGHhX5RTxXyVX66YS7DW8WtYA==
X-Google-Smtp-Source: ABdhPJw3D/PPI3EjClKd4HAAD3rdiq0imztKnb02/aKzUBf4ti5fN6L9aDFSgjQrEsVoJ9cj6bCJBw==
X-Received: by 2002:a17:90a:4811:: with SMTP id a17mr1113366pjh.159.1644272844772;
        Mon, 07 Feb 2022 14:27:24 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b14sm13427701pfm.17.2022.02.07.14.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:27:24 -0800 (PST)
Date:   Mon, 7 Feb 2022 22:27:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 20/29] x86/tdx: Get page shared bit info from the TDX
 module
Message-ID: <YgGcyGYDHf2KywD9@google.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-21-kirill.shutemov@linux.intel.com>
 <87iltyw2et.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iltyw2et.ffs@tglx>
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

On Wed, Feb 02, 2022, Thomas Gleixner wrote:
> On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
> > +static void tdx_get_info(void)
> > +{
> > +	struct tdx_module_output out;
> > +	u64 ret;
> > +
> > +	/*
> > +	 * TDINFO TDX module call is used to get the TD execution environment
> > +	 * information like GPA width, number of available vcpus, debug mode
> > +	 * information, etc. More details about the ABI can be found in TDX
> > +	 * Guest-Host-Communication Interface (GHCI), sec 2.4.2 TDCALL
> > +	 * [TDG.VP.INFO].
> > +	 */
> > +	ret = __tdx_module_call(TDX_GET_INFO, 0, 0, 0, 0, &out);
> > +
> > +	/* Non zero return value indicates buggy TDX module, so panic */
> 
> Can you please get rid of these useless comments all over the place. The
> panic() message tells the same story. Please document the non-obvious
> things.

And why isn't there a tdx_module_call() wrapper to panic() on failure?  IIRC,
that's why the asm routines had the double underscore, but that detail appears
to have been lost.  E.g. __tdx_module_call(TDX_GET_VEINFO, ...) in patch 04 should
also panic, but it currently morphs the #VE into a #GP if it can't retrieve the
info, which will lead to weird "#GPs" on things like vanilla MOV instructions if
something does go wrong.  TDX_ACCEPT_PAGE is the only call into the TDX Module
for which failure is not fatal.

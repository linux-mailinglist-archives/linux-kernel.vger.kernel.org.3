Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F036F48369D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 19:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiACSKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 13:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiACSKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 13:10:44 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2A2C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 10:10:43 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id k27so56876809ljc.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 10:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UhBbx898E389Fzaey+N9kjPR5JWyzT1VKoYkhiyWe8g=;
        b=WNVG9om0NNJeiGdVtxlF2hehbq7ZTQinCQ0aiTIDP7czv3IYKvW0PzFZiNKtHAGkOg
         XOsR4p3Wg+sW/Av3EyKs+2lqcZ0mjWUyrmCflwzQir8438voP2MpxRgFxHf9C0UXFT42
         au35hp2HhA5Yz/CLpODDkAAxt04ZW2Too7T7LazNx7aSh+At68ojWI4BHCMyrH9Dk6nw
         kiPk7CuCES4r6EyYHAJ9uKXVXoRcju6TrwjD8aPi97IwWUTqAzAS0elu+7O+8qf41xZH
         Vo6mDuW5ZbNc3Macmml2RsUr9pfCxHkaaCOKqpA23jvj4czqKnwLMfaPXeqz/Hffd49e
         Unhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UhBbx898E389Fzaey+N9kjPR5JWyzT1VKoYkhiyWe8g=;
        b=eP3DJ63oSk5iskO/PIRktgN74O15KwDW5XlvnMjE7mD79Rp8gLOTYLnL95wYk7l5mv
         r3FXbZQ1R3yfFA/5nuxEH1girenaMP0fRCfkizTkOJRCTfV9BJonKJHpRzk8IORXDHgq
         kMPSn4U8IVWyZCb/mkme6/XBSqpyBcYFrrSwLw07ebtZqvy7bXpgYN5A8zNff9ufeU+E
         9nAnvhxKyND9XSvVsiX8DV5nsn8VTgofzAnu6/o2dUegWgQv7J/F3BuTlkSAan1d0lE8
         Eo5uYkolxvbak7VzIaYoekuBzDp+C0/GEQEENtcLLo6oTKPeMprmA0V7xeUPxb0EFhbE
         zGJA==
X-Gm-Message-State: AOAM5337rYUS8Wr2cOtJw8x7hH1JPRJy8x3xjhqb2DmwAB+70J8YlGyS
        kFnEdZx7/Gk63ImR9en8jGI9dg==
X-Google-Smtp-Source: ABdhPJzY+s8TfVvyJ9/LCXSRARWNgeCS8RHWcxrxopKC3x+KZZIczghbGQh9RqSvS5nDp/wrHlVJWA==
X-Received: by 2002:a2e:a546:: with SMTP id e6mr7438700ljn.320.1641233442100;
        Mon, 03 Jan 2022 10:10:42 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g24sm1444781lfh.88.2022.01.03.10.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 10:10:41 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 49129103686; Mon,  3 Jan 2022 21:10:59 +0300 (+03)
Date:   Mon, 3 Jan 2022 21:10:59 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
Message-ID: <20220103181059.ui5eloufw5gsojcb@box.shutemov.name>
References: <f61b591b-a06c-bc29-4b9b-a5d46111fe4e@intel.com>
 <YcTTt4LXKfDO+9u3@zn.tnic>
 <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
 <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
 <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
 <YdMIWAT42el4D6wJ@zn.tnic>
 <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
 <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 08:50:12AM -0800, Dave Hansen wrote:
> On 1/3/22 7:15 AM, Kirill A. Shutemov wrote:
> > On Mon, Jan 03, 2022 at 03:29:44PM +0100, Borislav Petkov wrote:
> >> On Mon, Jan 03, 2022 at 05:17:05PM +0300, Kirill A. Shutemov wrote:
> >>> I'm not sure how to unwind this dependency hell. Any clues?
> >> Forward-declaration maybe?
> >>
> >> I.e., something like
> >>
> >> struct task_struct;
> >>
> >> at the top of arch/x86/include/asm/switch_to.h, for example...
> > Forward-declaration only works if you refer the struct/union by pointer,
> > not value.
> > 
> > And pgprot_t is not always a struct and when it is a struct it is
> > anonymous.
> > 
> > See "git grep 'typedef.*pgprot_t;'".
> 
> In the end, the new functions get used like this:
> 
> 	prot = pgprot_decrypted(prot);
> 
> I think they _could_ be:
> 
> 	pgprot_set_decrypted(&prot);
> 
> Which would let you have a declaration like this:
> 
> 	extern void pgprot_cc_set_decrypted(pgprot_t *prot);
> 
> It does not exactly give me warm and fuzzy feelings, but it would work
> around the header problem.

Apart for being ugly, I don't see how it solves anything. How would you
forward-declare a typedef?

-- 
 Kirill A. Shutemov

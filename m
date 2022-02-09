Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04ABA4AF737
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbiBIQuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbiBIQuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:50:10 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ECBC05CB87
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:50:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y9so2658460pjf.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ie+kBJX6zNW29jfgEHXpxmht0Lrv/fsvECrXMCMfQ7I=;
        b=K/P0J+sdRGgRinBlOtzxkkPjlvqRjiPji9QWnf00s+heAYZmJtjdWDby61q88LB/mX
         LEBYaSzFf1CCGzmkPco3V/UyPckytOEE9NIivfi8KZIiijiYvvG0SSM90wQ4yv3MxXOm
         7HRwUbBSUBbHBxekRI7DGLxinpQFL67af5RL88gGAJMsAxlwU0JaQfalVAWE+yTx76Uo
         7wn6nahEz/t44Yht0AXkYT9V7ybNvIKWhnPC6JFpdSzNea0wbTX7n/hdz2d6l99v2N9n
         MelhhfPsbT4MgoGaaS5LzaLFLVDY4NsFgVsQ7zSApeAIBz22NaiXYCG1NtsGTCcH9kmd
         Y7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ie+kBJX6zNW29jfgEHXpxmht0Lrv/fsvECrXMCMfQ7I=;
        b=Tm7htgI0h7cr5STQ9kiVsGK4M8LVPoy/zk9xEgpFsmkCGTHMuR+71PTL5xOrBQbtX7
         jWdPc6oh8UxDL4WnjBkHaL2SmJWqRd55V4LrPuuR9wBmfTe/9C2f/+Ey6qTQjDbC32xg
         iE8k0hXsVJ8Yje5U/IZ0cFnrVBeH+6ezc2lAxf9H9VDRi5dJpfZZ23ZknioSMrJO4j5c
         ANToogjD2r9v2tjidDhZ/Du7JbQT0/I6VjUp3A4RMkfgyhW6Dym7EbhdjG7eQ+UvT519
         XFP1xbd9FmRvRMpFAd0/6Kk7V6lwvSTHQYwasZOaiVvgaMC3hHOJs/m4rpHaUr0X5dVk
         I+0A==
X-Gm-Message-State: AOAM530aIXDW3F/6oL4AQFKhhZiVygLKp8bGg9Z2k7n7CPSlAJg05Xxx
        Q7YbyEAqopRHEsZ27DeQsCeZPw==
X-Google-Smtp-Source: ABdhPJxbHpDyE45oY59DRg4rVrrESbQCB0HsjwRb0OOVlT2xJsiY70v2Pm344q+VtVaO201O56yW7w==
X-Received: by 2002:a17:902:c94a:: with SMTP id i10mr2218549pla.137.1644425412809;
        Wed, 09 Feb 2022 08:50:12 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n2sm6064046pjp.56.2022.02.09.08.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:50:11 -0800 (PST)
Date:   Wed, 9 Feb 2022 16:50:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kai Huang <kai.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-ID: <YgPwwI2+16/7jQC4@google.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220209235613.652f5720cd196331d7a220ec@intel.com>
 <YgOgog9Pb886lfsv@zn.tnic>
 <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
 <YgOoId+vyd1VhIqQ@zn.tnic>
 <20220210004831.03dea501738bee060003d040@intel.com>
 <YgOr6tZjsooJgAi9@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgOr6tZjsooJgAi9@zn.tnic>
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

On Wed, Feb 09, 2022, Borislav Petkov wrote:
> On Thu, Feb 10, 2022 at 12:48:31AM +1300, Kai Huang wrote:
> > Are you suggesting even for now we can start to put TDX host support to
> > arch/x86/coco/tdx/ ?
> 
> That's exactly what I'm suggesting. The TDX stuff is not upstream so
> nothing's cast in stone yet. This way there won't be any unpleasant code
> movements later.

I strongly prefer we put the guest and host code in separate directories.  Both
TDX and SEV are big enough that they'll benefit from splitting up files, having
to fight over file names or tag all files with guest/host will get annoying.

I do like the idea of arch/x86/coco though.  The most straightforward approach
would be:

  arch/x86/coco/guest/
  arch/x86/coco/host/

but that doesn't provide any extensibility on the host virtualization side, e.g.
to land non-coco, non-KVM-specific host virtualization code (we have a potential
use case for this).  If that happens, we'd end up with x86 KVM having code and
dependencies split across:

  arch/x86/coco/host
  arch/x86/kvm/
  arch/x86/???/

An alternative idea would be to mirror what generic KVM does (virt/kvm/), and do:

  arch/x86/coco/<guest stuff>
  arch/x86/virt/<"generic" x86 host virtualization stuff>
  arch/x86/virt/coco/<host coco stuff>
  arch/x86/virt/kvm/

Though I can already hear the stable trees and downstream kernels crying out in
horror at moving arch/x86/kvm :-)

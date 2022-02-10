Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254924B031C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiBJCKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:10:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiBJCJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 21:09:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE6D1103
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 18:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644458960; x=1675994960;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=14HFZvkskXGXmjCsgyuCIL7UCDkSY0nfG1WnzlCtV0Q=;
  b=QgqTxwnZOaMyXxwfs+cwIlOLws88F+psx682N+ZkcVZV7onW2C7dCzej
   +RV9WkMLZI3KNXCe8GwEZcPvIgmWI3dcsihrshqYB7G2lQVBA0AVD4aYJ
   yzK+t33KKxbzexA19OIxCnKDcz/GkmlyDPXj2+AOs7FUPbkTvO79oh919
   N4odx9G4wroU2NaczIuOd9vy/oI2XPQ0Xq7sWgHWYkfKkDyV0INakb2xQ
   cEh2MsX/2+79mB6JslFAD+DDeUOgN1UTFTQ1bEATc7EDeA7CKxMlkx4ot
   CoffVJajHnGOjLq3gXN88vylCjLICBNt+R0Sxkk7JH8wuY7EQN5RsgkoX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="246953707"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="246953707"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:05:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="633438541"
Received: from jratner-mobl.ger.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.251.129.27])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:05:48 -0800
Date:   Thu, 10 Feb 2022 13:05:45 +1300
From:   Kai Huang <kai.huang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-Id: <20220210130545.69cfffc8f9ced7d215141a17@intel.com>
In-Reply-To: <YgQl6Uk9rONgv9+F@zn.tnic>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
        <20220209235613.652f5720cd196331d7a220ec@intel.com>
        <YgOgog9Pb886lfsv@zn.tnic>
        <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
        <YgOoId+vyd1VhIqQ@zn.tnic>
        <20220210004831.03dea501738bee060003d040@intel.com>
        <YgOr6tZjsooJgAi9@zn.tnic>
        <YgPwwI2+16/7jQC4@google.com>
        <YgQR/S67Fqz9PanR@zn.tnic>
        <YgQfGKXOemtXnFau@google.com>
        <YgQl6Uk9rONgv9+F@zn.tnic>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > No objection to omitting "coco".  Though what about using "vmx" and "svm" instead
> > of "tdx" and "sev".
> 
> I'm not dead-set on this but ...
> 
> > We lose the more explicit tie to coco, but it would mirror the
> > sub-directories in arch/x86/kvm/
> 
> ... having them too close in naming to the non-coco stuff, might cause
> confusion when looking at:
> 
> arch/x86/kvm/vmx/vmx.c
> 
> vs
> 
> arch/x86/virt/vmx/vmx.c
> 
> Instead of having
> 
> arch/x86/kvm/vmx/vmx.c
> 
> and
> 
> arch/x86/virt/tdx/vmx.c
> 
> That second version differs just the right amount. :-)

Having vmx.c under tdx/ directory looks a little bit strange.

vmx.c seems more like "generic non-KVM host virtualization staff".

> 
> > and would avoid a mess in the scenario where tdx
> > or sev needs to share code with the non-coco side, e.g. I'm guessing TDX will need
> > to do VMXON.
> > 
> >   arch/x86/virt/vmx/
> >   	tdx.c
> > 	vmx.c
> > 
> >   arch/x86/virt/svm/
> >   	sev.c
> > 	sev-es.c
> > 	sev-snp.c
> >   	svm.c
> 
> That will probably be two files too: sev.c and svm.c
> 
> But let's see what the other folks think first...
> 

So if I catch you guys correctly, so far I am heading towards to:

	arch/x86/virt/vmx/
		tdx.c

("vmx/" can be changed if you guys prefers others later).

And I am targeting to use single tdx.c to hold ~2k LoC since looks like single
file is preferred.

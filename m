Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A751CC0E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386291AbiEEW3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386309AbiEEW3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:29:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573A9B85
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651789518; x=1683325518;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J7EFq8xXxu64ehJhvDLKryqmTjxBXFcI4TKtKuJ5cYg=;
  b=gHKcBZOQfXgsRL6ZDAhRQCPeTcbdvFopoaRbkJc06ZPTdUzQ7Mn7+zpv
   i1mwIqoLCaz7+3Nd5gnTtz87F9EgP04dvyNPQXmZOmTjTzOSM+feqe40c
   GBeRmNQn0C0fMbtH1MprEo4Ic0PhXc++6SyWslnOw/7ziUdclkEw5b7T1
   g2IOQMOinoLpKnkp3W6ejdX7mSPGSKz0G268ujhUHgAsKxatIXvbBFvSI
   mZjuev1TfVehdKrbmeap0zR744jNA12i+gGP8MQRRhoHKDAXkqGKKzKL3
   qTDb+XbHPP6+smK3CDiiCHBrSh4VkVyDqfRIoeFebK61BuIoBBqaNcwbX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="293474091"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="293474091"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 15:25:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="654432618"
Received: from anthienn-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.4.139])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 15:25:12 -0700
Message-ID: <dee7e614fea2dfe791efb84cc91be1a148954129.camel@intel.com>
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 06 May 2022 10:25:11 +1200
In-Reply-To: <5d34ac93-09dc-ea93-bffe-f3995647cd5b@linux.intel.com>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
         <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
         <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
         <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
         <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
         <1534b975275b78d61d851eb86faa226fd9be5c7a.camel@intel.com>
         <5d34ac93-09dc-ea93-bffe-f3995647cd5b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-05 at 12:03 -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi Kai,
> 
> On 5/5/22 3:50 AM, Kai Huang wrote:
> > 
> > > +       /* Submit GetQuote Request */
> > > +       ret = tdx_get_quote_hypercall(buf);
> > > +       if (ret) {
> > > +               pr_err("GetQuote hypercall failed, status:%lx\n", ret);
> > > +               ret = -EIO;
> > > +               goto free_entry;
> > > +       }
> > > +
> > > +       /* Add current quote entry to quote_list */
> > > +       add_quote_entry(entry);
> > > +
> > > +       /* Wait for attestation completion */
> > > +       ret = wait_for_completion_interruptible(&entry->compl);
> > > +       if (ret < 0) {
> > > +               ret = -EIO;
> > > +               goto del_entry;
> > > +       }
> > 
> > This is misuse of wait_for_completion_interruptible().
> > 
> > xxx_interruptible() essentially means this operation can be interrupted by
> > signal.  Using xxx_interruptible() in driver IOCTL essentially means when it
> > returns due to signal, the IOCTL should return -EINTR to let userspace know that
> > your application received some signal needs handling, and this IOCTL isn't
> > finished and you should retry.  So here we should return -EINTR (and cleanup all
> > staff has been done) when wait_for_completion_interruptible() returns -
> > ERESTARTSYS (in fact, it returns only -ERESTARTSYS or 0).
> 
> 
> But in this case, I was expecting the user agent to check the Quote
> buffer status code to understand the IN_FLIGHT, SUCCESS or FAILURE
> status and handle it appropriately. So IMO, it should not matter what
> we return for the failure case. For the IN_FLIGHT case, they can retry
> if they want after checking the status code.

Couple of issues around your statement:

1) When wait_for_completion_interruptible() returns error, you never copied the
data back to userspace.  Therefore userspace cannot check buffer status.  Your
assumption is wrong.
2) Even if you copy the data back to userspace, there's no guarantee *after* you
do the copy, the VMM won't update the buffer status.  So this doesn't work.
3) You only provide one IOCTL.  Even if userspace can retry, you will create a
new buffer, and ask VMM to do it again.  Then what happens to the old buffer? 
VMM is still owning it, and can update it, but you have already converted it
back to private, and freed it.

I really don't see how your statement is correct.

> 
> But I agree that EINTR is the appropriate return value for an
> interrupted case. So, I will change it.
> 
> > 
> > Since normally userspace application just ignore signals, and in this particular
> > case, asking userspace to retry just makes things more complicated to handle, I
> 
> I am not sure how the user agent is going to be implemented. So I don't
> want to make any assumptions. In this case, we are not asking user space
> to implement the retry support using signals. But we are just giving 
> them option to do it. It is up to them if they want to use it.

As I see you are not providing any functionality to allow userspace to retry.



-- 
Thanks,
-Kai



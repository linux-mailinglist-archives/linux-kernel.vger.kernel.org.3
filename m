Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC94DCFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiCQUtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiCQUtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:49:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B521A5D76
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647550066; x=1679086066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hmMYWSZzkNPyQOI+8FnvXcsJjJoIWtMKUc2LvJ+9yDQ=;
  b=LjhpxBumIg3KrdrJwiUwodIVFqBr8ZjBzQekmXIUIklgqH7oTnPGv6Vm
   Gvp/ZuUIkV3b30QCnqOiSLFghRrR1L7FV8eGof1AvRnIdpAR9hU9pDd28
   6wh8wpae942HUPyriLuSH7xIv884aKiuZII4R1ZUfqIaWIVvZz1JaBH0w
   EWKB7zK7cmwu4sFLtbeNl2Id8hdBQ43G3TUbNcP4NZA1loow7CfnyHy3Z
   lcf/sS/vZ4zDgc5BALU/mQg8t1cQfK5ohprz36jiXmFIGj2+GdjeAaDOJ
   9Z7Vrld5ZgVtNpb1ubt4RJ3ysA8my3ZbUAIHOhwuzbEkDA9SVupqqe6lf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="281777275"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="281777275"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="635504153"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Mar 2022 13:47:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 37DF7107; Thu, 17 Mar 2022 22:47:44 +0200 (EET)
Date:   Thu, 17 Mar 2022 23:47:44 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 24/30] x86/topology: Disable CPU online/offline control
 for TDX guests
Message-ID: <20220317204744.d5bry4246xkzecyv@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-25-kirill.shutemov@linux.intel.com>
 <87r170zqtb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r170zqtb.ffs@tglx>
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:50:08PM +0100, Thomas Gleixner wrote:
> On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >
> > Unlike regular VMs, TDX guests use the firmware hand-off wakeup method
> > to wake up the APs during the boot process. This wakeup model uses a
> > mailbox to communicate with firmware to bring up the APs. As per the
> > design, this mailbox can only be used once for the given AP, which means
> > after the APs are booted, the same mailbox cannot be used to
> > offline/online the given AP. More details about this requirement can be
> > found in Intel TDX Virtual Firmware Design Guide, sec titled "AP
> > initialization in OS" and in sec titled "Hotplug Device".
> >
> > Since the architecture does not support any method of offlining the
> > CPUs, disable CPU hotplug support in the kernel.
> >
> > Since this hotplug disable feature can be re-used by other VM guests,
> > add a new CC attribute CC_ATTR_HOTPLUG_DISABLED and use it to disable
> > the hotplug support.
> >
> > With hotplug disabled, /sys/devices/system/cpu/cpuX/online sysfs option
> > will not exist for TDX guests.
> 
> I can't find any code which removes the online file. The write will fail
> with -EOPNOTSUPP, right?

Right. Will fix the commit message.

-- 
 Kirill A. Shutemov

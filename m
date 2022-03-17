Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5584DC68F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiCQMzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiCQMwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:52:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D021A1F89E5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:50:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647521408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FzHveh5D0wbhES3zxBscZvsLRFNqiz1ukGIu06eCWMU=;
        b=WKJZJMahz2mUkwbptb+bSgPX48IJBDSFAVuI9iIoidmfuR9fE0AMMLJctsZsG8Hs6ns6xW
        gXGqH0O36/lZeEJ/dbVJCVOLCDbhwSb9q5hBX6ZDHIkba3tLz8STpeRd60cg9laRnj7ySl
        cPJo2neV+QrszN8JnBHgWJEOphh5kAE1Jc+oT/vhGWIltwhwFMvPthVSmQncy+DAWMY97c
        e9DlGqpd3FtBlOjQTrzPNOspu5Y2E1cgiSpDVTJ1o+beiaVG9X+pW1rUlSN8eOVTZQFP2Q
        ElBURo6Z/NFstXHMmPP+Bkp4H7cb75j9RK/zeidfs/rEYh0I5RmfJZoop2IQeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647521408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FzHveh5D0wbhES3zxBscZvsLRFNqiz1ukGIu06eCWMU=;
        b=uJMNE2+XTeTms+lOWaDn1Qvk/Ygye29Gs9naxwKIu3B7T8a8c9ydV8ejkcJL9TSEeT5vhP
        6kvCAf4O9sZja9AQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv6 24/30] x86/topology: Disable CPU online/offline
 control for TDX guests
In-Reply-To: <20220316020856.24435-25-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-25-kirill.shutemov@linux.intel.com>
Date:   Thu, 17 Mar 2022 13:50:08 +0100
Message-ID: <87r170zqtb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16 2022 at 05:08, Kirill A. Shutemov wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Unlike regular VMs, TDX guests use the firmware hand-off wakeup method
> to wake up the APs during the boot process. This wakeup model uses a
> mailbox to communicate with firmware to bring up the APs. As per the
> design, this mailbox can only be used once for the given AP, which means
> after the APs are booted, the same mailbox cannot be used to
> offline/online the given AP. More details about this requirement can be
> found in Intel TDX Virtual Firmware Design Guide, sec titled "AP
> initialization in OS" and in sec titled "Hotplug Device".
>
> Since the architecture does not support any method of offlining the
> CPUs, disable CPU hotplug support in the kernel.
>
> Since this hotplug disable feature can be re-used by other VM guests,
> add a new CC attribute CC_ATTR_HOTPLUG_DISABLED and use it to disable
> the hotplug support.
>
> With hotplug disabled, /sys/devices/system/cpu/cpuX/online sysfs option
> will not exist for TDX guests.

I can't find any code which removes the online file. The write will fail
with -EOPNOTSUPP, right?

> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

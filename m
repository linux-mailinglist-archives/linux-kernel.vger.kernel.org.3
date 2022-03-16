Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A104DBA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357043AbiCPWDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236240AbiCPWDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:03:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92362183F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647468159; x=1679004159;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=unsxFxvxNqydYeu6fYXvNgWVZzRQpk13Xj2Sd7S+YNk=;
  b=KO2JIW3fGFatLBVjDqkvQ1slkf3KlYQZPJtZAEmdVRk4QC5z3DRA4kem
   FnR7xho2OYloOnkuRHLzawibqjZTC67U9JOovM8hida2PHIiWOskKqd7r
   y7Rx8jGNXAGWH7F/AEfp8+bWBp3De+cHh8gqK9+ysNYNMjQZR/VFriz7E
   +Jt0qhD1Y1nJRls/DoNsiawfM46DWaCWyBu8d6GIuCHzbALQWPgGeohPR
   18gk5TvcbMTZS1hiXCEAYQGW6sF2acAot9eJn8iZZiszTiwXaxjJZVt4D
   Q5U2Hg2V7f1iAbWUiAXI0U+hiATXOgitThsnoL065+qYk0AKdFnmsXvcC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244175394"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="244175394"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:02:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="783630353"
Received: from pwblakex-mobl1.amr.corp.intel.com (HELO [10.212.129.47]) ([10.212.129.47])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:02:37 -0700
Message-ID: <1479dc19-7901-8d2b-8967-bc7b33e95af2@intel.com>
Date:   Wed, 16 Mar 2022 15:02:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-16-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv6 15/30] x86/boot: Port I/O: allow to hook up alternative
 helpers
In-Reply-To: <20220316020856.24435-16-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 19:08, Kirill A. Shutemov wrote:
> +++ b/arch/x86/boot/io.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef BOOT_IO_H
> +#define BOOT_IO_H
> +
> +#include <asm/shared/io.h>
> +
> +#undef inb
> +#undef inw
> +#undef inl
> +#undef outb
> +#undef outw
> +#undef outl
> +
> +struct port_io_ops {
> +	u8 (*inb)(u16 port);
> +	u16 (*inw)(u16 port);
> +	u32 (*inl)(u16 port);
> +	void (*outb)(u8 v, u16 port);
> +	void (*outw)(u16 v, u16 port);
> +	void (*outl)(u32 v, u16 port);
> +};
> +

This is ugly, but I don't have any better ideas considering all the
other review feedback.  It's also the boot code, so the ugliness is much
more limited in scope.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

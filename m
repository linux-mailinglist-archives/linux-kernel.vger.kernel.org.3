Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C508E50ADA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443305AbiDVCQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiDVCQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:16:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E464B1C2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 19:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650593624; x=1682129624;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a3Q0zOlJmqzKbq1TioWMjq8UWQWJ+hPrxq2cIoPXurE=;
  b=EUyO0fqDn+uDfl4GpLn4jguL2xWHc3QTT7wUfVZngzBgR7VH5IJEcm+q
   i39MVH3imci0aAg9GMkQCLT7n4pvIOMV2dAvRmS630QeocdKOf5xE23E+
   KsgjZEHf9dn8j24ixEVlK3+II82Ts11R/AudYiNXe0caz109fwj7zdTTK
   6PvJqVI3Hqi8Q6vVw0vr+OOabUQZA9oBVnVaVtig4P4mVlqGUb6Jhuty2
   gNoKcNaeUrZtBPwcPBL3Cd+wnxkZ8nLjY8Gj9hNJhHDh9o1IA+BCouoGQ
   JfaHJdXFAtS5xS0omjtGz0ktdO/IhZ/exkkE9PKe374hNCWUopb0GFJNa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="324991674"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="324991674"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 19:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="671617883"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2022 19:13:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6F61E120; Fri, 22 Apr 2022 05:13:42 +0300 (EEST)
Date:   Fri, 22 Apr 2022 05:13:42 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Annotate a noreturn function
Message-ID: <20220422021342.wpxpubqan6ndsajx@black.fi.intel.com>
References: <20220420115025.5448-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420115025.5448-1-bp@alien8.de>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 01:50:25PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> objdump complains:
> 
>   vmlinux.o: warning: objtool: __tdx_hypercall()+0x74: unreachable instruction
> 
> because __tdx_hypercall_failed() won't return but panic the guest.
> Annotate that that is ok and desired.
> 
> Fixes: eb94f1b6a70a ("x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions")
> Signed-off-by: Borislav Petkov <bp@suse.de>

Have not seen REACHABLE before.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

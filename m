Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D00506BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351965AbiDSMOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiDSMON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:14:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AFAC52
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650370291; x=1681906291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K9mNYYOocKwKMHXneuTEgIG++6u3r2KdoGyTJjcKSuk=;
  b=k3CiKsmc/E5CgHK2VcIYpCv/hV8BiQpoL/GUCmQ4gxLVijkZC//u1/K1
   euDRC7KiCih5zXyf16EYfSA2KZX+c5V/Jyf2hO2Rd8mExSBRr/fyEHEcM
   QzbaCa/B5oh+AItWxVt8N4+G18dR2lxOz8vHv46G3wVEI88zi+y71LaLw
   O9j6qiKUBC6XmI0Qg3VHh5CmC84yl9hnjbkypjWc4QWfO5PHBGs3SWujH
   acwh0gxLQ78ClHZkt+6CAOXrveJZGxdukHTrHVt/m+mx1XVBofmr1LkKT
   grEuN/uRARtYkKDhWKi0o29/lHms6+pmNTSgSAEyznFZFco2rdZ9/rz8E
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="288846933"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="288846933"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 05:11:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="554701273"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 19 Apr 2022 05:11:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EF598120; Tue, 19 Apr 2022 15:10:51 +0300 (EEST)
Date:   Tue, 19 Apr 2022 15:10:51 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH] x86/mm: Fix spacing within memory encryption features
 message
Message-ID: <20220419121051.6rp7tb3dfkoyuqth@black.fi.intel.com>
References: <02401f3024b18e90bc2508147e22e729436cb6d9.1650298573.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02401f3024b18e90bc2508147e22e729436cb6d9.1650298573.git.thomas.lendacky@amd.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 11:16:13AM -0500, Tom Lendacky wrote:
> The spacing is off in the memory encryption features message on AMD
> platforms that support memory encryption, e.g.:
> 
>   "Memory Encryption Features active:AMD  SEV SEV-ES"
> 
> There is no space before "AMD" and two spaces after it. Fix this so that
> the message is spaced properly:
> 
>   "Memory Encryption Features active: AMD SEV SEV-ES"
> 
> Fixes: 968b493173ac ("x86/mm: Make DMA memory shared for TD guest")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Oops. Sorry for that.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

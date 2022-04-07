Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9F4F850E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345755AbiDGQiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiDGQiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:38:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2A216F073
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 09:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649349366; x=1680885366;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=hK+d2HHDlz0ecW4sXiMgzJ+gVphpzWjcuVk7ypQ92YA=;
  b=gYp19h+fsnVXL82dXg6LeAPAQ5I8uuspyn2mqXmHPQpwrNJUAz9aYiuj
   dX87W2WjT65XrGONlcecxg6Nf+5QbFz7PNQOt9M2Qqu0Pvm4GDySYBmfe
   9JCjamxTWy8W7UpyIGkYJUY0uIKud2IsKYxmqGUyBh5OF1W4cn31QLVxa
   mymewVrcMmAUuJDlJ1RhIvHUIOlbIAa19yLud1HfYjekZZKJ4VcdjcS+1
   SXlVMDo88OgwC7sOZxcdnpvCuZ1kHM/CEGoWJetMjed9u9unFIcWITRjI
   oZR098kKN5oxDjgnOQ9Pos4YIwRQlbe2MzhPFIEX2ESPSAl1cKKH9MY46
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261369188"
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="261369188"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 09:36:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,242,1643702400"; 
   d="scan'208";a="659132191"
Received: from okathe-mobl.amr.corp.intel.com (HELO [10.255.228.211]) ([10.255.228.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 09:36:05 -0700
Message-ID: <b43720c6-0763-f4bb-64a0-7745c6ad920a@intel.com>
Date:   Thu, 7 Apr 2022 09:36:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
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
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv8 00/30] TDX Guest: TDX core support
In-Reply-To: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 16:29, Kirill A. Shutemov wrote:
...
>  arch/x86/coco/Makefile                   |   2 +
>  arch/x86/coco/core.c                     |  22 +-
>  arch/x86/coco/tdx/Makefile               |   3 +
>  arch/x86/coco/tdx/tdcall.S               | 204 +++++++
>  arch/x86/coco/tdx/tdx.c                  | 692 +++++++++++++++++++++++

This coco/ code currently doesn't have a specific MAINTAINERS entry.
That makes me a bit worried that folks like Kirill won't get cc'd on
patches.

Should we just do a MAINTAINERS entry like this?  It would also be
really nice to get some SEV folks on the list as well.  I suspect the
coco/ directory will grow more common SEV/TDX code over time.

X86 CONFIDENTIAL COMPUTING
M:      x86@kernel.org
R:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
...
S:      Supported
F:      arch/x86/coco/
...

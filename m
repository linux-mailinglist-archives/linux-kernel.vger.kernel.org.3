Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C456D4C379C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 22:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbiBXVZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 16:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiBXVZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:25:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3871C28B63F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 13:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645737880; x=1677273880;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=VJIUHzzNg/J5YBpbghw3Gvfsdbp1RKNrk9kYvdYy0OI=;
  b=MT7//SuR/8x6EM5f7glbdl3JStG78OfIXYGbqNJPghvXZMUtWZHoWMZd
   myy0/0TuIh1IgoZucVGBll2Iw0UTCKN+vd2p1oaUMrIX2ZfK5ZA1LFds2
   wYd6/DptGkNrZdzw8PKDxuI5lGmA6hhdACmIp5NbtrTJ7yo8r8vxaOTuC
   162sk71QKhUv2odJ3gRb/+CTam9ioL3aGCNWn25K0c4pm49PPHrdON/GP
   6hMMVwT5kz3vV7k0eKE1yKy/5gNJ+JOrkyreUVH0Mgf16L1XUG0azGuUK
   Pxs2H6Kw8KguRa8X7sbLydFjZjKAnH0J6WJhjw2IVEt7EB4Xa4icxZtat
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="239756181"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="239756181"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 13:24:39 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="639885370"
Received: from hthen-mobl2.amr.corp.intel.com (HELO [10.209.48.194]) ([10.209.48.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 13:24:38 -0800
Message-ID: <c7306c3f-41a6-6895-8bb7-a16101756599@intel.com>
Date:   Thu, 24 Feb 2022 13:24:34 -0800
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
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-14-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 13/30] x86: Adjust types used in port I/O helpers
In-Reply-To: <20220224155630.52734-14-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 07:56, Kirill A. Shutemov wrote:
> Change port I/O helpers to use u8/u16/u32 instead of unsigned
> char/short/int for values. Use u16 instead of int for port number.
> 
> It aligns the helpers with implementation in boot stub in preparation
> for consolidation.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

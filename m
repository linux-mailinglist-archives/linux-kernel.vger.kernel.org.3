Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A445A4F1686
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359251AbiDDNxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376998AbiDDNxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:53:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549D23EA9D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649080284; x=1680616284;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=/CyzTMyNUaleC6oJHeCvq7JBm6K65IzCRsT3znkbvNY=;
  b=dqvnDPzIYUUBkn25As3VyysZWjl6CdhG+n34NucnGRMnKCqyu8yg9bla
   Y3vzEjYydnBLDiGyyeIL9K+Po+bOwyA8RtB3fOb3UXGpujuM6eCvZYktL
   S8LUyBhDu3WoKVaCT+YtzTWM5fz7tSXHwEDOLiDAZSnlH8FWynRq/jaYn
   ERq6+Z8rl9YUwIOufmeOyOmdqGEtI3ZW37r2PDjCeste9MJ0y0wc2oCF+
   1tMUzuvl8+YmqsRxa3UW1zFdVYX63ic6DaaRO/tatmMv4yu20WruXy3nq
   ij4LYvBQumYMGDn7BEA3whnIUGwtnZDIM2Ey6avv0wrKbkkbxzOgUqvBY
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="242658638"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="242658638"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 06:51:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523035203"
Received: from petersun-mobl1.amr.corp.intel.com (HELO [10.209.86.175]) ([10.209.86.175])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 06:51:23 -0700
Message-ID: <dd5c52ad-9c61-54c3-6654-7a30c56b1917@intel.com>
Date:   Mon, 4 Apr 2022 06:51:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        bp@alien8.de
Cc:     aarcange@redhat.com, ak@linux.intel.com, brijesh.singh@amd.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, thomas.lendacky@amd.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
References: <YjXtK4awY6utz3wE@zn.tnic>
 <20220321160245.42886-1-kirill.shutemov@linux.intel.com>
 <9f8f57fdbbf76e70471541dc42b04f8a89be4a56.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv7.1 02/30] x86/tdx: Provide common base for SEAMCALL and
 TDCALL C wrappers
In-Reply-To: <9f8f57fdbbf76e70471541dc42b04f8a89be4a56.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/22 20:19, Kai Huang wrote:
> Btw, I previous suggested perhaps we can just use -1ULL instead of above value
> for TDX_SEAMCALL_VMFAILINVALID, but didn't get response.  The reason is this
> value will only be used when detecting P-SEAMLDR using P-SEAMLDR's SEAMLDR.INFO
> SEAMCALL.  Note your above SW-defined error codes is based on error code
> definition for TDX module, but actually P-SEAMLDR has different error code
> definition:

I suggested moving away from the -1 because it didn't really carry any
additional information.  For folks that have the spec open day in and
day out, it's easy for you to go look up what the components of that -1
_mean_.

It sounds like there's a bug here (mixing up the P-SEAMLDR and TDX
module error ABIs), but that doesn't mean that moving to -1 is the right
answer.

Please just build up an error value the same way it was done for the
software-defined TDX module error codes.

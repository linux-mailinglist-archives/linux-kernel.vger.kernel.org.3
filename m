Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBEE4D54D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbiCJWrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240933AbiCJWr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:47:29 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1725596834
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 14:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646952388; x=1678488388;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=GyPHG+6o6SQ+zoAb+LvVQuT3BEQ0NBaqyT3vnoNdJqo=;
  b=A/4Vu1WFMN5dutYpWdFCaq8xhSLpntB6Fh/H/626217TouXGAG/5SruL
   LAfhIfOyZw/VF1HBVAsDqglda73n3NDKsgx6KsmaI4YCVPq2H8/PW1sRT
   /KR1hb+81ZbhQVBfwF9nihn6bJ86ktZMrU4DgzJAVo2p1oY7LfM7Kr9GW
   di3ZYaT35n9d3ycDD7GqtGb6jRGj0OEvb8kUZHhC5q2E6tgor8PoI/djh
   BeZ5ZM8B9/9328Aq9mQevwahJ3cqVTYZ0YvUJ9KnsZzL7goiKMfo0Ib66
   FJvh9kXgYMtPW3AFjt7yThmCWOMxsIqRi/jZVIbffs9/9KiM6ir9/APog
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341828598"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="341828598"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 14:46:27 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="511096709"
Received: from rabiahus-mobl1.amr.corp.intel.com (HELO [10.251.7.204]) ([10.251.7.204])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 14:46:27 -0800
Message-ID: <4f5e149e-aa0b-d18b-3a91-6db15c2fab64@intel.com>
Date:   Thu, 10 Mar 2022 14:46:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Andrew Cooper' <Andrew.Cooper3@citrix.com>,
        Bharata B Rao <bharata@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <20220310111545.10852-4-bharata@amd.com>
 <7fccb7f2-fc88-993e-e1b2-919448844112@citrix.com>
 <bcd71ac6539e48359e8a80cb74115964@AcuMS.aculab.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v0 3/6] x86: Enable Upper Address Ignore(UAI) feature
In-Reply-To: <bcd71ac6539e48359e8a80cb74115964@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 14:37, David Laight wrote:
> Just letting user address space be aliased a lot of times doesn't
> seem like a security feature to me.
> It must have some strange use case.

This should have been in the changelogs... sheesh...

Right now, address sanitizers keep pointer metadata in various spots.
But, it requires recompiling apps and libraries.  These compiler-based
things are also so slow that production use is rare.

These masking things (ARM TBI, AMD UAI, Intel LAM) _theoretically_ let
you plumb enough metadata around with pointers to do address sanitizer
implementations in production.

I think LAM is the most sane of the three, but I'm biased.

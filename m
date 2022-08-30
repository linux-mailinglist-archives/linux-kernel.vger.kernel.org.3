Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC62B5A6641
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiH3OZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiH3OZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:25:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23364EE13;
        Tue, 30 Aug 2022 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661869531; x=1693405531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ls7bUeG0qImuDU5GXNYrpLFVEHonOvKe9zvl+zk5MN4=;
  b=YxGWLa9RvSAgt4OYdJpDNfYy4+e79McXzuEBnJyc99wqL2xs3frNJ6Sh
   HTxJSz1gsm3E2ULUUrAdiYPnyUK+s5cy04GMHOJuEQP+niAHW3qZkyt+z
   bwzBPFH3kmlOYaejizGGZbQ7+CPJtteS4/948UqY/1MRzygzaC9D/hFJv
   jO9q/mgFlMYzkYaryxBYQWVRf5bpV0TYvNFMssiG3ng556gH1ZwOP/7c9
   CRaXeH81KaoXNnHjhcFuUOQseScFHvSClp0kxmtinOn+nRXeTZbaAZylN
   X852WsolF+taLS++/XOPWNZTjQ80W8V/YcME8/33vOZechXTSjpkEE5jk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296464229"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="296464229"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 07:25:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="680053657"
Received: from agawande-mobl.amr.corp.intel.com (HELO [10.255.229.254]) ([10.255.229.254])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 07:25:30 -0700
Message-ID: <6ec9cdab-db5b-ab28-c92d-79c3812dd369@intel.com>
Date:   Tue, 30 Aug 2022 07:25:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Should Linux set the new constant-time mode CPU flags?
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Langley <agl@google.com>, Ard Biesheuvel <ardb@kernel.org>
References: <YwgCrqutxmX0W72r@gmail.com> <Ywzr2d52ixYXUDWR@zx2c4.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Ywzr2d52ixYXUDWR@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/22 09:39, Jason A. Donenfeld wrote:
> On Thu, Aug 25, 2022 at 11:15:58PM +0000, Eric Biggers wrote:
>> I'm wondering if people are aware of this issue, and whether anyone has any
>> thoughts on whether/where the kernel should be setting these new CPU flags.
>> There don't appear to have been any prior discussions about this.  (Thanks to
> Maybe it should be set unconditionally now, until we figure out how to
> make it more granular.

Personally, I'm in this camp as well.  Let's be safe and set it by
default.  There's also this tidbit in the Intel docs (and chopping out a
bunch of the noise):

	(On) processors based on microarchitectures before Ice Lake ...
	the instructions listed here operate as if DOITM is enabled.

IOW, setting DOITM=0 isn't going back to the stone age.  At worst, I'd
guess that you're giving up some optimization that only shows up in very
recent CPUs in the first place.

If folks want DOITM=1 on their snazzy new CPUs, then they came come with
performance data to demonstrate the gain they'll get from adding kernel
code to get DOITM=1.  There are a range of ways we could handle it, all
the way from adding a command-line parameter to per-task management.

Anybody disagree?

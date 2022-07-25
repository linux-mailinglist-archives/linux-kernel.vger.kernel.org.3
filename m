Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C2B58039F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbiGYRo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiGYRoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:44:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0661A054
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658771064; x=1690307064;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SkpttYi1cwno6GFk8tMlBxbrhXWEBQKeBSWYy4Xy/6A=;
  b=BqjN4nnsI8yhPNoVdd/SqEM7IlCIQ2bOSRY/RsEoZyupyOcu7tQHtfw/
   UFldm05FVLYL1m9KLuv6PE9jWsZ0hwL0oy9yaFJXy4Y/1Z0g4riLwQh+I
   6fHm8GAIZeDNh2Z/BMFnhMmUlK97ciluS+w06wjixDqRdR57V8bopvZth
   fG5Rd4BY35R05r0yHutbiALLzy5IHpA4/iOWuBGH25B3lHrBJv4NIJHbt
   rl3ZB8AR5PfFONAkf8UCD+yORl35sU16LadF7cRvV9C1P7kM85j/21HkO
   E9jXjxUBGvUXAdN0Cuk5tc33hJKaUASLnFMiJJzHtneHMFXCQF3KTST7X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="268148679"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="268148679"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 10:44:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="596750191"
Received: from spaletti-mobl1.amr.corp.intel.com (HELO [10.212.231.21]) ([10.212.231.21])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 10:44:23 -0700
Message-ID: <f2a0e0e0-79f2-1b5c-2bcd-b6037d479d4e@intel.com>
Date:   Mon, 25 Jul 2022 10:44:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Yi Sun' <yi.sun@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "heng.su@intel.com" <heng.su@intel.com>
References: <20220723083800.824442-1-yi.sun@intel.com>
 <20220723083800.824442-2-yi.sun@intel.com>
 <921078bc2a994d3ab6aba26d4654cb47@AcuMS.aculab.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <921078bc2a994d3ab6aba26d4654cb47@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/22 13:54, David Laight wrote:
> I've done some experiments that measure short instruction latencies.
> Basically I found:

Short?  The instructions in question can write up to about 12k of data.
 That's not "short" by any means.

I'm also not sure precision here is all that important.  The main things
we want to know here when and where the init and modified optimizations
are coming into play.  In other words, how often is there actual data
that *needs* to be saved and restored and can't be optimized away.

So, sure, if we were measuring a dozen cycles here, you could make an
argument that this _might_ be problematic.

But, in this case, we really just want to be able to tell when
XSAVE/XRSTOR are getting more or less expensive and also get out a
minimal amount of data (RFBM/XINUSE) to make a guess why that might be.

Is it *REALLY* worth throwing serializing instructions in and moving
clock sources to do that?  Is the added precision worth it?

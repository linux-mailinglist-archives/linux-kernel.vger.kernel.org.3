Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8274EAF3F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiC2Oc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiC2Ocy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:32:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4FF1BE8E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648564272; x=1680100272;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=MPEyK90txtRaPxxSHUlpyihpzVwxdEsPaW015RjFxuo=;
  b=K4f+qPggOtp8N2NWE2GHXQcGTkbPahUCCKT1SJUJT0sF10cnHACfZEcV
   0/9ydzj61sUZ/Rad8mH/YO6LDQCwzJuHbndQ6iBtQZAw5GsngMPxNMMio
   SkLLmKYz4F9YRa9sEkLSEVjx2GMNFvt7ckxDqeHk1MgUdoaxqyp8ZWe7I
   hlf1kVtm4VTWnJdcUlud+mKQzFVHkfNn/W6Pz3Yf83+bfLGAWosdrZEYx
   4SnLiP2vz0UH98Wm2HUORhBw47eDTFM3LWi8YirffbYPM05GZlI/zLyyC
   AokvjX55Zqrh50W54kzEOPWcZr/eLLg6i5CIpqmaqdSmOM2tCKqJ6WFFH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322447300"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="322447300"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 07:31:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="604810742"
Received: from acstuden-mobl.amr.corp.intel.com (HELO [10.209.45.17]) ([10.209.45.17])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 07:31:11 -0700
Message-ID: <55161160-1084-c81d-d116-00f5bcaa1268@intel.com>
Date:   Tue, 29 Mar 2022 07:31:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
In-Reply-To: <20220329115222.8923-1-jvgediya@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 04:52, Jagdish Gediya wrote:
> The current implementation to identify the demotion
> targets limits some of the opportunities to share
> the demotion targets between multiple source nodes.

This changelog is a bit unsatisfying.  It basically says: the current
code isn't working, throw some more code at the problem.

I'd love to see some more information about *why* the current code
doesn't work.  Is it purely a bug or was it mis-designed?

I actually wrote it intending for it to handle cases like you describe
while not leaving lots of nodes without demotion targets.

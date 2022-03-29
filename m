Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1076D4EB628
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiC2Wl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiC2Wly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:41:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95372325CE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648593605; x=1680129605;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=9ZxjrWRQCn+QQnHcEkTsysVidpslLyjF9+Y3Xn6wT/0=;
  b=KW6PN9cx8i/VARrW8clBKUM+rWmNUxyAbA8VZbqyPy1rxGLhKKQkjm1t
   3vSQRYuIYFipPla/W8lDVEIVdY3NIPOX5wbO8pgRS2dvkSO10LnsQUNRf
   SNfxXQAxxCmLBPqwi5b+gHSmYPXX/Ega1bUmO0PiiPTLumb5bkVybxyf0
   0mFe5F3ohThha0hBbwvrdT5Z0i683iLe20AyWdT9UIMnD+hEnBCdsXRJG
   2AjtZbaHrvUSi2X/sFjtzgR7dDxZRuAgYkgmBeE73+M6i3bnxLLsntvpt
   FPCT4ga1c0d8LZrJacx+1WwCoQMH5Zu5442RWkG2aX3lY5Bfr668vZxgp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="256969867"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="256969867"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 15:40:05 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="605075895"
Received: from acstuden-mobl.amr.corp.intel.com (HELO [10.209.45.17]) ([10.209.45.17])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 15:40:04 -0700
Message-ID: <3842f49f-d940-333b-74ad-55d1521209cb@intel.com>
Date:   Tue, 29 Mar 2022 15:40:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
 <55161160-1084-c81d-d116-00f5bcaa1268@intel.com>
 <YkM3/vKRoy8/fnvD@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
In-Reply-To: <YkM3/vKRoy8/fnvD@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 09:46, Jagdish Gediya wrote:
>> I'd love to see some more information about *why* the current code
>> doesn't work.  Is it purely a bug or was it mis-designed?
> I think the design seems to be intended because as per the comment
> in the current code, it was known that there are limits to the node
> sharing as a demotion target.

Ahh, that makes sense.

You've got some slow memory that's not really associated closely enough
with an initiator node to be used exclusively for demotions from that
node.  The original code was really intended for demotions when the
system is made up of relatively identical building blocks, like one CPU
with two kinds of memory attached.

I think what you're doing here makes sense.  The only thing I'll say is
that, at some point, we need to stop messing with the demotion order
that the kernel comes up with.  It's not going to be able to handle
*everything* perfectly.  We're probably not at the point that we should
stop enhancing the kernel-generated demotion order, but let's at least
keep in mind that we should stop eventually.


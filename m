Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CFD50F263
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343910AbiDZHaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343908AbiDZHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:30:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A09B8985
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650958026; x=1682494026;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jaNEaOZHZW4ArX88xjysMT3Bv8oI1VDPlRS5BXJ1sXs=;
  b=np40/NjUVbG3zWeFqo+SKnRaOBQjtTcmdXwR4xKtKc87tZktZ7E9bV6/
   11NJ/AvMH4li6dib6bFHoTnBmX9hFwByj52zxUsYIqyVVlqFutln/geIv
   uGjFqbHD7FIWQBrtzf5KUSZaoyqODJJushOmlxcPYomOk0zEHTUbUsXXd
   0rao/OxBCoJJFqVCthoiaIwsFIPqg0uHmBxnrUI/YwCI73CQV/1aR93t+
   6iTaqPLQ/yMsYlTQCKTCieYUMpJPhl/A7Ik4rN3aLlJOPRTLvrPDI5SCi
   wcNycBH7x+FOEePneFVlCgu+PqZ/OIlBj4pgH+dpdpUmSB3+w+lUBCNZB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="351927270"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="351927270"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:27:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="558161318"
Received: from yyu16-mobl.ccr.corp.intel.com ([10.254.212.128])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:26:59 -0700
Message-ID: <9581e4acc5392fd3f173189f7bd3ed11c372883e.camel@intel.com>
Subject: Re: [PATCH v3 1/7] mm: demotion: Fix demotion targets sharing among
 sources
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com
Date:   Tue, 26 Apr 2022 15:26:56 +0800
In-Reply-To: <YmZqmEyEcs3wwu2a@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
         <20220422195516.10769-2-jvgediya@linux.ibm.com>
         <bb4daddde2df1762dd0d6f2faac1d196a01d50be.camel@intel.com>
         <YmZqmEyEcs3wwu2a@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 15:02 +0530, Jagdish Gediya wrote:
> On Sun, Apr 24, 2022 at 11:25:50AM +0800, ying.huang@intel.com wrote:
> > > Subject: [PATCH v3 1/7] mm: demotion: Fix demotion targets sharing among sources
> > 
> > IMHO, this patch doesn't fix some bugs in the original code.  Instead,
> > it just enhances the original code.  For example, the subject could be,
> 
> I think it is fixing a bug, there is a comment in the code which
> mentions that 'used_targets will become unavailable in future passes.
> This limits some opportunities for multiple source nodes to share a
> destination'. As per this comment, it was intended to share a node as
> demotion targets with some limits but the code limits not some but all
> such opportunities as no common node can be demotion targets for
> multiple source node as per current code.

IMHO, the original code is just to keep as simple as possible to address
the issue for the real machines at that time.  That provides a base line
for future improvement like you have done.  If the original code
wouldn't work well for the target machines, then we fixed a bug.  But if
that doen't work well for some new kind of machines, then we need to
improve the code, add more feature, not to fix a bug.

Best Regards,
Huang, Ying

> >   mm: demotion: support to share demotion targets among sources
> > 
> > Best Regards,
> > Huang, Ying
> > 
> > [snip]
> > 
> > 
> > 



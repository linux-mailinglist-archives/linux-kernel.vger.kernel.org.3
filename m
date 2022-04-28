Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DBE5129D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbiD1DKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiD1DKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:10:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B050E27;
        Wed, 27 Apr 2022 20:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651115246; x=1682651246;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qf/sL2c/Niu6I91VlQ6JvAsod31Nu9i+Rzkwp6qjn9Q=;
  b=N61xzxtncIeFd/mhk9DrYbBDhSARcrFAxRNXonrNJ7K85KY9rvdhtdAP
   eBL61kcXQ+7TyFSD8qb1O+zbu1UdXgBHOAl3vFBs6LhFGs/hV+HfyLYaQ
   PLRRTPGT8dCKHfDVKPkBQPWlocCSuiMYjGOqnFPuK4KqGHhBiRr80qTyA
   Ys8slfqJ54cHWGsaDFqEl236OR83ad4Xi1TxWLj1PGQ01TdxnSORsvKtm
   72TU1nH9PlK6i1GlXNdEKBB+SSOLT158fh9uEzJX7iew4sHZXWe9RlLjL
   gx58GedlzP1MJLrauzBJQkTBmHBYA+93k7Y4rKOEzT/L5YcwuCPu9zkTO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="291299777"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="291299777"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 20:07:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="559370038"
Received: from liweishx-mobl.ccr.corp.intel.com ([10.255.30.19])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 20:07:23 -0700
Message-ID: <c0514f1376171e0998ce2e8b74be21a064b00406.camel@intel.com>
Subject: Re: linux-next: build failure after merge of the pm tree
From:   Zhang Rui <rui.zhang@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Thu, 28 Apr 2022 11:07:20 +0800
In-Reply-To: <20220428110030.7090a45b@canb.auug.org.au>
References: <20220428110030.7090a45b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is caused by the new merged commit 39c184a6a9a7 ("intel_idle: Fix
the 'preferred_cstates' module parameter"), which removes the variable
and function that commit cc6e234b8264 ("intel_idle: Add AlderLake
support") depends on.

I will send a patch on top to fix this soon.

thanks,
rui

On Thu, 2022-04-28 at 11:00 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pm tree, today's linux-next build (x86_64
> allmodconfig)
> failed like this:
> 
> drivers/idle/intel_idle.c: In function 'adl_idle_state_table_update':
> drivers/idle/intel_idle.c:1701:17: error: 'disable_promotion_to_c1e'
> undeclared (first use in this function)
>  1701 |                 disable_promotion_to_c1e = true;
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~
> drivers/idle/intel_idle.c:1701:17: note: each undeclared identifier
> is reported only once for each function it appears in
> drivers/idle/intel_idle.c:1706:9: error: implicit declaration of
> function 'c1e_promotion_enable' [-Werror=implicit-function-
> declaration]
>  1706 |         c1e_promotion_enable();
>       |         ^~~~~~~~~~~~~~~~~~~~
> drivers/idle/intel_idle.c: At top level:
> drivers/idle/intel_idle.c:1854:13: error: conflicting types for
> 'c1e_promotion_enable'; have 'void(void)' [-Werror]
>  1854 | static void c1e_promotion_enable(void)
>       |             ^~~~~~~~~~~~~~~~~~~~
> drivers/idle/intel_idle.c:1854:13: error: static declaration of
> 'c1e_promotion_enable' follows non-static declaration
> drivers/idle/intel_idle.c:1706:9: note: previous implicit declaration
> of 'c1e_promotion_enable' with type 'void(void)'
>  1706 |         c1e_promotion_enable();
>       |         ^~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   39c184a6a9a7 ("intel_idle: Fix the 'preferred_cstates' module
> parameter")
> 
> interacting with commit
> 
>   cc6e234b8264 ("intel_idle: Add AlderLake support")
> 
> Presumably this should have been fixed up in commit
> 
>   55ecda6f25ef ("Merge branch 'intel-idle' into linux-next")
> 
> I have used the pm tree from next-20220427 for today.
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8654B2EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353401AbiBKUog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:44:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiBKUof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:44:35 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F821A2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644612273; x=1676148273;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ooP7Nd9GepcPUnJpgnBJPD3s6gNZ7UwYLT/WQ+DKCcM=;
  b=gBBykbgumlZMgNF3vNiOf3TOlncxzV3e/BmqWwJcPRvthhQnHQ+VPJCv
   j6P3udDW7BtoPDOP02JwaEid21jQoJT8FXuTuTOCeF4zvFUyRiGp1O7uh
   RUhlTVtF1vWXa9QJKiWtslq0Sqxl+nVCNQkVvfnLY51ljy0YDEIgBLC0y
   P7uv9QZ1QF0aWnVMHDLomPxj0nUntOqmcqWwcEB6my2Mm/4KYNNs8MYMZ
   FsNY+Rt0lcUO844PDm81ujDKqW+ErGRhT7wLW3fGprmSYug4O2wK/dy5w
   mL0HurdUjcQnNcs0zL+mEmyH1tuTVdQonL/T1h0U2sM9xkyPFiaia4ea+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="237211909"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="237211909"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 12:44:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="527093527"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 12:44:33 -0800
Date:   Fri, 11 Feb 2022 12:44:33 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 30/44] mm/pkeys: Test setting a PKS key in a custom
 fault callback
Message-ID: <20220211204433.GT785175@iweiny-DESK2.sc.intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-31-ira.weiny@intel.com>
 <9ef3dff3f46edda07afdf6b2469ef9a1a606563e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef3dff3f46edda07afdf6b2469ef9a1a606563e.camel@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 09:42:32AM -0800, Edgecombe, Rick P wrote:
> On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> > +#define RUN_FAULT_ABANDON      5
> 
> The tests still call this operation "abandon" all throughout, but the
> operation got renamed in the kernel. Probably should rename it in the
> tests too.

Thanks...  I thought I had changed all the names.  Missed that one.

s/RUN_FAULT_ABANDON/RUN_FAULT_CALLBACK

Ira

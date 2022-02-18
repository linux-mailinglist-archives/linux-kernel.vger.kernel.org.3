Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3CA4BB1C4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiBRGDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:03:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiBRGDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:03:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3E915A23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 22:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645164200; x=1676700200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6+YyNesvNZh7vYpc4u4e5RhhKIa96X8dx4OpNW7wDaw=;
  b=Zoq/m3aW0x0I49R//wy3fyqvtSpU3JmaxkqWG5XhQTLBRbofZUoPlPHt
   vnL5QvXYtd8p3jqLHohQ3cxGioSVsP2YNB3c6ktsErnt0vW3YzpY3OMmz
   RjjO09MKAItCAeVUn6PGuoU7nnvziG6dj3FRmkcTC1LrrovllCfDqQFzt
   iQ/KRc5lOXu6owvPfsjOvnO/5tUvAtKejzm/WGmksqH/PdE2H1wuRVgNq
   JVuWiwNczL+PuR5sXFiHNY1J7wsYYgm4suyUZquJG5GSNI+V8R+Yb0vcX
   8NspS6LViN1YnTUTHkZWFkoa8tos5fkTavUuVGixhRR8hrYRVtTCqxSnd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="248654321"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="248654321"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 22:03:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="572178706"
Received: from rbfawkes-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.127.120])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 22:03:18 -0800
Date:   Thu, 17 Feb 2022 22:03:18 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 20/44] mm/pkeys: Add PKS test for context switching
Message-ID: <Yg82ppgoMkCu9385@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-21-ira.weiny@intel.com>
 <da79f69a41925f26d810f42f34dd149f5ea69d5c.camel@intel.com>
 <ecafd25c10b50846b24dfad370539f0a1f803672.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecafd25c10b50846b24dfad370539f0a1f803672.camel@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 11:52:44AM -0800, Edgecombe, Rick P wrote:
> On Tue, 2022-02-01 at 09:47 -0800, Edgecombe, Richard P wrote:
> > On Thu, 2022-01-27 at 09:54 -0800, ira.weiny@intel.com wrote:
> > >  lib/pks/pks_test.c                     |  74 +++++++++++
> >
> > Since this only tests a specific operation of pks, should it be named
> > more specifically? Or it might be handy if it ran all the PKS tests,
> > even though the others can be run directly.
> 
> Oops, I meant "tools/testing/selftests/x86/test_pks.c"

Yea...  me too!  ;-)
Ira

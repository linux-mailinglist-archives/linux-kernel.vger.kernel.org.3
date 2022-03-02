Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8CA4C99CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 01:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbiCBAVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 19:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiCBAVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 19:21:15 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A1337A3D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 16:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646180434; x=1677716434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=98dQ6Q9QcfcsxeOBu96Yxqiy5CHpmxJunOMgXVgmFu8=;
  b=QbytN07tlqoC2gtGiEthqs/aYY6HhQTCMDwSNlirqZWM6vHx9L2cvBd8
   hHpN/VJAriirzf/WKL5SLfQGafn/BZd0Pw4OA+UKpY1TSodDPL5LhvlrY
   4V4nDx1Jfddu4h0p4n8fYN+gQP8WtjUDfsznBkAfUyLbonjgCoO45EodU
   To4vr4AFfks89KR/kY/yqlV4RdsSm9vl3SS2o0WMMDBiqi0rYwaG2+hSx
   IOk7jMxnFAv64+SS4WqL+WvMq2mKwPnfS5Yq/TEZLNkzwhRea95vY+g5d
   BaXf1lY7qJLdaisH1dKPBUcTEo6NenD4SUyGyekflP+cljfT9mIhkKTgr
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233889531"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233889531"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 16:20:28 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630201468"
Received: from bklinvil-mobl.amr.corp.intel.com (HELO localhost) ([10.212.48.220])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 16:20:27 -0800
Date:   Tue, 1 Mar 2022 16:20:26 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 39/44] memremap_pages: Add memremap.pks_fault_mode
Message-ID: <Yh64SuAXpqMt7RFG@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-40-ira.weiny@intel.com>
 <15f8b55bdb85130a8036332f850a561447681203.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f8b55bdb85130a8036332f850a561447681203.camel@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 05:16:26PM -0800, Edgecombe, Rick P wrote:
> On Thu, 2022-01-27 at 09:55 -0800, ira.weiny@intel.com wrote:
> > +static int param_get_pks_fault_mode(char *buffer, const struct
> > kernel_param *kp)
> > +{
> > +       int ret = 0;
> This doesn't need to be initialized.

Thanks, fixed,
Ira

> 
> > +
> > +       switch (pks_fault_mode) {
> > +       case PKS_MODE_STRICT:
> > +               ret = sysfs_emit(buffer, "strict\n");
> > +               break;
> > +       case PKS_MODE_RELAXED:
> > +               ret = sysfs_emit(buffer, "relaxed\n");
> > +               break;
> > +       default:
> > +               ret = sysfs_emit(buffer, "<unknown>\n");
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +}

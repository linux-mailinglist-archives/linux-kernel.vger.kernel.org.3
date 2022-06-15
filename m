Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F62654C1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352861AbiFOGZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352299AbiFOGZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:25:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ABC28982;
        Tue, 14 Jun 2022 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655274320; x=1686810320;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ddI8tS3UaSek/8nUnRWoCMYP4JFwHdkAwrK7GfTpVlY=;
  b=m9ZXP8Es0a/uOO1I3U2MGFVG2n2VDUbI98WagGUeP4WVcFMZ5GltbJBZ
   oniej5x3OPIeSMEnR+Bv9Xo5IdgRt+YIHZ1OUGfzhgNwnXyYrGNBZGpTE
   vAQ/cfocKtuwAL2aGs1IKP6cFdZ3w5j0mLnyMnZSF7YdiMvql0xNcTixq
   da60n/sqrQwhDtvoNLMM+2fz3sG7FfLTRPMExG2VyEyVIQNtdo9AAkmKn
   lewBAED8wdIuv6Tr1NYDgtMrRttxy4Rj/v7Q6nLpI9FekY3KtKhdMLG7/
   rTmhKpo9Bk/DiElkMXM1KKsRVDyXF2o8AY331l/Hed5chYJthZaBRqlju
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="304281124"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="304281124"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 23:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="687123703"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2022 23:25:20 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.72.79])
        by linux.intel.com (Postfix) with ESMTP id 002A85807E7;
        Tue, 14 Jun 2022 23:25:15 -0700 (PDT)
Message-ID: <fd8895a033e3dae041c0dfb14012e258b3ab2964.camel@linux.intel.com>
Subject: Re: [PATCH v5 2/2] intel_idle: Add a new flag to initialize the AMX
 state
From:   Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org, riel@fb.com,
        bigeasy@linutronix.de, hch@lst.de, fenghua.yu@intel.com,
        rui.zhang@intel.com, jacob.jun.pan@linux.intel.com, lenb@kernel.org
Date:   Wed, 15 Jun 2022 09:25:14 +0300
In-Reply-To: <b5dea7bb-239d-9054-7130-03a9d1421bf5@intel.com>
References: <20220608164748.11864-1-chang.seok.bae@intel.com>
         <20220608164748.11864-3-chang.seok.bae@intel.com>
         <38cd51750ef7b995506d001eae3e4ec872cf5b77.camel@linux.intel.com>
         <b5dea7bb-239d-9054-7130-03a9d1421bf5@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 10:23 -0700, Chang S. Bae wrote:
> On 6/10/2022 3:02 AM, Artem Bityutskiy wrote:
> > 
> > LGTM,
> > 
> > Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com> 
> 
> Thanks, Artem!

I apologize for sending that e-mail in HTML format. It did not reach the mailing
lists.

Artem.


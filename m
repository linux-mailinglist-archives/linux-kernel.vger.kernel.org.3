Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDF5269C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 21:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383516AbiEMS7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350124AbiEMS7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:59:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8E236B5B
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652468385; x=1684004385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8jZEDO0wap/S70A6rQv+pSQuvwOwjW4+QKi9OH+Emho=;
  b=VQPvmxJo7n7Hi2Yncoe/646I5rny79Uc07/jWAGRhL+sV0D8iPTfdICw
   lNpwA12EQvYrliB6n9+nCSEsISjCQ53GUU/jvWRBEu0R/iR2dlt1Avbpc
   IBcb7jk73SJYMeWl8yOMnD9mTAp0IRXwzELxnUiOONiPU/rb2EKRe6PqK
   aaYsBb6cdzyuZ3OpRTM8FYTkWLZFb4DbkN1Ah/QXb3kkt7aaJzIp4ucq+
   ucQM4dCgwGUHuzkTldztkouf5P8qT/RY341AwNp8kTgel1CoNmteXBr8C
   TgLbDnxQCfk6Q+7ATfsCII9uj8PJSj2zT6tLwx6cc6L+tigKj6jZeJig3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270518314"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270518314"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 11:59:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="698603603"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2022 11:59:44 -0700
Date:   Fri, 13 May 2022 12:03:19 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 13/29] iommu/amd: Compose MSI messages for NMI irqs in
 non-IR format
Message-ID: <20220513190319.GD22683@ranerica-svr.sc.intel.com>
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-14-ricardo.neri-calderon@linux.intel.com>
 <87r156fiur.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r156fiur.ffs@tglx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 11:31:56PM +0200, Thomas Gleixner wrote:
> On Thu, May 05 2022 at 16:59, Ricardo Neri wrote:
> > +	 *
> > +	 * Also, NMIs do not have an associated vector. No need for cleanup.
> 
> They have a vector and what the heck is this cleanup comment for here?
> There is nothing cleanup alike anywhere near.
> 
> Adding confusing comments is worse than adding no comments at all.

I will remove the comment regarding cleanup. I will clarify that NMI has a
fixed vector.

Thanks and BR,
Ricardo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A14B3002
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353894AbiBKWAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:00:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353923AbiBKWAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:00:32 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B34CD7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 14:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644616828; x=1676152828;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=CITimWb5ieMVL8+eI+RkkxN4zcJlsfWrf99ICqoKahE=;
  b=VVKlbFYIDO5KMCcfKN+wbf6V3ZTb8kd+zXEukhYAFzXu+8s/CilCVYw9
   sUni1gEdEaweWhDArTVHs1q5xhclMe8s+sOeT8JVxj/9qoazpxJX0RCc5
   IXORyXR97ZRcR4fLyvjiK2fZpOS7KL91iWnY9xM+CALrEQ0BF7xhZxmxM
   oB6iNZbJSDEyIJL3aDjUZ9h9QUVhJTWZ2mFUqHUiNDPkomAaqfIjfRnTz
   5v0zTok9sEzAIaTWlDEVJ3e8heB009dlv/Z7fVvZ+vE9n6fb7jJggC1RB
   rm9d9ALbzrc/rQyO1VwnU6Dcxrt/I647eI4AL1bX5gI2qTeboBJQCqf9n
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="229782269"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="229782269"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 14:00:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="542257070"
Received: from nsmdimra-mobl.amr.corp.intel.com (HELO [10.209.96.127]) ([10.209.96.127])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 14:00:27 -0800
Message-ID: <79060ea1-8392-58d7-5a27-ff173e830403@intel.com>
Date:   Fri, 11 Feb 2022 14:00:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <20220207230254.3342514-6-fenghua.yu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 15:02, Fenghua Yu wrote:
...
> Get rid of the refcounting mechanisms and replace/rename the interfaces
> to reflect this new approach.
...
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  5 +--
>  drivers/iommu/intel/iommu.c                   |  4 +-
>  drivers/iommu/intel/svm.c                     |  9 -----
>  drivers/iommu/ioasid.c                        | 39 ++-----------------
>  drivers/iommu/iommu-sva-lib.c                 | 39 ++++++-------------
>  drivers/iommu/iommu-sva-lib.h                 |  1 -
>  include/linux/ioasid.h                        | 12 +-----
>  include/linux/sched/mm.h                      | 16 ++++++++
>  kernel/fork.c                                 |  1 +
>  9 files changed, 38 insertions(+), 88 deletions(-)

Given the heavily non-x86 diffstat here, I was hoping to see some acks
from folks that this might affect, especially on the ARM side.

Is everyone OK with this?

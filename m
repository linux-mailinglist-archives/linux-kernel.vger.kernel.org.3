Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721004B2E29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353062AbiBKUEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:04:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBKUEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:04:50 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6391CCE4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644609888; x=1676145888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ZlVaDtKfVX9/LVBJ9h/jToT61g2FD0JlwafMGgpbqg=;
  b=fNiM2WitKA+ZlJc2bhg02nzuLeggRFNNZb+ZGhK/jUSmgLJUASDtmV5Y
   ESD/Nrwnx54golHrkzSrf8obyMhhKeuKW/cC6U/lKttjotIvyKhWvZKrX
   FcvIqXyA34aWyt/rMqh/wKxVEBXXvHiu8Zp6+nvMyqPsRB9v/yvo9638P
   rnXMKUmx/tC+cjm+qrkkcM0bie5RMFc6RNziOb2z7WbJFjDZnVd7R3A9c
   wnpW7ZctMo2XJDJrGG6P7L+RjFE8vBkbBjkp4sonRFkkUR5U9drtv7BAb
   Pc40CimyYKevzoI9mOz/3+w6NDr4p4Bu35yebZedg3en65jxgGRmTZlbX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="310537804"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="310537804"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 12:04:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="702223218"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 12:04:47 -0800
Date:   Fri, 11 Feb 2022 12:04:41 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
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
Subject: Re: [PATCH v4 00/11] Re-enable ENQCMD and PASID MSR
Message-ID: <YgbBWcLzpddko1wR@otcwcpicx3.sc.intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207230254.3342514-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thomas,

On Mon, Feb 07, 2022 at 03:02:43PM -0800, Fenghua Yu wrote:
> Problems in the old code to manage SVM (Shared Virtual Memory) devices
> and the PASID (Process Address Space ID) led to that code being
> disabled.
> 
> Subsequent discussions resulted in a far simpler approach:
> 
> 1) PASID life cycle is from first allocation by a process until that
>    process exits.
> 2) All tasks begin with PASID disabled
> 3) The #GP fault handler tries to fix faulting ENQCMD instructions very
>    early (thus avoiding complexities of the XSAVE infrastructure)
> 
> Change Log:
> v4:
> - Update commit message in patch #4 (Thomas).
> - Update commit message in patch #5 (Thomas).
> - Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" in patch #1-#3
>   and patch #6-#9 (Thomas).
> - Rebased to 5.17-rc3.

A friendly reminder. Any comment on this series? Will you pick up this
series in tip?

Thank you very much!

-Fenghua

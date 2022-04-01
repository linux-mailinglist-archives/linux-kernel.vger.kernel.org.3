Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF114EEE8C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346537AbiDANzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346361AbiDANzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:55:10 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2447CC57
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648821201; x=1680357201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NxPLj+EOCmrCwV6lNB3BH9LIzEApUxGmlciC9PV9DKM=;
  b=IVBtvX3ba58e1PCDHPacPYFFjCbOtOuZ7eww/XqSe5y3UtPFTGtoTo3x
   9fuUPGLxVPcLphRj5RYZVbOo1dbDUViKQs/LdbsZnhuEzroGLzefoRuCN
   vVVc2ukjf6kFcvEW6dhPLHAfd0W9qrNeXOjDAzOPla3lA1SfKfBpl2YWl
   QTEh4oVFk5nWz5HpKqzf8LHsckv38Y5Dere4/72lOoxin3VFHabiOLBoe
   HmaZZIFPpgM54lXF4qlMO8kYBILfJeDP9oOaWcP8E+Tn/Rx68cPzPW0nN
   eOcABZqBOj6v7fZnqvEQ8UgS3UwDRqBnjCwnYHLFHfLQhLdCXWrwrc0Xc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="240732658"
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="240732658"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 06:53:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,227,1643702400"; 
   d="scan'208";a="547805163"
Received: from unknown (HELO localhost) ([10.238.155.175])
  by orsmga007.jf.intel.com with ESMTP; 01 Apr 2022 06:53:18 -0700
Date:   Fri, 1 Apr 2022 20:45:19 +0800
From:   Youquan Song <youquan.song@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Youquan Song <youquan.song@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Zhiquan Li <zhiquan1.li@intel.com>,
        Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH] x86/uaccess: restore get_user exception type to
 EX_TYPE_UACCESS
Message-ID: <20220401124519.GA6935@linux-youquan.bj.intel.com>
References: <20220328201748.1864491-1-tony.luck@intel.com>
 <20220330123205.GL8939@worktop.programming.kicks-ass.net>
 <20220331113125.GA2628@linux-youquan.bj.intel.com>
 <20220331175113.GV8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331175113.GV8939@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 07:51:13PM +0200, Peter Zijlstra wrote:
> On Thu, Mar 31, 2022 at 07:31:25PM +0800, Youquan Song wrote:
> > > Did you do your testing on RHEL or something daft like that?
> > Tested on RHEL8.x
> 
> Right; the home of obsolete software.. :-)
> 
> > > Something like the below can also work, I suppose. But please, add
> > > coherent comments to the extable code with useful references to the MCE
> > > code that does this abuse.
> > Here is the full fix patch depending on your suggestion. Thanks a lot!
> 
> Did you verify this was indeed the only UACCESS I lost?

The full fix patch has included a change in error_context to identify
this case to be MCE_IN_KERNEL_COPYIN. I verfied it fix the issue.
In addition, LTP was run and no issues were reported.

@@ -286,6 +286,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	switch (fixup_type) {
 	case EX_TYPE_UACCESS:
 	case EX_TYPE_COPY:
+	case EX_TYPE_UA_IMM_REG:
 		if (!copy_user)
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;

-Youquan

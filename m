Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB5548D063
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 03:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiAMCRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 21:17:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:10933 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231633AbiAMCRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 21:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642040256; x=1673576256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kohd/KN76Ae/MMFKWK97OCPjh5Y650GQfH6Ey9YO2tM=;
  b=JAHMiXRjj+dT7iKffXr1nao+ofS2tWYrtSUUIKJRwxUGee3y+VF2rPC6
   pDLnZLlzlhXTybNdh3O+rRQ/b5PMgk231Q+U8BqbpdxSRZepG4ZNmrbnF
   ona8+A2dbVW3d2ciu63YFeQSlN1jNkisZbex2kEfk3Uapaa07C2t68Xsr
   PPwKGOvhyCztbwy4+G/YVrNd7+u0coQ1Har6ZsKZWQu2wYDMmnul2TqV/
   iA/YcOPYBrFT6BStOQK2AP/64dgbzoMXL2so0DbTSEG81vxnU/T4EzD1A
   dZQ45Es/9LeZENOxyaW8AKLmwzEmWiEEa9+1ZfIqFUZ6yQuc7t+MUa9jT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="307257789"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="307257789"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 18:17:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="529466424"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 18:17:32 -0800
Date:   Thu, 13 Jan 2022 10:17:04 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com
Subject: Re: [ucounts]  59ec71575a:  will-it-scale.per_process_ops -10.3%
 regression
Message-ID: <20220113021704.GA18396@xsang-OptiPlex-9020>
References: <20220112134211.GA10024@xsang-OptiPlex-9020>
 <874k68pyag.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k68pyag.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Wed, Jan 12, 2022 at 01:08:23PM -0600, Eric W. Biederman wrote:
> kernel test robot <oliver.sang@intel.com> writes:
> 
> > Greeting,
> >
> > FYI, we noticed a -10.3% regression of will-it-scale.per_process_ops due to commit:
> 
> 
> I am having a bit of a challenge reading this report.  Does the -10.3%
> mean that will-it-scale.per_process_ops is performing 70873 operations
> per second instead of 78995 aka -10.3% fewer operations per second?

yes

> 
> The per-profile.self-cycles-pp.do_dec_rlimits_put_ucounts now takes +2.6
> more cycles, and perf-profile.self.cycles.pp.inc_rlimit_get_ucounts now
> takes +3.8 more cycles.
> 
> Which if I read this correctly is a regression report about two
> functions taking 3 or 4 cycles more after the code was rearranged inside
> of them.
> 
> Is that correct?  Is this a regression report saying those two functions
> are taking a few cycles more which leads to
> will-it-scale.per_process_ops not being able to perform as many
> operations per second?

yes

> 
> Given the change in the commit mentioned I think this is all down to a
> bug fix causing the code to be rearranged and a compiler optimizations.
> 
> I don't see much room to do anything about this.

got it. this is a bug fix. Thanks for explanation!

> 
> Eric
> 

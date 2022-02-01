Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A5A4A548C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 02:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiBABQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 20:16:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:6251 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbiBABQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 20:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643678175; x=1675214175;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yFiMbxHv2jU9Dq48eIVP79iXy+cfXC+v6KdXN0sS4A4=;
  b=iY7Xwzk9wPDYshWLVS9lxuMJg9JsnEfoNSxkl58r6fFbFTNCEF6GCi1M
   qp4vZj42cSDgkHUlVgM9Bmp5zAG/yMLG9YN3BTfS3U2UUYixVJXZRRveP
   AAZTIAKPzGfbq/Cl9L4J9RLChm2fwSH1TukDKI/DQ4EBCOn0FDsYt8YNT
   Mdc4/w747bCVgqxMfKjJpEY5kwMs8VWcIQTvW3PILrHKvaf74Bbb34CC7
   B0JVPuCs2G1T9ZqADEg2Yb6U7512Kz4p56soBl0N8KLO8xnZVevudMZRO
   Wki1sqINr7omUmqewpexVt22acPhBcbhIgMW2qde4Qbaw76Lll4YjiEE9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="246432693"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="246432693"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 17:16:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="497163766"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.65.131]) ([10.209.65.131])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 17:16:14 -0800
Message-ID: <2db9fab4-0aff-b8b0-5012-13556ea496af@linux.intel.com>
Date:   Mon, 31 Jan 2022 17:16:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 0/3] Handle chroot tasks properly (v1)
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
References: <20220128203950.3371061-1-namhyung@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20220128203950.3371061-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/28/2022 12:39 PM, Namhyung Kim wrote:
> Hello,
>
> I found that perf tools don't work well with tasks in a chroot.  The
> filenames in MMAP record are from the root directory of the task so
> it's different than what it sees from outside.


While that's a real problem, and for chroot it can be fixed, it's much 
more complicated for the more complex container namespace case with 
custom mounts, including loop back, etc.

It seems it really need some kind of agent to handle all cases. For 
example the agent could understand container metadata formats and then 
do the right thing.

-Andi


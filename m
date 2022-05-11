Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5E1523F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348297AbiEKVrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiEKVra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:47:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDC2286F3;
        Wed, 11 May 2022 14:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652305649; x=1683841649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K5vUYX7cPworJBAWBFM83vOSyWXHdl4K9zNHAtvVvDI=;
  b=QTdDc/sNEhHY4m7vFFOpM9uyOKll4nqK9JpqvS+Gx3I33A0RogtgCyH8
   hxLxeGMyExisGfF81KxOwONn0W8XexAii6+Vvh8JxNj2PPE891sJEnn+R
   4tAYcq0yhfnlIlnpxlyfHwcKEE+IwpIdnN+nTGs9zl2MbI8ykpfMSn9Wn
   fl/SQs5ur3O6dPypsZ/27I3LtpNfFDOFhRCWoMFLHY6Yg3yVCjW8Mn4kc
   urVBnMpumiBI+uOGfv/n2FZZpInns9OennrRsevh0q3uubVuupfwHjvw2
   l2hQeYEVeQvPw/dfnp8Q0Waeng+ZrcgIMupklArWOawHLpYNLUvJKCa/X
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269493744"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="269493744"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 14:47:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="636586943"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.146.202]) ([10.212.146.202])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 14:47:26 -0700
Message-ID: <96ad6825-7607-92ef-566c-3e7a54c397bb@linux.intel.com>
Date:   Wed, 11 May 2022 14:47:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 5/7] perf jevents: Add python converter script
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>
References: <20220511211526.1021908-1-irogers@google.com>
 <20220511211526.1021908-6-irogers@google.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20220511211526.1021908-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/11/2022 2:15 PM, Ian Rogers wrote:
> jevents.c is large, has a dependency on an old forked version of jsmn,
> and is challenging to work upon. A lot of jevents.c's complexity comes
> from needing to write json and csv parsing from first principles. In
> contrast python has this functionality in standard libraries and is
> already a build pre-requisite for tools like asciidoc (that builds all
> of the perf man pages).


Well I was still hoping at some point we could have run time loading of 
events. But yes if that's not

happening then this probably the right approach.

-Andi



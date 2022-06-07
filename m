Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BCD53F33F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiFGBQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbiFGBQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:16:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131E987A3F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654564571; x=1686100571;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5uRxpNCqrv0wkUJk7kXR7lzpnHAOfa88Tzy/qiakN/s=;
  b=W1gtUD/Ui18psFOyJhhRav4CzqARSsJw6hQ8ydWSwwPg5zeOTuzDxsMj
   /U7QwavQsYff9e0EO9u2RiUJ3jhMcJJi6zfApp2id1HJla+7pCgO1a2NL
   YWInTVnnH5yLyyKGK/Fomib4b5YGnxeMXTu/WW5LwScv1N1iLztkytEhR
   ZjkI55DDPhnVwRhtz+Uazpo0WHiQlfhSHa2ZoQ4R4k2FgwOnAuOWmcFt+
   bnijoCV31aK5XnC1E4BPTTE9X2yLqx881tkSYBo4yT3rdzhBaR/khxKK0
   GaS9xxV3N2SOy/jdvUgE+pb1EYjCrwBZGG7kda8E9MkAP680DUl1QFkFN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="256538942"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="256538942"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 18:16:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="826122910"
Received: from hongyao1-mobl.ccr.corp.intel.com ([10.249.175.193])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 18:16:04 -0700
Message-ID: <13fc8175ef5a3b5d998019d2ce5b728edd797d75.camel@intel.com>
Subject: Re: [PATCH v4 2/3] x86: Remove vendor checks from
 prefer_mwait_c1_over_halt
From:   Zhang Rui <rui.zhang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
Date:   Tue, 07 Jun 2022 09:16:01 +0800
In-Reply-To: <0f8417ab-a0f8-82d9-c075-594e5f5fd835@intel.com>
References: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
         <67ca737f7cdabfc75f930cf59b49d910d8c491d6.1653324016.git-series.wyes.karny@amd.com>
         <1cc1af5000ceb5197c3b266ac82e7770d771a7b4.camel@intel.com>
         <0f8417ab-a0f8-82d9-c075-594e5f5fd835@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-06 at 08:37 -0700, Dave Hansen wrote:
> On 6/6/22 05:50, Zhang Rui wrote:
> > I couldn't evaluate the impact to other vendors, but at least for
> > Intel platforms,
> > 
> > Test-by: Zhang Rui <rui.zhang@intel.com>
> 
> I you mean:
> 
> Tested-by: Zhang Rui <rui.zhang@intel.com>
> 
> right?

Oops, sorry.

Tested-by: Zhang Rui <rui.zhang@intel.com>

-rui


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F8659AA0D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245270AbiHTAel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245250AbiHTAef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:34:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AEDBC14
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9513B61909
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 00:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6504FC433C1;
        Sat, 20 Aug 2022 00:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660955673;
        bh=exwuMdrg5qTnP1tlzlM00aIWZ/dJVmjgxKylsvSYu3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aVTNR7yq91xjdaURJaNSqLHunfakxxuUr/eEVrt8kMCHd+Q91enZvb4cMVE7g2IkI
         TzS35VhknhyIpH4y2y6h6y9EjMTZvcuJZVeJ1CbuaKN2WxNjrkPtXUkVzFxFc4h79h
         4r2b/jCQM2N0jf4U8fRU41O1bsyqEjM2wxMSaHiw=
Date:   Fri, 19 Aug 2022 17:34:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bharata B Rao <bharata@amd.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v15 00/10] mm/demotion: Memory tiers and demotion
Message-Id: <20220819173431.5c391297042eff209e821088@linux-foundation.org>
In-Reply-To: <137cf90f-abf9-4a6d-08fb-ef3922685ba5@amd.com>
References: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
        <137cf90f-abf9-4a6d-08fb-ef3922685ba5@amd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2022 11:57:18 +0530 Bharata B Rao <bharata@amd.com> wrote:

> > The kernel initialization code makes the decision on which exact tier a memory
> > node should be assigned to based on the requests from the device drivers as well
> > as the memory device hardware information provided by the firmware.
> 
> I gave this patchset a quick try on two setups:
> 
> 1. With QEMU, when an nvdimm device is bound to dax kmem driver, I can see
> the memory node with pmem getting into a lower tier than DRAM.
> 
> 2. In an experimental CXL setup that has DRAM as part of CXL memory, I see that
> CXL memory node falls into the same tier as the regular DRAM tier. This is
> expected for now since there is no code (in low level ACPI driver?) yet to
> map the latency or bandwidth info (when available from firmware) into an
> abstract distance value, and register a memory type for the same. Guess these
> bits can be covered as part of future enhancements.

Should I add your Tested-by:?

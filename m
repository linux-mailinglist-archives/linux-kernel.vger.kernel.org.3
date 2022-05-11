Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D601D522D75
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbiEKHfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiEKHfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:35:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FE26156;
        Wed, 11 May 2022 00:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GtHBDOUv2SzILplqvasL40fJchCRZ1Q3JxJsRuhLFOg=; b=ue5w9Io/qs8nKUru5wPeBZMCS0
        qecYrDjALr2lY8idf/RRbktFJQrTrZAmAFmX7VsYoZ57oq4P2mnWWkzLTDvxoeRP+zmMnPeEya/St
        ks4nZc177nCeYAKGjnvHYZVxeWhNN1E6F2INkQZSbY2UpyEqeo7KOhPKT+MTE2ZAX0mmCzKE5u4SD
        hZnitVD3sUS54rzbq16hDFZQAdlRvE/32GLlkeWmAifQoVfYFBSKjtCfHml6X5D10XoA8tTc2xcls
        0j8UrfBgaY3q+1eSiSAU58rfjZF6r0wsm3Cr0ln7/QozmOUnNHtibvtd/QDcAks8v9Lt6WGE6uIJy
        EQAOku8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nogsA-005ElP-5C; Wed, 11 May 2022 07:35:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD4D0980E3A; Wed, 11 May 2022 09:35:01 +0200 (CEST)
Date:   Wed, 11 May 2022 09:35:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
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
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/7] Rewrite jevents program in python
Message-ID: <20220511073501.GW76023@worktop.programming.kicks-ass.net>
References: <20220511070133.710721-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511070133.710721-1-irogers@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 12:01:26AM -0700, Ian Rogers wrote:

> The changes here switch from jevents.c to a rewrite in python called
> jevents.py. This means there is a build time dependency on python, but
> such a dependency already exists for asciidoc (used to generate perf's
> man pages).

You mean just building perf (not the docs) will now require snake stuff?

That's very tedious :/ I don't typically have snakes on my machines.

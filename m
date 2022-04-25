Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6BE50DDFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbiDYKg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236344AbiDYKgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:36:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5282DF5;
        Mon, 25 Apr 2022 03:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6rsQ5fLAtyoRL3SCMAk0oVTyMBB12u7c5MZ8wkkb5As=; b=eW9cGuwpaIgQ68FjdQGW5135pM
        9tqLVhqfzw41daqFoSxdYQ/af4NbMzk56dxF37hJ8qaX77dseTCr8SUaFd5D66025hnYCKGUZq66p
        MV18qFjo7U9QpJln+4demErqx5RZkIlOvGJKAABIdbn8E+KEQUv/9X6uCCpjKLNSofDsqUhuqRptr
        FIvE5XDKWVtcPQiEMnimASjqM5XMyn89q2dx6SQF8/6CAlcRr0m4G1pJ5YXPZ/gZeMeRivL7FLgY/
        wBahDvqLCQo/PzTKleGxYxvJW1cg+4QsV3Y/oYIcwYoZHSoi6S/HVdcBH+WBhN18xRa0URKWb5bTE
        Y92rIkYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1niw1l-008c8c-4P; Mon, 25 Apr 2022 10:33:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 61E7F980BF1; Mon, 25 Apr 2022 12:33:07 +0200 (CEST)
Date:   Mon, 25 Apr 2022 12:33:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] cxl/acpi: Add root device lockdep validation
Message-ID: <20220425103307.GI2731@worktop.programming.kicks-ass.net>
References: <165055518776.3745911.9346998911322224736.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165055519869.3745911.10162603933337340370.stgit@dwillia2-desk3.amr.corp.intel.com>
 <YmNBJBTxUCvDHMbw@iweiny-desk3>
 <CAPcyv4jtNgfjWLyu6MtBAjwUiqe2qEBW802AzZZeg2gZ_wU9AQ@mail.gmail.com>
 <CAPcyv4hhD5t-qm_c_=bRjbJZFg9Mjkzbvu_2MEJB87fKy3hh-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hhD5t-qm_c_=bRjbJZFg9Mjkzbvu_2MEJB87fKy3hh-g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 10:27:52AM -0700, Dan Williams wrote:

> ...so I'm going to drop it and just add a comment about the
> expectations. As Peter said there's already a multitude of ways to
> cause false positive / negative results with lockdep so this is just
> one more area where one needs to be careful and understand the lock
> context they might be overriding.

One safe-guard might be to check the class you're overriding is indeed
__no_validate__, and WARN if not. Then the unconditional reset is
conistent.

Then, if/when, that WARN ever triggers you can revisit all this.

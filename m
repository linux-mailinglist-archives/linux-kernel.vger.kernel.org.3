Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8808F4E9278
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiC1K1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiC1K1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:27:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A940F369D9;
        Mon, 28 Mar 2022 03:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lf3j/iRG/esIjnJN7hgl0CTJgV2rHtUJ5goRSH2ROBM=; b=AG7brs63P76eLr0qRcQFEuUfjA
        pl6byXYPpSfILFFBPlkavssv233PFl/ZsZYr20eM+lLGhrMJcm2U+7gA83FEdvdKEDjJkUFo8QLNJ
        TMwheso7I7nOp0NuEVI903hjeirUjAC8MwGIO1e6YxhmpydAQVxBDSSApS2cGc+XCS1TPXwRaZ2Hy
        xepAGGRqg/MqqCfTL4MbuLpmRFnFw99IAOaewkzh4G4gjSnyMknHQ0F9vocWaH2jie0g9oHulGCo8
        eRGn5udwwaQBmi2xDbMzHZcVNgVxqlwFy6zny02qiBO471Gl7GBolBEzT1BXC8BLsHXrL6+d1iBx3
        u8M3/xvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYmZ4-00GouA-VZ; Mon, 28 Mar 2022 10:25:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7FAAC9861F5; Mon, 28 Mar 2022 12:25:34 +0200 (CEST)
Date:   Mon, 28 Mar 2022 12:25:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86: Unify format of events sysfs show
Message-ID: <20220328102534.GX8939@worktop.programming.kicks-ass.net>
References: <20220324031957.135595-1-yangjihong1@huawei.com>
 <20220324101107.GC8939@worktop.programming.kicks-ass.net>
 <a4a0758f-b183-8244-d59c-10d31d8e0a3a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a0758f-b183-8244-d59c-10d31d8e0a3a@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 09:38:47AM +0800, Yang Jihong wrote:
> Hi Peter,
> 
> On 2022/3/24 18:11, Peter Zijlstra wrote:
> > On Thu, Mar 24, 2022 at 11:19:57AM +0800, Yang Jihong wrote:
> > > Sysfs show formats of files in /sys/devices/cpu/events/ are not unified,
> > > some end with "\n", and some do not. Modify sysfs show format of events
> > > defined by EVENT_ATTR_STR to end with "\n".
> > 
> > Did you test all the userspace that consumes these fields to make sure
> > none of them break? I suppose it's mostly perf tool, but I'm fairly sure
> > there's others out there as well.
> > 
> Yes, I tested "perf record" and "perf stat" commands on my machine against
> the modified events, and the results are as follows:

Fair enough, I'll queue it for after -rc1.

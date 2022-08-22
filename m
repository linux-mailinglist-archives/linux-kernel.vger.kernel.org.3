Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951B259C34C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbiHVPop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbiHVPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:44:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44080167EA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zqT+vapO33dfH5RK6+b+4smufsoheg5AXIp4xVOHEZw=; b=YTgD0QKFHzMjlJ7OSo7AvZfA9k
        bcEXNOOqjYFGD1xXoikX1CpOKjmlfRRoOE5LZgkE5IDhmdy8Iw0D5QECPJ8GYQH6+iO3q1sK0qXPr
        qV1jS3rVfc8GY3uW+vYonyEpX0MgYA7Eg18rr6c32Kud5Z/aRBUHBf0l683CwxfpFqmogGOK5CheA
        ywHitgXOTSIsDyrPwWBHY70ZCHwtdmco1hr6773teAVE/YJAD8EEEzPARXS8GUDRUj7p6XEfSMdGG
        TtoV24HUxNf47IeIq7Vi4q8OkmI4hQU0H0hcJVQ0fkm0S+sI0U6i7JSYc786IeDKz3Y5DBF5ZqaCc
        gBcbHuRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQ9aA-00579Y-Rx; Mon, 22 Aug 2022 15:43:19 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D24B9804A3; Mon, 22 Aug 2022 17:43:18 +0200 (CEST)
Date:   Mon, 22 Aug 2022 17:43:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com
Subject: Re: [RFC v2] perf: Rewrite core context handling
Message-ID: <YwOkFqqxONtoGImZ@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqdL8LsOvxNqhz/v@hirez.programming.kicks-ass.net>
 <f994d403-df7b-d88e-8324-c29d0ef2034e@amd.com>
 <YwOgxhfS99Rquwct@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwOgxhfS99Rquwct@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 05:29:11PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 02, 2022 at 11:41:42AM +0530, Ravi Bangoria wrote:
> > 
> > > pulling up the ctx->mutex makes things simpler, but also violates the
> > > locking order vs exec_update_lock.
> > > 
> > > Pull that lock up as well...
> > 
> > I'm not able to apply this patch as is but I get the idea. Few
> > questions below...
> 
> I was just about to rebase the 'series' to current, let me do that and
> get back to you on the specifics.

https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/wip.rewrite

I need to go make dinner, but I'll try and remember how it all was
support to work later this evening when the loonies are in bed,

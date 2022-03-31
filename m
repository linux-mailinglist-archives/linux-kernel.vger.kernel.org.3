Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CB54EDFE7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiCaRxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiCaRxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:53:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367CD20DB11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VyPUihNu73IfTdE732MxSej/aNPvSlAWr0Rwps1OQpM=; b=KJPe8MrhcE/flK20Aapg3ciCCt
        D8991q2oT4TJyS/zBuWkU3e/P+hGMcnA4PGsoebAbSdYJSRjLpe5DXy9ciGVGosAfOs7oZc07TJyY
        bwEsZ9IP+4cL7UJx5Lnm62b3p4Ubs5pu7Ady/yHrpvjne6zJKGe2E+8smTdOcd8agPx2v8d2BG2s1
        O8uJsuy8R8FPjnRSVHZ5tBh88HoYbK/KPrA/FK5G29y8adu81HjFTfoR2KYwwdJ0Tk3Ggs0SGqQE5
        Dg31OL4vOfSryFMKNpIBSdJ7UZapeUvtrt8b+/p7YCSgQvyAk2e2z0nYY/bcAV6xywUUqfXVlb2RS
        7uiHNFzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZyx1-002SKm-TM; Thu, 31 Mar 2022 17:51:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9131C9861EB; Thu, 31 Mar 2022 19:51:13 +0200 (CEST)
Date:   Thu, 31 Mar 2022 19:51:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Youquan Song <youquan.song@linux.intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Zhiquan Li <zhiquan1.li@intel.com>,
        Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH] x86/uaccess: restore get_user exception type to
 EX_TYPE_UACCESS
Message-ID: <20220331175113.GV8939@worktop.programming.kicks-ass.net>
References: <20220328201748.1864491-1-tony.luck@intel.com>
 <20220330123205.GL8939@worktop.programming.kicks-ass.net>
 <20220331113125.GA2628@linux-youquan.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331113125.GA2628@linux-youquan.bj.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 07:31:25PM +0800, Youquan Song wrote:
> > Did you do your testing on RHEL or something daft like that?
> Tested on RHEL8.x

Right; the home of obsolete software.. :-)

> > Something like the below can also work, I suppose. But please, add
> > coherent comments to the extable code with useful references to the MCE
> > code that does this abuse.
> Here is the full fix patch depending on your suggestion. Thanks a lot!

Did you verify this was indeed the only UACCESS I lost?

I'm also failing to spot a comment making extable users aware of this
abuse.

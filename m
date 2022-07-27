Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E729158282E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiG0OEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiG0OEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:04:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD76515FC7;
        Wed, 27 Jul 2022 07:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F013617C0;
        Wed, 27 Jul 2022 14:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7895C433C1;
        Wed, 27 Jul 2022 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658930678;
        bh=O6jeZVLKYQMWPi3PKSOn064mNnD47HdvIqglROSSWAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKCtRLWfM+8Rrgzm3doB5vIqySsG+YUcPS1Ge/iClPuQsripsOYXN90RaNJ5CwR3c
         0FNkbeYPwuo0fSDV586zvxXkUlHAhkZlxh//dfZ9qtf7R60w3qwaKcBT1LjrXdF9Lf
         iqEUbGXx47Z7w97SOCKi0+lYfgkmMCqcL7CFYnnMsCgDoMavosU4t3M+dkxEdLxtdb
         cBl6Yc22NTmJ0CWUOqwJQE7Ag3gCbgwN2iibuSq5fVtbquyMjR5xn2b4gWlRTSLJE6
         mLG09+NXpl/9qgSaPeja8aYm5FP61mHe9tnfaz31/VvJ3fYpD9Hpfb4d2k4w6DGBmB
         16JClnZcbsXsA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2760F405DD; Wed, 27 Jul 2022 11:04:35 -0300 (-03)
Date:   Wed, 27 Jul 2022 11:04:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, pc@us.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC v3 06/17] perf kwork: Implement perf kwork report
Message-ID: <YuFF83qDSyzBrhBm@kernel.org>
References: <20220709015033.38326-1-yangjihong1@huawei.com>
 <20220709015033.38326-7-yangjihong1@huawei.com>
 <YuAnEBpYSf53PkXI@kernel.org>
 <b865f96a-856c-6a7d-a66a-c3343097ee5a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b865f96a-856c-6a7d-a66a-c3343097ee5a@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 27, 2022 at 08:39:33AM +0800, Yang Jihong escreveu:
> Hello,
> 
> On 2022/7/27 1:40, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Jul 09, 2022 at 09:50:22AM +0800, Yang Jihong escreveu:
> > > +
> > > +static void report_print_work(struct perf_kwork *kwork,
> > > +			      struct kwork_work *work)
> > > +{
> > > +	int ret = 0;
> > > +	char kwork_name[PRINT_KWORK_NAME_WIDTH];
> > > +	char max_runtime_start[32], max_runtime_end[32];
> > 
> > Committer notes:
> > 
> > - Add some {} for multiline for/if blocks
> > 
> > - Return the calculated number of printed bytes in report_print_work,
> >    otherwise soem compilers will complain that variable isn't used, e.g.:
> > 
> >     2    92.64 almalinux:9                   : FAIL clang version 13.0.1 (Red Hat 13.0.1-1.el9)
> >      builtin-kwork.c:1061:6: error: variable 'ret' set but not used [-Werror,-Wunused-but-set-variable]
> >              int ret = 0;
> > 
> > 
> OK, I'll fix it in next version.

your work with these fixups is already at acme/perf/core:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core

Please continue from there. Please let me know if I made some mistake.

Thanks for working on this!

- Arnaldo

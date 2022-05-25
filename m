Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16C053387D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiEYIb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiEYIbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:31:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B18B65
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:31:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 024BCB81CEF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:31:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62179C385B8;
        Wed, 25 May 2022 08:31:40 +0000 (UTC)
Date:   Wed, 25 May 2022 09:31:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        lkp@intel.com
Subject: Re: [PATCH] ftrace/fgraph: fix increased missing-prototypes warnings
Message-ID: <Yo3paLdqS7oJ/ueL@arm.com>
References: <20220506032737.23375-1-zhouchengming@bytedance.com>
 <20220524191718.5d906700@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524191718.5d906700@gandalf.local.home>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 07:17:18PM -0400, Steven Rostedt wrote:
> On Fri,  6 May 2022 11:27:37 +0800
> Chengming Zhou <zhouchengming@bytedance.com> wrote:
> 
> > After commit e999995c84c3 ("ftrace: cleanup ftrace_graph_caller enable
> > and disable") merged into the linux-next tree, the kernel test robot
> > (lkp@intel.com) has send out report that there are increased missing-prototypes
> > warnings caused by that commit.
> > 
> > COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 \
> > 	O=build_dir ARCH=sh SHELL=/bin/bash kernel/trace/
> > warning: no previous prototype for 'ftrace_enable_ftrace_graph_caller' [-Wmissing-prototypes]
> > warning: no previous prototype for 'ftrace_disable_ftrace_graph_caller' [-Wmissing-prototypes]
> > warning: no previous prototype for 'ftrace_return_to_handler' [-Wmissing-prototypes]
> > warning: no previous prototype for 'ftrace_graph_sleep_time_control' [-Wmissing-prototypes]
> > 
> > BTW there are so many missing-prototypes warnings if build kernel with "W=1".
> > 
> > The increased warnings for 'ftrace_[enable,disable]_ftrace_graph_caller'
> > is caused by CONFIG_FUNCTION_GRAPH_TRACER && !CONFIG_DYNAMIC_FTRACE,
> > so the declarations in <linux/ftrace.h> can't be seen in fgraph.c.
> > 
> > And this warning can't reproduce on x86_64 since x86_64 select
> > HAVE_FUNCTION_GRAPH_TRACER only when DYNAMIC_FTRACE, so fgraph.c will
> > always see the declarations in <linux/ftrace.h>.
> > 
> > This patch fix the increased warnings by put the definitions in
> > CONFIG_DYNAMIC_FTRACE although there are no real problems exist.
> > 
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The change this fixes was merged into the ARM tree and I do not have that
> code, so I can not apply this.

Ah, I missed this patch. The commit mentioned is in mainline now but I'm
happy to add it to the arm64 tree and send before -rc1.

-- 
Catalin

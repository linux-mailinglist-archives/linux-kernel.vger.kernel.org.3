Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA215030FA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbiDOWAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiDOWAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:00:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02922338B1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=h/fJAssHuhHtEQkbuzibG/c6MWf07PdZ913rUat+g0s=; b=jUdPCbAMk62xXwyXqzOgd1bK+F
        7rWq5HJIjzAVDVmoKivikcmya7dWZFWu+PkvlaLtPrOpx5VWS4GUiH8trlCW1kvDqRufSp8eesHk7
        fOktGD0VAEQuve7aNVCrRPh+8WrblztLOtI7DU2VaVyw+2yJbK7uRCprdgfx1iFMW93R43RA4W3XT
        /CdOqHOt3TcPphI085kLdlZYbdf/6Dro2sremKayILqSSbHq0NyW7escHqaJ43Glm17HJqOaHredO
        ovYlOkxNmZ0D3oVsaU9d9Kp6GafLmCFafKjt2fBDaTdpIJ0XPmh6Vn0VJtTksdCpljxaBDOTvzeL8
        1uFMzimA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfTwc-00BRmR-Pw; Fri, 15 Apr 2022 21:57:34 +0000
Date:   Fri, 15 Apr 2022 14:57:34 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, mingo@redhat.com,
        xiaowei66@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ftrace: Fix build warning
Message-ID: <YlnqTjK92J2nxQR3@bombadil.infradead.org>
References: <20220407074612.16608-1-yuehaibing@huawei.com>
 <20220407105917.715eaa2e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220407105917.715eaa2e@gandalf.local.home>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 10:59:17AM -0400, Steven Rostedt wrote:
> On Thu, 7 Apr 2022 15:46:12 +0800
> YueHaibing <yuehaibing@huawei.com> wrote:
> 
> > If CONFIG_SYSCTL and CONFIG_DYNAMIC_FTRACE is n, build warns:
> > 
> > kernel/trace/ftrace.c:7912:13: error: ‘is_permanent_ops_registered’ defined but not used [-Werror=unused-function]
> >  static bool is_permanent_ops_registered(void)
> >              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > kernel/trace/ftrace.c:89:12: error: ‘last_ftrace_enabled’ defined but not used [-Werror=unused-variable]
> >  static int last_ftrace_enabled;
> >             ^~~~~~~~~~~~~~~~~~~
> > 
> > Move is_permanent_ops_registered() to ifdef block and mark last_ftrace_enabled as
> > __maybe_unused to fix this.
> > 
> > Fixes: 7cde53da38a3 ("ftrace: move sysctl_ftrace_enabled to ftrace.c")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  kernel/trace/ftrace.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Queued onto sysctl-testing. I have one more fix I just posted for this too.

  Luis

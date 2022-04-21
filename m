Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1327509FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384931AbiDUMkx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Apr 2022 08:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241611AbiDUMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:40:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCADF21839
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 706DC61C19
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A892DC385A5;
        Thu, 21 Apr 2022 12:37:59 +0000 (UTC)
Date:   Thu, 21 Apr 2022 08:37:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <liwei391@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <zengshun.wu@outlook.com>
Subject: Re: [RFC PATCH -next v2 0/4] arm64/ftrace: support dynamic
 trampoline
Message-ID: <20220421083758.37b239a4@gandalf.local.home>
In-Reply-To: <5ddc2722-4489-f66d-552d-1f4c755b5d30@huawei.com>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
        <20220420141143.23286faa@gandalf.local.home>
        <5ddc2722-4489-f66d-552d-1f4c755b5d30@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 09:13:01 +0800
"Wangshaobo (bobo)" <bobo.shaobowang@huawei.com> wrote:

> Not yet, Steve, ftrace_location() looks has no help to find a right 
> rec->ip in our case,
> 
> ftrace_location() can find a right rec->ip when input ip is in the range 
> between
> 
> sym+0 and sym+$end, but our question is how to  identify rec->ip from 
> __mcount_loc,

Are you saying that the "ftrace location" is not between sym+0 and sym+$end?

> 
> this changed the patchable entry before bti to after in gcc:
> 
>     [1] https://reviews.llvm.org/D73680
> 
> gcc tells the place of first nop of the 5 NOPs when using 
> -fpatchable-function-entry=5,3,
> 
> but not tells the first nop after bti, so we don't know how to adjust 
> our rec->ip for ftrace.

OK, so I do not understand how the compiler is injecting bti with mcount
calls, so I'll just walk away for now ;-)

-- Steve

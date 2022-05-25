Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DAB533E94
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244639AbiEYOAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244692AbiEYN7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:59:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796BAE27D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 06:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AFE1B81DC3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7B2C385B8;
        Wed, 25 May 2022 13:58:47 +0000 (UTC)
Date:   Wed, 25 May 2022 09:58:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>,
        cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 0/4] arm64/ftrace: support dynamic
 trampoline
Message-ID: <20220525095845.53ec8fe0@gandalf.local.home>
In-Reply-To: <Yo4k2Y8oNcKG5ca0@FVFF77S0Q05N>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
        <20220420141143.23286faa@gandalf.local.home>
        <5ddc2722-4489-f66d-552d-1f4c755b5d30@huawei.com>
        <20220421083758.37b239a4@gandalf.local.home>
        <Yo4k2Y8oNcKG5ca0@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 13:45:13 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> ... the compiler places 3 NOPs *before* any BTI, and 2 NOPs *after* any BTI,
> still recording the location of the first NOP. So in the two cases we get:
> 
> 		NOP		<--- recorded location
> 		NOP
> 		NOP
> 	__func_without_bti:
> 		NOP
> 		NOP
> 
> 		NOP		<--- recorded location
> 		NOP
> 		NOP
> 	__func_with_bti:
> 		BTI
> 		NOP
> 		NOP

Are you saying that the above "recorded location" is what we have in
mcount_loc section? If that's the case, we will need to modify it to point
to something that kallsyms will recognize (ie. sym+0 or greater). Because
that will cause set_ftrace_filter to fail as well.

-- Steve


> 
> ... so where we want to patch one of the later nops to banch to a pre-function
> NOP, we need to know whether or not the compiler generated a BTI. We can
> discover discover that either by:
> 
> * Checking whether the recorded location is at sym+0 (no BTI) or sym+4 (BTI).
> 
> * Reading the instruction before the recorded location, and seeing if this is a
>   BTI.
> 
> ... and depending on how we handle thigns the two cases *might* need different
> trampolines.


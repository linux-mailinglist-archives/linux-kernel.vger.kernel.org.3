Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5653E50A1AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388317AbiDUOMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389068AbiDUOMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:12:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593792DAB1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC080B8229C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883D5C385AA;
        Thu, 21 Apr 2022 14:09:00 +0000 (UTC)
Date:   Thu, 21 Apr 2022 10:08:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <20220421100859.244c6ae3@gandalf.local.home>
In-Reply-To: <20220421100639.03c0d123@gandalf.local.home>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
        <20220316100132.244849-4-bobo.shaobowang@huawei.com>
        <YmFXrBG5AmX3+4f8@lakrids>
        <20220421100639.03c0d123@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 10:06:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Without this change, because the arch does not support dynamically
> allocated trampolines, it means that all these ftrace_ops will be
> registered to the same trampoline. That means, for every function that is
> traced, it will loop through all 10 of theses ftrace_ops and check their
> hashes to see if their callback should be called or not.

Oh, I forgot to mention. If you then enable function tracer that traces
*every function*, then *every function* will be going through this loop of
the 10 ftrace_ops!

With dynamically allocated trampolines, then most functions will just call
the trampoline that handles the function tracer directly.

-- Steve

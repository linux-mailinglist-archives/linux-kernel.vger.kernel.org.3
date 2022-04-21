Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41BA50A68F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390535AbiDURJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349367AbiDURJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:09:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952AA40907
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0894461DC7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 17:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B18C385A1;
        Thu, 21 Apr 2022 17:06:50 +0000 (UTC)
Date:   Thu, 21 Apr 2022 13:06:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com, liwei391@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, zengshun.wu@outlook.com
Subject: Re: [RFC PATCH -next v2 3/4] arm64/ftrace: support dynamically
 allocated trampolines
Message-ID: <20220421130648.56b21951@gandalf.local.home>
In-Reply-To: <YmGF/OpIhAF8YeVq@lakrids>
References: <20220316100132.244849-1-bobo.shaobowang@huawei.com>
        <20220316100132.244849-4-bobo.shaobowang@huawei.com>
        <YmFXrBG5AmX3+4f8@lakrids>
        <20220421100639.03c0d123@gandalf.local.home>
        <YmF0xYpTMoWOIl00@lakrids>
        <20220421114201.21228eeb@gandalf.local.home>
        <YmGF/OpIhAF8YeVq@lakrids>
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

On Thu, 21 Apr 2022 17:27:40 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> We can initialize the ops pointer to a default ops that does the whole
> __do_for_each_ftrace_ops() dance.

OK, I think I understand now. What you are doing is instead of creating a
trampoline that has all the information in the trampoline, you add nops to
all the functions where you can place the information in the nops (before
the function), and then have the trampoline just read that information to
find the ops pointer as well as the function to call.

I guess you could have two trampolines as well. One that always calls the
list loop, and one that calls the data stored in front of the function that
was just called the trampoline. As it is always safe to call the loop
function, you could have the call call that trampoline first, set up the
specific data before the function, then call the trampoline that will read
it. And same thing for tear down.

-- Steve

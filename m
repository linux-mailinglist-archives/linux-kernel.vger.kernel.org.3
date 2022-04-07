Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601804F8251
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344381AbiDGPBX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Apr 2022 11:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbiDGPBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:01:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4DA1EF9F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:59:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1403CB8278D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:59:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFACC385A4;
        Thu,  7 Apr 2022 14:59:19 +0000 (UTC)
Date:   Thu, 7 Apr 2022 10:59:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <mingo@redhat.com>, <mcgrof@kernel.org>, <xiaowei66@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] ftrace: Fix build warning
Message-ID: <20220407105917.715eaa2e@gandalf.local.home>
In-Reply-To: <20220407074612.16608-1-yuehaibing@huawei.com>
References: <20220407074612.16608-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 15:46:12 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> If CONFIG_SYSCTL and CONFIG_DYNAMIC_FTRACE is n, build warns:
> 
> kernel/trace/ftrace.c:7912:13: error: ‘is_permanent_ops_registered’ defined but not used [-Werror=unused-function]
>  static bool is_permanent_ops_registered(void)
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> kernel/trace/ftrace.c:89:12: error: ‘last_ftrace_enabled’ defined but not used [-Werror=unused-variable]
>  static int last_ftrace_enabled;
>             ^~~~~~~~~~~~~~~~~~~
> 
> Move is_permanent_ops_registered() to ifdef block and mark last_ftrace_enabled as
> __maybe_unused to fix this.
> 
> Fixes: 7cde53da38a3 ("ftrace: move sysctl_ftrace_enabled to ftrace.c")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  kernel/trace/ftrace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

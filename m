Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F12D485CB2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 00:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245581AbiAEX53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 18:57:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49778 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiAEX5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 18:57:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5FF6B81158;
        Wed,  5 Jan 2022 23:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5C4C36AEB;
        Wed,  5 Jan 2022 23:57:17 +0000 (UTC)
Date:   Wed, 5 Jan 2022 18:57:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] trace: remove unneeded initialization in
 __trace_uprobe_create()
Message-ID: <20220105185715.0b40cb3f@gandalf.local.home>
In-Reply-To: <20211227125308.25787-1-lukas.bulwahn@gmail.com>
References: <20211227125308.25787-1-lukas.bulwahn@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami, want to ack this?

-- Steve


On Mon, 27 Dec 2021 13:53:08 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> There is no need to initialize ret with 0, as all the early error branches
> simply return constant values, and the default path always reaches
> ret = kern_path(filename, LOOKUP_FOLLOW, &path), which will reset ret
> before the initial value was ever used.
> 
> Remove this unneeded initialization and keep the code succinct.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  kernel/trace/trace_uprobe.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 5921951a0d5c..9da10c5efdce 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -548,7 +548,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
>  	bool is_return = false;
>  	int i, ret;
>  
> -	ret = 0;
>  	ref_ctr_offset = 0;
>  
>  	switch (argv[0][0]) {


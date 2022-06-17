Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E311954FF7C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiFQVr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiFQVr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:47:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846CD54188
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:47:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B591B82BDB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 21:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF99EC3411B;
        Fri, 17 Jun 2022 21:47:21 +0000 (UTC)
Date:   Fri, 17 Jun 2022 17:47:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     <cj.chengjian@huawei.com>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <mhiramat@kernel.org>, <acme@redhat.com>,
        <yuehaibing@huawei.com>
Subject: Re: [PATCH 1/2] libtraceevent: fix memleak in make_bprint_args()
Message-ID: <20220617174720.6f63b5c8@gandalf.local.home>
In-Reply-To: <20220513023308.2400381-2-bobo.shaobowang@huawei.com>
References: <20220513023308.2400381-1-bobo.shaobowang@huawei.com>
        <20220513023308.2400381-2-bobo.shaobowang@huawei.com>
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

On Fri, 13 May 2022 10:33:07 +0800
Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:

> Release arg allocated from alloc_arg() when strdup failed in make_bprint_args().
> 
> Fixes: a6d2a61ac653 ("tools lib traceevent: Remove some die() calls")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  tools/lib/traceevent/event-parse.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index 8e24c4c78c7f..69e4d5229362 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -4507,8 +4507,10 @@ static struct tep_print_arg *make_bprint_args(char *fmt, void *data, int size, s
>  				arg->next = NULL;
>  				arg->type = TEP_PRINT_BSTRING;
>  				arg->string.string = strdup(bptr);
> -				if (!arg->string.string)
> +				if (!arg->string.string) {
> +					free(arg);
>  					goto out_free;

This is a fix, thank you. But libtraceevent now lives here:

  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/

I'll port this patch to that.

Thanks,

-- Steve

> +				}
>  				bptr += strlen(bptr) + 1;
>  				*next = arg;
>  				next = &arg->next;


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203BF54FF76
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiFQVoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiFQVoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:44:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D265402F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 019B5620C6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 21:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3D7C3411B;
        Fri, 17 Jun 2022 21:44:16 +0000 (UTC)
Date:   Fri, 17 Jun 2022 17:44:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     <cj.chengjian@huawei.com>, <linux-kernel@vger.kernel.org>,
        <liwei391@huawei.com>, <mhiramat@kernel.org>, <acme@redhat.com>,
        <yuehaibing@huawei.com>
Subject: Re: [PATCH 2/2] libtraceevent: fix free NULL pointer in
 parse_arg_add()
Message-ID: <20220617174414.495392e2@gandalf.local.home>
In-Reply-To: <20220513023308.2400381-3-bobo.shaobowang@huawei.com>
References: <20220513023308.2400381-1-bobo.shaobowang@huawei.com>
        <20220513023308.2400381-3-bobo.shaobowang@huawei.com>
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

On Fri, 13 May 2022 10:33:08 +0800
Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:

> Should not call free if parg->format is NULL.
> 
> Fixes: e7a90882b05b ("tools lib traceevent: Optimize pretty_print() function")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  tools/lib/traceevent/event-parse.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index 69e4d5229362..b1a07db54457 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -5461,9 +5461,11 @@ static int parse_arg_add(struct tep_print_parse **parse, char *format,
>  	return 0;
>  error:
>  	if (parg) {
> -		free(parg->format);
> +		if (parg->format)
> +			free(parg->format);

It's perfectly fine to call free(NULL).

This is not a bug fix.

-- Steve

>  		free(parg);
>  	}
> +
>  	return -1;
>  }
>  


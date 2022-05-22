Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FABF53037F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346832AbiEVOWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbiEVOWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 10:22:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD09A3968C
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 07:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80462B80AE9
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 14:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE5DC385AA;
        Sun, 22 May 2022 14:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653229341;
        bh=5jwl99JxBIUjh3Qh5dWJ3BCJiWyb5trvHhe0CaZLHdo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r8DCVZq+h53FFG2HiBhtx6fqFfPoWp9FQpIEVSnY1xL1bCwYER3Gg3PI3DsnioD3T
         debkWl9utxa5WSxuyCgoLVAVEop78dj95Cgn23Dg60wKypGmWxFLTPqZoawfLnAa4o
         5knxwUZVEKv4BG5uqbFN23+se71IsgnPfQRwDGbwapWWFJyR+dshfvKhFChAWqL5IT
         17lHuQ0RD8TceaqJz2a6Qlz+hZBtqZ5Ns27AWr8webq75EIaYpiNXBA5f56MBQWIYz
         6CexGKbnp8TzkhbHJqSzUF2SD7eDZQrAE3GicNZyUHnWEWV7Ij2MU2NPBV0Zkgdlk1
         sGefprsLXYr3Q==
Date:   Sun, 22 May 2022 23:22:16 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        zanussi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/4] trace/objtrace: Get the value of the object
Message-Id: <20220522232216.bb1451fb6efc18c2bccc8d09@kernel.org>
In-Reply-To: <20220512170008.1301613-3-xiehuan09@gmail.com>
References: <20220512170008.1301613-1-xiehuan09@gmail.com>
        <20220512170008.1301613-3-xiehuan09@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Fri, 13 May 2022 01:00:06 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

[...]
> @@ -175,9 +271,27 @@ trace_object_trigger(struct event_trigger_data *data,
>  
>  	field = obj_data->field;
>  	memcpy(&obj, rec + field->offset, sizeof(obj));
> -	set_trace_object(obj, tr);
> +	/* set the offset from the special object and the type size of the value*/
> +	set_trace_object(obj, obj_data->obj_offset,
> +			obj_data->obj_value_type_size, tr);
>  }
>  
> +static const struct objtrace_fetch_type objtrace_fetch_types[] = {
> +	{"u8", 1},
> +	{"s8", 1},
> +	{"x8", 1},
> +	{"u16", 2},
> +	{"s16", 2},
> +	{"x16", 2},
> +	{"u32", 4},
> +	{"s32", 4},
> +	{"x32", 4},
> +	{"u64", 8},
> +	{"s64", 8},
> +	{"x64", 8},

Hmm, as far as I can see, you don't distinguish the prefix 'u','s','x'.
If so, please support only 'x' at this moment. kprobe events supports
those types, and it distinguishes the types when printing the logged
data. E.g. 's16' shows '-1' for 0xffff, but 'x16' shows '0xffff'.
You can add another patch to support such different types afterwards.

> +	{}

If this array is null terminated, please explictly do that, like

	{NULL, 0},

for readability.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

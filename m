Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE0E55AB68
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 17:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbiFYP6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiFYP6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 11:58:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C7814D2E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 08:58:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1FFCB80B79
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 15:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B0BC3411C;
        Sat, 25 Jun 2022 15:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656172708;
        bh=C+wj1L5F+qIizsR/TtI4W39GU6Of2nP/P3g/quQ+aPI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V//YY+4JnyBjWx4SK6Ye6mmHSW3X1zsubngbcBT3wtcACUCUDIholl5vmxRZw5+Vx
         70eYcLrEnpm4LLTWNBJfptW2KaXZn4XJ1/jUN3DSj+3v0OsyvAfMY8v6iDM/ZVxeGD
         ZBdeYUoOcirwtTGmqtmD3xbxmDlVJ3DjDAUBhVtG6POrB9kmXIA92RYXyycObJu7zn
         TkfBw3LJRpzj4i6/Z3KWT7EutSUER46oiV6V3hiXxFINSY2m0qiyr81CXaGMn3t9v5
         yPYd0fLB2qEv8OZZBvBlaBCC0qCXcNcWrSWvzuEQOPo3/4fT0DZ9xZGHJQb3rGyMuE
         7m5yt3jwqU3WQ==
Date:   Sun, 26 Jun 2022 00:58:24 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        zanussi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/4] trace/objtrace: Get the value of the object
Message-Id: <20220626005824.cabbfe7d77baf3aa64ca7669@kernel.org>
In-Reply-To: <20220606160943.663180-3-xiehuan09@gmail.com>
References: <20220606160943.663180-1-xiehuan09@gmail.com>
        <20220606160943.663180-3-xiehuan09@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue,  7 Jun 2022 00:09:41 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> @@ -176,9 +275,27 @@ trace_object_trigger(struct event_trigger_data *data,
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
> +	{NULL, 0},
> +};

As I said before, please use only 'uX' types at this moment,
since the objtrace event doesn't show the value with sign.
This means it only supports 'uX'. 

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

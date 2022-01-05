Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A78485BC4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbiAEWkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245110AbiAEWkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:40:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBDAC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:40:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC61F615CE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 22:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A8EC36AEB;
        Wed,  5 Jan 2022 22:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641422431;
        bh=W2ooYWtd5fNKN/0XwTpBXyEZRdu47WgIIApoIku9Paw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A0Ttho+Wl8Pm1QpOYD56aidU8ocsYZgLnLZGLOCimmZutvka2xRYKyKa+tZefhdA2
         n8K6VgM2ucGpXR2FMWHgzKCyWnAceg2Z+Veid+P/3EARUxf/4HiRRMDEyxgD+QkyZD
         OqXG0Xrr927uS8XCFLOukAJ4huPK+B4ci5Knvyjx6rYIYJALuCjlBHKoHhqBWxiz/c
         8eAnwp9XEbV2yirDreiaoPnYrkOCWR+ucHqozv61v5KooULwSH8IX/+5zBhCKYl/4W
         i4WdDeenh4wgKbvsu5/wa92Eu9rK5pkfuH8lJ8HhGPfAdXRYgjF0t/OhSr4//yoADS
         sLn5R4dP3pX+Q==
Date:   Thu, 6 Jan 2022 07:40:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     xkernel.wang@foxmail.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing: check the return value of kstrndup()
Message-Id: <20220106074027.c67476cd8cb8d4b11e49a534@kernel.org>
In-Reply-To: <20220105171112.337844b9@gandalf.local.home>
References: <tencent_4D6E270731456EB88712ED7F13883C334906@qq.com>
        <20220105171112.337844b9@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 17:11:12 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Masami, can you ack this?

Yes, thanks for fowarding.

> 
> -- Steve
> 
> 
> On Tue, 14 Dec 2021 10:26:46 +0800
> xkernel.wang@foxmail.com wrote:
> 
> > From: Xiaoke Wang <xkernel.wang@foxmail.com>
> > 
> > kstrndup() is a memory allocation-related function, it returns NULL when
> > some internal memory errors happen. It is better to check the return
> > value of it so to catch the memory error in time.

Thanks for fixing!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: a42e3c4de964 ("tracing/probe: Add immediate string parameter support")


> > 
> > Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> > ---
> >  kernel/trace/trace_probe.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 3ed2a3f..bb4605b 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -356,6 +356,8 @@ static int __parse_imm_string(char *str, char **pbuf, int offs)
> >  		return -EINVAL;
> >  	}
> >  	*pbuf = kstrndup(str, len - 1, GFP_KERNEL);
> > +	if (!*pbuf)
> > +		return -ENOMEM;
> >  	return 0;
> >  }
> >  
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

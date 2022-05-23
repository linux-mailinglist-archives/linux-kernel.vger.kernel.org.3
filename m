Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF125531363
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbiEWOYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbiEWOY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:24:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E737354696
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:24:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so414131wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ORWFAZCp4/Zk5Nqu20QI65lyIr5uzgl0SoBfyItB3UE=;
        b=VF2DlEItiFgFDsauLZA94o/k9d7s4eVt1PkXLaY9YmDQoL18Yu+GC4FBgQB+KEtrbh
         JenVMg3gGB1OZGm821Z60KQoZOzdGUy3nJmxI+op8F+VRa77MP1uMBYA4+hzMWcSqTsm
         Q537SyAG3py9LSARQfiazWSYDBX/+64XzuZMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ORWFAZCp4/Zk5Nqu20QI65lyIr5uzgl0SoBfyItB3UE=;
        b=40WXnWb/Z5GJuYymQLo1pVwJBz9DXE3U1WETfKyexEBDAj5K3v7pqF5f+lBBM8K63x
         l0pZJrmpJYhOMQRjKnkq9bKVtmiCWdzQVzWHyUMQqKd8dHXCLzN4E1d9Yj6zTi/HqcTL
         3+KGijMk+rn/EklRo2a6kz4uRSRfiWDwNqb6SGpM7qystoBtYFbDj1TEl+I/tCUiw/jv
         X9SrDt8lsiO5osv1/8PsnrHkVL/vgXM3cM/8l7YgIOZ03sdFjbUibCxrrLuj8b+/4GLb
         FIOPpLyw6BliB0ODiF+PObdvwGwtjxJk3RFR4o06kfzpBinZBWBgROcbfLzkE16R5ZYq
         Kd1A==
X-Gm-Message-State: AOAM530IkyAIV2hap/369R78VJvg7VjCYJqNtoDNmqsdCJh/7aSnYNXH
        KnySceZg9/YHIiB331IeXK1oCw==
X-Google-Smtp-Source: ABdhPJwekygTEIIOftdiK/y+vg5EBdwu0tvFydK2dbdBmzO6AuNoTHS/5sIMvtstR7bX+0duUatXnQ==
X-Received: by 2002:a05:600c:358c:b0:394:8522:e28 with SMTP id p12-20020a05600c358c00b0039485220e28mr19979733wmq.92.1653315864322;
        Mon, 23 May 2022 07:24:24 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::4:42cf])
        by smtp.gmail.com with ESMTPSA id s1-20020adf8901000000b0020c5253d91asm10361668wrs.102.2022.05.23.07.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:24:23 -0700 (PDT)
Date:   Mon, 23 May 2022 15:24:23 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [RFC PATCH v2] printk: console: Allow each console to have its
 own loglevel
Message-ID: <YouZF7eWCy8Jrc/O@chrisdown.name>
References: <YoeQLxhDeIk4VSmx@chrisdown.name>
 <20220523130917.GA21282@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220523130917.GA21282@axis.com>
User-Agent: Mutt/2.2.5 (a8c7fba1) (2022-05-16)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Vincent Whitchurch writes:
>I've had to do something similar for my systems, to allow all messages
>to always be logged to the pstore console while still allowing the UART
>console loglevel to be adjusted.  I've been carrying the following
>pstore-specific hack for a while now.  This patch set looks like it will
>be able to solve the problem in a generic way.

Thanks, nice to hear about other usecases :-) Yes, this should allow this 
generically for any console, including pstore.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888914E5484
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbiCWOs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244904AbiCWOrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:47:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6238B81644
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648046779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cn0smztOCGunuSPJdDem3I+aqBWOZ8KtIXpALCRJfso=;
        b=YjQ97bzy/r32JQfy27kYyarmhyCEgyCt3rquyQ0hojoViteIRSXVFCGpdkSs0LZIIJ2Ozl
        nI1eNsZp3zyWj4tIrEh6LdcrImxn41g3AWGU95NPZ+B9DhmYoTmJBsFxehF42nNKTw7KHY
        S5OBzqv7Xe/l4P1qD560yALzHJ4Kc0I=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-gtfsKgHfMKWmHD-4guFyOg-1; Wed, 23 Mar 2022 10:46:18 -0400
X-MC-Unique: gtfsKgHfMKWmHD-4guFyOg-1
Received: by mail-qk1-f198.google.com with SMTP id v22-20020a05620a0a9600b0067e87a1ff57so1104986qkg.14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cn0smztOCGunuSPJdDem3I+aqBWOZ8KtIXpALCRJfso=;
        b=QeMnPe15VIbePctSOgURx1Ah6z3hD5UrTsMkUGUbjsSjgyUmx5j5DC4dTm0U0tsyP9
         UQCUaHAzS1THncUz7RoYkmgiyU14jNBsLknQPqL7xOATACAZ1DV2JMnsJk4GlbPMULWB
         1hX2zI+gXeQ8amlqQHJc9CnQN47tC7CiH+qA1/lBdBkVKx580si8fHR8OW/nnikOhJkN
         /zCZE6QDSrENepmEFWiPRgJQ0rZ15vZkmMAKA022SrVd/6aezyJ44gHEAAMds+rV2tFI
         lNDe0hU6Gz/x8WvL2GidI1Rx2MR7o3uICHg9mRc5ked1FqoiZlRuDpAs1j6h0rHGOBdw
         VOgQ==
X-Gm-Message-State: AOAM533bHErFhZSQzVoI00iy00GT+kYA5ws9Zqnvyc1TdNZE7fB31ea4
        BEbBFVw70+0KsfXxrbQkmpvWbSV1QT2BTi6/Y3+03I0DtucLytVaLSvQ/VDZ8RKBgserwF0/ikB
        UwDpxMDSfjdO6JPeS1DUkHdEk
X-Received: by 2002:a05:620a:2946:b0:67b:3039:89c with SMTP id n6-20020a05620a294600b0067b3039089cmr98620qkp.388.1648046777446;
        Wed, 23 Mar 2022 07:46:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN2LRA/dhdxHdc7btSSE2tWdp1q9V1705ngf7bilOT8vkfyeznXfhRikVWh/gWZRtBe8YUWg==
X-Received: by 2002:a05:620a:2946:b0:67b:3039:89c with SMTP id n6-20020a05620a294600b0067b3039089cmr98609qkp.388.1648046777212;
        Wed, 23 Mar 2022 07:46:17 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id h22-20020a05620a245600b0067d6dae634csm110896qkn.9.2022.03.23.07.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:46:17 -0700 (PDT)
Date:   Wed, 23 Mar 2022 10:46:15 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] tracing: Have trace event string test handle zero length
 strings
Message-ID: <Yjsyt/6OeFSRsmcq@bfoster>
References: <20220323103912.097ad3a8@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323103912.097ad3a8@gandalf.local.home>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:39:12AM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If a trace event has in its TP_printk():
> 
>  "%*.s", len, len ? __get_str(string) : NULL
> 
> It is perfectly valid if len is zero and passing in the NULL.
> Unfortunately, the runtime string check at time of reading the trace sees
> the NULL and flags it as a bad string and produces a WARN_ON().
> 
> Handle this case by passing into the test function if the format has an
> asterisk (star) and if so, if the length is zero, then mark it as safe.
> 
> Link: https://lore.kernel.org/all/YjsWzuw5FbWPrdqq@bfoster/
> 
> Cc: stable@vger.kernel.org
> Reported-by: Brian Foster <bfoster@redhat.com>
> Fixes: 9a6944fee68e2 ("tracing: Add a verifier to check string pointers for trace events")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---

FWIW:

Tested-by: Brian Foster <bfoster@redhat.com>

Thanks for the patch!

>  kernel/trace/trace.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index eb44418574f9..96265a717ca4 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3663,12 +3663,17 @@ static char *trace_iter_expand_format(struct trace_iterator *iter)
>  }
>  
>  /* Returns true if the string is safe to dereference from an event */
> -static bool trace_safe_str(struct trace_iterator *iter, const char *str)
> +static bool trace_safe_str(struct trace_iterator *iter, const char *str,
> +			   bool star, int len)
>  {
>  	unsigned long addr = (unsigned long)str;
>  	struct trace_event *trace_event;
>  	struct trace_event_call *event;
>  
> +	/* Ignore strings with no length */
> +	if (star && !len)
> +		return true;
> +
>  	/* OK if part of the event data */
>  	if ((addr >= (unsigned long)iter->ent) &&
>  	    (addr < (unsigned long)iter->ent + iter->ent_size))
> @@ -3854,7 +3859,7 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
>  		 * instead. See samples/trace_events/trace-events-sample.h
>  		 * for reference.
>  		 */
> -		if (WARN_ONCE(!trace_safe_str(iter, str),
> +		if (WARN_ONCE(!trace_safe_str(iter, str, star, len),
>  			      "fmt: '%s' current_buffer: '%s'",
>  			      fmt, show_buffer(&iter->seq))) {
>  			int ret;
> -- 
> 2.35.1
> 


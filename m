Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691F04B38CC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 02:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbiBMBDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 20:03:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiBMBDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 20:03:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8345060056
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 17:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644714184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ins8sGNc9bHOmwljx/s1vxHKOLJy2EKsmlSrZVMjDnI=;
        b=KB/ayYPJwJXU9XV1XmcHWc4DXjLAo8ZmrHyNnwKJn6HlDhXVJzojxDqKWufIfIto+hvyAz
        y5qjgE+kKcM/uUp2VOGXQ2YQ5i7TuPVeEhOV1w1/wnkdGwhgbesvi4modnGUgC4iruA1D0
        DAESHYDlhvwBcEugmuWUZynSV8+KAkM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-EWumyYTQNR6GhN4usc6kbg-1; Sat, 12 Feb 2022 20:03:02 -0500
X-MC-Unique: EWumyYTQNR6GhN4usc6kbg-1
Received: by mail-ot1-f72.google.com with SMTP id r16-20020a9d7510000000b0059ea94f86eeso7829475otk.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 17:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ins8sGNc9bHOmwljx/s1vxHKOLJy2EKsmlSrZVMjDnI=;
        b=Q19x45m1PenefxM8vOSBRRY+hbXrNzshxm5t2RvXUoF/rhyQgqdBZHQDiUs/jtFIN8
         iuaDZIQ3ysR26DV6BNcmlm9mLgfW204b3QrFWvgCPiALvzWhOrlNIv3szYdn7Q82gV1u
         EEY6td8ENWqCfQjVTCkk5JIMQ1ujrNUeMNmUl0ASKOTlmKbBNcjZ6o84oa+e8Bqfa8vL
         Igb2xYEr2s/MPxtBurcfb33XRseTSLt6PBXWDqtMHxzkZr6AjfLh2JgYxZ2ApQtXiIWS
         9ILPITq258cse2og6ECJ3gOO4GpaEo4yeNqc+H5+yi5JxXFQTEzNay/0HxjovBJfdLfb
         cGfw==
X-Gm-Message-State: AOAM533MA0tk9hu/KX4yotSiebBZrGbRWvmr38gX2xSTkV+bBmK5s3mp
        rfxiLm6Dm5mbkX0ljVIj795YOL35ROPti7EOKFv0cKbV62u9BeEDsAehOxKZ7XNOvf1wR9QdU5h
        ffX+oV2Gpcw53TEXGseTW1cXD
X-Received: by 2002:a05:6830:92:: with SMTP id a18mr2878499oto.373.1644714182192;
        Sat, 12 Feb 2022 17:03:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLlMZslbwgMVP9zAD5/X+Q5Yz8w5PDh7Q9JtMTWNAPu+5FtKAISWKRrI4EwXxFCANNDNkE1w==
X-Received: by 2002:a05:6830:92:: with SMTP id a18mr2878490oto.373.1644714181909;
        Sat, 12 Feb 2022 17:03:01 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id u5sm11273818ooo.46.2022.02.12.17.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 17:03:01 -0800 (PST)
Date:   Sat, 12 Feb 2022 17:02:57 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Justin Forbes <jmforbes@linuxtx.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tools: Fix use-after-free for realloc(..., 0)
Message-ID: <20220213010257.yllouthdbjzawil2@treble>
References: <20220212181855.3460176-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220212181855.3460176-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 10:18:55AM -0800, Kees Cook wrote:
>  static inline void *xrealloc(void *ptr, size_t size)
>  {
> -	void *ret = realloc(ptr, size);
> -	if (!ret && !size)
> -		ret = realloc(ptr, 1);
> +	void *ret;
> +
> +	/*
> +	 * Convert a zero-sized allocation into 1 byte, since
> +	 * realloc(ptr, 0) means free(ptr), but we don't want
> +	 * to release the memory. For a new allocation (when
> +	 * ptr == NULL), avoid triggering NULL-checking error
> +	 * conditions for zero-sized allocations.
> +	 */
> +	if (!size)
> +		size = 1;
> +	ret = realloc(ptr, size);
>  	if (!ret) {
> -		ret = realloc(ptr, size);
> -		if (!ret && !size)
> -			ret = realloc(ptr, 1);
> -		if (!ret)
> -			die("Out of memory, realloc failed");
> +		/*
> +		 * If realloc() fails, the original block is left untouched;
> +		 * it is not freed or moved.
> +		 */
> +		die("Out of memory, realloc failed");

xrealloc() only has two uses -- both via ALLOC_GROW() -- and they don't
rely on the 'size == 0' freeing anyway.  How about simplifying this
further to just:

 	ret = realloc(ptr, size);
  	if (!ret)
		die("Out of memory, realloc failed");

Much easier to grok, and as a bonus, we don't need the long comments :-)

-- 
Josh


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5413147629F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbhLOUHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:07:47 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:34361 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbhLOUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:07:46 -0500
Received: by mail-ot1-f46.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso26310735otj.1;
        Wed, 15 Dec 2021 12:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m0VRlHAZHzoc7igUEoPLwWQFICeOyNMQMaAOAQfBA3w=;
        b=x0m5U6nN8D+RtWxOvlHNJXkBnktgIGduqQkZDNEq2m/IYtrJHeogmXJJRBfVfWr8w8
         cL+9gwdjkRy5C5xJfo/vMeZMubldPy8VexaCOwsn7PmUM7mQYmrBxwA/k6D5g5KY0h/I
         zsVGvAUCHpBsHj4JNWSWrjTGeBSFsb8o2K8KhPp0GNgIspiueeh1pboKi0BvWrYAEg9m
         84lxujre/cJyC32wiuezPteb6JP3g8cOT4Qo6byQHOVhlQN0OFSRJC1Nd4nsMvgAz/RT
         +e4kdCQTzFctJNrihUeBQIvJBqQMmKiOJcTtAtKcWbOx4zqwOddM0pAIMdRf8/uV4XLk
         WdUw==
X-Gm-Message-State: AOAM532HdQj7j4uSh2wN07voi/lIbvfKUmcZIFRZ2k+zbpC6+VZtaea3
        qFfZOsiWAb1p123hwWtJiw==
X-Google-Smtp-Source: ABdhPJzQItzMugL5xHOgJlW79NlBbaijlUk3G6Goo5mJT3P3FxaTxjfmfFA1qcBdNAsTDmD3edUxtw==
X-Received: by 2002:a05:6830:1092:: with SMTP id y18mr9822533oto.119.1639598865134;
        Wed, 15 Dec 2021 12:07:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w25sm631165otq.28.2021.12.15.12.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:07:44 -0800 (PST)
Received: (nullmailer pid 1750441 invoked by uid 1000);
        Wed, 15 Dec 2021 20:07:43 -0000
Date:   Wed, 15 Dec 2021 14:07:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: unneed to initialise statics to 0 or NULL
Message-ID: <YbpLDxhsSW43kMKj@robh.at.kernel.org>
References: <20211212071454.298251-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212071454.298251-1-wangborong@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 03:14:54PM +0800, Jason Wang wrote:
> Static variables do not need to be initialised to 0 or NULL,
> because compilers will initialise all uninitialised statics
> to 0 or NULL. Thus, remove the unneeded initializations.
> 

Not required, but I think it helps statics stand out more as-is.

> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/of/pdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
> index 7eda43c66c91..37d02fcb81d0 100644
> --- a/drivers/of/pdt.c
> +++ b/drivers/of/pdt.c
> @@ -40,7 +40,7 @@ static inline void irq_trans_init(struct device_node *dp) { }
>  
>  static char * __init of_pdt_build_full_name(struct device_node *dp)
>  {
> -	static int failsafe_id = 0; /* for generating unique names on failure */
> +	static int failsafe_id; /* for generating unique names on failure */
>  	const char *name;
>  	char path[256];
>  	char *buf;
> @@ -67,7 +67,7 @@ static struct property * __init of_pdt_build_one_prop(phandle node, char *prev,
>  					       void *special_val,
>  					       int special_len)
>  {
> -	static struct property *tmp = NULL;
> +	static struct property *tmp;
>  	struct property *p;
>  	int err;
>  
> -- 
> 2.34.1
> 
> 

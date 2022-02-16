Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04F64B7EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245547AbiBPDqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:46:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiBPDqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:46:51 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9A9E05
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:46:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u5so1011271ple.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zJZZ+JEvBwB9q8zo9G87rqVvPao4wt79zrPDR0URZQs=;
        b=HjdvhoRwHsPkQ16tNkW2IiyAHMTGDy1+3w54g0ZrhhyJbAjLMoax+rtJaX9WfcPm9K
         MA8m/kKSp7FZwuEAm7LLWpaHORtbYgS4sf8TLNayrH1lloGfrjZEbHQ3YYi4omS0e9iY
         U6N6zDEG3WMxdajDF3z449SYtHJ5mCkoAqMKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zJZZ+JEvBwB9q8zo9G87rqVvPao4wt79zrPDR0URZQs=;
        b=PlMucCJFTLEvKLCTXYrdb4REYBYTpU5IhmftsJcllL/r98A/4Ikvl4yTEOCvNX7VLW
         kkSbTI+H629yF6z+QXRqgQnEdGXpiYp+eiFlF5YxsglnzLmeQD8LKOHLUtbqid6oYjel
         aJWUUja3FBktl1W/XXgddO3mM6LEz8mwrj+U6Z0mgykBUGNJO6lqHsL9yrJvbt4ys1Qz
         TZYjRBY7o+otT4zLSfPghKES0mnHKYBsOG1CLVsQKFUQoaOqBmD9BnMknntK1EfwEk+8
         OiEg7fsxF27GzImYfA/fMlicaxUJNRggg+Vlz84ppjpc0c4z/ul6gf00GgMOT2TXHQZf
         ZPoQ==
X-Gm-Message-State: AOAM532J6fU1SsNHgtpfGUREolHKcVaneD7Q8LHgQNxNLgZtZmY4QwMJ
        qA/XwALa9W9wV91SAb2ObShguw==
X-Google-Smtp-Source: ABdhPJzRWGqn9Ucp2/c4wH++iZR883Ywc2CjfsVHYVzh8jA8DkVyGoPe1vHRXkmEUyQeuk8yzeH7gQ==
X-Received: by 2002:a17:902:988c:b0:14f:2934:6838 with SMTP id s12-20020a170902988c00b0014f29346838mr955950plp.47.1644983199097;
        Tue, 15 Feb 2022 19:46:39 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c926:4ee:add9:bf67])
        by smtp.gmail.com with ESMTPSA id b21sm19923235pji.22.2022.02.15.19.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 19:46:38 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:46:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@google.com,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] printk: make suppress_panic_printk static
Message-ID: <YgxzmSBZv5Q3pS9/@google.com>
References: <20220216031957.9761-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216031957.9761-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/16 11:19), Jiapeng Chong wrote:
> This symbol is not used outside of printk.c, so marks it static.
> 
> Fix the following sparse warning:
> 
> kernel/printk/printk.c:100:19: warning: symbol 'suppress_panic_printk'
> was not declared. Should it be static?
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

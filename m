Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C91954D8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356563AbiFPDA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355750AbiFPDAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:00:21 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A45A2C3;
        Wed, 15 Jun 2022 20:00:20 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id s37so293663pfg.11;
        Wed, 15 Jun 2022 20:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kLu0AyZbwG8o8hfD/fv5Wh7BJxHL6y7f8uHQKEJJV6U=;
        b=k3iAfz3repC7wE79wV5V9jmg7OTywTvZQCS6xd/4rdeiVtRUs0zT9HlIgTw3IePSeR
         RhNy43WOSAVQPzquN2IkpzIK3DaNPvyghrQKhV8EtL9nTDjnZy8dostvB+cHEdQec+fH
         Tg1u+9a5gEZUfGxYUqUF6kAk5XJIloDHXEtwOmprLD96Cc4f1TaWyTuKpc7UPOlpIbTh
         TUyqq8jlRcHsWcnv4FUU3SpHDTyMi7ZzI1cAKHqppeeoQ91cGVaHIuBafjPSSwXfdMDm
         RrJVihVqm/2zPKAfCvC1Z3fboamcD/gW9o/naihh9dpTp6dWE8IuYZ86uc7S1O7XDPmP
         XF/A==
X-Gm-Message-State: AJIora/hGBWpHXq9W1K2Y/z6dQ+HtYNyZaHKLTZzo+xs0Hs3aFn0PFqO
        4qPQQBd5g1Po6nc3QnU1++4=
X-Google-Smtp-Source: AGRyM1uRqJci6ZIfCJSBxo3jFrvP6GWbLFgj40m+japCby9a0CiFohY8D+yndlsBrHLluXlD0d2bTA==
X-Received: by 2002:a63:8a42:0:b0:3fc:f8b5:291f with SMTP id y63-20020a638a42000000b003fcf8b5291fmr2547392pgd.550.1655348420055;
        Wed, 15 Jun 2022 20:00:20 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id fu13-20020a17090ad18d00b001cb6527ca39sm2582309pjb.0.2022.06.15.20.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 20:00:19 -0700 (PDT)
Message-ID: <7fd6f544-0bd2-62fe-bddd-869364f351e8@acm.org>
Date:   Wed, 15 Jun 2022 20:00:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 3/8] block: use new capable_any functionality
Content-Language: en-US
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Serge Hallyn <serge@hallyn.com>,
        Alistair Delva <adelva@google.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com>
 <20220615152623.311223-2-cgzones@googlemail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220615152623.311223-2-cgzones@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 08:26, Christian Göttsche wrote:
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.
> 
> Reorder CAP_SYS_ADMIN last.
> 
> Fixes: 94c4b4fd25e6 ("block: Check ADMIN before NICE for IOPRIO_CLASS_RT")
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3:
>     rename to capable_any()
> ---
>   block/ioprio.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 2fe068fcaad5..6441c052f837 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -37,14 +37,7 @@ int ioprio_check_cap(int ioprio)
>   
>   	switch (class) {
>   		case IOPRIO_CLASS_RT:
> -			/*
> -			 * Originally this only checked for CAP_SYS_ADMIN,
> -			 * which was implicitly allowed for pid 0 by security
> -			 * modules such as SELinux. Make sure we check
> -			 * CAP_SYS_ADMIN first to avoid a denial/avc for
> -			 * possibly missing CAP_SYS_NICE permission.
> -			 */
> -			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
> +			if (!capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN))
>   				return -EPERM;
>   			fallthrough;
>   			/* rt has prio field too */

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

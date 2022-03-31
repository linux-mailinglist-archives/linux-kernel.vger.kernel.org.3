Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67384ED18F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241434AbiCaCO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiCaCOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:14:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B7A66625
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:12:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so2217400pjm.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23XfkAHDqNFtL26bKDov8Qbam5dCiK7y19fMRZBdXt4=;
        b=qm67aC678igD9cDL/UrGvx7xNWfMGdlcX6eDKXldXuN9aExMlgo1sI9rARaUib4H6D
         0f1Zgv0E2nMHMYwOy8Rd34T6IHiVubFzpPzNipSggMDDmDvN9FYHLu8TCeyMooewNklG
         BDYcTh5Blw9PJdZ8DMO4orLOpxYFckL+ZN/vPMzEpp3AM/3Y7bFP/h3eN4XwLFY3c9pR
         Xl+8wmV7U9V7JSWGwcK67PHf6TgGUAvWJGQ1BmQeyEi0+LzMWzkc3sKhqYGBi6rAvKVn
         56Co8QllBFAv48GN4E8Vl85AQKC8rdQb/2Vz0TVAtIEBQmJjmF1U7afzRhri234sZ83r
         SVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=23XfkAHDqNFtL26bKDov8Qbam5dCiK7y19fMRZBdXt4=;
        b=iUOGmNblyC5zKQRIZfiw/iRxSpQIxmeoYCO3XTFN8Y4YF7Rl7mKqGXaOeAGNCLCq7l
         ij7fUKFl9I61YZvduKG0qSLYCXJ7boeR5BZF98WW6fL8eB6k1U0m8SyU39QZsuQTXjL8
         JVyiwjvX1BsWZBjILcDFPzUe0ftgiXsI6LZpkEvmApgHIn+MQVd41yge5d6AagMeGw1/
         s4D06y8vyMXmc8jMgQJLOy0W32qza8L/d5eJK8Rqv7uznthfVV6wm2Ofsss7RWtrWgyS
         sNEbKsB72Q9DmkOvd8Oyc8GSAnG88x6RgXux5BqnIG7NXIIbU83VwMneVoaHLoBbmpUZ
         G0aA==
X-Gm-Message-State: AOAM532pU9dFjshy5OraTaiMZ+E0n1mPm6RCPoHNT6B3lc56ADLo8FM7
        ZC6DrHrFfDMpzVwYVEPPvQVVRw==
X-Google-Smtp-Source: ABdhPJy9CjLfyqEnfds3s+9ym0N2LGlzWw/ZN+JoBZJV9H6hqL+LC4pVIxa3u/7cj8q6KKt7N2940A==
X-Received: by 2002:a17:90b:4b88:b0:1c7:666e:7edb with SMTP id lr8-20020a17090b4b8800b001c7666e7edbmr3251434pjb.41.1648692757155;
        Wed, 30 Mar 2022 19:12:37 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id v8-20020a056a00148800b004fa9bd7ddc9sm25067522pfu.113.2022.03.30.19.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:12:36 -0700 (PDT)
Date:   Thu, 31 Mar 2022 07:42:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: use list iterator only inside the loop
Message-ID: <20220331021235.bhb4t2g43eva3c3s@vireshk-i7>
References: <20220331015818.28045-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331015818.28045-1-xiam0nd.tong@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaomeng,

On 31-03-22, 09:58, Xiaomeng Tong wrote:
>     dev = new_dev->dev;

Why is this added here ?

> 
> As discussed before,

Please remember that whatever you write here will go in the commit
logs for ever and no one will ever know what you discussed and with
whom.

This area should describe the problem at hand.

> we should avoid to use a list iterator variable
> outside the loop which is considered harmful[1].
> 
> In this case, use a new variable 'iter' as the list iterator, while
> use the old variable 'new_dev' as a dedicated pointer to point to the
> found entry.
> 
> [1]:  https://lkml.org/lkml/2022/2/17/1032
> 
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  drivers/opp/debugfs.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index 596c185b5dda..a4476985e4ce 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -187,14 +187,19 @@ void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
>  static void opp_migrate_dentry(struct opp_device *opp_dev,
>  			       struct opp_table *opp_table)
>  {
> -	struct opp_device *new_dev;
> +	struct opp_device *new_dev = NULL, *iter;
>  	const struct device *dev;
>  	struct dentry *dentry;
>  
>  	/* Look for next opp-dev */
> -	list_for_each_entry(new_dev, &opp_table->dev_list, node)
> -		if (new_dev != opp_dev)
> +	list_for_each_entry(iter, &opp_table->dev_list, node)
> +		if (iter != opp_dev) {
> +			new_dev = iter;
>  			break;
> +		}
> +
> +	if (!new_dev)

I will rather make this BUG_ON(!new_dev);

> +		return;
>  
>  	/* new_dev is guaranteed to be valid here */
>  	dev = new_dev->dev;


-- 
viresh

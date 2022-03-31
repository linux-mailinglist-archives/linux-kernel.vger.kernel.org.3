Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74B4ED1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiCaCyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiCaCyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:54:36 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69595111DF0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:52:44 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t4so15856859pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PYuCQIvuD74pqIke58Nyk48QUD+/IoXOla1cm+PGYVY=;
        b=hOOvNdihbsPP0Nxr6SkheJbdoeJzJ/yyoY42Rvw6MwDxI6QRNXPYLThSsB8bvTWCyo
         HjaXt9EW3kae+oo+kV1WgcwFd3HufMJHM0S5YiBrmA2fOSvo0EWOyR6TnsOUEXdOKPVw
         GalyzJgwVeeHR9Jm+wILSPvJxFQ9hnS/IkwgoVemWNaeQv4/gthiXm7QSrAEQHWozUfm
         eukbz83KDu6zo8KyCwipjDAWhA9wzjDy9ZZ+JoxSmPi8ANT3h3MROsQyakvoDMldSEEx
         DqlDDn822DjnOUbVguWqaxZZ6ESmv/GTJEd2uASr8mxZpZxe1bwOvnmK2lwbnIdzj7Rx
         4NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PYuCQIvuD74pqIke58Nyk48QUD+/IoXOla1cm+PGYVY=;
        b=Y9ylrGZrXV4D+aVOzwGxAvGV0OAvU9wCTiQZfdu3Ye7vJNG7kdr2ZguMp7d+te34ZU
         GBTQtmc/pB9XOVr8pvPaZZvcJt/CHl0O5n8La9+Jj1J2sWRUQExHFrDg1NPYTh8bVGKu
         ksNLUzbRGMzsNiHdukmyj5aitwcilVu8f7jjfwldMSSAj92wrRaN3jfuhKjP0DYahk4/
         qZ75xOmWqMv1S9xFwL+WZ0FBjxS/WD/lTKllgD7zvsd1BfcsVbgXNIc7tFqvCy9jHEj7
         a0Rg89Y4zEQX0Jh5KBFz2wcT3OPu8atZF6ZamsqwvsJ9tJGsrrdvERJvi9QZHKuc09gg
         LDUA==
X-Gm-Message-State: AOAM5312fpdTju0hhtLgPzZX0VQTdMZu1zoqG82htEFnloIxJ1EFkAx1
        HMlnKfwhXZNyrH2RaMwnc6ZlQratMWVReA==
X-Google-Smtp-Source: ABdhPJwRX/OnGSaAmRsG3TAjUqrDjnoNgZl+Dw9mNkJ2g2ay234Usz0Um3HtxwAWBPxWy1BU9pQK3w==
X-Received: by 2002:a63:770c:0:b0:386:361f:ecce with SMTP id s12-20020a63770c000000b00386361feccemr8852405pgc.202.1648694949570;
        Wed, 30 Mar 2022 19:49:09 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a0026ca00b004fb44e0cb17sm14937316pfw.116.2022.03.30.19.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:49:09 -0700 (PDT)
Date:   Thu, 31 Mar 2022 08:19:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] opp: use list iterator only inside the loop
Message-ID: <20220331024906.i7ucvoxrkkfpb6w5@vireshk-i7>
References: <20220331023608.30497-1-xiam0nd.tong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331023608.30497-1-xiam0nd.tong@gmail.com>
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

On 31-03-22, 10:36, Xiaomeng Tong wrote:
> The list iterator 'new_dev' will point to a bogus position containing
> HEAD if any one of these conditions is possible: the list is empty or
> no element is found, thus can potentially lead to an invalid memory
> access in 'dev = new_dev->dev;'.

There is no such bug as I explained earlier, why you added this again
despite being discussed ?

> As discussed before,

I just told you not to use such language as this will go in logs, but
you still chose to add it :(

> we should avoid to use a list iterator variable
> outside the loop which is considered harmful[1].
> 
> In this case, use a new variable 'iter' as the list iterator, while
> use the old variable 'new_dev' as a dedicated pointer to point to the
> found entry. And BUG_ON(!new_dev);.

Please look at this on how to write the log, which fixes a very
similar problem.

https://lore.kernel.org/all/20220324071815.61405-1-jakobkoschel@gmail.com/

> 
> [1]:  https://lkml.org/lkml/2022/2/17/1032
> 
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
> 
> changes since v1:
>  - use BUG_ON(!new_dev); instead of return; (Viresh Kumar)
> 
> v1: https://lore.kernel.org/lkml/20220331015818.28045-1-xiam0nd.tong@gmail.com/
> 
> ---
>  drivers/opp/debugfs.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index 596c185b5dda..81b2bc4b5f43 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -187,14 +187,18 @@ void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
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
> +	BUG_ON(!new_dev);
>  
>  	/* new_dev is guaranteed to be valid here */
>  	dev = new_dev->dev;
> -- 
> 2.17.1

-- 
viresh

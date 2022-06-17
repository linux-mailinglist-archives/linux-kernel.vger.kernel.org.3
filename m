Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9679554FF41
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiFQVR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbiFQVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:17:24 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A50A20BDB;
        Fri, 17 Jun 2022 14:17:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i15so4876425plr.1;
        Fri, 17 Jun 2022 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AYFvbP/LdnwHfGvJorDKl6IhipOxX+onTGL/S3ZVCIg=;
        b=XZ/ACFYwOvqutcWmxBGbIbMauQBFuz5Zx28aTEUiE07E1U8TxwKcH8uPsJWVf9bXkK
         qo+sibSIV6EiCtjOXeogb661GcWpCmxEF7CtC5XEBgVMRJV/isy6ZTOKQKrCmtUXAfak
         C/+iHIsGmMq07Gatk7ASZ7PkkE094HcNThVvCbnCDrFGOeyKkeTOHwMQTpQNkZwvjAuu
         G4leSzOTX3C9taQfSaswz1eXp+2UghFHVUi9m4+XTOA4ajZ84QPQG16vCj3ehkRYZ8kI
         qzyqh0LOHdsmpWvWJeOeas+MRqBiwTUTpT+cjaoR9dYk1tZmYu/FiFk/ZrriW1tAwTDQ
         hDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AYFvbP/LdnwHfGvJorDKl6IhipOxX+onTGL/S3ZVCIg=;
        b=awKEgmLRLmhHVSt6No1qovZOrPXJEXfM1nzxrE8Tl/X5hwfLrGTCrTHyNRyn3Lvnri
         YQKvpTWpuLHGt/YlNVnL9y1ScjcxgKsoc8C9ZEJhYk0Wwzk58Wd3vR+z1CiNKTvzlWDL
         xRgMo2Vh6+Ymxte5tsmGmqsCOKU5AeCxX2qwwz8D7wFg6W/PyH+es1I402B4fQ/Z3BfI
         4nvS3cY1HJgEOgF8UeKOJY+WZSeiLwB+YqDF5qiGqWx/QausiEmUP2/nLWvQVPdXW66I
         O/0NAoxDprV6vof9m9KcVZ9eJQJzaAxAbpKnXc9W5KeLITy3nCOd+gjyJeAJBZ69O7iE
         2HUg==
X-Gm-Message-State: AJIora/Jhi4Lh5pn4O33bm9gE2hBAuCLkNTC+R5ThR4Zkmv6LFFsYr3Z
        IcgW8Ga1OfWPDOaRwp9KtoiZGIzGhsk=
X-Google-Smtp-Source: AGRyM1sgwhhem1uZHnvfzEJpbDWDQNxT5VRPqkGIkm8OL+Gc061z29B6qTti6ac80rq+BRMp1ifiug==
X-Received: by 2002:a17:90a:5409:b0:1e8:664e:41dd with SMTP id z9-20020a17090a540900b001e8664e41ddmr12693514pjh.173.1655500641015;
        Fri, 17 Jun 2022 14:17:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3-20020a17090a8d0300b001ec84049064sm321238pjo.41.2022.06.17.14.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 14:17:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 17 Jun 2022 14:17:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Liang He <windhl@126.com>
Cc:     tharvey@gateworks.com, rjones@gateworks.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (gsc-hwmon) Add missing of_node_put()
Message-ID: <20220617211719.GA632482@roeck-us.net>
References: <20220616114024.3985770-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616114024.3985770-1-windhl@126.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 07:40:24PM +0800, Liang He wrote:
> In gsc_hwmon_get_devtree_pdata(), of_find_compatible_node() will return
> a node pointer with refcount incremented. We should use of_node_put() in
> fail path or when it is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/gsc-hwmon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> index 1fe37418ff46..d64be48f1ef6 100644
> --- a/drivers/hwmon/gsc-hwmon.c
> +++ b/drivers/hwmon/gsc-hwmon.c
> @@ -269,10 +269,13 @@ gsc_hwmon_get_devtree_pdata(struct device *dev)
>  	/* fan controller base address */
>  	fan = of_find_compatible_node(dev->parent->of_node, NULL, "gw,gsc-fan");
>  	if (fan && of_property_read_u32(fan, "reg", &pdata->fan_base)) {
> +		of_node_put(fan);
>  		dev_err(dev, "fan node without base\n");
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	of_node_put(fan);
> +
>  	/* allocate structures for channels and count instances of each type */
>  	device_for_each_child_node(dev, child) {
>  		if (fwnode_property_read_string(child, "label", &ch->name)) {

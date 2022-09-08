Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCDB5B262C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiIHSuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiIHSt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:49:56 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2898C03C;
        Thu,  8 Sep 2022 11:49:53 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s206so17601727pgs.3;
        Thu, 08 Sep 2022 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=tJTwU4stupW8LHT+ZyN0zQCc5o/+KAr70ucKLAwyn7k=;
        b=TzysSwcbkYenIlokh8kQco3QIGs7ps1wA9TKybuAyhI+dWuEiy/p8plwELhN9NEkMo
         gVOVnRThI+UjBo7Nel93fHX3ew1chrv2UijXR83IuWUipXoNzVi8uTRm0bmlMXkPpocd
         b5MMzbCARCWWspXUkwKp81mcgiUyxJ/ZLFJYuypiT7xHX80BJsjK0/rCZ0TdAwNot0S4
         MgpdkNKvXF/PpDCflsgq4+o9WKPW6bhIIJOZdzIpNJld9kqY0IDZ+ZUjjzEUI5BET/M+
         ua/GDG1orPPCYK6vixsUMQYDvZ8WSh9NWiV/b+Zca41gzj6TpVDkNZw4syJeyZvJr7ZE
         FDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tJTwU4stupW8LHT+ZyN0zQCc5o/+KAr70ucKLAwyn7k=;
        b=4F+x2ADRCLFdM2nHMHipLy4WF09Uc/aRhn2E5LW34Wa2cu8V2EZmvWXdTe1Q+koAfU
         K0vsRF69saSeTYeRbbpUI0TNN3XW74BETsVYCPSerN39sITFyhjs8ivNWczpbgf2LrJX
         cDjnKUDGlxG/Gj4TTZbIxxSDhs+6HgKxkqtIXEzMqcDv0isZS+/JJjcfLmIdiNjVO3qK
         wXoK6gdmZQ2cyMW5ny+XJYDARa5GHufahGsPb964PqDFc9qKRAuqkemakrdsIy3uTUDn
         o9acJkAt/7Mu3ZB8lH9ryOYWc6tI1M7hI3Bms80mjRD2VJDzfzS/nJQzFrbdXkVEi7Rd
         D0hQ==
X-Gm-Message-State: ACgBeo26dMbkPqVtlU9/JCQ0JbDlI7Vo/ZJVdvHckV3fpQmClZcVVi6S
        ATQkA8//p8L8IoS64TBsH4yRIvit1eyVhA==
X-Google-Smtp-Source: AA6agR65KK4K4Qyp3j4pikU0YAtfTtI6KYQctfgMjhTGVte+r4H5EvUi1yAWGf4hTXqcQSMxerb9rA==
X-Received: by 2002:a05:6a00:21c8:b0:52e:3404:eba5 with SMTP id t8-20020a056a0021c800b0052e3404eba5mr10435950pfj.67.1662662991469;
        Thu, 08 Sep 2022 11:49:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id nd15-20020a17090b4ccf00b002006f8e7688sm2117124pjb.32.2022.09.08.11.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 11:49:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 8 Sep 2022 11:49:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, robert.marko@sartura.hr,
        luka.perkov@sartura.hr, jdelvare@suse.com, dev@aboehler.at,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: (tps23861) create unique debugfs directory
 per device
Message-ID: <20220908184949.GA3191400@roeck-us.net>
References: <20220907015405.16547-1-mr.nuke.me@gmail.com>
 <20220907015405.16547-2-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907015405.16547-2-mr.nuke.me@gmail.com>
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

On Tue, Sep 06, 2022 at 08:54:05PM -0500, Alexandru Gagniuc wrote:
> On systems with more than one tps23861, creating the debugfs directory
> for additional devices fails with
> 
>     debugfs: Directory 'tps23861' with parent '/' already present!
> 
> To resolve this, include the hwmon device name in the directory name.
> Since the name is unique, this guarantees that the debugfs directory
> is unique.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/tps23861.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
> index 019009b71a90..a3d7d6b75a26 100644
> --- a/drivers/hwmon/tps23861.c
> +++ b/drivers/hwmon/tps23861.c
> @@ -503,9 +503,17 @@ static int tps23861_port_status_show(struct seq_file *s, void *data)
>  
>  DEFINE_SHOW_ATTRIBUTE(tps23861_port_status);
>  
> -static void tps23861_init_debugfs(struct tps23861_data *data)
> +static void tps23861_init_debugfs(struct tps23861_data *data,
> +				  struct device *hwmon_dev)
>  {
> -	data->debugfs_dir = debugfs_create_dir(data->client->name, NULL);
> +	const char *debugfs_name;
> +
> +	debugfs_name = devm_kasprintf(&data->client->dev, GFP_KERNEL, "%s-%s",
> +				      data->client->name, dev_name(hwmon_dev));
> +	if (!debugfs_name)
> +		return;
> +
> +	data->debugfs_dir = debugfs_create_dir(debugfs_name, NULL);
>  
>  	debugfs_create_file("port_status",
>  			    0400,
> @@ -554,7 +562,7 @@ static int tps23861_probe(struct i2c_client *client)
>  	if (IS_ERR(hwmon_dev))
>  		return PTR_ERR(hwmon_dev);
>  
> -	tps23861_init_debugfs(data);
> +	tps23861_init_debugfs(data, hwmon_dev);
>  
>  	return 0;
>  }

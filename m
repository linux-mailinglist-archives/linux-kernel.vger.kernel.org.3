Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC3E518372
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiECLti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiECLtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:49:36 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE95534BA7;
        Tue,  3 May 2022 04:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1651578364;
  x=1683114364;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=37MI/EE6FV3uuqjHcV4iKuHw8/hQcJzCqhGsyjlBzV4=;
  b=j5YBHC/3HUmAXy2banMBdXMmSjrBK21wrDlxdXNIOn4MrPzNOAyHklGI
   e4w3KCeFHeYOYspRyQ/MPYIvg2ZkwSkjaYYwUznQk2OqJN6t8LiKrfUOm
   xWx1sI1O53yim0wOab6vYvNC/BlxEPetb2AWdjWTKjaZFe4wtlKvmNPAs
   PdcM+Mucc4iBESBijkATLODZOJ8LyKIB/ep/5/t+ICXml0HnDzTs5TDD0
   9d6swFvIMxKH0a1+YnBOFOFSeqtkM6sn+5MSx+5sjKkkRDPwRWEAg1VLv
   PcDk6EZ7w5WJlstPi7NuWcukvX1/zlEg30vMKmt1HQpnUiAHlQRv5tQmj
   g==;
Message-ID: <07415a07-58e1-2190-2c8a-be7fb7756400@axis.com>
Date:   Tue, 3 May 2022 13:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3] hwmon: (tmp401) Add OF device ID table
Content-Language: en-US
To:     Camel Guo <Camel.Guo@axis.com>, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
CC:     Javier Martinez Canillas <javierm@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
References: <20220503053350.598031-1-camel.guo@axis.com>
From:   Camel Guo <camelg@axis.com>
In-Reply-To: <20220503053350.598031-1-camel.guo@axis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail07w.axis.com (10.20.40.13) To se-mail03w.axis.com
 (10.20.40.9)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/22 07:33, Camel Guo wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
> 
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.
> 
> Fixes: af503716ac14 ("i2c: core: report OF style module alias for 
> devices registered via OF")
> Signed-off-by: Camel Guo <camel.guo@axis.com>
> ---
> 
> Notes:
>      v3:
>       - Copy commit message from commit 72fc64c68decf119466 ("hwmon: 
> (tmp103)
>         Add OF device ID table")
>       - Add Fixes tag
>      v2:
>       - Put evidence and circumstances in commit message
> 
>   drivers/hwmon/tmp401.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/hwmon/tmp401.c b/drivers/hwmon/tmp401.c
> index b86d9df7105d..52c9e7d3f2ae 100644
> --- a/drivers/hwmon/tmp401.c
> +++ b/drivers/hwmon/tmp401.c
> @@ -708,10 +708,21 @@ static int tmp401_probe(struct i2c_client *client)
>           return 0;
>   }
> 
> +static const struct of_device_id __maybe_unused tmp4xx_of_match[] = {
> +       { .compatible = "ti,tmp401", },
> +       { .compatible = "ti,tmp411", },
> +       { .compatible = "ti,tmp431", },
> +       { .compatible = "ti,tmp432", },
> +       { .compatible = "ti,tmp435", },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, tmp4xx_of_match);
> +
>   static struct i2c_driver tmp401_driver = {
>           .class          = I2C_CLASS_HWMON,
>           .driver = {
>                   .name   = "tmp401",
> +               .of_match_table = of_match_ptr(tmp4xx_of_match),
>           },
>           .probe_new      = tmp401_probe,
>           .id_table       = tmp401_id,
> 
> base-commit: 38d741cb70b30741c0e802cbed7bd9cf4fd15fa4
> -- 
> 2.30.2
> 

Sorry for the spam, but after rethinking, I think some description in 
commit message is improper. Hence I updated it in v4. Please review that 
one instead.

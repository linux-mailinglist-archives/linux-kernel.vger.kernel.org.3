Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C703650B872
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447973AbiDVNal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447968AbiDVNaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:30:39 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57572583B3;
        Fri, 22 Apr 2022 06:27:45 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s16so9081805oie.0;
        Fri, 22 Apr 2022 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7wD/67zFN01OLjk/4ayvCobKKh+EpoxVKPJMMkQWRKI=;
        b=cHmV5J4YqPlLXRoviT4VhtrfOzmgaQtvuq3zeGMbQrXja5Cp481sDGvN5TiVtmve48
         v8dHMZGXsmi0kLN76djZKrxStvINgxF8l1Z3/cm6Pij73tlg7u966jf57MhMel4hFYJ3
         sYsXiouAZKYCeyY7ogUNIqmcmcF5K+V4j3au6OkS0o9PC9VArkWISnEXsJ2knO0mAk4m
         qvFQcRDC1h0vROh/Ya4dDQM7bhKLyH7UkxkWvY9+gMi/JQfuo6kJAUlMD5uYJOWYaGpn
         kEnrkMpaq0TjGsASQlKH9/0SiHrnq6BdwyqZk0v1zDv6/cT+2kxuVE4E3H4mj3XXiD0z
         kGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7wD/67zFN01OLjk/4ayvCobKKh+EpoxVKPJMMkQWRKI=;
        b=VhVFMWTnhlgsEcn1R1TjsjXxFe0QyJqhiwaji9rYQuQjbGStLvTMTinNcDk+wUO8ix
         k4OIqJ1JIF0gQd/owhYR1HMYLlEVdfkzG96arNYi/TI12ppHGYFY0kBtya+jLuJaspYS
         TN5U9CyTndMJRJjVjZT9i6K/qRrqGVOcOq76JBqsy7e+WZgyqYypRKAzf7on+b9g0QSK
         De0JbqOWjBCC+soqeyRzmO6gLLtwrXLpYTDEh6h8vdiDkW6cAogjuBvY7C08Gbll1Esy
         KbLUQgPVkzPucGk96WmJBwezXvYYNrPIPKcln+/ZcHabworAS5D7vv3Q/yGbIhjU9zp9
         TAsA==
X-Gm-Message-State: AOAM532PHepwFk34EtYLBIBenDMj8SdIVjFrq9p7g2jEVxJve5pZwxT8
        c65NshihBPhv5opW3zjM5GM=
X-Google-Smtp-Source: ABdhPJxHjKtY6ERH3y1gOTMOcM1o8bf8FqSjwSMj7qG2kbasaAzJuxduFyyUS72VE+pRqoAjXS6WLw==
X-Received: by 2002:a05:6808:130f:b0:323:1fd5:f381 with SMTP id y15-20020a056808130f00b003231fd5f381mr2968287oiv.121.1650634065336;
        Fri, 22 Apr 2022 06:27:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a11-20020a056830008b00b0060546411473sm705186oto.75.2022.04.22.06.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 06:27:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3896f884-56d9-d0d9-efe6-839c7431e6de@roeck-us.net>
Date:   Fri, 22 Apr 2022 06:27:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 00/20] hwmon: check return value after calling
 platform_get_resource()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Cc:     jdelvare@suse.com
References: <20220422091207.4034406-1-yangyingliang@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220422091207.4034406-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 02:11, Yang Yingliang wrote:
> This patcheset add check after calling platform_get_resource to avoid null-ptr-deref
> in drivers/hwmon/.
> 
> Yang Yingliang (20):
>    hwmon: (abituguru) check return value after calling
>      platform_get_resource()
>    hwmon: (abituguru3) check return value after calling
>      platform_get_resource()
>    hwmon: (dme1737) check return value after calling
>      platform_get_resource()
>    hwmon: (f71805f) check return value after calling
>      platform_get_resource()
>    hwmon: (f71882fg) check return value after calling
>      platform_get_resource()
>    hwmon: (it87) check return value after calling platform_get_resource()
>    hwmon: (lm78) check return value after calling platform_get_resource()
>    hwmon: (nct6683) check return value after calling
>      platform_get_resource()
>    hwmon: (nct6775) check return value after calling
>      platform_get_resource()
>    hwmon: (sch5627) check return value after calling
>      platform_get_resource()
>    hwmon: (sch5636) check return value after calling
>      platform_get_resource()
>    hwmon: (sis5595) check return value after calling
>      platform_get_resource()
>    hwmon: (smsc47b397) check return value after calling
>      platform_get_resource()
>    hwmon: (smsc47m1) check return value after calling
>      platform_get_resource()
>    hwmon: (via686a) check return value after calling
>      platform_get_resource()
>    hwmon: (vt1211) check return value after calling
>      platform_get_resource()
>    hwmon: (vt8231) check return value after calling
>      platform_get_resource()
>    hwmon: (w83627ehf) check return value after calling
>      platform_get_resource()
>    hwmon: (w83627hf) check return value after calling
>      platform_get_resource()
>    hwmon: (w83781d) check return value after calling
>      platform_get_resource()
> 
>   drivers/hwmon/abituguru.c  | 6 +++++-
>   drivers/hwmon/abituguru3.c | 6 +++++-
>   drivers/hwmon/dme1737.c    | 2 ++
>   drivers/hwmon/f71805f.c    | 2 ++
>   drivers/hwmon/f71882fg.c   | 6 +++++-
>   drivers/hwmon/it87.c       | 2 ++
>   drivers/hwmon/lm78.c       | 2 ++
>   drivers/hwmon/nct6683.c    | 2 ++
>   drivers/hwmon/nct6775.c    | 2 ++
>   drivers/hwmon/sch5627.c    | 6 +++++-
>   drivers/hwmon/sch5636.c    | 6 +++++-
>   drivers/hwmon/sis5595.c    | 2 ++
>   drivers/hwmon/smsc47b397.c | 2 ++
>   drivers/hwmon/smsc47m1.c   | 2 ++
>   drivers/hwmon/via686a.c    | 2 ++
>   drivers/hwmon/vt1211.c     | 2 ++
>   drivers/hwmon/vt8231.c     | 2 ++
>   drivers/hwmon/w83627ehf.c  | 2 ++
>   drivers/hwmon/w83627hf.c   | 2 ++
>   drivers/hwmon/w83781d.c    | 2 ++
>   20 files changed, 55 insertions(+), 5 deletions(-)
> 

This series solves a problem which does not exist in reality and is only theoretic.
The devices are instantiated from their init functions which always adds the resource.
Please do not submit such patches.

Guenter

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1971D50CFAC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 06:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbiDXE51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 00:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiDXE5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 00:57:22 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1035A1759D4;
        Sat, 23 Apr 2022 21:54:23 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id v12-20020a9d7d0c000000b006054b51c3d4so8517552otn.8;
        Sat, 23 Apr 2022 21:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iZlWRIHwaUXUOxN31m6d5GIwgcMFtRtOwVPfSB7BNkQ=;
        b=UuqoykSaJdeKVO8w8ScxnhtSQ3IFQZqaCvMLZXjxAyDXui49vZoOkNVPVPFlNexZQx
         cjQHaI6cSn4O59PFZ5yK5ltRF1ODwnO2X97SuipzSYHAIN6MpYp6yknn2Q4tH301shgR
         nc0A0at+XGR1iMG0zDGvPNscNin6Zm5hMINYmy+zX8lmS7bgV6yhOv1lovnlHve+Sl0b
         exlqX4DSi5PPzW5oPstFxzFr8Pa1y/unlrqTU7k/CkR3WxWbIHjuF1hGUEgADZ8qbVGs
         HFQlj8G8NqbX0V6wnJpNQaZ6H4+AOkM3/rv5Ib5Sv7egLDODXXgXSiRELXAMg1sqCpiN
         5mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iZlWRIHwaUXUOxN31m6d5GIwgcMFtRtOwVPfSB7BNkQ=;
        b=MX7NHuyRwpxNKFpQ4q0doKrIgiNgy3T9FqOx85ToaCohkHjq/6f86jL7ptjRmCJe9y
         Zpqzo7JVFYxL2lwgMxtprjQ29/uLvryz5xfGCno/d7aUonmlpgVLVO53/c7Eivr1n6WC
         oifdt7j/jC+QLBnGylLqBR8gCE7vBdMJYltsxfUGxK3EYjESfXoTqoRJwmmV6TWttZdZ
         w5QlhDkTQPtoKmOB1+J8XDZKkz4TQc2E0eOSE++BtIfB0FkmyutnhLzQEjR4cRDCp0DR
         PU5of9ZkfUF0Mzhu2bT1x8PLmGIa/5P3ik51ROL48JZp211aV2UyguOt1OccQyxLYhry
         EQwA==
X-Gm-Message-State: AOAM532NvrsSIBAi8+5lCEpEBu4jEOM92FzdRy22CjxmKbRB8Y0K98IC
        7yS07izlZaVn0hZBL2M+ODvlt/x3hMo=
X-Google-Smtp-Source: ABdhPJx8mXw/Q+AWtxdQMZAqjVOnFjeKGLovtMjfOax21slcp1e3tXZwQinckxoQxyLDlud6esXScQ==
X-Received: by 2002:a9d:5d15:0:b0:605:5632:1ea5 with SMTP id b21-20020a9d5d15000000b0060556321ea5mr4502984oti.341.1650776061705;
        Sat, 23 Apr 2022 21:54:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x2-20020a4a2a42000000b0033a3c4392c3sm2761165oox.26.2022.04.23.21.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 21:54:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e6fdd042-a84e-ef0d-a042-df04c3fb84e1@roeck-us.net>
Date:   Sat, 23 Apr 2022 21:54:16 -0700
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
 <3896f884-56d9-d0d9-efe6-839c7431e6de@roeck-us.net>
 <c40e9bff-e28c-58c3-dc09-1a10f24ad440@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <c40e9bff-e28c-58c3-dc09-1a10f24ad440@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/22 20:35, Yang Yingliang wrote:
> Hi,
> 
> On 2022/4/22 21:27, Guenter Roeck wrote:
>> On 4/22/22 02:11, Yang Yingliang wrote:
>>> This patcheset add check after calling platform_get_resource to avoid null-ptr-deref
>>> in drivers/hwmon/.
>>>
>>> Yang Yingliang (20):
>>>    hwmon: (abituguru) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (abituguru3) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (dme1737) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (f71805f) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (f71882fg) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (it87) check return value after calling platform_get_resource()
>>>    hwmon: (lm78) check return value after calling platform_get_resource()
>>>    hwmon: (nct6683) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (nct6775) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (sch5627) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (sch5636) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (sis5595) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (smsc47b397) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (smsc47m1) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (via686a) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (vt1211) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (vt8231) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (w83627ehf) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (w83627hf) check return value after calling
>>>      platform_get_resource()
>>>    hwmon: (w83781d) check return value after calling
>>>      platform_get_resource()
>>>
>>>   drivers/hwmon/abituguru.c  | 6 +++++-
>>>   drivers/hwmon/abituguru3.c | 6 +++++-
>>>   drivers/hwmon/dme1737.c    | 2 ++
>>>   drivers/hwmon/f71805f.c    | 2 ++
>>>   drivers/hwmon/f71882fg.c   | 6 +++++-
>>>   drivers/hwmon/it87.c       | 2 ++
>>>   drivers/hwmon/lm78.c       | 2 ++
>>>   drivers/hwmon/nct6683.c    | 2 ++
>>>   drivers/hwmon/nct6775.c    | 2 ++
>>>   drivers/hwmon/sch5627.c    | 6 +++++-
>>>   drivers/hwmon/sch5636.c    | 6 +++++-
>>>   drivers/hwmon/sis5595.c    | 2 ++
>>>   drivers/hwmon/smsc47b397.c | 2 ++
>>>   drivers/hwmon/smsc47m1.c   | 2 ++
>>>   drivers/hwmon/via686a.c    | 2 ++
>>>   drivers/hwmon/vt1211.c     | 2 ++
>>>   drivers/hwmon/vt8231.c     | 2 ++
>>>   drivers/hwmon/w83627ehf.c  | 2 ++
>>>   drivers/hwmon/w83627hf.c   | 2 ++
>>>   drivers/hwmon/w83781d.c    | 2 ++
>>>   20 files changed, 55 insertions(+), 5 deletions(-)
>>>
>>
>> This series solves a problem which does not exist in reality and is only theoretic.
>> The devices are instantiated from their init functions which always adds the resource.
>> Please do not submit such patches.
> As you said the resource will be add in init functions, I checked these drivers, the driver
> sch5627 and sch5636 won't add resource, so need I send patches to fix these drivers ?
> 
You might want to read the code more carefully. The drivers are instantiated
from drivers/hwmon/sch56xx-common.c which does add the resource.

Guenter


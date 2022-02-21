Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259BE4BE8C3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380395AbiBUQZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:25:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380352AbiBUQYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:24:30 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E163227154;
        Mon, 21 Feb 2022 08:23:23 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id f19so33255497qvb.6;
        Mon, 21 Feb 2022 08:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TKiCt1S1j4SATnS4TlLvHBjlEUqaLXI7U/mAZPB0y5I=;
        b=S9CZ1OU2H+mocrhnNQdvnqdd75Wt8mgMi73b6S3J2ouJI9QdY4BCqUHtiOmjdpuP+s
         ceghewmE1wR2TyU09ypOD5QTjNeO5TvcoktA2qK/+7DTTk9Fk42pb6z35teWNifJrOj6
         laYkck6lrqfcxzsws8HGkPFMyQMf0StyDwEYgDqgZb22o8HUROvfdZzES9ytRvn17nw2
         bTiQZw7SBIWffkQqHFkLcjEiNtw8ZPbCQE0lasOpK3OVm2yuevtW2ALer9LfY7oMvvMO
         FoC694j4qGJvwT83PTf2yyeEczxqN48hDati9qh5uf1rRqUVSttX8/00N4diRXnHTRCj
         ud9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TKiCt1S1j4SATnS4TlLvHBjlEUqaLXI7U/mAZPB0y5I=;
        b=JoTQsbxRzy2ERcOZ8m83QJO1/Bf93w7+KmMp4JR6Vq9PfYeQGslctGL2Hir/S1+ePW
         q0glBcJMtSIFYhZ4wvugvsOWo7MKq2Du9YsdCtFw6tYCv2Kmt2O+ihCOVhC/28aXeJtn
         ltQszujNVkFiHCjvZbDHw1n/7YJIy9eELxlcFeUIPmmRe+K56LsgF8suhDVw2gJwXmcG
         kYs/h2rEVW3kDek/JCytMvU9HpqqaFLowwPiYcCVjGs6eoZc49ZmU4xL775XsoIQqgZ5
         Kd8MWKgbYVOepgceDf7r0ZkqfZB1rYYb4CEt68nWF+MdbYwpjupmgkdXbCTxAfnwt3qK
         BX9Q==
X-Gm-Message-State: AOAM531Mn1v8eiHKPiDuPdvBf1Gw2FQ49HJ6iDeX9zQdIJG9zCJIPKQf
        Y6dYkdyuMXygm+vIU1TNnhw=
X-Google-Smtp-Source: ABdhPJx3luw9Yj2YgyBCmh5YWqsBLD2UE75fz7mAtavHhJp2P6swRwUHOFzLuWmLEGMvptso/PF9cg==
X-Received: by 2002:ac8:59c7:0:b0:2dd:1364:4149 with SMTP id f7-20020ac859c7000000b002dd13644149mr18292863qtf.90.1645460603031;
        Mon, 21 Feb 2022 08:23:23 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y15sm27301501qko.95.2022.02.21.08.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 08:23:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ed6fa743-781d-35ed-b002-5621d3f66c91@roeck-us.net>
Date:   Mon, 21 Feb 2022 08:23:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/4] hwmon: (lm90) Use hwmon_notify_event()
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210618215455.19986-1-digetx@gmail.com>
 <20210618215455.19986-3-digetx@gmail.com>
 <9580f660-2a11-40e4-2986-f05703822d72@nvidia.com>
 <2aae3bac-c9b3-ab47-aae4-a3c7b6fb4bb5@roeck-us.net>
 <84ddad27-eb22-0ba6-594f-2fc6d098dc2a@nvidia.com>
 <bdb8b51f-93ac-9f99-914e-e1ce16c0076d@roeck-us.net>
 <20da6f55-682f-4b30-7be7-f425f8efa995@nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20da6f55-682f-4b30-7be7-f425f8efa995@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 08:16, Jon Hunter wrote:
> 
> On 21/02/2022 16:02, Guenter Roeck wrote:
> 
> ...
> 
>>> The platform I see this on does use device-tree and it does have a node for the ti,tmp451 device which uses the lm90 device. This platform uses the device-tree source arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts and the tmp451 node is in arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi.
>>>
>>
>> Interesting. It appears that the call to devm_thermal_zone_of_sensor_register()
>> in the hwmon core nevertheless returns -ENODEV which is not handled properly
>> in the hwmon core. I can see a number of reasons for this to happen:
>> - there is no devicetree node for the lm90 device
>> - there is no thermal-zones devicetree node
>> - there is no thermal zone entry in the thermal-zones node which matches
>>    the sensor
> 
> 
> So we definitely have the node for the lm90 device and a thermal-zones node, but I do not see a thermal-sensor node. Maybe this is what we are missing?
> 

Correct.

Guenter


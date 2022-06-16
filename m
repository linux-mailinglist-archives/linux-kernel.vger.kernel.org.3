Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C7254E6AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378059AbiFPQJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiFPQJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:09:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1DF3BBE4;
        Thu, 16 Jun 2022 09:09:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e11so1904061pfj.5;
        Thu, 16 Jun 2022 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NSqRnCBlY+30yLpGT1yEVXZ5Opjd95WnpzwC8La05Pw=;
        b=ZiTF7ATSJU8rzinDjJfw/wLuEkIeQPhG5U0bYKzqmdMsV3qktKPY0OLlreR48+zTLO
         p9B+dZtsjDdAW/Gavk6pYD3joeurFcR5/B6F2RPsC4ORxVXMb7i5revKoDTn081srC8c
         k4FdgOT/NRFYFz/UcmPzO8i6WLfd4r1M3xYqns1SudeG9Narc51QuPhYD1qfIT14sZuD
         8dZtWpvz2MYebZkwsatFZH/FbubCdu/G9MpjuP/tSKuJEJyKmQOhReNy0hCbCewwM9Vn
         x5T7sMygc1NyrdpLPDMvjYSOLRd2YDFEen3hbyuKgTVzO7o75Jg6lbleExkG/yLOBw4h
         l7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NSqRnCBlY+30yLpGT1yEVXZ5Opjd95WnpzwC8La05Pw=;
        b=TsveHY6dalUjULiWBCsxkMuyJLBUnIvTQzM9eO2tHMGG/5roOFESC3LitrrgVzTnov
         K3UOZwQ/4DpIxaEfc5xupJBlJqx35GO2VW/BSq8tjkX3yToVzMDiC5fFpm6UZpOv0tkk
         OLD9wREyX+iWuw1FOke5g3AKsAp4UmyejnZOFrszV+ooh8soz05fdNCQp7x6BQkdFaf6
         rLrp1iUorWwzapRJQvbFaFHoyPvX6LhuC1DpxUGmChvH10dmXtMyI1O2PmvoKt7NyuQT
         p8QDvbJidXNqRNEribvnPMQZdBwzMn9rj9uFUC13X9BEDuyaMXOdZIc/Vgu2cPpMZZvo
         ZcHg==
X-Gm-Message-State: AJIora99zxBx2YNrr+F9RI1KM4PZ78ofrYLPdph+PvaM1DcJ3HGy5lI1
        MooErepJqbvgqFPJSkKqhuY=
X-Google-Smtp-Source: AGRyM1ssSDnzm/wjaESMwGwAIvyLkV7Z8zdYJngZmT6ucOFnJvJw4I+WcsI/ZwXsPN6mldPPgm3h6g==
X-Received: by 2002:a63:5412:0:b0:408:84a9:9562 with SMTP id i18-20020a635412000000b0040884a99562mr5203509pgb.600.1655395762716;
        Thu, 16 Jun 2022 09:09:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b13-20020a1709027e0d00b00163aba9a2a5sm1811312plm.106.2022.06.16.09.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 09:09:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7dadb147-bf8a-d2b3-1f02-18b467492e5e@roeck-us.net>
Date:   Thu, 16 Jun 2022 09:09:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Content-Language: en-US
To:     Sebastian Ene <sebastianene@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com
References: <20220616092737.1713667-1-sebastianene@google.com>
 <20220616092737.1713667-3-sebastianene@google.com>
 <YqsBN2qtjCkNtVM0@kroah.com> <YqtTzehgcxRpoiyF@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YqtTzehgcxRpoiyF@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 09:01, Sebastian Ene wrote:
> On Thu, Jun 16, 2022 at 12:08:55PM +0200, Greg Kroah-Hartman wrote:
>> On Thu, Jun 16, 2022 at 09:27:39AM +0000, Sebastian Ene wrote:
>>> This driver creates per-cpu hrtimers which are required to do the
>>> periodic 'pet' operation. On a conventional watchdog-core driver, the
>>> userspace is responsible for delivering the 'pet' events by writing to
>>> the particular /dev/watchdogN node. In this case we require a strong
>>> thread affinity to be able to account for lost time on a per vCPU.
>>>
>>> This part of the driver is the 'frontend' which is reponsible for
>>> delivering the periodic 'pet' events, configuring the virtual peripheral
>>> and listening for cpu hotplug events. The other part of the driver
>>> handles the peripheral emulation and this part accounts for lost time by
>>> looking at the /proc/{}/task/{}/stat entries and is located here:
>>> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>
> 
> Hi,
> 
>> The robot reported stalls on vcpus?
>>
>> I think you need to fix this up...
> 
> The robot reported some issues on v5 and after fixing them it
> recommended to add this tag.
> 

Only that doesn't make sense for patch sets which are still being worked
on. If you want to credit the robot, mention it in the change log.

Guenter

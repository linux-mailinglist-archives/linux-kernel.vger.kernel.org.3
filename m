Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646F354E17B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376784AbiFPNI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiFPNI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:08:57 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BC5252B9;
        Thu, 16 Jun 2022 06:08:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y6so1269128plg.0;
        Thu, 16 Jun 2022 06:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VVJk39U+rrdJ8hRu277G3dCrMn0aAbAp7eK2DbUeJWo=;
        b=MGJyTaul/uQ0f+MkRFxEtmgjmVHAgvSpWspOMA2OC0kOZFcN473B2USZ0ZTdEtfyFP
         No0n5kRsemVAw5vpIq2w9mTFJ870iL4R84Vl0L/hWUYwOfPMNyDfu0h0Z77QCK6+eeTv
         7SeYm+VsWIP/xaZwEVvsC3/NJ1g5iJWMyvtie4k/t5oMZdpKct/CMfMA1O+CXW14KKVV
         /Q/hgke6NyvHqETBqwg3VorqKxAFZwhGTIp/7hlseIYaQjJ6vpMNLLcGnJzuJZqYjWH8
         S6wXi6Yf7/nx5whjWGRC0H+1nQg7bfJXd20lgB2kv/grWqq5J2AeBjK4dklxiDAeRMSK
         57Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VVJk39U+rrdJ8hRu277G3dCrMn0aAbAp7eK2DbUeJWo=;
        b=MafgubbpqhUDv5gnDbK2ax49HPG7McEagqJEWXTU7kY3dQ2U50EQdtPUKviwfSLcbp
         FDjWt3BwZxeiB9m3wWbpvBXJuhFWekoBu7FIL9gaE3eOK2wvynHe1q4StGRIDrhBjCnQ
         8Wl74XPRb0MDNrSVwU67/O3ss3td7Pr9WZ82fMOv3kzH6XG3O1lkiLzxD2JnyGcnLvwI
         fmthqXusZE9Mde0Gita48ldPsZbERxWQOHESOtufbSAY/7ixZRvNBf1lfUrN2Icm2YSr
         Rg6znnC/eiQbrKbcAy36blFOQBLIHSn+6Vb41kbknQBG6YLmg6dmOpj3Arorpw6oEgEI
         hiyw==
X-Gm-Message-State: AJIora/dfc4ndR63lO5O7Gb30fO0Vv+YfKUXD3RR1wZpWSKmY1ZBO8T6
        OPLdD9BatQK5Ja9Tkaqa0qc=
X-Google-Smtp-Source: AGRyM1u5/iL9VCObbDfPPUtEkMb1evkIZRjjNhM4/48tlJqCj4ZBtAY9FT8BP5uL2sLw47XIctNBbA==
X-Received: by 2002:a17:903:18d:b0:167:47f3:49 with SMTP id z13-20020a170903018d00b0016747f30049mr4743721plg.95.1655384935230;
        Thu, 16 Jun 2022 06:08:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y23-20020a056a001c9700b0051b95c76752sm1686997pfw.153.2022.06.16.06.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 06:08:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fe96c19c-b8eb-2443-1476-3dff7ea47f6b@roeck-us.net>
Date:   Thu, 16 Jun 2022 06:08:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Ene <sebastianene@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        kernel test robot <lkp@intel.com>
References: <20220616092737.1713667-1-sebastianene@google.com>
 <20220616092737.1713667-3-sebastianene@google.com>
 <YqsBN2qtjCkNtVM0@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YqsBN2qtjCkNtVM0@kroah.com>
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

On 6/16/22 03:08, Greg Kroah-Hartman wrote:
> On Thu, Jun 16, 2022 at 09:27:39AM +0000, Sebastian Ene wrote:
>> This driver creates per-cpu hrtimers which are required to do the
>> periodic 'pet' operation. On a conventional watchdog-core driver, the
>> userspace is responsible for delivering the 'pet' events by writing to
>> the particular /dev/watchdogN node. In this case we require a strong
>> thread affinity to be able to account for lost time on a per vCPU.
>>
>> This part of the driver is the 'frontend' which is reponsible for
>> delivering the periodic 'pet' events, configuring the virtual peripheral
>> and listening for cpu hotplug events. The other part of the driver
>> handles the peripheral emulation and this part accounts for lost time by
>> looking at the /proc/{}/task/{}/stat entries and is located here:
>> https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
>>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> The robot reported stalls on vcpus?
> 

I have seen this a number of times when people fix issues reported by
the robot in their submissions, just because the robot asks them to
do so. This should really be part of the change log, such as

v17: Fixed the following issues issues reported by the kernel test robot:
      ...

Guenter

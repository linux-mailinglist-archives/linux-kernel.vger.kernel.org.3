Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3813051DDC2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443868AbiEFQqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349789AbiEFQqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:46:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3005A6D4D6
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:43:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n10so15524002ejk.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 09:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uXADz01AeFewV6iYhU+m/XHBp5vt6rj8FBguzHNht/w=;
        b=naZPiE9y/1tBVgRCbc98NpZBEX2LMXBzApytnp9TzMwbwRNXK+tzub9jPsBFe5hq5X
         WDLHxdINBwyNtCXfxLXl5MaU8MVJ5n8p6oMht4UJQg4HPCT89Ytq4nHHjVbX6WjJXqrh
         TrubfMnrWO+eI+jRzS/ANPiGh2VOdXvMvsOXUf6V8Khdo1pM2WYNXnbwX122u6HlnNAr
         Wbtzoq7QFNYRgqJOH9YbFKH70SrOoKEGKFpSzN0kiFDPbFNqrujUWZCEBhBilEjSeRas
         x6kv+TfxBP+FW6lKcr2yDjIj6UbuCF71CPfNjr0tn9fyYMtHKSv5f3CX7vmq6DKNDHKM
         zbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uXADz01AeFewV6iYhU+m/XHBp5vt6rj8FBguzHNht/w=;
        b=q90LxDnGSB5hhFu4UZagJ2nIn3E9q7Tkg8xmc/1a6IolhMTj+vBirnmBkvzSY2SeJr
         BfCF3uBmn51uZDdkjSPlqyQQFEApjzKMT8nHaUHJOInARCEqp2KJFFLi7ILidA34RAMu
         gVBbiZHvzzi2BgCLGia4AXpcSQXQI2c7fgasCQQitcKV9XltDyXevzxOHl4xuI3kpuzL
         d7lkriDwpajpjA04sCUD07hFryw1HBcn5zxSOdzf6ZcCiQAQ+ZgX6Tyiyb9TdpgPCBar
         fgKRWo+1m8C91ahorGdKnwzXfYBpACwvn/bO/BVEGP6kyQKX6Gyqw+1H+P3jEttMjQ4O
         BvHw==
X-Gm-Message-State: AOAM531WxPUxdRMpFYeagcxUZ7Ww2t1rMvbh/PAIJM1hcsWsKFBvQrtO
        w8u+cmANLlb5h35rhjt8WMtQWg==
X-Google-Smtp-Source: ABdhPJwTnirkXiophxQdfZTgJxDwbQCMukkaJamT/JW2zZO9KNxKhPH6DgHhjHeJmHXyDDlbQnkE5Q==
X-Received: by 2002:a17:907:7242:b0:6f5:2921:a89c with SMTP id ds2-20020a170907724200b006f52921a89cmr2583932ejc.445.1651855380805;
        Fri, 06 May 2022 09:43:00 -0700 (PDT)
Received: from [192.168.0.231] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y1-20020a50eb01000000b0042617ba6392sm2431843edp.28.2022.05.06.09.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 09:43:00 -0700 (PDT)
Message-ID: <6f28acde-2177-0bc7-b06d-c704153489c0@linaro.org>
Date:   Fri, 6 May 2022 18:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/4] scsi: core: constify pointer to scsi_host_template
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.smart@broadcom.com
References: <20220408103027.311624-1-krzysztof.kozlowski@linaro.org>
 <2a88a992-641a-b3ff-fe39-7a61fff87cb6@huawei.com>
 <4c3be5b6-50ef-9e9a-6cee-9642df943342@linaro.org>
 <7b3885e3-dbae-ff0b-21dc-c28d635d950b@huawei.com>
 <c121430b1b5c8f5816b2b42b9178d00889260c90.camel@redhat.com>
 <b6af3fe8-db9a-b5dc-199f-21c05d7664a2@huawei.com>
 <Yl+wJ7xSHzWmR+bR@infradead.org>
 <d09faf74-a52e-8d93-cf26-08b43b12c564@huawei.com>
 <24bfb681-faec-3567-3089-9cd5ee182710@linaro.org>
 <1bb53912-c5c3-7690-e82f-cf356ca87404@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1bb53912-c5c3-7690-e82f-cf356ca87404@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 15:04, John Garry wrote:
> 
>> For example scsi_proc_hostdir_rm(): 'present' and 'proc_dir' members.
>> Where should they be stored? Should they be moved to the Scsi_Host?
>>
> 
> I don't think scsi_Host is appropriate as this is per-scsi host 
> template, unless you see a way to do it that way. Alternatively we could 
> keep a separate list of registered sht, like this:
> 
> struct sht_proc_dir {
> 	int cnt;
> 	struct list_head list;
> 	struct proc_dir_entry *proc_dir;
> 	struct scsi_host_template *sht;
> };
> static LIST_HEAD(sht_proc_dir_list);

Hi everyone,

It took me some time to get back to this topic. I moved the proc_dir out
of SHT, how John proposed. Patches do not look that bad:
The commit:
https://github.com/krzk/linux/commit/157eb2ee8867afbae9dac3836e4c0bedb542e5c1

Branch:
https://github.com/krzk/linux/commits/n/qcom-ufs-opp-cleanups-v2

However this does not solve the problem. The SHT has "module" which gets
incremented/decremented. Exactly like in case of other drivers
(driver->owner).

I started moving the SHT->module to a new field scsi_host->owner and
trying to use the parent's driver (so PCI, USB) owner.
I am not sure if it is correct approach, so before implementing such big
change affecting multiple subsystems (USB, ATA, SCSI) - can you share
ideas/opinion?

The Work-in-Progress looks like this (last commit):
https://github.com/krzk/linux/commit/17609caecd53df20f631703ea084a70e7735b5d7


Best regards,
Krzysztof

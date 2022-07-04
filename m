Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D220E565ED0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiGDVSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGDVSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:18:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9160DB493
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 14:18:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a5so248833wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 14:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NAXVM4+dYox3VVgsqiD1LRzFX4iWrqHBkJH97rOqm7o=;
        b=5pa5KRy291cHOWTaLGrA3y72Vs/9z7FLXMgUasv5JCbykQfUeY8VAh+1e9NEUq8jeq
         mk4Hc4g/y6ePhyy62+oDH8ifMk3cmdBjp0rHI3psG5J4YieBsU0/gqZNZZaH6vXqNJHa
         UCz5k5/YdyDiT+mUYFwnWf0tHFNCNLXfs/clAC52ZBHSrWY158OJjR5i49DaNlOapMNZ
         iKxfrykaVN7Z/t4l9SYOLRDBu9dL6yl7FgAWvdD/WIL85z+fNi60ixdsIdRVCFK7zUCc
         vv3q3506wXPzoqbvUZXFad9LO/tppjFJ3mfKAGp4Aed42dULXANiX5b+Ry/eltFRcMAP
         i+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NAXVM4+dYox3VVgsqiD1LRzFX4iWrqHBkJH97rOqm7o=;
        b=aNuUBWxmBIUQWbuOqNMDLM0XuZJPq3ovrzNzDEyQNB9Ft1WsllqWDOnwQkVNEWikXi
         KvuRz3PYaBBvkVT3PihsYLeIR7rGJQaCtOYV9eeT3p6aKWBO/SqZYefl+nCWVgLHPEUI
         Zqyw1D9wuayNzQNFE76UuE0feIGQ9bJPn3L/aV6LoEl1Od3JSk/GbbRSfFiRuwSZ+/dT
         CLVgrQq9oXwSpv6i/Ra8G+StWx2oewC80tnp8aRcG7IhmgHYY58CStgOTiW1XYDJH0eN
         0pN7GDPklTM5eK245nbOIH4zxcK2IlyexKOwbk7WDxnHR1IlVrb3akepmL7skcWscrUs
         0K2w==
X-Gm-Message-State: AJIora9pZP3NLmTcOR10jG4aGjOMZRtNRicm0Z7A+f3yAt6RnQKZ5mtf
        xTcnYqOakNDvdnoNqrNp2tUopQ==
X-Google-Smtp-Source: AGRyM1tJpQhFNte8swsAJEQf2eqt78Dmc9YUPUqOAqzoKirUJJeHX/WNrUKROw4ikKSVygYS9RZVog==
X-Received: by 2002:a05:6000:18ad:b0:21b:a24a:1786 with SMTP id b13-20020a05600018ad00b0021ba24a1786mr30814634wri.115.1656969496174;
        Mon, 04 Jul 2022 14:18:16 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id bv13-20020a0560001f0d00b002101ed6e70fsm12443544wrb.37.2022.07.04.14.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 14:18:15 -0700 (PDT)
Message-ID: <801d98af-2a41-0f78-ec97-da20c56e49a2@linexp.org>
Date:   Mon, 4 Jul 2022 23:18:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 02/12] thermal/of: Replace device node match with
 device node search
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-3-daniel.lezcano@linexp.org>
 <180b55da-9ed2-baba-27b0-fba354a9ecd2@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
In-Reply-To: <180b55da-9ed2-baba-27b0-fba354a9ecd2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2022 09:59, Lukasz Luba wrote:

[ ... ]

>> -    for_each_child_of_node(child, gchild) {
>> +    for_each_child_of_node(trips, gchild) {
>>           ret = thermal_of_populate_trip(gchild, &tz->trips[i++]);
>>           if (ret)
>>               goto free_trips;
>>       }
>> -    of_node_put(child);
>> -
> 
> It's probably needed to put the 'trips' here, isn't it?
> Or at the end in 'free_trips'.

Right, it is fixed later in another patch but I'll fix it here too.

Thanks for spotting this


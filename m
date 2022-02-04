Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571644A9B92
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359497AbiBDPDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiBDPDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:03:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E118C061714;
        Fri,  4 Feb 2022 07:03:15 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id s13so20339981ejy.3;
        Fri, 04 Feb 2022 07:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=B670DNtJG0WdyNR5I1jFrgWciVu2OUtPUlpRz7Cp6s4=;
        b=dS2AM6xhnrTEaTxC9t4tAcKlxxKPTdL/033hfhpA0gDiLjd6DQGTvKDWxZ/rKb78Ik
         zKny8enp3Ev0eAtezLwbrUs02cIlEjLDEVcqeGsVR8MAKK25XMOZU+BM1qhRi5NSH3qR
         UpQF7876vC40ky9hHaWhjgXh7+60zsstLTThm+DT2BSAnhSAwuJAfiFWCalB1h8hwaYW
         ASXyehCHsJabzP3Nk4iRu9Jx49kvOih++bIpAAZRCpSkL1MS6OYvYtbgtyZhp8CP9lRG
         HX+h09TChSV6Pff5SBjyjSswlvbDy3xenMjsYmIMMWMQ4/8Rmp9V577/qcYYY90/avAj
         mk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=B670DNtJG0WdyNR5I1jFrgWciVu2OUtPUlpRz7Cp6s4=;
        b=8JIWiKYQsUazNjtkNFyggfL+7IcUo5A0uAIB+y6AYyIUW6pLY0fggNtHcpcSN/jsss
         2plwbgCeJ/rORw2xfk9VaxjPPtd4X4gxakhwUbAerV5Dt+nDWW/xu+DVWXpfHvd/M1L5
         gzVeeljuCMLVU3VUSsPIWZcoSwz1buKGiWsTgCXkwFv8ybdXZyotah105bQtJso86oLz
         3F0PIlDmxldpVPxkXdKbeXkoD2a0AGHvB+EzUeu58eziQkPVcIrBU+FFFJ6croLonpqb
         yBhbQN/13MZ5ItxPpW83X+nOR7XYfvRnnLPiu/3UUoJa0Sp3D1Vx5y3ECQppcRKy9qla
         HxJQ==
X-Gm-Message-State: AOAM530t2Ii/GRkKyIotMJmhsae/dzDpurbFXbXQoKJWxXj3zTou4UxG
        AoTve6x8nu83UNZo7rswcnFotuN1zlRtzg==
X-Google-Smtp-Source: ABdhPJxYKCNS7QCoUnclJE0R/yuYPYsLUjhaRtNX9+ro7+NLgccBXpuQHu6KJjyJcA5IR+2YjhMOSg==
X-Received: by 2002:a17:907:1c19:: with SMTP id nc25mr2942085ejc.354.1643986993950;
        Fri, 04 Feb 2022 07:03:13 -0800 (PST)
Received: from [192.168.8.101] (37-48-40-106.nat.epc.tmcz.cz. [37.48.40.106])
        by smtp.gmail.com with ESMTPSA id oz3sm736936ejb.219.2022.02.04.07.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 07:03:08 -0800 (PST)
Message-ID: <54f98c2a-4a40-75ed-8f66-11cc6b2fd190@gmail.com>
Date:   Fri, 4 Feb 2022 16:03:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Partial direct-io loop regression in 5.17-rc
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Kozina <okozina@redhat.com>
References: <feb7e4b4-1a6f-71a7-0cdd-fda547408bea@gmail.com>
 <08e1dbde-b27c-fd99-294c-8e4715b92576@kernel.dk>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <08e1dbde-b27c-fd99-294c-8e4715b92576@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/02/2022 14:32, Jens Axboe wrote:
> On 2/4/22 2:22 AM, Milan Broz wrote:
>> Hi Jens,
>>
>> It seems that there is a regression in direct-io over loop for partial
>> direct-io reads (or perhaps even for other situations).
>>
>> If I run this code (loop over 6M file, dd direct-io read with 4M blocks)
>>
>> IMG=tst.img
>> LOOP=/dev/loop66
>>
>> truncate -s 6M $IMG
>> losetup $LOOP $IMG
>> dd if=$LOOP of=/dev/null bs=4M iflag=direct
>> losetup -d $LOOP
>>
>>
>> on older kernel (<=5.16) it reads the whole file
>>     6291456 bytes (6.3 MB, 6.0 MiB) copied, 0.201591 s, 31.2 MB/s
>>
>>
>> while on 5.17-rc (tested on today/s Linus' git) it reads only the full blocks:
>>     4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.201904 s, 20.8 MB/s
>>
>> No error reported, exit code is 0.
> 
> Can you try:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.17&id=3e1f941dd9f33776b3df4e30f741fe445ff773f3

Yes, it works now.
(Not sure why I did not check if this patch is mainline, as I know about it. My bad...)

So this is going to some next rc, right?

Thanks,
Milan

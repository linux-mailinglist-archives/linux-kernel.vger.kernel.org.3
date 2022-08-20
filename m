Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB359AEEA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 17:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346238AbiHTPht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 11:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345775AbiHTPhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 11:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA526AA06
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 08:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661009864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CSUDwEi1svTWS13A5fcvj35eehBaJVIHJlmeSdMUK/M=;
        b=cx1EAOZFIZNVYkUlcg2+QrxMupJaHKVBd/yPygNDCsxdyUQOQ8rd2xcKUTr5CUtAM0yywo
        izedAR11QX9rMSNcAtvRtfYeTWQ4m+/iXwkuRenBVTcuGHxH5rX+OC9lyBAm4aX3PABXha
        DZ+Ue0RpTWsDiR42GwihLzGsm+JewIM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-35-5HGTBcVMOO2Tix7BXxhhhw-1; Sat, 20 Aug 2022 11:37:43 -0400
X-MC-Unique: 5HGTBcVMOO2Tix7BXxhhhw-1
Received: by mail-ed1-f69.google.com with SMTP id y16-20020a056402359000b0043db5186943so4383855edc.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 08:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CSUDwEi1svTWS13A5fcvj35eehBaJVIHJlmeSdMUK/M=;
        b=x05i5bFlZy831hwP+icXowG8JCwS2SORbig6b7xFfx3YeGMRpi0u0vEsKyuu0IL767
         zuIlGlkj6y89fOxKLOqyhF7qMGnHWaYLYI6pQT44S8itK/T8o6N8JpNtriAapYne/uT+
         HCEiUZ7nf7Teuc4kMU4Uiyg35Iw6A2YbrmCk90PAJwbt8ZaMSv9kPpHRJWyW5iY+t0Cv
         OvCVLhPcRZj0GauMCADEZDdyr6HvJGbXUC/A7OXaUtZ9GVb5xuvlN1c/lQu2Rhx3Iw0M
         f/GjVG0haYvECz8Y2gV4QP+LBhSuNqidtJigkx/bNQUJk8ANOl375jSpPRo8WCIFn8Xy
         kA8A==
X-Gm-Message-State: ACgBeo105ubD4rvk/wUEcDiFlk3lI+sfBxt6SYBED2rjTywLI19QTK70
        OU7cA1QgZQt6qAJouLo7VthgTo0nYwOeWjTWm77uni6z49XqYx3Kb7gkokQpTPQlsLbDpikcZ2r
        0VfYY8dWu7ul2rv63lHy2N0Nl
X-Received: by 2002:a05:6402:3495:b0:43d:d76e:e9ff with SMTP id v21-20020a056402349500b0043dd76ee9ffmr10158398edc.227.1661009862301;
        Sat, 20 Aug 2022 08:37:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR56NKhopv/ioAeFb925MKnrc4gMGSU/vLUjnbjCFZdK2VcWWVNy8nDcXS+vYMB17jvhSSMtNQ==
X-Received: by 2002:a05:6402:3495:b0:43d:d76e:e9ff with SMTP id v21-20020a056402349500b0043dd76ee9ffmr10158391edc.227.1661009862150;
        Sat, 20 Aug 2022 08:37:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ku7-20020a170907788700b0073d15dfdc09sm2324594ejc.11.2022.08.20.08.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 08:37:41 -0700 (PDT)
Message-ID: <1c4ffc37-df00-0487-2e4e-79b5178d9741@redhat.com>
Date:   Sat, 20 Aug 2022 17:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: 6.0-rc1 regression block (blk_mq) / RCU task stuck errors +
 block-io hang
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, rcu@vger.kernel.org
References: <dd6844e7-f338-a4e9-2dad-0960e25b2ca1@redhat.com>
 <17ccd5ae-0268-1bee-7822-1352f4c676ba@acm.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <17ccd5ae-0268-1bee-7822-1352f4c676ba@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 8/19/22 16:49, Bart Van Assche wrote:
> On 8/19/22 05:01, Hans de Goede wrote:
>> I've been dogfooding 6.0-rc1 on my main workstation and I have hit
>> this pretty serious bug, serious enough for me to go back to 5.19
>>
>> My dmesg is showing various blk_mq (RCU?) related lockdep splats
>> followed by some tasks getting stuck on disk-IO. E.g. "sync"
>> is guaranteed to hang, but other tasks too.
>>
>> This seems to be mainly the case on "sd" disks (both sata
>> and USB) where as my main nvme drive seems fine, which has
>> probably saved me from worse issues...
>>
>> Here are 4 task stuck reports from my last boot, where
>> I had to turn off the machine by keeping the power button
>> pressed for 4 seconds.
>>
>> [ ... ]
>>
>> Sorry for not being able to write a better bug-report but I don't have
>> the time to dive into this deeper. I hope this report is enough for
>> someone to have a clue what is going on.
> 
> Thank you for the detailed report. I think this report is detailed enough to root-cause this issue, something that was not possible before this report.
> 
> Please help with verifying whether this patch fixes this issue: "[PATCH] scsi: sd: Revert "Rework asynchronous resume support"" (https://lore.kernel.org/linux-scsi/20220816172638.538734-1-bvanassche@acm.org/).

Thanks that is very useful. I'm running 6.0-rc1 with this
patch added now and so far I've not seen the problem re-occur.

I was also seeing 6.0 suspend/resume issues on 2 laptops with
sata disks (rather then NVME) which I did not yet get around
to collecting logs from / reporting. I'm happy to report that
those suspend/resume issues are also fixed by this.

I'll reply to the patch with my Tested-by for this.

Regards,

Hans


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DB6471128
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 04:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhLKDTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 22:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbhLKDTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 22:19:18 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AA2C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 19:15:42 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id s137so9599453pgs.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 19:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oEtEML3eYYMIH5a0A+SA6KNBkcPPfw4EWeSJ3ru6CTM=;
        b=kMTWfpX+AgwsD4KkToVZcJlgQSqZc+Jo16HPBOaBnTnnrxW5S9eWtQoZWEkPDRe5rd
         057jBN5DJNuOaIynuEwnfSoac/EVi1WKxZm6ay+iVsfASN2pUVpN+JyZUUvvcIMUaq6D
         cevMaSl+AzBV5u2nqZ7eGJipAFTwl5VUTOZ3U02J49vnqt6PGBUyDSrFEgO2Bd7b4GrU
         ojNCoYWhVYeI7n2opDd4qPBuOE71VSRn9dID0UmTYHNbm/h5B+3bOo3ZIVvz1OuI0Phk
         IXUjM3rw1NQyJF4Hy5ZaXJkNctb1AWTza4op6yTR0B1rg74GxS0W5dWMCrMbVuWsbKvd
         cJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oEtEML3eYYMIH5a0A+SA6KNBkcPPfw4EWeSJ3ru6CTM=;
        b=HESXMIQSB3lE3xn5Do1gls209Of+oza02jybl+jR15Tgj+qKDTxmDLoOS24acc7VfD
         YP2Aipc3EmVzAFrEZUABsew3nq/hMMEj89eVnd6rP6nJoggS13QM79udAEHE9m99ApwB
         dB2NOMzJK5g9t4el1KUPfW93N/OS0+Ssw4HcaVxQXtBWaiEqq1lb2wX1d2VwT+h69R95
         EJO/DySfTU6/An/Hbp5evkyZkAVT+n+bi6pf9c8HLu75v1KYKazBX13g2ppFrRhyBNIR
         gbTxBFOzf5q+NM8v37wuoyOjFKxKILBBwHZTmpKP58cuSnbxK327bbVxL5r9Zdm4rSKW
         6/Hg==
X-Gm-Message-State: AOAM532nlXOdJZyxWT05TXyoXezc8pRO8ilc9QKDPzJstHw/CEZuVzMB
        dhlwjkPWclgtz4Kck7Ye39y2Z42EamenQg==
X-Google-Smtp-Source: ABdhPJwhuKSTNCd/mjdcfcodhDhFtba9HSq1hVHtcz9FxfkvtTaF7lyFfih+jGlNOD9f7I124Ia5xg==
X-Received: by 2002:a05:6a00:1693:b0:44c:64a3:d318 with SMTP id k19-20020a056a00169300b0044c64a3d318mr21788722pfc.81.1639192541723;
        Fri, 10 Dec 2021 19:15:41 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id q32sm349882pja.4.2021.12.10.19.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 19:15:41 -0800 (PST)
Subject: Re: Random high CPU utilization in blk-mq with the none scheduler
To:     Dexuan Cui <decui@microsoft.com>,
        "'ming.lei@redhat.com'" <ming.lei@redhat.com>,
        'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>
Cc:     Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
 <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c5c8f95e-f430-6655-bab5-d2a2948ab81d@kernel.dk>
Date:   Fri, 10 Dec 2021 20:15:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 8:10 PM, Dexuan Cui wrote:
>> From: Jens Axboe <axboe@kernel.dk>
>> Sent: Friday, December 10, 2021 6:05 PM
>> ...
>> It's more likely the real fix is avoiding the repeated plug list scan,
>> which I guess makes sense. That is this commit:
>>
>> commit d38a9c04c0d5637a828269dccb9703d42d40d42b
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Thu Oct 14 07:24:07 2021 -0600
>>
>>     block: only check previous entry for plug merge attempt
>>
>> If that's the case, try 5.15.x again and do:
>>
>> echo 2 > /sys/block/<dev>/queue/nomerges
>>
>> for each drive you are using in the IO test, and see if that gets
>> rid of the excess CPU usage.
>>
>> --
>> Jens Axboe
> 
> Thanks for the reply! Unluckily this does not work.
> 
> I tried the below command:
> 
> for i in `ls /sys/block/*/queue/nomerges`; do echo 2 > $i; done
> 
> and verified that the "nomerges" are changed to "2", but the
> excess CPU usage can still reproduce easily.

Just out of curiosity, can you do:

# perf record -a -g -- sleep 3

when you see the excessive CPU usage, then attach the output of

# perf report -g

to a reply?

How confident are you in your bisect result?

-- 
Jens Axboe


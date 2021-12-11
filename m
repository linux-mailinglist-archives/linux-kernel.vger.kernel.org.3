Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680FE471099
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 03:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242247AbhLKCIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 21:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244538AbhLKCI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 21:08:26 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D5EC0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:04:51 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r138so9492725pgr.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 18:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2S8/I20Ezd/HLw6sc+AWiuN7klMREXmDQI1IahWHKQA=;
        b=6fM9O1Dh/P1lWRQ3SMkvNku8Ph06gI7kJMWiYxUHz3X9Nb0HHP6CsFLuy6JJbjVqt/
         kYY2kJdZwjFVV4qinsy6RA1x8KQ2+RyqSeqiMVWtCEVU9ci4hKSF88eQRH74qv7ihE6Q
         brqWWhoTcGwYUf8Ca3M5y+WV3VhDqKlIGGlwNXI2WttfWgiSFXAwdwk2Py05M/z1NUUA
         9fF94bS/Fw3MGD1qnixQ2yZwP7Ngq1Hy7oW3uPHYvy9/VAi7h1sXXShKXPhdOLKIINPI
         ZTucxmEpUkKbd4FC2kAwmiXrZtWEVJZE1ANiEIX1qoHx+sQ6BHrEsUub8Ayxf7F9u4ip
         TWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2S8/I20Ezd/HLw6sc+AWiuN7klMREXmDQI1IahWHKQA=;
        b=RM+dQbzd8MrXZv9Zmz2VnXDBFXsvzz3qwxJgvzkdTFJgNsxhXRvs2zAZIsqAsWij1o
         2C8Nyeudky6yM74SZ1xCuTsxV3s4I9qPxGhXq0brP0KRTEqZot8SUEGRWJlm7RFWoV67
         m42z6WGMEw6zgdn/kDrC+3reGm7dPELgp/r9qdfRQb8rs/49Jq9RO3WteYO5rVKhHeEp
         KVhJ1xiIP7nfPDWgoEsnNk6V/4EVYR/NxyDxKFFs0nuCs+ktbqs1VpGwBgQ43djtATA4
         Q4+Uv73f69ob2kLNegS4iImxeVBrOckb0MhlVbX6o+td9D8/AfLqQHyCOX+tRYbOtB68
         kAdw==
X-Gm-Message-State: AOAM531G4VUzjueJYv5kIA3UqMKCWe00QYrDCsO/uHqStF+/lVCoVYt+
        /2W04OdDW9ISQRi34T18j9PtxlGTzRDciA==
X-Google-Smtp-Source: ABdhPJzRP3MBItZpg6nAIkTDSO2bM6xHpEVEXCUCFKSIS6assdVuUWT7a0rrwdfVSe6hVc1kRpbCTQ==
X-Received: by 2002:a05:6a00:1681:b0:4a8:2462:ba0a with SMTP id k1-20020a056a00168100b004a82462ba0amr21272811pfc.75.1639188290374;
        Fri, 10 Dec 2021 18:04:50 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id nm13sm244380pjb.56.2021.12.10.18.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 18:04:49 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
Date:   Fri, 10 Dec 2021 19:04:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/21 6:29 PM, Dexuan Cui wrote:
>> From: Dexuan Cui
>> Sent: Thursday, December 9, 2021 7:30 PM
>>
>> Hi all,
>> I found a random high CPU utilization issue with some database benchmark
>> program running on a 192-CPU virtual machine (VM). Originally the issue
>> was found with RHEL 8.4 and Ubuntu 20.04, and further tests show that the
>> issue also reproduces with the latest upstream stable kernel v5.15.7, but
>> *not* with v5.16-rc1. It looks like someone resolved the issue in v5.16-rc1
>> recently?
> 
> I did git-bisect on the linux-block tree's for-5.16/block branch and this patch
> resolves the random high CPU utilization issue (I'm not sure how):
> 	dc5fc361d891 ("block: attempt direct issue of plug list")
> 	https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.16/block&id=dc5fc361d891e089dfd9c0a975dc78041036b906
> 
> Do you think if it's easy to backport it to earlier versions like 5.10?
> It looks like there are a lot of prerequisite patches.

It's more likely the real fix is avoiding the repeated plug list scan,
which I guess makes sense. That is this commit:

commit d38a9c04c0d5637a828269dccb9703d42d40d42b
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Oct 14 07:24:07 2021 -0600

    block: only check previous entry for plug merge attempt

If that's the case, try 5.15.x again and do:

echo 2 > /sys/block/<dev>/queue/nomerges

for each drive you are using in the IO test, and see if that gets
rid of the excess CPU usage.

-- 
Jens Axboe


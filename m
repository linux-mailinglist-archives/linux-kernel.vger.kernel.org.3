Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10434EAF70
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbiC2Onp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiC2Onm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:43:42 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F2633E0A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:41:59 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id j15so12469176ila.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AVyIyksmsm35rpHbd7JYtqtwz4P+hprrGiulqdW6wU0=;
        b=5Q41RvDjYNyTdz/xPhbf/Hb6XzsVe1nJXQLYDWmaSQF60dzDLDdb0ctTqYhYKc2b7t
         RRVAOl1C2OoQJWGvAH8iX10KL4Uxl8sApigPqAmMhjQMlxKFBX0+VpOGjCOVUSR+1rZM
         K3P++VRaWt5Ru2hUm9Z0uT97OMDdrl7Z9+aoL9NIXU6nM+qBwAdl3Z9i4Vf32gdDodCr
         EPFRlkjw206wR9NZyU2RI7MjFuL2dOysi6utIqTHWLw2+jVzbeFJv/WGfWkQxj79low2
         a4Y24Be5bRohtk6obXTh5Ds80B8QLRYpkfcUWDguYvp0cNrWZzX7xdb9scgreu3aRTG/
         Dx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AVyIyksmsm35rpHbd7JYtqtwz4P+hprrGiulqdW6wU0=;
        b=2EgH75FXJA0SjBR0YJWh25Mqa0W+clbViZPbpVzrsRSt7Iw68h26CtN2oGjDn7SN5Q
         Axh/Rb2VpQ1w8y8mDVUWshqtI+hghwzJtRYWX7l7EOb1KxYbHtHacpXIXtWwGAmrj8TN
         tNuFCD+RKrOigc+stdLF/oyCZkQ20X7eJ5sym16XErnyObO6CLjAUxhA62/NenvNbiw+
         VOg1h7+mHeZG5zthdxydTPwbqi/4IeXGKpjcgcMXM9Y91rwqUJEmcQ45HNKcRSAlPHn8
         G1+EKhWz3MI+okFTm+G5QbpZ6cwNTxAWgmfGeDXkxVmrpT607aLj0XngF9Nj8PlR8r+D
         +MHQ==
X-Gm-Message-State: AOAM533Jpuyh7hgxX8K4EfXFHd8D1Zyg1BVqmrmBunQTTk3POm7EzAMt
        cmAuz63yjnZ3reD0zcwXJy8tpA==
X-Google-Smtp-Source: ABdhPJytJTd6+X8KoSkVyNx4qLN9qBrqSGniwmABff6ugJU1toO3UxxJ76wWUm/HZEzyajv5d1O0Uw==
X-Received: by 2002:a92:c246:0:b0:2c7:c7e5:e6f9 with SMTP id k6-20020a92c246000000b002c7c7e5e6f9mr8663839ilo.166.1648564918585;
        Tue, 29 Mar 2022 07:41:58 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u11-20020a056e02080b00b002c87d5830cbsm7626686ilm.40.2022.03.29.07.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:41:58 -0700 (PDT)
Message-ID: <338207c2-e3cd-abc1-6b8c-f08645ef144a@kernel.dk>
Date:   Tue, 29 Mar 2022 08:41:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC 2/6] block: refactor to split bio thoroughly
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Yu Kuai <yukuai3@huawei.com>, andriy.shevchenko@linux.intel.com,
        john.garry@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220329094048.2107094-1-yukuai3@huawei.com>
 <20220329094048.2107094-3-yukuai3@huawei.com>
 <YkMKgwsZ3K8dRVbX@infradead.org>
 <e46db33f-84a6-6d23-9be2-7429fec71046@kernel.dk>
 <YkMabVKr+7Mg53E1@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YkMabVKr+7Mg53E1@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 8:40 AM, Christoph Hellwig wrote:
> On Tue, Mar 29, 2022 at 08:35:29AM -0600, Jens Axboe wrote:
>>> But more importantly why does your use case even have splits that get
>>> submitted together?  Is this a case of Linus' stupidly low default
>>> max_sectors when the hardware supports more, or is the hardware limited
>>> to a low number of sectors per request?  Or do we hit another reason
>>> for the split?
>>
>> See the posted use case, it's running 512kb ios on a 128kb device.
> 
> That is an awfully low limit these days.  I'm really not sure we should
> optimize the block layer for that.

That's exactly what my replies have been saying. I don't think this is
a relevant thing to optimize for.

Fixing fairness for wakeups seems useful, however.

-- 
Jens Axboe


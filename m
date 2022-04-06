Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C054F63AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiDFPkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbiDFPj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:39:57 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78EF1B72FE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:55:34 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 125so2105440pgc.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 05:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ia9+/STEIK6s5M7yq5g28XApY0uGE7BS8OCfCM69b6A=;
        b=1jHJjG0vgz25gIzyBuScalLuzhFAfWyPNeNxdThD5QdRv6nV6NS/H9b5sgMPyXcpeA
         jCApD1jmvsgeKI5/tguxrCXmMwlkeU+UtDeN87DbXpH4BDnpcB6dNPoaNFysouTNi34D
         mwPOhoX8zj1JT2o34AsxHa7g1kWrXlKyqZo4B12OymnG/M27MMOZOiT0ZqBIcj9nC5R8
         nEgHt4nRlVA9IBDe+fKF7fgMLJMJoAxtikpXI44H+hEZOFb1kQS4ccI3urifRwJofOu2
         YNBnw7a4es5sxt9ZeJGKY6WGELxoWRLrYJlPP0GAzQkQbAbpFKYrApa4HUSOepOQTWEw
         CfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ia9+/STEIK6s5M7yq5g28XApY0uGE7BS8OCfCM69b6A=;
        b=qVdUDTjBbmyRHpzPX4lJZvucT2eFcO6QsJAudRCSosrDRYmtzbKBPuWTwMeraKgmqh
         Phh9qSj/Z+c3BeoAY52b+LNwBFTlJH4mqOlfyfhdRfwFzgBnxvwj8C+aezDAwOP4WUPt
         XLMijvwiTrQ6k81LoOq0OJjoOd6c2akgwbR55LX8SyxQiUzzBvB/Deh5vuuKTfzi4Enq
         6UmUpMrw0pz8ANwuHF5w4TAyZlHa0kNp5j/o6Pcy97IDBpmfZXLnDMjyy+/TH82mQcDj
         GpcWbrqGGhTijgQBg/uCn/6yER1mIvMgoAIpWJ6cT/Q+XH7tuaEQu9MoVofaze9Xwa4e
         SkEQ==
X-Gm-Message-State: AOAM530qoY9tQNfmBDfcxk8P1a7ZBB3QJso8lnUhpLCfHcfvRssHqxCh
        oVgU3tMhNrvaH4u295d/rlmsDA==
X-Google-Smtp-Source: ABdhPJw2Mh1njoqbEPjpvRC2p3sOjeTsg/pWyOftIQWGeQ7ifA9CMlk2Fr9+xIAJq2EzH3psDacsUg==
X-Received: by 2002:a05:6a00:a92:b0:4e0:57a7:2d5d with SMTP id b18-20020a056a000a9200b004e057a72d5dmr8534617pfl.81.1649249734194;
        Wed, 06 Apr 2022 05:55:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm19647671pfx.81.2022.04.06.05.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 05:55:33 -0700 (PDT)
Message-ID: <263199dd-34e4-36ff-51ef-23a8f4bbe5b2@kernel.dk>
Date:   Wed, 6 Apr 2022 06:55:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] nbd: fix possible overflow on 'first_minor' in
 nbd_dev_add()
Content-Language: en-US
To:     Zhang Wensheng <zhangwensheng5@huawei.com>, josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org
References: <20220406112449.2203191-1-zhangwensheng5@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220406112449.2203191-1-zhangwensheng5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/22 5:24 AM, Zhang Wensheng wrote:
> When 'index' is a big numbers, it may become negative which forced
> to 'int'. then 'index << part_shift' might overflow to a positive
> value that is not greater than '0xfffff', then sysfs might complains
> about duplicate creation. Because of this, move the 'index' judgment
> to the front will fix it and be better.

What's changed in this version? Always add a v2 to both the subject
line and below the '---' so that folks reviewing this will know
what changes you made since the last posting.

-- 
Jens Axboe


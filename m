Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA257948D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiGSHum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbiGSHul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:50:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B433F1FCF0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:50:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b9so12793963pfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=PBjfaUdPj5evCqbgk7mF2+xOQYrjkKK5SCgiEZ6AFog=;
        b=4lwX7lH7voEKXllRjuXXIWuahCwdYq00XCmdkwgwHW+uSezLtuOHvA8XUQvxDoInJo
         1rmAKASBIbnytTQnjyuqU6+YQmfiHYm+FNy5r8SL6eqKkqOSjt8TdQ9HDs24ToNKISF7
         NmzKbGCE574fdSkm8oq0ADc0E6cNKtmh8dMY4gSahs3KzV0JkdP+5mj9Ujy7g+eXqiRa
         DTHm/ZV38rwMpVczuRD2ZMVyFTKBU+QTGiDi9ughNhOqUYWISMwj5zIFuHCHGtONvmfw
         FBvWAuvhWsrWY2AGdlrf3FfN522CyVSidLNB5LAhdlvnuE1ikmd5g5h3ISqwRGAEopQC
         5Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PBjfaUdPj5evCqbgk7mF2+xOQYrjkKK5SCgiEZ6AFog=;
        b=AcC0UaptOZlDL2+CvbL5jQ0X0GEZjs5l0nxDA2DR6Pf85ZcXPqRUva2zcYgrHq+hQA
         htSeq0nC1uQSbd77FKtrVCNl95zkfRrs7Q/5vA+zfPnTCifP7oaVDKKKtVwi5/JjtkQC
         PPhZ0oPwaurfgF6aGNVvQwnsyvu7MYEqS+spQY/sEK9tzG8yoD0nliY0CptFNmlxpRgR
         0gJFmJG4hadzlfOfq3bdliUevnLHHj0EEIGAEcchAzTy32s8uCY6E0ZLpzhGmaCVxKqI
         bNHWPKrsIQ6vEJtAeepV5PGhpm0SfxofiUNxb9kDd+2iRigxKRgDSAB19T4onTbHQ5Kn
         eaFQ==
X-Gm-Message-State: AJIora9uP00rvv6B1DRCxFFjq5LDpYLsNIeV9mppyRTE+0YoDAVgHh1k
        OS4ey5isTS+NoFAXf1rsnGtZdb4+3tfSyg==
X-Google-Smtp-Source: AGRyM1vBtNGhOqlnABScERkafYVTqE2igXFv6cNjIrRTf1iEGD63CGABSiMaSZWAvvbQNNxkE168Cw==
X-Received: by 2002:a05:6a00:816:b0:52a:dea8:26a2 with SMTP id m22-20020a056a00081600b0052adea826a2mr31996768pfk.36.1658217039223;
        Tue, 19 Jul 2022 00:50:39 -0700 (PDT)
Received: from [10.4.188.211] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id o21-20020a170902779500b0016be24e3668sm10779367pll.291.2022.07.19.00.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 00:50:38 -0700 (PDT)
Message-ID: <5b02a27a-72a1-501f-b06e-8963ebb34916@bytedance.com>
Date:   Tue, 19 Jul 2022 15:50:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] block: don't allow the same type rq_qos add more than
 once
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
References: <20220718083646.67601-1-hanjinke.666@bytedance.com>
 <CAMZfGtVLkO6T-0n7fMBTvR84Ji8GhTO5==u9v+8f+dRkJhFHMA@mail.gmail.com>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <CAMZfGtVLkO6T-0n7fMBTvR84Ji8GhTO5==u9v+8f+dRkJhFHMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review. I have saw this review just after the send of 
patch v2

在 2022/7/19 下午2:53, Muchun Song 写道:
> On Mon, Jul 18, 2022 at 4:37 PM Jinke Han <hanjinke.666@bytedance.com> wrote:
>>
>> From: hanjinke <hanjinke.666@bytedance.com>
>>
>> In our test of iocost, we encounttered some list add/del corrutions of
>> inner_walk list in ioc_timer_fn.
>> The resean can be descripted as follow:
>>
>> cpu 0                                           cpu 1
>> ioc_qos_write                                   ioc_qos_write
>>
>> ioc = q_to_ioc(bdev_get_queue(bdev));
>> if (!ioc) {
>>          ioc = kzalloc();                        ioc = q_to_ioc(bdev_get_queue(bdev));
>>                                                          if (!ioc) {
>>                                                                  ioc = kzalloc();
>>                                                                  ...
>>                                                                  rq_qos_add(q, rqos);
>>                                                           }
>>          ...
>>          rq_qos_add(q, rqos);
>>          ...
>> }
>>
>> When the io.cost.qos file is written by two cpu concurrently, rq_qos may
>> be added to one disk twice. In that case, there will be two iocs enabled
>> and running on one disk. They own different iocgs on their active list.
>> In the ioc_timer_fn function, because of the iocgs from two ioc have the
>> same root iocg, the root iocg's walk_list may be overwritten by each
>> other and this lead to list add/del corrutions in building or destorying
>> the inner_walk list.
>>
>> And so far, the blk-rq-qos framework works in case that one instance for
>> one type rq_qos per queue by default. This patch make this explicit and
>> also fix the crash above.
>>
>> Signed-off-by: hanjinke <hanjinke.666@bytedance.com>
> 
> The change LGTM. Maybe it is better to add a Fixes tag here so that
> others can easily know what Linux versions should be backported.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> Thanks.

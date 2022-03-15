Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4454D9687
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345992AbiCOIoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346002AbiCOIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:44:13 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3DCCEB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:42:58 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id b19so5446387wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SQaJGlyMxDxM92vESERhjv5rcWAKZ6ex7RCbOXz8fBQ=;
        b=cxkf+zwzED48eNZ3U9UMbxgxLBoDmyb/DDbCr62aZ8V3HYkteoeXj5stXxClB+qzi8
         TMu6uH/uLigXnPoKT0f60LyPulfejrGgaEaA0U2mOPR5B5eL8XylOgahcL9w4Buj4UlO
         N9tF8+X6C8bq17r1S15QQGuKcb4rOsnZQ99WtriWZ9mITbeD+kQIzz9/vCpltn6VoObh
         IV5V1k1T7LOLGQNjZW8xusU5PACsVx4qgamvQNVfUCzHd357iv8nFlokmf5j5fxEMjHV
         xImYq5foXMdfTNj9aoyZs/E8wxqOHKWTx/JMHzICG7PXVmovm4pCJMEb77VYPnDH4pl0
         NERw==
X-Gm-Message-State: AOAM5328StfStnSQ/wGKb6n05gFcH2dRveAtcsqHew3QuG65thLnb8KI
        nyymFn8aFgMi8v5AEkT3k47tSmGRylI=
X-Google-Smtp-Source: ABdhPJwz23JwJGrmvxcd66EAJx6dzWlFeuh9jhCzDYWmqMSJXBX+pe4A9nWcHI6GAH4fuHhjqvsRkg==
X-Received: by 2002:a5d:5986:0:b0:1f1:f971:f02 with SMTP id n6-20020a5d5986000000b001f1f9710f02mr18678032wri.578.1647333777502;
        Tue, 15 Mar 2022 01:42:57 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u25-20020a05600c211900b00389d4bdb3d2sm2517865wml.36.2022.03.15.01.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 01:42:57 -0700 (PDT)
Message-ID: <6ac83f8b-01e6-5394-0570-023ac6b1a71d@grimberg.me>
Date:   Tue, 15 Mar 2022 10:42:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
Content-Language: en-US
To:     "hch@lst.de" <hch@lst.de>
Cc:     Sungup Moon <sungup.moon@samsung.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220315071230.GA2069@lst.de> <20220315071926.GA2137@lst.de>
 <a3051d85-c08e-a273-c7cc-2eb3e21df717@grimberg.me>
 <20220315084035.GA3834@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315084035.GA3834@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> +static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
>>>    		unsigned nsid)
>>>    {
>>> +	struct nvme_subsystem *subsys = ctrl->subsys;
>>>    	struct nvme_ns_head *h;
>>>      	lockdep_assert_held(&subsys->lock);
>>
>> IMO it is a bit strange that we now don't pass in the subsystem but
>> require that the subsys->lock is taken...
> 
> We do things like that in various places, mostly because information
> needed that is subsystem-wide hangs of the nvme_ctrl structure, in
> this case the various feature bitmaps.  We could move them to the
> subsystem structure, which would be the right thing to do but a fair
> amout of churn for little savings.

Yea I understand its not universally enforced, just popped up.

>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -504,10 +504,11 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>>>      	/*
>>>    	 * Add a multipath node if the subsystems supports multiple controllers.
>>> -	 * We also do this for private namespaces as the namespace sharing data could
>>> -	 * change after a rescan.
>>> +	 * We also do this for private namespaces as the namespace sharing flag
>>> +	 * could change after a rescan.
>>
>> What happens in this case? we now have non-unique shared namespaces?
> 
> The non-uniqueue NSIDs can only happen for private namespaces.

But what happens if this changes upon a rescan as you commented?

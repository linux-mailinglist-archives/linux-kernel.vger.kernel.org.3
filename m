Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB274C81AD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiCADhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiCADhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:37:23 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080143614F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:36:43 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g1so12982294pfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yuF96zzT57twduJlHeKSD6TkuFieUVPnAsmNC4IsGOc=;
        b=gPI++ctiPbeOLDXHs2JCiOGa5xjh9jv/2cq+ReN80iq+oluvWXc6V2SliGXEJdyNlg
         wFKwEl6crL/rzy5g76d53W93Pnm7BY28bUvD7CS0S2yPCAFa8xe0hGEwJbbwQFmuvLfY
         oYz9vKATTF3DnzAWsegi9S8eiKRvI+kFsEZ0RdvsU/yd6hgv03eqIyI4quwquZqm6i4q
         pB8YYc1tcrXDPsKMqnDMuL8QLPBrE7ZWdXH4qnqEUpASo/+Z1qfysyLEUbM2ysqMqjXk
         sYp8/ha3IbCm3/D23uiUzcTPkQO2WKs0GJwlaAlXouwGG9oO/Bxp5Xsj/nzGKSvZYl4f
         JgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yuF96zzT57twduJlHeKSD6TkuFieUVPnAsmNC4IsGOc=;
        b=rfVmQErcauUlPwUGnswKswHIcrPczsocEGAHmapI//fiXqOFvmYaJxBo33ndfZ024j
         TPWDRWI3ipk8aJr0XC17zPSagElLkj4OWuAEMnVJVlo4loNIFHZh4cIK20WMtxcoe7RA
         Jz7kpQFNkNl3d4Hu6eL0KX7AJ7icTsM85SXUNq+WVK1zZ3W8/DW1k8RSUBvHPub7W0Nt
         EkvnXNpJZYthO4B0DMTdoduXISEXcafy8q/zumHOyu26nRkUAvDpY6RnD8QkNszgKzj3
         lAP1Kq2IM9U3thy1L71E4ZAybLC778D4cVguVyUwuLaO8m1TTJQxTTS1O+qWWjq2Qa6/
         fjzw==
X-Gm-Message-State: AOAM532WLVfz8zJ8SarpWa3BPdqZAR5Zqow7HjyAfNVewZQ87+c8FUYv
        y7+9mE0cd7SKEfkPoQ5YcKiZbw==
X-Google-Smtp-Source: ABdhPJywg+Sm8GNjdeMS62YMjsjTrpLvsDf+jafMIIarrfWMp6kDAFDQHsKYHROqVQdwlVoPNp5p1A==
X-Received: by 2002:a05:6a00:a8f:b0:4e1:2619:11a2 with SMTP id b15-20020a056a000a8f00b004e1261911a2mr25071872pfl.53.1646105802445;
        Mon, 28 Feb 2022 19:36:42 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u37-20020a056a0009a500b004e1414d69besm15344351pfg.151.2022.02.28.19.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 19:36:41 -0800 (PST)
Message-ID: <4100a868-c5bd-91dd-0c45-a92fb1344b12@kernel.dk>
Date:   Mon, 28 Feb 2022 20:36:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvme-pci: trigger disk activity LED
Content-Language: en-US
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
References: <20220227234258.24619-1-ematsumiya@suse.de>
 <20220228092215.GA8549@lst.de>
 <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk>
 <20220301033001.tozk6cakdznww6wi@cyberdelia>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220301033001.tozk6cakdznww6wi@cyberdelia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 8:30 PM, Enzo Matsumiya wrote:
> On 02/28, Jens Axboe wrote:
>> On 2/28/22 2:22 AM, Christoph Hellwig wrote:
>>> I don't think we should add code to the absolutel fast path for
>>> blinkenlights.
>>
>> Agree. It'd be a lot better to put the cost on the led trigger
>> side, and not need anything in the fast path for block devices.
>> Monitor disk stats, or something like that.
> 
> There's been at least 4 attempts to do so, as far as I'm aware (one of
> them being mine). All got rejected due to the complexity it introduced,
> that's how I ended up with this one-liner.
> 
> Performance-wise, I'm understand the problems, but according to ftrace,
> ledtrig_disk_activity() adds an average of 0.2us overhead, whether an
> LED is assigned or not. Is that really unacceptable?

On fast devices, we can complete a full IO in ~3us. If it's 6-7% of
overhead for that case, then yes, that is definitely unacceptable.

It's as much the principle of it. If it can be done in such a way that a
feature that almost nobody would use doesn't add to the fast path, then
it should be done that way.

What kind of frequency does this need to be toggled at? Surely not
hundreds of thousands or even million times per second? If it's suitably
low, then a registration scheme and a running timer would be a much
better idea. Each time the timer triggers, check devices you are
interested in and toggle the LED based on that. No fast path additions
for that, and it keeps the cost at zero for folks that don't need an LED
trigger for drive activity.

> If so, would introducing a CONFIG_NVME_LED (default =n) and wrap that
> call around it make it better? Then at least there's a chance to inform
> users that desires this feature about performance costs.

Doesn't really help, because then distros turn it on and we're back
where we would be if we didn't have a config option...

-- 
Jens Axboe


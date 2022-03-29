Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ABE4EAF54
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiC2OhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiC2OhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:37:15 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83EE6C93D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:35:32 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e18so12496493ilr.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=rLBlumatCz8Nv/UkESSqnWxm3zO0DFp2RxdbwYYI0O8=;
        b=JEl1nRoACe/wSyq6LaHoSG7pkYiTfT06Hda0r0IxVL7cbItcUSPKwL3vTuiCVBtGjn
         iSHJt2YHE9eAtkmUynfXR0TH0aycrNVZbgxMAQC2W//2BZCBjaOCAgRWBwE5klEXSyMT
         raW9Sf9DQoTFbLLHQqOoJXzmr4Mq9yYYaAGvrNZvEdQ1543dhGFxEZBJfh39TBZZDGW+
         x0fqHAVgc7Gq16H9VBZU/jJbHlQEVU28PHQSduZgFnqSIoW/4svir82FYFvoOTnvqkhQ
         8pBlO9KKKAIx8F7ntn5RkkJlkX6MnILwypkJlbnGjjgaLJYGTrKlSHm8bVl//Ph4BCQp
         hP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rLBlumatCz8Nv/UkESSqnWxm3zO0DFp2RxdbwYYI0O8=;
        b=K9HdkvxlDUJgou53sOmwD5i6JhT5c5ICQf+3/+YaTTYEK/lhgM+GoG3KJ7qMTFX/H8
         pBIukCBsjErzSQAyKFOlETXVJ4BiJRH03yvO1cV521GiSZbUbpItKtrCH+yrifkIv6e6
         C6nxDuJbRH8QpOo5uOYY3PgtqAlnoJU18hazxoEPtIR2V7Wf3bTwY9JI9e0YsWUBefgv
         irLwIzR/KwNO1tmJ46c13/msYL4QD7ngb2eQyCXysU5TS19YQ6CaeLPpG17mWCrGEdOM
         qfkWnHc4hy3gc7vNCwoAhTBY2P+rnHEroU914hWzhwT9VEehHqZ6cKBuTQReRgkrAfZ+
         VHTA==
X-Gm-Message-State: AOAM530DIbTLwOCBjQ4d9lNg/JTbZp0mgkFU9qpRb1rnpNb+U8o8wo56
        d0tWZZQ3a07ydKu2lTRYSt/z3Q==
X-Google-Smtp-Source: ABdhPJwvB2uNS2eYVlbU9ZG9C0in1gCWZPyFKG0lb1i/Sxihat/y41hzbfH2mqkS8Yz87AtD02R77Q==
X-Received: by 2002:a05:6e02:1b89:b0:2c9:c062:fc26 with SMTP id h9-20020a056e021b8900b002c9c062fc26mr4100863ili.215.1648564532020;
        Tue, 29 Mar 2022 07:35:32 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a22-20020a5d9816000000b006496d8651cfsm9327233iol.1.2022.03.29.07.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 07:35:31 -0700 (PDT)
Message-ID: <e46db33f-84a6-6d23-9be2-7429fec71046@kernel.dk>
Date:   Tue, 29 Mar 2022 08:35:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC 2/6] block: refactor to split bio thoroughly
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai3@huawei.com>
Cc:     andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
References: <20220329094048.2107094-1-yukuai3@huawei.com>
 <20220329094048.2107094-3-yukuai3@huawei.com>
 <YkMKgwsZ3K8dRVbX@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YkMKgwsZ3K8dRVbX@infradead.org>
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

On 3/29/22 7:32 AM, Christoph Hellwig wrote:
> On Tue, Mar 29, 2022 at 05:40:44PM +0800, Yu Kuai wrote:
>> Currently, the splited bio is handled first, and then continue to split
>> the original bio. This patch tries to split the original bio thoroughly,
>> so that it can be known in advance how many tags will be needed.
> 
> How do you avoid the deadlock risk with all the split bios being
> submitted together?

That too

> But more importantly why does your use case even have splits that get
> submitted together?  Is this a case of Linus' stupidly low default
> max_sectors when the hardware supports more, or is the hardware limited
> to a low number of sectors per request?  Or do we hit another reason
> for the split?

See the posted use case, it's running 512kb ios on a 128kb device.

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E314BA3C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242244AbiBQOzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:55:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240380AbiBQOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:55:34 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE632B2C7B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:55:19 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t4-20020a17090a510400b001b8c4a6cd5dso5619799pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Gtr/RxsviZ5tCz0Bvt9jFmBxJ4FzXAbaGSbJElz/Hlg=;
        b=RP7AQlvkfeyRpEygxSQlTGe6YiucyajrKNZ4j2hs8dxrxbOzhwdAjmuzMhSXrnPt1c
         sny5HzykjZTUwFYcF613btPpzWCTxDY1j5wRZK396jirf7OMFgu649fDpCFyebrafdeG
         RnSHJknmwSjudEtRmuN9INtjpMjAMBfnvhjFILCzmwDxH0liEGGIY5hPQzFOUwOxpnJY
         zy4U1fENYzFqWYZfBVexpReueospH8JHhAGfLUg9sSummfXjccAJxvdS2vlQIMoHXiIe
         FZn/OmNGkZPFj63d+yMQR67slCb6+k0EGJ58QDfqVCieoff++Ce4wWVz/akRdrferrbx
         sWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Gtr/RxsviZ5tCz0Bvt9jFmBxJ4FzXAbaGSbJElz/Hlg=;
        b=zMRjRMHMZsp4bLGTmPF9XEACUx9U9UteJUNflRMp8SNJ0QSbbnbh7xNIHGsQ3Hw8gD
         9dJFt1TN6hEF9Uy8Kwl1LEHCLJML01T6kPmjHLwxIx2L0jSNiTTt+yV9MfCT6kzeKEMM
         A6DvC/RQUNX+tES3zu/lZfpcWncWCx2R58dkAlHu4XFE5Z6piAm1lSEL7HPZMMuU61ET
         0YvMxKsWeA3kQQtyj66Aio9XWhXH4SpXvaHPyuWwLh53B3BIIB8NGoCtvU5FmMO1yqxc
         Y6kZgDCOSR3pbHXBQLaoTrgc3+0E2empFojBCsyf4opRfRFnVRHU0TTCQ9vLlkS0M4Ud
         hv6g==
X-Gm-Message-State: AOAM5329e80snR7kngd42RC3I49K1vlWWDJBnKf72biJ5q847wu2p7ZO
        MyN/b62kUARqabIBHPKmqxxQpw==
X-Google-Smtp-Source: ABdhPJxxN4fdtmNfBaNeeot2cudgg/6576pYDbt5buKEIhVRK6sNxrw74mPRD7B40QhIulki0+PgcQ==
X-Received: by 2002:a17:902:daca:b0:14d:7e1b:24af with SMTP id q10-20020a170902daca00b0014d7e1b24afmr3123388plx.167.1645109718763;
        Thu, 17 Feb 2022 06:55:18 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d8sm2040679pjr.29.2022.02.17.06.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 06:55:18 -0800 (PST)
Message-ID: <eb8e2477-d8f6-b032-6177-8ce187de12ab@kernel.dk>
Date:   Thu, 17 Feb 2022 07:55:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] blk: do rq_qos_exit in blk_cleanup_queue
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220216113212.83000-1-jianchao.wan9@gmail.com>
 <Yg392sqFydj9p3My@infradead.org>
 <96deb063-f4ef-fadd-543b-e905495898f6@kernel.dk>
 <Yg5VnRtsrrQX4mFG@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yg5VnRtsrrQX4mFG@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 7:03 AM, Christoph Hellwig wrote:
> On Thu, Feb 17, 2022 at 06:34:02AM -0700, Jens Axboe wrote:
>> On 2/17/22 12:48 AM, Christoph Hellwig wrote:
>>> On Wed, Feb 16, 2022 at 07:32:12PM +0800, Wang Jianchao (Kuaishou) wrote:
>>>> From: Wang Jianchao <wangjianchao@kuaishou.com>
>>>>
>>>> When __alloc_disk_node() failed, there will not not del_gendisk()
>>>> any more, then resource in rqos policies is leaked. Add rq_qos_exit()
>>>> into blk_cleanup_queue(). rqos is removed from the list, so needn't
>>>> to worry .exit is called twice.
>>>>
>>>> Fixes: commit 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
>>>> Suggested-by: Bart Van Assche <bart.vanassche@wdc.com>
>>>> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
>>>
>>> Ming had a pending patch to move it into disk_release instead, which
>>> I think is the right place.
>>
>> I missed that patch and can't seem to find it, do you have a link?
> 
> [PATCH V2 12/13] block: move rq_qos_exit() into disk_release()
> 
> from Jan 22.  Although it would need a rebase so it can be applied
> without the preceding patches.

Can someone respin that for 5.17 then?

-- 
Jens Axboe


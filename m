Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB0E4B973D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiBQDyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:54:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiBQDx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:53:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154B71D966C;
        Wed, 16 Feb 2022 19:53:46 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i6so3880206pfc.9;
        Wed, 16 Feb 2022 19:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=anu63ADScUWbvf9kEf9F61i07ll+gpD88rNiTggb59Y=;
        b=O4x5kUJYhlgOKQCP1W/ATa8vcxLZlyEmDrTCZVOvA3FEu2XISkxvNndUhTM6QNByoq
         8KMn4855joZ5MJDi6IuP8PivIe19NoRZNdS60cJeLnsUDZ6n4k0QwgSJnM+qRiI+tOdC
         2UGgpiOXgtqiQu4oKUkuR/Nurh74qOvYAxDanVJeEAlgUE38ROEv30j6edpwmm9Kbn93
         wgUyVsgOL3E3qtiiyfkxEswvdfwx65PoNyy/udyoQmxuumO8VEcfmpy/1DmiBkgJEVJ3
         0KiVcyWAP2VW1fh4Qx9QUL97Y8Fpup5v0QRAZfue/ZJwcc7C1ur/VHPyuTTBSzN5j7tO
         uatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=anu63ADScUWbvf9kEf9F61i07ll+gpD88rNiTggb59Y=;
        b=mqdEByVS+ERlCpdPIb/dX8krHvdFWT3/n8m+ceagiHsFAJM2fXd6TC91A7uRy260n/
         xqagStzDIECN7fq9ByAOZnemaep0a/F4SmU1dO9mZNObRu/2z8qpKGkvg2l4qtwWx00f
         3C6Ris3J/R/CrJucME7IcExPuubcVv3mnF45hFb+S0rVYFu9JzW9TvthwnPWvNMg7x6u
         zKk27s1GdD95FsyMybb5PHh7jTyskSribmhOMRVutiCMlPdaz5RFSOKw6upeMUoYT7Hz
         aFiSIAKp7vpP/ZB47MnrydDP8uzIxw6IcrHADtz4ed33IOM7ll24hqv3t1pHlfIWyAcr
         58Uw==
X-Gm-Message-State: AOAM533ZHtFGqyQ6YOo6l39tBo1jLf21GrWfqdEOsYRgxXffeixUVNx1
        Oj09FNMIQ8JgoR1zhgjTzO4=
X-Google-Smtp-Source: ABdhPJyGcrJCVxjkv5tQVr/9luHQAKul6vb98q+6FEFGBlevbqifCt8C31CkAnR1GXrhSgnzO+Rs3A==
X-Received: by 2002:a05:6a00:1787:b0:4c8:aca8:52cd with SMTP id s7-20020a056a00178700b004c8aca852cdmr1056850pfg.10.1645070025580;
        Wed, 16 Feb 2022 19:53:45 -0800 (PST)
Received: from [172.20.119.15] ([61.16.102.69])
        by smtp.gmail.com with ESMTPSA id z13sm6702847pga.84.2022.02.16.19.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 19:53:45 -0800 (PST)
Message-ID: <4b8864f3-c4da-88a8-2c62-39722ef7cd02@gmail.com>
Date:   Thu, 17 Feb 2022 11:53:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [RFC V4 0/6] blk: make blk-rq-qos policies pluggable and modular
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <f7936d00-a495-64b9-9497-7eb515d7c15b@kernel.dk>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <f7936d00-a495-64b9-9497-7eb515d7c15b@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/17 11:21 上午, Jens Axboe wrote:
> On 2/16/22 8:13 PM, Wang Jianchao (Kuaishou) wrote:
>> Hi Jens
>>
>> blk-rq-qos is a standalone framework out of io-sched and can be used to
>> control or observe the IO progress in block-layer with hooks. blk-rq-qos
>> is a great design but right now, it is totally fixed and built-in and shut
>> out peoples who want to use it with external module.
>>
>> This patchset attempts to make blk-rq-qos framework pluggable and modular.
>> Then we can update the blk-rq-qos policy module w/o stopping the IO workload.
>> And it is more convenient to introduce new policy on old machines w/o udgrade
>> kernel. And we can close all of the blk-rq-qos policy if we needn't any of
>> them. At the moment, the request_queue.rqos list is empty, we needn't to
>> waste cpu cyles on them.
> 
> I like this patchset, would be a lot more convenient and helps
> efficiency.
> 
> What kind of testing have you done on it?
> 
I have run blktests against this patchset in a VM machine along with a new test
case for switching rqos policies while running IO. 

https://marc.info/?l=linux-block&m=164506848620632&w=2

And also there is a bit different version running on v4.18 with more tests

Thanks
Jianchao

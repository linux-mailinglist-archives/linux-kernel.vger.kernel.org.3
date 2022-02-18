Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132634BB035
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiBRDXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:23:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiBRDXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:23:20 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF80E19DEA4;
        Thu, 17 Feb 2022 19:23:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id y9so7461499pjf.1;
        Thu, 17 Feb 2022 19:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MW5+mgo4D9khCYGp5XLA5oPQ58Fp8A7oXa2V6fKP9uM=;
        b=W07QPP/tHJTR8bjJO5DrwTh5c8QmIYccGHP5ZIOB6/7JKEV851Xtm6H8i2agDMa8w+
         SBMEUFBSFQfqwmfLXOZrXmRqdiVslMAX78G9jZLwMOpInCVYn3uBUytlrcpN1G9MNx0i
         1ON5kabHnTNkAqRBD7VydHfhwJinC3fcMVx0ay23PurBTXpye2CoK5xwBnceyXClj6Ow
         jIZhKfHG+w2VZJbHk3F57cqGY11eDY+zCj139f9NI9XOf25leto8RPD2AiPuKwd5LKha
         eRMckWRk1CHOcLQ8NXg3/FK0JyEpePbqo81rn7i6xj4ktGEY4dAKpk5FIb5PpzlkMMfx
         J6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MW5+mgo4D9khCYGp5XLA5oPQ58Fp8A7oXa2V6fKP9uM=;
        b=zTV7bwYPifgsLztCjNWP/aUDFODX6sTbbd8mi/1757ja4wEao1c5hqlxFWuTOXkkpI
         decOaGak4jiqDNIwv9fbnYehHu13cfZBgi7lxKltxG2DpvG/ASuHGESdU4wab5qfJsww
         C4R+Z999F9PdoTcGOd/qOED55a7EVvfmp2E8YskKWiIafrbFMhkMq34orh5/JXb7HPei
         gyErikFBLH71Om8mIcu3f2C2qYDmMGdeUJKJg9M5etVXlhk7e38qDBR39bxa3/QDOkEN
         8E6l+Zz4JI7VpCcFo0EYBKGvTRbupVMmPsT3YTkEZgw2C6ByF75qTXU0x5OHO0cL40dq
         bdYw==
X-Gm-Message-State: AOAM532Qkot31Tm4vFRJD4GeNX+9uaMCPZbAkDSDqdD9jckTqD3lDRsg
        n3eoJnMQhaVLiuEdid6sP20=
X-Google-Smtp-Source: ABdhPJxOlDrjpZULWDIBVYKDEt4Pj/bJESmO10QaNt1UpzaWgxRAAAyYaJNIyk7Njo3e0+lrinGVGg==
X-Received: by 2002:a17:902:e5d0:b0:14a:496c:6f2b with SMTP id u16-20020a170902e5d000b0014a496c6f2bmr5771373plf.57.1645154584467;
        Thu, 17 Feb 2022 19:23:04 -0800 (PST)
Received: from [172.20.119.15] ([61.16.102.72])
        by smtp.gmail.com with ESMTPSA id 8sm961000pfl.164.2022.02.17.19.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 19:23:04 -0800 (PST)
Message-ID: <ba4065ae-f663-9084-371e-4fdf401ac70b@gmail.com>
Date:   Fri, 18 Feb 2022 11:22:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [RFC V4 0/6] blk: make blk-rq-qos policies pluggable and modular
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <Yg4Kl6EHWS5N3WoH@infradead.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <Yg4Kl6EHWS5N3WoH@infradead.org>
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



On 2022/2/17 4:43 下午, Christoph Hellwig wrote:
> On Thu, Feb 17, 2022 at 11:13:43AM +0800, Wang Jianchao (Kuaishou) wrote:
>> Hi Jens
>>
>> blk-rq-qos is a standalone framework out of io-sched and can be used to
>> control or observe the IO progress in block-layer with hooks. blk-rq-qos
>> is a great design but right now, it is totally fixed and built-in and shut
>> out peoples who want to use it with external module.
> 
> And that's got.  External modules do not matter.
> 
> That being said this series has a bunch of nice cleanups, but we really
> do not need the exports and modular build.

Got it.
I will get rid of the code for supporting external module in next patch.

Thanks
Jianchao

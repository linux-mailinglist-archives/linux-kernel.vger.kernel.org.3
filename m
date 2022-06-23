Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35614557F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 18:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiFWQOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 12:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiFWQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:14:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA72F66A;
        Thu, 23 Jun 2022 09:14:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lw20so19775066ejb.4;
        Thu, 23 Jun 2022 09:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9my7BIzdQKToa872aa7K8z8zM0/VCCSMeCh7egVSNio=;
        b=Ux9NVpaU2IQ7ep9PCgOib8SWPuCzBnLbniwQpQq4VjL/lVfHWqlaUAVEJlQEoi6I4k
         GFS6oyhgLMQdPYK0qg12ic4Bfki7kq9zbe3TFIePJIiJaNsIpKVh5dW9bKH5FJfoiiK9
         NKg+iQL22lkle2begO9zG92plfkoFcpU2B92EJrWOnzPJnh5BE/te1FfDl4pgyC94QuG
         3Vfcl0H4Ps5ZpXJ81ErnzWeQfnk8pCUlHFsbBSnCOJNfXly7sHYpzb0TvP3BcPkLP3ac
         yqO9+n8SEnFlNyxJleg/zvYl0ejekqA/50r+PM2ZxPxRHJYKgmirGNurJap1SK1AWqto
         GHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9my7BIzdQKToa872aa7K8z8zM0/VCCSMeCh7egVSNio=;
        b=JOXN1mLUonXlLaspD/pEQ5riYTBn8gB56uKcVVbEBnzD89uH/ESSyBo+lL0w6QH6Rn
         ENy2+7vl3JPt+RJ2ig7fem4Q7FsrjP+bb/PFO0/uK62wHflmHf3gizI0w+4r85baXyMc
         OL2PClWOUW/0dBRId5dygJeeekzGTT1S4YXBwzZwRr74CpwSe1pvCO07y8wTn0qOww3p
         GBVD+mA16PEi1MECuxQTOsOk33hnMa2eUpiF5BiRWvGpjUgzM09/H1uTH19yaiEs7QTp
         4FAKBOF6MhkNJtqKQhHqIcduQQp1S+2+yHfOS95LMEOG2fH/Ln4kR3t/ps0NYIXiZlAx
         WEbA==
X-Gm-Message-State: AJIora/F3neS0pjtYRey4+u3cTJ2NIgiccPSznyTn+jFpOCoXSJI4WyE
        bZAiJa/3nxrWAu2OEDUe2io=
X-Google-Smtp-Source: AGRyM1uT1nDTwnky+9bdNC1MBSakR5BvTEtg4Siws+lF99x5ZK41M/uHh6qfe4X3LFrFyNyGYrsHpw==
X-Received: by 2002:a17:907:7f8b:b0:721:9c02:37f1 with SMTP id qk11-20020a1709077f8b00b007219c0237f1mr8914822ejc.211.1656000889827;
        Thu, 23 Jun 2022 09:14:49 -0700 (PDT)
Received: from [192.168.0.182] ([79.119.98.153])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709063d2200b0070759e37183sm11161525ejf.59.2022.06.23.09.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 09:14:49 -0700 (PDT)
Message-ID: <54bfff70-938f-16e1-198d-47ed9ba95db4@gmail.com>
Date:   Thu, 23 Jun 2022 19:14:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 2/2] iio: adc: ad4130: add AD4130 driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220620162059.1097264-1-cosmin.tanislav@analog.com>
 <20220620162059.1097264-3-cosmin.tanislav@analog.com>
 <CAHp75VcBJkQ+CwyoDaTJ_AD+mv9d0tEd_txqHwkPRy4-xvnyKg@mail.gmail.com>
 <2aa93eab-de6d-866b-a829-36b47ff00982@gmail.com>
 <CAHp75Vc_fcAP6gGwMkYZUoMM6jKeUoQr8J+zYCUz8inSHnTF_w@mail.gmail.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <CAHp75Vc_fcAP6gGwMkYZUoMM6jKeUoQr8J+zYCUz8inSHnTF_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/22 18:39, Andy Shevchenko wrote:
> On Thu, Jun 23, 2022 at 5:27 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>> On 6/20/22 21:29, Andy Shevchenko wrote:
>>> On Mon, Jun 20, 2022 at 6:27 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
> ...
> 
>>>> +       /*
>>>> +        * DMA (thus cache coherency maintenance) requires the
>>>> +        * transfer buffers to live in their own cache lines.
>>>> +        */
>>>
>>> This is a good comment, but what fields does it apply to?
>>
>> Whatever is below it, grouped together. This is not hard to
>> understand.
> 
> It's hard to understand what exactly is DMA-aware here. I see only one
> buffer that is aligned properly for DMA, the rest are not, except the
> case if all of them are going in one DMA transaction. Is this the case
> here?
> 
>>>> +       u8                      reset_buf[AD4130_RESET_BUF_SIZE] __aligned(IIO_DMA_MINALIGN);
> 
> This is aligned.
> 
>>>> +       u8                      reg_write_tx_buf[4];
> 
> This one is aligned + offset (== AD4130_RESET_BUF_SIZE + 0).
> 
>>>> +       u8                      reg_read_tx_buf[1];
> 
> This one is aligned + offset (== AD4130_RESET_BUF_SIZE + 0 + 4).
> 
>>>> +       u8                      reg_read_rx_buf[3];
> 
> This one is aligned + offset (== AD4130_RESET_BUF_SIZE + 0 + 4 + 1).
> And this is Rx.
> 
>>>> +       u8                      fifo_tx_buf[2];
> 
> Here is Tx again which is most likely is not aligned...
> 
>>>> +       u8                      fifo_rx_buf[AD4130_FIFO_SIZE *
>>>> +                                           AD4130_FIFO_MAX_SAMPLE_SIZE];
>>>> +};
> 

This has been mentioned before by Jonathan as a reply to V6 of my
AD74413R driver.

 > I'm surprised I didn't mention this before but you only need to 
ensure  > that any memory used for DMA is not in a cacheline with memory 
used
 > for other things that might change concurrently.

To my understanding, as long as the DMA buffers will all be accessed by
the same DMA-compatible SPI controller, you only need to align them so
they're not in the same cacheline with memory that will not be accessed
by the SPI controller.

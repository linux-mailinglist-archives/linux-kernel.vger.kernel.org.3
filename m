Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53EB4539F8F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350686AbiFAIdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344920AbiFAIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:33:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C068C590BC;
        Wed,  1 Jun 2022 01:32:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so3359251pjb.1;
        Wed, 01 Jun 2022 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wYKrercWjjwhVcq5zwRz95bnyrViR728O6OmqX4hnKc=;
        b=jChRG5M+RIX7K5ln36MT/cnUVEnd4wFwyPwT0OluWvMa5hrBJNs+M0+WCsfgXKow7O
         QNcD9y4BXQmJbLFRNWuLlw6Z5pzLOgpsPH0brJ8FLmpKEV0tevpleWMYek3ZzI9iALJM
         bIO0yIbzWMZmBfgODAoQlrxtpNMfND1StkhLQeC63u3lObVM/JH22DQj7qRRXURzQ6L2
         6Hau+v76Cc65gtLw/tHtxaqMKWx+vP2MrNUh0EBQfrPVDuRohg9nsPeZRr0cg2o7cPkB
         6/+nSgLTEGZ/iXcdSA6tSgXsSQZhgudTS+0QK0yFdyblYPWKmdqyBhKf2Kx1gNXSf62k
         kPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wYKrercWjjwhVcq5zwRz95bnyrViR728O6OmqX4hnKc=;
        b=rAAY13u0XSnZWLu5CbDBRG8ukDF2gxj3UB8htl7IDIYVxtAKL43VdoJ8m8A2OBOINd
         8e+VWqMQdLVwaP88cYb/tOkGHk/tikgfW3JI7Krdzk0h2TU3sPzIX72paqNU+Fu91/yk
         OJE/cM6L2ZbzzZIaFasuIbjPOW57+NbxrLUbepMfIyueQtx67TKEBr49O0SPbSGebNQ3
         Xskp4WT99+Fmxj/K9ZII3ECAEWxFHUHoDMo6LF0jKL3o2Yxll//tUFD4d2u3aczX72hS
         3UuETrBfusSh/2OlHebExO0clh5Q0fADgSVUV7nOZBo+vV6+oJhkY1zVQ3gU+8dV/Jji
         S0NQ==
X-Gm-Message-State: AOAM533HwFd+631D2bT389GVKjfGiVHFo0VcFe8D7e7P84cCcCJiplfn
        liT+tytqnc4jaOcV3B5T2gV9Pvbpq6k0CcOI
X-Google-Smtp-Source: ABdhPJw8n510jrR/IrcT0pJGTXpYydR0zo1E7nsV1+TzjU7/bNiHq7F1xyds6O/jydFgysFav3c0Mg==
X-Received: by 2002:a17:90b:3803:b0:1e0:da02:b903 with SMTP id mq3-20020a17090b380300b001e0da02b903mr33041377pjb.125.1654072379055;
        Wed, 01 Jun 2022 01:32:59 -0700 (PDT)
Received: from [172.16.4.4] ([106.39.150.114])
        by smtp.gmail.com with ESMTPSA id h26-20020a62b41a000000b0051843980605sm837388pfn.181.2022.06.01.01.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 01:32:57 -0700 (PDT)
Message-ID: <a2076725-acc6-c84c-91d5-acabd138264b@gmail.com>
Date:   Wed, 1 Jun 2022 16:32:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] v4l: xilinx-vipp: Fix refcount leak in
 xvip_graph_dma_init
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
References: <20220601042514.61780-1-linmq006@gmail.com>
 <YpcWf46fAJcfIgIt@pendragon.ideasonboard.com>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <YpcWf46fAJcfIgIt@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Laurent

On 2022/6/1 15:34, Laurent Pinchart wrote:
> Hi Lin,
>
> Thank you for the patch.
>
> On Wed, Jun 01, 2022 at 08:25:14AM +0400, Miaoqian Lin wrote:
>> of_get_child_by_name() returns a node pointer with refcount
>> incremented, we should use of_node_put() on it when not need anymore.
>> Add missing of_node_put() to avoid refcount leak.
>>
>> Fixes: df3305156f98 ("[media] v4l: xilinx: Add Xilinx Video IP core")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
>>  drivers/media/platform/xilinx/xilinx-vipp.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/media/platform/xilinx/xilinx-vipp.c b/drivers/media/platform/xilinx/xilinx-vipp.c
>> index f34f8b077e03..415579b63737 100644
>> --- a/drivers/media/platform/xilinx/xilinx-vipp.c
>> +++ b/drivers/media/platform/xilinx/xilinx-vipp.c
>> @@ -483,10 +483,12 @@ static int xvip_graph_dma_init(struct xvip_composite_device *xdev)
>>  		ret = xvip_graph_dma_init_one(xdev, port);
>>  		if (ret < 0) {
>>  			of_node_put(port);
>> +			of_node_put(ports);
>>  			return ret;
>>  		}
>>  	}
>>  
>> +	of_node_put(ports);
> We could possibly simplify this a little bit by initializing ret to 0
> when declaring it, replacing the "return ret" above by a break, and
> returning ret below. This would remove the need for the first
> of_node_put(ports) call above.
>
> If you think that's a good idea I can make that change when applying
> this patch to my tree, otherwise I'll take it as-is.
Thanks for your review, I think your idea is good, we can do that to simplify code.
> In either case,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
>>  	return 0;
>>  }
>>  

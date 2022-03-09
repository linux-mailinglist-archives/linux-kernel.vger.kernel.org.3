Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B87D4D2B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiCII5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiCII5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:57:00 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E2913D93A;
        Wed,  9 Mar 2022 00:56:01 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id o6so2068668ljp.3;
        Wed, 09 Mar 2022 00:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=eUO4BGCaHboPB9N2fBYoX3A2M2dDMMg+0HewNmnIXKc=;
        b=gbqbUGFvb70GD0V2bZc3URsu+T8NPOBppil+SFoXn09tdFA05VAVpBh/bfkBu1/9lo
         Fk8TphEuHbhKEhmC+0GrksUvfsLDOpZ+C1TV8bqqysAqWfWe/GWmS/0IUAMzUanhgw4l
         Ac34ADwn7q6XlZT8LrfY6TTpVX4nZzzeptNRozhRZXPEZUr9Gw+DJP0pCKn9eB87+/iy
         gXuJUkw2LquAXrjAXOOt4yrS3ga7xvHow08mDqahb8BsT9ghV+UdgwPcqSIY/5M/o37e
         AwYOYW3H9H+4rNJ5rGvfbXyXHkvezAjiVky75b3P2cxCHT66TVd8zSxdScc9PSiGzxSG
         raqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=eUO4BGCaHboPB9N2fBYoX3A2M2dDMMg+0HewNmnIXKc=;
        b=ydZKsW71xVUd2uT8SfRz1Fyhk0mWVwu+2UeF/20MtnehWA3kTKeQpcG8d6MIzcihf7
         ey/Hui4olthveuh+5gNWzhe88vXoe/zLr/fL0/+BtEzYX5tKeYBMHe/X86vc15kXVTRM
         kVoBJNabkzBXqPoSUZtk/zrFlG9WxxR+L6U7yB9Cs0b5JbSk0KBM0JtGUHfMKDKG00uc
         2GzKg42MDy+5OQxP+Mi24Hx9vLnCtEf3UsrZXvpf4gVkwNQWPpIqbJHCKsNOunC41Jjo
         NR8zQW/XydNgykaJuFc65WJB6DS9o/lJkZFlYzZMEmOYndtoaE7FN/h1fg+3R96MtVNj
         lUOg==
X-Gm-Message-State: AOAM5302Y+VpSZ1QOHvka/5mRVvvYJNdhNn6PJ+IXORJ3hgZma3M1K99
        C2ulf+qvC+Dqwt/wQGtVq78=
X-Google-Smtp-Source: ABdhPJzQokymwwpJtDj+y874/n4npMzlLNf1Wu+AlXoLAGebFh4VS0dnIjoY+oFRQ65GB1XeVOyktQ==
X-Received: by 2002:a05:651c:542:b0:247:f648:be47 with SMTP id q2-20020a05651c054200b00247f648be47mr3775657ljp.11.1646816160029;
        Wed, 09 Mar 2022 00:56:00 -0800 (PST)
Received: from [192.168.1.100] ([178.176.79.30])
        by smtp.gmail.com with ESMTPSA id t10-20020ac24c0a000000b004482e94a3b5sm280159lfq.16.2022.03.09.00.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 00:55:59 -0800 (PST)
Message-ID: <d4f60079-9a99-c8e6-4a3c-4c77597cc151@gmail.com>
Date:   Wed, 9 Mar 2022 11:55:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V3] ata: pata_pxa: Use platform_get_irq() to get the
 interrupt
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        cgel.zte@gmail.com
Cc:     chi.minghao@zte.com.cn, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, s.shtylyov@omp.ru, zealci@zte.com.cn
References: <d1dfb244-eda3-b5c6-c6bd-c0294a9a4a94@opensource.wdc.com>
 <20220309072834.2081944-1-chi.minghao@zte.com.cn>
 <4ce9ad67-7102-1ad8-2726-5e96aecfde80@opensource.wdc.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
In-Reply-To: <4ce9ad67-7102-1ad8-2726-5e96aecfde80@opensource.wdc.com>
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

On 09.03.2022 10:31, Damien Le Moal wrote:

>> From: Minghao Chi <chi.minghao@zte.com.cn>
>>
>> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
>> allocation of IRQ resources in DT core code, this causes an issue
>> when using hierarchical interrupt domains using "interrupts" property
>> in the node as this bypasses the hierarchical setup and messes up the
>> irq chaining.
>>
>> In preparation for removal of static setup of IRQ resource from DT core
>> code use platform_get_irq().
>>
>> v1->v2:
>>      - Use more specific in the subject: ata: pata_pxa:
>>      - Switch to returning 'irq'
>> v2->v3:
>>      - drop the unlikely()
> 
> Looks good. FYI, the changelog above should be placed under the "---"
> after your Signed-off-by so that it does not stay as part of the commit
> message. No need to resend, I will remove this when applying.
> 
> Sergey,
> 
> Review OK ?

    Yes.
    Although, strictly speaking, we still need to check for IRQ0 as well...

MBR, Sergey

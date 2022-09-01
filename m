Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E915A9137
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiIAHuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiIAHtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9E311EB70
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662018518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5jcSdT0P6afRsEiScMWA2XdjMc9EYOIodZqy6Femx3w=;
        b=CppT8B1MzTDYlVvM+ARFHoHjcEI3YKVvFUEhqszYUxs3d2IjOu9wLl8OuwJoLrmhbPlBB4
        1TsWqzFuWOdWflaJAZBzwfLlsoJ0eTYaWSAZZbRlIUpR3q+CNZu1Q0Us+yByXr5WrR6n4x
        w/J1v+cYJp7K4BNywfygfipJZDqX8g0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-65-OfrdmBsQMIOK9HdKa_IndQ-1; Thu, 01 Sep 2022 03:48:37 -0400
X-MC-Unique: OfrdmBsQMIOK9HdKa_IndQ-1
Received: by mail-wr1-f72.google.com with SMTP id j4-20020adfa544000000b002255264474bso2851507wrb.17
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=5jcSdT0P6afRsEiScMWA2XdjMc9EYOIodZqy6Femx3w=;
        b=7R++6IGmZikWfGg4LmkrJ4+pb+5C6OveyFAzypTxyMnxK3dje80QyN+GCs/luL76Lu
         4ino1v9cXLOL9sbMx6ArGJh4aaXo31cB4DNefVqACcA9F8BcyAsNqIW2XS1t/R58GeLE
         e+rkMb5DR+i/hwxyQlRxEgTt0g/uGIl1mj/FpuejBaKE/AQiL2GX3jEscrBxB6INZnrw
         TzwySX9mjzV6MhClyrwckbde0p6r3j8Dr1dTOPbPFJDo79exbJ654RJMnUhpfz4nLadl
         Kd42h8UfVi/nflvBWg/ZfR8uevofp50OEkJJLzKSZAq4lGKaEPxHC/JlIPD95Wt8TPu7
         P4qQ==
X-Gm-Message-State: ACgBeo0tah4K2Q4Na9E0k/sauvogdElu2OPIVQk/Ep74GaT9PqWZOMQu
        NuWQMgj4z1qot7ch9vGzyBJy4TWY0wYHusq/s92KC6FjqwP/QQtku3/CkzkiEc3ZTOtF4IkKBE3
        fAlexph0JdCMs4NkmdxlnMpfj
X-Received: by 2002:adf:e10c:0:b0:225:3168:c261 with SMTP id t12-20020adfe10c000000b002253168c261mr13639582wrz.159.1662018515966;
        Thu, 01 Sep 2022 00:48:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7R1Nq9kE4sH+4OKj+aaG4a+EvhvYKEWfGMfPstByKgi89eFpj8PgtRAOeRshfA8K3CoZWEQw==
X-Received: by 2002:adf:e10c:0:b0:225:3168:c261 with SMTP id t12-20020adfe10c000000b002253168c261mr13639568wrz.159.1662018515709;
        Thu, 01 Sep 2022 00:48:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:9e00:fec0:7e96:15cb:742? (p200300cbc7079e00fec07e9615cb0742.dip0.t-ipconnect.de. [2003:cb:c707:9e00:fec0:7e96:15cb:742])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600c4e0b00b003a50924f1c0sm5271109wmq.18.2022.09.01.00.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:48:35 -0700 (PDT)
Message-ID: <df6f3926-da31-9361-b19e-e19ac3937ebf@redhat.com>
Date:   Thu, 1 Sep 2022 09:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yuan Can <yuancan@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220901063725.24220-1-yuancan@huawei.com>
 <0e2ea2d8-5b0b-107a-c679-7d5a7e37718f@csgroup.eu>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: remove extra empty line
In-Reply-To: <0e2ea2d8-5b0b-107a-c679-7d5a7e37718f@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.22 09:37, Christophe Leroy wrote:
> 
> 
> Le 01/09/2022 à 08:37, Yuan Can a écrit :
>> [Vous ne recevez pas souvent de courriers de yuancan@huawei.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Remove extra empty line.
> 
> Don't you have anything more exciting and usefull to do in your life ?
> 
> This kind of standalone patch is a waste of time for both you and the 
> reviewers/maintainers.

While I agree with the general idea of that message, we could phrase
that a little differently I think, after seeing:

 $ git shortlog -s --author "Yuan Can <yuancan@huawei.com>"
     2  Yuan Can


The linux-mm list is currently fairly overloaded (lots of new material,
reviewers/maintainers having a hard time to catch up), which is why such
simple cleanups that could essentially be done semi-automatically by
tooling (coccinelle scripts ?) are not of general interest and rather an
unpleasant distraction for reviewers/maintainers.

-- 
Thanks,

David / dhildenb


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CDD56C00A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbiGHQVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiGHQVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:21:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9E364D7;
        Fri,  8 Jul 2022 09:21:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l124so13526004pfl.8;
        Fri, 08 Jul 2022 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M2aoSokBLCYPbBjm+wHXpd3xRs663JjZw7y2yCoEjIk=;
        b=SS68MlvF9YrmGrBs6VwKYWvOfU9VokMkrO1J3XoqHC8DT0pTyNg+uT3ktP0WMSJsXs
         rdYRmD8Y/u5IvMz0sV8N1+7R43TItC2LZdQlIAWM5iEItArFDQLQpM3gacfug88a5hZt
         2FMD3abr8a709V1kAfKZEO+i5rd/Q67hjc7rjg1ZXcMWJIAyy8xosLm5Qsg/UFqfsYFu
         Nh8YzfA14OKNmDiCce5ZaAx/6R5ihrZ5EkcqnoQ2M3zeneMVTjmDKJ3F4WOt0nU1bA9n
         nkZMzmb1wI/OM3smP323Zd67g5VfGps9Na8z0AcLw+6mAE6YgEohcoSqIiUwWeq8rPpr
         ZQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M2aoSokBLCYPbBjm+wHXpd3xRs663JjZw7y2yCoEjIk=;
        b=4AHTzP8heDWIKPE+A4yl09bLPbJ6XyUdz4S3YUEcg6aNc6aXS4rLI0gQA5nK9nD/wS
         sEzh1c13mzTm3syKTV9E04iIx2YvAuednC5DbqZogTHL8gPiRLWrkLO7C8+EBroo4Mz9
         YM3WHM5zH626o+V9I0D+SD0K+l4qS6HA2kv/M98jsY6qtOGxvRzvuoWgvRHDx5v9NWYL
         lSqilUI1E+BabmYFporSnc6mQAqotv9OWz5oRmhPhyDrCrcM23akybo92uA5MuuVO7uG
         eRIERiDdbwM7DumFEFSl1rOtJxQyONK4bftXW2HRptpVXy4COAfJXVa7Kub3S/750Api
         qT5w==
X-Gm-Message-State: AJIora/psTOzwaQL8dz+Q5E8MZS64rLs2lggPZmWqClnQDy0BidmY6sM
        32NI2xJRkrX9F73LVoVejFM=
X-Google-Smtp-Source: AGRyM1s7gQ+8EBt8JaBQHvrtqSUB1FKBiK23I/bsfMU3WnKkyeBpPtkJpgg1ViUKGv956HekWpSuZQ==
X-Received: by 2002:a05:6a02:113:b0:412:a7c0:da8e with SMTP id bg19-20020a056a02011300b00412a7c0da8emr4121437pgb.113.1657297304947;
        Fri, 08 Jul 2022 09:21:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i9-20020a170902cf0900b0016beea47800sm8923460plg.41.2022.07.08.09.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 09:21:44 -0700 (PDT)
Message-ID: <1d7a028e-55fb-d93c-97b7-750743db4dba@gmail.com>
Date:   Fri, 8 Jul 2022 09:21:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] MIPS: Make phys_to_virt utilize __va()
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-mips@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        open list <linux-kernel@vger.kernel.org>
References: <20220707203743.1226302-1-f.fainelli@gmail.com>
 <20220708123454.mj7f3gdzk3ct6seb@mobilestation>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220708123454.mj7f3gdzk3ct6seb@mobilestation>
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

On 7/8/22 05:34, Serge Semin wrote:
> On Thu, Jul 07, 2022 at 01:37:42PM -0700, Florian Fainelli wrote:
>> The implementation is exactly the same, so avoid open-coding it in two
>> different locations.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Seems reasonable. Thanks.
> 
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> *Note it now looks exactly as the generic phys_to_virt().

True, though switching to asm-generic/io.h is a slightly bigger 
undertaking. I will cook something towards that goal however.
-- 
Florian

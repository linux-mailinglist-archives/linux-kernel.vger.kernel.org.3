Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44D4560121
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiF2NSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiF2NSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EECD228736
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656508724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nK01Y1w7lfHB9EdYPYxV2v2lKj3XDdhDR/M3ipy/gM=;
        b=Q+TubkTkKDRVYluifwQAGdAEEkil/5rfuoNI6f6/qbkK2fhGBifFDpNtTuVgp1X7stK4zv
        XpQ+QYRCwPXlsxLZT4UjBKa2x2I1emefkPL5qU3UeEIh4cP++GnADctftpXcu3RkSc2Zp6
        4xzE4tRKn7kUyyAnYxWHaC2GJTRInlA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-VtNhFkw2NPK_rURjVQV73Q-1; Wed, 29 Jun 2022 09:18:42 -0400
X-MC-Unique: VtNhFkw2NPK_rURjVQV73Q-1
Received: by mail-ed1-f71.google.com with SMTP id z19-20020a05640240d300b00437633081abso10219352edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7nK01Y1w7lfHB9EdYPYxV2v2lKj3XDdhDR/M3ipy/gM=;
        b=XAtMz7oE90SFjmyt2FVo27y7nLCfnj823DM/esnhOWSUvSMkGCjgybayItftQBWrTN
         oLFvX2tL3VYe+EC7YTXGg3YA9TTIYliq87T37jUX9M+Zv8frgtqjXKQNqZidRYfJ01iQ
         1VfFhfFqwaqITKuiqMD66tvyq9ZaBxDEy8ttwmkFbh8Re4EW1NN1XfheavnVTx+HLic5
         /jCY1GJxa5TP534UeLkQN7UotP/HznjXDzpz5MriZ236ZOJHjQB/y8xRWSspMTZ0EPBC
         TndMr6VDcX0NukhW1GH/Onu9QpZUIveJySrAM6walTDzOF/ADeGfPCJ8GI1RCubSTRWo
         D0bw==
X-Gm-Message-State: AJIora9EKHwF/C8QS+ZKoYP4Nn+5EB/H2l6bYkBNk+kCWZ49H7Qvv0v8
        ge0VfWNPYFRvwjg97/CeLoCUXUhIIY8Y/Kg4kSEQRVoSe1pTninDxTXXT5f8q90hFQOEHJjFiKa
        EYBRuRW3/o6tpvZrKZUCRqhkB
X-Received: by 2002:a17:906:5512:b0:726:be2c:a2e5 with SMTP id r18-20020a170906551200b00726be2ca2e5mr3274570ejp.88.1656508721327;
        Wed, 29 Jun 2022 06:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vQoJbi5uj/L9jTROmpLMd8CBB1u89OFhpLp4lCvdG07wKj6WUePeQj4QWQUljkC4sbwB3kGA==
X-Received: by 2002:a17:906:5512:b0:726:be2c:a2e5 with SMTP id r18-20020a170906551200b00726be2ca2e5mr3274560ejp.88.1656508721193;
        Wed, 29 Jun 2022 06:18:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id jz18-20020a17090775f200b0070fd7da3e47sm7739972ejc.127.2022.06.29.06.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 06:18:40 -0700 (PDT)
Message-ID: <35153061-0d52-1c77-5921-e8ea0a662b3b@redhat.com>
Date:   Wed, 29 Jun 2022 15:18:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <81201d93-ffc5-024c-c132-36f91d9e663e@redhat.com>
 <YruJk4aAmFo/mihX@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YruJk4aAmFo/mihX@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/29/22 01:06, Andy Shevchenko wrote:
> On Mon, Jun 20, 2022 at 11:04:38AM +0200, Hans de Goede wrote:
>> p.s.
>>
>> I've added this commit to my local tree, so that the next time I boot
>> a device with a CRC PMIC it will get some testing.
> 
> Have you had a chance to boot such device?

Not yet, but I've just put a new kernel on one of these devices
and everything still works fine AFAICT:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


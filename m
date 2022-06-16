Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE5154ED3C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378904AbiFPWYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378814AbiFPWYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:24:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AD861616
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:24:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u12so5314032eja.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s5OVQxNBYmyEQ0OmaCMiLE8dcvy12XT+9uj6YfV0c7M=;
        b=V7kHqBNdSi12xPeBhfaIA4C8WeNusqT1JThDMUUuzy19EBFoEVKJ2/UNjtsY2Bij3C
         GBj/s38zp3vbo7WX6a6J8u49ZDbEa+otOpNDdO47/SHcGcOS4mXzF2NKcKolLkODp7ZV
         G/kLA8v2g0bhg7Kmz4GIsP+2JTFbKAU3l4/YpidzxaFtGu2zoHmFddvquR0xqseNCXkg
         +RYWGp+PogNA/lcHTt4BEZie4ySvZ/bH7rZXJGnTe69Bj5stpStnFXnfcgOBI3hPaXV4
         /+Zgqdl3upX3iupiljH/6MBjdh2oNFFjaSNh8j85KA+tikFQH/bCfhW22iQ6HNUgNG5C
         zllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s5OVQxNBYmyEQ0OmaCMiLE8dcvy12XT+9uj6YfV0c7M=;
        b=ZqybNTIGFOhwV3v6wfwlgCbpLtSpiPlZ/o2gihLVszPvJqsoyFEMgWAb5Mww3SuSEN
         F/XW0mvGLJ3gl9Cjh23LJwqYOoushctiX69ELpjYm0Ih+mNaUo65swWax9r4K/3T6Mq1
         EZ8uWCntEp+mHZdjYNOrmNTaGaH0dgvXO2eFOIAjfLzm1IMvSd4JwdC1/u5m/DctjURK
         t266LhF775Sw0YGNQ0R/F/yBDiK7a9Spu8k1ZG7BpLjuH5gNWXf8IhkifxaRx2OOnu2a
         mMVThk9fefPAmNITnHJTZFv6Z06d2pdaHPVXZjY5Fa3Iehke8nF3UrZBS6bBd4mHi0ju
         sZTw==
X-Gm-Message-State: AJIora9Qi5RhqQlAP/C988XUryIGMHp8qd5yeFembQGkNYy5DJ5i12LU
        KB8KyL9m27cJTac1IaJ4o+SWww==
X-Google-Smtp-Source: AGRyM1v4PTRpYJnGjT6DqWqt/rtDzyXA3kNaGhkSm5VBADyv1wVpQ5I4Cr3z61H+DiLds+uhcpAkVQ==
X-Received: by 2002:a17:906:d84:b0:715:7f3d:403f with SMTP id m4-20020a1709060d8400b007157f3d403fmr6646452eji.406.1655418256867;
        Thu, 16 Jun 2022 15:24:16 -0700 (PDT)
Received: from [192.168.1.12] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id c26-20020a170906171a00b006fed9a0eb17sm1249215eje.187.2022.06.16.15.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 15:24:16 -0700 (PDT)
Message-ID: <aa1334b2-49db-2425-6895-c186566374e8@linaro.org>
Date:   Fri, 17 Jun 2022 01:24:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] venus: Add support for SSR trigger using fault
 injection
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, quic_vgarodia@quicinc.com
References: <1655377322-14195-1-git-send-email-quic_dikshita@quicinc.com>
 <CAE-0n51HOy84c9osif0wXd90c5D_MQZ=9sa1g93iZHG3mWxREA@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
In-Reply-To: <CAE-0n51HOy84c9osif0wXd90c5D_MQZ=9sa1g93iZHG3mWxREA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dikshita.

On 6/16/22 21:37, Stephen Boyd wrote:
> Quoting Dikshita Agarwal (2022-06-16 04:02:02)
>> Here we introduce a new fault injection for SSR trigger.
>>
>> To trigger the SSR:
>>  echo 100 >  /sys/kernel/debug/venus/fail_ssr/probability
>>  echo 1 >  /sys/kernel/debug/venus/fail_ssr/times
>>
>> Co-developed-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> This line should come last and the 's' should be capitalized.

Thanks Stephen, will fix that while applying.

> 
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
> 
> Code looks good
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

-- 
regards,
Stan

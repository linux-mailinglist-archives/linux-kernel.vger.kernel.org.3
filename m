Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B563A522740
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiEJWwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiEJWwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:52:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EA36C0C5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:52:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id bo5so411893pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 15:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4xY5bF9UYm6MAVtzgNfATpmkNYNH44rnKMWoXQzjxrI=;
        b=FItJqMaNmWv33SShK+ZO3am8AWGCUIO6YZHO6V6G0rTg06JmT35pvYET0rD5wPSRKz
         PgAkOYcRvOg9plTi0Fpz6xMt09s+1bmZfMjbmpygVANoPcqVB3lrBOHQIGZKzyRQC2cz
         DERZv562zIwz3Y/CWl4EbJM59XeNRgMvRXdDxJ6wv3iRRZ0LV6Sxz60uF4f3G6yS4Jn+
         w45yjweNbsXo+XV4w/ghyJ+0ddsElP9+zEKMZyU97FyjBDsuZNWSuv+JBECRCBsFfFUP
         KnAri+dIhCAJdvlBSpRF1utp2WaUQN1LqnKN/58bGKpNR11aN2B1+2gLa7jOQ5itTpzd
         XzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4xY5bF9UYm6MAVtzgNfATpmkNYNH44rnKMWoXQzjxrI=;
        b=vNCduuXQNn0Nc8LT7BZKIzm1qP2dASXHSxL/dK6W26ROCThxMmcvDFaKv5N1OrHgNx
         NzXJrRKPAUy89GWOZgHe7IA4f7HRANqX0Mz6RnMF9jwsOpG2PW7Ps82YohbICVBN6nhS
         8QVelSiXpL4mpb7/cR2rSW12IGdrsfLerDL7xR3fKImlUGUfmzbkFtHY4Mylr1c8u4wM
         kzfju5G/VKC8Bkqf6SfX6LBLaZ35RSJuy301GJvsrtcbqadxucMtYVIschmXAkehm1sM
         tfXO66vvvK0xQBX1t+vtmLcdcjcTVkYi9yLYqgwT/6ddTDHKco15fiALcMdJ+4Mzb3Ty
         WdbA==
X-Gm-Message-State: AOAM532mu4TC7O/ufcgZ8rtEclutXpOqwRgmTVly8DmBJ5tXPt3XUwSr
        +bn9FP5d89BDeBDZq0FsRF7VTA==
X-Google-Smtp-Source: ABdhPJxBD7xz21Is5XyKacXGuURKZ97TVB0rCPcvgYeeGxXp0XTbwkIq3b31s//zgRAl/JwRiH+h9Q==
X-Received: by 2002:a05:6a00:1251:b0:50d:f2c2:7f4e with SMTP id u17-20020a056a00125100b0050df2c27f4emr22492045pfi.72.1652223136854;
        Tue, 10 May 2022 15:52:16 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b0015e8d4eb229sm149967plb.115.2022.05.10.15.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 15:52:16 -0700 (PDT)
Message-ID: <ef6c9822-8099-99b2-0a88-50347934e62a@linaro.org>
Date:   Tue, 10 May 2022 15:52:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] exfat: check if cluster num is valid
Content-Language: en-US
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+a4087e40b9c13aad7892@syzkaller.appspotmail.com
References: <20220418173923.193173-1-tadeusz.struk@linaro.org>
 <CAKYAXd_9BT7je6-UHgDYCY-WD2maxYtam0_En8pgS_FiwRJP9Q@mail.gmail.com>
 <CAKYAXd8sQDJyftZ_N8bgCMcMCMraQ=6_8x+QZ5XprMN3P4x9gQ@mail.gmail.com>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <CAKYAXd8sQDJyftZ_N8bgCMcMCMraQ=6_8x+QZ5XprMN3P4x9gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 20:26, Namjae Jeon wrote:
>> Could you please share how to reproduce this ?
> Ping, If you apply this patch to your source, there is a problem. You
> need to add +1 to EXFAT_DATA_CLUSTER_COUNT(sbi).
> and please use is_valid_cluster() to check if cluster is valid instead of it.

Ok, I will try a new version with is_valid_cluster()

-- 
Thanks,
Tadeusz

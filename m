Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC5359AFE1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiHTTO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 15:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiHTTOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 15:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF90328E03
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661022893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RcEdOQ10DcjhFhOlSWptCrA6mRT/8ZyucyzcP38daTc=;
        b=VqNY0Yszdh3822l+tX1cD+CumUqiDQExLkqzFYEOtcMnmkxG3ewZVX7fudP8vf867bloV9
        0+Gf18f/dfakNf5Gs97zENzKihzTq0CJUhWH60t3hTMy16WbZ+eZ4Ap75LltDL8MAWf9Xa
        eb7ujGSUYqAvTaspWP7JUfVt3/xqeyM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-XNN_DP3iOrCmVu34jNus5g-1; Sat, 20 Aug 2022 15:14:51 -0400
X-MC-Unique: XNN_DP3iOrCmVu34jNus5g-1
Received: by mail-ed1-f69.google.com with SMTP id z3-20020a056402274300b0043d4da3b4b5so4565179edd.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 12:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=RcEdOQ10DcjhFhOlSWptCrA6mRT/8ZyucyzcP38daTc=;
        b=gfi60osEfop7oSD4/iKEAIV2mrP4dJZW9fQKa+KPSGsFKvIjo78ncRTojL/bR+DuAk
         p1rUF+GsqoobB+TBE7MhDOEq2VRKfJy1I1i6xMTKEEGXH7Cj/OlRUVv3yBbetdER5CKa
         aFaorXoeruodW77z5DGEWh7PPsnmOikoBCJhayQnbr8hXfKZF+TDpCqTbfZkDGF1Bk7Q
         jC64jHKKft3oPsNiICtBfU/KONCtIEtwTei23HHKhPM0FigziSOfBU9R6TqCAYx/QbR0
         Gmg/Tp7rWqxAoh4eVIFLNnWCmtJA/04dryE+rFcBBTnLPi4EeDviVDhq26JFuoNWx7L1
         qR6w==
X-Gm-Message-State: ACgBeo1gOpBQBHT5+C/UTxjJNuakFHkTCfMnTLvp3m8Lb3cDdDATTFLB
        G2xJ33P6yc9sNIQcNzf7gW0kThOX55DPBLbggnPRyh2lVb7ZIobIw4PhTqTvgAqTwCCWwPAezRE
        tTY1iz/DBkUk7GMRh/hqCtgxq
X-Received: by 2002:aa7:c790:0:b0:443:a086:6877 with SMTP id n16-20020aa7c790000000b00443a0866877mr10384380eds.84.1661022890443;
        Sat, 20 Aug 2022 12:14:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR60jbrBYrvBSLFTcJQhnjQeLrtGvAgcYYuRCi9iNnW52jSM6yo7xugH8I2R5ca19534ueMvEQ==
X-Received: by 2002:aa7:c790:0:b0:443:a086:6877 with SMTP id n16-20020aa7c790000000b00443a0866877mr10384370eds.84.1661022890289;
        Sat, 20 Aug 2022 12:14:50 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id z6-20020a1709060f0600b0073079439f27sm3927590eji.72.2022.08.20.12.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 12:14:49 -0700 (PDT)
Message-ID: <a74584a3-fc47-b458-2d1f-8e03beba7d9c@redhat.com>
Date:   Sat, 20 Aug 2022 21:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 0/3] remove useless files
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, lkp@intel.com
References: <13600e0c-bde2-198f-26c4-00531f277bf8@redhat.com>
 <cover.1661017377.git.namcaov@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <cover.1661017377.git.namcaov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nam,

On 8/20/22 20:00, Nam Cao wrote:
> Delete odm_NoiseMonitor.c and odm_NoiseMonitor.h because they are
> useless. The first 2 commits are preparation, and the final commit is
> actual removal.
> 
> v2: Add new patch to remove the file from Makefile, otherwise there is
>     build error as reported by kernel test bot.
> v3: Squash some commits together. The patchset functionally remains
>     the same.
> 
> Nam Cao (3):
>   staging: rtl8723bs: remove unused function ODM_InbandNoise_Monitor
>   staging: rtl8723bs: remove member noise_level from struct dm_odm_t
>   staging: rtl8723bs: remove odm_NoiseMonitor.h and odm_NoiseMonitor.c
> 
>  drivers/staging/rtl8723bs/Makefile            |   1 -
>  drivers/staging/rtl8723bs/hal/odm.h           |   2 -
>  .../staging/rtl8723bs/hal/odm_NoiseMonitor.c  | 130 ------------------
>  .../staging/rtl8723bs/hal/odm_NoiseMonitor.h  |  39 ------
>  drivers/staging/rtl8723bs/hal/odm_precomp.h   |   1 -
>  5 files changed, 173 deletions(-)
>  delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.c
>  delete mode 100644 drivers/staging/rtl8723bs/hal/odm_NoiseMonitor.h

Thank you for the new version, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans


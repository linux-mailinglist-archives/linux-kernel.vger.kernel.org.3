Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD17255FFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiF2MXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiF2MXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A292A340E0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656505395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjB8BWfKUGEVoS354QTL3ZLESIpcbjTDuUnp9doERGM=;
        b=SEFgsmJgWYOjF2PieN413jJWQO4gsQdLKgJDIOFdQRGe/g0dsS5OkJxNNzFMmtf4s6Yj6K
        anI1/l3XSmVVuwoK/FF2ksklIVdZy/IgA9hGdXCaIFZPQ0SPHGz7k1tJdwLjGKeTitp2hu
        ErGu/1kU4pVlpT8U0Cd/ibeVFu4sMoA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-ZGBOQceuN5Cy_EuN_pW3cw-1; Wed, 29 Jun 2022 08:23:14 -0400
X-MC-Unique: ZGBOQceuN5Cy_EuN_pW3cw-1
Received: by mail-qv1-f72.google.com with SMTP id ls8-20020a0562145f8800b0047078180732so15099691qvb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bjB8BWfKUGEVoS354QTL3ZLESIpcbjTDuUnp9doERGM=;
        b=YsNoIq3x9BTDURA3LiJg9quh/M255AqfVJSTfBMvvJQsIn3vGNGV6+0HYiCWX/4h9v
         XlgbbXOwXK+gDczchX4LUZ/tjCVmJ2Yuu/GBJJUlaCS8MJ00v2JTKvEdDTfKcwodwMEW
         Jo7E76lZ+UqcmlYUNSNtb+vwhFfQGqYUpnESgwpzz+DLeHEZpktpjL9EHextXvUOplNH
         JgHnceeRjYjZYjoM826FSGnVsVNR2OK0QTTMbkuZxKG1fo/eHJF2TXDy32xqwMWBwZV3
         n3s19rvkBu3x+EsMcTbJhl9VneHuTvbFf+9JZOrb50QDpg+rTwXR1otrP2bQbSiE5+qg
         uVdQ==
X-Gm-Message-State: AJIora/V3GLsJJKblYJOptl/FaUkaMHmj5aaaCtAzc/wQQSRjftyB6U5
        R2IbCyF9bwjjfCQNm/gwY7F8g1ERvRYUGuSCEBHk3ebax8p99tCv8NqFxX1m+/PJ15MSNdh8HI8
        lAfcgPERUe5lh6i44s+P4bVNZ
X-Received: by 2002:a37:2d46:0:b0:6af:9d9:e0d1 with SMTP id t67-20020a372d46000000b006af09d9e0d1mr1734540qkh.398.1656505393783;
        Wed, 29 Jun 2022 05:23:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uZFGyQB5h0m5/rDcrwgHjPqEQPMbvBifJKvUDl6CcWxfXv9cg0yaXC/avzoRxmO8XKQx1cJA==
X-Received: by 2002:a37:2d46:0:b0:6af:9d9:e0d1 with SMTP id t67-20020a372d46000000b006af09d9e0d1mr1734515qkh.398.1656505393477;
        Wed, 29 Jun 2022 05:23:13 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006a68fdc2d18sm8740492qkp.130.2022.06.29.05.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 05:23:13 -0700 (PDT)
Subject: Re: [PATCH] misc: Fix a typo
To:     Zhang Jiaming <jiaming@nfschina.com>, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     kai.heng.feng@canonical.com, christophe.jaillet@wanadoo.fr,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        renyu@nfschina.com
References: <20220629091011.36187-1-jiaming@nfschina.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c8a45d98-ed21-17fd-6a5a-1f2ae5302137@redhat.com>
Date:   Wed, 29 Jun 2022 05:23:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220629091011.36187-1-jiaming@nfschina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/29/22 2:10 AM, Zhang Jiaming wrote:
> Change 'timout' to 'timeout'.
>
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
> ---
>   drivers/misc/cardreader/rtsx_pcr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index 2a2619e3c72c..c42dd837bd4c 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -131,7 +131,7 @@ static void rtsx_comm_pm_full_on(struct rtsx_pcr *pcr)
>   
>   	rtsx_disable_aspm(pcr);
>   
> -	/* Fixes DMA transfer timout issue after disabling ASPM on RTS5260 */
> +	/* Fixes DMA transfer timeout issue after disabling ASPM on RTS5260 */
>   	msleep(1);
>   
>   	if (option->ltr_enabled)
Reviewed-by: Tom Rix <trix@redhat.com>


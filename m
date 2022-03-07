Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7581E4CEF31
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 02:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiCGBmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 20:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiCGBmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 20:42:42 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7AA25E9C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 17:41:49 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id c1so12285310pgk.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 17:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0Fw2idvMV9mmhbkYq5zfFzJocfFBD0RDIL74FoXxZpY=;
        b=nNPl9n/hzDpRgVPn26lEdnQq42yce2vm+LJYINOXG4Vs6xI9QWUSqVepzjfR9TZ1ed
         3JTgKw+MqjeMZUlrH0uasq6gkOUuHplXIAsrKBsqYmVJ28s1c15VI0q6W+MR7AO8jQ3Y
         F6pEKgx41ApiPRuzcxufAqoXKew08qTvMuWTc4k9Wldy2yx3ILq26tJ/vDRJY5HwJpp8
         73Ct7R72BgxzjzKBQfaa5jnkKJNBaDHaiRNR/TXyJvMSGaqgIxRJKjv4sewudhBklo2G
         9tMgshuYE/uGY13Mik793WW3phc+CNc4tH0bCXvxJw6krtv1cTnFKM19muZv59RLOjPm
         k3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0Fw2idvMV9mmhbkYq5zfFzJocfFBD0RDIL74FoXxZpY=;
        b=0Pfj3eYOS9e1cToLVJr5erD5lR85RHCVAdV3KNj1KiDrU2YMIbnzSMwd0SMzZ7Lh7p
         LGXvrnS9XFMgHqQByS8xPM1rayoyLkrErBMmTKmSj4yIb5/pB8J7J1hEq2yc5d/zHiMm
         KJISNGSDyXGF/oxbO8ScFDo1L/EqYAyhK3S779UUO7TjVXJAytMpcxnLo92OvJRlazG7
         6XXhUsPscnvTOLhqmTFJ7yUpcCmgILqAWk/eOTI159JNZfdkNGygLd2N9OZ12tnEs2fm
         H/PayJggTgkFPYbiLr+EnkgkCjRgoyzsIzx9V8+CLLSp2VY2QpNC9YCwnn0VXE8gM6ZZ
         L8lQ==
X-Gm-Message-State: AOAM5329BbBtvULIXtkXJ/CP02lsrLhFfS1adaBu+Ah7sYQa5dNJN5Ff
        zp1lmdVQuyzIc1gA0I/OsK8=
X-Google-Smtp-Source: ABdhPJzqZPGdtNsh38PDx/KkZI6yTkClYiDaRvbHiuNtDsuVA6cAjTc5vohHAo0NPZ+YnD4T8wMuRg==
X-Received: by 2002:a05:6a00:b90:b0:4f6:b88d:ec96 with SMTP id g16-20020a056a000b9000b004f6b88dec96mr10300678pfj.12.1646617309370;
        Sun, 06 Mar 2022 17:41:49 -0800 (PST)
Received: from [10.11.37.162] ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id n24-20020a637218000000b0037ffc63b98csm4614537pgc.65.2022.03.06.17.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Mar 2022 17:41:49 -0800 (PST)
Message-ID: <146301ab-e217-6984-1dd4-0d782328d7f0@gmail.com>
Date:   Mon, 7 Mar 2022 09:41:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] powerpc: 8xx: fix a return value error in mpc8xx_pic_init
Content-Language: en-US
To:     christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, peng.hao2@zte.com.cn,
        wen.yang99@zte.com.cn
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220223070223.26845-1-hbh25y@gmail.com>
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <20220223070223.26845-1-hbh25y@gmail.com>
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

Ping?

On 2022/2/23 15:02, Hangyu Hua wrote:
> mpc8xx_pic_init() should return -ENOMEM instead of 0 when
> irq_domain_add_linear() return NULL. This cause mpc8xx_pics_init to continue
> executing even if mpc8xx_pic_host is NULL.
> 
> Fixes: cc76404feaed ("powerpc/8xx: Fix possible device node reference leak")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>   arch/powerpc/platforms/8xx/pic.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
> index f2ba837249d6..04a6abf14c29 100644
> --- a/arch/powerpc/platforms/8xx/pic.c
> +++ b/arch/powerpc/platforms/8xx/pic.c
> @@ -153,6 +153,7 @@ int __init mpc8xx_pic_init(void)
>   	if (mpc8xx_pic_host == NULL) {
>   		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
>   		ret = -ENOMEM;
> +		goto out;
>   	}
>   
>   	ret = 0;

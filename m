Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE2D4AFA10
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiBISeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239312AbiBISdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:33:52 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41B5C05CB89
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:33:53 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id bx31so4772000ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 10:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/VHbBhh1Q5BW0eHT7ODuGdUrQwpBM3ZeS/JzBlzS9jg=;
        b=keJhsHcEm7hotnsbHxViXXol0pALn6nLuo0isXo7S9YQJwQgaJ+dOc46DYLg9W81MY
         7JnC/TE9t/lDp8oUoJNnkHs6z9sCvhRMWJJyZ5kDtS8htfmpBWaVFwYi31IZLLck9pe9
         KyxGtXlAM4bvJjDmdgl38SSajtMIvXGZooE///ovgxOFXLtZT3GlvjzVqMOCkcC0IaCV
         gFJ9mIHg/89NDvwdM+vwb0OASB/94Lx8ladYZJ6DRYZOm0FDiELrnEfKGUtX2vyAf3jN
         4V5QzUhEa1ccxg75bk2osR2BRZUS6eOJ+2sw61GkcFsXUv/dfWlZ8mLMgHNctZr+4b+C
         mflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/VHbBhh1Q5BW0eHT7ODuGdUrQwpBM3ZeS/JzBlzS9jg=;
        b=zlVY6HwK+9ToF6ZAihDsqFsX5Pxu++pE576/+Gb+IUe13RODm0kg2wETwbxfsahjDo
         5rvVC1X8FxpuaQufz8SytlU6ZWOBdnCMoOc+HgoQXa+eQ9p+t8xllbYK2uGorH/kNDdn
         5dA3qIWkgfp3TvAjlo3gnEsySkMeEu+uZvWzD0m3C2qLn/arPO19WwDNUDJLTrqpKTMs
         VJl2PL4BsH3SWEivsZUVLmIwRKN88U/tG3nB1zqwMs8VyxsmVRfu7YRwJOYz4+3hVQki
         R8lWe93PHSgJUXlXsn6J15ZJdvDgeVfCYQD0obz3nz8qThDZZIY9xIOH4w1cIZ3dvZ7v
         LqQQ==
X-Gm-Message-State: AOAM532Mf2vet9MyJBW9zU+1kWAJfYGY5U9sM1+Vw7N2R7nS+XeACd70
        ORd3Dh8ZWfxiIFVuOuWrN5Y=
X-Google-Smtp-Source: ABdhPJxh9nYl2aI5spHPNmfjqz/wXlDX3E9kOtM5a728QIC8T9TyOZy7Wzyxsh3VLJ0ATjuEK4fl5w==
X-Received: by 2002:a2e:bc1c:: with SMTP id b28mr2337728ljf.40.1644431632033;
        Wed, 09 Feb 2022 10:33:52 -0800 (PST)
Received: from [192.168.1.11] ([217.117.245.154])
        by smtp.gmail.com with ESMTPSA id u21sm2606127ljo.81.2022.02.09.10.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 10:33:51 -0800 (PST)
Message-ID: <be19eaee-2b90-d0c3-c80c-d8fb379bdcf3@gmail.com>
Date:   Wed, 9 Feb 2022 21:33:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] staging: r8188eu: keep the success path and error path
 separate
Content-Language: en-US
To:     Vihas Makwana <makvihas@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220209174819.5068-1-makvihas@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220209174819.5068-1-makvihas@gmail.com>
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

Hi Vihas,

On 2/9/22 20:48, Vihas Makwana wrote:
> -exit:
> +	if (pnetdev)
> +		rtw_free_netdev(pnetdev);
> +	else if (padapter)
> +		vfree(padapter);
> +	padapter = NULL;
> +
>   	return padapter;
>   }

Why just not `return NULL`?




With regards,
Pavel Skripkin

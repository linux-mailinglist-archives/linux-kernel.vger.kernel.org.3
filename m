Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A653B467E19
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382809AbhLCT0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382807AbhLCT0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:26:09 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305BEC061751;
        Fri,  3 Dec 2021 11:22:45 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id o17so4409057qtk.1;
        Fri, 03 Dec 2021 11:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8QSR93HLtSMmmWi5RqTKjc6Rjz7wyeXf4rRAZP+slaw=;
        b=OYRPznavvBEtO2wq8+pe8DlTDQGohPJmgTw3EoN4AysFzReDpFgo+g0qIuglARpQ7L
         ffM50uCHHAkQ8P2NXf1ZXXiV795xJZaOIxs4gVqKZNluiotCS0mrEfM6weCn5IA0XPBP
         APsPxk2zn8z4S0m4Zv5IYF5IPlvK5FSiNUYpokEG8Um7yttX7PckM5caC9h3gIKcakCL
         E9cM3EtK2VCkX7S5m11eiTt/WYfvhQ2pIatZXuYX7n5Mj19ji+JYvvNOY53SnjCTnNgQ
         1BGkHs7BqddEbIe2sE71vmRuSApoVQ/zoyusJdbwxFLNSSlHn9ns8hhMGBdbCkTWhIwc
         lFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8QSR93HLtSMmmWi5RqTKjc6Rjz7wyeXf4rRAZP+slaw=;
        b=YDw2P3T7vkarUs+oRzOaY5Fnnn+NLNl3kYjNAicv8qvOyv1PwqVARtkNZdw0XsaJ1B
         B1hOAz3+PsumSOa4Jl3pJ4VEuBlGfLIl+lNk7Cx6j7bXEwoX9yqjThgIZ5u47JAKQFf9
         rMRi0B4XupXpgZq7u9LVlp9D5rSOnK+qGjjYiHWH8BwIxEGTb0QzYJ5YiXYUBnKRpops
         DWB8Vs/hMgia7Fj7gSlDzKhGKj2+SUYjmUhepCREO6722WRfndw+qTH3YRIuYWT4QMUX
         UR1hJmxYFsOYHRm6TLZDugbWwBACho68EALMqOHm/8u4WDs1vjhlZ0L57wwLgMJd7/ab
         9Uiw==
X-Gm-Message-State: AOAM532qPQ4rZpyPkzPbtmpDbpxCMJpfYt7V7mFMTlZTlQMeRaGuzVEK
        Fs3+TWOdck+ncqsMrfDP5Sx5Ie5uJp4=
X-Google-Smtp-Source: ABdhPJz3wsKaO2DLnS0aF/i5tHEymFeurj9OOqHD9Rtm2E0UxIj+BNfFg/+24d8HLO1tgDRIHDSZtw==
X-Received: by 2002:ac8:5cc5:: with SMTP id s5mr22486373qta.97.1638559364306;
        Fri, 03 Dec 2021 11:22:44 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id bj30sm2544101qkb.58.2021.12.03.11.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 11:22:44 -0800 (PST)
Subject: Re: [PATCH] media: s5p-jpeg: Constify struct v4l2_m2m_ops
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211130212700.1253521-1-rikard.falkeborn@gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <e2441bf7-676c-097e-7b60-37f18078b5ef@gmail.com>
Date:   Fri, 3 Dec 2021 20:22:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211130212700.1253521-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rikard,

Thanks for the patch.

On 11/30/21 10:27 PM, Rikard Falkeborn wrote:
> The only usage of the v4l2_m2m_ops structs is to pass their address to
> v4l2_m2m_init() which takes a pointer to const struct v4l2_m2m_ops as
> argument. Make them const to allow the compiler to put them in read-only
> memory.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>   drivers/media/platform/s5p-jpeg/jpeg-core.c | 6 +++---
>   drivers/media/platform/s5p-jpeg/jpeg-core.h | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
Best regards,
Jacek Anaszewski

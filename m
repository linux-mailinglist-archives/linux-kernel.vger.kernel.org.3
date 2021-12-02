Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099424668D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359792AbhLBRKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359563AbhLBRKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:10:31 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8DCC06174A;
        Thu,  2 Dec 2021 09:07:09 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id a2so355366qtx.11;
        Thu, 02 Dec 2021 09:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MiHYwOcU4niVTZVTW2HCw6eYKVAYISAwMN8OEWX2J0U=;
        b=Ef4oJmdu+LEMv2ydR99vgiLF3BGiYAuAm4B5EWzlno9uVZK/hHU3nsXuIklubFu2TY
         AuUztK9nlG6k5cWUpWuN21jmeeB1UEFOHm2paryyC1cJy8EEByvCp34BHX3Ib6VXI62A
         yNv13inVfU6N4MUXbiG8qJvGE6QZN3d9bhz8eQ7UdUnSAZl/b9TaIoaD627iYC0/poRe
         csFTHl5BMYUEWkKiNRwwNn5WnxsG0xLCcEY1j/2JhWn2G8k84fKdLdAIGIWo4YUzOTE+
         PEd6iltESemecY47pPN2RWP/wVEQzveGG5tjmjtcplI8wbz+BgfLxg6zKvTB173f5Zim
         dvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MiHYwOcU4niVTZVTW2HCw6eYKVAYISAwMN8OEWX2J0U=;
        b=rDYGVpM6FGeZqheU9PVGGhQuxjnT7/CRkjOAOaekV7q2sxb47riJtMMTqLsnAryO3V
         BsUy6yYvHrOVZ8Dqmq1nr740bDRX37w7JBwD6vch5LV4/ppHadaGNTI/l5UrcielKSnt
         8S3/UID0sl9z4Lc+RkgqT9GzUuEfdsXQRMh/rmS/v+oI01E+6/bO3plTwpviteMwJz/7
         Y1gL6yaWgtOwF581so158CLgoa+mC5OwmwqJwq1DEVx0o/klqdSesP6wFq/9N4ZGNhdy
         CKlBPxDZPDgh6MCXf1bvMA0sB88ggIDyOaUk1jGCCwyvpsogW03kcNYs1UZGyUgR3cmR
         FfhA==
X-Gm-Message-State: AOAM531Y/HozMfqk/z+A6J9yCJcmLWI6bsmvk0IKCRBD7E4YeCkhABzC
        r3zpdz8pspOa1NXdaOp6Q5E=
X-Google-Smtp-Source: ABdhPJxHm6JHI2qsCq3+f7aXWkpV7aspSqTauD/rryT+ZNlZox5QyO2FOaWDOipGKA+ryYA0IJTaZA==
X-Received: by 2002:a05:622a:2ce:: with SMTP id a14mr14817982qtx.445.1638464828207;
        Thu, 02 Dec 2021 09:07:08 -0800 (PST)
Received: from ?IPV6:2804:14d:72b4:9077:b53b:d2e6:63a5:6035? ([2804:14d:72b4:9077:b53b:d2e6:63a5:6035])
        by smtp.gmail.com with ESMTPSA id h22sm236879qkk.14.2021.12.02.09.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 09:07:07 -0800 (PST)
Message-ID: <805c6ead-1e8f-19a1-dc0f-565fb0563a1c@gmail.com>
Date:   Thu, 2 Dec 2021 14:07:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] media: vidtv: Fix a wild pointer dereference in
 vidtv_channel_pmt_match_sections()
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>, Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211130163946.189005-1-zhou1615@umn.edu>
 <94dbfe62-43b3-a293-5f59-d8bd1f35bde1@xs4all.nl>
From:   Daniel Almeida <dwlsalmeida@gmail.com>
In-Reply-To: <94dbfe62-43b3-a293-5f59-d8bd1f35bde1@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou Qingyang, thanks for the patch.

Yes this is a real issue.

> +
> +					if (!tail) {
> +						vidtv_psi_pmt_stream_destroy(head);
> +						dev_warn_ratelimited(m->dev,
> +							"No enough memory for vidtv_psi_pmt_stream_init");
> +						return;
> +					}

Yes this is the right thing to do, as vidtv_psi_pmt_stream_destroy will 
free the stream chain and all descriptors associated with it, if any.

By then aborting out of this function, we will have a PMT section 
without any streams. This is OK if the allocation failed.

Reviewed-by Daniel Almeida <daniel.almeida@collabora.com>

Thanks,

-- Daniel

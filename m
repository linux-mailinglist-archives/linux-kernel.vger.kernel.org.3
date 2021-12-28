Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B06480973
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhL1NMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:12:45 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:45482
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232128AbhL1NMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:12:44 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D3B5B3F044
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640697163;
        bh=PHoxW3qi5dqUGPM3GtNEF3gB6+cmt8tlvVRU3SmK+uQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=iqUw/HgIeeASox6ZlQmsssd35WIbzE7etR6wBqpqRMO766Txx/5dWxC5862lVea5x
         J3NSResRz4OCYARMykVaOFgvP0YP9y+8mozH48+u7SBlep/Vqz43ZMOYMm8QEfHsaV
         bBc0a+Gcb0gy3RC6adwIia4OLy/OPUB/FpyJU18B+xIfqHN27TkfnQ7NUh057UCMKL
         yJogGz1NlOqkeDrJuPBkiFqNqakT1RWhpCmAXqrLGK46fF5JQ/kE9cLnqiqYXfxYO9
         syVS3/0CyvzVV4r1cEzMHHAhTb561UblCBvjxem+Q6Tffo4L4GX/8TrJM7PIskgDLs
         nuo97lhGkkbYA==
Received: by mail-lj1-f199.google.com with SMTP id bd7-20020a05651c168700b0022d71e1839bso5993332ljb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 05:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PHoxW3qi5dqUGPM3GtNEF3gB6+cmt8tlvVRU3SmK+uQ=;
        b=ZfJZdDNVnDEtl5RoJynjHCn7xTSkwaCqYGC9oPxbJm+46FD9/rXjOuH8F3SltQr7xB
         jTWtvIt5GCXeWPapYoorwrUK+lYnqY3r2C+GkVE7mL2YGrNdE0T0X9TP8UyQs56fLBYZ
         Lww49HZiyS6b7ajdwIZIsWomjZ6FjJPCz3qgc+UE1DvwBeXFsgfZd8cfumSnU9znI53h
         eH/duVwN9vfgwt/SyEgZHthHvLS8Vx5evzU6mWSVC52eIFcy1Syy4ZZL3JmiJDdjTYh5
         gEDt56ShT66Pa7MnDvlmXJOmbXrFL4/zpERvSpaR4W2PWmPYcAz5cQ8inDDZ9j/BEj2y
         rtwQ==
X-Gm-Message-State: AOAM5321SSf3LfXdur6Q3Czuk0gvFurYcUUXLQGZplsK7s4XavEr/WGO
        +zi3nVKpieiEEsrZgdEy+rOz9XybQy6LldRra5qsxuWgwiHjQ/2AfRtbi/RnJyKSm/s3l2F83F/
        fH79p4JgjPeSyVqdLgaTfdWTapPIZMKJmow9/1K4Y0Q==
X-Received: by 2002:ac2:46d4:: with SMTP id p20mr19141640lfo.653.1640697162839;
        Tue, 28 Dec 2021 05:12:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyoavReARFXLadW++33qI3Nh2nMVHqNtx8xt4u7Le2xVMY4oTna4zrRBpafVgDfdAK51erwxw==
X-Received: by 2002:ac2:46d4:: with SMTP id p20mr19141604lfo.653.1640697162249;
        Tue, 28 Dec 2021 05:12:42 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id r11sm115506ljp.18.2021.12.28.05.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 05:12:40 -0800 (PST)
Message-ID: <5e799c7f-573b-d254-80e6-85404ef536b6@canonical.com>
Date:   Tue, 28 Dec 2021 14:12:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] ASoC: samsung: idma: Check of ioremap return value
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, s.nawrocki@samsung.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20211228034026.1659385-1-jiasheng@iscas.ac.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211228034026.1659385-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2021 04:40, Jiasheng Jiang wrote:
> Because of the potential failure of the ioremap(), the buf->area could
> be NULL.
> Therefore, we need to check it and return -ENOMEM in order to transfer
> the error.
> 
> Fixes: f09aecd50f39 ("ASoC: SAMSUNG: Add I2S0 internal dma driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  sound/soc/samsung/idma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof

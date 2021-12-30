Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB6148201D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbhL3T6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:58:48 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33730
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237051AbhL3T6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:58:47 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2DA023F044
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 19:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640894326;
        bh=GNWzUrlrK9iApcC0QIt7hy4CWeyRUiCxofVD3uisya4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=IQ0XcJkyjY35RH82W+KcSDToOvW8gpc1+D8s2XE8QiRxzgBMArbosRdYWRJRr1hUM
         EjC13HVx4kkYU3P2gyH4FsFPUx7X8mwhrXXyg2I94H27jRDbTX2tIObJISFcWEeips
         tFjt+WW1y00eslzFdEZKLNsgiKXIvQFtwtcqV9esj7NwiU/T+qQWo0TMwJvK8f/10i
         7JwiitkuMLMLR1wgUfNbTaC3xu8zRLGZ20jSsmRgwp8IsLc2goaF8xNUPY2ejzsfZ9
         dQaFZoaKat4LeXcYj243dA3R087vNje3ItgKKzqwwQ23an2lIjE2TRCVqyfFfTgvT9
         bc6JhD1WxNlJg==
Received: by mail-lj1-f197.google.com with SMTP id c20-20020a2e9d94000000b0021cf7c089d0so4471788ljj.21
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GNWzUrlrK9iApcC0QIt7hy4CWeyRUiCxofVD3uisya4=;
        b=G4VbT/TE2WX5ew1ombWqufSPx22PZRd4ebrHrtT8HS9U5oQTmfMtgWa0xnGSlp8+vE
         /eWvLQN2xBHkBRhsHw0QBqMr2RcQ3bATIfpfKBtkpdc8VxUnAY+ALK4uoyln5DQzmykj
         RYdTqcT4dpWwVgC8LwOKfnESwz6HOq44Dljc8nTDjshLm4Wljmaug33+n1C2O6nB0hio
         lqik8cFzj0YNBfmHKM0L+lwh7ElJ+CrAMqu0MeqdNOLFYAlFww+ucouh8EMlw/CNlDVw
         mh93SqDOdWDq3HO0FC8d+84iN1sPcH6yVPKmbHQ48wBAm4FZxJdJATArooXpBV3GKuei
         wb+g==
X-Gm-Message-State: AOAM530EvRLGrQaVRkCHdVvUTXtO6+sYjeHql/3DkzerlWZ5KblihE5s
        8l7Q6MFr0aHiLVi4lrM6z2ec0Y5aeM10xk5iomkucA5cScO8GkY7oBYjRYW1rJQgu0fRqHw3pli
        1VLCsE/NlzANMTy/LLj3s1HY00R8vBvIcRXr5pMFpng==
X-Received: by 2002:a05:6512:2311:: with SMTP id o17mr25992434lfu.256.1640894325567;
        Thu, 30 Dec 2021 11:58:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSa/wf1cnt5j7jqACUSdQ38QoQdVyafz5ZdxBfdxwsi0qKJ3PwI4Qbtw2FxwfqCGrdy+92UA==
X-Received: by 2002:a05:6512:2311:: with SMTP id o17mr25992421lfu.256.1640894325422;
        Thu, 30 Dec 2021 11:58:45 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id z36sm2571458lfu.182.2021.12.30.11.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Dec 2021 11:58:44 -0800 (PST)
Message-ID: <eb2f0bb7-46ee-2290-6b60-90f555e4811c@canonical.com>
Date:   Thu, 30 Dec 2021 20:58:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] nfc: st21nfca: remove redundant assignment to variable i
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20211230161230.428457-1-colin.i.king@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211230161230.428457-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2021 17:12, Colin Ian King wrote:
> Variable i is being assigned a value that is never read, the
> assignment is redundant and can be removed. Cleans up clang-scan
> build warning:
> 
> drivers/nfc/st21nfca/i2c.c:319:4: warning: Value stored to 'i'
> is never read [deadcode.DeadStores]
>                         i = 0;
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/nfc/st21nfca/i2c.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof

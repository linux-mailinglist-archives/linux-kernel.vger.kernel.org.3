Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680744857F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbiAESK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242736AbiAESKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:10:52 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7F9C061245;
        Wed,  5 Jan 2022 10:10:52 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a11-20020a17090a854b00b001b11aae38d6so6974977pjw.2;
        Wed, 05 Jan 2022 10:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IN8JyRQXgDSCK0v1Wn0gLRr9LoWdI33w03eu61b9On0=;
        b=OK/GzVvXZ3CoUoJdr5FkSPypm6560lEB9ez8vKa0iRwgUnrbiOdh/er9ZBrVWd3SDT
         fUsESbx/pDByDZnaqxa5XBTN/rOwnBuFMHeKmpysc4aBxYM52/tfBdBji9q+tRXjrAgr
         xadLJ7dqsExec/APBALDC8EEoSMS4O9+w32pPYFHkkBRAVO04uBhW+HQ3sS7i3/7N9YU
         LaK5KBXvezLVmfiZqx3PIreU8rnDrTCWaqt2NdmOyPIfwCrwyCEoAyn+0W5X2dButIYZ
         GC3nhmL/RaldVKBbZuusr1UNLHdla87g0aiH7R4IlDQS5CbNQU6fLYt1cPQ0VtGPQl+z
         ke8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IN8JyRQXgDSCK0v1Wn0gLRr9LoWdI33w03eu61b9On0=;
        b=A8up+SEamiACNN5mx13j2pSQRkNX879/JkwC6Nb8YKcV6BZ8j3N09P9bvwZ7pLFLAW
         ioRXvV6xQKHgdZn4qzc3xZJ1jrEdReHNOnGOowUAl8orXaTpUkhGcgqQVFDA5SES+nzE
         Gw5gtgdRhU74EhgQzFobSWctADGdguA8k+olL+n5jseTMJzpePMrqqCCzASOOkG0rLnU
         O71Zy5xuDMDBucSsaMztDoM7ZFkfItSJGhnOPKTmIfj8PszAm3o4Cez/fiSyigNUV7Zc
         6vSrnya/rA6zgLqMESX5BxGa5DNVsq3aBlHokItztljELJLNfKqSmiPF5ulkmjAnYaJ6
         Mhbw==
X-Gm-Message-State: AOAM53142P0wR/32PwJK0BU+iYiJgBNNX9JCLZ9aKvtkQJxkS31SLns6
        LOn+WEMBrhSWSc0TsO4W8y9e+6KxFiE=
X-Google-Smtp-Source: ABdhPJzYAr5aQKXDt/hhaG0rCqxhjgcuiROF3x3VmQ5huilbRdfemPYUJ61hl5VSzNSslKLHFvYY/w==
X-Received: by 2002:a17:902:c205:b0:149:5027:93c6 with SMTP id 5-20020a170902c20500b00149502793c6mr53235557pll.15.1641406251608;
        Wed, 05 Jan 2022 10:10:51 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ob8sm3730838pjb.38.2022.01.05.10.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 10:10:51 -0800 (PST)
Subject: Re: [PATCH v2] serial: 8250_bcm7271: Fix return error code in case of
 dma_alloc_coherent() failure
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-serial@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <20220105180704.8989-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4ec13c48-f0fe-dac1-36cf-f972a7e1b2b6@gmail.com>
Date:   Wed, 5 Jan 2022 10:10:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220105180704.8989-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 10:07 AM, Lad Prabhakar wrote:
> In case of dma_alloc_coherent() failure return -ENOMEM instead of
> returning -EINVAL.
> 
> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> v1->v2
> * Dropped fixes tag as suggested by Florian/Andy

Thanks for the quick turnaround and carrying the tags forward. Cheers
-- 
Florian

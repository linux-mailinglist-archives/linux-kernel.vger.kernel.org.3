Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C273461BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 17:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345977AbhK2QlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 11:41:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239158AbhK2QjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 11:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638203750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z+0UH7faosVx15h46/+E0XlxJz/7Dmc273dgHrakKzk=;
        b=iW2nfzuON+UpAHTYZ20GN7Q2Lg6BPyvJ0uSAlf0VXidzeyseAoH/SYvxDL9Pe+ffeh+E1b
        /qeoY1z+sD014aSiEdzMaFeHQjOlI2WYsxwXX5h0COxBD75Gs/YdFO9CSGiHRz/NTrERw+
        ctqmoJctfjKshdRKJsbaBx6lLYg7zf8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-8iEEsK-QN1CKFREwtyUPNQ-1; Mon, 29 Nov 2021 11:35:49 -0500
X-MC-Unique: 8iEEsK-QN1CKFREwtyUPNQ-1
Received: by mail-ot1-f70.google.com with SMTP id i3-20020a05683033e300b0057a02219a82so7390505otu.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z+0UH7faosVx15h46/+E0XlxJz/7Dmc273dgHrakKzk=;
        b=KiL7o+lEOJu8B9IUu0K7F0GGVCQ9djmfzthzb4c51eds7hf8T4NvWTr34uCehzzRWS
         OWMxmSvEcY5oL5qa3oE20uee7ZI82Fe4mppBchjuaM50FdJw9mSVNdmjd17W5SZjo+V5
         XGuM8uxBKPJVS1o38jPa+iW4lYcDhiaEuryhmJNueDiJQ5KbFCyKzI5DX+fzdfs0Y9KE
         scCNP13QEqmY1TYJpDCkxWEhFrNGtpHhQdfjz+4s3vnc/4JNS1V++8RYIonHhsNqEfts
         5ACE6qDLADq9XT6dIora5zKMYQipEbIxhYNmD9qmHqtD3Bw6L+B/pJT/crY6P+OwoTMr
         bc+Q==
X-Gm-Message-State: AOAM532PWsfM4kcrHrV40qW8N3n2K6PoclZ79QT/dh3mfsY5sO8/GmZa
        1IZ7xut3yB4yFXJsRTIolJ0Neor1ZOqmBDC9FKq6NXwihBioSLTFGD6ZzFHSb9GDv8GBQatfUhA
        rVrQz5y751Bc6/WX0xV6w+z9j
X-Received: by 2002:a9d:12f2:: with SMTP id g105mr45667002otg.301.1638203748366;
        Mon, 29 Nov 2021 08:35:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwS/EyfAXGDPdwrwrmhMPGzKG/buDJaP6G2uXiiEwETMILIBNk9kd7VMt0tC6GrUGvPKMhIuw==
X-Received: by 2002:a9d:12f2:: with SMTP id g105mr45666930otg.301.1638203747840;
        Mon, 29 Nov 2021 08:35:47 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a16sm2710200otj.79.2021.11.29.08.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 08:35:47 -0800 (PST)
Subject: Re: [PATCH] fpga: stratix10-soc: Do not use ret uninitialized in
 s10_probe()
To:     Nathan Chancellor <nathan@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
References: <20211129161009.3625548-1-nathan@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <410b9067-588b-881e-da03-fa970ef576b1@redhat.com>
Date:   Mon, 29 Nov 2021 08:35:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211129161009.3625548-1-nathan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/29/21 8:10 AM, Nathan Chancellor wrote:
> Clang warns:
>
> drivers/fpga/stratix10-soc.c:431:9: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
>          return ret;
>                 ^~~
> drivers/fpga/stratix10-soc.c:402:9: note: initialize the variable 'ret' to silence this warning
>          int ret;
>                 ^
>                  = 0

This line to contradicts what you did, to reduce confusion, remove the 
'silence this warning line'

Change itself looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>

> 1 warning generated.
>
> ret is only assigned in an error path now so just return 0 directly.
>
> Fixes: 4ba0b2c294fe ("fpga: mgr: Use standard dev_release for class driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1517
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>   drivers/fpga/stratix10-soc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 737d14c6e0de..357cea58ec98 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -428,7 +428,7 @@ static int s10_probe(struct platform_device *pdev)
>   	}
>   
>   	platform_set_drvdata(pdev, mgr);
> -	return ret;
> +	return 0;
>   
>   probe_err:
>   	stratix10_svc_free_channel(priv->chan);
>
> base-commit: 8886a579744fbfa53e69aa453ed10ae3b1f9abac


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5474053CA87
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242633AbiFCNPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240900AbiFCNPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:15:45 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B832DABF;
        Fri,  3 Jun 2022 06:15:44 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id t22-20020a0568301e3600b0060b333f7a1eso5525743otr.0;
        Fri, 03 Jun 2022 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N+RG0Zk5ys6ys2VQCOn4syuja/2pBVS/SvIxFJpa7jE=;
        b=aLydiZUKwihBsQQiiKCuqciNN8KaSoK3pFDIt38r72VZAm9rB79zHbT3v34VubviDi
         vtr+sro4J8j6vS/5e7QibCiTJeteIJnkt7ZpuPw2dnumfacYti/AiXiAW+gn5SpfLxZx
         wgIEhIkC8vwGA+iez7sMLadk00m4EF91Is8j4a1MtdS6PA+6roO6F3jYK6Zbq18O8DFY
         4DoutGF1x14CvXdbaUk5MmVlOLOBpDLvmQmYo4tMQzbCfydxOtQ+GUfJMQIaEDgQkKpW
         rzUJbjPLlZ1/gzWYzzLi+h0njXLBDI4tYTqZHi9NANT86JWoZ1/teU18ySjr1z97gUEO
         7F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N+RG0Zk5ys6ys2VQCOn4syuja/2pBVS/SvIxFJpa7jE=;
        b=DXcrRkcuFu8+THNtz47Y9Gc2svP+Suv8W40Vyd8OxrFfbWKqusEX2HryTgwUlCvmLG
         EOUO8WwqGvl0tiQZBk36+AsKtFNqCoKq4yhQPuCIvwtU/4vVONnBkY+tqvqLhSQAPikI
         A8bPt7sVnbOOC2KmGkELo9Bm4SwFXe5yN94+5BupjYjruFe+tPToxNkGP5q39Qi2CvkE
         kAEUGZVQc9o3uHQQB40G+HDvomwD3P6Cx/CqOBMxHYTa31zilGUhcI2+rdFg2HmCfPNv
         rdvUj9jvf0IGFnQ7+3xBAHMBfK3kYFWAfjJSxK1DMwTzMSqikgRBJQXZhVBf99cb6f9y
         hAxg==
X-Gm-Message-State: AOAM5316mfIQmg2boQbyFmYrvy03lzLk0RebA588SvxBmrBCdvO4FYiI
        a9f/gGpd3bNxDJhSvka/r4CUl+daMQM=
X-Google-Smtp-Source: ABdhPJx0G+0uzl4GbXnADDD9iSN1yINSR6uJN+50E0Y7tlzFlEK2PIcEv4hr4fpDp514J2peP/pjKw==
X-Received: by 2002:a9d:6197:0:b0:60b:232e:8bc0 with SMTP id g23-20020a9d6197000000b0060b232e8bc0mr4082705otk.285.1654262143548;
        Fri, 03 Jun 2022 06:15:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e28-20020a544f1c000000b0032c18f04800sm4029969oiy.1.2022.06.03.06.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 06:15:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <10f49cf3-3f92-e5e2-d69a-77c37f12a1fe@roeck-us.net>
Date:   Fri, 3 Jun 2022 06:15:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: mainline build failure due to 6b47441bed49 ("watchdog: hpe-wdt:
 Introduce HPE GXP Watchdog")
Content-Language: en-US
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Nick Hawkins <nick.hawkins@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jean-Marie Verdun <verdun@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
References: <YpncSXSTTyKGprLi@debian>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YpncSXSTTyKGprLi@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/22 03:02, Sudip Mukherjee wrote:
> Hi All,
> 
> The latest mainline kernel branch fails to build for "arm allmodconfig"
> with the error:
> ERROR: modpost: missing MODULE_LICENSE() in drivers/watchdog/gxp-wdt.o
> make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
> 
> The file is missing MODULE_LICENSE().
> 

I sent a patch fixing the problem a minute ago.

Guenter


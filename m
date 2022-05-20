Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D88752EE82
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350509AbiETOwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244321AbiETOwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:52:41 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1079C7222C
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:52:40 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-f17f1acffeso10567821fac.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=F9NhlZ1BJrBJt+HtsXVIjBK2G+mZ/27MPaPylnb4RNE=;
        b=Jt6eAQ/B+zcTSyiZXDjHSNcrBTdKeQdAqLLh0JQZzLX3EgYQZg+X7VFmHLZOYPNq1T
         Rpf8lY7QAZZK9DcjFQvEqc2njXqcBRvQIdZyp+CCdQ2csSRvEAsNNsFjWbAnysBFcsit
         25kicyco7anuiRhakdy0AYeUoRgUO4Nm1QeYZzI/q79iRDdKuFS8hmNMF96BRckv0DRs
         J+DYumIHAcnTwfVFwUHLBs2P16wV/0UwheKPLkQhe03eSMDGhD/fHIhcBVTV/tyynZPi
         EGhwfZrKKWmcLspVmIjS/J4df89yHXsGMMGZayw9/gMxTLfgwE8MHufHDInCwgo3gnyJ
         VfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=F9NhlZ1BJrBJt+HtsXVIjBK2G+mZ/27MPaPylnb4RNE=;
        b=mRGHLMRh/qWUHykt6uZpdG/k6/sbd8aFsZWHnJtwkm+T8PmeJthVqees+e9YCUDRiG
         WxIrbwOLIY3ZrBlKFrA6DGvxCRBFqt1ui84xRsYra2xnd87fqJ+wPDzNDljDipL80z4m
         RqAHyBjL8q2UY1Hon/KEVtH/gwjHf2PDZ0yyWUhbige3vjhaqZ2zj8JkoYjhZGybzEdT
         +sTu4BDwMEJ5dgWUlPLmY+4QVRo+sX++uaLk+YTPYdo+7SKatV1DmzIuku6VS+ovp8g/
         dIlxttea1/t8i7NJ0Op2q0eFQLI6qnPFDKF+XFSBxQnCpCBk4riKHbFFTVACunQQK3OH
         RzJw==
X-Gm-Message-State: AOAM532B4OdlNZ0GaRV4dUmG9HqbcL+8n/LW/Wx7dV1JGlSg+YT/y4vH
        uqMOgOTOUUkNaxy+RqlJxgo=
X-Google-Smtp-Source: ABdhPJy7mVltaRXWRtvkPoQ4iTECp435azi4gtzOhBHMxEPqui8gPmieKENEafO2uJLBx4fV61MHvA==
X-Received: by 2002:a05:6870:248a:b0:e5:9e62:58e0 with SMTP id s10-20020a056870248a00b000e59e6258e0mr6174361oaq.21.1653058359435;
        Fri, 20 May 2022 07:52:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p7-20020a05683019c700b00606ad72bdcbsm974276otp.38.2022.05.20.07.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:52:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <286a1eef-e857-a31f-839b-00a4c835dfa9@roeck-us.net>
Date:   Fri, 20 May 2022 07:52:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <c15bedc83d90a14fffcd5b1b6bfb32b8a80282c5.1653057096.git.geert@linux-m68k.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] m68k: atari: Make Atari ROM port I/O write macros return
 void
In-Reply-To: <c15bedc83d90a14fffcd5b1b6bfb32b8a80282c5.1653057096.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/22 07:32, Geert Uytterhoeven wrote:
> The macros implementing Atari ROM port I/O writes do not cast away their
> output, unlike similar implementations for other I/O buses.
> When they are combined using conditional expressions in the definitions of
> outb() and friends, this triggers sparse warnings like:
> 
>      drivers/net/appletalk/cops.c:382:17: error: incompatible types in conditional expression (different base types):
>      drivers/net/appletalk/cops.c:382:17:    unsigned char
>      drivers/net/appletalk/cops.c:382:17:    void
> 
> Fix this by adding casts to "void".
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Survived m68k/allmodconfig.
> To be queued in the m68k tree for v5.19.
> 
> Removing the casts instead causes issues with functions propagating void
> return values (return expression in void function), which BTW sparse
> complains about, too.

We live and learn. I didn't even know that this was valid syntax.
I thought it might be easier to just fix that code, but coccinelle
reports that there are hundreds of places in the kernel where this
is done. Outch.

Guenter

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D145845FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiG1Sq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiG1SqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B4C96E2D1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659033981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjF6W4Csz4g0rUWnnoan8g4wLstWebVhsMlFWJRzp2s=;
        b=ERxE3KtlZZCEvOQ6ClkuypjDAhTUJdmvZ4bL7e2mD/zsPlmodfHAC/FcXtZV9G/+jZpzQ1
        9qhjYCV7TyGPAQZFAJpZ2a2Y0k/TJJTQoicwbl3HfTsEeGhkBbGyT/pkrtlJumyPEpFtFs
        W2tCITEda1d2z97fXyvfn29/9guIhyE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-Bbc-Yeo5PkuJEHbKTs5h0Q-1; Thu, 28 Jul 2022 14:46:20 -0400
X-MC-Unique: Bbc-Yeo5PkuJEHbKTs5h0Q-1
Received: by mail-ed1-f72.google.com with SMTP id z1-20020a05640235c100b0043bca7d9b3eso1598308edc.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 11:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UjF6W4Csz4g0rUWnnoan8g4wLstWebVhsMlFWJRzp2s=;
        b=Mt/YJS3RIlrAKja8VYLa/hhB9JpH2orTeB6WP1QFVHMXtftsEdbkR2agSML3exTajo
         boUm6OEwlcPiJsxmn3lZiDLpDDZBOpnyLToSSPooPERF4sbThtKPD5nSUk53Q6/3kGAg
         ZZAWO8uEccXfXQSl/nzSO+05KWq1j3Y5+4sT+hwatZoGQtAqFtwUjRHSyhpiNBn9JQoe
         dRQdPHMtKx4CLVfRDcAXivILlGGLdo/L5lDWuOy/JK0KNadsCjxyw5zNXX177LHH/i4R
         Bo3KOxVUfdE/H2H3OyRXqgcb9Z7F3jzPw/BXydCNSF6JyUeAcyaqGU2LOyc0Ofvgd5s5
         shZg==
X-Gm-Message-State: AJIora8U6404hV4kQG71oPVMOwTgx6w0buntxU3hAeG3POR+J6IB6Srt
        uGKYb3QjHALnqocWfft+kxWve/nITTEVmLS6XJYEUzb0SEm1BW7PVMa/1AkciIYTZIKO4m3yz94
        Wtw+LVduOgA8XE0YvzOypfJS0
X-Received: by 2002:a17:907:7ba9:b0:72f:2994:74aa with SMTP id ne41-20020a1709077ba900b0072f299474aamr198716ejc.85.1659033978863;
        Thu, 28 Jul 2022 11:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vp3AJuTTutmrSFCg3orG4R7IBnDwQmGu+7Ego5p5sGZrqIbp7PLCS9usMJA/fn2Q+kkUuUVA==
X-Received: by 2002:a17:907:7ba9:b0:72f:2994:74aa with SMTP id ne41-20020a1709077ba900b0072f299474aamr198701ejc.85.1659033978404;
        Thu, 28 Jul 2022 11:46:18 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id yw17-20020a170907245100b00722fadc4279sm686602ejb.124.2022.07.28.11.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 11:46:17 -0700 (PDT)
Message-ID: <63a992e4-6016-7063-8219-ac59288a6ec0@redhat.com>
Date:   Thu, 28 Jul 2022 20:46:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] platform/x86: Fix comment typo
Content-Language: en-US
To:     Xin Gao <gaoxin@cdjrlc.com>, paul.gortmaker@windriver.com
Cc:     linux-kernel@vger.kernel.org
References: <20220722022337.15903-1-gaoxin@cdjrlc.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220722022337.15903-1-gaoxin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/22/22 04:23, Xin Gao wrote:
> The double `of' is duplicated in line 50, remove one.
> 
> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  include/linux/platform_data/x86/pmc_atom.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/platform_data/x86/pmc_atom.h b/include/linux/platform_data/x86/pmc_atom.h
> index 6807839c718b..3edfb6d4e67a 100644
> --- a/include/linux/platform_data/x86/pmc_atom.h
> +++ b/include/linux/platform_data/x86/pmc_atom.h
> @@ -47,7 +47,7 @@
>  #define	PMC_S0I2_TMR		0x88
>  #define	PMC_S0I3_TMR		0x8C
>  #define	PMC_S0_TMR		0x90
> -/* Sleep state counter is in units of of 32us */
> +/* Sleep state counter is in units of 32us */
>  #define	PMC_TMR_SHIFT		5
>  
>  /* Power status of power islands */


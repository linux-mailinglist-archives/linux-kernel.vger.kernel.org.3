Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307CF48CE54
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 23:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiALWXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 17:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiALWXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 17:23:44 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24352C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 14:23:44 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso15245303pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 14:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TMVKGQT49DH/LLD/tFy3QBNX0mSxKPeroeqStkkLKDI=;
        b=4mJ6gOW0jxKBgn3no0jpmA7lTgfKK/qra/ahbL067VCRLqG64Vz6ho1TL9diR6f/YW
         ZpuDFNqcApFUH32aT9Z4SXVORRl2PwOR3UJRdWKMsp4FQxE1MOsnL8iIubWzpsyaCNay
         1UhT26UYb/F+VUjUTIqDmE3rQDwY3aWCxgSGeLrlHmOyytf9DB5Y2IQZYkDHO/fSmozX
         za0dcRrwnbJgZamkvLKrFdn1TdpNOA+o764pVasIY7UrCZycKuK1hTjjzuSJpZ/XlA7d
         jgRCJ4eDy9xsLJZ+NEmxfxNE1yDsXsyx4f1027YAsC0ssWYxASU6DRIjNk9AED6jMlTr
         9bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TMVKGQT49DH/LLD/tFy3QBNX0mSxKPeroeqStkkLKDI=;
        b=63k32SkImlt8fA43wwEIF//SY1VeE/kmjD6k9065+Oab618lPjRbtXr6kPwVqPsDn7
         Edv9PYB7Y2b/IJyeXyejIMbUw2heOQ7B2TUcU/AlamThvwSBYgjc8jHUQgJ7HKBv5+Xt
         rQNv4N9yFBEPkPV/YsLETWeFdGU/vjiT26VQoHzNDZgRphJnJB2JyZ5OcYvagchZwmId
         cedzGCG4eAiQTADC/ytjlkr3a9d4Tq0XfIEEiE9fby5QXOgDlSerasZGw4/j6KsC6nLD
         mbvQ2btR0TC+XO2hIM2zDn97IqQRfTTGSNk8kyyNZ08B3Df6QtIVEaPMmSPI6Zx05p0Q
         QPew==
X-Gm-Message-State: AOAM531JG3glAz/l5IAFQSooFwUmdnGrEXL3M9lyPnu1oAn15moxo3oz
        paKrP/vNO7Kce5pVuPtULu0RAo3wC3PoXA==
X-Google-Smtp-Source: ABdhPJyhNaErTayGibYA8zyghPidZI+lSfKnbcuGDtxIF28nf7vE6WFskHj59uD1diaxL90oD9xAvQ==
X-Received: by 2002:a17:902:7e4a:b0:14a:1da5:88dd with SMTP id a10-20020a1709027e4a00b0014a1da588ddmr1783673pln.125.1642026223358;
        Wed, 12 Jan 2022 14:23:43 -0800 (PST)
Received: from ?IPv6:2600:380:767c:9370:809f:a3be:808e:2696? ([2600:380:767c:9370:809f:a3be:808e:2696])
        by smtp.gmail.com with ESMTPSA id v15sm548174pfu.203.2022.01.12.14.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 14:23:42 -0800 (PST)
Subject: Re: [PATCH][RESEND] sata_fsl: Use struct_group() for memcpy() region
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220112220652.3952944-1-keescook@chromium.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df3eefdc-d8d1-48fa-f5f7-9c2f2382842b@kernel.dk>
Date:   Wed, 12 Jan 2022 15:23:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220112220652.3952944-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/22 3:06 PM, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally writing across neighboring fields.
> 
> Use struct_group() in struct command_desc around members acmd and fill,
> so they can be referenced together. This will allow memset(), memcpy(),
> and sizeof() to more easily reason about sizes, improve readability,
> and avoid future warnings about writing beyond the end of acmd:
> 
> In function 'fortify_memset_chk',
>     inlined from 'sata_fsl_qc_prep' at drivers/ata/sata_fsl.c:534:3:
> ./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
>   199 |    __write_overflow_field();
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-ide@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Jens, can you take (or Ack) this? It's a dependency for the FORTIFY_SOURCE
> improvements that are close to being finished. :)

I don't maintain libata anymore, so Damien is the guy to nudge ;-)

-- 
Jens Axboe


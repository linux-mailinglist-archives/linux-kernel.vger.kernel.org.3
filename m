Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B2B4908DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbiAQMmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239966AbiAQMmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:42:02 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1265C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:42:01 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id g14so45334458ybs.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vAmFUqrC0PksSSA2pMtmtsSscMtr7L+ruC6Pf2vhQnE=;
        b=e2bMOzD6lFvxfjU1JWi/EP+qcCLvVyTMOV06myYdjWq34wqNWJzOikTOYQ47Fiuw/X
         pSkOTE+pLL7w8DbMB9AEWd4xKCTPZfAP5WR6vW1ebgqvqXcx+bTDNMEHFSllfIeb8VFz
         9h4iD8hED19+5Kp2Qw8HPKyDauoLc1HyQxURhgIgLLiMueg85slmtbft0dfJVAamzSUo
         V+aeGqgnX8FU4h6LWcS9AeA5pxShh3CkY80HKJ4X+AgpAmB9tLNzVQZ/9tmLq4tbk/xS
         MQnLnHfy7eD4X8ws9cLWfX3s4s7H4keEnjxEESQuLldmZtHkmSLWptYn+j2p86vKI8p3
         jaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vAmFUqrC0PksSSA2pMtmtsSscMtr7L+ruC6Pf2vhQnE=;
        b=I0VX6nKjanpvPL91VlfJr/5qZvmmyvDfAqCMKhw/+FVsiwlKg8ZcZUhrmDtHgIFny0
         X2tsMBpTq0U3jN7nlS0cN9G/FtS/wZ4jHcVGpqsPrC+BhD7zDlQtfKsQrMPGeTbDsyxD
         Rifx3L4FmTVTiZudi4OQ36YkMeH2DR8+lJDG3YUunPHnjKjX4l0P2tX0JM2/YkJandMu
         W06PuT/TQ4nltTG5gwOgYCweL7z1fuOIj9Amd67Ffr4f1eQkZuefCBAAa3vWX6VFWUEn
         GpFtPrq1WuFgs6/GzewJJOuiCfiAjRe+5JJEP397zS/MQ32PMBS8Yy0gm+b8YUM1mbTx
         U5yQ==
X-Gm-Message-State: AOAM531AQ3EQtTEbV0hAopRQnZqAWyf+1eFs68ZpkV5qHRcmINJ86p0X
        kPwLRgdr6aW9BhXv7PlTu1vFmyqxeJs2+t/a+TKmNDlhV3JJhA==
X-Google-Smtp-Source: ABdhPJwFcWegAP/aLBiQS2RDOI0Vfg/3kYpQ7IAjve/Fx5jG6zBvjvW74xJsvC4FSVsUwOS9wCM3NvGN1aPUjQAvZa8=
X-Received: by 2002:a05:6902:1141:: with SMTP id p1mr3065197ybu.393.1642423320797;
 Mon, 17 Jan 2022 04:42:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a81:3cd:0:0:0:0:0 with HTTP; Mon, 17 Jan 2022 04:42:00 -0800 (PST)
In-Reply-To: <eea2c529-b874-58e6-f0b2-1483cc7e30a6@intel.com>
References: <20220113213027.457282-1-martin.fernandez@eclypsium.com>
 <20220113213027.457282-4-martin.fernandez@eclypsium.com> <eea2c529-b874-58e6-f0b2-1483cc7e30a6@intel.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Mon, 17 Jan 2022 09:42:00 -0300
Message-ID: <CAKgze5Z7U0R+HJ8_GajUsspYw+52+i2MW75KBGVOmE8zmT_BDQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] x86/e820: Tag e820_entry with crypto capabilities
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/22, Dave Hansen <dave.hansen@intel.com> wrote:
> On 1/13/22 1:30 PM, Martin Fernandez wrote:
>> +/*
>> + * Update crypto capabilities in a range
>> + */
>> +static u64 __init __e820__range_update_crypto(struct e820_table *table,
>> +					      u64 start, u64 size,
>> +					      enum e820_crypto_capabilities crypto_capable)
>
> This looks like an almost pure copy-and-paste of a 70-line function.
> That's not the end of the world, but it does seem like a place where
> refactoring is in order.
>
> The rest of this series looks pretty straightforward, but this part in
> particular is the most worrying.
>

Yep, I'm not super happy with this either. I'll check it out to see
what we can do. Btw e820__range_remove is quite similiar too.

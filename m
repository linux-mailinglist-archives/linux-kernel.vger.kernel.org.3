Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EACB47891B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhLQKmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:42:35 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44702
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232014AbhLQKme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:42:34 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3D1493FFD0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 10:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639737750;
        bh=Cch2YRuTHpQOb264zUOrMD/m+Xgx+o5ASl1QOhMgcdU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=g+/1IoatiKhPLDuO+Ml1DTYIcRH7o+dmuLSkkmuYEnQ1mRWhqaeMlfqgaD2tCDC/w
         2zNhuN4/h4ejTqzYCohQKIaWtSyLMfJq+l70OTkAQU1QdGrkEOuJxI4Zaxed9c0wIb
         GTCyvkSAL51PcLTWPGEI0bOl1jAYYTLmWlqvyUQjteauXjIUS68+rlO6KK8LR86VcY
         3ifKPU00Wu+PzI0lDatcI9hd763RdnouXkecyxtsDV8TjOzz/jEWu+NQBtE58mX7/r
         ATHJeiYH78nSp7K2PlOzKgtBJW/ZHtUAdGlWR+Xd9d5A/S0UH0x0Y1xf0Vz5CzsUbi
         9lIQ2LDV/txlw==
Received: by mail-wm1-f69.google.com with SMTP id z200-20020a1c7ed1000000b0034574ef8356so862640wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 02:42:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cch2YRuTHpQOb264zUOrMD/m+Xgx+o5ASl1QOhMgcdU=;
        b=Uw6fXBh/plb5KxaOUYSJoGy36YG8wpCKCAA/8Lm9SKGBEiaa8ugyCC50E/D5s7FNtz
         sxQlSzYU0EC8hJPljVb0a66HlevMJ4bCL5sLkZmJsUVTProNGgPufm3aveTp45WnG975
         HgHVE1Wf6hDFcOit/jBJf0z0AaQRIq9IQkzXXH7VEHjZVn284xLjHO+mIjL4zmsIqFJp
         4r0SvtXm75T6QrJXdnNt0Viu6gwy40rfrim3L0Or2VNpDF5MCB2pevVmQPDHBoHXoxn8
         Kzd+2A9YNmG7Ya6tAlXGTPT4dZgrC7/AoxiKjP00PMklc3vZNX3O6UpgaO9gmVHFZe/q
         u4XQ==
X-Gm-Message-State: AOAM531Cj4VEm6dRekLknxEJSuHZG4TuTaygcb8pwNE+FCAmIeNhPbmQ
        yAws9XMNgbxiPg9YBSbhVKiJZqHc+dWH71AagqwBUAOOW7FK+6HzBe4+TSrJok/A5El0xVod7Vy
        47s6N2aEcDZo9/mGdWLWhk0yzBo3v6JiqMh9WmaCIEA==
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr2199902wri.158.1639737748955;
        Fri, 17 Dec 2021 02:42:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5yYBNvNIR6wOPIyl83PueKllFASZM93qe3PncXh68LjxD9RvBVSXqlHNHsv81WWLN5bSd4g==
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr2199882wri.158.1639737748768;
        Fri, 17 Dec 2021 02:42:28 -0800 (PST)
Received: from [192.168.123.35] (ip-88-152-144-157.hsi03.unitymediagroup.de. [88.152.144.157])
        by smtp.gmail.com with ESMTPSA id b19sm11536525wmb.38.2021.12.17.02.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 02:42:28 -0800 (PST)
Message-ID: <611d4055-c50c-55c1-0e02-43ffda66dbce@canonical.com>
Date:   Fri, 17 Dec 2021 11:42:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/1] riscv: default to CONFIG_RISCV_SBI_V01=n
Content-Language: en-US
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211216123538.175087-1-heinrich.schuchardt@canonical.com>
 <BC1B38E7-1170-4C05-948A-D18E80AC49E7@jrtc27.com>
 <fd40010f-f2ec-b32a-6850-1e054af43725@canonical.com>
 <150C4E84-2C69-45DB-AF27-1E0C223D8D7A@jrtc27.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <150C4E84-2C69-45DB-AF27-1E0C223D8D7A@jrtc27.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/21 17:51, Jessica Clarke wrote:
> On 16 Dec 2021, at 14:17, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 12/16/21 14:49, Jessica Clarke wrote:
>>> On 16 Dec 2021, at 12:35, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> The SBI 0.1 specification is obsolete. The current version is 0.3.
>>>> Hence we should not rely by default on SBI 0.1 being implemented.
>>> It’s what BBL implements, and some people are still using it,
>>> especially given early hardware shipped before OpenSBI grew in
>>> popularity.
>>> Jess
>>
>> Do you mean BBL is not developed anymore?
>>
>> Some people may still be using a 0.1 SBI. But that minority stuck on an outdated software stack does not justify defaulting to deprecated settings in future Linux releases.
> 
> BBL is still actively maintained; its most recent commit was 24 days
> ago. Also, the amount of code CONFIG_RISCV_SBI_V01 affects is tiny, so
> I see no tangible benefit from making this change, just unnecessary
> breakage of perfectly functional systems.

Only the default is changed. How could this break any existing system?
You can still compile with the deprecated setting.

I can not see why we should keep a default that will cause issues on 
systems complying to the current SBI specification.

Best regards

Heinrich


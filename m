Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C86E477436
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhLPOR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:17:28 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37760
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229792AbhLPOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:17:28 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EC75D3FFD9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639664246;
        bh=hXcKig2BTgNYlsnaKeNaeezzj0lAoxAXYJuGyAPXer0=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=tATwKonCqcd9rCmNOWVVvMgx/DZLUwWeMkhoVI9TkSV9VOH50u7t0PwKR5Hb3vvR2
         QYun/xsgaMt6MUO5RmjEoGB6bk9A+uvkRe1ejxI8A1rwn9zTCXu/+DNgI2FH7itrwD
         /LmXVr8M+2PHUBy+Gl1TcRbt1fobxxKbwuk4DxVZV8Sxe5z5etG32gJh1ugqHWk7H0
         5HM5sAIXOf0PsJrPRylDs8Fz1f0dO76ZBRFh/VwSa/kHPMdHfGcy3jgEfFRr2qqkY6
         t1s0Bg6SF8SkZBcC8O8YaaSAoPqUSy8DdM2QP4yaA+uZCuewF1XuppPraDfqp0yzYR
         G4kli7fXlyhKA==
Received: by mail-wm1-f69.google.com with SMTP id j71-20020a1c234a000000b00342f418ae7cso1343229wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 06:17:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hXcKig2BTgNYlsnaKeNaeezzj0lAoxAXYJuGyAPXer0=;
        b=gdoiQ9kzu4BY6e38fcuCC2FqG0ff0oSFM94b4ob9i2wkJgf5Wx3OSvGvmyOAdLhXTa
         EPLdHteaJRpfe//adQojmZDbS3ow54/GByd37okw+vwnZ2gYniInHKEvgZKxyvqHh4RG
         KyvexUKkCGs2YopcPZ/64XuQLpCwl/6+9XtT00LkWDVCslFcJ0BNQ0+9Z/KL4V7iu6lc
         ah8mVR9s2R7Ulz5OVTFvrW/dC/XBnhIe0vZ7siRgQJ0mKMFec7fb93zEBEZQPguC3FsS
         WTU3Ids7GI1BbgqZ7AFuHxUhsyK7rRNFmSSBxOWtQDyUsskomu6LSmS/UNeIxecSTDMR
         Kb9Q==
X-Gm-Message-State: AOAM531Fqtb57CW/XcBCugIjq25gPwznpJ+n2pe95es+tWo/NBSUslva
        znvBReq87RgKS/za2ougvbwempK9ERA739EBYbtUglgY+dvKlrRBkRIZ8VpI/mQrNOZNqv8x+Cl
        xDfa69On4awWli8nJ+ibb6+a8MzGAkIiXKigzV5s5TA==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr9316094wro.324.1639664246526;
        Thu, 16 Dec 2021 06:17:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQzaGzh5uSvdXoD/U0jonieRUBkngZQxVU6MeqdFjuxxNDCLX8Dbfju2GouOfAFj1rfc6n9A==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr9316079wro.324.1639664246280;
        Thu, 16 Dec 2021 06:17:26 -0800 (PST)
Received: from [192.168.123.55] (ip-88-152-144-157.hsi03.unitymediagroup.de. [88.152.144.157])
        by smtp.gmail.com with ESMTPSA id o2sm3822032wru.109.2021.12.16.06.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 06:17:25 -0800 (PST)
Message-ID: <fd40010f-f2ec-b32a-6850-1e054af43725@canonical.com>
Date:   Thu, 16 Dec 2021 15:17:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/1] riscv: default to CONFIG_RISCV_SBI_V01=n
Content-Language: en-US
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211216123538.175087-1-heinrich.schuchardt@canonical.com>
 <BC1B38E7-1170-4C05-948A-D18E80AC49E7@jrtc27.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <BC1B38E7-1170-4C05-948A-D18E80AC49E7@jrtc27.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/21 14:49, Jessica Clarke wrote:
> On 16 Dec 2021, at 12:35, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
>>
>> The SBI 0.1 specification is obsolete. The current version is 0.3.
>> Hence we should not rely by default on SBI 0.1 being implemented.
> 
> It’s what BBL implements, and some people are still using it,
> especially given early hardware shipped before OpenSBI grew in
> popularity.
> 
> Jess
> 

Do you mean BBL is not developed anymore?

Some people may still be using a 0.1 SBI. But that minority stuck on an 
outdated software stack does not justify defaulting to deprecated 
settings in future Linux releases.

Best regards

Heinrich

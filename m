Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2379B47F2DD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 11:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhLYKL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 05:11:26 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52936
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229680AbhLYKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 05:11:25 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 23BC23F1F2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 10:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640427078;
        bh=I39oV/QZaWmlVgFT3DcbTijQiyG6xjSwFwSGQ0EVsOQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=EZQT3CtUQQ2gvjtwuwPnEYjZUl4pc0oL9rjmPqp4yF6mih0UOGbsk4FChjYQ97Iy8
         q4nRYtKlbEot5dC7VrKiGkTpY/BmD2xf4bF0AYrUV8Us5eaSvIpyf9um644hN4grVd
         CrUtw+Q7u4HppHy3KBPZ2MMdx9WqLvqqvY7qQHOLEDrDCviNqGKbE9cMRWBqvIeD2z
         xh5jyWaYfX+8QqmxXgy0xWAb6saP2na+4sVZyCFVaM/fdmyR7kMQ6MzGMlYxYy3eSf
         HwMSDJPadMyu/w31bb/v6gEIkteqond5l5j8jzLj4eTuOdJZOtMXKPLWsDXq8xxIYv
         WvS5uamwnQiAA==
Received: by mail-lj1-f197.google.com with SMTP id k20-20020a2e9214000000b0022d6b13bc8aso2874066ljg.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 02:11:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I39oV/QZaWmlVgFT3DcbTijQiyG6xjSwFwSGQ0EVsOQ=;
        b=27LCy/7nM78zIiD+X+1CidWIsr5MEtJ/n90GaAEx06fF4VoVnnrlUgulGzt2EdK8rj
         G5BkRD2YTZEAz+BlZO2ZTkLTZKtzxgvb6pnS09FTrKb4OX2oQd7ujM78SJAVqv6qMU3I
         axUNwwY8KURtIvvIzuJz6Rbwg1TSv3kqy3Z3sJQA8oMzDyiBAUnq8nK8Cz81LcACS7yt
         9KIYH1GAn83JBetAD5nWxmyx67IizLHvLV5IRFjChkGDjXg2c2GkgNN9yvFEogRVYgR/
         V1nrOkIXowuxLmLlcTO1GDzbuXwzPFsynf9o+N8cKEbf2gYXEqtntjsAD8oDw6mWrMS8
         S1YQ==
X-Gm-Message-State: AOAM533Jc1mLGXmQQlEftOcPIWS6VpS+kN6hiQpEosmxEoVO6TONbqJu
        aPOdcdu8cyRVSRySkDJ2y1X4R5fvscNY/aqYchyt9CdqQXSkjymMvJqyPkgp5hY9dK/dnBFNz4w
        QfzePiMJNIkIOvRk76uDqOb5ZLyT6Gho1PHVzuuQ/Nw==
X-Received: by 2002:ac2:4e06:: with SMTP id e6mr7482614lfr.295.1640427077521;
        Sat, 25 Dec 2021 02:11:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx4sjq+1CG+HpXFM71RWmF3bJveHv7XWD7dzylenrpt+oIJERl9BtbYscnpD8bEiahaL/dhKw==
X-Received: by 2002:ac2:4e06:: with SMTP id e6mr7482598lfr.295.1640427077285;
        Sat, 25 Dec 2021 02:11:17 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id f19sm183205lfv.100.2021.12.25.02.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Dec 2021 02:11:16 -0800 (PST)
Message-ID: <e20a52cf-69cf-747d-7cfb-0a2b58008ce4@canonical.com>
Date:   Sat, 25 Dec 2021 11:11:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v1 1/2] RISC-V: Provide a framework for parsing
 multi-letter ISA extensions
Content-Language: en-US
To:     Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20211224211632.1698523-1-atishp@rivosinc.com>
 <20211224211632.1698523-2-atishp@rivosinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211224211632.1698523-2-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/12/2021 22:16, Atish Patra wrote:
> Recently, there were 15 specifications/40 ISA extensions were ratified.
> Except hypervisor ('H') extension, all of them are multi-letter extensions.
> Going forward, there will be more number of multi-letter extensions as
> well. Parsing all of these extensions from ISA string is not scalable.
> Thus, this patch provides a DT based framework to for easy parsing and
> querying of any ISA extensions. It facilitates custom user visible strings
> for the ISA extensions via /proc/cpuinfo as well.
> 
> Currently, there are no platforms with heterogeneous Linux capable harts.
> That's why, this patch supports only a single DT node which can only work
> for systems with homogeneous harts. To support heterogeneous systems, this
> cpu node must be a subnode for each cpu.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Your from address does not match SoB. Please use consistent one - they
must match.


Best regards,
Krzysztof

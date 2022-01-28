Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208CC49F369
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346336AbiA1GRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:17:33 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33878
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346329AbiA1GRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:17:31 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 59FEE4000F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643350650;
        bh=0t1V4zvmNPJT9wYj/Pd8jJat58ip8FOEKuqF28wuRD4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FyJ2/j2wgzrB4h9LmTBiQO7jB3URILRuw7et+JxYY6p/3Ii4ogyi/VupkdKNEfoyx
         C2Osh0A+OLKDLiWWO1Q4DuquXp8cNh1YM8WqKggfMkXhZtUABhoBUsTQ4EOTF8lGWj
         Hd4g6CI1JGwqDV+HI3PtkIGPni2VhnyIDbOag2S0xU9DLjv0cHgOp+bJ34BzYR22Vb
         Zw5H332OMbjxYRb8nNUy0KOh7v4N4OGJaaNqkIJlSEZRydhcdX6cYprI9J14Szybc2
         O7FMMKQ0J2VegHe8DK49iorVSjqdZVZUZW1g8aVhBX4xO4BKhFNlxaH3bCVDv0cpM9
         Q1p1q3VIhrSMg==
Received: by mail-wr1-f70.google.com with SMTP id w19-20020adf8bd3000000b001df887ad0caso531018wra.18
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0t1V4zvmNPJT9wYj/Pd8jJat58ip8FOEKuqF28wuRD4=;
        b=fD1bCdG5WlPnnlLOF3FEsX1M6M0IIBc+RVKhgX9Q/n2pl+tMwp893Zz/RjOX1+g5fQ
         rpcQdu8ndvCasLlmZvJqx65DHds1ys1D9nFDUrr7fTq4Jbb/94Gl8IW81mYi2ZmTL+TT
         mgtOlGEsOhIUX1caCo21L0w2dzUoKEHysJ3CMpZyEH3DZ+NYqy6cWJPw37gHjzhPoV3b
         4yj+jdxuPW4qtz8QDrJLQyu3s2+/O7bjR83eUxa8Wnyzvlsc+CfglILGaXOLsiwuKdYx
         0p6hKWCn6/Z4APUd/0Q5UsgKSpY+oYe8LtLCJlDxNhvqcwpb7SzdU5jlOP0k8wQ8cC6n
         TcrQ==
X-Gm-Message-State: AOAM532Fl4c3QJ/hAmYR/LMyTw/FWJLBqMqKWtrxJP6LQM80yKjfTmlP
        R4ylt3ErKbtKpuQuQz4HO8v1cWKBrtDiH8D7RIv7agMtHhC9dbG3x/IYIUaVA5LBFiTSa+acJlU
        RzNMQ0W5CC4fTS5jYFmDyQ52aOilmdJpSOkD9lYK2TQ==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr5875251wrr.220.1643350649374;
        Thu, 27 Jan 2022 22:17:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnfGoUTSgGUq+FTJ1O5uTS7OjWZEbG246bwyKtGG3BSFUg0GOMLfkbUl4tx/4Z1J+yMAiWqg==
X-Received: by 2002:adf:fb05:: with SMTP id c5mr5875223wrr.220.1643350649139;
        Thu, 27 Jan 2022 22:17:29 -0800 (PST)
Received: from [192.168.123.94] (ip-088-152-144-107.um26.pools.vodafone-ip.de. [88.152.144.107])
        by smtp.gmail.com with ESMTPSA id m6sm1158698wmq.6.2022.01.27.22.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 22:17:28 -0800 (PST)
Message-ID: <6cd57022-6fe3-d065-dbe3-e9487894a94c@canonical.com>
Date:   Fri, 28 Jan 2022 07:17:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] riscv/efi_stub: Fix get_boot_hartid_from_fdt() return
 value
Content-Language: en-US
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <apatel@ventanamicro.com>,
        stable@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Ard Biesheuvel <ardb@kernel.org>
References: <20220128045004.4843-1-sunilvl@ventanamicro.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220128045004.4843-1-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 05:50, Sunil V L wrote:
> The get_boot_hartid_from_fdt() function currently returns U32_MAX
> for failure case which is not correct because U32_MAX is a valid
> hartid value. This patch fixes the issue by returning error code.
> 
> Fixes: d7071743db31 ("RISC-V: Add EFI stub support.")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D6E47F86C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 18:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhLZRq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 12:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhLZRq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 12:46:57 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5765C06173E;
        Sun, 26 Dec 2021 09:46:56 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bq20so30249967lfb.4;
        Sun, 26 Dec 2021 09:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=1w90fj4mBw0ATe2jw+OEN+E/mxrPl/6mvO0lB1elWYw=;
        b=NhelbEc7H25j4w4qqmn1ZesJ/IXwasoOkXAE4oe0kZiPgWYOwPpbwD06+S1fAlo8hX
         1Qux5McMz+OwHDoItUKob6/hDqqXYTFrENaD5/mNALjRcZZvCj5jxR4N8SvmZRZTPMfZ
         l5Lsmqe5h6C2OhRz90l34/LcGs4rr4XE6uaUsm0I/3Mu8OBIoriEki7CNhCOg5yU0ex0
         YWlML6ikurmBlFTnpRDm/VDZHLt71PR64NI27fKj6nNll5wq5LP8gRjQLKLSjyiU7J0k
         z3srxtrF1KltKXCTh659Z5FZqnYzSDzeqZ/QB7C5b4kI0X5AVRDupd/jxtP1Rvx/Od0S
         aFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=1w90fj4mBw0ATe2jw+OEN+E/mxrPl/6mvO0lB1elWYw=;
        b=rmooN1DIatom91C+mtcufT9eiaxnywYTsyMJDl5HnLmOAfkiMXGQrtIoDNAwCMKO+G
         ajp4/YkaidUGjC/yeutL9iWHPfsjZp7YWPrh0uHZ4xiryMqbW6DUNIfEq+2F86deQ1Cu
         M8NCYo31apRxiNaOJxAul6eP/6ODXWHs0+wcqunwTsnK3wYbZ2QL52ktY6BWCtLHyfSn
         FpuUZ59q+EHqvhVTjR/Qv75AS4wDKsz5XJmx3pV6wMCznrO8F/KqPospimfYHHVHSMKq
         M2YokLCT/aaIh6bY7lQ19PXfR16bFHCx1MH5CSO1Y9XwVicX5acAmNuv9HtXGtvi7qmV
         yIEA==
X-Gm-Message-State: AOAM531vsz4qUdR6L8KeU4voMFagbK+yqWeDbHnXlHg/2TH+gRmiNp4c
        JJXramrPJLRpmdYT0XWv7XM=
X-Google-Smtp-Source: ABdhPJwGbMTS2uWuY4yPIEhkOprjE/nskYYB4CkNKpfaTldSDtEP89dPvQTKl/OeIjTgRx8CTq+ujg==
X-Received: by 2002:a19:644f:: with SMTP id b15mr12241624lfj.76.1640540814978;
        Sun, 26 Dec 2021 09:46:54 -0800 (PST)
Received: from [192.168.1.100] ([178.176.72.233])
        by smtp.gmail.com with ESMTPSA id by8sm181807ljb.106.2021.12.26.09.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Dec 2021 09:46:54 -0800 (PST)
Message-ID: <e0a56147-e800-914b-1df3-51ca7003a69d@gmail.com>
Date:   Sun, 26 Dec 2021 20:46:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] clk: renesas: r8a7799[05]: Add MLP clocks
Content-Language: en-US
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211225193957.2195012-1-nikita.yoush@cogentembedded.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
In-Reply-To: <20211225193957.2195012-1-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.12.2021 22:39, Nikita Yushchenko wrote:

> Add clocks for MLP modules on Renesas R-Car E3 and D3 SoCs.
> 
> Similar to other R-Car Gen3 SoC, exact information on parent for MLP
> clock on E3 and D3 is not available. However, since parent for this
> clocl is not anyhow software-controllable, the only harm from this

    s/clocl/clock/. :-)

> is inexact information exported via debugfs. So just keep the parent
> set in the same way as with other Gen3 SoCs.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
[...]

MBR, Sergey

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBDE52CE55
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiESI3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiESI3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:29:52 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE41B7981A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:29:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 9710C419BC;
        Thu, 19 May 2022 08:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1652948988; bh=5kyzTvASw3UKGusahQelKEPBKdXW7kdc8VKMIbe/oIQ=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=ojaiMLekIVlHOaF77Y5cGLw1S8Zx87mKedlKGJR4lKcJGtd2Gt/jm3zxxRfTJCRPc
         AuGKoRGspVv4G6rAcHktsBWHBlu8NrzGxugEKMA9lXrFhLgpFtYqLxvqz0Pw6FNBN4
         z82mxtTnRLJbfHDlOPiLIQPhMg96g2x817T1pMDxUfF/Sd13iUVetvxbpj6OpXaybT
         OcDXNNj0sArUiXh4qPFx+86ftmYBtPs8/iknm/Xxhk/Zin7xSJgQns6G82HLQqB7nd
         mOlYw7L2ElCF3La1V3XCXee9iP3LgHtqXh0LCikXhFrI8Ktu04Lk06xmoUQxhEM0G1
         oS9tOR/N7Lj2A==
Message-ID: <57184edb-8a04-b4bd-969b-bca152375d86@marcan.st>
Date:   Thu, 19 May 2022 17:29:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/8] Add hardware prefetch control driver for A64FX and
 x86
Content-Language: es-ES
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, mchehab+huawei@kernel.org, eugenis@google.com,
        tony.luck@intel.com, pcc@google.com, peterz@infradead.org,
        marcos@orca.pet, conor.dooley@microchip.com,
        nicolas.ferre@microchip.com, linus.walleij@linaro.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2022 15.30, Kohei Tarumizu wrote:
> This patch series add sysfs interface to control CPU's hardware
> prefetch behavior for performance tuning from userspace for the
> processor A64FX and x86 (on supported CPU).
> 

[snip]

> In pattern A, a change of dist at L1 has a larger effect. On the other
> hand, in pattern B, the change of dist at L2 has a larger effect.
> As described above, the optimal dist combination depends on the
> characteristics of the application. Therefore, such a sysfs interface
> is useful for performance tuning.

If this is something to be tuned for specific applications, shouldn't it
be a prctl or similar and part of process context, so different
applications can use different settings (or even a single application
depending on what it's doing)? Especially if writing those sysregs/MSRs
is cheap.

In particular, configuring things separately for different cores feels
strange. You'd then have to pin applications to specific cores to get
the benefits, and wouldn't be able to optimize for multiple applications
running simultaneously that need different prefetch behavior if they
share cores.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

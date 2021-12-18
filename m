Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075F64799F7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 10:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhLRJgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 04:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhLRJgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 04:36:38 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0D4C06173E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 01:36:38 -0800 (PST)
Received: from [IPv6:2a02:a03f:eafe:c901:e9c7:274f:a8f6:5f25] (unknown [IPv6:2a02:a03f:eafe:c901:e9c7:274f:a8f6:5f25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 35193282F99;
        Sat, 18 Dec 2021 10:36:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1639820196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ic3nSXTrokVKYLO53tYmm3SIRtfWjuQABsYBaeQn/c=;
        b=3W3pRNWYL1QSh5GvDbU/qEr9mvAIiHfIGH9HtGkOOKCAE/lTdFm7mCWcAddIFBiDlfy+8W
        H2eGnb3nG2D5dpjXv7B7mGaVehg885G2VpE1jLg6D7dsqqaGfakCiycRzr8b7P53+ebzsO
        XgJ97Ume+rNGG9uJaqTqSieAz479dIPJwhoJM7/bOKMoJeSFXp2eZWs8/uua3xd6R9wm+M
        AhFow/iF+7Wg9k6AVDfSaFdGFQzAzrt3rC6rXc2LVF53J4ZI1C9F0Rmg7fj8+2yKw34tFm
        Vo7fuMal9gYvw4QaDhQRs91AWe/bHum9cszZZteB8zcNNMWzi9UEQewgM/T6Rw==
Message-ID: <e570866957f677aab77f2ecb48befc0dcc4481f4.camel@svanheule.net>
Subject: Re: [PATCH] MIPS: generic: enable SMP on SMVP systems
From:   Sander Vanheule <sander@svanheule.net>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org,
        INAGAKI Hiroshi <musashino.open@gmail.com>
Date:   Sat, 18 Dec 2021 10:36:35 +0100
In-Reply-To: <dbff4beb-1982-1568-ab7e-2b12ad956a06@flygoat.com>
References: <20211217183930.16192-1-sander@svanheule.net>
         <dbff4beb-1982-1568-ab7e-2b12ad956a06@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxun,

On Fri, 2021-12-17 at 22:12 +0000, Jiaxun Yang wrote:
> 
> 
> 在 2021/12/17 18:39, Sander Vanheule 写道:
> > In addition to CPS SMP setups, also try to initialise MT SMP setups with
> > multiple VPEs per CPU core. CMP SMP support is not provided as it is
> > considered deprecated.
> > 
> > Additionally, rework the code by dropping the err variable and make it
> > similar to how other platforms perform this initialisation.
> Hi,
> 
> Thanks for your patch :-)
> 
> However there is a probem that register_vsmp_smp_ops never returns error
> if CONFIG_MIPS_MT_SMP is enabled. But generic kernel is supposed to
> run on systems with & without MT.
> 
> So probably you need:
> 
> diff --git a/arch/mips/include/asm/smp-ops.h 
> b/arch/mips/include/asm/smp-ops.h
> index 65618ff1280c..864aea803984 100644
> --- a/arch/mips/include/asm/smp-ops.h
> +++ b/arch/mips/include/asm/smp-ops.h
> @@ -101,6 +101,9 @@ static inline int register_vsmp_smp_ops(void)
>   #ifdef CONFIG_MIPS_MT_SMP
>          extern const struct plat_smp_ops vsmp_smp_ops;
> 
> +       if (!cpu_has_mipsmt)
> +               return -ENODEV;
> +
>          register_smp_ops(&vsmp_smp_ops);
> 
>          return 0;


Thanks for the feedback, I was wondering if we had missed something :)
I'll send a v2 (series) including this addition.

Best,
Sander

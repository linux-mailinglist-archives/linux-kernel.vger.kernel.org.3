Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E94546A56
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349563AbiFJQZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFJQZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:25:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EA514D09;
        Fri, 10 Jun 2022 09:25:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c21so4096498wrb.1;
        Fri, 10 Jun 2022 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-transfer-encoding;
        bh=dBmcJX6AVJBgWMnSCEKpdH0azr72CDJP/wCuFP078m4=;
        b=q0HzbCYxavYbLOJrDFXLPblIQASTiA6vk09CohznR2AqgtlPSBJtuiuhVFJ1k6ZYhZ
         fRv5k8d+cZ7veA6BDcBoZ0XjX0ExVQKqg+yInAmBtVDPNftbfe9/CmgJluOvTVcjA4Cw
         PhQQkm0tnNsC7bsVkfiU5FuyEcMmrII1Zkjq0Wj28sD1qpVGltUX6/V9YVB5r6UugRKb
         Ql8Iq+wbwbnJsZXqwdF0VYF+Wg3CKBZT5xKcDBh8Jy1qkdO9jbRypT72iXChBqv43Nyo
         Iy2/46x3m6dg6ESXgmYLjFxfOg/dHTs3w1pLkx+gbLnJ1i8wno50KQKSfqu86m6tleaO
         MSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dBmcJX6AVJBgWMnSCEKpdH0azr72CDJP/wCuFP078m4=;
        b=XIdBkB0m/AA4BD2pTsfLev4cW8cA44uNVH/88JpaFfCGOHp9t18x92GdbbjMCxffpX
         +jzIREzXX+bNtvrOJcq0V6V4Pcpl1RrYfNXZs8qOAXEe95+JJLh/2IicvbqbknEQzhye
         +MgcmNkeeMy876sZXmJ8EXgOW1N2BPpE94/X28y3HUanf278XmKsDyrB6KFWLDV2+0eu
         YIgdTFfyXxmnSIdKVoeDyDCRQ+DKVm3iCzf70Ik+6tgy1AQJKgALJvb9H9tTCqfASNaE
         JnAMB+tQTj003xdOVeFM6mmp88FR5A4Fjzd6eX+BnxDA4t6wgPlC+IQXcC1uPUHGD0gg
         Km2w==
X-Gm-Message-State: AOAM532ewELpIbxgK/jEFQU6rWOopQSjHgiHLrD++jlRKegihC+vtHEN
        KSdKqRAVaSutfT0jHWm32pQ=
X-Google-Smtp-Source: ABdhPJzmA9wCzKg919qp5d7nNkbaVNBXWMftLW+cv8QpAEKPvAUuc35HgOE5QliHDSqQlaap7kE6OQ==
X-Received: by 2002:adf:f14b:0:b0:213:b98e:c0df with SMTP id y11-20020adff14b000000b00213b98ec0dfmr40649791wro.79.1654878315953;
        Fri, 10 Jun 2022 09:25:15 -0700 (PDT)
Received: from localhost (92.40.202.147.threembb.co.uk. [92.40.202.147])
        by smtp.gmail.com with ESMTPSA id 131-20020a1c0289000000b0039c5fb1f592sm1261566wmc.14.2022.06.10.09.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 09:25:15 -0700 (PDT)
References: <20220603134705.11156-1-aidanmacdonald.0x0@gmail.com>
 <20220609224200.D1E8BC34114@smtp.kernel.org>
 <qONO5Rg11q4yBfTVshsrN1odktNWOtHV@localhost>
 <TDQ9DR.SDDTZMEA0H7F3@crapouillou.net>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Stephen Boyd <sboyd@kernel.org>, mturquette@baylibre.com,
        linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: ingenic-tcu: Properly enable registers before
 accessing timers
Date:   Fri, 10 Jun 2022 17:24:38 +0100
In-reply-to: <TDQ9DR.SDDTZMEA0H7F3@crapouillou.net>
Message-ID: <SRc6K3M4AqicGZJ2iAONg1d6NAikTPNJ@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Cercueil <paul@crapouillou.net> writes:

> Le ven., juin 10 2022 at 16:43:27 +0100, Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> a =C3=A9crit :
>> Stephen Boyd <sboyd@kernel.org> writes:
>>=20
>>>  Quoting Aidan MacDonald (2022-06-03 06:47:05)
>>>>  Access to registers is guarded by ingenic_tcu_{enable,disable}_regs()
>>>>  so the stop bit can be cleared before accessing a timer channel, but
>>>>  those functions did not clear the stop bit on SoCs with a global TCU
>>>>  clock gate.
>>>>  Testing on the X1000 has revealed that the stop bits must be cleared
>>>>  _and_ the global TCU clock must be ungated to access timer registers.
>>>>  Programming manuals for the X1000, JZ4740, and JZ4725B specify this
>>>>  behavior. If the stop bit isn't cleared, then writes to registers do
>>>>  not take effect, which can leave clocks with no defined parent when
>>>>  registered and leave clock tree state out of sync with the hardware,
>>>>  triggering bugs in downstream drivers relying on TCU clocks.
>>>>  Fixing this is easy: have ingenic_tcu_{enable,disable}_regs() always
>>>>  clear the stop bit, regardless of the presence of a global TCU gate.
>>>>  Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
>>>>  ---
>>>  Any Fixes: tag?
>> Probably 4f89e4b8f121 ("clk: ingenic: Add driver for the TCU clocks")
>> but I don't have docs or hardware to confirm the bug affects the jz4770,
>> which is the only other SoC affected by the change.
>> I think what caused my problem was my bootloader stopping all the timer
>> channels. The stop bits are supposed to be zeroed at reset, so I'd guess
>> the jz4770 relied on that and only worked by accident.
>
> I'll test it on JZ4770 this weekend.
>
>> I'll send a v2 along shortly. Is it worth CC'ing stable as well?
>
> If the bug is in jz-5.18 or earlier, yes.
>
> Cheers,
> -Paul

Thanks. Guess I'll wait for your test results, though I don't expect any
problems.

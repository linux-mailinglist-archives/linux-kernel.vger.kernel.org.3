Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F2A527106
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 14:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiENMTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 08:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiENMS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 08:18:58 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6CD2E6AE;
        Sat, 14 May 2022 05:18:56 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id v14so7941123qtc.3;
        Sat, 14 May 2022 05:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtoP2XbqVMyoMGXah/2mkYSD35yqmPo/cBhku3xFzP8=;
        b=dDoUCxoVB91HP8rjM3y9vKkAVXI71Hzusm4JT3B8XVhJHC8Y5qvqqFIuKaC9zJZwK4
         J5E6MFM1rBnDnto+aFEoglwUVg70Etgdf07cTwl+01BYXi6+pOL0R+NcxnpdBU2BgU/3
         +h0thQe7+EEr/tcPm88Z8X4jQ7nTtYf7PRGDe8QXL6mNal+v19Fg9PHpLWeT7dYBRjqh
         hRoIV5BboMQXtqHluR+Iq5GSI1HQDXEK++Jjyd+N4TOUJLB0PxE0Jx74fONgeKHsklX4
         XVCY7ygtU4V0tsS91dsbSQWEtnNm6gwu0xtukDyDth7gLBuQKyLlbGCi5ugfBIveq2qY
         VWWA==
X-Gm-Message-State: AOAM530r7wRRy7DlLsWfNlcCsiLMUzZXsnZ94d3KseJ/h8ohyVC7xPCZ
        E8gq1ZImkxeh2Tr6xhhmh18Iaqrrm5Y/3g==
X-Google-Smtp-Source: ABdhPJyeZdGcJmVSNkAb91nuRYEwXfcci56J/ko9f7+OUaksIFENv580G7vBccCaMq9j6Wth7xtZOQ==
X-Received: by 2002:ac8:5e47:0:b0:2f3:cb77:9046 with SMTP id i7-20020ac85e47000000b002f3cb779046mr8122594qtx.221.1652530735638;
        Sat, 14 May 2022 05:18:55 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id u26-20020ac8751a000000b002f39b99f6absm2844694qtq.69.2022.05.14.05.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 05:18:55 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2f16645872fso113543387b3.4;
        Sat, 14 May 2022 05:18:55 -0700 (PDT)
X-Received: by 2002:a81:7383:0:b0:2fe:c9e4:cac with SMTP id
 o125-20020a817383000000b002fec9e40cacmr3999688ywc.383.1652530734763; Sat, 14
 May 2022 05:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220503172926.08215c77@canb.auug.org.au> <3f94c9a8-c927-5cc0-7d67-4b21c3d9dbaf@microchip.com>
 <9a424be9-380f-f99c-4126-25a00eba0271@microchip.com> <20220509141122.GA14555@lst.de>
 <dd946220-eaf6-773a-06b4-307cda466c9c@microchip.com> <505d41d1-1bc8-c8bc-5ebb-8a2b7934f3de@microchip.com>
 <20220511062232.GA32524@lst.de> <102578f2-5c10-e9c2-c1ef-e76ba90d011e@microchip.com>
 <20220511064832.GA761@lst.de> <2c0e2fbe-4e45-4acc-c2a7-4f4dcf9161a3@microchip.com>
In-Reply-To: <2c0e2fbe-4e45-4acc-c2a7-4f4dcf9161a3@microchip.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 14 May 2022 14:18:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVJuErxg16jFQEJhMwTgAt2AcHOGck1REZY6j0OpWwH+w@mail.gmail.com>
Message-ID: <CAMuHMdVJuErxg16jFQEJhMwTgAt2AcHOGck1REZY6j0OpWwH+w@mail.gmail.com>
Subject: Re: linux-next: Tree for May 3
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Wed, May 11, 2022 at 12:13 PM <Conor.Dooley@microchip.com> wrote:
> [    0.000000] Kernel command line: earlycon=sbi debug

That should work without the "=sbi" part.

I've used "earlycon" and "earlycon keep_bootcon" successfully on
icicle before.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

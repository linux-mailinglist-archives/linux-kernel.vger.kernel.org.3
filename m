Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC5507C83
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357869AbiDSWbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiDSWbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:31:09 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA42A2018A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:28:24 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ef4a241cc5so260537b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQ16/wzEbkIxABqBQAKbTQVkqdTIndZcraJCAptXuhY=;
        b=yoXcKfD13iMzlWLmDdTn9x/FgNOG3kw5R6VfR68MomindQ8Hiv7SzULtDp5wMZtZo0
         2p564dccFw0ASuHog1Dbu75M0gub3K7/gFgedB9FsgbL9prB0ku7TgwW/yaEXe53Kd46
         PtMjQJ2lSRlOTIcQbtX63lAdpfJkOYVFqVebXApp53lXa6bmaTKCtcP1SbWNj0x+HZNF
         ihXfq9Ybd3JNnMgsO2kIJ7Iu7ExpXoHDCtksI2FYzGF7gJbGLVKmVpKKBlWdRdml5pHC
         EB6wilJJ0dh6CMGp7Nal0CpwJOfWyC2uL6utOO89/6NncgsHY0H0dT0WXcGTJcmxGqTM
         zV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQ16/wzEbkIxABqBQAKbTQVkqdTIndZcraJCAptXuhY=;
        b=MmtUMUKo4x8824qkP1YVCxw6/uGjTcdozbJzEh7AzNv1FsWv16djzUsA9D9X/G9QtO
         PjAhWZ93gezRqVt9s3juVUaLA1GLMu+UZxBp7u99I40QoMRTlQuAA6W21qPc7KuHOgzx
         do81CjABJ388+zy/lJ5Fws5t1JUwNDxt2Ytp2Pc7CWwhdJRQMxWnt/OVlsR3GE4dikEr
         N3DgOu9MYAzE4p2Ef0OJsaVcS5T9BXMUH6FkIyEzWP4Tx92E4LFTb5gmZYCoCngHbhsE
         wXW1YLA9qNxqOLKwzm0VK3HOht2TrwMIHJAJP+GnSx47mOBlabe5eGYye8eEp/2vtObE
         7vGw==
X-Gm-Message-State: AOAM530lhEgiMLRj4V7JnseBiP/EWI5hUgL+u5KodVf02xLAlvpweFHq
        Ltgq+VFLdr2GT9nMhw9D1ozopRBUSv7//4tT6X8H6Q==
X-Google-Smtp-Source: ABdhPJyWVz7jt1E4X9cx0GUTeF4NIpd361BkoD/MNZwADLszDMApenfwwPgUiKRHjpfFGwkluq+EgZVFHDc3jDKRGZg=
X-Received: by 2002:a81:1d48:0:b0:2f1:8ebf:25f3 with SMTP id
 d69-20020a811d48000000b002f18ebf25f3mr12081778ywd.118.1650407304055; Tue, 19
 Apr 2022 15:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220319204628.1759635-1-michael@walle.cc>
In-Reply-To: <20220319204628.1759635-1-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Apr 2022 00:28:12 +0200
Message-ID: <CACRpkdYDsHiZm+pg6Coe-u8wpkiJbX0Cfrw4ymG0KyhJp4KBvA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] pinctrl: ocelot: convert to YAML format
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 9:46 PM Michael Walle <michael@walle.cc> wrote:

>   dt-bindings: pinctrl: convert ocelot-pinctrl to YAML format

This patch applied to the pinctrl tree, please send the rest
through the SoC tree.

Yours,
Linus Walleij

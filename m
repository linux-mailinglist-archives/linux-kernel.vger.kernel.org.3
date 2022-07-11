Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7012E56D837
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiGKIfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiGKIfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:35:16 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933EF1F2EB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:34:41 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-31caffa4a45so41698007b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QdbaAV5FK76Uc2eirkQA2yHXVOboe6L8Bk5p4Quu1Fc=;
        b=U1zIMqgVXWpxUf+MgxIN2kElsyLm53b1G9tMIQjlu27E0ToE7Dc6bZh/dd4NL18TEo
         oOiOjkCkyA0+hJxX54Q3Yg15DnaPCWwjraCSy5EDkgrpXR4c5Ji8VaHJd9dbusCmIbwC
         ixf/thwjLfiiFeVBLiJNfLlwTGjvfmHku6tw4/Jjy2D1Ku7l4yUGsSA/IwfcELTRhxqo
         lwCqwtAtsiiLOOS31p69ViXQwR1ElWQIVyKWRxgrsElQcHvRdRaT5rAJuTA+SJt9lncR
         WJbQKC7kZ4FkPZUFwHrdrML63FxfqlIE/gqiFFgcbt7PJP5JYUpaUyRi1ee3z8tcGbTg
         T3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QdbaAV5FK76Uc2eirkQA2yHXVOboe6L8Bk5p4Quu1Fc=;
        b=N1hCO0AOW4i3SyivbtBL7cfr1SHp6RI7c9uVYMraO7IVUfaw9nzbZjwPlYEQzsS1sd
         4rPpBU8xoVQaKjNJgalr1dsIcLwLXhpOQmDUxzFNjKXrN8AU1L2HHmlssA2NpQaBYJGb
         KwsgSqGodM/C76oEEFsNOvUrIK3CrFzjCv9BrWjiCuhWAA/hSTAWrIa/SBPaddVFKwBi
         a8xGhR3BKi9l1X88coro0FAKtUgh5Gmwd1HDaP4xTMh6DfAQPkDWgfHjbUOZFUHk4zsN
         3mxhjyzF53qUIj5/8bmQlnDQqTvDnQkkuyu5QMc14h0YJBs2gS7O30dQEcovNdQahtZM
         4pkw==
X-Gm-Message-State: AJIora8/YfPhA3+Wp+XsYg2Po+bR6P2Pycx2DwHg2RNL7whJShmx5gAX
        pr3eACrnrdp9RhKwCUwFb3qQQ13n8E3V1VVQ2zylQg==
X-Google-Smtp-Source: AGRyM1v2gWdKpSi1APBbZfuBwCnT5kbKZ3VCWH6h/oSBTVy+KlcaafOxwYR6NVtPsb8r6FrPyS9sUg76wAF1b27C3xY=
X-Received: by 2002:a0d:f801:0:b0:31d:851:96b8 with SMTP id
 i1-20020a0df801000000b0031d085196b8mr18316942ywf.448.1657528480835; Mon, 11
 Jul 2022 01:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656583541.git.hakan.jansson@infineon.com> <c0ac87d9f7072de6ad8ea7c9d306eacfbb4ef2c9.1656583541.git.hakan.jansson@infineon.com>
In-Reply-To: <c0ac87d9f7072de6ad8ea7c9d306eacfbb4ef2c9.1656583541.git.hakan.jansson@infineon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 10:34:29 +0200
Message-ID: <CACRpkdbOWdNyywooNdr-O-fpksVAwaxOn4Qr9c+oZp0Z8DqCwA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] Bluetooth: hci_bcm: Increase host baudrate for
 CYW55572 in autobaud mode
To:     Hakan Jansson <hakan.jansson@infineon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
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

On Thu, Jun 30, 2022 at 2:55 PM Hakan Jansson
<hakan.jansson@infineon.com> wrote:

> Add device specific data for max baudrate in autobaud mode. This allows the
> host to use a baudrate higher than "init speed" when loading FW in autobaud
> mode.
>
> The device specific max baudrate in autobaud mode for CYW55572 is set to
> 921600 bps. Devices without device specific max baudrate in autobaud mode
> will use init speed as before. If no device specific init speed has been
> specified, it will default to the bcm_proto default 115200 bps.
>
> The increased baud rate improves FW load time. The exact load time will
> depend on the specific system and FW being used. As a rough indication,
> the FW load time dropped from ~9s @ 115.2kbps to ~1.7s @ 921.6kbps in one
> test.
>
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

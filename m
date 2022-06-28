Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FA955D8B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345700AbiF1Mcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345716AbiF1Mc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:32:29 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75632ED5C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:32:27 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31780ad7535so115182527b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVfbgOitG18bb87yWBkH35J4JenCkCxRi/ygXGcpbt4=;
        b=tGDyMj1XdbwFx5ENUdMBx7m0pmv1IRVf63OHKrsDLJaeKTSSU2j33ObLxTEK/a1s7Y
         jrOPoEx2nYoNwN/ceD5w9u66ehVEcvbB7E3vPaR+lDZvoKpzNs1eTK0ER7hkvQe6m/VL
         vc+wfNUJ6WJ7Sye6jdDw4Ow3y/KAqjzKYuY6qwnQ9WhqpoeIWOqI32MWXDG6n7fy9Cpk
         6D931yS1B2I3am70V095kXKMLaW15fL1j0Hmj65paVEps+dGjAg7uti5JJ/xTsZ3ffcU
         /T1xlJJOoIPNCE4UuUNFGc1XtroA22QdqISWZXog6bvdHHDaXe0g6WdCDKQnW7q4V5ah
         E3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVfbgOitG18bb87yWBkH35J4JenCkCxRi/ygXGcpbt4=;
        b=A1h/DWPDwfenFTm0eAGnU5/CnmiN0CI98YK3Lq+vcrtTjv/KlQIR63yMltcOT7e17I
         RctAUVPX6HKpR9uwzF0N2zgDiEA7tPYuEM5qmm8Ik7rt/U+GZfrVkCOJYNkk60ODd/hp
         15Phu+jUFqh2QmQ6R0nJ1BtKrLxULWlv9ReKUkdzDc63FN3Al+6kFs319xbb815JbGE4
         nwa6MNP/CuC43bBV39G/UER/HMIC6538Avtm+GDm40uWBwTMwPONRjJGot914pzxS36u
         FYo1fBWHWAYm2LYa1a6/sflheC4/rmOXb9iQIZif2sZFDxyV+ZKfrMNlSFI+Chzl2fNZ
         pBxw==
X-Gm-Message-State: AJIora/M8N2hMCQp0lX7AtH3myd26PtbNQhTI+PnuzKggd8hJs6M0l6l
        CdomGHFyQvTifv0HYZZ9liEmaP/MyNqi4Paq3i0Pjw==
X-Google-Smtp-Source: AGRyM1tZOg8a8akbWJ6uq2aHl4kzEALWqREo/NhIhOnARsOJw9Xp0MQNW5ZunAPwLkiwJuL6LtQs7iavkhL0jCc/bFc=
X-Received: by 2002:a81:d05:0:b0:317:76a1:9507 with SMTP id
 5-20020a810d05000000b0031776a19507mr21222754ywn.151.1656419547105; Tue, 28
 Jun 2022 05:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655723462.git.hakan.jansson@infineon.com> <0e3c48f0f38b167d83feb102284eaf24caa8c500.1655723462.git.hakan.jansson@infineon.com>
In-Reply-To: <0e3c48f0f38b167d83feb102284eaf24caa8c500.1655723462.git.hakan.jansson@infineon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 14:32:15 +0200
Message-ID: <CACRpkdZu9RrmWN+AZi_wy-UsJtdsfBHW+27Nj+n7YRSRXpoSEQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: hci_bcm: Prevent early baudrate setting in
 autobaud mode
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 2:02 PM Hakan Jansson
<hakan.jansson@infineon.com> wrote:

> Always prevent trying to set device baudrate before calling setup() when
> using autobaud mode.
>
> This was previously happening for devices which had device specific data
> with member no_early_set_baudrate set to 0.
>
> Signed-off-by: Hakan Jansson <hakan.jansson@infineon.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

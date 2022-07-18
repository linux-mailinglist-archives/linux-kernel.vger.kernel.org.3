Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A591B577E88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiGRJVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbiGRJUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:20:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1088918E1A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:20:49 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w12so14357221edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ekBvsCl8tLKRAhRxJqGXywTj2TNw0INMK1oBW7njZa8=;
        b=lUrC2exnFGAMhW9f1cEy3vN207RjeJWPpUMpCBlmirV9EVbL/aNuqLBe/50KhjVkJ2
         hci7HW+DoU6ROue1ds2Cw8EMPXd1OBACzPk9FHyAnk9Jwj1sJ5D/b5UcwaW8R7dl7bDz
         F2Umx9nNeoiMxxjr+/38cAf80XT/CQq8QwNdiJ7FpWCZWsTQ/cjk0p/0Bj1rHT2c1hEr
         N1gko1IQ39qLTWzkYTwnYJWyqcDTeuHm//NB665cMKDA/XpQcv1JZwO77gA4v86zow7F
         A2q9kak+EdVfAcSpam69LoeGeUr9gcuWSK9V+f102ohM89YS2klSmp6eOQykdZwzMY9X
         IFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ekBvsCl8tLKRAhRxJqGXywTj2TNw0INMK1oBW7njZa8=;
        b=vSbkWLFo/R3mMXHRkUMAE4CD2JEUQN6TMrgL4FbSDnMXLSCsT1ZyDr+qxbYcn8KMMR
         z4G+QXPt5j1m7MJU5uCQ/cSd2fh6MCvP4JY10bgTNp7ltihiDloPaTLLfZSSx4fxAQLt
         k2qbXzd18qX3FR4nVRb1umFxWYitXFbluFd0LB3hn6CsPPk1ULzKVhkebf9lklBQWRTf
         EmUqMH45D9UN/O5XnTX7Gmu0sTBnxqZOhxvjU99NUsKQgOhya685naKwPk5o5Cqw5V2J
         O+JPjimuhFbFcKm/th66DB8TVFZgCntaHF6W/CYiFfCC1rUuMcG1aCnAAA/W+711XAdN
         BZcQ==
X-Gm-Message-State: AJIora/LsFhWOZNIFWGI1PEAIrZgPXBG5ksgIk07jgJouaaD/L8EXHdt
        e6M2+G/Dawx+VMMBM9r4AH1/wAi4qAre0CGpRNzrVQ==
X-Google-Smtp-Source: AGRyM1sKDeO3oY5retnedorjemb+XBD4ir+Vd2E8sIvSAqj2LxUEW9bOClUAgOnVKsx44I+9jjPR1B3irrU2VJnyqoU=
X-Received: by 2002:a05:6402:3307:b0:43a:826c:d8b4 with SMTP id
 e7-20020a056402330700b0043a826cd8b4mr36456660eda.32.1658136048498; Mon, 18
 Jul 2022 02:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220712163345.445811-1-francesco.dolcini@toradex.com> <20220712163345.445811-3-francesco.dolcini@toradex.com>
In-Reply-To: <20220712163345.445811-3-francesco.dolcini@toradex.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:20:37 +0200
Message-ID: <CACRpkdbSVOR6RA5Ji4qQm2OvMPjHHbe=hM5a6cv9M4tb21LALA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mfd: stmpe: Probe sub-function by compatible
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 6:36 PM Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:

> Use sub-function of_compatible during probe, instead of using the node
> name. The code should not rely on the node names during probe, in
> addition to that the previously hard-coded node names are not compliant
> to the latest naming convention (they are not generic and they use
> underscores), and it was broken by mistake already once [1].
>
> [1] commit 56086b5e804f ("ARM: dts: imx6qdl-apalis: Avoid underscore in node name")
>
> Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> v2:
>  - remove define usage for compatible strings
>  - moved rotator removal from probe to a separate patch

v2 LGTM
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

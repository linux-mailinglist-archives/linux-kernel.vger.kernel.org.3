Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C49955C673
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbiF1HS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 03:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiF1HSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 03:18:53 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF387A184
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:18:52 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-3176d94c236so107624247b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 00:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hVPyvtelgjO5N3Tnyn9eDabv9JhwUUxB4F8kEyoIZs4=;
        b=peL08p2YqaFjgbMH7AfZXAoCJwDhJ7e5fwfTfJ64y4tKrwGItXd44fXmQ8+d+Sfn+n
         E0mTrcpg19o9jgGEPx2nCtKvWXUOJexLZnc8y4iDJ9e0SxIw3K3gU9bjFmU9MyKoMZfU
         SW/IGIzEGlboe6boUFi9Zm3kcRJToQesLQFLcDRlWwQmqagYXSJSavsiGdun3XqoQPS3
         w7VTLDbKNnedCfuvIyOY64W98XPXr3iOo7zxEmW3mBY7h3K96v5oVcpfSdASPH09hYP7
         8jhNS6oCPPsdYzhYc1ktiXyXSHQ7dwl0P2QxpxUYfNp0s/T5fNczAR5KXLKQ2DTC6x6l
         gxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hVPyvtelgjO5N3Tnyn9eDabv9JhwUUxB4F8kEyoIZs4=;
        b=DK7432ehjJ70p+SvOUwo8cA2ryMJvTqDvxnjbqxzt45uZ/BxYXWIcdmSwXjcCIGqbG
         fs0e9/WLDcDeJpXI0TLlD58t2mz2Lsxb0pZemZ8eZuWRh3vWflReBG5aPUR+mCtLvjMo
         kC8SngvcCm7UOrmbB2q9JN7q/8Jer+f16UTcYCJVnaLFyRACgNVKGiQWfTei+0Iurucl
         MfusUPCw2RXNtRrDgtb2E+h0i71QuXUYUkTLBzBVsT/sjfov41U7gexqhRe/cg3ljK8H
         CNnzeOyY891o5Oc3cfND0jRX4MWh8iRTT18w2PjNcGLIAgJ8gHe0CCZNI3nlInqMxqUI
         fJvA==
X-Gm-Message-State: AJIora/J95dyub24wvu5t5Wd87o7zVGzREHy6/dfHsJYCrLXS0RRtXFC
        QOCQPOV+PW0XxFuYfz5YDjLP+Jr7ZItBtoA3ebPJRg==
X-Google-Smtp-Source: AGRyM1sXkqP6U4APkUKdRJP6FOyPrwPL9H7o1+gS5xghr/7xu11IFFDTBpumh2pvEc4GqYkdsW9+rd9BI2Yb3fOpcms=
X-Received: by 2002:a0d:d487:0:b0:318:48dd:95b3 with SMTP id
 w129-20020a0dd487000000b0031848dd95b3mr20499441ywd.140.1656400731986; Tue, 28
 Jun 2022 00:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220617103548.490092-1-clement.leger@bootlin.com>
In-Reply-To: <20220617103548.490092-1-clement.leger@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 09:18:39 +0200
Message-ID: <CACRpkdZ0jd9KW35WNmxC6Ux3ZdCE2AJuyhF2sstfhEBp6604hw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: allow building as a module
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 12:36 PM Cl=C3=A9ment L=C3=A9ger
<clement.leger@bootlin.com> wrote:

> Set PINCTRL_OCELOT config option as a tristate and add
> MODULE_DEVICE_TABLE()/MODULE_LICENSE() to export appropriate
> information. Moreover, switch from builtin_platform_driver()
> to module_platform_driver().
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>

Patch applied!
Yours,
Linus Walleij

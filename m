Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718C455AD5D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 01:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiFYXJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 19:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiFYXJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 19:09:05 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAA014082
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:09:05 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31772f8495fso54957497b3.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1MXmkDUiw43Z0PqWiIuKVcX086I1aXIxpAimItsCgY=;
        b=qWk6cykw70SFCMI1O1BJLkjsV2zHzeUjcAQBEcUV4R2KGQbs+yjeFhy2GdZHWI6iOp
         dDseFJGmwis0XO7PUzbwGTBccukj2fwzTM3BMgUOhSi4c/8m6bIjLIbXJ0HjOMPerdsq
         FLOuMMpa3siHqfcF02E6ty3uPtSgtDg+uAjXD+SIEQORJPjX1kpcxFHH9Z4hzlZgzYOG
         9h+XfDLl5YDcNMx5PsbrWufrd2wDsStKZfoRDceYzTvObDIrtV6I+dxq0BoAQVvkD0cY
         +XdZQ0CnUoDKMNQVUgdNMsaalHsJc/F+x/pWHOzP4CqpBWtO7o07rK1woQj+O/mEVwnO
         q68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1MXmkDUiw43Z0PqWiIuKVcX086I1aXIxpAimItsCgY=;
        b=IEUHYhqUb6OakfEQH1ANx+nZUywbLxuvYvIghnW/tKoglK9eG7/FpK6+aRubPH0TpP
         mysE/c6xm+R8YQKBgRb4mNXDXH+XlO+qhf/QO+HIpgNJv4NCBgFyqpg3XrKpOstd3VCw
         m1ScR6HVsRrpK6ZD6UDkiFSZEbmrBmW7vjIT2oh1sihs8DM0X0zRSdHft/4uyTiTz4X3
         90WsrHPTUbew+6NR3aQGwkAeRqvJ+Wf1+sQQK8UUJRmZJ+CBogb14PaVZ0Qc5mZQ/N3s
         aV53HhSfghy2B03D+xDWKZwCUm9S0cSYOIfbXxAZbe2NuyWzhDZAV/WszXfztMU+kyu+
         LEAw==
X-Gm-Message-State: AJIora/78n2Pzb4UnHjy8Dq4Utt8Z7h544+h4VltuJG2P1fEw9f9phKH
        BSYg1rTMbSFFxrA3VYwPBolzZQUsCrBKCsWspz7OgQ==
X-Google-Smtp-Source: AGRyM1vNlNLKL1bICHSuct3T11AvYCz+HnuVKjSdzzMyBs6oIijdhnwpbjJqdXi5QptR/DL/iDDg26IyU761Rnutypk=
X-Received: by 2002:a0d:cc54:0:b0:317:752c:bcf3 with SMTP id
 o81-20020a0dcc54000000b00317752cbcf3mr6763435ywd.437.1656198544324; Sat, 25
 Jun 2022 16:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220615104921.1390138-1-patrick.rudolph@9elements.com> <20220615104921.1390138-3-patrick.rudolph@9elements.com>
In-Reply-To: <20220615104921.1390138-3-patrick.rudolph@9elements.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Jun 2022 01:08:53 +0200
Message-ID: <CACRpkdakd1T9FFfjbSpLnCmOQM-HVLy+UTJBKkpphyDVmZt6yg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: Add Cypress cy8c95x0 support
To:     Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
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

On Wed, Jun 15, 2022 at 12:50 PM Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:

> Add support for cypress I2C GPIO expanders cy8c9520, cy8c9540 and
> cy8c9560. The GPIO expanders feature a PWM mode, thus add it as
> pinctrl driver.
>
> The chip features multiple drive modes for each pin when configured
> as output and multiple bias settings when configured as input.
>
> Tested all three components and verified that all functionality
> is fully working.
>
> Datasheet: https://www.cypress.com/file/37971/download
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Looks good to me, I see there are still some comments on the bindings,
once that is fixed this is good to go.

Yours,
Linus Walleij

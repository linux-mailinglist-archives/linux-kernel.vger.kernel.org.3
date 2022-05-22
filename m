Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD75305EC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351208AbiEVUqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349856AbiEVUqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:46:31 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14461186DD
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:46:30 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ff7b90e635so63481267b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cyojD6n8i4EzxUISCBdDfpa/iegMOVhEame9/6yeCc4=;
        b=c2yRe1R2iCspNJMu8fSP4l5Jz+ZxiGtVqnFGzGb6idOS9rlHADsVkGWkvrcNIKP7wr
         9RYLPJhGxNw0BsEU+9Wz5eKzTEyMb5uTxPJyonyl9iJqYMHSetvzKT3PtPGCzsOKagUr
         D8e1kIXHGqszuUGa+Rd5ZBVOh5hdO6E0PCXOO38lwFfTwyBV31vCGgYCkMKBUQ3mR0Bp
         V0ASBqLpSL0AHqb1bKhnY9Zb7FJA4IzKCB7JV1chFeAxbXG0m6lLEn2Ps98AHyZBBOBQ
         5JsjhuMptdrFiFA2knd2GsFTdS41sq+dFroJ11UQeoOmHAub+dZvqEO5o0UUGWjCfUTV
         9WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cyojD6n8i4EzxUISCBdDfpa/iegMOVhEame9/6yeCc4=;
        b=JWjagXJZsIUkGbaTVikMobysjPs/TjUrAHEdceEuLdKdELTie0zfFLTLcIWrtvjNos
         OWt55XKd8cb9fyIL2zJh7WzkrlrPyf9+bF8OZe7wYlIo1JoZ/xOzf/vLipIZWI6SpXdH
         uGWV1ymMYKsWa/TfvExX0dwRjjthOTB0CmWQq7Y0rXs4SW3dBDZl1d8afdi0FZUX1uyH
         aXrBdPBXWWItyR2oCDqXmQhemiDyFi1s2gQ577NVuKKcCLpGyEhAhLSCc9jqUJHpplVf
         mjYmv0yXus4pT3Sv9WeNLw9/N4F9Kd7eDJPrHtWF0Jcb9vXmhN4o3U/PyUbeobZqGeCy
         HAAw==
X-Gm-Message-State: AOAM531ZKyKePIfxofC3+KBGICybYZy2WtC3jxRCZnCUqjXY1L5z0iZZ
        t4FdOSYntsP/ejqBoRjHs944IdYL9a3SL3RHJ7HCUlj8k7I=
X-Google-Smtp-Source: ABdhPJwyLkMRtzNRYSmeJ4yT/Fvvn7Nuu3SKjR6DAAZVsJ52glL6OQXAXga09V/gacjOX41kQVFMpLLZcQCzycx7zIk=
X-Received: by 2002:a81:99d8:0:b0:2ff:f419:59aa with SMTP id
 q207-20020a8199d8000000b002fff41959aamr2086655ywg.437.1653252389296; Sun, 22
 May 2022 13:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220520052021.25631-1-zhaoxiao@uniontech.com>
In-Reply-To: <20220520052021.25631-1-zhaoxiao@uniontech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 22 May 2022 22:46:18 +0200
Message-ID: <CACRpkdbTq2HD_8c11bngEQOA6ZFyVY0g=JGqbCjG1zYVrF_xtQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: berlin: bg4ct: Use devm_platform_*ioremap_resource()
 APIs
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, May 20, 2022 at 7:20 AM zhaoxiao <zhaoxiao@uniontech.com> wrote:

> Use devm_platform_get_and_ioremap_resource() and
> devm_platform_ioremap_resource() APIs instead of their
> open coded analogues.
>
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>

Patch applied!

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897DB568F43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbiGFQen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGFQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:34:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E44913CE0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:34:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id f23so3782469ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsmyrhFdA3oRLX5GTtCbo3h/deELHX26ErxA9V5MPxQ=;
        b=TJU8Xl+X3pgKEXzhElDychDhdR1mtS857lUCIMiUJ7UVPUTAfbH22wLlDzFeHUCmUZ
         SqN45egvCiUJRyanpNpkDwnX6D12usmPyEDiHZ5zjR+NEqqnEYKK3EDJ2SqFll0lMv2X
         SDM8GjPbBjmAa49M3+dDATcxnuVZql2wKbTvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsmyrhFdA3oRLX5GTtCbo3h/deELHX26ErxA9V5MPxQ=;
        b=mwhUOXxq9+678QGBuzjpNTtVpHXPNbyRasAmVvOYcHe8gvI/M/M7TRFjEpAb+hcMdu
         sUdJeGp+DfUWpyltKTsvM6sspxHVVaFL4LZF8lI0yk4ova0nRtAWzsvzQMrAbY8lwwk1
         iHtaISiQgN9ExicPbrYftQhzNwusGeyW8wIe3E8ADxn7ujqKqN36zrqeLttDaQ8KeKr5
         yZVGZydzsRfIquYv/MMrN0/ZXCdI6l7wBR+NZ3JHCgqilYA1jltD+DeOWkdT68OZ5M3n
         2N1ufYq5tzH9VNE0FMETjydc6gFapytsO1aCSuE22HBk1Yum5ZXBgNqZhMi5Dv8gF6WF
         HtSw==
X-Gm-Message-State: AJIora9gWnaK71oGE9nV5xnW+o+k7lJNzJCIYjnTi5THJ+FkVBfyYgEj
        sKgJksdsHCyC/Z7Or0olt9j9BSVtYERPu3YC
X-Google-Smtp-Source: AGRyM1vItI5vmAm3hF+FcD8eWKTZ84J5NNkOM5uV+Q2yocllmhOgO0VDclmuTnE/PwAxAF9CFpUiWw==
X-Received: by 2002:a17:907:7247:b0:72a:fb6d:fb10 with SMTP id ds7-20020a170907724700b0072afb6dfb10mr3405216ejc.525.1657125276720;
        Wed, 06 Jul 2022 09:34:36 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id u6-20020a170906780600b006fef557bb7asm17570513ejm.80.2022.07.06.09.34.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 09:34:36 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id c131-20020a1c3589000000b003a19b2bce36so6340911wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 09:34:35 -0700 (PDT)
X-Received: by 2002:a05:600c:2049:b0:3a0:536b:c01b with SMTP id
 p9-20020a05600c204900b003a0536bc01bmr44065555wmg.151.1657125275340; Wed, 06
 Jul 2022 09:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656759988.git.mchehab@kernel.org> <0ae8251f97c642cfd618f2e32eb1e66339e5dfde.1656759989.git.mchehab@kernel.org>
In-Reply-To: <0ae8251f97c642cfd618f2e32eb1e66339e5dfde.1656759989.git.mchehab@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Jul 2022 09:34:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7gzG4xSsR3HxOv96ytzyNvT5a1oQnmy4F0BqpCOChOw@mail.gmail.com>
Message-ID: <CAD=FV=W7gzG4xSsR3HxOv96ytzyNvT5a1oQnmy4F0BqpCOChOw@mail.gmail.com>
Subject: Re: [PATCH 11/12] docs: arm: index.rst: add google/chromebook-boot-flow
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 2, 2022 at 4:07 AM Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
>
> This document was added without placing it at arm book.
>
> Fixes: 59228d3b9060 ("dt-bindings: Document how Chromebooks with depthcharge boot")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/12] at: https://lore.kernel.org/all/cover.1656759988.git.mchehab@kernel.org/
>
>  Documentation/arm/index.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
> index 2bda5461a80b..495ada7915e1 100644
> --- a/Documentation/arm/index.rst
> +++ b/Documentation/arm/index.rst
> @@ -31,6 +31,8 @@ SoC-specific documents
>  .. toctree::
>     :maxdepth: 1
>
> +   google/chromebook-boot-flow
> +

Sure, seems reasonable. It's not truly SoC-specific but I guess
there's no better place for it.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

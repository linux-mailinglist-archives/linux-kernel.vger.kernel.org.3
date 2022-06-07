Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD7854251D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390357AbiFHBuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450379AbiFGXLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:11:13 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DB0392134;
        Tue,  7 Jun 2022 13:49:17 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x18so10682587qtj.3;
        Tue, 07 Jun 2022 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6OzJWnX7XOWLy09SsgShl0+AdUcp50QiZ/tYbextP4Q=;
        b=i1FQpB4zMZY2BupvN4XD17bMMlxM4SkxRXOTS8rctLXeu4FHOSmZP53iCYomN0KUS8
         n3HSSYbo6X6Sk1uiVfJqf6HQXbKSSAqi1t79N1EDcHuurJzYMxigwswntQKPaxx0EK6z
         8yCc9JpDoSsKmC7fc/LSwquIInUEH3pH3EuKrJEYqWCkxMUAQa00osLr2ExZSaBqXbOd
         lDlXitfjh7J3oYfX1JhgIaVGjErCHPIqW0XKAJR+phtWmHz6FMpHaJ+MYBF0tHmOpHEH
         BJTN45YtUJvPFSvXl0N/rGCzJsRJnTn2Fep/1jogSm24ivyzzWEVzn8soIDXe+1ycML1
         GR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6OzJWnX7XOWLy09SsgShl0+AdUcp50QiZ/tYbextP4Q=;
        b=jzkBTsJp1fgOgqvNmquB8C4pG51i0eHYDxS4RcRYuSmXVo6a0rqcXxQZOG1O15/yMl
         2jPSKs0yqR62qboxYXD0rLA44UltwBbX14kPbX8ZGhoMVjcajNHWi6HjsK6UNrdItF3Q
         0B7vNIegsmX0YbMOpBD0Y9eiW/JEC+fm5G3EyqbVPfRJPPKI0QByhS8J9zYPeA7rUnar
         XKh/GsMyC8AGbXsouZFUk4YXjrl0MsGdy4ojre/8TgbF1LqPWx7XXcP083UlNAEbK8yp
         NVImUHNacHxyn4UfetsfiBnLBcTiyFLpNgNMaDff256apbi8BKOneRcNlO64XnhLAlNS
         2+Jg==
X-Gm-Message-State: AOAM531plcj3kz5nF6hwjQvguisaOuGnKKWurtrF4zO0N8CktxJmpH8l
        42wZHRNQCQmsAl/Gu+XWqpNaLxkfFkKw5boV9sgbc749
X-Google-Smtp-Source: ABdhPJwE6QpALhwFKv2F6OUdVIHHsur41OqT3tW0FzBUtOfl6yfACS1sOYPrMnF2Eq0+1aMyXMWgGuGskF2YCDs9uk8=
X-Received: by 2002:a05:622a:344:b0:304:eb0a:3901 with SMTP id
 r4-20020a05622a034400b00304eb0a3901mr11181434qtw.297.1654634956111; Tue, 07
 Jun 2022 13:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220604193300.125758-1-robimarko@gmail.com> <20220604193300.125758-2-robimarko@gmail.com>
 <Yp+lMm66+imh1wvk@sirena.org.uk>
In-Reply-To: <Yp+lMm66+imh1wvk@sirena.org.uk>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 7 Jun 2022 22:49:05 +0200
Message-ID: <CAOX2RU7DefWU9jr09VOFsN7+9wWw5rbYGmvfyFA4HHHF9A8acQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: qcom_smd: correct MP5496 ranges
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 at 21:21, Mark Brown <broonie@kernel.org> wrote:
>
> On Sat, Jun 04, 2022 at 09:33:00PM +0200, Robert Marko wrote:
> > Currently set MP5496 Buck and LDO ranges dont match its datasheet[1].
> > According to the datasheet:
> > Buck range is 0.6-2.1875V with a 12.5mV step
> > LDO range is 0.8-3.975V with a 25mV step.
>
> Doesn't make much difference here but in general fixes like this should
> come before new features in a series so they can be applied without
> dependency issues.

Will do it next time, thanks for the heads up.

Regards,
Robert

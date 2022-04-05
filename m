Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627844F4910
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389993AbiDEWC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573490AbiDETL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:11:58 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4005E885A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:09:59 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e2442907a1so40467fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=sPMX429tI6hHm9JGLP4wtiS6WntCuwJ+oSIEAlhqQq4=;
        b=HCOU4BHcfRd3p8bxiwuoftAjfLn3RfhjTUIBIg9b7YM/jJMdwkTSrJ84CkHkpB0v1s
         uE0tKJ2IxoARUznnTrCPNS6G4Iie2aoFAv6s45x+yIC3tD6iE2p1vtqlk2PPQiZVzAJi
         ANFvSL+vd5g/wFrh40eK3FIuUvVdZ5e0iNHLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=sPMX429tI6hHm9JGLP4wtiS6WntCuwJ+oSIEAlhqQq4=;
        b=4NdTDUvDNlBGkynrOe5Qq+PYXG9MFSMEc8oaiBXb8Xm0o/0iguYIfOm8GdZhnKfeB6
         T0Vc+S9rVUtEfafZ9iFTxZziVVErS927sA8UoH6vV63FI77T07V5iyPYjftXeya1fcOm
         tJ55iRQggJvuvkwzfLGgAcKWo6BJCnviq0GbwUYCVSCpEgK04wY8JRcB1DpNc+LwjX93
         hamju0y+F3PNyUFSyM59VEBa+adR4+GORCqIwivE49i+fJ+ngv1PXkZcEuMT0AqvCJQG
         uACnkKGhmwoWwZORq1iw61qMxp4yHkqRX/yCoJLW1HyWpbWjZ6sEowxTW//hdT4htAOt
         Ve8Q==
X-Gm-Message-State: AOAM5315psYQtjfb75CUaZOhScOCHoxQYEFGLI+SyyFqh7VxLftciVX/
        BxSuLChJgFGrdPG89jnSwlVlRdQhOILYBhC0LLPHng==
X-Google-Smtp-Source: ABdhPJxWEM7cBY41biQ2dGgAM1IQu7FyI39398w6FDLRT0cr5Eg7iPiQ04BRqK9rPG53e/kqf3JThjvF++uVHzzoPcI=
X-Received: by 2002:a05:6870:558e:b0:e1:db7c:26aa with SMTP id
 n14-20020a056870558e00b000e1db7c26aamr2272235oao.63.1649185799403; Tue, 05
 Apr 2022 12:09:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Apr 2022 14:09:59 -0500
MIME-Version: 1.0
In-Reply-To: <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com> <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 5 Apr 2022 14:09:59 -0500
Message-ID: <CAE-0n53tXnOw_hRD-O9juAbJ1FDcEOx1rHqGijZs8fuanqMNfg@mail.gmail.com>
Subject: Re: [PATCH V9 4/6] regulator: Add a regulator driver for the PM8008 PMIC
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-04-05 06:50:31)
> +
> +static struct platform_driver pm8008_regulator_driver = {
> +       .driver = {
> +               .name           = "qcom,pm8008-regulators",

Also, the name should be something like pm8008_regulators

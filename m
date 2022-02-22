Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079D14C0384
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbiBVVIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiBVVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:08:16 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095A4D2071
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:07:51 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id u17-20020a056830231100b005ad13358af9so10516418ote.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=yTWyYubMR//Jgsba7P9C6e+8BGed7UAn8IRrcIATL28=;
        b=EM/gc7DZswlv9F7GcnoSAd+qWrEWCPCbdyvy1Py5xUaiPWiOKdwoetuoclsEBcoOLE
         i03D1Td1H5ewCy/8qce7cWHqo5h6HT2N4cJgr/39jzBveFcGQTJjP6grkpTWdlIwu83u
         zzQQKVyA4t31l4fZoOGzkbxEUJhNBlJKTM0Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=yTWyYubMR//Jgsba7P9C6e+8BGed7UAn8IRrcIATL28=;
        b=jxR//A1bTIRmWXXvytldquKrRklgQ3y5pkwS5QW6lZqLHMstSB9vuMWxUIr/y/EJds
         3U3/O3WcdSqKOcUsiR6yzFcFfCkwgkTKo4fvQ7oXR3fLEkKumXNmjj25O0TgEAoJQPIb
         12WPj7A6qB8ohppUv+Nw6RkmGPjX/M2Bu3JTcqydbf3whar6+p+hjOyC3Zzn7u7sU3ho
         MRZbEKTOi3upMYTZJ2jFu1lsrplvwILbLa00CD7ERa+FASxYFlBAN3KYlGNQLu1CpGL7
         xPQnQJfp/oTLk80fpFoEPwZn4dgSSBgl1E2rqzVwRepw3HVFHfxwlSojtFsMjByu0KCc
         kQbQ==
X-Gm-Message-State: AOAM530xVHSx6jC6fv8CH0pNWvjdod1+pDRV2HRfqSM+aI6Oz0CYlgpI
        HUkP+ZHZi418V+b9lmscJcnYKOf3I/qC7l3uKXJGew==
X-Google-Smtp-Source: ABdhPJxpUMNXg0CVkf4Zqe1XypjicGyou6NwnzAMp7S4QlSBTuMZu+qAWALcLW1hZMEP0IgnlZifMNj5zQNSwhz5f5U=
X-Received: by 2002:a9d:7687:0:b0:59e:da8c:5d32 with SMTP id
 j7-20020a9d7687000000b0059eda8c5d32mr8930738otl.77.1645564070331; Tue, 22 Feb
 2022 13:07:50 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Feb 2022 21:07:49 +0000
MIME-Version: 1.0
In-Reply-To: <20220221073339.10742-1-jose.exposito89@gmail.com>
References: <20220221073339.10742-1-jose.exposito89@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Feb 2022 21:07:49 +0000
Message-ID: <CAE-0n50cW4-xzabNjb0mHLCgUYj+Mcp3_XxYrYf9AVuZO_9qKg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: switch to devm_drm_of_get_bridge
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        robdclark@gmail.com
Cc:     sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        maxime@cerno.tech, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jos=C3=A9 Exp=C3=B3sito (2022-02-20 23:33:39)
> The function "drm_of_find_panel_or_bridge" has been deprecated in
> favor of "devm_drm_of_get_bridge".
>
> Switch to the new function and reduce boilerplate.
>
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> ---

Dmitry is rewriting this code in a larger series. This patch is
superseded by that work.

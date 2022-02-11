Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ABF4B1AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346651AbiBKBEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:04:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346645AbiBKBEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:04:45 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5C82724
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:04:44 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id bt13so20580962ybb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WsTiTpIPXd6aBVRDWWCsW2EfHImVRBu7uRe/2mtmvMo=;
        b=hE/Mrs0OT4PJEvvcSBW//N5IldkDiXP8QA8UXh6EUPg2m7sgepjbdSVH+YRKBY3QFF
         a5/XUpkCzfPY3wLcdHeRPOOWiHRzJX5iLHRp/rhZXAEgVFWb2kCc0jQjK9jkPjth8baS
         +SOfsi88n5gCkWBefJdLXdpRv9Sk8q3cKpl2RU0uBFtwaBTO3w2BZTvEjvrI4u7yw+uM
         8VUBEoTAxYHIlXAbNeBdu+5rzGI6Qu1v3d2T9BKeN1AiCpuOyAoOJJBm7cc8iVHZ8Edm
         hsjw53+KzB5w4jjKF7GFI35WTcf6mL82oIre7eqJ5K6FZXnmghyatq7Kc8zOXWjB4LWB
         +7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WsTiTpIPXd6aBVRDWWCsW2EfHImVRBu7uRe/2mtmvMo=;
        b=bRA3CtkuptqidajvNRizsJlojwA6javLCalNcwvuWTwhxA5UaT9wZO1Vke6WWO2m90
         5NaC7xqJblkyiQkHjeh7zkLqN5eOlyI5CsnAGF1gwj0tRA2NhRDFiwgYk+rgJrL7oLFs
         TNZpZd0rxFALpK2igWq/vZVaXQQG2sttNbGQ8cGSLzMePk6INJXaerCHSfKMOjTdQe3u
         JxibODCeiVIAnIdj/cCLOi3Dbgr9hR7J7qImtIXxAlUcNIJHLHthZ58UcwW3/BCTqwRJ
         v0fSGMMRqZpZnPn7EsVwlUWuOhVmlgKTF35fuzJwlCTu0VmnHfSn+ayz9xwLSnEUWCbM
         BuNg==
X-Gm-Message-State: AOAM532cQVUwXbD47UKgbMTfS3dts6PZvISv24hug0I/MwqHlrVpv0Ni
        2Kx7ueBaudyU85+uCySzzRdmHTLOTW3qreExHY/GEg==
X-Google-Smtp-Source: ABdhPJx8k/neEG8CQ2DJYegDVZpGIz+78Gj9mxX8H5U/x2yDSI9sCRLGpI/0cV62BDxBuVS7AyEpooCPglR+uu9KsbU=
X-Received: by 2002:a81:b343:: with SMTP id r64mr10383367ywh.268.1644541483360;
 Thu, 10 Feb 2022 17:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20220205155332.1308899-1-j.neuschaefer@gmx.net> <20220205155332.1308899-2-j.neuschaefer@gmx.net>
In-Reply-To: <20220205155332.1308899-2-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 02:04:32 +0100
Message-ID: <CACRpkdYJnB1HnEt29p3G_fUEMMHoXMmuKBkUHAGV5sKUpiU3eg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pinctrl: nuvoton: npcm7xx: Use %zu printk format
 for ARRAY_SIZE()
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 5, 2022 at 4:53 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> When compile-testing on 64-bit architectures, GCC complains about the
> mismatch of types between the %d format specifier and value returned by
> ARRAY_LENGTH(). Use %zu, which is correct everywhere.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 3b588e43ee5c7 ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO dri=
ver")
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>
> v3:

Applied this v3 rather than the other version.

Yours,
Linus Walleij

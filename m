Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687F94C53BF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 05:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiBZE4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 23:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiBZE4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 23:56:01 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65CF1AA048
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:55:27 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so9594077oob.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=B1iyIZxykdfFaUxBAPXSJr+OEff3IvbWqJkmpppNQ2A=;
        b=cqQxtTdwgeqkVD8mIAABpM3Lb+uPsK+Ljq/J96oufbg3NqlWmx9uB/n87dKiJqYJcY
         Cnhr/mwuTdRzlORa1RmggOoW0nfVUjgXK7g2uAggAAX7GRcuNxfBUf6X/TZYAg4Bv6s/
         v9kH5cgSrGPg91jM7qG5NS+t0NEPQ6uoXN4KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=B1iyIZxykdfFaUxBAPXSJr+OEff3IvbWqJkmpppNQ2A=;
        b=ESAn4GzOv1aCV6sNysF/T97PM36PJlQOHjs+eeuhO8MThaolIhkKCbwmkjchlYFc47
         5KhWThYoTwsLk2V1crOnnKOgWez3m5UeOT5D7UCpnCMIXadPN2PswTpZ5Pu9CISr/kH3
         dqq9XCSW9ehBny+hfpHsHeNZN1NXmkR3IqJo0bW3jyxgEk/dTqbtGZNgnlJ6NXmFriKy
         6a3aBKUTeo4ImBQw5hnNJMy/31x/r5qDyPscJWukrmzgzYUunAM3fHPIfUSOkJsa2NSJ
         8DUpnIxqzt4ul3GesyAewkVtfEkd7X7lhHtNee404oTlunkjLmpZH2Hsr4DxQ/B0CJBS
         lMqA==
X-Gm-Message-State: AOAM533gp4HW/kHEK5lZrcb4lWCsCCSMK+bn1rkMnWA3hNa0uEhLRvwj
        yKdGQ5ndvrn5fgVcGcLBbaQBzkLN8nx1pnlfa0DyvA==
X-Google-Smtp-Source: ABdhPJxp6sVEjW60aep61/nJM/HwunlNfAbyEPQYp6FXwhxqj+plH0SEeNdCtXwccMojoGcClktp7K5QhnuyShvUY+Q=
X-Received: by 2002:a05:6870:631a:b0:d1:7d97:806 with SMTP id
 s26-20020a056870631a00b000d17d970806mr2928982oao.8.1645851327275; Fri, 25 Feb
 2022 20:55:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Feb 2022 20:55:26 -0800
MIME-Version: 1.0
In-Reply-To: <YhmAAjNeTjiNoLlJ@google.com>
References: <YhmAAjNeTjiNoLlJ@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Feb 2022 20:55:26 -0800
Message-ID: <CAE-0n53tHSswXFKabHEZymn3-sObFU_7n51wRkR0xk9g05SBCw@mail.gmail.com>
Subject: Re: [PATCH] HID: vivaldi: fix sysfs attributes leak
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     "Sean O'Brien" <seobrien@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
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

Quoting Dmitry Torokhov (2022-02-25 17:18:58)
> The driver creates the top row map sysfs attribute in input_configured()
> method; unfortunately we do not have a callback that is executed when HID
> interface is unbound, thus we are leaking these sysfs attributes, for
> example when device is disconnected.
>
> To fix it let's switch to managed version of adding sysfs attributes which
> will ensure that they are destroyed when the driver is unbound.
>
> Fixes: 14c9c014babe ("HID: add vivaldi HID driver")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---

Makes sense

Tested-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>

will you make a similar change for the hid-google-hammer driver?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB649AC47
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244735AbiAYGT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S254372AbiAYFOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:14:05 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4265DC0612FE
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:42:02 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id w7so22170301ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 19:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUk8vRb1/TEpI4p3BEManRMgUagR/L5zFts1s2DKOAU=;
        b=i0BK/0cSd5ql/xvy9Y2DcbaWQl5ucael2ytCi27aBvxFMayD9HBIEsOJLSGcqtlV+w
         QBI1KgX2fbtxohV7KwVaGWzNib17c208bD/Z4FSLc2mwhP6d1ueS20DTqNqQUIaUCJ74
         XOypZqctX3ZZAL6j2Sm2cnpX1HcOUHxiKQOfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUk8vRb1/TEpI4p3BEManRMgUagR/L5zFts1s2DKOAU=;
        b=steqKtAWOfBqoUpSi8xn6mPE+GUELFgqwAGxDKkzvQwA00AHXUpqHECmY0nvNgyDh7
         rE+wGjDVbmkWZziGQa6hKaDYlNS+/q/oKsdpJjSz/3c3smVLG5uKUHHwE0BBhZlB8THu
         /6zLuUskCzC8aGTheFTyLAy8s3NFFFV207/91q5erZTvLlV6frqlZLA/eUZcXfTJByjo
         Wm1B3aX7BkITpzbZ5T1Zshnkn6HGXmBsiQkIkxBGKvSkd39Is076CIeXo6C1vv+SajqJ
         yS5af859feRO7v54ne3TQYaJ63WpGHe6H2WYrhQvqCq6PW5T56NGl2shYiktqXd4j6TF
         hhWA==
X-Gm-Message-State: AOAM531LUbmREs3cximNMLEf+8JLxlDYHezakIWVEcNtgxXSQmwpHwMg
        xJD3NrQGvbCqrWc8M7RfoqN5Imb/T7ZUy8b6diawbA==
X-Google-Smtp-Source: ABdhPJzaBMEOBhwghU89luomCIh9naT22YMmxOhZ04LUV562x/5upFLl+PZPpk/4aTF1+FNa5qr433TsbzRPRd+nYxk=
X-Received: by 2002:a05:6638:3009:: with SMTP id r9mr8180868jak.262.1643082121708;
 Mon, 24 Jan 2022 19:42:01 -0800 (PST)
MIME-Version: 1.0
References: <20220105031242.287751-1-dustin@howett.net> <20220105031242.287751-2-dustin@howett.net>
In-Reply-To: <20220105031242.287751-2-dustin@howett.net>
From:   Tzung-Bi Shih <tzungbi@chromium.org>
Date:   Tue, 25 Jan 2022 11:41:51 +0800
Message-ID: <CALtnz62fQbyK+WEE=8zSQpuDuaVO=A6PTBEdrYJ+nrSuphpi7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/chrome: cros-ec: detect the Framework Laptop
To:     "Dustin L. Howett" <dustin@howett.net>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:35 AM Dustin L. Howett <dustin@howett.net> wrote:
>
> The Framework Laptop identifies itself in DMI with manufacturer
> "Framework" and product "Laptop".
>
> Signed-off-by: Dustin L. Howett <dustin@howett.net>
> ---
>  drivers/platform/chrome/cros_ec_lpc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index d6306d2a096f..458eb59db2ff 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -500,6 +500,14 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "Glimmer"),
>                 },
>         },
> +       /* A small number of non-Chromebook/box machines also use the ChromeOS EC */
> +       {
> +               /* the Framework Laptop */
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Laptop"),
> +               },
> +       },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
> --
> 2.34.1
>
>

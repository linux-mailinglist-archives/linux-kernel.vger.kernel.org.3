Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E0A471D03
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 21:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhLLUpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 15:45:03 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:38868 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbhLLUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 15:45:02 -0500
Received: by mail-ed1-f46.google.com with SMTP id x10so28660372edd.5;
        Sun, 12 Dec 2021 12:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yP2O9civRRxQtY3Lz25ifh6I1U06VEYbkYd4G8hA+6Q=;
        b=EVCFPAzeNtIR4NLQweygrDcmmZDGq3eOACnKcs/hfw0MqusEaudP1EcUZUf6LLvHam
         nS7Kz+OzkwKm42WGeRqXN6qIErYf7F8FF8XKjMUIN1VKuT4zCA2bVfnTpqLzgOTied4F
         +ZLUP8EkuF9LJAPqG4Ry2jnTRbxkqm1lApeK5lMEfiATUZZ5vWm3FSBwVBMoYKohcQf2
         60u1/LzACjJYBLHIXvxtVuPs8iaQQwDm0oIW9xettkTSj6txiFzpJbNYVaeezw775p9/
         blJEae/WAdiqQasK9wGPpD3rpKvW0GnEPOQ36X2lUvg6qvPaGjWDeQjymptnwp/5OIhg
         3QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yP2O9civRRxQtY3Lz25ifh6I1U06VEYbkYd4G8hA+6Q=;
        b=NmS2K5rN5aYrnPSbUjn/tn+ZVOIyqow1liKT+syHlCupd9p1eSVcjTJnZSgwySaL7n
         1oprj1DuFz4DSNxy6inMs4kcsRbWImKk6sN1oxNV4muAC8Y6KWqIhl+ZOjqTGibxQlbv
         cOBPz9KCvCqQReb2ZCz6WYaETizOlMAQwVaKCc7Gl87w3WunJrPAVfI3srdgfnCBGdPC
         0WZY73kmsXBRgydzzBHggvQIQSBwclF4GaABNu//dxOyuv9lEs0n60Jy2DwsH5dGWElI
         hAiHpuDQxFNGykb4Y0s08r863iManoYaqz20G3tzhHcmAHBcIQr3LNFTX/cPuKZvnd5K
         CVIw==
X-Gm-Message-State: AOAM533PhLArMdrkVk69lXJissyZr9/q5sptzlR9GOZg6rQOkG0F+sEh
        4GcTMsSNs6YwlyaZ6RWXNAK8NKD3TYx1FJnRB0o=
X-Google-Smtp-Source: ABdhPJynDnAdk3DFucCVq3HNgD6bpcw0wB668tsm6h4tMO7JBDvph4oMhm+3W7hax5atapV9b9iXrwZ0zPtk0x073VQ=
X-Received: by 2002:a50:f189:: with SMTP id x9mr58742036edl.95.1639341841296;
 Sun, 12 Dec 2021 12:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20211212201844.114949-1-aouledameur@baylibre.com> <20211212201844.114949-3-aouledameur@baylibre.com>
In-Reply-To: <20211212201844.114949-3-aouledameur@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 12 Dec 2021 21:43:50 +0100
Message-ID: <CAFBinCCjrKYOjUsJZ7rPan-0XVNMU0+x0fUS1Wn_bNUXxqBLdQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] phy: amlogic: meson8b-usb2: Use dev_err_probe()
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc:     khilman@baylibre.com, p.zabel@pengutronix.de, balbi@kernel.org,
        jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amjad,

On Sun, Dec 12, 2021 at 9:18 PM Amjad Ouled-Ameur
<aouledameur@baylibre.com> wrote:
>
> Use the existing dev_err_probe() helper instead of open-coding the same
> operation.
>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> Reported-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

For future patches: if you send another version of the patchset then
please keep any Reviewed-by/Acked-by/etc. for patches in the series
which have not changed.

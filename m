Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254A2486BB2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244151AbiAFVNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244039AbiAFVNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:13:33 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F66C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:13:32 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id a18so13333421edj.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Uo3zrvjs6l5Jch3xWP8LMBVP8GHSaGKJV7WhF6qa1w=;
        b=bEcm+18jIgP7S0xmkuW/1Q15uSKoVSBzIXjUF8iFJdQC/7AfjIZTaomrGFrd3XI12w
         a3BKwczI6UNtMWCLe8xw5+hpKmZ1aVeUzUOJ8shZtPWcgDF/eREJLs5OoqDb9MTX7rMv
         BsqNN08ybKlO2ULIQJih+DEsdoiYdx8JrnBkHQh7HFdhiz4ff9yYYCz3dj8KFhBbmoXT
         8buZPkVFvsAicnNCQS5d5Omqy8EE6iPMTdZZw/65u67tG75iNGz5OdJX3SIF+KsH6Vpu
         aBuvbgAhNC3RC2H0EdfjsYnLaX413L8Iq0rHoiMHJUcC5vhO8wIy6sQ3MQDWivvXSjk7
         KXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Uo3zrvjs6l5Jch3xWP8LMBVP8GHSaGKJV7WhF6qa1w=;
        b=eUG5q/L/cNpwfGrBwp1pD/EIZ1YLqRgzxD2vnuBhOpEmx3FjcrOkKBwP8xyAmMxfaf
         zzmdL93N4YLmTJWZ0mdQTYTma4DP/7Y1aCdGgdXnnvTycGV4KXB6NZlR7EW2/FrYfLFe
         0YXnAJ6qOvz2kdM0xwFMQvtCkujYMqfbXt8uwQjGgtiOBKYVBH+pnI/xr1jTx3LMy20C
         Y7ssWdMu/s4FKIEcu8rV2bPSGc4MqoOgDxQMEQDiHjPzBDBHCVJhmJYi28H4QYtUcnJs
         fQgkOGDcRYfXUotb54BGxIOJWtRqcFQcsOgvWQST2arL3yV/yxD93XE22g0KyS1BK2Ya
         bhjw==
X-Gm-Message-State: AOAM530PpAp8qa29u97u4EyyQZpmJsJ3UFI13bkx6+RaiCwuXzIlPX8F
        ZDOWCo5GCH/1KcSD6EuCrvC5RVSNSnJUOQrWy4MIDXNO
X-Google-Smtp-Source: ABdhPJwW0I2gFdo2lb3NgI3Cc2FFm64EQc4xUiosUseOqyYcf/X4k18twKL06XkaAfi/v6V4zRL2uwTdcoI0Gs/HtXg=
X-Received: by 2002:a17:906:5948:: with SMTP id g8mr47408005ejr.4.1641503610850;
 Thu, 06 Jan 2022 13:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20220106175019.3116389-1-festevam@gmail.com> <Ydc2EHf5f12w4YcW@sirena.org.uk>
 <CAOMZO5Czbr=vuvZdqc6+odAQv0M-LJEQVz6uke8OXnoG6wLqwA@mail.gmail.com> <YddLe8cCvj5fVBTQ@sirena.org.uk>
In-Reply-To: <YddLe8cCvj5fVBTQ@sirena.org.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Jan 2022 18:13:19 -0300
Message-ID: <CAOMZO5B63zHEiZc-Z1AR8za6eWXX8y0wbYLmrVkXC85ewFSqbg@mail.gmail.com>
Subject: Re: [PATCH v2] regmap: debugfs: Free debugfs_name buffer after usage
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Jan 6, 2022 at 5:05 PM Mark Brown <broonie@kernel.org> wrote:

> > Where exactly would you like me to call regmap_debugfs_exit()?
>
> Before we try to reinitialise debugfs for the new name seems like the
> obvious place.

I am afraid I am not enough familiar with regmap to fix this problem.

If you could please submit a patch, I will be glad to test it.

Thanks

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2D470E24
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344698AbhLJWqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344675AbhLJWql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:46:41 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029FFC0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 14:43:06 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z5so35036108edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 14:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uNvZHe6DHRkF+xFR2MjDNEoC+neS0KSxMQQUcva/BLo=;
        b=grQgQcg5MH+iX7Jw2TpSklrJNA/RSRHJETmDcYrXbXsk3YGdRDRXXoXauSP5q327/M
         xnSxXPjy36NvjVKp/+pXBFy44pq100Dyqgg4i1t+JBgHycd6Pm2Pscz/QIMcHcnjx4Tg
         1fVwhoeVi7wK76k1Y6Oypx+EYeaQ8bJnJMo3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uNvZHe6DHRkF+xFR2MjDNEoC+neS0KSxMQQUcva/BLo=;
        b=6mhDwgsvW2OSieakjiTOQk25rACxAnnSCk2ClTgP8DrgH+HfxBjVMlx0RjQqu3JVG4
         I2IR9M6xLKGP5+KymNim0kT3GxrOtvmgjUlHJg37/HlO0X+1dk20lALFwnUBNIJhAzOg
         2+C2b455KYDtRhGwIFP14E1xTKSx4iLBfCrbHz3o3zw4g9AWU11AT9YKNMazbZIK2LQw
         0gRRItpjjqskGIVh8FosN5dqdiaDA6yDePc+LjupjxRgBJYCZ28+7kBSjgVz288DA6IX
         Jti26Iv4JIL36Ruhz/hGKCYM8mCBnjysv5eduoQsWN0wZBhnWtXo/i9pMlBJZn9O8GqF
         e11A==
X-Gm-Message-State: AOAM533R2/fS1VYlwVulBrDuM1vsJSSkItW3ph48AzHIZwVbOoT8O9C7
        A2VQCtvoL7cBdU3J7n9aKh693bdptYCsY5hSI+M=
X-Google-Smtp-Source: ABdhPJzBOQLiwKEVnQh+/EEnxQiUjfKFDeFZOzXSbIGto+9z9IqvORBCRPOn271NFUbDFk9ZMax8Hg==
X-Received: by 2002:a05:6402:35ce:: with SMTP id z14mr42363470edc.197.1639176184400;
        Fri, 10 Dec 2021 14:43:04 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id og38sm2060044ejc.5.2021.12.10.14.43.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 14:43:03 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id u1so17255113wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 14:43:02 -0800 (PST)
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr17138267wrj.274.1639176181996;
 Fri, 10 Dec 2021 14:43:01 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hpgZ76wUgAuuzcjCdxjpBWAEtruTtXN6eqsDdYdpS8Hw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hpgZ76wUgAuuzcjCdxjpBWAEtruTtXN6eqsDdYdpS8Hw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Dec 2021 14:42:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMh42qQSUW_DYkCOsjku401B9210MGmFGCixJFDWCeEA@mail.gmail.com>
Message-ID: <CAHk-=wgMh42qQSUW_DYkCOsjku401B9210MGmFGCixJFDWCeEA@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control fix for v5.16-rc5
To:     =?UTF-8?Q?Rafa=C5=82_Wysocki?= <rjwysocki@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 12:11 PM Rafa=C5=82 Wysocki <rjwysocki@gmail.com> w=
rote:
>
> This fixes the definition of one of the Tiger Lake MMIO registers
> in the int340x thermal driver (Sumeet Pawnikar).

Funky.

You sent me three pull requests, and two of them came with your normal
address, and now the third from a new gmail one that I've never seen
before.

I also note that this one uses the proper utf-8 "Rafa=C5=82" rather than
"Rafael" - is that your preferred spelling?

I see the signed tag, and I notice that you do have this gmail address
in your key, so this is all fine, but now I'm not sure how to spell
your name any more ;)

              Linus

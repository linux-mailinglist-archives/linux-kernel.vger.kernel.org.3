Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BDC46BF40
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbhLGP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:29:13 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35098 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhLGP3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:29:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 82B30CE1B61;
        Tue,  7 Dec 2021 15:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF660C341C8;
        Tue,  7 Dec 2021 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638890738;
        bh=J8msW6LwcnbTDITwAK9K1Hgp5b7keEccDrPi9Mhoggo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iwb5L4OlwmF0yt3uWY4AZYqXRz84IRo0QH9tgxKb2o5soL1MNqgQJcYQXEO+/tAtm
         76CQRRrWE/0ce7lftJNT+Cb8gtLgAxfDW1vnhSI9V7LngiFtGB1OgsyXyQYytZSDWT
         yoIZfFqqoW9bs2URgEiP3uL9rysxU9rg+mJTyveDYbnYSdGvtHzofgIaC3EfpqQazX
         pEi6W6ucZSMArYx+wy3sTr+nIYnoRNfhlQGVz4b+kYNGKzdngXnaqdXfH3xtgYekYk
         c4LC/uZDrPXO6cdrRIgc6Ksz7OBy69rZy/WzC1ovFUfDigNEL5fKqabNi8lzO9bOV1
         sUE721hCI6rUA==
Received: by mail-ed1-f54.google.com with SMTP id v1so58446336edx.2;
        Tue, 07 Dec 2021 07:25:38 -0800 (PST)
X-Gm-Message-State: AOAM532J6oXEKU+ocqGbCJaKGqLN47lCQVwGpsfm1P8IINeY29HSoy6+
        D74e/eVode+aE2dRYXqAJa7PIQatm6Rzf4aiWQ==
X-Google-Smtp-Source: ABdhPJyOdYTX77AKFpCdW12txA/jNFV1mj20oqfaQ5wauNVRPMWnjnumSoliIuE8OYgdRW1emQ32gqTEtRHsDJ6P8SE=
X-Received: by 2002:a17:906:5e14:: with SMTP id n20mr84229eju.466.1638890736629;
 Tue, 07 Dec 2021 07:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20211206154032.227938-1-thierry.reding@gmail.com>
 <Ya51Ndf+VdRRdM9h@robh.at.kernel.org> <dfb6b42c-16ed-ab17-b585-6b07d3d6874f@gmail.com>
In-Reply-To: <dfb6b42c-16ed-ab17-b585-6b07d3d6874f@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Dec 2021 09:25:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKJFk76nXwRZoe-A_C8r+1jBWMDg7BvrxFBRHR62Ls9yw@mail.gmail.com>
Message-ID: <CAL_JsqKJFk76nXwRZoe-A_C8r+1jBWMDg7BvrxFBRHR62Ls9yw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: regulators: Document Tegra regulator
 coupling in json-schema
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 3:55 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 06.12.2021 23:40, Rob Herring =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, Dec 06, 2021 at 04:40:32PM +0100, Thierry Reding wrote:
> >> From: Thierry Reding <treding@nvidia.com>
> >>
> >> Move the NVIDIA Tegra regulator coupling bindings from the free-form
> >> text format into the existing json-schema file for regulators.
> >
> > Do we need these properties for every single regulator? This should be
> > its own schema file and then referenced where it is needed.
>
> These properties are SoC-specific, they describe how regulators are
> integrated into SoC's power subsystem. Regulators themselves are
> SoC-independent, i.e. PMIC's vendor and model don't matter for SoC.

Yes, but in reality the PMIC and SoC are typically somewhat coupled.
How many PMICs do you need these properties for?

Rob

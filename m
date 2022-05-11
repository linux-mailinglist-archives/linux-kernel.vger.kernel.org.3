Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6485229FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237195AbiEKCrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243334AbiEKCkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:40:35 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B91C20F4C6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:40:32 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id f6-20020a4ace86000000b0035f083d2216so746291oos.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jtaiydWG/wHEMbYT/FSFofg9mXlu8btSO46ZLTfW2rA=;
        b=eGyFVrO10lmw+zfaf5pcltLktNJ/1CbPOHymz7tN2r3TOcOAfeRKz40YqA963vP6Sj
         4+pnLx6kifsxT1QTpSkWWCvT4wJFDRgxVEoNYJTNnEUcNXwtYAow1ohLI7MDL0WpObqn
         gZ1nDsuhO86xqC+aFz2sB7vp0Ouj/1FMnmCy72wpLNUxqg+7C/l6Mo2WdgmQGLgSzuZk
         OFFxkfvg12/OVpCkcbcp4SILs5YLxNRAHP7/XiWcAZIdRMXK7xsXq8bAqaFQKeaBgyhA
         +uf0OmAUGoclt2ZWaXD3s1vaf6OuMtxkT6nDPaBm+PzUVYwoyq1a668E06SVvS8yzasc
         AVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jtaiydWG/wHEMbYT/FSFofg9mXlu8btSO46ZLTfW2rA=;
        b=alsI+gWaaoaRGChDRTy6L0hfyC97zpwoBiZxlsELApeER2618fIGdAFfCDD+F3NJp/
         AbsskwfebhAU+yJT8Km76mlJjCmZ4xp2kdMEU6e1+rASVuYEtrFe21hZd72QWI3Eb/xx
         8yR9ek8Cfx/0yeDu6J2fgY+F2iwcoxqLmQjnlx9TqVA7k49f93xWhmIH0/Ye28ia+nrf
         KCqJyb3nFm8d1LPptiywcL3S6w8XAN+1Ek/eFr8R9L4ve0Dl9CbsPpKs5GYDyx9xpjKo
         8cm2gbrrQI2tQnRt/cwz1+kxMpGxZulfB8ZVWPZJIKy+T7ZrwEsuvlKZYMsTWQGJrH6n
         i4NQ==
X-Gm-Message-State: AOAM533zoNgGajxzB8+GtFhx1knaI4luIotQjHk3lnrVW3+LCVzDnAaF
        oC1xJvG1tLcQus9cVsyettrWc/Zess7CkueptYILZg==
X-Google-Smtp-Source: ABdhPJz+ei/hQMAcBiVGCP/disKXAMzLMiX0vJBayUYqAiRMua51m3bNh5IsKSq1ogoNfL8nyG0RKn+rtIE9XjUvhAU=
X-Received: by 2002:a05:6830:246f:b0:606:bbb:f613 with SMTP id
 x47-20020a056830246f00b006060bbbf613mr8997032otr.102.1652236831957; Tue, 10
 May 2022 19:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220510131136.1103-1-mario.limonciello@amd.com>
In-Reply-To: <20220510131136.1103-1-mario.limonciello@amd.com>
From:   Jian-Hong Pan <jhp@endlessos.org>
Date:   Wed, 11 May 2022 10:39:25 +0800
Message-ID: <CAPpJ_efn1YiLRtbhNwDEr8j+jJfZrHBM9fukDJpuH0czJpgRTQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Limonciello <mario.limonciello@amd.com> =E6=96=BC 2022=E5=B9=B45=E6=
=9C=8810=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:11=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> ASUS B1400CEAE fails to resume from suspend to idle by default.  This was
> bisected back to commit df4f9bc4fb9c ("nvme-pci: add support for ACPI
> StorageD3Enable property") but this is a red herring to the problem.
>
> Before this commit the system wasn't getting into deepest sleep state.
> Presumably this commit is allowing entry into deepest sleep state as
> advertised by firmware, but there are some other problems related to
> the wakeup.
>
> As it is confirmed the system works properly with S3, set the default for
> this system to S3.
>
> Reported-by: Jian-Hong Pan <jhp@endlessos.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215742
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/sleep.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index c992e57b2c79..3147702710af 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -373,6 +373,18 @@ static const struct dmi_system_id acpisleep_dmi_tabl=
e[] __initconst =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
>                 },
>         },
> +       /*
> +        * ASUS B1400CEAE hangs on resume from suspend (see
> +        * https://bugzilla.kernel.org/show_bug.cgi?id=3D215742).
> +        */
> +       {
> +       .callback =3D init_default_s3,
> +       .ident =3D "ASUS B1400CEAE",
> +       .matches =3D {
> +               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"),
> +               },
> +       },
>         {},
>  };
>
> --
> 2.34.1
>

Tested-by: Jian-Hong Pan <jhp@endlessos.org>

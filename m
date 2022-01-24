Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1436449A629
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3412126AbiAYAfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 19:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2364487AbiAXXsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 18:48:16 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBE1C07E314
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:43:19 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id h23so21217727iol.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bwyi05nr6wT2ZFWR22PTFFEqIa15MbmZhLkPDJsvpx0=;
        b=RHC6VLVvqaubbaCRsVngcmpEX70I5qMnda30/M7WCCZwC5f0cqpQ3RymomMsBkULmw
         nf5/S3hSqeRVgjITKXpsUWSCPJ1zSs0WErq91oJeo4EwKAl5NWPxbZD95UmjUoLTZfxV
         UKqLgKCXjmYxAMpQTBGbu1bs6koOmgR3YMUPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bwyi05nr6wT2ZFWR22PTFFEqIa15MbmZhLkPDJsvpx0=;
        b=6cPymeRT6BCdDl6P7iiFy3RTqold7GzMp2qT1Cepa1A2B19PdlVo3cFNlZxosKPtJp
         xEEL4f0z49QNxthTOm5H3dRXzNxoVFiGcq1X49lYYTLsxYkfFeyVIA63ACtppZ61G5je
         TqXglz4goMuFxFvOKqFzZbIAcXcb4nJ0PAE4jBVStLk0rL1DQpQ3RCLD6XF0GcOoa/fR
         ykrDkxohi4DXvTukJ2B9XxGNYdj0neB1yAsJY/lF8CLNoAFnidgbtk6zI1YDSPTbqY9J
         Ewcc1D6od9oPFpVV0495oCOF4LDgeT0UG4ITXd+y7tqM/Q1EJa9r4qGbhlWhuX4ep+1M
         6vHQ==
X-Gm-Message-State: AOAM533O5ffZwjM+6MHCcr/ZCDPl29q/fgU2TDs5K90ywji1lT6NGiiH
        gU89tr8ZflF/aA0SaPB7bJmJAkIhWouveg==
X-Google-Smtp-Source: ABdhPJzP3SKMw6dJ3Zfo3bzJE6hSPN73uestrc9Uen95HaFscPCPvoo/ub7M749/85Rn7AAw8Hz5Aw==
X-Received: by 2002:a5d:9f4c:: with SMTP id u12mr9335789iot.22.1643060598977;
        Mon, 24 Jan 2022 13:43:18 -0800 (PST)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id k9sm7437748iow.48.2022.01.24.13.43.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 13:43:17 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id h7so3354468iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 13:43:17 -0800 (PST)
X-Received: by 2002:a02:9043:: with SMTP id y3mr7723156jaf.263.1643060597485;
 Mon, 24 Jan 2022 13:43:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643015752.git.christophe.leroy@csgroup.eu> <848d857871f457f4df37e80fad468d615b237c24.1643015752.git.christophe.leroy@csgroup.eu>
In-Reply-To: <848d857871f457f4df37e80fad468d615b237c24.1643015752.git.christophe.leroy@csgroup.eu>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jan 2022 13:43:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VMUA+8RFOSkVQTmBDrHPSYSG5VBVA_EKKQuBjF0ZZKpQ@mail.gmail.com>
Message-ID: <CAD=FV=VMUA+8RFOSkVQTmBDrHPSYSG5VBVA_EKKQuBjF0ZZKpQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] modules: Add CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 24, 2022 at 1:22 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -2022,8 +2022,11 @@ static int kdb_lsmod(int argc, const char **argv)
>                 if (mod->state == MODULE_STATE_UNFORMED)
>                         continue;
>
> -               kdb_printf("%-20s%8u  0x%px ", mod->name,
> -                          mod->core_layout.size, (void *)mod);
> +               kdb_printf("%-20s%8u", mod->name, mod->core_layout.size);
> +#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> +               kdb_printf("/%8u  0x%px ", mod->data_layout.size);

Just counting percentages and arguments, it seems like something's
wrong in the above print statement.

-Doug

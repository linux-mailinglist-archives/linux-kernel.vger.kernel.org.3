Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C33474B05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhLNSfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbhLNSfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:35:43 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B92C061574;
        Tue, 14 Dec 2021 10:35:42 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z7so5095809edc.11;
        Tue, 14 Dec 2021 10:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2VijXhAq7PPoIytUtJiQziDQ+1sJ+YxGcblV5fEQi9Y=;
        b=kMyj5kZcDc7vJ0G0r+olqpiyY+QcqHR82Kjmsy2TqzRUSyDQAFMeYsu0mozg71xDUp
         Svz12WMWd9pJGQ8APIcDkva/fS10xPUOUpE7YNVoVQpTMIlBDlhwF7RgPPP9IlI6Rb7S
         DwbdL3oeDqHbh6eHct5T5UEk0F+eHvhM/ckwPlp2YHso1C54xD+kEPFyPMTmRlwfsCia
         DLu79no4dm6dAAs0l+tSK4xoNUSuAeiom17BfHzjCMkYfE3J9ZIxqvSbV0ceiWrWO9bs
         5HWtaWf0iedK+rhSpTdUdOLSuzjAmlhkBXQG6dZSkjzDNl/FALqd+Pe0dU9GGKu/wfnk
         DLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VijXhAq7PPoIytUtJiQziDQ+1sJ+YxGcblV5fEQi9Y=;
        b=AtOkUBMz/q0b6NQfxD3wECwmYPSs2uxyezKLn48sRP0VZLbDrHb3QupdgPHKbd8KtO
         VWbP/KBZ/Kq7GM3rw/dOZh805WP1QarHMXth/3daSDEUWoSkeVCmTcA59GZGdmoM5vYy
         DfVw3Wx0DBXeIUEc22LwmLlX0eMnLNn+HRPepMPrBD1MDGmQPncpM8qprUq5lnMYCG6b
         0u9aPj1ceI0CHxvLvaewuRlYup32VAEeh7BzJXqnWmZ/qXWOEfweoVFSWAR/81DfWXKQ
         8tnKyOoTK3PnLryZiZcz3EQWQGNEl8hU9aHAE6iCo6qysiVsjAqCo/3gyMf8TfQhjLX6
         XRMQ==
X-Gm-Message-State: AOAM533wu8iprzhozhONOJvhLDuCoiCaUHCTvWRxpZjJCJ5K3wUH3CZm
        y5PeH/jFK+Vfmd21jQ8XyXSR3Zj1Re8EoE3dm/5SOcvMa4U=
X-Google-Smtp-Source: ABdhPJwN6qcuf6GilYEfxAcZRtvCiadUaXxDhk3n5lxZR+XInneXofDN2QeZQvdrNkCKp/577fNwvOUg1LNfeU1DZPw=
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr10095409eds.386.1639506941061;
 Tue, 14 Dec 2021 10:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20211212145956.1423755-1-martin.blumenstingl@googlemail.com>
 <20211212145956.1423755-2-martin.blumenstingl@googlemail.com> <CAPDyKFq4Q2M=MimXAERtBy+UY79NwLQs8afGWvvXatOrP_LB7w@mail.gmail.com>
In-Reply-To: <CAPDyKFq4Q2M=MimXAERtBy+UY79NwLQs8afGWvvXatOrP_LB7w@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 Dec 2021 19:35:30 +0100
Message-ID: <CAFBinCAD1guDgrFW5Y3H7YBMKFFiDK92AzyoxnDoAPRsPV8xwQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: meson-mx-sdhc: Set MANUAL_STOP for
 multi-block SDIO commands
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Tue, Dec 14, 2021 at 2:21 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
[...]
> > +
>
> Maybe add a comment to explain a bit about this workaround here?
sure, I'll add a paragraph for v2 because this workaround/fix is not obvious

> > +               manual_stop = cmd->data->blocks > 1 &&
> > +                             (cmd->opcode == SD_IO_RW_DIRECT ||
>
> SD_IO_RW_DIRECT doesn't have cmd->data, so checking for that command
> doesn't make sense.
This also means that you found a bug in the vendor driver :-)
I'll drop SD_IO_RW_DIRECT, do another round of testing and then send
an updated version.

Thank you for taking a closer look!


Best regards,
Martin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F3249722A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 15:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbiAWOjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 09:39:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43316 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbiAWOjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 09:39:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D57860DCB;
        Sun, 23 Jan 2022 14:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5341C340E4;
        Sun, 23 Jan 2022 14:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642948790;
        bh=pbdm6yNzVp/q1gX4haqsF4KAHn/ly4XCm2b7ufFhvcI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wr+DTn/aPm0RFQRCxe41WKikBqJ6SdbgwraVSTZRNizPiaQS8kyhev68O2YHAhsnA
         OeZXOWBPf2xjaV/W7CyxK+lL1Y8zDdmxIqEiuXnnAwcjwXgK5lG9bsa8XeT0rqlUV3
         wZSBZz+hW1+dvppu9LoxOqP15JXSW+cssV3Ui3lO4InfQCMnA58F2JRB2YbKzf5bo1
         k3k4oa00VCpX3w7HmdmNJlVczyhsH+8GekL/yqmiiz/K1p+kfPgemdxoCW2ajoGfLR
         o8onL05X2r0c6V9aPkmogoCtXIy8cTPd7ZSgixU1Z7RYNRY61g7BO/+X9GPrHN+A9f
         QhbDbzr7IHcUw==
Received: by mail-yb1-f179.google.com with SMTP id c6so42993484ybk.3;
        Sun, 23 Jan 2022 06:39:50 -0800 (PST)
X-Gm-Message-State: AOAM533b6L+iODZdUrcI7qA2gmS8WP81iLRVGxFqTa+CUf8rDBcxpCWn
        5LYPb25+rJkY5ZZt1z/ZucQcLiKgg07+6hRYHPE=
X-Google-Smtp-Source: ABdhPJwJFnlLrjCH33CrvzoYJ2kXlBqK2ErLkFwDl5tP5l3SjOYv7cZBRYYKfZOZZbEsk3e4uOoMz5PFi2Pn1K6eB/I=
X-Received: by 2002:a05:6902:72a:: with SMTP id l10mr9866744ybt.302.1642948789950;
 Sun, 23 Jan 2022 06:39:49 -0800 (PST)
MIME-Version: 1.0
References: <20220111071651.GB11243@kili>
In-Reply-To: <20220111071651.GB11243@kili>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 23 Jan 2022 16:39:23 +0200
X-Gmail-Original-Message-ID: <CAFCwf139_RCeudr5RVxhO2A8G8vgj-Qc_0aZ8vGqLRjoP0Ga8g@mail.gmail.com>
Message-ID: <CAFCwf139_RCeudr5RVxhO2A8G8vgj-Qc_0aZ8vGqLRjoP0Ga8g@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: silence an uninitialized variable warning
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Yuri Nudelman <ynudelman@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        Alon Mizrahi <amizrahi@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 9:17 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Smatch warns that:
>
>     drivers/misc/habanalabs/common/command_buffer.c:471 hl_cb_ioctl()
>     error: uninitialized symbol 'device_va'.
>
> Which is true, but harmless.  Anyway, it's easy to silence this by
> adding a error check.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/misc/habanalabs/common/command_buffer.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
> index 3c0ae07a2d80..b9483a3cee91 100644
> --- a/drivers/misc/habanalabs/common/command_buffer.c
> +++ b/drivers/misc/habanalabs/common/command_buffer.c
> @@ -464,6 +464,8 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
>                                 args->in.flags,
>                                 &usage_cnt,
>                                 &device_va);
> +               if (rc)
> +                       break;
>
>                 memset(&args->out, 0, sizeof(args->out));
>
> --
> 2.20.1
>

Thanks!
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.

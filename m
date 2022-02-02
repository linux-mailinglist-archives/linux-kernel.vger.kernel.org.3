Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D8A4A6C79
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 08:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241235AbiBBHut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 02:50:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45116 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbiBBHur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 02:50:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11D8161735
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 07:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CA9C36AE3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 07:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643788246;
        bh=IZcfQmiEK7dPH39xIPhUOsyygBhi4ViZfBzcezAaAXc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bw3TuXXzIklg3ABW3OZbOTYfeiTv0QhzkNnuj2uv7sPJsE5sjn0gJkIYwi3ZD70lN
         /Gz0AkaFAhGgV7ViOmtGd/0pnW3Hyv0pK8/5aZ7pp+ju1tkbn9SRlRU0CEIQ/u7gJZ
         SMDe5mjpQ5piqQwRro2BZ3VYOVIQIyCCPhlOrkF/0oStCACPpAJiFR7dvF5BVTwMxR
         86/ZZwonl+j8dS7Ww8QpzgN0mB95FQK0zy3QzViNk4rEBjccJMUnJ85f9eo2DGbwHJ
         SKC2TmKf5srplOO/M2+7GSwFJ2OIRG/oKpT1ONYzhvaFEHGIVcTaHZl6CxaSIcNfEg
         OACQ7dZuLgTKw==
Received: by mail-yb1-f170.google.com with SMTP id p5so58305803ybd.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 23:50:46 -0800 (PST)
X-Gm-Message-State: AOAM530EXEns+ZOANy9Ted2+w5/pZWEjK5L38Q0vj8wOn4o+zKKdN0jU
        FEtuhTCuCHlGuThiX9pZ0u3izIjR6GJ4Sq3OB0c=
X-Google-Smtp-Source: ABdhPJwOKp8Bdt6ghjUc2oN3ZiJpupW8sgjkoyGq+2cna/JHotucQM+LSrmRVx1UxgPKQObkAh7Nnbi2U/L1AYw4/Bg=
X-Received: by 2002:a5b:48:: with SMTP id e8mr29341428ybp.64.1643788245631;
 Tue, 01 Feb 2022 23:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20220201172424.3509544-1-jordy@pwning.systems>
In-Reply-To: <20220201172424.3509544-1-jordy@pwning.systems>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 2 Feb 2022 09:50:18 +0200
X-Gmail-Original-Message-ID: <CAFCwf12sExpnsBDZX+ay6KKQ1RXoS470a2X_SOUM9KOUwXH4=g@mail.gmail.com>
Message-ID: <CAFCwf12sExpnsBDZX+ay6KKQ1RXoS470a2X_SOUM9KOUwXH4=g@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: fix potential spectre v1 gadgets
To:     Jordy Zomer <jordy@pwning.systems>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Dani Liberman <dliberman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>, Koby Elbaz <kelbaz@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        Sagiv Ozeri <sozeri@habana.ai>,
        Yuri Nudelman <ynudelman@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 7:25 PM Jordy Zomer <jordy@pwning.systems> wrote:
>
> It appears like nr could be a Spectre v1 gadget as it's supplied by a
> user and used as an array index. Prevent the contents
> of kernel memory from being leaked to userspace via speculative
> execution by using array_index_nospec.
>
> Signed-off-by: Jordy Zomer <jordy@pwning.systems>
> ---
>  drivers/misc/habanalabs/common/habanalabs_ioctl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
> index 3ba3a8ffda3e..c1cdf712a10d 100644
> --- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
> +++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
> @@ -14,6 +14,7 @@
>  #include <linux/fs.h>
>  #include <linux/uaccess.h>
>  #include <linux/slab.h>
> +#include <linux/nospec.h>
>
>  static u32 hl_debug_struct_size[HL_DEBUG_OP_TIMESTAMP + 1] = {
>         [HL_DEBUG_OP_ETR] = sizeof(struct hl_debug_params_etr),
> @@ -849,6 +850,7 @@ long hl_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>         }
>
>         if ((nr >= HL_COMMAND_START) && (nr < HL_COMMAND_END)) {
> +               nr = array_index_nospec(nr, HL_COMMAND_END-1);
>                 ioctl = &hl_ioctls[nr];
>         } else {
>                 dev_err(hdev->dev, "invalid ioctl: pid=%d, nr=0x%02x\n",
> @@ -872,6 +874,7 @@ long hl_ioctl_control(struct file *filep, unsigned int cmd, unsigned long arg)
>         }
>
>         if (nr == _IOC_NR(HL_IOCTL_INFO)) {
> +               nr = array_index_nospec(nr, _IOC_NR(HL_IOCTL_INFO));
>                 ioctl = &hl_ioctls_control[nr];
>         } else {
>                 dev_err(hdev->dev_ctrl, "invalid ioctl: pid=%d, nr=0x%02x\n",
> --
> 2.27.0
>

Thanks for the patch.
I'm going to run this through our CI and if nothing breaks I'll merge
it to our -next branch.

Oded

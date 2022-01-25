Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA2149B988
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353226AbiAYRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351746AbiAYQ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:59:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F5FC061783
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:59:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r25so4387581wrc.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0EPBTQB+lrJUfmAenKtP4vKFgFhxTwuJuGHovZ9LsFE=;
        b=QhaQEJdMKLqtIqzHjLgydhsRceWU0PhhmbNDNtwNqt62yw+clPUDRqeO3McjtGcb5h
         61ADGpP/FdrSZSlir/xDTOpCLQ/cIGQ9gRs1zV6v6jwSqOzqt4aDGp3rCAglx/OXuoi3
         /AkO3meyRxOgscSoNR5Nrf8CQuswv+9iEq2Jpq+OWoaB23diYL2HtGV4WE7uVIAC1xZw
         7gPEk2TtkO6Yn3oRbB2kXY6SIxoa4uXzB/WHnfTZCnX9H5OCHPhrf3tqZT6NvZPHBhzt
         qggN4D0baZrmfIGrOebWZDVojORI4G2+B1tAlZPzXOA1OqXdncZOk1rgb81f/0bEM3j9
         zrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0EPBTQB+lrJUfmAenKtP4vKFgFhxTwuJuGHovZ9LsFE=;
        b=wqI+N0xHi6swGzRnJmS2RK/ZF2i052tLXpQNwF+DCqk3YWpfJo5KBibebSapuH/vUx
         ALiIHa0b5LTNc3FeKsjisHjNl+zlC94cf+OLt/XaQDrqM8DWDTiUs8lod+g6uXo6MsY3
         z5HqKJsO/RUWzdj+w1Nld803+lmE9ipNiYiuWJmE5vGi5HgQ+rFm5lV43/d9gSbmVovU
         LQIphh5chZh+UpcE7sZAq/oDx/86ZmYAHsxS29t9LERTTNMPWSNR+IPjmhN7A0nOjIWG
         YnsyB/r+xvdt+DexyTR7ZBu7BaEPu3QRf8tT50gmCxdJoXAzVpj1ELlslKHHHa9rZYix
         emXQ==
X-Gm-Message-State: AOAM531ZleFUQ0F8JKb1PYHKiYgLEoBlBllWihcWDgEFbiTrVk0GP/B4
        XfJif9z1ckyrbvFNm0FxvptVw0mMaqaXl2R6YecdHA==
X-Google-Smtp-Source: ABdhPJzhr5UswaMT7F1OyCk083+R2wOZHEwcVvfkypvFYUFRK0pPN7sqIb8CdgutboBR4Raggs4Qj74sny/tSJ1be8k=
X-Received: by 2002:adf:dfcb:: with SMTP id q11mr18953518wrn.181.1643129959261;
 Tue, 25 Jan 2022 08:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20220122023447.1480995-1-eugenis@google.com> <YfAV6FTN5g6jZGj7@FVFF77S0Q05N>
 <YfAcKZpDWmKMZy8q@FVFF77S0Q05N>
In-Reply-To: <YfAcKZpDWmKMZy8q@FVFF77S0Q05N>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Tue, 25 Jan 2022 08:59:07 -0800
Message-ID: <CAFKCwrjbn3e2w-LikMY5bOvUKbUBi7_4iwBOD7KQUn8QHPwbng@mail.gmail.com>
Subject: Re: [PATCH] arm64: extable: fix null deref in load_unaligned_zeropad.
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 7:50 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Jan 25, 2022 at 03:23:20PM +0000, Mark Rutland wrote:
> > On Fri, Jan 21, 2022 at 06:34:47PM -0800, Evgenii Stepanov wrote:
> > > ex_handler_load_unaligned_zeropad extracts the source and data register
> > > numbers from the wrong field of the exception table.
> >
> > Ouch. Did you find this by inspection, or did this show up in testing?
> >
> > Sorry about this.
> >
> > I think we should be a little more explicit as to exactly what goes wrong. How
> > about:
> >
> > | In ex_handler_load_unaligned_zeropad() we erroneously extract the data and
> > | addr register indices from ex->type rather than ex->data. As ex->type will
> > | contain EX_TYPE_LOAD_UNALIGNED_ZEROPAD (i.e. 4):
> > |
> > | * We'll always treat X0 as the address register, since EX_DATA_REG_ADDR is
> > |   extracted from bits [9:5]. Thus, we may attempt to dereference an arbitrary
> > |   address as X0 may hold an arbitary value.
> > |
> > | * We'll always treat X4 as the data register, since EX_DATA_REG_DATA is
> > |   extracted from bits [4:0]. Thus we will corrupt X4 and cause arbitrary
> > |   behaviour within load_unaligned_zeropad() and its caller.
> > |
> > | Fix this by extracting both values from ex->data as originally intended.
> >
> > > Fixes: 753b3236
> >
> > That should be expanded, e.g.
> >
> >   Fixes: 753b32368705c396 ("arm64: extable: add load_unaligned_zeropad() handler")
> >
> > With those changes:
> >
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>
> Looking again, sicne this isn't jsut a null-deref, can we also rework the
> title, something like:
>
> | arm64: extable: fix load_unaligned_zeropad() reg indices

That's a much better commit message, thank you! I'll upload v2 shortly.

This was found by updating to a newer QEMU that correctly delivers MTE
faults from unaligned memory accesses, and triggers this bug reliably
during Android boot. I'll add a stack trace to v2.

>
> Thanks,
> Mark.

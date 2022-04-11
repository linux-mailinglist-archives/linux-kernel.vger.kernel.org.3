Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2884FBAD4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245698AbiDKLZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiDKLZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:25:32 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90594550A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:23:18 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q19so13898383pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jLhdyx9SwFrbnM2p4JRIefCX4L9OXfhTOuUBWrvzHFY=;
        b=PMDpL7NeORJqEjVqbuLPqkMKb3G1lCabNtIimOppXj/xL0yehJks172PsFaJ933VCK
         usmqhMzGSewyE+XH0DUxZOLLkauDpL7S2Q1/HDPHcqSVQGDBMGqHzUJq1nNxxqv8XlDX
         5CzX6fNgbr0KPB/Vq5T3+8M3mSDk+S0o4IqO7y0Aa4ePxvojqI/gk4ZzhrhILHH8xj0U
         NQvhlMKyGszX9OnlouDpkb+pSO+148cSqUfNSvLOC2hTYtFkn5sIB8KrkbYrEeUZb0OM
         VkrUgp/n6aiPgGz0wyWQDOdwtczTyQH8VdIfkjQFNSqdz2pT2dSg/AUqS25MIN6jQKmZ
         hyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jLhdyx9SwFrbnM2p4JRIefCX4L9OXfhTOuUBWrvzHFY=;
        b=Cp87+DSOK9tyrbgmAUuezNyjqcrVNpjCukJLs1bVFPm7QnXkf4/2XrGXGIQ3pQq+ck
         3ceQF54hcXREUA44JCZlmDo5/+T7SIIs5IKBpjUP0snZZsGVtQU4+0RVSvKvPVoHgxJv
         8skAuTzKzZQWbE4k5kO8qql46WSBYIIjZ/SYos8HWlpmc3Ry9vc4K7B6X6PCGHZaSFVS
         nMaplxQD6oEwwm9kj8QxnyOV0foUqfiPVILimfG71+dtSq3dWE4Oixh5I+ZvS3gc/BYV
         wkL0oPbRfrMpY2GRPEm5XXVTRGMCOnwQ/f+Mfi8E92fKwAsgijSkbVJw7gomavoe0ize
         QqBQ==
X-Gm-Message-State: AOAM531AjIHH4DMDdIceB2MkH545rUvVkf0ZrAhbGdobLYUegGhZrtvw
        gR1/xhGqUkJ4DGjVDYwhM8yxYwguBZVPBN+fuNBQKNmZb3gS
X-Google-Smtp-Source: ABdhPJz7ply/vDvBKcwd3G2CJe3l8EYagqvloodWDAgbrda+wNFc971QiTJszHRFh6DxWRkxsVXlwQdifg7ah2Sg8xs=
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id
 bj2-20020a056a02018200b003745a57cbf9mr25492959pgb.616.1649676198343; Mon, 11
 Apr 2022 04:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAMhUBjn40pO7A=icudFKOoiMrckcH_o7mdi-uCmgCFHi6Ueuzw@mail.gmail.com>
 <20220411093715.4cecc280@xps13>
In-Reply-To: <20220411093715.4cecc280@xps13>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Mon, 11 Apr 2022 19:23:07 +0800
Message-ID: <CAMhUBj=HxPBg1GWF1z3E4zikZ-v9na_8_jCgtJ4d00rL-v8LfA@mail.gmail.com>
Subject: Re: [BUG] mtd: rawnand: denali_pci: page fault when probing fails
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 3:37 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Zheyu,
>
> zheyuma97@gmail.com wrote on Sun, 10 Apr 2022 22:17:35 +0800:
>
> > Hello,
> >
> > I found a bug in the denali_pci module.
> > When the driver fails to probe, we will get the following splat:
> >
> > [    4.472703] denali-nand-pci 0000:00:05.0: timeout while waiting for
> > irq 0x1000
> > [    4.474071] denali-nand-pci: probe of 0000:00:05.0 failed with error -5
> > [    4.473538] nand: No NAND device found
> > [    4.474068] BUG: unable to handle page fault for address:
> > ffffc90005000410
> > [    4.475169] #PF: supervisor write access in kernel mode
> > [    4.475579] #PF: error_code(0x0002) - not-present page
> > [    4.478362] RIP: 0010:iowrite32+0x9/0x50
> > [    4.486068] Call Trace:
> > [    4.486269]  <IRQ>
> > [    4.486443]  denali_isr+0x15b/0x300 [denali]
> > [    4.486788]  ? denali_direct_write+0x50/0x50 [denali]
> > [    4.487189]  __handle_irq_event_percpu+0x161/0x3b0
> > [    4.487571]  handle_irq_event+0x7d/0x1b0
> > [    4.487884]  handle_fasteoi_irq+0x2b0/0x770
> > [    4.488219]  __common_interrupt+0xc8/0x1b0
> > [    4.488549]  common_interrupt+0x9a/0xc0
> >
> > It seems that the driver unmap the memory region before disabling the irq.
>
> Thanks for the report! The mapping is done with devm_ helpers and so is
> the IRQ registration, so it's slightly more complicated that just
> moving a function call in the remove path, apparently. Would you mind
> investigating and proposing a patch?

I have proposed a patch for this issue, please correct me if I am wrong.

Thanks,
Zheyu Ma

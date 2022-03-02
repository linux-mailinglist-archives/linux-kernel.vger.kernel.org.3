Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B284CB028
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244230AbiCBUqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiCBUqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:46:16 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0780B38789;
        Wed,  2 Mar 2022 12:45:33 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id f5so5861601ybg.9;
        Wed, 02 Mar 2022 12:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6qqvHc/+bg7logl0Wqx5hN0gsT9pLtg+9GuBdEyV/s=;
        b=N6mzMrvWJ3NnD3ZyiJjMdVcsCSd17WTZeB6K7pfo5O4CTlaCF/zVdybZv+jhlTrmxe
         uPhSjCcemXAPPjSrv6Mt5HWt3iMD5ymv09MAlL+oTjIdHYCdg/0ssExCUuNBW85SJtyL
         6OeZi79DSlqdlABdL8kngO2BoTutu+xJFXugejEjTOelpI2a+1M4P6YxOlDkDUJyF29p
         PgdD7Ic+/VgjKaC6I7tmOHYd0tLr5EfPZX9OcETMEavgE8GzKwipHdx6ClJQBP2rXN9f
         EGUY3EVA/3aCTBVmeMF2lzsoXWVLoxju/7BmHfIIowzLDvJ2L+u3IWbGBpTNizOgCwuq
         xi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6qqvHc/+bg7logl0Wqx5hN0gsT9pLtg+9GuBdEyV/s=;
        b=MqTU/7efOxboHWpzNtbPuUYy5P3UtEZkdXGobys3I+yE4NONEoIYDh2OMaAtgEXsto
         0etjCrSBMc0cfPzYeUmqZVIFiPWatz6xYCBLAMVlSurHao+yl7p0kFLVCoG5iQuPz7Ir
         oNnA7Jl4Odo0KYnHkXYXUVNC7AeamPH9BaJstB3x4ZJZ3tcikMFUvlkzcMIPFKzs7zYi
         iax6xJPG9IgJCb1METWlCUbtyk8Cb0JQSKPm8+rcnPrPRx9pVMmMExlSCORysR5mmncl
         evi/IKZurk3WxnGJCtChu8jqCRaIyPl30DgrD1wALp5wtH/LODB1QhepuGYVwPufVb8S
         cs+g==
X-Gm-Message-State: AOAM5302zMnxAGgWroUQhPc5HYFLcZAvoLm4RBOH7/RakyzxosXy/4eG
        3uDEi+NsIXfD/Mx4CCUJfsXYgvL7wr8BtVJvGcg=
X-Google-Smtp-Source: ABdhPJzRUMWLpsd+tQeqMe+lON1YrQZx9JkRO/Ga9/nynwkkheUILhBEVszCKkAbAE9UfTyjpoKk7tOUpMQSERi2HWM=
X-Received: by 2002:a25:23d2:0:b0:628:771a:9d3 with SMTP id
 j201-20020a2523d2000000b00628771a09d3mr10191498ybj.215.1646253932161; Wed, 02
 Mar 2022 12:45:32 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 2 Mar 2022 20:44:56 +0000
Message-ID: <CADVatmP4sPwyqi6vKPm3QOFD=47w1LwXtsUynhecY4wMYGhXmw@mail.gmail.com>
Subject: Re: [PATCH v2] parport_pc: Also enable driver for PCI systems
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 8:16 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> Nowadays PC-style parallel ports come in the form of PCI and PCIe option
> cards and there are some combined parallel/serial option cards as well
> that we handle in the parport subsystem.  There is nothing in particular
> that would prevent them from being used in any system equipped with PCI
> or PCIe connectivity, except that we do not permit the PARPORT_PC config
> option to be selected for platforms for which ARCH_MIGHT_HAVE_PC_PARPORT
> has not been set for.
>
> The only PCI platforms that actually can't make use of PC-style parallel
> port hardware are those newer PCIe systems that have no support for I/O
> cycles in the host bridge, required by such parallel ports.  Notably,
> this includes the s390 arch, which has port I/O accessors that cause
> compilation warnings (promoted to errors with `-Werror'), and there are
> other cases such as the POWER9 PHB4 device, though this one has variable
> port I/O accessors that depend on the particular system.  Also it is not
> clear whether the serial port side of devices enabled by PARPORT_SERIAL
> uses port I/O or MMIO.  Finally Super I/O solutions are always either
> ISA or platform devices.
>
> Make the PARPORT_PC option selectable also for PCI systems then, except
> for the s390 arch, however limit the availability of PARPORT_PC_SUPERIO
> to platforms that enable ARCH_MIGHT_HAVE_PC_PARPORT.  Update platforms
> accordingly for the required <asm/parport.h> header.
>
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Usually parport patches goes via Greg's tree. Adding Greg.

-- 
Regards
Sudip

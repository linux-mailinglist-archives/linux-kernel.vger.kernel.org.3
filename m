Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E0D4D2F00
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiCIMZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiCIMZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:25:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F1613CA15
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:24:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38985B818A3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 12:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CFEC340E8;
        Wed,  9 Mar 2022 12:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646828640;
        bh=Aezk0kKkfAiKooUqCsoaoCgBRyxul+bYb/TjUtLyzU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=li7DU14bELKkddX2uIsYVX+An7p+x5dIZa0b5TmIVlJ3otEyARoX0nNHF1GWdBHAM
         qKT9f4QD8+eTo6CZ+8KbuhdTCvj+u4y1kY1AvrKOr7NeMZFiD9W4Ijlwmh28lCEYE5
         FhsI41IP+CzQ9BqGvN8nYoLN6p3fn+db4dSTyHZY=
Date:   Wed, 9 Mar 2022 13:23:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] platform: goldfish: pipe: Use platform_get_irq() to get
 the interrupt
Message-ID: <YiicXXId7T+THYCT@kroah.com>
References: <20211224161334.31123-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224161334.31123-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8viRAW+YxhU=Krmc+zF3ixDOV8nL72PG7CP0iYU9onOhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8viRAW+YxhU=Krmc+zF3ixDOV8nL72PG7CP0iYU9onOhw@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 12:09:45PM +0000, Lad, Prabhakar wrote:
> Hi Greg,
> 
> I'm not sure how I missed you to add in the to list.
> 
> On Fri, Dec 24, 2021 at 4:13 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> > allocation of IRQ resources in DT core code, this causes an issue
> > when using hierarchical interrupt domains using "interrupts" property
> > in the node as this bypasses the hierarchical setup and messes up the
> > irq chaining.
> >
> > In preparation for removal of static setup of IRQ resource from DT core
> > code use platform_get_irq().
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi,
> >
> > Dropping usage of platform_get_resource() was agreed based on
> > the discussion [0].
> >
> > [0] https://patchwork.kernel.org/project/linux-renesas-soc/
> > patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >
> > Cheers,
> > Prabhakar
> > ---
> >  drivers/platform/goldfish/goldfish_pipe.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> >
> Do you want me to resend this patch?

If you want me to apply it, yes.

thanks,

greg k-h

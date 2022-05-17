Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958DA52A8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351241AbiEQQyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350665AbiEQQyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:54:49 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A240934
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:54:47 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2fedd26615cso81418747b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qfrwpsR8dVYRSweWV/3B4/qVRy2oFwVXna3I/qpO720=;
        b=bcV6Yy2SmG5kbc6Q0/RO4eqS91H09JPCZebLeSw/NxhJKasEo8+GNMY59lxoJsum9M
         4jhBAuevZyGJx/xmKU4uYQQDy80mfVv4+vgTUAXPqKwYLR9nQw6fT9+oOCredKi7qDEK
         8qdIv3GRuzTYuddp1+5eme1J94/10qJRcw24MD95o/z7LY86Gyy11dij26G6Tdqr+FFZ
         VThcInGlWbQWOcS+SAW8xp1YsvTAsNQl+0ImPTGcGWBoCogXWE1LG4TvVtypNzumze7E
         ys2MDAEwmPlKYvf714pL37hPyu7ozSRB4HqhPYZ24Qkq3npQqvoFsVqWZ0uiso3RqGam
         LL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfrwpsR8dVYRSweWV/3B4/qVRy2oFwVXna3I/qpO720=;
        b=J5z6SGRcQDTakUyV6LxHCS/LNa1TQyJjuOlNPyZlaT1GlVJdSAahA3QB5SwpEuHWgX
         RDJ01ruSat1cIMDZBBkCBj+5xJN6ncY+gYwZhtRraLywPJoJhAXERKiTruCRKStjcVvW
         HO7/PuUCI3EJWz0ZYPWw3Er3VoUD6AGRhtWYy4zDHlVzHGxBFGQstAyn2OqRPmU1D+uw
         pxH/grTRh6I+h20kC0DL7bAhHITmLtFfpF+jb4s+/z9MKly2nrtq+9UgwD0urORTRdkl
         u9CcUpSmfPrzOj+ey2OigqRiG3Eb0uA6omN2qo6thqG6qV+3QeMWzt5ng0UTiXlX31Ct
         jdIA==
X-Gm-Message-State: AOAM5336kukDLrbV0WcJosUN9F6NwTRdyw7Jy0ev7iuVA+h9Ezk4Ha00
        Tq+o/DirPHNX9s1oUnlnbk5DCCzRdw5RJ8sczOGmfw==
X-Google-Smtp-Source: ABdhPJxRWXaAW/s7NQiyicZLAUVWqeo8BUdGCRUR2iOWAW29E0H0E6iMG/OCQUnBO3WNAZSnwEP4KifL6o+gmc2+wiI=
X-Received: by 2002:a0d:d4d0:0:b0:2fe:b86b:472d with SMTP id
 w199-20020a0dd4d0000000b002feb86b472dmr24665158ywd.469.1652806487018; Tue, 17
 May 2022 09:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220517101410.3493781-1-andre.przywara@arm.com> <20220517153444.GA1057027-robh@kernel.org>
In-Reply-To: <20220517153444.GA1057027-robh@kernel.org>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 17 May 2022 17:54:36 +0100
Message-ID: <CAFEAcA8sE8Rj0GmF71ox4BdDr0UcaS4QwiLUVUUFH5oj+hDhfA@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Ignore disabled memory nodes
To:     Rob Herring <robh@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ross Burton <ross.burton@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 at 16:34, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 17, 2022 at 11:14:10AM +0100, Andre Przywara wrote:
> > When we boot a machine using a devicetree, the generic DT code goes
> > through all nodes with a 'device_type = "memory"' property, and collects
> > all memory banks mentioned there. However it does not check for the
> > status property, so any nodes which are explicitly "disabled" will still
> > be added as a memblock.
> > This ends up badly for QEMU, when booting with secure firmware on
> > arm/arm64 machines, because QEMU adds a node describing secure-only
> > memory:
> > ===================
> >       secram@e000000 {
>
> BTW, 'memory' is the correct node name.

We already have a 'memory' node, which is for the NS
memory. This one's for the secure-only RAM block,
which is why I gave it a name that hopefully helps in
spotting that when a human is reading the DT.

I'm not really sure to what extent node names in device trees are
"this is just an identifying textual label" and to what extent
they are "this is really ABI and you need to follow the standard",
though -- nothing in practice seems to care what they are,
suggesting the "textual label" theory, but some bits of tooling
complain if you do things like forget the address value or use the
same address for two different nodes, suggesting the "really ABI"
theory.

thanks
-- PMM

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7335359565E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiHPJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiHPJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:30:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2B3DEC9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 00:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD3BAB81647
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 07:51:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A48C433D7;
        Tue, 16 Aug 2022 07:51:46 +0000 (UTC)
Date:   Tue, 16 Aug 2022 08:51:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mte: Follow arm64.nomte override in MMU setup.
Message-ID: <YvtMk2cNDrrzVX3g@arm.com>
References: <20220805214734.1937451-1-eugenis@google.com>
 <875yj1x0k0.wl-maz@kernel.org>
 <CAFKCwrjVaOdrGktxVHLCDPyJSRjZ0B3FHTGsb3PXMULL=dw9rA@mail.gmail.com>
 <87v8r1uztz.wl-maz@kernel.org>
 <CAFKCwriq-Vh+fhxso=xqtKzkL95QkYOOkMR8XwTOJfeg1M-2qQ@mail.gmail.com>
 <CAMn1gO5Va0eVFqzoOLLLJ+C+x-5=cc4qXDTw0e9J7v0RpYWusA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO5Va0eVFqzoOLLLJ+C+x-5=cc4qXDTw0e9J7v0RpYWusA@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 06:24:23PM -0700, Peter Collingbourne wrote:
> On Tue, Aug 9, 2022 at 10:29 AM Evgenii Stepanov <eugenis@google.com> wrote:
> > On Tue, Aug 9, 2022 at 9:49 AM Marc Zyngier <maz@kernel.org> wrote:
> > > In which case what is the tag memory doing in the linear map?
> > > Shouldn't it be marked as reserved, not mapped, and in general
> > > completely ignored by the NS OS?
> >
> > That would be wasteful. The idea is to only reserve the parts of the
> > tag memory that correspond to the TZ carveout and release the rest to
> > the NS OS.
> 
> More generally, one can imagine a system where *any* tagged memory
> transaction can result in an SError because the MTE implementation was
> not configured by an earlier bootloader phase, e.g. because the
> bootloader was configured to disable MTE at runtime. On such systems,
> the kernel must refrain from causing tagged memory transactions to be
> issued via the linear map, and that's exactly what this patch does.

The problem is that it doesn't. The 8.5 architecture allows any Normal
Cacheable (even non-tagged) mapping to fetch tags. It may happen that on
certain implementations setting MAIR to non-tagged works but that's not
guaranteed and with the Linux kernel we tend to stick to the architected
behaviour (with a few exceptions like PMU counters and errata).

There is an ongoing discussion with the architects and partners on
whether we can tighten the architecture as not to cause visible
side-effects like SError but not sure whether that has been closed yet
(just back from holiday).

Until that's sorted, tag storage cannot be reused in an arm64-generic
way in the kernel.

-- 
Catalin

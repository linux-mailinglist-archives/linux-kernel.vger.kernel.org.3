Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571144FBE36
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346861AbiDKOEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243601AbiDKOEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:04:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488531DFC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:02:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFD71B815F3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE8AC385A3;
        Mon, 11 Apr 2022 14:02:16 +0000 (UTC)
Date:   Mon, 11 Apr 2022 15:02:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from
 ARCH_DMA_MINALIGN
Message-ID: <YlQ05X7hmYpMWydy@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-2-catalin.marinas@arm.com>
 <YlQEzdOtoNwDHhDi@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlQEzdOtoNwDHhDi@hyeyoo>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 07:37:01PM +0900, Hyeonggon Yoo wrote:
> On Tue, Apr 05, 2022 at 02:57:49PM +0100, Catalin Marinas wrote:
> > In preparation for supporting a dynamic kmalloc() minimum alignment,
> > allow architectures to define ARCH_KMALLOC_MINALIGN independently of
> > ARCH_DMA_MINALIGN. In addition, always define ARCH_DMA_MINALIGN even if
> > an architecture does not override it.
> > 
> > After this patch, ARCH_DMA_MINALIGN is expected to be used in static
> > alignment annotations and defined by an architecture to be the maximum
> > alignment for all supported configurations/SoCs in a single Image.
> > ARCH_KMALLOC_MINALIGN, if different, is the minimum alignment guaranteed
> > by kmalloc().
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
[...]
> Sorry for the noise I made due to misunderstanding :)
> Now this patch looks good to me and I think it's worth adding.
> 
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> and works fine with SLAB/SLOB/SLUB on my arm64 machine.
> 
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks for the review and test. We still need to solve the potential
crypto issues raised by Herbert before making the change.

-- 
Catalin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1D538C12
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbiEaHl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiEaHlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:41:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205AD8CCEA
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FiBE3+6Zj41uR5MWSVwoPXLvCROMHXml0uOpgCHkabs=; b=f9KfzqGtWoHwTpkTKaUNSmkkrq
        a832nluQ/NYDJ/Phb3YLI0WMym9Jj6F/CRklih5BWReVVSfsoBNc4FQpa36hyWGrcSOLRqUhQJy94
        NUWJqBgxqwa/7N2ZGz0Aiyxlatqsp6OAlKUnnVUPlhjr2/9gnY53W/GUMu+2h43Pls6BrfFWxSar8
        jB5BtaRrjw0mC/Jubs1zspFvkK2s3Mh1RfRugpXDHGzDbXPEndmV6AwLGfqJx1cNFZlHdEedQDIMP
        XvTW3Yxqzd+dRn3d8U1/JZCVqn9Ok78e07bJLe63DCT7Og0w+O6fCSZhA4AWmrNtMGm97tRA/cvvW
        CtGP6mUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvwV8-009iK0-78; Tue, 31 May 2022 07:41:14 +0000
Date:   Tue, 31 May 2022 00:41:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Erhard Furtner <erhard_f@mailbox.org>
Subject: Re: [PATCH] powerpc/Kconfig: Force THREAD_SHIFT to at least 14 with
 KASAN
Message-ID: <YpXGmilyOWmAh4WA@infradead.org>
References: <cc1190008368a3305d424a98be756fedec6348c1.1653926503.git.christophe.leroy@csgroup.eu>
 <87h756kz0s.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h756kz0s.fsf@mpe.ellerman.id.au>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 04:16:19PM +1000, Michael Ellerman wrote:
> I was thinking of doing it in C, similar to the way arm64 handles it.
> 
> Something like below. It means we always double the stack size when
> KASAN is enabled. I think it's preferable, as it will always work
> regardless of whether the user has an old .config (or is bisectting)?

Is there any reason to even offer the Kconfig?  It is super cryptic and
just picking the right value directly in the header would seem much
more sensible:

#if defined(CONFIG_PPC_256K_PAGES)
#define MIN_THREAD_SHIFT		15
#elif defined(CONFIG_PPC64)
#define MIN_THREAD_SHIFT		14
#else
#define MIN_THREAD_SHIFT		13
#endif

#ifdef CONFIG_KASAN
#define THREAD_SHIFT		(MIN_THREAD_SHIFT + 1)
#else
#define THREAD_SHIFT		MIN_THREAD_SHIFT
#endif

#if defined(CONFIG_VMAP_STACK) && THREAD_SHIFT < PAGE_SHIFT
#undef THREAD_SHIFT
#define THREAD_SHIFT		PAGE_SHIFT
#endif

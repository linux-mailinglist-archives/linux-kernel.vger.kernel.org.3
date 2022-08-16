Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4AB5954C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiHPIOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiHPINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:13:30 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B0969F60;
        Mon, 15 Aug 2022 23:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5mwKLMlqlsmYbtuyi4aXzonUQ8/kmoqLmUhmFoodlO8=; b=GkbwgdirZZUpz61FCNvNhgX3h3
        DKSv0OCJl9yp0v8E0fujD4t5nvp2H1W2rgPEr91bf9OgOjMFA61W0Sh7UFRD04UmFW7noRpyBv6os
        xyjJ7UFbttn0qzhLBJvUuU0ZVpF6bmTjai84VJ9G3D3kKMx1EavmJczinX87urxPcx5dviIoTmANa
        2S+1ftsCuZ5QcH3nVcKYt+KWXZU/x1cOeRmivadO2KmvkENapsnz2CpUcpLKqDSPVZTFtLkP/EUEV
        V9Cc1sOmUCs0jEWRFgK2Uny39YVOQcAt/aVzyAA3FZnoiPPSR5w77IPnhBYjPnGDvOP5LOzKM6TpS
        nCk9byzQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNpzt-004wki-P2;
        Tue, 16 Aug 2022 06:24:17 +0000
Date:   Tue, 16 Aug 2022 07:24:17 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Xin Gao <gaoxin@cdjrlc.com>, geert@linux-m68k.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: Complete variable type
Message-ID: <Yvs4EUfVUdOgEW4f@ZenIV>
References: <20220815194806.3487-1-gaoxin@cdjrlc.com>
 <4ae72d0b-b197-f9d8-5cbe-ce7cfaf3affc@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae72d0b-b197-f9d8-5cbe-ce7cfaf3affc@linux-m68k.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 09:37:19AM +1000, Greg Ungerer wrote:
> On 16/8/22 05:48, Xin Gao wrote:
> > @@ -169,7 +169,7 @@ void q40_sched_init (void)
> >    *
> >   */
> > -struct IRQ_TABLE{ unsigned int mask; int irq ;};
> > +struct IRQ_TABLE{ unsigned int mask; int irq };
> >   #if 0
> >   static struct IRQ_TABLE iirqs[]={
> >     {Q40_IRQ_FRAME_MASK,Q40_IRQ_FRAME},
> 
> This last change doesn't match the commit message.
> It should be a separate patch.

	The last change is not a valid C.  Never had been.
In C semicolon is *NOT* a separator - it's a part of declaration.

-- 
improve the kernel quality - git rm scripts/checkpatch.pl

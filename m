Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6D2520532
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbiEITZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 15:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbiEITYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 15:24:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB63A2469C5;
        Mon,  9 May 2022 12:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ECD2B818F6;
        Mon,  9 May 2022 19:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25555C385B8;
        Mon,  9 May 2022 19:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652124048;
        bh=+bmICguv18jBXLXxrwEf33icObsc1fpHfVo5K9f7UEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRqjkFhc7fprJOJNhXu8GtpXTXjxRgBD11PxUp5vgIDT+yvDiqJ87C3HYOFhA8jdg
         R+oLSULFkhfcr+yp9NkuWc5h6OLbSHeyLb6zDIUu9i0pBIxF8cBZ9+47e9zOg8aL9P
         l3EkaSgcNByUgdE0P9G+I68ZcKHTZ1mAOoFJ/VOnIL2LYNsiElmX6jWPxGH4z+/NOO
         VU3uxCgvT9hpeTUOTO486gfhJr2PzZkT7pf4U7L2PPZnk1wuVH58YvDIDcdFR26RRq
         tk62Ej4fdy95ArndH/Fj2+sajgYOO9SSXHbnnLJeycGEeWRhveSn+d7ISAMZgxGDvT
         bGW6RhhtE7Nyw==
Date:   Mon, 9 May 2022 12:20:45 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] bug: Use normal relative pointers in 'struct bug_entry'
Message-ID: <20220509192045.2nkiaw4ne2dnuuai@treble>
References: <afddb4548e93f6458ec1d9ec185a834c348eda33.1651798983.git.jpoimboe@kernel.org>
 <871qx2ubu5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871qx2ubu5.fsf@mpe.ellerman.id.au>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 10:31:14PM +1000, Michael Ellerman wrote:
> Embarrassingly, we have another copy of the logic, used in the C
> versions, they need updating too:

Oops, thanks for finding that.

> With that added it seems to be working correctly for me.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Thanks!

-- 
Josh

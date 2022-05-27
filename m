Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909B8535ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351097AbiE0K6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350706AbiE0K63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:58:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1561271AD
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:58:27 -0700 (PDT)
Received: from zn.tnic (p200300ea97465727329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5727:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C30A31EC064E;
        Fri, 27 May 2022 12:58:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653649101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qz4XrAcGGPsXYTIjWabEhNGNxbXciy2M07T6g7TPC7g=;
        b=i6+zzAkp4x2ZjS/trI7lM10v7YizyV220MfBnr/gKNkRXWPHCnIZoydApIqbQklQOQEb/+
        B1b1KhoVwcDZBEu0rysOQNEhrLGSisjRMTJOVLUhBA8yDDAnH1wMWdv4moYSt1A8dYpT6X
        qERv21abMTGxeyqqM4N30kK/ZkjjQpU=
Date:   Fri, 27 May 2022 12:58:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [RFC PATCH 2/3] x86/microcode: Default-disable late loading
Message-ID: <YpCuyrqc/YEmdPs6@zn.tnic>
References: <20220524185324.28395-1-bp@alien8.de>
 <20220524185324.28395-3-bp@alien8.de>
 <YpCp5B7noKAt+91A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YpCp5B7noKAt+91A@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 12:37:24PM +0200, Ingo Molnar wrote:
> Might make sense to outline here valid circumstances under which late 
> loading is used? Such as some weird kernel package that doesn't have the 
> latest firmware included in the initrd?

Well, considering how we do correctness first, functionality later, I'd
really really like to not do late loading at all.

I wasn't aware of this sequence Cooper gave me on IRC but consider what
happens where one thread is doing the microcode uploading and the other
gets an NMI!

Our "precious" dance we have right now is not protected against that
scenario so *actually*, if we have to do the right thing, we should not
do late loading at all and zap it.

> Because it's hard (for me) to see any valid circumstance under which late 
> loading should be supported at all TBH: new kernels where this patch is 
> active would come with a modern package.
> 
> Ie. we should consider removing late loading altogether.

Yap, exactly.

Late loading is actually broken as it is right now, IMNSVHO.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

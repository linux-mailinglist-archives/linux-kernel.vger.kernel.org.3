Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DBB560731
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiF2RSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiF2RSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B941A812
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D444461E56
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 17:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C95C34114;
        Wed, 29 Jun 2022 17:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656523111;
        bh=cElJT+fqYXMLdJ0O9skHbTQ8acmcYY3npP0Idut/ntE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ti985LV+4onMHrTrVh1q2DMliiCN0ww7NfP/MJct+nuqmClkkjSIm86ULTpKL6g59
         j52/wek/dOmKMWSktBjEyg1c3kKfFSnPTazCVlvOWhTqyvfGgp3YWMqiwQVEherWIx
         3rqDa3Vl8HJobmeSU2QbQa1aLy6JIFBt1L9QOc+Hg4uEotfZ7mm8fA+CgaOVzQtRju
         ltcPDaOpAuvwEcnqabUllBaMIDjNmYW9vzyVao4gVbX8MBdN0LZKtvwywxC/uRQ7af
         pWZwK075jfREZIJpdmS6LNLO0ojr7i5JUu0L0Ncws5c/OqsGKW84vkr92vx8zhwQOE
         vyBGKuZ/nMtIw==
Date:   Wed, 29 Jun 2022 10:18:29 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 3/3] x86: fix .brk attribute in linker script
Message-ID: <20220629171829.shotpln44nzgo2eu@treble>
References: <20220623094608.7294-1-jgross@suse.com>
 <20220623094608.7294-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220623094608.7294-4-jgross@suse.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:46:08AM +0200, Juergen Gross wrote:
> Commit e32683c6f7d2 ("x86/mm: Fix RESERVE_BRK() for older binutils")
> added the "NOLOAD" attribute to the .brk section as a "failsafe"
> measure.
> 
> Unfortunately this leads to the linker no longer covering the .brk
> section in a program header, resulting in the kernel loader not knowing
> that the memory for the .brk section must be reserved.
> 
> This has led to crashes when loading the kernel as PV dom0 under Xen,
> but other scenarios could be hit by the same problem (e.g. in case an
> uncompressed kernel is used and the initrd is placed directly behind
> it).
> 
> So drop the "NOLOAD" attribute. This has been verified to correctly
> cover the .brk section by a program header of the resulting ELF file.
> 
> Fixes: e32683c6f7d2 ("x86/mm: Fix RESERVE_BRK() for older binutils")
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh

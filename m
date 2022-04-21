Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A9350A726
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390786AbiDURcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390780AbiDURb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:31:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CBC46B1E;
        Thu, 21 Apr 2022 10:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3F60B82870;
        Thu, 21 Apr 2022 17:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABA7C385A5;
        Thu, 21 Apr 2022 17:29:01 +0000 (UTC)
Date:   Thu, 21 Apr 2022 18:28:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net,
        linux-hardening@vger.kernel.org, Jann Horn <jannh@google.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Igor Zhbanov <izh1979@gmail.com>
Subject: Re: [PATCH RFC 0/4] mm, arm64: In-kernel support for
 memory-deny-write-execute (MDWE)
Message-ID: <YmGUWq1Ea5koA8mt@arm.com>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <202204141028.0482B08@keescook>
 <YmAEDsGtxhim46UI@arm.com>
 <c62170c6-5993-2417-4143-5a37a98b227c@gmail.com>
 <202204201610.093C9D5FE8@keescook>
 <YmF5s4KqT5WL4O0G@arm.com>
 <400be309-ef3f-4175-594d-7dc45a43dc36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400be309-ef3f-4175-594d-7dc45a43dc36@gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 07:48:27PM +0300, Topi Miettinen wrote:
> On 21.4.2022 18.35, Catalin Marinas wrote:
> > Do we want the "was PROT_WRITE" or we just reject mprotect(PROT_EXEC) if
> > the vma is not already PROT_EXEC? The latter is closer to the current
> > systemd approach. The former allows an mprotect(PROT_EXEC) if the
> > mapping was PROT_READ only for example.
> > 
> > I'd drop the "was PROT_WRITE" for now if the aim is a drop-in
> > replacement for BPF MDWE.
> 
> I think we'd want existing installations with MemoryDenyWriteExecute=yes not
> start failing when the implementation is changed to in-kernel version. The
> implementation could be very simple and not even check existing PROT_ flags
> (except for BTI case) to be maximally compatible to BPF version.

It would have to check the existing flags otherwise this could have been
implemented in the BPF filter. The dynamic loader (or kernel loader)
first mmap(PROT_READ|PROT_EXEC) and, if the BTI note is found, it
switches it to mprotect(PROT_READ|PROT_EXEC|PROT_BTI). If we allowed
this to pass simply because of PROT_BTI, one could create such
executable mapping even if it is (or was) writeable.

So we can either allow mprotect(PROT_EXEC) if the mapping was never
writeable or we allow mprotect(PROT_EXEC) if the mapping is already
PROT_EXEC (and the check for W^X was previously done by mmap()).

> So I'd leave "was PROT_WRITE" and other checks to more advanced
> versions, enabled with a different PR_MDWX_FLAG_.

This works for me as well. See my reply to Kees for the use-cases.

Thanks.

-- 
Catalin

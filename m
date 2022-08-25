Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7125A1CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 01:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbiHYXQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 19:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHYXQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 19:16:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D526152085;
        Thu, 25 Aug 2022 16:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6838E61CFA;
        Thu, 25 Aug 2022 23:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C03C433D6;
        Thu, 25 Aug 2022 23:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661469359;
        bh=1luF4ZPC+Q2s8FgZ5cg9kHsh/AqkmR9rbZevSu2GNpA=;
        h=Date:From:To:Cc:Subject:From;
        b=kEU9/E79AmW2kl0mXY5lSkYUcvS33J095SeGujFg01tLd9d1L5kFgZGRJf4pgZnA8
         138aGBAHZD1O9j7zbDsYbd7xvMkrHgpG/MiGRV+GfZJMhufeurfEJPxm9xExsAhmNw
         NiRMiCxI0dPsv97n5JgeBuVX7pniCB0WGOmvX7M9KE5EFa5sr2RXag49NYLP/R/mBo
         zWod0WIE+510aCkPPJ9Zgxg9hJ3Ph/p7Ric9PURdl/qkGNYLHLxU2I3LkMCynaShDA
         RdlJtC7P2qHUDNcdLbw/r1pbYfyK19VvLF/0Q9lCze30CRPu7Pir5egKUMcXU2RGif
         PrIaMimUzM3AA==
Date:   Thu, 25 Aug 2022 23:15:58 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     x86@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Langley <agl@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Should Linux set the new constant-time mode CPU flags?
Message-ID: <YwgCrqutxmX0W72r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Intel and ARM recently published documentation that says that no instructions
are guaranteed to be constant-time with respect to their data operands, unless a
"data independent timing" flag in the IA32_UARCH_MISC_CTL register (Intel) or
DIT register (arm64) is set:

* https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/best-practices/data-operand-independent-timing-isa-guidance.html
* https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers/DIT--Data-Independent-Timing

This is a major problem for crypto code, which needs to be constant-time,
especially with respect to keys.  And since this is a CPU issue, it affects all
code running on the CPU.  While neither company is treating this as a security
disclosure, to me this looks exactly like a CPU vulnerability.

For Intel, given that the mitigation is to set an MSR flag, it seems that the
kernel will need to do that -- similar to the MSR flags that enable mitigations
for speculative execution vulnerabilities.

For arm64, it's not clear to me whether the DIT flag is privileged or not.  If
privileged, I expect it would need to be set by the kernel just like the Intel
flag.  If unprivileged, I expect there will still be work to do in the kernel,
as the flag will need to be set when running any crypto code in the kernel.

I'm wondering if people are aware of this issue, and whether anyone has any
thoughts on whether/where the kernel should be setting these new CPU flags.
There don't appear to have been any prior discussions about this.  (Thanks to
Adam Langley, who maintains BoringSSL, for bringing this to my attention.)

- Eric

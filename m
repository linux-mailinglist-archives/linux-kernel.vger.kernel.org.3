Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2E95A21B6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245234AbiHZHXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244814AbiHZHXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:23:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22E1D2EB8;
        Fri, 26 Aug 2022 00:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AEKb3DwntGJTTjvDTJ6NmSnPWGwTdjV+VoVwaBrNJnk=; b=OkA+Cx6EfR/tlzYGyBhl8+vsbz
        3Za4a2S7rWXT+HhqKqJf5T1BQjDBg0G3qCmFvzOIovSWOu8gzNUGDBDFdvC9A7GjkfCPQoguol4wb
        i2FYfBbYPfPEJYIYgqTrsq73NtGhpvCFzME763sBZckOABZSOk1o8FpsX+2gRox1hKEIPonKZ62mA
        q3QF0yn04z6diKaFQs+4rc8x6Q07IDs0V3o4yIIxk76ddrcyHQ1soQ+/ZvHu5zb2j5Zb4CAHARU7y
        AyDgtU6LR8GLZDzV4Qn9MK8ODVMqXPWT4IFWRtLUdOwcWbM7GzHeMBwNrDyjMrrtda/fUtX//2pPM
        5MPsMXcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRTgk-006HEO-Ko; Fri, 26 Aug 2022 07:23:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4AB7B98028D; Fri, 26 Aug 2022 09:23:33 +0200 (CEST)
Date:   Fri, 26 Aug 2022 09:23:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam Langley <agl@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Should Linux set the new constant-time mode CPU flags?
Message-ID: <Ywh09ZXBZFA3R0W6@worktop.programming.kicks-ass.net>
References: <YwgCrqutxmX0W72r@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwgCrqutxmX0W72r@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 11:15:58PM +0000, Eric Biggers wrote:
> Hi,
> 
> Intel and ARM recently published documentation that says that no instructions
> are guaranteed to be constant-time with respect to their data operands, unless a
> "data independent timing" flag in the IA32_UARCH_MISC_CTL register (Intel) or
> DIT register (arm64) is set:
> 
> * https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/best-practices/data-operand-independent-timing-isa-guidance.html
> * https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers/DIT--Data-Independent-Timing
> 
> This is a major problem for crypto code, which needs to be constant-time,
> especially with respect to keys.  And since this is a CPU issue, it affects all
> code running on the CPU.  While neither company is treating this as a security
> disclosure, to me this looks exactly like a CPU vulnerability.
> 
> For Intel, given that the mitigation is to set an MSR flag, it seems that the
> kernel will need to do that -- similar to the MSR flags that enable mitigations
> for speculative execution vulnerabilities.
> 
> For arm64, it's not clear to me whether the DIT flag is privileged or not.  If
> privileged, I expect it would need to be set by the kernel just like the Intel
> flag.  If unprivileged, I expect there will still be work to do in the kernel,
> as the flag will need to be set when running any crypto code in the kernel.
> 
> I'm wondering if people are aware of this issue, and whether anyone has any
> thoughts on whether/where the kernel should be setting these new CPU flags.
> There don't appear to have been any prior discussions about this.  (Thanks to
> Adam Langley, who maintains BoringSSL, for bringing this to my attention.)

Whichever way around I think you want OS support to make it a per-task
property instead of a per CPU one.

Also, *sigh* yet another MSR to touch :/

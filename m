Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F2D50FA8B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349104AbiDZKe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349143AbiDZKdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:33:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 538FD101D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:11:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83EFD23A;
        Tue, 26 Apr 2022 03:11:00 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.76.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3300C3F5A1;
        Tue, 26 Apr 2022 03:10:59 -0700 (PDT)
Date:   Tue, 26 Apr 2022 11:10:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH 0/8] stackleak: fixes and rework
Message-ID: <YmfFLOW5QyF3DKTC@FVFF77S0Q05N>
References: <20220425115603.781311-1-mark.rutland@arm.com>
 <202204251551.0CFE01DF4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204251551.0CFE01DF4@keescook>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 03:54:00PM -0700, Kees Cook wrote:
> On Mon, Apr 25, 2022 at 12:55:55PM +0100, Mark Rutland wrote:
> > This series reworks the stackleak code. The first patch fixes some
> > latent issues on arm64, and the subsequent patches improve the code to
> > improve clarity and permit better code generation.
> 
> This looks nice; thanks! I'll put this through build testing and get it
> applied shortly...

Thanks!

Patch 1 is liable to conflict with come other stacktrace bits that may go in
for v5.19, so it'd be good if either that could be queued as a fix for
v5.1-rc4, or we'll have to figure out how to deal with conflicts later.

> > While the improvement is small, I think the improvement to clarity and
> > code generation is a win regardless.
> 
> Agreed. I also want to manually inspect the resulting memory just to
> make sure things didn't accidentally regress. There's also an LKDTM test
> for basic functionality.

I assume that's the STACKLEAK_ERASING test?

I gave that a spin, but on arm64 that test is flaky even on baseline v5.18-rc1.
On x86_64 it seems consistent after 100s of runs. I'll go dig into that now. 

FWIW, I'm testing with defconfig + STACKLEAK + STACKLEAK_RUNTIME_DISABLE +
LKDTM, using GCC 11.1.0 from the kernel.org crosstool pages. When running the
test it passes a few times, then fails dramatically:

| # uname -a
| Linux buildroot 5.18.0-rc1 #1 SMP PREEMPT Tue Apr 26 10:38:12 BST 2022 aarch64 GNU/Linux
| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| [   21.899596] lkdtm: Performing direct entry STACKLEAK_ERASING
| [   21.900102] lkdtm: checking unused part of the thread stack (15480 bytes)...
| [   21.900752] lkdtm: the erased part begins after 1440 not poisoned bytes
| [   21.901318] lkdtm: OK: the rest of the thread stack is properly erased
| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| [   22.551022] lkdtm: Performing direct entry STACKLEAK_ERASING
| [   22.551625] lkdtm: checking unused part of the thread stack (15480 bytes)...
| [   22.552314] lkdtm: the erased part begins after 1440 not poisoned bytes
| [   22.552915] lkdtm: OK: the rest of the thread stack is properly erased
| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| [   23.137457] lkdtm: Performing direct entry STACKLEAK_ERASING
| [   23.138521] lkdtm: checking unused part of the thread stack (15480 bytes)...
| [   23.139173] lkdtm: the erased part begins after 1440 not poisoned bytes
| [   23.139787] lkdtm: OK: the rest of the thread stack is properly erased
| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| [   23.601729] lkdtm: Performing direct entry STACKLEAK_ERASING
| [   23.603159] lkdtm: checking unused part of the thread stack (15480 bytes)...
| [   23.603982] lkdtm: the erased part begins after 1440 not poisoned bytes
| [   23.604565] lkdtm: OK: the rest of the thread stack is properly erased
| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| [   24.046171] lkdtm: Performing direct entry STACKLEAK_ERASING
| [   24.046525] lkdtm: checking unused part of the thread stack (15480 bytes)...
| [   24.046965] lkdtm: the erased part begins after 1440 not poisoned bytes
| [   24.047562] lkdtm: OK: the rest of the thread stack is properly erased
| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| [   24.481889] lkdtm: Performing direct entry STACKLEAK_ERASING
| [   24.482682] lkdtm: checking unused part of the thread stack (15480 bytes)...
| [   24.483361] lkdtm: the erased part begins after 1440 not poisoned bytes
| [   24.483994] lkdtm: OK: the rest of the thread stack is properly erased
| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| [   24.930625] lkdtm: Performing direct entry STACKLEAK_ERASING
| [   24.931168] lkdtm: checking unused part of the thread stack (15480 bytes)...
| [   24.931914] lkdtm: the erased part begins after 1440 not poisoned bytes
| [   24.932404] lkdtm: OK: the rest of the thread stack is properly erased
| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| [   25.351606] lkdtm: Performing direct entry STACKLEAK_ERASING
| [   25.352181] lkdtm: checking unused part of the thread stack (15480 bytes)...
| [   25.352827] lkdtm: the erased part begins after 1440 not poisoned bytes
| [   25.353496] lkdtm: OK: the rest of the thread stack is properly erased
| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| [   25.762500] lkdtm: Performing direct entry STACKLEAK_ERASING
| [   25.762970] lkdtm: checking unused part of the thread stack (15480 bytes)...
| [   25.763396] lkdtm: the erased part begins after 1440 not poisoned bytes
| [   25.763789] lkdtm: OK: the rest of the thread stack is properly erased
| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| [   26.157349] lkdtm: Performing direct entry STACKLEAK_ERASING
| [   26.157880] lkdtm: checking unused part of the thread stack (15480 bytes)...
| [   26.158381] lkdtm: the erased part begins after 1440 not poisoned bytes
| [   26.158859] lkdtm: OK: the rest of the thread stack is properly erased
| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| [   26.527798] lkdtm: Performing direct entry STACKLEAK_ERASING
| [   26.528621] lkdtm: checking unused part of the thread stack (15480 bytes)...
| [   26.529451] lkdtm: the erased part begins after 1440 not poisoned bytes
| [   26.530654] lkdtm: FAIL: bad value number 197 in the erased part: 0xffff8000083d3670
| [   26.531246] lkdtm: FAIL: bad value number 198 in the erased part: 0xaea4d638c4322298
| [   26.531760] lkdtm: FAIL: bad value number 199 in the erased part: 0xffff8000083d3670
| [   26.532219] lkdtm: FAIL: bad value number 200 in the erased part: 0xdead000000000122
| [   26.532640] lkdtm: FAIL: bad value number 201 in the erased part: 0x0
| [   26.532991] lkdtm: FAIL: bad value number 202 in the erased part: 0xdead000000000122
| [   26.533412] lkdtm: FAIL: bad value number 203 in the erased part: 0x101
| [   26.533773] lkdtm: FAIL: bad value number 204 in the erased part: 0xffff2f22033d0000
| [   26.535385] lkdtm: FAIL: bad value number 205 in the erased part: 0xffff8000083d3650
| [   26.536150] lkdtm: FAIL: bad value number 206 in the erased part: 0x2fc3d638c4321e2c
| [   26.536798] lkdtm: FAIL: bad value number 207 in the erased part: 0xffffd638c61c3880
| [   26.537487] lkdtm: FAIL: bad value number 208 in the erased part: 0xffff2f227fbd4878
| [   26.538444] lkdtm: FAIL: bad value number 209 in the erased part: 0xffff8000083d3600
| [   26.539094] lkdtm: FAIL: bad value number 210 in the erased part: 0xfd5d638c4311244
| [   26.539736] lkdtm: FAIL: bad value number 211 in the erased part: 0xffffd638c6139a38
| [   26.540383] lkdtm: FAIL: bad value number 212 in the erased part: 0x0
| [   26.540919] lkdtm: FAIL: bad value number 213 in the erased part: 0x0
| [   26.541458] lkdtm: FAIL: bad value number 214 in the erased part: 0x3eb4d638c43111dc
| [   26.542399] lkdtm: FAIL: bad value number 215 in the erased part: 0xfffffcbc880fa8c0
| [   26.543051] lkdtm: FAIL: bad value number 216 in the erased part: 0xffff2f2203ea3100
| [   26.543698] lkdtm: FAIL: bad value number 217 in the erased part: 0xffff2f2202817500
| [   26.544353] lkdtm: FAIL: bad value number 218 in the erased part: 0xe184d638c447df3c
| [   26.545004] lkdtm: FAIL: bad value number 219 in the erased part: 0xffff8000083d3600
| [   26.545652] lkdtm: FAIL: bad value number 220 in the erased part: 0xffff2f22033d0000
| [   26.546571] lkdtm: FAIL: bad value number 221 in the erased part: 0xffff2f227fbd3b80
| [   26.547110] lkdtm: FAIL: bad value number 222 in the erased part: 0xc5d1d638c42cb164
| [   26.547643] lkdtm: FAIL: bad value number 223 in the erased part: 0xffff8000083d35a0
| [   26.548180] lkdtm: FAIL: bad value number 224 in the erased part: 0x2f94d638c42cb150
| [   26.548716] lkdtm: FAIL: bad value number 225 in the erased part: 0xffff8000083d35a0
| [   26.549263] lkdtm: FAIL: bad value number 226 in the erased part: 0xffff2f22033d0000
| [   26.549798] lkdtm: FAIL: bad value number 227 in the erased part: 0xffffd638c61c3880
| [   26.550684] lkdtm: FAIL: bad value number 228 in the erased part: 0x96ccd638c4477ac8
| [   26.551216] lkdtm: FAIL: bad value number 229 in the erased part: 0xffff8000083d35a0
| [   26.551754] lkdtm: FAIL: bad value number 230 in the erased part: 0x99abd638c4499888
| [   26.552289] lkdtm: FAIL: bad value number 231 in the erased part: 0xffff8000083d3580
| [   26.552821] lkdtm: FAIL: bad value number 232 in the erased part: 0x6ccd638c447e0e0
| [   26.553348] lkdtm: FAIL: bad value number 233 in the erased part: 0xffff8000083d3600
| [   26.554135] lkdtm: FAIL: bad value number 234 in the erased part: 0xffff2f227fbd3b00
| [   26.554674] lkdtm: FAIL: bad value number 235 in the erased part: 0xffff2f220288ba00
| [   26.555210] lkdtm: FAIL: bad value number 236 in the erased part: 0x3da6d638c42c1e34
| [   26.555739] lkdtm: FAIL: bad value number 237 in the erased part: 0xffff8000083d3540
| [   26.556271] lkdtm: FAIL: bad value number 238 in the erased part: 0xc0
| [   26.556723] lkdtm: FAIL: bad value number 239 in the erased part: 0x0
| [   26.557182] lkdtm: FAIL: bad value number 240 in the erased part: 0xffff2f220288ba00
| [   26.557719] lkdtm: FAIL: bad value number 241 in the erased part: 0xffff2f227fbd3b00
| [   26.558478] lkdtm: FAIL: bad value number 242 in the erased part: 0xf882d638c447a134
| [   26.558944] lkdtm: FAIL: bad value number 243 in the erased part: 0xffff8000083d3530
| [   26.559407] lkdtm: FAIL: bad value number 244 in the erased part: 0x14bcd638c4494bf4
| [   26.559862] lkdtm: FAIL: bad value number 245 in the erased part: 0xffff8000083d3510
| [   26.560320] lkdtm: FAIL: bad value number 246 in the erased part: 0x33a7d638c44939c4
| [   26.560774] lkdtm: FAIL: bad value number 247 in the erased part: 0xffff8000083d34e0
| [   26.561227] lkdtm: FAIL: bad value number 248 in the erased part: 0x1
| [   26.561606] lkdtm: FAIL: bad value number 249 in the erased part: 0xffff2f22028701b0
| [   26.562293] lkdtm: FAIL: bad value number 250 in the erased part: 0xfff3d638c448fb6c
| [   26.562753] lkdtm: FAIL: bad value number 251 in the erased part: 0xffff8000083d34c0
| [   26.563206] lkdtm: FAIL: bad value number 252 in the erased part: 0x1
| [   26.563596] lkdtm: FAIL: bad value number 253 in the erased part: 0xffff2f22028701b0
| [   26.564055] lkdtm: FAIL: bad value number 254 in the erased part: 0xc3b1d638c448f978
| [   26.564509] lkdtm: FAIL: bad value number 255 in the erased part: 0xffff8000083d34a0
| [   26.564963] lkdtm: FAIL: bad value number 256 in the erased part: 0x4399d638c42c1cec
| [   26.565420] lkdtm: FAIL: bad value number 257 in the erased part: 0xffff8000083d34b0
| [   26.566045] lkdtm: FAIL: bad value number 258 in the erased part: 0xffff2f227fbd3b80
| [   26.566507] lkdtm: FAIL: bad value number 259 in the erased part: 0xffff2f220288ba80
| [   26.566965] lkdtm: FAIL: bad value number 260 in the erased part: 0xe9e9d638c42cca74
| [   26.567421] lkdtm: FAIL: bad value number 261 in the erased part: 0xffff8000083d34b0
| [   26.567821] lkdtm: FAIL: bad value number 262 in the erased part: 0xffff2f220288ba80
| [   26.568221] lkdtm: FAIL: bad value number 263 in the erased part: 0xffff2f227fbd3b80
| [   26.568620] lkdtm: FAIL: bad value number 264 in the erased part: 0xf697d638c42cb164
| [   26.569015] lkdtm: FAIL: bad value number 265 in the erased part: 0xffff8000083d3450
| [   26.569410] lkdtm: FAIL: bad value number 266 in the erased part: 0x47e5d638c42cb150
| [   26.569947] lkdtm: FAIL: bad value number 267 in the erased part: 0xffff8000083d3450
| [   26.570391] lkdtm: FAIL: bad value number 268 in the erased part: 0xf0b1d638c447ad28
| [   26.570788] lkdtm: FAIL: bad value number 269 in the erased part: 0xffff8000083d3430
| [   26.571189] lkdtm: FAIL: the thread stack is NOT properly erased!

Thanks,
Mark.

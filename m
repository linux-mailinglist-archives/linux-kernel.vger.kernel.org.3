Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D6B49DFDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbiA0Kyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiA0Kyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:54:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41914C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:54:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JkyCS74VSz4xNm;
        Thu, 27 Jan 2022 21:54:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1643280885;
        bh=5lIaVIE45bKk0MuhVgUEHyZpIklqveSec/luVC/AxhQ=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=QKs/rB31RreZtBU21tuy5vImut9RZ/88u/OsWhz1NO9DBxPqQsc2i3L/K81ygbrVW
         Py0fDRwCI6/VHui5vRW61oQqiB4I620Sn6cZZ8K508dMnq0khAhVw1EpAhgBBWZNYc
         q9jZM73cwECdChuqejJGrTvv2iscbusCvOrZQHvmh5dShpUJLyPQxQYE+jmMackuHf
         L66S9nnD+rhaq2OdZ1y5yaPWQVw0MgvxRsUlPQ3I+vPbmRuBjYzksTBf1EpAH9iBPn
         Y/9OgoPZSP0fz/uZBc3JpIZ6lsDFAaRoQvQVOKdIYFSqq+HsF03LPG0sQ68vl2JvVm
         N6k9kXG8LLFAw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ppc: hard lockup / hang in v5.17-rc1 under QEMU
In-Reply-To: <CANiq72n_FmDx=r-o9J8gYc6LpwRL5EGmhM6Xzwv27Xc7h1TNDw@mail.gmail.com>
References: <CANiq72n_FmDx=r-o9J8gYc6LpwRL5EGmhM6Xzwv27Xc7h1TNDw@mail.gmail.com>
Date:   Thu, 27 Jan 2022 21:54:39 +1100
Message-ID: <871r0tmosw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:
> Hi PPC folks,
>
> Our ppc64le CI deterministically triggers a hard lockup / hang under
> QEMU since v5.17-rc1 (upgrading from v5.16).
>
> Bisecting points to 0faf20a1ad16 ("powerpc/64s/interrupt: Don't enable
> MSR[EE] in irq handlers unless perf is in use").

Hi Miguel,

Thanks for the report.

Nick has posted one fix for the commit you identified:

  http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20220124143930.3923442-1-npiggin@gmail.com/


It looks like your kernel-ppc64le-release.config does not have the
hardlockup detector enabled, so I suspect you're hitting the bug
described in that patch.

That fix will hit linux-next in the next day or so and should be in rc2.

cheers

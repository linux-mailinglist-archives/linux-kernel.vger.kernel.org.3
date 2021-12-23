Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BCB47E152
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347679AbhLWKVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbhLWKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:21:14 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A965FC061401;
        Thu, 23 Dec 2021 02:21:14 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d10so15029238ybe.3;
        Thu, 23 Dec 2021 02:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KsIOojEX08aWCewXg//rXmzHnn7mySZCYR+v7sS+FY4=;
        b=Wa2LpEvof2ondCIqXxDyABniFVWbQVENcZwSGEP8lok7abdGSB2qfjYwbtpF42Ea/v
         TrlJALAgRvrAeNSkgHpisCZeSUQUzM0Lyfp3RGwPprOm29/BDMM2oEQCTGDfoDPjoTI4
         9OhOXA2cx5BAbgYO/GAgRBJHB0gtJ+pLmc5gpJv5MsEZ1eSCMkAJ3XnC8rwqMRTPFcNH
         4i3VElIXcZdVGpJwrd/Ucj/Y7ONIR8rPYdgxqePGH+qRMcBEVC8X4wuNrnTWy4z41pxv
         k/PzRvPHFj8MK8IEs1IaYDBqPF+8kIavD+YA3gsrtGR4TOnepPUxKXG+4otjWrXCRkwf
         uxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KsIOojEX08aWCewXg//rXmzHnn7mySZCYR+v7sS+FY4=;
        b=EVLWhySsMQeDNk/idLy0qasxcpkoxPPMTvJkpO7xyxyyvhEflebfxTlIKVUhuyfE6d
         DI0NBLd9YUVevQ1mBexz28A1FCzUy4eqQYfnCXSBMpCeFP2sez0TprdiL+47cqxKqpwe
         /6IP8AmXOsumckuxUuNYblAY6yAVPp6BeHTnQu6ihtEYxai1Jv3p68CegJlII10I9XHy
         qDXS1QMKOX6VcLpe9sEcHLqdMk/RWUopEOyrsdYAY/mmSuhtKVMkljT+ekZbFXE+lAUP
         GJxwH6GhvLAYbpDylKgi4KQxqnfs4ioBY5+dQITxmtZxax5TvvDLErpwmiNhvIAy+Pro
         Muxw==
X-Gm-Message-State: AOAM533L4wRdN0gSt0Mgagkdp0hK7sdQ2NLZ3XXBWs+HNBhTA72RXgGx
        eC2TWygKDxLADteWiPsJI1QmPNJ3vqhG9j3ebns=
X-Google-Smtp-Source: ABdhPJwXP0cYtdT8YXvq84jv2kX03nIHs5jmPaQNQMbpX3WzXkgAWIGsBTcOhtCkpjUSaZCq7wGhyXpac3FTXMMywAE=
X-Received: by 2002:a25:cad5:: with SMTP id a204mr2537986ybg.234.1640254873841;
 Thu, 23 Dec 2021 02:21:13 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 23 Dec 2021 11:21:03 +0100
Message-ID: <CAKXUXMxa6zuTncNjTVHeU7nJ9uvv3KqMtSDocMC7P5hxfrkakQ@mail.gmail.com>
Subject: code conditional on non-existing PPC_EARLY_DEBUG_MICROWATT.
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Benjamin, dear Paul, dear Michael,

with commit 48b545b8018d ("powerpc/microwatt: Use standard 16550 UART
for console"), you have some code in arch/powerpc/kernel/udbg_16550.c,
conditional on the Kconfig symbol PPC_EARLY_DEBUG_MICROWATT. However,
since then, the definition of this Kconfig symbol was never introduced
to the mainline repository or current linux-next, nor am I finding any
pending patch for that.

Are you going to add this config definition soon? Or did you identify
that this setup code in udbg_16550.c is not actually needed and can we
simply drop this code again?

This issue was identified with the script ./scripts/checkkconfigsymbols.py.


Best regards,

Lukas

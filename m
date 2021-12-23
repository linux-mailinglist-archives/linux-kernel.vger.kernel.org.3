Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97F847E1F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347856AbhLWLF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:05:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42938 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239611AbhLWLFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:05:55 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14F9A1EC058C;
        Thu, 23 Dec 2021 12:05:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640257550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mjlpL30YRZjpB7+65FML0QnfEiaj5dKWWL+9Ghjy3ok=;
        b=jIaG5S11ItoSZM6KfQVnCBVUhMxTrHBPAQyF7sHSo4Fea+SuMS8qXHk2vqnI2/Cle9Uowm
        1wG0burx1LaOzE0rF0nXR2SCoW07MnC8sGpGrQGulS5t5PvJc6GJJFaJPAFE2HiIHILHLz
        nIQSeyybIEvpkFrrSKcdgsqXxS7cFFU=
Date:   Thu, 23 Dec 2021 12:05:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH RESEND v2] x86: warn on native_io_delay() before DMI scan
Message-ID: <YcRYD9drK5lRgEyY@zn.tnic>
References: <20211017192558.266809-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211017192558.266809-1-mat.jonczyk@o2.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 09:25:58PM +0200, Mateusz Jończyk wrote:
> Writing to IO port 0x80 in native_io_delay() causes system lockups on
> some laptops. This is handled by io_delay_init(), which scans DMI info
> and changes io_delay_type on these laptops.
> 
> Therefore, calling native_io_delay() / outb_p() / inb_p() / etc. before
> io_delay_init() may cause problems there and may constitute a kernel
> bug. Warn if this happens.

When/how does this happen?

io_delay_init() gets called pretty early in setup_arch()...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D783D46E61D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhLIKGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:06:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57892 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229758AbhLIKGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:06:43 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 200A81EC04D3;
        Thu,  9 Dec 2021 11:03:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639044185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=o6pF0A5Tdv1+e43SYjUNncgg3DcM/4rxW10BaPhOwpQ=;
        b=rxE77cpC9ES/A4+ihCQHcJBe2Sk0WPU/prRMyY8myeyUeRaURG9H6hT2Qrk8DatfcUeCYb
        K1gktB7t/+qZgSCt4KbY1ZBzabKLq/OXnuz2Gww/FHl9i6jUWohKPgSBYYEezjNVn0eTNT
        hLWDxlpRb77A24Oxep87OZ4mq2QTHbc=
Date:   Thu, 9 Dec 2021 11:03:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hugh Dickins <hughd@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Anjaneya Chagam <anjaneya.chagam@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: 5.16-rc: "x86/boot: Pull up cmdline" breaks mem=
Message-ID: <YbHUW1KTfvJtxNwP@zn.tnic>
References: <ae2bb14d-d27a-e76d-adde-ef888d373343@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae2bb14d-d27a-e76d-adde-ef888d373343@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Wed, Dec 08, 2021 at 09:44:54PM -0800, Hugh Dickins wrote:
> Bad news, I'm afraid: I boot with "mem=1G" on the cmdline for testing,
> which worked fine on 5.16-rc1, but does not work on 5.16-rc2 onwards.
>
> Bisection arrived at 8d48bf8206f7 ("x86/boot: Pull up cmdline preparation
> and early param parsing"); and reverting c0f2077baa41 ("x86/boot: Mark
> prepare_command_line() __init") then 8d48bf820cf7 does fix my "mem=1G".

Yeah, I had a bug reporter report breaking on his machine but he didn't
respond to my request for additional details.

Can you pls send me full dmesg and .config of the -rc1 kernel which
still boots fine. I'd like to try to repro.

> I have not tried 5.15-stable, but guess that is likewise afflicted.

Right.

> Sympathy, but no suggestions from me: early init ordering is hard!

Tell me about it! This is the 4 or so "fix" which tries to address
fallout from Mike and mine's attempt to sort out memblock ordering
during early boot.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

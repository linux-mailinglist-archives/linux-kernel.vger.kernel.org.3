Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD84A4DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbiAaSS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343549AbiAaSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:18:55 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AC2C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:18:55 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 760271EC0535;
        Mon, 31 Jan 2022 19:18:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643653129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Q9K9UXWajSKZwi1PFGnCmJIzbUpD/dJNvx51ODbzBrQ=;
        b=kpwwhdBqkNpcmF8GexK6EoSVFDf+ir7oCVErixKSaglXyfJkoT6kdCsjYMIPS9jfa2f4s4
        5l62lgq02rsoXUU0p7kV/BhfHfCk994KLOhvWTY86nbsjHuQPVFaBPyfLDcN++lgY5wUte
        y40CylvE+XI3Ifgoe21gR51P480Xsso=
Date:   Mon, 31 Jan 2022 19:18:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH v2 0/6] PPIN (Protected Processor Inventory Number)
 updates
Message-ID: <YfgoBgwgfoiKkPa9@zn.tnic>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220121174743.1875294-1-tony.luck@intel.com>
 <YffWtTq2y6K8+gHF@zn.tnic>
 <YfgbCFNeNEkypCmC@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfgbCFNeNEkypCmC@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 09:23:20AM -0800, Luck, Tony wrote:
> I'm worried that some future thing might reverse that and have
> a "package" id for each die in a multi-die package which still
> appears as a single node. That would distort the meaning of "package",
> so it isn't supposed to happen. But if it did, Linux would be stuck
> just reporting one of the "package" ids.

Hmm, so we write that we don't really care about the physical socket in
software:

Documentation/x86/topology.rst:
"The kernel does not care about the concept of physical sockets because
a socket has no relevance to software. It's an electromechanical
component. In the past a socket always contained a single package
(see below), but with the advent of Multi Chip Modules (MCM) a socket
can hold more than one package. So there might be still references to
sockets in the code, but they are of historical nature and should be
cleaned up."

and the PPIN is a physical socket property. So there's no proper way for
us to tie to anything that represents the physical socket.

So, the use case you're imagining would be, what?

The FRU code glue would go:

"I got an MCE on CPU X...

Lemme see which PPIN is it:

# cat /sys/devices/system/cpu/cpuX/topology/ppin
BLA

ah ok, lemme report it:

You just had an MCE on CPU X, socket BLA"

Something like that?

But that FRU glue software would have to run as root so that it reads
the ppin sysfs file.

But we don't want to expose that processor serial number to !root users
so we're forcing the people to run the FRU thing as root.

This feels like this guy here:

https://c.tenor.com/fDZOE4okO3EAAAAC/homer-simpsons.gif

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8495C483EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiADJEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiADJEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:04:06 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C912C061761;
        Tue,  4 Jan 2022 01:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LIpGUA+BIUuIAA5mn06eiD0IWkKRl9vPozuSU1YrjFw=;
        t=1641287046; x=1642496646; b=SF3yFNpMOZiMSIMDEKf8NpaBYrj1BVzrdHa0lJj+lLLZ9gR
        CAUahblriIFZxAfzf0KOnJYktn8RggvQDIqFvfd4nekQBo6gFnWqiusk8B9xPceO2DiPF0IwcZ0PO
        ouZzeEgVP/inR5ypXCFSvNWG5v/d5I3CwQ3jEThGmkbv6JjPzZYH0yjLlkLrZJMSf62+8+PO1l4nT
        kMIh7gRy/i3yzfqz/vmwX4hTGNIr9i1kdRmOQbHYvp8QzumQqN9xBzi9SBcJSKgKTAdagMnIRz2cd
        J1IYN4+8XpLpNVR+dggwhwhR5/diXH6zca3M2qPoPrjofPM/U4u94a/yqek9icWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n4fjg-001het-NC;
        Tue, 04 Jan 2022 10:04:04 +0100
Message-ID: <0523cc8788bfe47ffba185d0436a7c77c85c6e4c.camel@sipsolutions.net>
Subject: Re: Build regressions/improvements in v5.16-rc7
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Date:   Tue, 04 Jan 2022 10:04:03 +0100
In-Reply-To: <alpine.DEB.2.22.394.2112271142250.1704790@ramsan.of.borg>
References: <20211227083126.1153239-1-geert@linux-m68k.org>
         <alpine.DEB.2.22.394.2112271142250.1704790@ramsan.of.borg>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-27 at 11:44 +0100, Geert Uytterhoeven wrote:
> 
> sparc64-gcc11/sparc-allmodconfig
> 
>    + /kisskb/src/drivers/video/fbdev/nvidia/nvidia.c: error: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]:  => 1439:10, 1414:10
> 

This should be fixed by

commit 5f174ec3c1d62013f86db6597249174d8cb227b2
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Sep 20 21:32:49 2021 +0000

    logic_io instance of iounmap() needs volatile on argument


when it lands.

johannes

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DB0507986
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354906AbiDSTA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiDSTAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:00:52 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490D03EF0A;
        Tue, 19 Apr 2022 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Bp4bwe3H7WczeFj56jWpI8QBoijIjdBXfNXBKn0bveA=; b=BnjvFkL1Ut5niN1GJU9Qqiqxk6
        bSPHAiXL02AryU4BQbQpKlkwkXIt6mnpaGai1EkMfb0N77GoGMiPu82Wt1d4/+QTWXcjmBV6Ku7ag
        5hFnENghTqRcnVGh//6lZ3HUdy935pKzoa0T5tTd6a06gSHsV+1rn8Io1dCb+FjgCxRGlfV1yw4Y7
        cXkAHqXV7UtAWVHSPZreuF+Fv6h6X24hK0ekZ6grYTMiEtvlDlP9dUvb31vc66WRUZZTLiANfU0Sd
        ijIbnGbDawioK8ZKRXJzI4YrOxtoaUSi1Hwf0K71Z6Ka7hBoV/5ziHXVUw7oTmuDiI0mQAuI0pLBc
        s6mPA9Zw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58334)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ngt2s-0001Sk-I9; Tue, 19 Apr 2022 19:57:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ngt2g-00011J-Hx; Tue, 19 Apr 2022 19:57:38 +0100
Date:   Tue, 19 Apr 2022 19:57:38 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        max.krummenacher@toradex.com, Shawn Guo <shawnguo@kernel.org>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [next] arm: boot failed - PC is at cpu_ca15_set_pte_ext
Message-ID: <Yl8GInPZyl2PqK7D@shell.armlinux.org.uk>
References: <CA+G9fYuACgY2hcAgh_LwVb9AURjodMJbV6SsJb90wj-0aJKUOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuACgY2hcAgh_LwVb9AURjodMJbV6SsJb90wj-0aJKUOw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 04:28:52PM +0530, Naresh Kamboju wrote:
> Linux next 20220419 boot failed on arm architecture qemu_arm and BeagleBoard
> x15 device.

Was the immediately previous linux-next behaving correctly?

If so, nothing has changed in the ARM32 kernel tree, so this must be
someone else's issue - code that someone else has pushed into
linux-next.

It looks to me like someone is walking the page tables incorrectly,
somewhere buried in handle_mm_fault(), because the PTE pointer is in
the upper-2k of a 4k page, which is most definitely illegal on arm32.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

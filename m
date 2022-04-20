Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F341A508528
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377313AbiDTJsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243155AbiDTJsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:48:03 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A6D1F60C;
        Wed, 20 Apr 2022 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sKYagvR6CfauZc5SfVdvqjzzNgqk07AuGu+1B6sV42o=; b=P3YgYiJgq5rd0fveUG035inBvs
        WwVWo3pEOg9TaLW7DaXoNWDFwXJJ+lR0CJw5Wg57IlE2Bs08iJWnBs1YIyz6iITbGVyVQo/xAVO7d
        953xU0+vy5WQjNtJuGjinhvBONG8ZS0++76jD9UYQor+gMcetNSIfSuozs4r5GakMs9wpM1FKc1op
        M1jOEIOQqt3+es6Z+RiQN3lzszW2uw77Mrs1g2PlMY7WXhpmPS+8nPKadqdH1LnZOkQOKNeTJq2d1
        BsGulgEvxejBbyZX67HxKoTginAklK3D1GTaQXiF2FkGINe0jSHMDbDAUq8Q5wLo10xe6oE7N8pC4
        4d7vIrdg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58340)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nh6tW-00025n-JN; Wed, 20 Apr 2022 10:45:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nh6tO-0001h2-TE; Wed, 20 Apr 2022 10:44:58 +0100
Date:   Wed, 20 Apr 2022 10:44:58 +0100
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
Message-ID: <Yl/WGnHXASYSBXct@shell.armlinux.org.uk>
References: <CA+G9fYuACgY2hcAgh_LwVb9AURjodMJbV6SsJb90wj-0aJKUOw@mail.gmail.com>
 <Yl8GInPZyl2PqK7D@shell.armlinux.org.uk>
 <CA+G9fYvRdg6t6OnoJy62Vte5XnSymyL6B6kARC_1Jao52h6ZYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvRdg6t6OnoJy62Vte5XnSymyL6B6kARC_1Jao52h6ZYg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 02:25:32PM +0530, Naresh Kamboju wrote:
> On Wed, 20 Apr 2022 at 00:28, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Apr 19, 2022 at 04:28:52PM +0530, Naresh Kamboju wrote:
> > > Linux next 20220419 boot failed on arm architecture qemu_arm and BeagleBoard
> > > x15 device.
> >
> > Was the immediately previous linux-next behaving correctly?
> 
> This crash started happening from the next-20220413 tag.

That rules out any arm32 specific changes - the last time my tree
changed in for-next was 1st April.

Ard points out that the pte table is on the stack, which it really
should not be. I'm guessing there's some inappropriate generic
kernel change that has broken arm32. A pte table should never ever
appear on a kernel stack.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

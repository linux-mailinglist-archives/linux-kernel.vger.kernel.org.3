Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6189595E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 16:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbiHPOym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbiHPOyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 10:54:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971F761D7B;
        Tue, 16 Aug 2022 07:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C834B81646;
        Tue, 16 Aug 2022 14:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83073C433D6;
        Tue, 16 Aug 2022 14:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660661676;
        bh=yKFsnzw1EkWC0v+w7uDhNcNgjrX28e9te6FlH9rY5gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhiNfPag2m49FMccdwipbtZoOkyKltOcgF/mTUupmGmlKjSohmYcjvR3RWB2eBWwF
         aIVwafKsA9zEO8EEOUWrLQfo/8iHfqZ3/gv3/SrbVkovOn8taPnYOxJu899d1/S2bh
         VQwaiiErgwpU1jX/BXClF3N76/DLyalTiqRpddkdUPTyV4O9SVfv6ORgaDpygGkokd
         fGkfkYzbtSOFi3uqHrNCuxIfdaagJyh98QWGsqDvibjxgx3ItVVQsVNKyYe3jliEzo
         zYdKEsGko5v1ZbfDdBupsqPH9RQnATTl/VY34x2zwZNhzqLSA90yHkziINalLW4WM7
         2bDnoZtOjy96w==
Date:   Tue, 16 Aug 2022 16:54:29 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kishon@ti.com
Cc:     Shunsuke Mie <mie@igel.co.jp>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Fix
 pci_endpoint_test_{copy,write,read}() panic
Message-ID: <Yvuvpd9n59mp96p0@lpieralisi>
References: <20220816100617.90720-1-mie@igel.co.jp>
 <YvtxAN7E4nmZmL/X@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvtxAN7E4nmZmL/X@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 12:27:12PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Aug 16, 2022 at 07:06:17PM +0900, Shunsuke Mie wrote:
> > Although dma_map_single() doesn't permit zero length mapping, the each
> > test functions called the function without zero checking.
> > 
> > A panic was reported on arm64:
> > 
> > [   60.137988] ------------[ cut here ]------------
> > [   60.142630] kernel BUG at kernel/dma/swiotlb.c:624!
> > [   60.147508] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > [   60.152992] Modules linked in: dw_hdmi_cec crct10dif_ce simple_bridge rcar_fdp1 vsp1 rcar_vin videobuf2_vmalloc rcar_csi2 v4l
> > 2_mem2mem videobuf2_dma_contig videobuf2_memops pci_endpoint_test videobuf2_v4l2 videobuf2_common rcar_fcp v4l2_fwnode v4l2_asyn
> > c videodev mc gpio_bd9571mwv max9611 pwm_rcar ccree at24 authenc libdes phy_rcar_gen3_usb3 usb_dmac display_connector pwm_bl
> > [   60.186252] CPU: 0 PID: 508 Comm: pcitest Not tainted 6.0.0-rc1rpci-dev+ #237
> > [   60.193387] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
> > [   60.201302] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [   60.208263] pc : swiotlb_tbl_map_single+0x2c0/0x590
> > [   60.213149] lr : swiotlb_map+0x88/0x1f0
> > [   60.216982] sp : ffff80000a883bc0
> > [   60.220292] x29: ffff80000a883bc0 x28: 0000000000000000 x27: 0000000000000000
> > [   60.227430] x26: 0000000000000000 x25: ffff0004c0da20d0 x24: ffff80000a1f77c0
> > [   60.234567] x23: 0000000000000002 x22: 0001000040000010 x21: 000000007a000000
> > [   60.241703] x20: 0000000000200000 x19: 0000000000000000 x18: 0000000000000000
> > [   60.248840] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0006ff7b9180
> > [   60.255977] x14: ffff0006ff7b9180 x13: 0000000000000000 x12: 0000000000000000
> > [   60.263113] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> > [   60.270249] x8 : 0001000000000010 x7 : ffff0004c6754b20 x6 : 0000000000000000
> > [   60.277385] x5 : ffff0004c0da2090 x4 : 0000000000000000 x3 : 0000000000000001
> > [   60.284521] x2 : 0000000040000000 x1 : 0000000000000000 x0 : 0000000040000010
> > [   60.291658] Call trace:
> > [   60.294100]  swiotlb_tbl_map_single+0x2c0/0x590
> > [   60.298629]  swiotlb_map+0x88/0x1f0
> > [   60.302115]  dma_map_page_attrs+0x188/0x230
> > [   60.306299]  pci_endpoint_test_ioctl+0x5e4/0xd90 [pci_endpoint_test]
> > [   60.312660]  __arm64_sys_ioctl+0xa8/0xf0
> > [   60.316583]  invoke_syscall+0x44/0x108
> > [   60.320334]  el0_svc_common.constprop.0+0xcc/0xf0
> > [   60.325038]  do_el0_svc+0x2c/0xb8
> > [   60.328351]  el0_svc+0x2c/0x88
> > [   60.331406]  el0t_64_sync_handler+0xb8/0xc0
> > [   60.335587]  el0t_64_sync+0x18c/0x190
> > [   60.339251] Code: 52800013 d2e00414 35fff45c d503201f (d4210000)
> > [   60.345344] ---[ end trace 0000000000000000 ]---
> > 
> > To fix it, this patch adds checkings the payload length if it is zero.
> > 
> > Fixes: 343dc693f7b7 ("misc: pci_endpoint_test: Prevent some integer overflows")
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 8f786a225dcf..d45426a73396 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -364,7 +364,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
> >  	}
> >  
> >  	size = param.size;
> > -	if (size > SIZE_MAX - alignment)
> > +	if (size > SIZE_MAX - alignment || !size)
> >  		goto err;
> 
> Can we test size first?  And do it in the ioctl handler in one place so
> you don't have to add it everywhere?
> 
> Or have a "validate all parameters" function that you do it in one
> place?
> 
> Also, all of these ioctl handlers are wrong, they are returning "0" to
> userspace if they fail, which is not correct at all.

This is bad, thanks Greg for spotting it.

@Kishon, we have to fix it asap, please let me know if you
can post a patch promptly.

Lorenzo

> thanks,
> 
> greg k-h
> 

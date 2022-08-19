Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DD3599DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349616AbiHSOxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349609AbiHSOxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:53:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1B3EF00D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:53:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso5094292pjr.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=OzfFfFOXDbyq5fs5hSj2kLJvkNmpW2kv11TMrs1o44s=;
        b=kPekV3MDzzZBzMgPueWnJ/sdMwKerG+8weiirSFULhmGyTjStpvtX0UJoqYgDAn4R8
         E++4p2lYEJ4xU8RqzVFWs3UPaAd9EA/5N9vqIRLJBmcW0NoqQ072500CWE0Cy34pe9S/
         y70jUTQZC1tkwPrgM9/CJsv+TRbK+jMiWLr3NM2E+4fz2/08InzUOqlLin5SvGwQ/RSt
         wf12H91qTB6RmaTA3qxymwE4E8fiGPtr6bqeT0N7iR9IL2xDiDraVDtfCqm8WyZZ7Swl
         AX2oPnPi8NszsJSOrVImRh2zCkelmUPQLU0dWYeJuIxfhwhtr1xXIU6JxFZZUfvDI88L
         Smvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=OzfFfFOXDbyq5fs5hSj2kLJvkNmpW2kv11TMrs1o44s=;
        b=0fin+RUFOt1/PNZdD4L+rgm+vrexFb9XKWdcgAz6pnEOyQmtc58og/k69wuRefwYvB
         10NUOexJElyHk8airSZ30Lr9bN8BsPvGujpnv4kzK5bT+raksk9/or/6FWJ1QED1h2Cu
         jfGFGSqeIgKIR3HBBkCv9rBor8ps7s2FG/m8ZarNIj1bOzGZoF8rSZLNy6hft0kPnkkV
         4L35wt6sGoabVH0WgB3Pkill20NHaFYOY/I1rCogQWNSHliO1SWkXeBnDLXxL06Et8aS
         84TPu1jeLzESCS7hPtdcoLTlngqTAhDN+SMMWSN2Wlf41eqTEG5jOjcOh8gjnXL0QF+7
         NWMg==
X-Gm-Message-State: ACgBeo31Ktcmg7AMVpz28XQS4EULeJKYa4bGwkr2SFoKIgXKjo4veXtp
        KwzVzm02roJU1aiwI13Ci3Ar
X-Google-Smtp-Source: AA6agR7F+3kzjmmug6+gBvxH7857Gj60mhCrlHxSeiYw2b/Xb0puZlAyDhMP3BEkdn9A3poYN/1xVg==
X-Received: by 2002:a17:90b:605:b0:1fa:b5c5:3449 with SMTP id gb5-20020a17090b060500b001fab5c53449mr13359463pjb.103.1660920782295;
        Fri, 19 Aug 2022 07:53:02 -0700 (PDT)
Received: from thinkpad ([117.217.188.127])
        by smtp.gmail.com with ESMTPSA id 22-20020a630d56000000b0041c66a66d41sm2923485pgn.45.2022.08.19.07.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:53:01 -0700 (PDT)
Date:   Fri, 19 Aug 2022 20:22:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Shunsuke Mie <mie@igel.co.jp>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Fix
 pci_endpoint_test_{copy,write,read}() panic
Message-ID: <20220819145253.GA35978@thinkpad>
References: <20220816100617.90720-1-mie@igel.co.jp>
 <YvtxAN7E4nmZmL/X@kroah.com>
 <Yvuvpd9n59mp96p0@lpieralisi>
 <695ab9b3-8385-e8bd-0095-14b07de66b15@ti.com>
 <YvzNg5ROnxEApDgS@kroah.com>
 <632f447c-fe1a-e6aa-2fda-73669964fc92@ti.com>
 <20220819105255.GD215264@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220819105255.GD215264@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 04:23:03PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Aug 19, 2022 at 04:08:13PM +0530, Kishon Vijay Abraham I wrote:
> > +Mani
> > 
> > On 17/08/22 16:44, Greg Kroah-Hartman wrote:
> > > On Wed, Aug 17, 2022 at 02:18:58PM +0530, Kishon Vijay Abraham I wrote:
> > >> Hi Lorenzo,
> > >>
> > >> On 16/08/22 20:24, Lorenzo Pieralisi wrote:
> > >>> On Tue, Aug 16, 2022 at 12:27:12PM +0200, Greg Kroah-Hartman wrote:
> > >>>> On Tue, Aug 16, 2022 at 07:06:17PM +0900, Shunsuke Mie wrote:
> > >>>>> Although dma_map_single() doesn't permit zero length mapping, the each
> > >>>>> test functions called the function without zero checking.
> > >>>>>
> > >>>>> A panic was reported on arm64:
> > >>>>>
> > >>>>> [   60.137988] ------------[ cut here ]------------
> > >>>>> [   60.142630] kernel BUG at kernel/dma/swiotlb.c:624!
> > >>>>> [   60.147508] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > >>>>> [   60.152992] Modules linked in: dw_hdmi_cec crct10dif_ce simple_bridge rcar_fdp1 vsp1 rcar_vin videobuf2_vmalloc rcar_csi2 v4l
> > >>>>> 2_mem2mem videobuf2_dma_contig videobuf2_memops pci_endpoint_test videobuf2_v4l2 videobuf2_common rcar_fcp v4l2_fwnode v4l2_asyn
> > >>>>> c videodev mc gpio_bd9571mwv max9611 pwm_rcar ccree at24 authenc libdes phy_rcar_gen3_usb3 usb_dmac display_connector pwm_bl
> > >>>>> [   60.186252] CPU: 0 PID: 508 Comm: pcitest Not tainted 6.0.0-rc1rpci-dev+ #237
> > >>>>> [   60.193387] Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
> > >>>>> [   60.201302] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > >>>>> [   60.208263] pc : swiotlb_tbl_map_single+0x2c0/0x590
> > >>>>> [   60.213149] lr : swiotlb_map+0x88/0x1f0
> > >>>>> [   60.216982] sp : ffff80000a883bc0
> > >>>>> [   60.220292] x29: ffff80000a883bc0 x28: 0000000000000000 x27: 0000000000000000
> > >>>>> [   60.227430] x26: 0000000000000000 x25: ffff0004c0da20d0 x24: ffff80000a1f77c0
> > >>>>> [   60.234567] x23: 0000000000000002 x22: 0001000040000010 x21: 000000007a000000
> > >>>>> [   60.241703] x20: 0000000000200000 x19: 0000000000000000 x18: 0000000000000000
> > >>>>> [   60.248840] x17: 0000000000000000 x16: 0000000000000000 x15: ffff0006ff7b9180
> > >>>>> [   60.255977] x14: ffff0006ff7b9180 x13: 0000000000000000 x12: 0000000000000000
> > >>>>> [   60.263113] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> > >>>>> [   60.270249] x8 : 0001000000000010 x7 : ffff0004c6754b20 x6 : 0000000000000000
> > >>>>> [   60.277385] x5 : ffff0004c0da2090 x4 : 0000000000000000 x3 : 0000000000000001
> > >>>>> [   60.284521] x2 : 0000000040000000 x1 : 0000000000000000 x0 : 0000000040000010
> > >>>>> [   60.291658] Call trace:
> > >>>>> [   60.294100]  swiotlb_tbl_map_single+0x2c0/0x590
> > >>>>> [   60.298629]  swiotlb_map+0x88/0x1f0
> > >>>>> [   60.302115]  dma_map_page_attrs+0x188/0x230
> > >>>>> [   60.306299]  pci_endpoint_test_ioctl+0x5e4/0xd90 [pci_endpoint_test]
> > >>>>> [   60.312660]  __arm64_sys_ioctl+0xa8/0xf0
> > >>>>> [   60.316583]  invoke_syscall+0x44/0x108
> > >>>>> [   60.320334]  el0_svc_common.constprop.0+0xcc/0xf0
> > >>>>> [   60.325038]  do_el0_svc+0x2c/0xb8
> > >>>>> [   60.328351]  el0_svc+0x2c/0x88
> > >>>>> [   60.331406]  el0t_64_sync_handler+0xb8/0xc0
> > >>>>> [   60.335587]  el0t_64_sync+0x18c/0x190
> > >>>>> [   60.339251] Code: 52800013 d2e00414 35fff45c d503201f (d4210000)
> > >>>>> [   60.345344] ---[ end trace 0000000000000000 ]---
> > >>>>>
> > >>>>> To fix it, this patch adds checkings the payload length if it is zero.
> > >>>>>
> > >>>>> Fixes: 343dc693f7b7 ("misc: pci_endpoint_test: Prevent some integer overflows")
> > >>>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > >>>>> ---
> > >>>>>  drivers/misc/pci_endpoint_test.c | 6 +++---
> > >>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
> > >>>>>
> > >>>>> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > >>>>> index 8f786a225dcf..d45426a73396 100644
> > >>>>> --- a/drivers/misc/pci_endpoint_test.c
> > >>>>> +++ b/drivers/misc/pci_endpoint_test.c
> > >>>>> @@ -364,7 +364,7 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test,
> > >>>>>  	}
> > >>>>>  
> > >>>>>  	size = param.size;
> > >>>>> -	if (size > SIZE_MAX - alignment)
> > >>>>> +	if (size > SIZE_MAX - alignment || !size)
> > >>>>>  		goto err;
> > >>>>
> > >>>> Can we test size first?  And do it in the ioctl handler in one place so
> > >>>> you don't have to add it everywhere?
> > >>>>
> > >>>> Or have a "validate all parameters" function that you do it in one
> > >>>> place?
> > >>>>
> > >>>> Also, all of these ioctl handlers are wrong, they are returning "0" to
> > >>>> userspace if they fail, which is not correct at all.
> > >>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/pci/pcitest.c
> > >>> This is bad, thanks Greg for spotting it.
> > >>>
> > >>> @Kishon, we have to fix it asap, please let me know if you
> > >>> can post a patch promptly.
> > >>
> > >> The userspace tool (pcitest [1]) that calls these IOCTLS prints "NOT
> > >> OKAY" on 0 and "OKAY" for 1.
> > >>
> > >> I'll change to negative value for error and still keep '0' for data
> > >> mismatch error?
> > > 
> > > No, 0 as a return value from a system call means "success".  You can not
> > > redefine it to mean something else for a tiny single kernel driver,
> > > otherwise so much for consistency.
> > > 
> > > 0 is success, -ERROR_NUMBER is an error, please read the ioctl man page.
> > 
> > Thanks Greg!
> > 
> > Mani, Would you be able to post a patch fixing it? If not I'll post it
> > mid next week.
> > 
> 
> Will do!
> 

Done! But I haven't fixed the size issue that _this_ patch fixes. I'll leave it
up to Shunsuke.

Thanks,
Mani

> Thanks,
> Mani
> 
> > Regards,
> > Kishon
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

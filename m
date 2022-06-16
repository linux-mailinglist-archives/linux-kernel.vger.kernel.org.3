Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E1454DCF9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359231AbiFPIfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiFPIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:35:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B643B5DA75;
        Thu, 16 Jun 2022 01:35:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 518CB61D64;
        Thu, 16 Jun 2022 08:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33D6C34114;
        Thu, 16 Jun 2022 08:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655368502;
        bh=kwIjgcV2Tp1xTcd80hF7hfCHlu1DDrD34AyzJST/7Fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+i8B9G5RU2vfNVnueCyqmTiJxwxq906Ujc60TuMSfVt8s5tRYUFqw4bAz+00K589
         OhqmByGvuEuPYvr9NQ6ZAi98i8O7QJKdsKRLG5VTMKQO48FoF4ixMNuM9I8r6ZwKjp
         0ytMxc1udqCAxAyP25u135ff5p9JF9g6IJQ7H/rE=
Date:   Thu, 16 Jun 2022 10:34:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6LCi5rOT5a6H?= <xiehongyu1@kylinos.cn>
Cc:     Hongyu Xie <xy521521@gmail.com>, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        125707942@qq.com, wangqi@kylinos.cn, xiongxin@kylinos.cn,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 -next] usb: xhci: disable irq during initialization
Message-ID: <YqrrMjnvtLVqUtjg@kroah.com>
References: <20220616080933.1238309-1-xiehongyu1@kylinos.cn>
 <Yqrl3jGyUx7sZVdL@kroah.com>
 <ab92690c-c3ee-ab92-5763-376db208aebb@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab92690c-c3ee-ab92-5763-376db208aebb@kylinos.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 04:24:08PM +0800, 谢泓宇 wrote:
> Hi greg,
> 
> On 2022/6/16 16:12, Greg KH wrote:
> > On Thu, Jun 16, 2022 at 04:09:33PM +0800, Hongyu Xie wrote:
> > > irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
> > > in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
> > > It's possible that you will receive thousands of interrupt requests
> > > after initialization for 2.0 roothub. And you will get a lot of
> > > warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
> > > disabled?". This amount of interrupt requests will cause the entire
> > > system to freeze.
> > > This problem was first found on a device with ASM2142 host controller
> > > on it.
> > > 
> > > Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > the test robot did not find this original problem, it only found
> > problems with your original submission, which is different.
> > 
> "Reported-by" shouldn't had been put here.
> Quote from the last email test robot sent to me，
> "If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>"
> Where should I put this? Or just ignore it?
> 

Yes, you can ignore it but you properly referenced it in your changelog
area.

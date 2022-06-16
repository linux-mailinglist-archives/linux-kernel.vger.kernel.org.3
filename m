Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD454DC9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359513AbiFPIMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359602AbiFPIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6355D64D;
        Thu, 16 Jun 2022 01:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0FCC61D26;
        Thu, 16 Jun 2022 08:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DA5C34114;
        Thu, 16 Jun 2022 08:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655367138;
        bh=mWVWvlbNF5oM92o+SC6qXGqar6mMj/mWssSgx/VPIsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXjdS09w8tl6WHwt1elnRwRw61srgTuQepEqDujX/nKPw+I5ZIWuRD9rqzmRmk0ic
         u30mLIYhthZxNk/xyMVzl47T25FztdspG8l3ZUwBleKi+NoWTzBh9bsVooqZTGeapS
         uy29WF7wFHy0pbTS8X5g69cocaACtb8QI4vTbOiE=
Date:   Thu, 16 Jun 2022 10:12:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hongyu Xie <xy521521@gmail.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 125707942@qq.com, wangqi@kylinos.cn,
        xiongxin@kylinos.cn, Hongyu Xie <xiehongyu1@kylinos.cn>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 -next] usb: xhci: disable irq during initialization
Message-ID: <Yqrl3jGyUx7sZVdL@kroah.com>
References: <20220616080933.1238309-1-xiehongyu1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616080933.1238309-1-xiehongyu1@kylinos.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 04:09:33PM +0800, Hongyu Xie wrote:
> irq is disabled in xhci_quiesce(called by xhci_halt, with bit:2 cleared
> in USBCMD register), but xhci_run(called by usb_add_hcd) re-enable it.
> It's possible that you will receive thousands of interrupt requests
> after initialization for 2.0 roothub. And you will get a lot of
> warning like, "xHCI dying, ignoring interrupt. Shouldn't IRQs be
> disabled?". This amount of interrupt requests will cause the entire
> system to freeze.
> This problem was first found on a device with ASM2142 host controller
> on it.
> 
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> Reported-by: kernel test robot <lkp@intel.com>

the test robot did not find this original problem, it only found
problems with your original submission, which is different.


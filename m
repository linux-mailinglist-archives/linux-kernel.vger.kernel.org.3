Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31DA551E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350992AbiFTOYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245182AbiFTOXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:23:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6731B1EEEC;
        Mon, 20 Jun 2022 06:38:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22394B811C2;
        Mon, 20 Jun 2022 13:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33985C3411C;
        Mon, 20 Jun 2022 13:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655732335;
        bh=+fFogW7MYgbcV+/+vdX3im2l7WY1OGpRvAvNxoxAPyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MY0okBXnmX/EcirZ4FWy0Au4Y8zBCrkzVtpjevX0FoB6qwpJTz30gOQFAAt4oN6Wp
         DW3fpwxgyyETQUYYDXCMkZ3HFC4L2BRZ0in3174sgFIpi+tOiSnguvTwsE9p523sUu
         fFtI9jPYwiStyH0GgovpWMaPLWnOVLDFBXv5s+7c=
Date:   Mon, 20 Jun 2022 15:38:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Yang Shen <shenyang39@huawei.com>
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
Message-ID: <YrB4WLW/ZvKp1imo@kroah.com>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica>
 <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica>
 <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
 <YrB1D9rv9G4h/BYU@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrB1D9rv9G4h/BYU@myrica>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 02:24:31PM +0100, Jean-Philippe Brucker wrote:
> >From c7c2b051ec19285bbb973f8a2a5e58bb5326e00e Mon Sep 17 00:00:00 2001
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Date: Mon, 20 Jun 2022 10:10:41 +0100
> Subject: [PATCH] uacce: Tidy up locking
> 
> The uacce driver must deal with a possible removal of the parent driver
> or device at any time.

No it should not, if the reference counting logic is properly set up.
The parent driver should correctly tear things down here.

> At the moment there are several issues that may
> result in use-after-free. Tidy up the locking to handle module removal.

I don't think you did that, as module removal should never happen if a
file descriptor is opened as I previously mentioned.

thanks,

greg k-h

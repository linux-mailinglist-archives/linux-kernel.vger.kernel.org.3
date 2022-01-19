Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5378E49386F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353723AbiASK3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbiASK3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:29:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD09C061574;
        Wed, 19 Jan 2022 02:29:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A58CB8190C;
        Wed, 19 Jan 2022 10:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0697C004E1;
        Wed, 19 Jan 2022 10:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642588159;
        bh=i7W6a1IPOdnCVmjmrwYtLjG7iQyAMgRXD3ReyBt+QKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ukLnbAswOFr1NxPqmWNEFC2JflcWnFkuqEpTUSTLKEByjJiHJOieVTwtvD40xi8k
         VHuZPjqhLzWpmvQRaqVvlQB0BqJBl2Z05EW7xSvpXcghub07B2tQHZTm0toFzOwn2U
         p9ylcLM+GDbI2mR4cQaZf9KDV13M1qLV1ktKsBn4=
Date:   Wed, 19 Jan 2022 11:29:16 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     David Binderman <dcb314@hotmail.com>
Cc:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re:
 drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c:275: dangling
 pointer ?
Message-ID: <Yefn/J0D33c9bDO+@kroah.com>
References: <HE1P189MB05719D490E35B19D832195139C589@HE1P189MB0571.EURP189.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HE1P189MB05719D490E35B19D832195139C589@HE1P189MB0571.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 09:53:48AM +0000, David Binderman wrote:
> Hello there,
> 
> Recent gcc development versions say:
> 
> drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c:275:33: warning: storing the address of local variable ‘h’ in ‘*handle’ [-Wdangling-pointer=]
> 
> Source code is
> 
>       *handle = &h;
> 
> but h is a stack local variable, so exporting its address doesn't make any sense.

Great, can you send a patch to fix this up?

thanks,

greg k-h

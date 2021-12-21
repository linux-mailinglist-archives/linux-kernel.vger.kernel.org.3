Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF16247B9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 07:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhLUGRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 01:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbhLUGRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 01:17:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8853AC06173F;
        Mon, 20 Dec 2021 22:17:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47D83B811B1;
        Tue, 21 Dec 2021 06:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821EFC36AE2;
        Tue, 21 Dec 2021 06:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640067425;
        bh=yIz5GSteNznazB9ICJ0nSd7ewm/WJGgw+sxO9Mzuqp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsBbAHwnQ2mYUDKX+ggXToetIrxkNHaoSVCNlJr7HfyWukaT3e9dZt4Y7JCzUzN66
         GawpgWhOD2URgRY7TvLixYCQc3gfNAAr5Te9Aj7sbUTSfS0byKchT71NvzlLdHRXJU
         gxQTtBHzUvg6xDt24R4UX4cQX6GDmpp3uQQvRjn4=
Date:   Tue, 21 Dec 2021 07:17:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     ok@artecdesign.ee, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: host: isp116x: Check for null res pointer
Message-ID: <YcFxXkn99IOl2L3s@kroah.com>
References: <20211221015658.1002191-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221015658.1002191-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 09:56:58AM +0800, Jiasheng Jiang wrote:
> And I correct my commit message because platform_get_resource returns
> null if fails.
> Here is it.
> The return value of platform_get_resource() could be null when there is
> no suitable resource.
> So it should be better to check it to avoid the use of null pointer in
> release_mem_region().
> 
> Fixes: 4808a1c02611 ("[PATCH] USB: Add isp116x-hcd USB host controller driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v3 -> v4
> 
> *Change 1. Just skip the use of null pointer instead of directly return.
> *Change 2. Add the driver name in the subject line.
> *Change 3. Correct commit message.
> ---
>  drivers/usb/host/isp116x-hcd.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

*plonk*

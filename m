Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50A446CEA9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244649AbhLHILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240465AbhLHILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:11:45 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA940C061574
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:08:13 -0800 (PST)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CA6198BB;
        Wed,  8 Dec 2021 09:08:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638950891;
        bh=rnwqGnyrDlCLdmc/u8xDAhVlrtYBdqtoH9dUCLcPNJ0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uDUdQk+jSMDO4iJJFvYefQnkZtPRJlc9npCUMNqtTV3ZTVADHZfJd2ahYD/0VEODe
         gUtvtJjRp8Eb0hxHDErVrejt+Dz7w2ZM/frBW+xP3MkvonMNdI0gg2pX0egGRlJbqM
         NGBpERId13aTrdJ2dNxiiKSBSSj7Z3g/I10CCJgY=
Subject: Re: [PATCH] omapdrm: dss: mark runtime PM functions __maybe_unused
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jyri Sarha <jsarha@ti.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211205131612.3192652-1-arnd@kernel.org>
 <Ya3wsKEVEtkTsmSU@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <e3adce46-8eed-0af2-4aa3-9ac3bbf1508f@ideasonboard.com>
Date:   Wed, 8 Dec 2021 10:08:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya3wsKEVEtkTsmSU@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 13:14, Laurent Pinchart wrote:
> Hi Arnd,
> 
> Thank you for the patch.
> 
> On Sun, Dec 05, 2021 at 02:15:56PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Using the SET_RUNTIME_PM_OPS() macro causes a warning about the
>> referenced functions when they are marked static but not __maybe_unused:
>>
>> drivers/gpu/drm/omapdrm/dss/dss.c:1572:12: error: unused function 'dss_runtime_suspend' [-Werror,-Wunused-function]
>> drivers/gpu/drm/omapdrm/dss/dss.c:1584:12: error: unused function 'dss_runtime_resume' [-Werror,-Wunused-function]
>> drivers/gpu/drm/omapdrm/dss/dispc.c:4845:12: error: unused function 'dispc_runtime_suspend' [-Werror,-Wunused-function]
>> drivers/gpu/drm/omapdrm/dss/dispc.c:4860:12: error: unused function 'dispc_runtime_resume' [-Werror,-Wunused-function]
>>
>> Fixes: b92f7ea556f8 ("drm/omap: dss: Make use of the helper macro SET_RUNTIME_PM_OPS()")
> 
> I wonder how well drivers are tested with !CONFIG_PM. We may be going
> through hoops and loops to support this when it actually won't work in
> most drivers. That's a separate issue though :-)

It won't work, but can be fixed. I did that for tidss, some years back. 
The problem is that the driver depends on runtime_suspend/resume to be 
called, and the fix is to call them manually when !CONFIG_PM.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Tomi, could you apply this ?

Yes, I'll push to drm-misc-next. Thanks!

  Tomi

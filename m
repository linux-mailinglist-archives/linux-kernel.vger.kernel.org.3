Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5224864E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 14:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbiAFNEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 08:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238990AbiAFNEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 08:04:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0512C061245;
        Thu,  6 Jan 2022 05:04:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F3C8617FF;
        Thu,  6 Jan 2022 13:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7831DC36AE3;
        Thu,  6 Jan 2022 13:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641474282;
        bh=OrpbMz33tmziz/Ene2vJS2s15wTiwckM/wakIsT7NvY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YdsZWjm5tMFJk/FQ/7b4cTFiFobAtPgu79wGZt/hy2uNv0g5KCnoQHopmi92SjECg
         NN39H0txUQ1kU3kgn5HBSm9q4CSzMrhOzqA+5tl07l8Pr4h1fNQ0JQuYhF4ffe88Kx
         G94xaawdGSzIOcsH/aGkf8HYTcILvgviEMGEIfU6lmVjijRAYQsL/v+IUil8yrRX+M
         SKa7BBOrRXiC2URtn9KQpL6E6C3+OawK11MhLYfgrD0d5df3cNkloGEmbNJnJdQ/Nk
         qi/O+1wYgmDWIuJLaJSeaJwXqj6IAjPCFV2LNknSjDG/TbFfZdbNIzbE6JDML1cdq0
         B5XzNyAnMvAKQ==
Date:   Thu, 6 Jan 2022 14:04:39 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc:     benjamin.tissoires@redhat.com, jose.exposito89@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] HID: magicmouse: Fix an error handling path in
 magicmouse_probe()
In-Reply-To: <b0777c29fb4c59f27a726f62680b4c7f04c5c76e.1640725695.git.christophe.jaillet@wanadoo.fr>
Message-ID: <nycvar.YFH.7.76.2201061404340.16505@cbobk.fhfr.pm>
References: <b0777c29fb4c59f27a726f62680b4c7f04c5c76e.1640725695.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021, Christophe JAILLET wrote:

> If the timer introduced by the commit below is started, then it must be
> deleted in the error handling of the probe. Otherwise it would trigger
> once the driver is no more.
> 
> Fixes: 0b91b4e4dae6 ("HID: magicmouse: Report battery level over USB")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/hid/hid-magicmouse.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index eba1e8087bfd..b8b08f0a8c54 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -873,6 +873,7 @@ static int magicmouse_probe(struct hid_device *hdev,
>  
>  	return 0;
>  err_stop_hw:
> +	del_timer_sync(&msc->battery_timer);
>  	hid_hw_stop(hdev);
>  	return ret;
>  }

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E264979F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbiAXIET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:04:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32884 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236109AbiAXIES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:04:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 072A3B80E19;
        Mon, 24 Jan 2022 08:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A2EC340E1;
        Mon, 24 Jan 2022 08:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643011455;
        bh=DqPJN/JIB8tHhcVzN32koJJQ0u4X/+E4TGCtyvLCsEg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=gw5hfkViupjANxqUxsyfCibq9No2Ie5M1NlR3ITDNImLtUQ0olWLryQiOxxDcCCBU
         SaHz69uKz9gM/Bfbwodd/Ml03jK+HZ6TmWbB0QtPdpNATfIK9M3tHnlUmEkrvXZ102
         P1GAt06ME7MvFEDoUctaniKcQg4GPZUXICU4220VWT4IBQzOjHexBNi+sXOlCe3RII
         W/K1mUgipnR8XqrOGK1ZIz+XlN3YV2vR2DF+Msun+D9xppCAaHqaoL5v/pWx48fn+6
         MiEopM+sjDX+wXEvhimQmRzpda68ysH/UriDKE/vAPs7V/DvpjFsl2aO6O8FCpaQgs
         M4FxVUu2IOGYQ==
Date:   Mon, 24 Jan 2022 09:04:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Salah Triki <salah.triki@gmail.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        syzkaller <syzkaller@googlegroups.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: elo: fix memory leak in elo_probe
In-Reply-To: <20220122094827.684542-1-dzm91@hust.edu.cn>
Message-ID: <nycvar.YFH.7.76.2201240904040.28059@cbobk.fhfr.pm>
References: <20220122094827.684542-1-dzm91@hust.edu.cn>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jan 2022, Dongliang Mu wrote:

> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> When hid_parse in elo_probe fails, it forgets to call usb_put_dev to
> decrease the refcount.
> 
> Fix this by adding usb_put_dev in the error handling code of elo_probe
> 
> Fixes: fbf42729d0e9 ("HID: elo: update the reference count of the usb device structure")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/hid/hid-elo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
> index 8e960d7b233b..9b42b0cdeef0 100644
> --- a/drivers/hid/hid-elo.c
> +++ b/drivers/hid/hid-elo.c
> @@ -262,6 +262,7 @@ static int elo_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  
>  	return 0;
>  err_free:
> +	usb_put_dev(udev);
>  	kfree(priv);
>  	return ret;

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs


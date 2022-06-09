Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642915446BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbiFII5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242905AbiFII4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:56:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5B51E2898;
        Thu,  9 Jun 2022 01:56:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47D27B82C7E;
        Thu,  9 Jun 2022 08:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46A2C3411E;
        Thu,  9 Jun 2022 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654764969;
        bh=Le8tPzoYYL2tORCuXImVySrfImcCUAxU8vy3RAykSlo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=R/4IuUAssjcQ98itfPJK0iNCFfRUlw+3MZ/iZnTNJUF6bN6a7p13V/qoFv/jwApAX
         /YO6GCcYRqM/tbR0tBPDr+1YKh4NDeZ8qLtv7BFGujHm+RE025u1xfGpC1hwInGhLe
         eUXcK2L0oWQkAK4S2TbHbut+shw0flWC4Ei9HvNeKH23WR0D1C5UKjQ84CpOB68xZW
         ch4xuqd/xD3wZV3KNTs48yLShwKN/LbpKWCIBaxFpQn9kbSGgCntRJwOmj30dI0Y+D
         iPoZBt3+cmlONVICod7/BJgHSG/AmNRx2ylQ6nafDhKoGy7BM0xtUJN/LfZgsWO7sw
         FL/J+dDESo7jA==
Date:   Thu, 9 Jun 2022 10:55:57 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
cc:     benjamin.tissoires@redhat.com, eudean@arista.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: Re: [PATCH] HID: cp2112: prevent a buffer overflow in
 cp2112_xfer()
In-Reply-To: <20220608122609.70861-1-harshit.m.mogalapalli@oracle.com>
Message-ID: <nycvar.YFH.7.76.2206091055490.14340@cbobk.fhfr.pm>
References: <20220608122609.70861-1-harshit.m.mogalapalli@oracle.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022, Harshit Mogalapalli wrote:

> Smatch warnings:
> drivers/hid/hid-cp2112.c:793 cp2112_xfer() error: __memcpy()
> 'data->block[1]' too small (33 vs 255)
> drivers/hid/hid-cp2112.c:793 cp2112_xfer() error: __memcpy() 'buf' too
> small (64 vs 255)
> 
> The 'read_length' variable is provided by 'data->block[0]' which comes
> from user and it(read_length) can take a value between 0-255. Add an
> upper bound to 'read_length' variable to prevent a buffer overflow in
> memcpy().
> 
> Fixes: 542134c0375b ("HID: cp2112: Fix I2C_BLOCK_DATA transactions")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
>  drivers/hid/hid-cp2112.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index ece147d1a278..1e16b0fa310d 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -790,6 +790,11 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
>  		data->word = le16_to_cpup((__le16 *)buf);
>  		break;
>  	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		if (read_length > I2C_SMBUS_BLOCK_MAX) {
> +			ret = -EINVAL;
> +			goto power_normal;
> +		}
> +
>  		memcpy(data->block + 1, buf, read_length);
>  		break;

Good catch, now applied. Thanks,

-- 
Jiri Kosina
SUSE Labs


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA0E46EDA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241348AbhLIQzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhLIQzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:55:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED03C061746;
        Thu,  9 Dec 2021 08:52:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8B290CE2720;
        Thu,  9 Dec 2021 16:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA60C004DD;
        Thu,  9 Dec 2021 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639068730;
        bh=lFjiir2sD0md/TMvmilM7d7unRsKVDD5122cBpWYVHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ay8itGGWLP4hcucKaH7KnA0aif4zos10gDn7dU++YCK3HfNUvy/0g53jLbHTxq5S7
         /QH6TKJS14zrdPM4CGBxE7SWzyI94Q/AhSaPj/FFbySAUZF6sa2tH+Z77hsJBrZrHK
         Sc5tqt4Et5XCUhElErkw1Th3zbOBAElnj5AwACuMxTnLqlnknieoWJTzd9Ur2wkJE1
         ZSSoxVKFeutGnVdnGdtNb4XKjiyfk2tz8knNu0ufjbEyX2+SRn9r/f0n2efhjli8Iy
         FHhQUXO1xGdFd7I8hgHVM+5xq0E38pelMs3AXtxgwX18KC2+q9ZkNsDScN78GcB0mF
         is4SrpUHWXCDQ==
Received: by pali.im (Postfix)
        id 56707111E; Thu,  9 Dec 2021 17:52:07 +0100 (CET)
Date:   Thu, 9 Dec 2021 17:52:07 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (dell-smm) Simplify ioctl handler
Message-ID: <20211209165207.kik56ozi7umti4xo@pali>
References: <20211120170319.72369-1-W_Armin@gmx.de>
 <20211120170319.72369-2-W_Armin@gmx.de>
 <20211123161332.discv3bfx4rkowah@pali>
 <5024959a-772a-ebde-089d-0668e1e188f7@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5024959a-772a-ebde-089d-0668e1e188f7@gmx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 November 2021 21:57:40 Armin Wolf wrote:
> Am 23.11.21 um 17:13 schrieb Pali Rohár:
> 
> > On Saturday 20 November 2021 18:03:18 Armin Wolf wrote:
> > > The second switch-case has no real purpose:
> > > 
> > > - for I8K_BIOS_VERSION, val does not represent a return value,
> > >    making the check for error values unnecessary.
> > > - for I8K_MACHINE_ID, val remains zero, so the error check is
> > >    unnecessary too.
> > > 
> > > Remove the switch-case and move the calls to copy_to_user()
> > > into the first switch-case for I8K_BIOS_VERSION/_MACHINE_ID.
> > > Omit buff[] since data->machineid already contains the string
> > s/->machineid/->bios_machineid/
> > 
> > > with the necessary zero padding.
> > data is allocated by devm_kzalloc() so data->bios_machineid is really
> > zero padded.
> > 
> > > Tested on a Dell Inspiron 3505.
> > > 
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > ---
> > >   drivers/hwmon/dell-smm-hwmon.c | 30 +++++++++---------------------
> > >   1 file changed, 9 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > > index 5596c211f38d..b5d1703faa62 100644
> > > --- a/drivers/hwmon/dell-smm-hwmon.c
> > > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > > @@ -454,7 +454,6 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
> > >   {
> > >   	int val = 0;
> > >   	int speed, err;
> > > -	unsigned char buff[16];
> > >   	int __user *argp = (int __user *)arg;
> > > 
> > >   	if (!argp)
> > > @@ -468,15 +467,19 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
> > > 
> > >   		val = (data->bios_version[0] << 16) |
> > >   				(data->bios_version[1] << 8) | data->bios_version[2];
> > > -		break;
> > > 
> > > +		if (copy_to_user(argp, &val, 4))
> > > +			return -EFAULT;
> > > +
> > > +		return 0;
> > >   	case I8K_MACHINE_ID:
> > >   		if (restricted && !capable(CAP_SYS_ADMIN))
> > >   			return -EPERM;
> > > 
> > > -		strscpy_pad(buff, data->bios_machineid, sizeof(buff));
> > > -		break;
> > > +		if (copy_to_user(argp, data->bios_machineid, 16))
> > What about usage of sizeof(data->bios_machineid) instead of hardcoded
> > constant 16? And maybe same for constant 4?
> 
> For the string yes, but maybe i should change the int to an u32?

I do not know if changing int to u32 should be done or not...

> > > +			return -EFAULT;
> > > 
> > > +		return 0;
> > >   	case I8K_FN_STATUS:
> > >   		val = i8k_get_fn_status();
> > >   		break;
> > > @@ -527,23 +530,8 @@ i8k_ioctl_unlocked(struct file *fp, struct dell_smm_data *data, unsigned int cmd
> > >   	if (val < 0)
> > >   		return val;
> > > 
> > > -	switch (cmd) {
> > > -	case I8K_BIOS_VERSION:
> > > -		if (copy_to_user(argp, &val, 4))
> > > -			return -EFAULT;
> > > -
> > > -		break;
> > > -	case I8K_MACHINE_ID:
> > > -		if (copy_to_user(argp, buff, 16))
> > > -			return -EFAULT;
> > > -
> > > -		break;
> > > -	default:
> > > -		if (copy_to_user(argp, &val, sizeof(int)))
> > > -			return -EFAULT;
> > > -
> > > -		break;
> > > -	}
> > > +	if (copy_to_user(argp, &val, sizeof(int)))
> > > +		return -EFAULT;
> > > 
> > >   	return 0;
> > >   }
> > > --
> > > 2.30.2
> > > 

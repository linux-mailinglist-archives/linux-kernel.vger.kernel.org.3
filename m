Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AA54FE361
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352425AbiDLOIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbiDLOIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:08:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9505EBF6;
        Tue, 12 Apr 2022 07:06:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 305261F44867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649772382;
        bh=NhAvw/CPjn/FJ55ToKdoxCWXAqWdjMGkT/ji6E0FKyU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SYpsF7V3cepiNan4tqZ0rypUYSyf/XKReb0Sgn1oBe35LQqMtUCe9gG3GH2jPNtTK
         jIrVKPXhFmRpX4eMj+TrUgDVLwxLIKVTIORCfi9VsL8mcVu3C0iMGHeswNR82BxS++
         oV8HHbw/1oO2eLO2xyPQalGdshhpkzsx1iGk1BSeQ84jaTN2A2JzPVW+dkHfR8sWvN
         1KOfu8zBk1Dw3J4aE1uFlfFCrrsy89j39npDKfufQka+s+DlKBifFcOfQf4EEumaTG
         rMQa4yQtzSyJ57+03oDrnJs5o62qq7sKk4zhigcnW9PFKiu3u0AkvKoPsD2fbplL/T
         J87j4VYjFUtow==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, krzk@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
Subject: Re: [PATCH 3/3] iio: light: Add support for ltrf216a sensor
Organization: Collabora
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
        <20220325103014.6597-4-shreeya.patel@collabora.com>
        <20220327153049.10e525e9@jic23-huawei>
        <d5de6b56-ad90-feec-c65a-53699c8ddbe9@collabora.com>
Date:   Tue, 12 Apr 2022 10:06:18 -0400
In-Reply-To: <d5de6b56-ad90-feec-c65a-53699c8ddbe9@collabora.com> (Shreeya
        Patel's message of "Mon, 11 Apr 2022 22:36:56 +0530")
Message-ID: <875ynexup1.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shreeya Patel <shreeya.patel@collabora.com> writes:

>>> +	val_1 = i2c_smbus_read_byte_data(data->client, addr + 1);
>>> +	val_2 = i2c_smbus_read_byte_data(data->client, addr + 2);
>>> +	ret = (val_2 << 16) + (val_1 << 8) + val_0;
>> This is a le24_to_cpu() conversion.
>> Preferred choice would be to use something like
>> 	u8 buf[3];
>> 	int i;
>>
>> 	for (i = 0; i < 3; i++) {
>> 		ret = i2c_smbus_read_byte_data(data->client, addr);
>> 		if (ret < 0)
>> 			return ret;
>> 		buf[i] = ret;
>> 	}
>> 	return le24_to_cpu(buf);
>>
>
> We do not have any le24_to_cpu() function in current kernel source code.
> I was thinking to use le32_to_cpu() instead but it requires an argument of
> type __le32 and our case we storing the values in u8 buf[3] so I'm not
> really sure if it's possible to use le32_to_cpu() or any other function.

I guess you could make it a 32-bit buffer, keep the most
significant byte zeroed and return le32_to_cpu:

  u8 buf[4];

  memset(buf, 0x0, sizeof(buf));

  for (i = 0; i < 3; i++) {
 	ret = i2c_smbus_read_byte_data(data->client, addr);
 	if (ret < 0)
 		return ret;
	buf[i] = ret;
  }
  return le32_to_cpu(buf);

-- 
Gabriel Krisman Bertazi

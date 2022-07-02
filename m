Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D245640DC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 16:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiGBOxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiGBOxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 10:53:01 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C75BC0F;
        Sat,  2 Jul 2022 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=tANdXAfV1vCs9Lw2PldJS6DPsvSnCBtLkkhAPN71x+A=; b=m8m09NehjeFLIOuV0/cG163a+V
        /6mPuZ4P14grF8WYGK6+hJUnoaRJ7CTIwMZkRY9Gk7Uko2YS88S36brz/c+oUDtdSPYqtlOzcR571
        wk3U29JLTwMdIBVyv7dwkR68LK49O8Y1+8eJIJ3kI8oyaUD19xqEzsrw4JXdB+rmRjRmcKUnqmUhO
        Jsi6bXci74ZSD0TAr+rdA/B857hJ0h3jpKS7f22+tKxujnnK2BGrn8isPFaChx8dEc/9y+DPO10aQ
        4SmwCUaPcnQOKvCJ5ZSXeq7+L/veiCi6ifC2BWzLT5acMdNSwWiifk5K/GfSZ1dPcM424mdcsimlW
        60HWPRRA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1o7eUT-0002jB-5U; Sat, 02 Jul 2022 16:52:57 +0200
Received: from [2001:a61:2a49:8301:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1o7eUS-000BVR-UU; Sat, 02 Jul 2022 16:52:56 +0200
Message-ID: <cb198913-cf3b-e3f4-bbe9-e864822d9820@metafoo.de>
Date:   Sat, 2 Jul 2022 16:52:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 1/2] iio: adc: xilinx-xadc: Make use of device
 properties
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>
References: <20220531141118.64540-1-andriy.shevchenko@linux.intel.com>
 <20220603183224.540b3808@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220603183224.540b3808@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26591/Sat Jul  2 09:24:09 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/22 19:32, Jonathan Cameron wrote:
> On Tue, 31 May 2022 17:11:17 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> Convert the module to be property provider agnostic and allow
>> it to be used on non-OF platforms.
>>
>> Add mod_devicetable.h include.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> These both seem good to me, but as the driver is fairly actively maintained,
> I'll let this one sit on the list for a while so others can take a look.
>
> Whilst it 'seems' unlikely anyone will ever use this driver with other firmware
> I am keen to reduce the number of of-specific drivers in IIO just to avoid
> any chance of cut and paste.
I actually have this device on a PCIe card where I instantiate it using 
mfd with device properties. But no external channels so there was no 
need to convert that part to device properties.

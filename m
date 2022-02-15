Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7014B4B61A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiBODak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:30:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiBODaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:30:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BC983001
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=aI3zYe8mcdc6OUHFtuiG4L1b8S6PH59f355Ltvme6pI=; b=q4q84liFqK4YXrgSJcOSoPGGGT
        HS1YAlrRkct0h34FEsBqWrOeHdxciuOgyMj5x3ED8DWUihVzB1Bbp8qehvUbIYe4i6AuDSkzYjIIO
        eVIu0VMD6x5jL28ZWry7xaA97gyfWC9qQRV9FphjbtB/ZgESOZvbLmvJ9FQv3dVTWl5iOF2tN5Pqd
        sTGHLbUTIeOuYC7ygA19Os3H/qGDbNf06qiXNfIJxxeFDnDpAvsBBqoxFYatxbqHbSGplYDTUI4dz
        SMJP4HHVh5DJhlK1T0Bb0/E4ZhOjJIGh07ZzvaiRFei3jD0/32SvIG0GmsLFXZqsWN+g1HXhAWNPk
        jLWeDgrA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJoXr-00A3HV-H7; Tue, 15 Feb 2022 03:30:27 +0000
Message-ID: <29f9b063-96c9-f120-0920-acd088b01b89@infradead.org>
Date:   Mon, 14 Feb 2022 19:30:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] firmware_loader: EXTRA_FIRMWARE does not support
 compressed files
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220214222311.9758-1-rdunlap@infradead.org>
 <YgsHtdqm3xRU+QUD@bombadil.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YgsHtdqm3xRU+QUD@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/22 17:53, Luis Chamberlain wrote:
> On Mon, Feb 14, 2022 at 02:23:11PM -0800, Randy Dunlap wrote:
>> Document in the firmware loader Kconfig help text that firmware image
>> file compression is not supported for builtin EXTRA_FIRMWARE files so
>> that someone does not waste time trying that.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> ---
>> Yeah, I wasted some time trying to use an xz compressed file
>> as builtin EXTRA_FIRMWARE, 
> 
> Curious *why* you are using EXTRA_FIRMWARE BTW.

Hi Luis,

I need to load i915 firmware very early
and I am not using an initramfs.

>> so try to prevent someone else from
>> doing that.
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks.

>   Luis
>>
>>  drivers/base/firmware_loader/Kconfig |    5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> --- linux-next-20220214.orig/drivers/base/firmware_loader/Kconfig
>> +++ linux-next-20220214/drivers/base/firmware_loader/Kconfig
>> @@ -60,6 +60,8 @@ config EXTRA_FIRMWARE
>>  	  image since it combines both GPL and non-GPL work. You should
>>  	  consult a lawyer of your own before distributing such an image.
>>  
>> +	  NOTE: Compressed files are not supported in EXTRA_FIRMWARE.
>> +
>>  config EXTRA_FIRMWARE_DIR
>>  	string "Firmware blobs root directory"
>>  	depends on EXTRA_FIRMWARE != ""
>> @@ -169,6 +171,9 @@ config FW_LOADER_COMPRESS
>>  	  be compressed with either none or crc32 integrity check type (pass
>>  	  "-C crc32" option to xz command).
>>  
>> +	  Compressed firmware support does not apply to firmware images
>> +	  that are built into the kernel image (CONFIG_EXTRA_FIRMWARE).
>> +
>>  config FW_CACHE
>>  	bool "Enable firmware caching during suspend"
>>  	depends on PM_SLEEP

-- 
~Randy

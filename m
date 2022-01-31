Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD164A4BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380339AbiAaQ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380319AbiAaQ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:26:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070D4C06173D;
        Mon, 31 Jan 2022 08:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=GEwATrS8QyZwxwEyKt9LncyWi/r/xnwpQIPKwhOCdNw=; b=mYrisjOodfhbzF6aT3BqYPvfVx
        arCZ2gkbDftYehgG2gkPMXIZu4PoPMjnZZ6jyfFbKhAaE8AlOWtBozklCVRheAehK9CzSHvZnkk8K
        czb74/oMM0iO3ZqTSaOar+C4lYmiSTgocCKNo1+/SozcpltwXiOl9WmJv/iclw6lVIwnR8bsTVHC/
        Gfk6o/Z1X0zrEYwqzMIm/1F/M07a32o/4i83b4iQjiRuSuiCxY5FVIxttNyCygudd1Djz4EGQUa6p
        zITnsVExJ5bgfFAs4b7rf3JG0rqHI9mcC98AA7TXW88AzbOtscZVf8Qmx2EI3f3fWX+WXjRg4Ba1f
        HOHH5guQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEZVn-00A8Vj-Jk; Mon, 31 Jan 2022 16:26:40 +0000
Message-ID: <bc370384-f852-eedf-5bd8-ed39bf671aba@infradead.org>
Date:   Mon, 31 Jan 2022 08:26:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2] usb: typec: mux: select not-visible INTEL_SCU_IPC
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>
References: <20220130185032.29298-1-rdunlap@infradead.org>
 <Yfeg96P3no1FhWE5@kuha.fi.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Yfeg96P3no1FhWE5@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/22 00:42, Heikki Krogerus wrote:
> On Sun, Jan 30, 2022 at 10:50:32AM -0800, Randy Dunlap wrote:
>> Use "select INTEL_SCU_IPC" instead of depending on it since it is
>> not a visible Kconfig symbol and it may not otherwise be set/enabled.
>>
>> Fixes: b62851491a55 ("usb: typec: mux: Convert the Intel PMC Mux driver to use new SCU IPC API")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: linux-usb@vger.kernel.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: kernel test robot <lkp@intel.com>
>> ---
>> v2: add dependency on X86_PLATFORM_DEVICES to fix build error that was
>>     Reported_by: kernel test robot <lkp@intel.com>
>>
>>  drivers/usb/typec/mux/Kconfig |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- linux-next-20220128.orig/drivers/usb/typec/mux/Kconfig
>> +++ linux-next-20220128/drivers/usb/typec/mux/Kconfig
>> @@ -11,8 +11,8 @@ config TYPEC_MUX_PI3USB30532
>>  
>>  config TYPEC_MUX_INTEL_PMC
>>  	tristate "Intel PMC mux control"
>> -	depends on ACPI
>> -	depends on INTEL_SCU_IPC
>> +	depends on ACPI && X86_PLATFORM_DEVICES
>> +	select INTEL_SCU_IPC
>>  	select USB_ROLE_SWITCH
>>  	help
>>  	  Driver for USB muxes controlled by Intel PMC FW. Intel PMC FW can
> 
> This will cause the driver to fail at probe time if there are no SCU
> device drivers enabled.
> 
> The idea is that the SCU device drivers select the SCU IPC library,
> not the users of the library like this mux driver.

OK. Thanks.

-- 
~Randy

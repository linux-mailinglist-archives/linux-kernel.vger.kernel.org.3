Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472F24C0E94
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 09:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbiBWIzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 03:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbiBWIzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 03:55:03 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737177B56D;
        Wed, 23 Feb 2022 00:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645606476; x=1677142476;
  h=to:cc:references:from:subject:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0ZZp86S8zQ5HRoamd0As4WUEpt/6C+J08F7o2V0U4gk=;
  b=EHAK1YAEBfgGW5W16QdkjnT2QadwGdpb73Irr0Xn8aDtd+kv3AuEmt3V
   40Xsfi88ofknXcx4G6eTcDC5BS/rvoatrMyQNoBC++4yVHBv9RpP6Hztn
   a7XJx6iW6Sp6LeXTbFFMUmbqcZNde4Lsz35vVTdC1ktXV0jyL2sSA0f8S
   jL4amqeNPWauqs8gNfZ49ijjAyZ0xDRbpKpGw94pSn9mcOq42Ao46Vuwi
   3j0zYM/kYFJDRXOk8ZeCsG4R5eWH2IWmo72qaz5luH+HchU4SRLwlJEWO
   sk/aP59fAL41wM5OQ3hBSE8AXrO1HmoL9rnk1n+4jxM44FSqJXNnFu+I/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251653875"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="251653875"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 00:54:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="573743475"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 23 Feb 2022 00:54:34 -0800
To:     Anssi Hannula <anssi.hannula@bitwise.fi>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220222134117.34844-1-anssi.hannula@bitwise.fi>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 1/2] xhci: fix garbage USBSTS being logged in some cases
Message-ID: <fe7381b1-19bc-3b1e-50f3-0ed5c7c39e5e@linux.intel.com>
Date:   Wed, 23 Feb 2022 10:56:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220222134117.34844-1-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.2.2022 15.41, Anssi Hannula wrote:
> xhci_decode_usbsts() is expected to return a zero-terminated string by
> its only caller, xhci_stop_endpoint_command_watchdog(), which directly
> logs the return value:
> 
>   xhci_warn(xhci, "USBSTS:%s\n", xhci_decode_usbsts(str, usbsts));
> 
> However, if no recognized bits are set in usbsts, the function will
> return without having called any sprintf() and therefore return an
> untouched non-zero-terminated caller-provided buffer, causing garbage
> to be output to log.
> 
> Fix that by always including the raw value in the output.
> 
> Note that before 4843b4b5ec64 ("xhci: fix even more unsafe memory usage
> in xhci tracing") the result effect in the failure case was different as
> a static buffer was used here, but the code still worked incorrectly.
> 
> Fixes: 9c1aa36efdae ("xhci: Show host status when watchdog triggers and host is assumed dead.")
> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
> ---
> 
> Noticed this while debugging a USB issue. Let me know if you prefer a
> different fix.
> 
>  drivers/usb/host/xhci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 8a0026ee9524..ac91647195f6 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -2642,6 +2642,7 @@ static inline const char *xhci_decode_usbsts(char *str, u32 usbsts)
>  		ret += sprintf(str + ret, " CNR");
>  	if (usbsts & STS_HCE)
>  		ret += sprintf(str + ret, " HCE");
> +	ret += sprintf(str + ret, " (0x%08x)", usbsts);

Thanks, nice catch.

Maybe this could be the first thing printed out, something like (untested):

@@ -2697,8 +2697,11 @@ static inline const char *xhci_decode_usbsts(char *str, u32 usbsts)
 {
        int ret = 0;
 
+       ret = sprintf(str, " 0x%08x", usbsts);
+
        if (usbsts == ~(u32)0)
-               return " 0xffffffff";
+               return str;
+

-Mathias


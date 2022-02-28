Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452294C6A92
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 12:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiB1Lea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 06:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbiB1Le1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 06:34:27 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1743F3B3F3;
        Mon, 28 Feb 2022 03:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646048029; x=1677584029;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ySEF5DlzjPALe7nOecQb25EocfAPubPKoB3jY4hZ7cw=;
  b=g095o77BwvrY6TB2RrlHXbo5nElUvM6N9iX5bK+tt6XKw5cLkqKF1W2Z
   w7OJL/d3BZ9u39EVGQS1HzOSO6g0yAm++d/rjnN3/8mug6De7JWbKZTq8
   tolJvoNSsZDllCREHmK0CTKyhRRQCuwzmajG5s99EX2Xe0gLW61K+T4Pv
   gyNc6fjN0Uz8/dbXcnWEj4TinyRw1rtajk1oSsCb0w0Cb2pYZif3+CDS/
   0gRRAaZO1QpyKPcHz9v0dI95OkrHwh/9/5HTjrXnVK5IY1l5WwW5dVRN9
   M8B5/odei4g52Uh85z547CG8QewwWqWQyctEj1kBfiKqzM+0KfwtltY+r
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="236367620"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="236367620"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 03:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="575286580"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 28 Feb 2022 03:33:04 -0800
Subject: Re: [PATCH 1/2 v2] xhci: fix garbage USBSTS being logged in some
 cases
To:     Anssi Hannula <anssi.hannula@bitwise.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <fe7381b1-19bc-3b1e-50f3-0ed5c7c39e5e@linux.intel.com>
 <20220225102602.3829106-1-anssi.hannula@bitwise.fi>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <01054a96-22d1-b72e-1166-fcbd5c2f489b@linux.intel.com>
Date:   Mon, 28 Feb 2022 13:34:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220225102602.3829106-1-anssi.hannula@bitwise.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.2.2022 12.26, Anssi Hannula wrote:
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

Thanks. Adding both 1/2 v2 and 2/2

-Mathias

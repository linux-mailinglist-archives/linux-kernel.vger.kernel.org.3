Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027824A978B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358224AbiBDKOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:14:16 -0500
Received: from relay4.hostedemail.com ([64.99.140.35]:59287 "EHLO
        relay4.hostedemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiBDKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:14:14 -0500
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id 2E13E233D5;
        Fri,  4 Feb 2022 10:14:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 94F0B2001E;
        Fri,  4 Feb 2022 10:14:11 +0000 (UTC)
Message-ID: <aa16191c1241473fbfd55995bbba37bd2ab4a41c.camel@perches.com>
Subject: Re: [PATCH V5 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
From:   Joe Perches <joe@perches.com>
To:     "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Fri, 04 Feb 2022 02:14:10 -0800
In-Reply-To: <20220204053046.2475671-2-david.e.box@linux.intel.com>
References: <20220204053046.2475671-1-david.e.box@linux.intel.com>
         <20220204053046.2475671-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 94F0B2001E
X-Spam-Status: No, score=-4.69
X-Stat-Signature: ydd71wdpkau56qatg8kyeubdkw717xzp
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX196MIkOYnFTw0WTDvhJHlAh7MzwlEJuSoU=
X-HE-Tag: 1643969651-478145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-02-03 at 21:30 -0800, David E. Box wrote:
> Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> activating additional silicon features. Features are enabled through a
> license activation process.

Why isn't this a user process and not a kernel one?

> V5
>   - Update kernel version to 5.18 in API doc and copyrights to 2022.
>   - Remove unneeded prototypes.
>   - In binary attribute handlers where ret is only used for errors,
>     replace,
>               return (ret < 0) ? ret : size;
>     with,
>               return ret ?: size;

I think this style overly tricky.

Why not the canonical:

	if (ret < 0)
		return ret;

	return size;



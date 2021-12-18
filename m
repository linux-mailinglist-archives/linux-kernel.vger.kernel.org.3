Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBE047991A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 07:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhLRGHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 01:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhLRGHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 01:07:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBC6C061574;
        Fri, 17 Dec 2021 22:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=9IggNXWYPRV4g7iE9jleVufPMdJohCFuOCK1m+uVJkM=; b=RNBMV58P0LXyiALNzQLuGvHexF
        VvmbKc8cJ4rUe3GUsGFQFTPIHxIbfT4sUu0OnOA+d4UN7dYXLBBzkwMl7Atc0orfhKHysMS50PXiF
        pYYHhcklChQM2B3PPYa/HRI0Ppjs6EPDQ/i5SiFm1u+890a/AJN5+51jvuFa4xhhwnHw3edL9Tz/V
        PBbfOfenrSmiaZSpSZr/32VmCQfaUSe8KoiZAAmGpixc99Ylq9XXBTJKaGZFhO95RpKgB41yp8r7g
        1duVSLUQIe+04ig2Q/d7yEQH1zBNkJr9/RWAAaFwoK7ZI31eOI8ama1dHd+WjTIKhv4Qs9NADFHuh
        S/ExkHlA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mySsP-00HM5A-Kq; Sat, 18 Dec 2021 06:07:26 +0000
Message-ID: <28c7a12e-6d85-d15d-8884-997eb68612e9@infradead.org>
Date:   Fri, 17 Dec 2021 22:07:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2][RFC 1/2] Implement Ziegler-Nichols Heuristic
Content-Language: en-US
To:     Chetankumar Mistry <chetan.mistry@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org
References: <20211217184907.2103677-1-chetan.mistry@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211217184907.2103677-1-chetan.mistry@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/17/21 10:49, Chetankumar Mistry wrote:
> Implement the Ziegler-Nichols Heuristic algorithm to better
> estimate the PID Coefficients for a running platform.
> The values are tuned to minimuse the amount of overshoot in
> the temperature of the platform and subsequently minimise
> the number of switches for cdev states.
> 
> Signed-off-by: Chetankumar Mistry <chetan.mistry@arm.com>

The kernel-doc changes all look good and don't cause any warnings.
Thanks.

> ---
> Changelog v2:
> - Updated Kernel-Docs to use ':' delimiter (asked by Randy Dunlap)
> - Changed divide operation to use div_frac (requested by kernel_test_robot)
> 
>  drivers/thermal/gov_power_allocator.c | 418 ++++++++++++++++++++++++++
>  drivers/thermal/thermal_sysfs.c       |   2 +
>  include/linux/thermal.h               |   7 +
>  3 files changed, 427 insertions(+)

-- 
~Randy

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94AD47D28D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245105AbhLVNAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:00:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46068 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbhLVNAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:00:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5C27B81054
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 13:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B0AC36AE8;
        Wed, 22 Dec 2021 13:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640178003;
        bh=5it6rXjduOr+op5cMxQzY3oUcUx9ll/J6R5QnTR+Df4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BhNby3B7vs58PL4/PZ0ndlHCCE2u7d7X34/OgiOJDIhvAmRL7QkUMp1SHzFE/bnbZ
         megI6GZJ5RndSxlC7tpa/fVIGiKaNhpSoKGijfEtTD/Ijh0XYlgW7ECq1BG7gEuz85
         TFxDeZiqxwm2Wt6EYI0JrnOUbXam/bjDjg3ffX3w=
Date:   Wed, 22 Dec 2021 14:00:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: platform: document registration-failure
 requirement
Message-ID: <YcMhUDbemvo/n3mB@kroah.com>
References: <20211222104213.5673-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222104213.5673-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 11:42:13AM +0100, Johan Hovold wrote:
> Add an explicit comment to document that the reference initialised by
> platform_device_register() needs to be released by a call to
> platform_device_put() also when registration fails (cf.
> device_register()).
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> 
> Greg,
> 
> I took a quick look at driver code registering non-static platform
> devices and only found four drivers getting this wrong.
> 
> I've fixed up two of them and of the remaining two, one media driver is
> using devres (hurray!) and the other ignores registration failures
> completely anyway:
> 
> 	- vpif_probe()
> 	- sm501_register_device()
> 
> It seems to me that the right thing to do here, at least short term, is
> to add a comment clarifying this behaviour and fix up the few driver
> that got it wrong.

Looks good, thanks for this, now queued up.

greg k-h

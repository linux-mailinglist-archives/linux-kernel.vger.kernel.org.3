Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B6E495195
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376740AbiATPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbiATPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:38:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC6BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:38:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BC7260AD6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6F8C340E0;
        Thu, 20 Jan 2022 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642693085;
        bh=t/67havVcIKUwmQL5G1hyKJG22hHt2hgG4Ka9kHQlxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfevTEkVcq2aTVvhC76gc+AxnkoLf5zunslu8PJ47UyUYEllK/PHwn9Spviq/rrWc
         zoksMha/2byIAS1XKsUhOfU8AvCuXIHFPqdBolNlpno1q9FloKud6mUSbqpixM7VX6
         kxbtX+IG0K9kGctRR9P5v37R1n8qOEGMm7thvBpQ=
Date:   Thu, 20 Jan 2022 16:38:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Soenke Huster <soenke.huster@eknoes.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: fix null pointer deref in device_find_child
Message-ID: <YemB2pdWSey1mA52@kroah.com>
References: <20220120150246.6216-1-soenke.huster@eknoes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120150246.6216-1-soenke.huster@eknoes.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 04:02:46PM +0100, Soenke Huster wrote:
> Similar to device_for_each_child, device_find_child should not ooops
> if parent->p is NULL. While fuzzing the Bluetooth subsystem, I got a null
> pointer dereference in next_device, which is prevented by this change.
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=215497
> Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
> ---
> I found this while fuzzing the bluetooth subsystem and reported this bug
> in bugzilla. As I feel more like a kernelnewbie, I am not sure whether
> this needs to be patched in driver core, or is just an issue of the
> bluetooth subsystem itself. If the latter is the case: sorry for the
> spam!

bluetooth should be fixed, this is an indication that something is using
a stale pointer and this would be the least of the problems here.

thanks,

greg k-h

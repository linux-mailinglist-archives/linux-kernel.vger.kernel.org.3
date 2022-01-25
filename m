Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4445E49B755
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581826AbiAYPNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581627AbiAYPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:11:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DF7C061759
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:11:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6137861669
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 15:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099F9C340E0;
        Tue, 25 Jan 2022 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643123460;
        bh=QktJHi6QpRk8SetsALi9mJL7sWv/IP6LVhyDznyywto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ivYtKLAcLMQP+KOX7JVvnkPcbUPnscUZ7z6UPkUgud/ZjMnVxYhymrwcjfDQ66ffD
         FIIvOP1LeubjaVl+9aJ/ulxwC8NoVUnCbByvDH9h8xcdKeTlUKSICc3gE/ZZuAGarX
         r4pjhLj1AsWhN1eI6QHPYLUJlreAzbeVqOSuPHJI=
Date:   Tue, 25 Jan 2022 16:10:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abdun Nihaal <abdun.nihaal@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] staging: r8188eu: remove unneeded ret variables
Message-ID: <YfATARBq6FJ2e3HE@kroah.com>
References: <cover.1641551261.git.abdun.nihaal@gmail.com>
 <c9c24c13d2823ccaadbbce33613d1242531dbe86.1641551261.git.abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c24c13d2823ccaadbbce33613d1242531dbe86.1641551261.git.abdun.nihaal@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 04:05:40PM +0530, Abdun Nihaal wrote:
> Remove unneeded return variables in ioctl_linux.c that are initialized
> to 0 and are not assigned after. Instead, return 0 directly.

Many, if not most, of these functions should either be having their
return value checked, or be void functions as no one checks their return
value and they can not fail.  Please split this up and look at each
function to determine which is is and how to fix it up properly.  Just
returning 0 all the time is not the correct thing to do all the time.

One example would be rtw_p2p_get_status()  It can not fail, so why does
it return anything?

thanks,

greg k-h

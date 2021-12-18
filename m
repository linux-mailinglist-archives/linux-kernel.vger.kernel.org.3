Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FAF4799E7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 10:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhLRJNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 04:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhLRJNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 04:13:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87325C061574;
        Sat, 18 Dec 2021 01:13:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36D71B8075D;
        Sat, 18 Dec 2021 09:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC97C36AE5;
        Sat, 18 Dec 2021 09:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639818817;
        bh=3BlsJhspxE/hwfBLonMvlt6Kd4L0FO/CGFZVjahTx8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZjXp5jYSPp/Vu9yLhUAVhLC6stfS63C6Ictuka54OkkIswz7jJscX9sX3X/0pX7Q3
         BNpm62AmkIfqGOdfva+1PkBh9tlPuM53cnGE49jnI1OE2VZqc5hu6oh7KZE9qOLRyV
         rRW77Xo/djx6ipL4O+jLz7L+tUJcGhN+5EciyV+Q=
Date:   Sat, 18 Dec 2021 10:13:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julio Faracco <jcfaracco@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, axboe@kernel.dk, tglx@linutronix.de,
        damien.lemoal@wdc.com, dkadashev@gmail.com,
        paul.gortmaker@windriver.com, zhouyanjie@wanyeetech.com,
        niklas.cassel@wdc.com, penguin-kernel@i-love.sakura.ne.jp,
        macro@orcam.me.uk, caihuoqing@baidu.com
Subject: Re: [PATCH] usb: fixing some clang warnings inside usb host drivers
Message-ID: <Yb2mOUHSwE+iUrkm@kroah.com>
References: <20211218042420.28466-1-jcfaracco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218042420.28466-1-jcfaracco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 01:24:20AM -0300, Julio Faracco wrote:
> Clang is reporting some issues related variable values not used and
> other issues inside some USB host drivers. This commit removes some
> trashes and adds some strategies to mitigate those warnings.
> 
> The most important is the maxpacket not checking for zeros inside both
> functions qtd_fill(). Even if this variable is always higher than zero,
> it should be checked to avoid this kind of verbosity.
> 
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>

Please break this up into "one patch per warning" and show the warning
that is happening as well, as it is not obvious why you are changing
these files in the way you are doing it.

thanks,

greg k-h

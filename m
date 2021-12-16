Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4B3476B62
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbhLPIEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:04:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36852 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbhLPIEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:04:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D910B82307
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 08:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14C7C36AE4;
        Thu, 16 Dec 2021 08:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639641888;
        bh=JIwilPIt+1khUC/w16nLhgXsQzoG1jn9mhNVyJvEAu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vjt37Jy60bumOhj2RffUXzT89nA/TA+qMht5Js/LmHFKZzTrrM4eCXtfBJ1cOGfVe
         u6tRIM9P8GvAOlzj9A8VE2LDLzun601JJciJxyeaxz+LqmCaJeJXoFIsz9hUTWGNO6
         vLRbNx7Y+4q6LdivvT+Gg1DG6wpa/4sanciGNDPo=
Date:   Thu, 16 Dec 2021 09:04:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amitay Isaacs <amitay@ozlabs.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        jk@ozlabs.org, joel@jms.id.au, alistair@popple.id.au,
        eajames@linux.ibm.com
Subject: Re: [PATCH v2 2/2] fsi: sbefifo: implement FSI_SBEFIFO_READ_TIMEOUT
 ioctl
Message-ID: <YbrzHf+wRKzTFxEm@kroah.com>
References: <20211216062405.415888-1-amitay@ozlabs.org>
 <20211216062405.415888-3-amitay@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216062405.415888-3-amitay@ozlabs.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:24:05PM +1100, Amitay Isaacs wrote:
> FSI_SBEFIFO_READ_TIMEOUT ioctl sets the read timeout (in seconds) for
> the response received by sbefifo device from sbe.  The timeout affects
> only the read operation on sbefifo device fd.
> 
> Certain SBE operations can take long time to complete and the default
> timeout of 10 seconds might not be sufficient to start receiving
> response from SBE.  In such cases, allow the timeout to be set to the
> maximum of 120 seconds.
> 
> Signed-off-by: Amitay Isaacs <amitay@ozlabs.org>
> ---
>  drivers/fsi/fsi-sbefifo.c | 44 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/fsi.h  | 14 +++++++++++++
>  2 files changed, 58 insertions(+)

Where is the userspace tool that uses this new ioctl?

And again, why does it have to be an ioctl?  Where is this now
documented?  What are the units of the value?

greg k-h

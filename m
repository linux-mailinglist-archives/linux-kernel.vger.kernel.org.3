Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE50482FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiACJz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:55:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33328 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiACJz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:55:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B901361003
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 09:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7731BC36AEE;
        Mon,  3 Jan 2022 09:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641203725;
        bh=E8J8AnmUaLkTFGW2nMhUjBsEvZld87+TWvohVtFqxfE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=inpm3z1kBpoJ+b+nQN4I6/3w96t2lSSWDnU+U6E7c8S2IMdyV9iEXdI1RayvWOFyW
         I45IpQzerNVsPuVaRWlsndqDBeWkgXzI1aRDzs7aZglJx4s3FCNc3urOcqZJV1OVRo
         +/5AtFrOQCQeLczhGeVoJgHWgKHOJYX7YClpLsKg=
Date:   Mon, 3 Jan 2022 10:54:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] kernfs: use kernfs_node specific mutex and
 spinlock.
Message-ID: <YdLH6qQNxa11YmRO@kroah.com>
References: <20220103084544.1109829-1-imran.f.khan@oracle.com>
 <20220103084544.1109829-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103084544.1109829-2-imran.f.khan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2022 at 07:45:43PM +1100, Imran Khan wrote:
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 861c4f0f8a29..5ed4c9ed39af 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -164,6 +164,8 @@ struct kernfs_node {
>  	unsigned short		flags;
>  	umode_t			mode;
>  	struct kernfs_iattrs	*iattr;
> +	spinlock_t kernfs_open_node_lock;
> +	struct mutex kernfs_open_file_mutex;

Did you just blow up the memory requirements of a system with lots of
kobjects created?

We used to be able to support tens of thousands of scsi devices in a
32bit kernel, with this change, what is the memory difference that just
happened?

There is a tradeoff of memory usage and runtime contention that has to
be made here, and this might be pushing it in the wrong direction for
a lot of systems.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805C148A873
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348488AbiAKHdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:33:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43074 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiAKHda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:33:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 014EBB818BB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 07:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6359C36AE3;
        Tue, 11 Jan 2022 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641886407;
        bh=m54T7ETLgQXBw2EpYQrmbMEPpODgoRADLiRj/ynuNw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PxqY+n6IQkLK72+cq13Sys/PtegXgODUxNnpfwjhi6UZ7wwVVeZcu/FIUTkLMUpND
         dWNrf61pBjFa7m76wBqMkrOio4n0IBX1HOE4uDXojrI2EZT6noVe0lUSya2MTRvv+i
         tC7h4JXyOEzjwYNe8K2Rz4TW+lvImTZn4eDoZpS8=
Date:   Tue, 11 Jan 2022 08:33:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     cruise k <cruise4k@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, sunhao.th@gmail.com
Subject: Re: INFO: task hung in devtmpfs_submit_req
Message-ID: <Yd0yw1xRixkdmhfP@kroah.com>
References: <CAKcFiNDwEUw+sLxfdFgYsrX7WrqtgbhvNi_ncZx040VFgF-cfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKcFiNDwEUw+sLxfdFgYsrX7WrqtgbhvNi_ncZx040VFgF-cfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:41:06AM +0800, cruise k wrote:
> Hi,
> 
> Syzkaller found the following issue:
> 
> HEAD commit: 75acfdb Linux 5.16-rc8
> git tree: upstream
> console output: https://pastebin.com/raw/gwHBn2EB
> kernel config: https://pastebin.com/raw/XsnKfdRt
> 
> And hope the report log can help you.
> 
> INFO: task kworker/6:4:13959 blocked for more than 145 seconds.
>       Not tainted 5.16.0-rc8+ #10
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/6:4     state:D stack:26944 pid:13959 ppid:     2 flags:0x00004000
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  __schedule+0xcd9/0x2550
>  schedule+0xd2/0x260
>  schedule_timeout+0x5e5/0x890
>  wait_for_completion+0x17b/0x280
>  devtmpfs_submit_req+0xa8/0x100
>  devtmpfs_delete_node+0xe1/0x150
>  device_del+0xadf/0xe80
>  usb_disconnect+0x4a4/0x8c0
>  hub_event+0x199c/0x4090
>  process_one_work+0x9df/0x16a0
>  worker_thread+0x90/0xe20
>  kthread+0x405/0x4f0
>  ret_from_fork+0x1f/0x30
>  </TASK>

Wonderful, please submit a change to resolve this issue.

thanks,

greg k-h

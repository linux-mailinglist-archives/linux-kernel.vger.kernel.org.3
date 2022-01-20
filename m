Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E64494F92
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbiATNve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:51:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230115AbiATNve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642686693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mbzRm40XNOcc6LfnmL8S8oFyNln2jL+JuCRRkKkQZQ4=;
        b=CM+ZayUKOWifgX5cuGRIOzmiuBnrozQCthPM/oQvvWTlC851UIWmCzRWCpjt28BSIF/BtO
        X0s+N7RquB6lHtmndfV/ljj6zPkF8gAgpM9dW13E60XlBV63+ZMEGQxZQAAxB0+s4iY6sj
        sGzvhghNA/IfSiZkOlLmDUyRy7iybLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443--boour0kOmOdZ1mVIFBM1g-1; Thu, 20 Jan 2022 08:51:30 -0500
X-MC-Unique: -boour0kOmOdZ1mVIFBM1g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FB9B1935790;
        Thu, 20 Jan 2022 13:51:29 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5842278AA6;
        Thu, 20 Jan 2022 13:51:24 +0000 (UTC)
Date:   Thu, 20 Jan 2022 21:51:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] block: hold queue lock while iterating in
 diskstats_show
Message-ID: <Yelo1gx5cp1l4npK@T590>
References: <20220120105248.117025-1-dwagner@suse.de>
 <20220120105248.117025-3-dwagner@suse.de>
 <Yelb4+r5KuV67tO0@T590>
 <20220120131936.mlug7nhnoe73abx5@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120131936.mlug7nhnoe73abx5@carbon.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 02:19:36PM +0100, Daniel Wagner wrote:
> Hi Ming,
> 
> On Thu, Jan 20, 2022 at 08:56:03PM +0800, Ming Lei wrote:
> [323467.255527] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [323467.255538] #PF: supervisor read access in kernel mode
> [323467.255541] #PF: error_code(0x0000) - not-present page
> [323467.255544] PGD 0 P4D 0 
> [323467.255550] Oops: 0000 [#1] SMP PTI
> [323467.255555] CPU: 13 PID: 17640 Comm: iostat Kdump: loaded Tainted: G          IOE  X    5.3.18-59.27-default #1 SLE15-SP3
> [323467.255559] Hardware name: Dell Inc. PowerEdge R940xa/08XR9M, BIOS 2.12.2 07/12/2021
> [323467.255569] RIP: 0010:blk_mq_queue_tag_busy_iter+0x1e4/0x2e0

Then Can you figure out where blk_mq_queue_tag_busy_iter+0x1e4 points to
in source code? And what is NULL pointer?

With this kind of info, we may know the root cause.

Thanks,
Ming


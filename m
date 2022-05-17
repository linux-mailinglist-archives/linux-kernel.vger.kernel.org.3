Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAE4529AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbiEQHdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241446AbiEQHdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:33:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6470948880
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:33:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC165B81676
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D94C34100;
        Tue, 17 May 2022 07:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652772791;
        bh=JnKhot49AQ23lOcrtqk4NwHL4epXuNlMmnHN6bV6tfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CgGCbPOQ6w01m1aNiu7wrBBn6TgMSuY1atWW44NTSBWIaIe2VRM6AliZOpJSJKYuK
         lQ+RXA0OvFQUD3I7XYYOjnItlnsbpfYe3vY0TBYlB0Qa/bmuhvcHGm2Z8AJE904Nrb
         D5fCDOGHyjC35pjxwiNQFIJ97jUxO5pNnFQp2RXs=
Date:   Tue, 17 May 2022 09:33:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: Replace mutex info_lock with percpu_ref
Message-ID: <YoNPs1EtUBBxOJ+w@kroah.com>
References: <1652161831-77791-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652161831-77791-1-git-send-email-kanie@linux.alibaba.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 01:50:31PM +0800, Guixin Liu wrote:
> If the underlying driver works in parallel, the mutex info_lock in uio 
> will force driver to work sequentially, so that become performance 
> bottleneck. Lets replace it with percpu_ref for better performance. 
> 
> Use tcm_loop and tcmu(backstore is file, and I did some work to make tcmu
> work in parallel at uio_write() path) to evaluate performance,
> fio job: fio -filename=/dev/sdb  -direct=1 -size=2G -name=1 -thread
> -runtime=60 -time_based  -rw=randread -numjobs=16 -iodepth=16 -bs=128k
> 
> Without this patch:
> 	READ: bw=2828MiB/s (2965MB/s), 176MiB/s-177MiB/s (185MB/s-186MB/s), 
> io=166GiB (178GB), run=60000-60001msec
> 
> With this patch:
> 	READ: bw=3382MiB/s (3546MB/s), 211MiB/s-212MiB/s (221MB/s-222MB/s), 
> io=198GiB (213GB), run=60001-60001msec
> 
> Reviewed-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>

Any reason why you didn't cc: this person on the patch submission so
that they would be part of the conversation about it?

thanks,

greg k-h

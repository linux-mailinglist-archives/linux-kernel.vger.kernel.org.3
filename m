Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E4E4D5BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346865AbiCKGxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245026AbiCKGxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:53:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7671AA06E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:52:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09AC9B829B8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 06:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C37C340F3;
        Fri, 11 Mar 2022 06:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646981531;
        bh=hmWjwGGSOeiCsTBFJneq7gI3Jc47FBu2bCw46XDp03U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQPaXYV4sORqZHniZtZNoVZ2gRUkzCvZ6eu1l5B2WUpbGE1zpFgZIhChhpjp01YZE
         ByUROiaHjIv0u+BFup3HjBQwtgG1hf1aAl+tOQ5D5alg3QOPW18ZT96ORDtgRmdwqt
         1W1oVH9Uuhoc4fSkwG4QvDwJTbGlfJqI/ExD3UTs=
Date:   Fri, 11 Mar 2022 07:52:07 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, javier@javigon.com,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4] drivers: ddcci: upstream DDCCI driver
Message-ID: <YirxlzkYxl3MIjoR@kroah.com>
References: <20220310055922.459460-1-yusisamerican@gmail.com>
 <3c0422d9-8ce9-64d8-f332-e07bc8e207c4@infradead.org>
 <CAJoG2+8OcL=5RRptaNMhXkFeDragq46_WpHpuN8XEP+jNbdZ0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJoG2+8OcL=5RRptaNMhXkFeDragq46_WpHpuN8XEP+jNbdZ0w@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 05:19:47PM -0800, Yusuf Khan wrote:
> I (hopefully) fulfilled those requests in my subsequent patch,
> turns out I forgot to git add some of my changes. I did not
> remove the unlikely()s  as I think they look good and point
> to where error checking is that many may miss.

Never use a unlikely() or likely() macro unless you can prove, with a
benchmark, that it makes the code go faster.  If not, just remove them
as the compiler and CPU will always do a better job at this (we have
proof of it in the past.)

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCC14EE817
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 08:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245329AbiDAGTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 02:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbiDAGTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:19:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF51E6EB5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 23:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B0F060BB5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A73DC2BBE4;
        Fri,  1 Apr 2022 06:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648793864;
        bh=8HJ2dThZuhlAG/zKt+3MnNMi7qOyxQ+9IpdZjNkR/lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MRJ+IqR6sNNK49lG+DQI4teQUGEdOP/AyEcFA7JW4CBs1h0S8V8NersUv1Z0hBF8u
         GR8o9y3awtwy6o3EozMKGc/PdiSC33dLBgNn4XEkoRcDwESnTaSGGH8m8wF8RDPQDh
         ABHoDqrBI9S2v8A+K9e4c1O5VtVG6DRgb4iynUsg=
Date:   Fri, 1 Apr 2022 08:17:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Yao Hongbo <yaohongbo@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH] uio/uio_pci_generic: Introduce refcnt on open/release
Message-ID: <YkaZBWqcOSBO28HU@kroah.com>
References: <1648692384-109967-1-git-send-email-yaohongbo@linux.alibaba.com>
 <20220331162521-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331162521-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 04:29:23PM -0400, Michael S. Tsirkin wrote:
> On Thu, Mar 31, 2022 at 10:06:24AM +0800, Yao Hongbo wrote:
> > If two userspace programs both open the PCI UIO fd, when one
> > of the program exits uncleanly, the other will cause IO hang
> > due to bus-mastering disabled.
> 
> With two programs poking at the same device, how is this ever
> supposed to work even while both are alive?
> 
> > It's a common usage for spdk/dpdk to use UIO.
> 
> Except people really should just use vfio ...

Yes they should, the kernel should not care if multiple programs open
the same UIO device node, it can not prevent that and userspace is on
it's own here as it _should_ know what it is doing.

thanks,

greg k-h

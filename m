Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC9654C2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346773AbiFOHlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243934AbiFOHlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C64B3AA6E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29A0C618F5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F81AC341C5;
        Wed, 15 Jun 2022 07:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655278858;
        bh=hoIk4nSZKSUgOeeJkohO5SOkmhY2HlMd4RFU6ZcXnlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qOhpnVHKbXmQuvQ8jU61HMxvpc0pynX2MIruxMkRknS+Bxu8HOEWpGOAdBOXCntQ4
         5ntfaTOZA5XwDRS7df+6ee1kpgeREfm+LNFpjGRtHOwSc1Tru2rxQSqycxee+dHSzd
         xhaebeXF61vrXbvf0d8/nmuladeY1JRVOY+Si6QI=
Date:   Tue, 14 Jun 2022 20:44:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Will McVicker <willmcvicker@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] sysfs: fix sysfs_kf_seq_show null pointer dereference
Message-ID: <YqjXBEslHagtL+Kd@kroah.com>
References: <20220614172401.3010509-1-willmcvicker@google.com>
 <YqjFPxuPO6SZuvg2@kroah.com>
 <CABYd82ZwAnjnBbJh73op32tKkcR-X96qtnFFJKLifYvs2ei9eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABYd82ZwAnjnBbJh73op32tKkcR-X96qtnFFJKLifYvs2ei9eA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 11:38:27AM -0700, Will McVicker wrote:
> On Tue, Jun 14, 2022 at 10:31 AM Greg Kroah-Hartman <
> gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Jun 14, 2022 at 05:24:01PM +0000, Will McVicker wrote:
> > > When the kobj->ktype is null,
> >
> > How can that happen?  What in-tree code does that?
> 
> This kernel panic happens randomly for me. The call trace shows that this
> happens when the read syscall is invoked by Android. GDB gave me this line
> when disassembling __arm64_sys_read+0x20/0x30:
> 
> fs/read_write.c:628
> SYSCALL_DEFINE3(read, unsigned int, fd, char __user *, buf, size_t, count)

What sysfs file is it reading?  Any hint about that?

thanks,

greg k-h

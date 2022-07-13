Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E88E5736D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiGMNGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiGMNGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:06:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CFB8F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 708E5B81F01
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A73EC34114;
        Wed, 13 Jul 2022 13:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657717589;
        bh=I/8fgDiVhnQn+g4npPm+EFV2apCMQYq4lmg3gRkrX5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RCnnZ5qfDQxP81MKBUlOpjlcR8nVBAkxZYruHpAfkjACJXmeHrCjG7/7ak8I7mERB
         bClPoF99tHTeV+XmL8u9WAZzgVRdlp5dACgY1ZDgjX1rZZm2BC4HFILR7vhRFnS1mI
         AFC+ubeNtWL7LXuMWpsVCX6tKTSm7h0x7/9eIqAg=
Date:   Wed, 13 Jul 2022 15:06:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki : --cc=" <rafael@kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH] drivers/base/node.c: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <Ys7DUYXuzwUvQzT6@kroah.com>
References: <20220712214301.809967-1-pauld@redhat.com>
 <CAGsJ_4xG0az1-g8DWL-mEv_cF3ZBMe6j87m_cxeL9abvxGNW=g@mail.gmail.com>
 <Ys6ud4JmMGjktAlL@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys6ud4JmMGjktAlL@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 07:37:27AM -0400, Phil Auld wrote:
> On Wed, Jul 13, 2022 at 11:18:59AM +1200 Barry Song wrote:
> > On Wed, Jul 13, 2022 at 9:58 AM Phil Auld <pauld@redhat.com> wrote:
> > >
> > > Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> > > This breaks userspace code that retrieves the size before reading the file. Rather
> > > than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> > > limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> > > comparison and a worst-case maximum to ensure compile time constants. For cpulist the
> > > max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960.
> > > In order to get near that you'd need a system with every other CPU on one node or
> > > something similar. e.g. (0,2,4,... 1024,1026...). We set it to a min of PAGE_SIZE
> > > to retain the older behavior. For cpumap, PAGE_SIZE is plenty big.
> > >
> > > On an 80 cpu 4-node system (NR_CPUS == 8192)
> > >
> > > before:
> > >
> > > -r--r--r--. 1 root root 0 Jul 12 14:08 /sys/devices/system/node/node0/cpulist
> > > -r--r--r--. 1 root root 0 Jul 11 17:25 /sys/devices/system/node/node0/cpumap
> > 
> > it is a fundamental problem of bin_attr, isn't it? when we don't know the
> > exact size of an attribute, and this size might become more than one
> > PAGE_SIZE, we use bin_attr to break the limitation. but the fact is that
> > we really don't know or it is really hard to know the actual size of the
> > attribute.
> >
> 
> But it broke userspace applications. I figured rather than revert it maybe
> we can find a max size to put in there and make it continue to work.

Yes, we need to do this, we can't break userspace.

thanks,

greg k-h

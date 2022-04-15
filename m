Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D2750266E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 09:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351269AbiDOH4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiDOH4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 03:56:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2959BB84;
        Fri, 15 Apr 2022 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TY7QrgqvgkH5i76LkYOioJ0Vkl4t7pW84wpQ7D92y58=; b=AcTLpeAaH8w+tdpl/NmhorrElG
        atvXYjPxEjQikC6x8SE+8HDVNTKWoEM+FsvUcvG076jAx7xNIBIvcqgiwE0V3stZBhNYOXvvA8vnZ
        zc4gx12b/A49yO4WhN6hQsKF84PF1ZIKeDYCKEyTke1hgE7VU8FSAQ7J9g203MaXF6QO8AGljarVP
        CiPXaijMzIGIDUDOW4kMw/7ezQFealbxmBG93M5cbBcYs9iGkeAWRYzU3JLVT2kx8bAwbi1fzS0Tr
        4+8w56oKLwIqD+IPKGefsfHR8DOgu51TXQliqANImjXt/+Xm+usnuab0TgQGxZ+xFgwj5I68klTUD
        SZQ9CvVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfGm5-00Fwly-Ay; Fri, 15 Apr 2022 07:53:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E02683001AE;
        Fri, 15 Apr 2022 09:53:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D2DF2025D913; Fri, 15 Apr 2022 09:53:48 +0200 (CEST)
Date:   Fri, 15 Apr 2022 09:53:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v2 02/12] device-core: Add dev->lock_class to enable
 device_lock() lockdep validation
Message-ID: <YlkkjLJg4a+2gqiq@hirez.programming.kicks-ass.net>
References: <164982968798.684294.15817853329823976469.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164982969858.684294.17819743973041389492.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220413084309.GV2731@worktop.programming.kicks-ass.net>
 <CAPcyv4huZVNkxa7-rQ_J=nVN77+5F1AJg5vi6kLHp8t5khcwHA@mail.gmail.com>
 <Ylf0dewci8myLvoW@hirez.programming.kicks-ass.net>
 <CAPcyv4hFabn6H064HTrH8=GQ-cxsOk4xEK8s66JQxQavfgAzGw@mail.gmail.com>
 <Ylh3ISDToV5y9/4P@hirez.programming.kicks-ass.net>
 <CAPcyv4hwsKCbaxDhAL6LPZQmLZZV2T4wpja+cNZpjy=enR-eYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hwsKCbaxDhAL6LPZQmLZZV2T4wpja+cNZpjy=enR-eYQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 12:43:31PM -0700, Dan Williams wrote:
> On Thu, Apr 14, 2022 at 12:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Apr 14, 2022 at 10:17:13AM -0700, Dan Williams wrote:
> >
> > > One more sanity check... So in driver subsystems there are cases where
> > > a device on busA hosts a topology on busB. When that happens there's a
> > > need to set the lock class late in a driver since busA knows nothing
> > > about the locking rules of busB.
> >
> > I'll pretend I konw what you're talking about ;-)
> >
> > > Since the device has a longer lifetime than a driver when the driver
> > > exits it must set dev->mutex back to the novalidate class, otherwise
> > > it sets up a use after free of the static lock_class_key.
> >
> > I'm not following, static storage has infinite lifetime.
> 
> Not static storage in a driver module.
> 
> modprobe -r fancy_lockdep_using_driver.ko
> 
> Any use of device_lock() by the core on a device that a driver in this
> module was driving will de-reference a now invalid pointer into
> whatever memory was vmalloc'd for the module static data.

Ooh, modules (I always, conveniently, forget they exist). Yes, setting a
lock instance from the core kernel to a key that's inside a module and
then taking the module out will be 'interesting'.

Most likely you'll get a splat from lockdep when doing this.

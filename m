Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD764EBD9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbiC3JZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241356AbiC3JZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:25:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E969D1A394
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99B74B81AD3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06927C340EE;
        Wed, 30 Mar 2022 09:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648632243;
        bh=FnB+eetLKSZWwvwpCHBxn/lH1oH8POgxomiIoF95zWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPKUaD86K2+Y1DdBU/DBFMgGTXAZhdFudusreQiPZKL1Qxz9HBCKVkLmh9uPNh1bo
         Li9fASK0WGkZNL/WqyPsmqb1K92/JpekIZsNg9EKfqCckdcIqPu+MQJoA/GGS2YQ6t
         RcckUZri4lX71aubLSqSIFcv5tc8GTVK5FnGqYBQ=
Date:   Wed, 30 Mar 2022 11:24:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Race condition in kobject_get_path()
Message-ID: <YkQhsTpTdlfW0oXW@kroah.com>
References: <abc55eae-1e78-4389-e60c-db984ad8ed50@quicinc.com>
 <YkQhc5ZjWe35T8fU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkQhc5ZjWe35T8fU@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:22:59AM +0200, Greg KH wrote:
> On Wed, Mar 30, 2022 at 02:47:20PM +0530, Mukesh Ojha wrote:
> > Hi All,
> > 
> > We are facing one issue where one driver is trying to register its device
> > from driver probe
> > and from another path  dev_set_name() done from driver probe of the added
> > device whose
> > length can be more than earlier which could result in redzone overwritten
> > issue.
> 
> What drivers are doing this so we can see the code?  This should be
> happening in order and not at the same time.
> 
> > 
> > Can we get your suggestion here ? is this case of a race here ?
> > 
> > 
> > p1 p2
> > 
> > *kobject_get_path* <https://opengrok.qualcomm.com/source/s?refs=kobject_get_path&project=KERNEL.PLATFORM.1.0>
> > 
> > 
> >                             =>  get_kobj_path_length  (length is calculated
> > from this path)
> >                                dev_set_name(same dev name)
> >                                  => fill_kobj_path  (path is copied here)
> 
> I do not understand this trace, sorry.  What code are you referring to?

Also, the above link does not work for me :(

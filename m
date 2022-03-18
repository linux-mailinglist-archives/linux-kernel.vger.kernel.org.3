Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD14DDD49
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238303AbiCRPv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238299AbiCRPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:51:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872F72D654A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 261E261485
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98CCC340E8;
        Fri, 18 Mar 2022 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647618603;
        bh=5uXL2x8DBwPa0cjyYC6YBKuUMgI5fKBpohYJLpVwkRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLaxEglc7duHdibRRJgglHKlHginIPE1xSMZtIsv9GhGSrS2VkQFj99XdDp05uven
         Zvp+u2gSF5ARMCqDn0s/EtoYWiL8BrKzRrJXCDy9zmCCdGwAplqBeGePju0rZ0AeV2
         0NV1oHOpTZPeJAvqJt0N7ctm68j0JITWyMKmwgKM=
Date:   Fri, 18 Mar 2022 16:49:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH 07/16] debugfs: Add signed versions of
 debugfs_create_u32/64 helpers
Message-ID: <YjSqJ7KgM1spnT31@kroah.com>
References: <20220227205608.30812-1-cristian.marussi@arm.com>
 <20220227205608.30812-8-cristian.marussi@arm.com>
 <YjSHXJZAlntzmyKZ@kroah.com>
 <YjSnvKV7dElpzTcd@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjSnvKV7dElpzTcd@e120937-lin>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 03:39:40PM +0000, Cristian Marussi wrote:
> On Fri, Mar 18, 2022 at 02:21:32PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Feb 27, 2022 at 08:55:59PM +0000, Cristian Marussi wrote:
> > > Add a few helpers to deal with signed values integers; built on existing
> > > debugfs internal helpers as the existing unsigned functions already do.
> > > 
> > > Make the simple_attr_write() internal helper detect the sign of the
> > > requested set operation from the related format string: this is needed
> > > to be able to properly parse negatively signed input strings.
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> 
> Hi Greg,
> 
> thanks for the feedback.
> 
> > > Note that in the rest of the series I do NOT need the s64 WRITE/SET
> > > operations, that required the more invasive simple_attr_write() change,
> > > but it seemed odd to implement a get only debug_create_s32/64 API.
> > 
> > Let's wait to add them when we have a need for them with a in-kernel
> > user.  Otherwise I'll just end up removing them eventually when I sweep
> > for "is this used" cleanups.
> > 
> 
> Ok, so just to double check what I understood(or not), I'll leave out the
> setters ops and implement instead the debufs_create_s32/s64 with only RO
> fops support, right ?

Only create what you actually need.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD984C674D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbiB1KsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiB1Kr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:47:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109285B888;
        Mon, 28 Feb 2022 02:47:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBBA1B80FF2;
        Mon, 28 Feb 2022 10:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BB0C340E7;
        Mon, 28 Feb 2022 10:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646045236;
        bh=wKsdoTANU5hpG2zlBt0hwyF+7+quOlTjzA0JHxNClnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RRObxfQNLSdZIiAH3BZhaD4LIww+/AHsaRBHjOolKzZF4/eGh5zIjLWvg0q8H6yT8
         pA3jOoXTWA7jwLEhPde/cTtTNsVc2PnWb68hpE1E3mzdYrP6YrbRPY8k4ShYmP5/qh
         rVKF8m5KZDO7o0iyU0r3t7CtUoDT/zPuXAfWSYRU=
Date:   Mon, 28 Feb 2022 11:47:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     Bodo Stroesser <bostroesser@gmail.com>,
        Guixin Liu <kanie@linux.alibaba.com>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xlpang@linux.alibaba.com
Subject: Re: [PATCH 2/2] scsi:target:tcmu: reduce once copy by using uio ioctl
Message-ID: <YhyoMekPbsKjO7KG@kroah.com>
References: <1645064962-94123-1-git-send-email-kanie@linux.alibaba.com>
 <1645064962-94123-2-git-send-email-kanie@linux.alibaba.com>
 <eb08230b-c9a7-26ed-9431-9be3b9791385@gmail.com>
 <4aef53b1-3e0f-92eb-4bd3-cdc4cd301866@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aef53b1-3e0f-92eb-4bd3-cdc4cd301866@linux.alibaba.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 04:52:52PM +0800, Xiaoguang Wang wrote:
> 
> hi Bodo,
> 
> > Liu,
> > 
> > generally I like ideas to speed up tcmu.
> > 
> > OTOH, since Andy Grover implemented tcmu based on uio device, we are
> > restricted to what uio offers. With today's knowledge I think we would
> > not use the uio device in tcmu again, but switching away from uio now
> > would break existing userspace SW.
> Yeah, it will have much work if deciding to switch away from uio.
> I came up with a hacky or crazy idea :) what about we create a new file
> in tcmu_open() by anon_inode_getfile_secure(), and export this fd by
> tcmu mail box, we can do ioctl() on this new file, then uio framework
> won't be touched...

No new ioctls please.  That is creating a new user/kernel api that you
must support for the next 20+ years.  Please do not do that.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D057E58275F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiG0NJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiG0NJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:09:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C566F3C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:09:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEEFD6165E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 13:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0747C433D6;
        Wed, 27 Jul 2022 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658927368;
        bh=IYDLcAKXv/t7eNqAwBTA6CMf/htt9xYg7+mFITnxwmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1mvs57IjIqp4Fh7iev+2LO1V+4e1RjgVA+QWd4SvGXfL5pI6p80JJ1/oAsIVhowfE
         IMvVdA/9Aa5/xHLVf+nH9BocrQVmhcc4AmtIbkY33+uBADHWIDzwWMpHKHZP4mPrg0
         LZ5aQGXq3FQSKIk9B1zKeK9Ei9wMrA1j56dm5RCI=
Date:   Wed, 27 Jul 2022 15:09:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiho Chu <jiho.chu@samsung.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        yelini.jeong@samsung.com, myungjoo.ham@samsung.com
Subject: Re: [PATCH 4/9] trinity: Add schduler module
Message-ID: <YuE5BYqgDrSlw8k7@kroah.com>
References: <20220725065308.2457024-1-jiho.chu@samsung.com>
 <CGME20220725065309epcas1p42ba84c5241d69192ea73904ed6af17d7@epcas1p4.samsung.com>
 <20220725065308.2457024-5-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725065308.2457024-5-jiho.chu@samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 03:53:03PM +0900, Jiho Chu wrote:
> This patch includes NPU scheduler interface.
> 
> Tasks can be pushed to the NPU in order by the scheduler. The default
> schduling algorithm is provided using Priority policy.
> The scheduler waits request from the user. When the requests are
> invoked, it submits each request to the NPU by the priority, and waits
> until complete interrupt arrives. The priority is calculated with
> remained time to requested timeout.
> 
> Thus the scheduler algorithm may be added more in the later, it
> provides an interface which can support various schedulers.

Please do not add interfaces that you do not use at all.  Just make it
simple for the first version and then, if you really need to add new
types of "schedulers" add them later on.

As it is, this is a whole layer of abstraction that is not needed and
can be removed.

thanks,

greg k-h

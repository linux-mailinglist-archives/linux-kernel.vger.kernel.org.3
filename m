Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AD94EBD97
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbiC3JYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbiC3JYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:24:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D512AE25
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:23:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D40F6104D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07549C340EE;
        Wed, 30 Mar 2022 09:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648632182;
        bh=brpHtBxVuS3ZLsL1Fi+IfeBWIo75mcyggExqK08yFhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zjBE6YUWjMdMUzBtc3OqqoVaRGNgigFMUqp55Oy+4vhgAo/NSqeyp//MR2DjsRzie
         a5Wv83cQ1iFvqkJovAZRZKRiWR1Ybj51tmV3QtBrosx1XPSFglVkdhj6N4s6Md1uv0
         bYyeoZP186CxNdPfASC4roYj1rRAFRsX4eNp4A8U=
Date:   Wed, 30 Mar 2022 11:22:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Race condition in kobject_get_path()
Message-ID: <YkQhc5ZjWe35T8fU@kroah.com>
References: <abc55eae-1e78-4389-e60c-db984ad8ed50@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abc55eae-1e78-4389-e60c-db984ad8ed50@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 02:47:20PM +0530, Mukesh Ojha wrote:
> Hi All,
> 
> We are facing one issue where one driver is trying to register its device
> from driver probe
> and from another path  dev_set_name() done from driver probe of the added
> device whose
> length can be more than earlier which could result in redzone overwritten
> issue.

What drivers are doing this so we can see the code?  This should be
happening in order and not at the same time.

> 
> Can we get your suggestion here ? is this case of a race here ?
> 
> 
> p1 p2
> 
> *kobject_get_path* <https://opengrok.qualcomm.com/source/s?refs=kobject_get_path&project=KERNEL.PLATFORM.1.0>
> 
> 
>                             =>  get_kobj_path_length  (length is calculated
> from this path)
>                                dev_set_name(same dev name)
>                                  => fill_kobj_path  (path is copied here)

I do not understand this trace, sorry.  What code are you referring to?

confused,

greg k-h

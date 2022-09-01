Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167905A9DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiIARAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiIARAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC91756BA2;
        Thu,  1 Sep 2022 10:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D441561F84;
        Thu,  1 Sep 2022 17:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BCCC433D7;
        Thu,  1 Sep 2022 17:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662051642;
        bh=FTMoHP+jNZSkNY64LCbBMoNbVWgPQPrlzvsfYnZNwSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNtthusNx774p2hTkkHBazhxfYtW3+1EnRAGcvY4m4vd7fzFx9dWvvlZREXRnu0/+
         C64yHy8jhKr+f4qP4m380j3CM3f9yrjQQsLjm61+gt/qx1vZ3dREIqmhvzzQ6dnrHG
         3OTqWwJIzUcoQp8t47euECosedv9CmsYWfO1h/RrCtTKY2JvJJ+bAy9ivJwKsIRT57
         ajTt/tU6aEZTAoYBO84aqTH4cvdVYGp/hL+GYQvkwN7GUPBqiITvIjzwDBQEgHdzgg
         EnV2O7lYLCjTaeDyv3dnJRZ2VGy00o5/UD7SdvNB5QwDIGJI5eYAkxzKaCjjBASEcX
         IU3j4/LdMKJUQ==
Date:   Thu, 1 Sep 2022 10:00:40 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kai Ye <yekai13@huawei.com>, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com, liulongfang@huawei.com
Subject: Re: [PATCH v7 2/3] Documentation: add a isolation strategy sysfs
 node for uacce
Message-ID: <YxDlOFYih5tQ37Av@sol.localdomain>
References: <20220806022943.47292-1-yekai13@huawei.com>
 <20220806022943.47292-3-yekai13@huawei.com>
 <YxDJ6PEWd/3c1jPd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDJ6PEWd/3c1jPd@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 05:04:08PM +0200, Greg KH wrote:
> On Sat, Aug 06, 2022 at 10:29:42AM +0800, Kai Ye wrote:
> > Update documentation describing sysfs node that could help to
> > configure isolation strategy for users in the user space. And
> > describing sysfs node that could read the device isolated state.
> > 
> > Signed-off-by: Kai Ye <yekai13@huawei.com>
> > ---
> >  Documentation/ABI/testing/sysfs-driver-uacce | 26 ++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
> > index 08f2591138af..e09fd160d3fa 100644
> > --- a/Documentation/ABI/testing/sysfs-driver-uacce
> > +++ b/Documentation/ABI/testing/sysfs-driver-uacce
> > @@ -19,6 +19,32 @@ Contact:        linux-accelerators@lists.ozlabs.org
> >  Description:    Available instances left of the device
> >                  Return -ENODEV if uacce_ops get_available_instances is not provided
> >  
> > +What:           /sys/class/uacce/<dev_name>/isolate_strategy
> > +Date:           Jul 2022
> 
> July was a while ago, you sent this patch in August :(
> 

Does the date in the sysfs documentation files serve any purpose besides making
people have to update their patchsets every month?

The kernel version number would be more useful to readers of the documentation,
and it wouldn't have to be updated quite as often.

- Eric

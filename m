Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E794E5598B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiFXLoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiFXLo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:44:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0C64EDEC;
        Fri, 24 Jun 2022 04:44:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B754C6221A;
        Fri, 24 Jun 2022 11:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95C7C34114;
        Fri, 24 Jun 2022 11:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656071068;
        bh=wuFcb8zHRqDd4Ot8oA4+RHa9LKDGhYTvTXxLoTJJzjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gUfodt5d1PJr726uOh95E2mHi9RldLj005llgN4lHR09iIA2JJWy7To2jdB02Cqbr
         nJCscFPYWI1O+PjHe1yvqonyPWexOxARneP8FzGuynes2W/GT8aSNJf4laMstmCWcv
         E0umCEKb3FM48UTwBrLUBb7Rw/ozbUHr3XIkQb4s=
Date:   Fri, 24 Jun 2022 08:44:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yekai(A)" <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v4 2/3] Documentation: add a isolation strategy sysfs
 node for uacce
Message-ID: <YrVdXcO9VLe8J/FP@kroah.com>
References: <20220623061452.40732-1-yekai13@huawei.com>
 <20220623061452.40732-3-yekai13@huawei.com>
 <YrQr/3URWsdowov9@kroah.com>
 <f25514f8-2d34-5911-b29f-a520d1df3db4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f25514f8-2d34-5911-b29f-a520d1df3db4@huawei.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 11:25:10AM +0800, yekai(A) wrote:
> 
> 
> On 2022/6/23 17:01, Greg KH wrote:
> > On Thu, Jun 23, 2022 at 02:14:51PM +0800, Kai Ye wrote:
> > > Update documentation describing sysfs node that could help to
> > > configure isolation method command for users in th user space.
> > > 
> > > Signed-off-by: Kai Ye <yekai13@huawei.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-driver-uacce | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
> > > index 08f2591138af..8784efa96e01 100644
> > > --- a/Documentation/ABI/testing/sysfs-driver-uacce
> > > +++ b/Documentation/ABI/testing/sysfs-driver-uacce
> > > @@ -19,6 +19,24 @@ Contact:        linux-accelerators@lists.ozlabs.org
> > >  Description:    Available instances left of the device
> > >                  Return -ENODEV if uacce_ops get_available_instances is not provided
> > > 
> > > +What:           /sys/class/uacce/<dev_name>/isolate_strategy
> > > +Date:           Jun 2022
> > > +KernelVersion:  5.20
> > > +Contact:        linux-accelerators@lists.ozlabs.org
> > > +Description:    A sysfs node that used to configures the hardware error
> > > +                isolation method command. The command can be parsed
> > > +                in correct driver. e.g. If the device slot reset frequency
> > > +                exceeds the preset value in a time window, the device will be
> > > +                isolated.
> > 
> > What is the "command"?  What is being parsed?  This needs to be
> > documented a lot more here, this is very vague and not obvious at all.
> > 
> > 
> 
> This command is a string command issued by the user. After the command is
> configured, the acc driver parses the command.

I am sorry, but I do not understand what you mean here.  What exactly is
a "command"?  What format is it in?  What are valid commands?  What are
invalid commands?  Are these commands different for different devices?
What do the commands do?  What are the return values for the commands?
And so on.

You are creating a new user/kernel API here and so you must define it
very specifically.  You have not speficied anything for us to know how
this works at all and so we can not accept this for that reason alone
(nor should you want us to.)

thanks,

greg k-h

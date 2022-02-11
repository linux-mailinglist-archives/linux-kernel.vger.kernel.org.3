Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5AC4B23F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346145AbiBKLKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:10:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbiBKLKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:10:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6980AE58;
        Fri, 11 Feb 2022 03:10:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0461361451;
        Fri, 11 Feb 2022 11:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC18C340E9;
        Fri, 11 Feb 2022 11:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644577801;
        bh=33FdS46stfzSs/sG/CxUDAEbJjCWo6GD2sOd4EcXOk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vn+Huk6YEfMew3bvWssowMlIcmOA7tf8jOwQ31FhgmXiFSouMARkQeAMHVJam4X1S
         09ykEZLx8MmWMycmtIynxtrXvIk+jIZGxSykk1Mr7fMeletbxxDqnSO2DNqnJEvQaU
         LnadcQl3M76G9ujUWirc9m8fPYwC/pOchdqElDFk=
Date:   Fri, 11 Feb 2022 12:09:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        swboyd@chromium.org, khsieh@codeaurora.org, nganji@codeaurora.org,
        seanpaul@chromium.org, dmitry.baryshkov@linaro.org,
        aravindh@codeaurora.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
Message-ID: <YgZEBrgG4rIZsfxN@kroah.com>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
 <8d67484c7e4b9fb4560d2eca1f71c75fde8bae0d.camel@sipsolutions.net>
 <ebd340e4-2a02-d484-2ed0-9ee738d5b5c5@quicinc.com>
 <c59bc1af9974484075091333a3c98a2088251321.camel@sipsolutions.net>
 <a280fec2-754a-88ec-acc7-337e069e9148@quicinc.com>
 <c2a6e29063793eecc5c65d32af9d826544404ecc.camel@sipsolutions.net>
 <b60d30cf-e435-49c4-a251-b910bc2e94ae@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60d30cf-e435-49c4-a251-b910bc2e94ae@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 05:55:18PM -0800, Abhinav Kumar wrote:
> Hi Johannes
> 
> On 2/8/2022 1:54 PM, Johannes Berg wrote:
> > On Tue, 2022-02-08 at 13:40 -0800, Abhinav Kumar wrote:
> > > > 
> > > I am checking what usermode sees and will get back ( I didnt see an
> > > error do most likely it was EOF ). I didnt follow the second part.
> > 
> > I think probably it got -ENODEV, looking at kernfs_file_read_iter().
> > 
> > > If the file descriptor read returns EOF, even if we consider them
> > > separate how will it resolve this issue?
> > > 
> > > My earlier questions were related to fixing it in devcoredump to detect
> > > and fix it there. Are you suggesting to fix in usermode instead? How?
> > > 
> > 
> > Yeah, no, you cannot fix it in userspace.
> > 
> > But I just followed the rabbit hole down kernfs and all, and it looks
> > like indeed the read would be cut short with -ENODEV, sorry.
> > 
> > It doesn't look like there's good API for this, but it seems at least
> > from the underlying kernfs POV it should be possible to get_device() in
> > open and put_device() in release, so that the device sticks around while
> > somebody has the file open? It's entirely virtual, so this should be OK?
> > 
> > johannes
> 
> Are you suggesting something like below?
> 
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 42dcf96..14203d0 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -32,6 +32,22 @@ static const struct sysfs_ops *sysfs_file_ops(struct
> kernfs_node *kn)
>         return kobj->ktype ? kobj->ktype->sysfs_ops : NULL;
>  }
> 
> +static int sysfs_kf_open(struct kernfs_open_file *of)
> +{
> +       struct kobject *kobj = of->kn->parent->priv;
> +       struct device *dev = kobj_to_dev(kobj);
> +
> +       get_device(dev);
> +}
> +
> +static void sysfs_kf_release(struct kernfs_open_file *of)
> +{
> +       struct kobject *kobj = of->kn->parent->priv;
> +       struct device *dev = kobj_to_dev(kobj);
> +
> +       put_device(dev);
> +}


That obviously does not work as not everything in sysfs is a struct
device :(


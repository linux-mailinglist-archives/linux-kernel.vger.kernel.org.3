Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AD44B9906
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiBQGOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:14:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiBQGOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:14:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7B2A2284;
        Wed, 16 Feb 2022 22:13:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D0206187C;
        Thu, 17 Feb 2022 06:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09281C340E8;
        Thu, 17 Feb 2022 06:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645078427;
        bh=XU8/+T6y9Te4fAEm5lTKGoyHAI0zLBhVl/DOvgsvegA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HbviZq4sfYH0qT4Fj5pJNhPhNa9Dj1X44lE7ldQzZBHvTZ/EfVjHHm3p9YLeTxKXv
         1hbqWcz3SjUsRWQSMW0MudUt5ePK6DaRMlFurAwS1T6nmyl6Dm1TnM0pqXrdQwJq0a
         ulYejbbtXiDVyviLQKws8XgegftWQLGSl613Mz1U=
Date:   Thu, 17 Feb 2022 07:13:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     bostroesser@gmail.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        xlpang@linux.alibaba.com
Subject: Re: [PATCH 1/2] uio: add ioctl to uio
Message-ID: <Yg3nmK7iWp7FuoOa@kroah.com>
References: <1645064962-94123-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645064962-94123-1-git-send-email-kanie@linux.alibaba.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 10:29:21AM +0800, Guixin Liu wrote:
> In TCMU, if backstore holds its own userspace buffer, for read cmd, the
> data needs to be copied from userspace buffer to tcmu data area first,
> and then needs to be copied from tcmu data area to scsi sgl pages again.
> 
> To solve this problem, add ioctl to uio to let userspace backstore can
> copy data between scsi sgl pages and its own buffer directly.
> 
> Reviewed-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>  drivers/uio/uio.c          | 22 ++++++++++++++++++++++
>  include/linux/uio_driver.h |  1 +

No, sorry, thie uio driver will not be adding ioctls to them.  If you
need an ioctl, then you should not be using the UIO api but rather use a
custom character driver instead.

thanks,

greg k-h

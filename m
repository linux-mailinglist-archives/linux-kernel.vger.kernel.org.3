Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEB74BA01C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbiBQM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:29:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiBQM3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:29:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674191732C1;
        Thu, 17 Feb 2022 04:28:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01351618D6;
        Thu, 17 Feb 2022 12:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41E8C340E8;
        Thu, 17 Feb 2022 12:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645100928;
        bh=hL/L8b4BKTDSEL6x9ErWbSWgnedtCgnztDYMuXioWCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QU7LJvepojWAFAgruilB0ehE54VngITJb5bW13FTGehcQ/yIvmU/s+VWcJwv8YfED
         UQXSmxRW8WYG7WIAHyyPGF4VNkCpUZWVf6wzKCICjxxzlbGI/CHKqmdZxCP5hRbKG6
         r1oha79XzUM0dVikBAq1uLPRbrGv9rbEBfCXYYQ0=
Date:   Thu, 17 Feb 2022 13:28:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     Guixin Liu <kanie@linux.alibaba.com>, bostroesser@gmail.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xlpang@linux.alibaba.com
Subject: Re: [PATCH 2/2] scsi:target:tcmu: reduce once copy by using uio ioctl
Message-ID: <Yg4/fTrGdK1OYai/@kroah.com>
References: <1645064962-94123-1-git-send-email-kanie@linux.alibaba.com>
 <1645064962-94123-2-git-send-email-kanie@linux.alibaba.com>
 <Yg4gL1tL7yJELNL2@kroah.com>
 <bc301d7d-49a7-8523-0bd4-f7f2a2fbfa81@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc301d7d-49a7-8523-0bd4-f7f2a2fbfa81@linux.alibaba.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 07:13:07PM +0800, Xiaoguang Wang wrote:
> hi,
> 
> > On Thu, Feb 17, 2022 at 10:29:22AM +0800, Guixin Liu wrote:
> > > --- a/include/uapi/linux/target_core_user.h
> > > +++ b/include/uapi/linux/target_core_user.h
> > > @@ -185,4 +185,13 @@ enum tcmu_genl_attr {
> > >   };
> > >   #define TCMU_ATTR_MAX (__TCMU_ATTR_MAX - 1)
> > > +struct tcmu_data_xfer {
> > > +	unsigned short cmd_id;
> > > +	unsigned long iov_cnt;
> > > +	struct iovec __user *iovec;
> > > +};
> > That is no way to define a structure that crosses the user/kernel
> > boundry, it just will not work at all, even if we wanted it to :(
> Sorry, I don't quite understand your comments well, can you explain more why
> this structure
> does not work, except that "unsigned short" or "unsigned long" here isn't
> correct, should use
> u16 or u32.

__u32 and __u16 must be used for structures like this.  Also it's
unaligned and has a hole in it, and will cause problems with compilers.
You didn't try this on a 32/64bit system either :(

thanks,

greg k-h

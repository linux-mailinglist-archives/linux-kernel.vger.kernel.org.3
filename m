Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04484B9CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239080AbiBQKPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:15:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiBQKPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:15:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC2A2AAB3D;
        Thu, 17 Feb 2022 02:15:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45F00B820B3;
        Thu, 17 Feb 2022 10:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40701C340E8;
        Thu, 17 Feb 2022 10:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645092913;
        bh=99+3Rkag+n6hqU+y7F8k/uyn3+KPpbhOvvdGy8sTHls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ayQFuDuCYHMAajv5eGocJAnJGnfoNg+H70bxHXWdGurvTieQ3EP2i/4maqtCWNqIG
         e06jEgEmbHOLvkbqt0p3kc3JJfhliCN7fbKzxyxnOioJjGnm84JTURvuihnN4Z9XJ5
         aQ9ITbxRR3HI9kB0fCkULlErOofvD+er7rtqAKrE=
Date:   Thu, 17 Feb 2022 11:15:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     bostroesser@gmail.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguang.wang@linux.alibaba.com,
        xlpang@linux.alibaba.com
Subject: Re: [PATCH 2/2] scsi:target:tcmu: reduce once copy by using uio ioctl
Message-ID: <Yg4gL1tL7yJELNL2@kroah.com>
References: <1645064962-94123-1-git-send-email-kanie@linux.alibaba.com>
 <1645064962-94123-2-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645064962-94123-2-git-send-email-kanie@linux.alibaba.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 10:29:22AM +0800, Guixin Liu wrote:
> --- a/include/uapi/linux/target_core_user.h
> +++ b/include/uapi/linux/target_core_user.h
> @@ -185,4 +185,13 @@ enum tcmu_genl_attr {
>  };
>  #define TCMU_ATTR_MAX (__TCMU_ATTR_MAX - 1)
>  
> +struct tcmu_data_xfer {
> +	unsigned short cmd_id;
> +	unsigned long iov_cnt;
> +	struct iovec __user *iovec;
> +};

That is no way to define a structure that crosses the user/kernel
boundry, it just will not work at all, even if we wanted it to :(

sorry,

greg k-h

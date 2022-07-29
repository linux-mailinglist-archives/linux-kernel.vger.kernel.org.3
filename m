Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F416C584D33
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiG2IMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbiG2IMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:12:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0067F52F;
        Fri, 29 Jul 2022 01:12:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FD43B82701;
        Fri, 29 Jul 2022 08:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D374CC433D6;
        Fri, 29 Jul 2022 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659082330;
        bh=lS6IOHyc0723JKW2Koe5554iUAaBJR0A5g1NPsHbWSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M1fLyvzIS9bGi5L1b1Wo44D4VoXlMchvH4aVLVHRqIbG53kOv46eTJBTgBwe1X0oK
         utEuzdFXLxv8TPgo1UqsS5Y+tz0FRB8RyqFdqHMxy0irIDM8T6Csch+MK8uAr1I30A
         F736+XyoPVN43rCsgCpzOR1kmi4Pu4SqB8TQO4gs=
Date:   Fri, 29 Jul 2022 10:12:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ufs: core: print UFSHCD capabilities in
 controller's sysfs node
Message-ID: <YuOWV5uLVV2JYP1c@kroah.com>
References: <20220729020508.4147751-1-dlunev@chromium.org>
 <20220729120216.v3.2.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729120216.v3.2.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:05:08PM +1000, Daniil Lunev wrote:
> Allows userspace to check if Clock Scaling, Write Booster and Inline
> Crypto Engine functionality can be enabled.
> 
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> 
> ---
> 
> Changes in v3:
> * Expose each capability individually.
> * Update documentation to represent new scheme.
> 
> Changes in v2:
> * Add documentation entry for the new sysfs node.
> 
>  Documentation/ABI/testing/sysfs-driver-ufs | 39 ++++++++++++++++++++
>  drivers/ufs/core/ufs-sysfs.c               | 41 ++++++++++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
> index 6b248abb1bd71..805d76f7d7aef 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -1591,6 +1591,45 @@ Description:	This entry shows the status of HPB.
>  
>  		The file is read only.
>  
> +What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/clock_scaling

This shouldn't be linked to as a driver file, it's a device file.  So no
need for this line.

> +What:		/sys/bus/platform/devices/*.ufs/capabilities/clock_scaling

Since when are all ufs devices platform devices?  Do we not have UFS
controllers on other types of busses?

thanks,

greg k-h

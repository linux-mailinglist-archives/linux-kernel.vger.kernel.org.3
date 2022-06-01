Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCB553AB85
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356237AbiFARG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350643AbiFARG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:06:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1D7A0D3D;
        Wed,  1 Jun 2022 10:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 286BF615B6;
        Wed,  1 Jun 2022 17:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A06DC385B8;
        Wed,  1 Jun 2022 17:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654103185;
        bh=HUU8KrBYMgNbvThGui3Jk0bCiWFX14Kr1oZeCG9HoUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uEKepc9IV5eV3Xnid76TgLGHN/xVD8Nknt2e27ubSavP6nZtj0k5B5klEeJzs1p0M
         4z7YIlY9GC1Czqq1gylqEkkp81+vHsfPgQYC7bdMdJyvASNkBNQpZL4OStBukyxVd8
         7/ypK1lkClxCpnrubC4ecZ9RU8SXfPj41+w+B7bnmDjBXnqkKyDL4DXRzj21WDrz1d
         RxcvwQyfyL4HyJHoJKsMf6kqWwAQqErdy8xzUtkx6Df33zubRL2Rkzo0iDlf6bYCO8
         p6j7J97k38zPsChaQxGEBFt7BpKXtrU+fO9FrBOKNKqwXewYNSVC6u1E7vnPXHMBPU
         J+qaWbkDJ2I+A==
Date:   Wed, 1 Jun 2022 10:06:23 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Subject: Re: [PATCH] scsi: ufs: add a quirk to disable FUA support
Message-ID: <Ypecj07egjAZTZbK@google.com>
References: <20220531201053.3300018-1-jaegeuk@kernel.org>
 <d3038c9e-c9ec-16e9-bad4-8b1de5e23ba6@intel.com>
 <3e13bf8f-060c-fc81-4405-e7d5820518cc@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e13bf8f-060c-fc81-4405-e7d5820518cc@acm.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01, Bart Van Assche wrote:
> On 5/31/22 22:24, Adrian Hunter wrote:
> > On 31/05/22 23:10, Jaegeuk Kim wrote:
> > > +	/*
> > > +	 * This quirk disables FUA support.
> > > +	 */
> > > +	UFSHCD_QUIRK_BROKEN_FUA				= 1 << 17,
> > 
> > Wouldn't it be more appropriate to make it a UFS_DEVICE_QUIRK_
> > since it presumably depends on the UFS device not the host controller?
> > 
> > Also, as already commented by others, there needs to be a user of
> > the quirk
> 
> Another possibility is to use the generic SCSI blacklist mechanism. See also
> the scsi_static_device_list array. See also /proc/scsi/device_info. From
> scsi_devinfo.c:
> 
> /*
>  * proc_scsi_dev_info_write - allow additions to scsi_dev_info_list via
>  * /proc.
>  *
>  * Description: Adds a black/white list entry for vendor and model with
>  * an integer value of flag to the scsi device info list.
>  * To use, echo "vendor:model:flag" > /proc/scsi/device_info
>  */

Good to know. Thank you, Bart.

> 
> Thanks,
> 
> Bart.

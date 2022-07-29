Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D39584D68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiG2IcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiG2IcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:32:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2857D1CC;
        Fri, 29 Jul 2022 01:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A342B826F0;
        Fri, 29 Jul 2022 08:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00F8C433C1;
        Fri, 29 Jul 2022 08:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659083537;
        bh=9Q0MNhoqEt6iJgN9HLzuAyJsP2J06Va6Xapeha90OEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xS4QMSlqbD7bc5DHXuSuJuZwFWTvWRwgn6F5Wlfv71/TCKcuUSS18rPFwHHm/2mGF
         FrN+NsyyLY3CStC5D9Nx5Ev4WaRFTGB52DPW8L9bhygzLSikAW6Qli6zPLuPRn4AM1
         Q8XGpKUpV3/cnSJdaMSU9EtcFPYjsETPZMcTHlII=
Date:   Fri, 29 Jul 2022 10:32:14 +0200
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
Message-ID: <YuObDu4fwPgpoWQn@kroah.com>
References: <20220729020508.4147751-1-dlunev@chromium.org>
 <20220729120216.v3.2.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
 <YuOWV5uLVV2JYP1c@kroah.com>
 <CAONX=-cy_abLBw1uAEYk6pxmyuQQ4qeQRftZVi7byNuYnEsA+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONX=-cy_abLBw1uAEYk6pxmyuQQ4qeQRftZVi7byNuYnEsA+w@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 06:29:45PM +1000, Daniil Lunev wrote:
> > >
> > > +What:                /sys/bus/platform/drivers/ufshcd/*/capabilities/clock_scaling
> >
> > This shouldn't be linked to as a driver file, it's a device file.  So no
> > need for this line.
> >
> > > +What:                /sys/bus/platform/devices/*.ufs/capabilities/clock_scaling
> >
> > Since when are all ufs devices platform devices?  Do we not have UFS
> > controllers on other types of busses?
> 
> I have pretty much copped the structure of the entries across this file. Nearly
> all of the entries link both device and driver paths and nearly all of
> the entries
> mention the platform-based path (which you correctly mentioned is not
> factually correct, since we do have controllers on the pci bus). Please advise
> if it is ok to keep it like this for consistency or what would be the
> appropriate
> way to adjust the documentation?

Ah, ok, that's odd.  Let's just leave this as-is for now, hopefully
someone else cleans this up later.

thanks,

greg k-h

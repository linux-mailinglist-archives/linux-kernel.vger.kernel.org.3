Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6485E588B60
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 13:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbiHCLeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 07:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbiHCLds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 07:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C5E4E61E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 04:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF75C61166
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E25C433C1;
        Wed,  3 Aug 2022 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659526425;
        bh=UuC8t1XbxVc7Rt5F5aq9a2luz/J8OSnn12GRcik7TNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCK6oyzzY+t/Cu7RXiQsdewruNE3+q80OoTvMFJXOMcZBsNSPnz7lahX8F344S61R
         Abqm5MnsO2BdmEJAvuEEEUDsDXhjX1Vq22b3LP60NVGKvbjJrDK6Yj5tZDRk/jhsgO
         z/W1jJXUAJkxFAO3SHvHWno+KQ98Ny94AbZMG/To3jHE6/UuP0TF+ZHF1p+KiTum9D
         CdfvnQ7ssZeSCTIVGTheU0v8inq+K8zaqbDbiSYyLjTSkW2Ps/o7YtpVj+eWm1ZhTT
         EgeQ/GF2X94bNiXoINEpJM1Dqg9/1pLW5TLx0XRh8qX5uGO2KUKKxJmbbHfSPMkJHg
         +wDZ664RQ31uA==
Date:   Wed, 3 Aug 2022 17:03:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] soundwire: sysfs: remove sdw_slave_sysfs_init()
Message-ID: <YupdFRvw9IKwp6z9@matsya>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-4-gregkh@linuxfoundation.org>
 <95dcb89d-bfc7-7bc4-5ec5-04537bc0758d@linux.intel.com>
 <YuP5K2/egiL/l9yk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuP5K2/egiL/l9yk@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-07-22, 17:13, Greg Kroah-Hartman wrote:
> On Fri, Jul 29, 2022 at 10:00:42AM -0500, Pierre-Louis Bossart wrote:
> > 
> > 
> > > diff --git a/drivers/soundwire/sysfs_slave_dpn.c b/drivers/soundwire/sysfs_slave_dpn.c
> > > index c4b6543c09fd..a3fb380ee519 100644
> > > --- a/drivers/soundwire/sysfs_slave_dpn.c
> > > +++ b/drivers/soundwire/sysfs_slave_dpn.c
> > > @@ -283,6 +283,9 @@ int sdw_slave_sysfs_dpn_init(struct sdw_slave *slave)
> > >  	int ret;
> > >  	int i;
> > >  
> > > +	if (!slave->prop.source_ports && !slave->prop.sink_ports)
> > > +		return 0;
> > > +
> > >  	mask = slave->prop.source_ports;
> > >  	for_each_set_bit(i, &mask, 32) {
> > >  		ret = add_all_attributes(&slave->dev, i, 1);
> > 
> > I am struggling with this one since the driver is still adding
> > attributes manually. You mentioned in the other thread that
> > 
> > "
> > That's what the is_visible() callback is for in the groups structure,
> > you determine if the attribute is visable or not at runtime, you don't
> > rely on the driver itself to add/remove attributes, that does not scale
> > and again, is racy.
> > "
> > 
> > I interpret that as "there's still a race here", no?
> 
> Yes, there is, BUT as you are creating all of these attributes "on the
> fly" for now, I don't see a simple conversion to fix that up.  Let me do
> these, the easy ones first.  Your dynamic attribute allocations are the
> harder things to do, let me think about those after I've fixed the rest
> of the tree up with the trivial ones :)

Sounds good to me.. Yes the dynamic ones are the one that need
attention. How do you propose to handle these?

-- 
~Vinod

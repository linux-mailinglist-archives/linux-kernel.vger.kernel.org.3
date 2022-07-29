Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D49A585380
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiG2Qfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiG2Qfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:35:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD5B69F01
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:35:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C487261DC9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 16:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D7CC433B5;
        Fri, 29 Jul 2022 16:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659112549;
        bh=La2xENc04xNZ++CRjJjr81vraFM/tBTfKc0zkbxL07E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ai+TTWjmeaNevgg3tHuabKwJ/OUSPJeCf8KNC5FCR6S8p06ebHufJO7NlYqR5265M
         PJP0gKQsstwJcGiKpB9lVRRPlVnK4K7NHV+R67+kUus9Qk5pU91pq7Jcc6LxJbudru
         QtM957VOIZjIYsFu+h712QYiBdXv7S2XtaNbD3gs=
Date:   Fri, 29 Jul 2022 18:35:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 2/5] soundwire: sysfs: cleanup the logic for creating the
 dp0 sysfs attributes
Message-ID: <YuQMYRYFo9gTk1yL@kroah.com>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-2-gregkh@linuxfoundation.org>
 <9365e038-2146-98f8-f989-02827f221c34@linux.intel.com>
 <YuP0Ffs3G7ZBR0AC@kroah.com>
 <cfacb124-a9ff-0a93-8f92-93d164b15966@linux.intel.com>
 <YuP2pjhyKTTfpXQq@kroah.com>
 <5caffe2a-f5a6-e312-a564-5fe29c4e2323@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5caffe2a-f5a6-e312-a564-5fe29c4e2323@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 10:52:28AM -0500, Pierre-Louis Bossart wrote:
> 
> >>>>> diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
> >>>>> index 83e3f6cc3250..3723333a5c2b 100644
> >>>>> --- a/drivers/soundwire/sysfs_slave.c
> >>>>> +++ b/drivers/soundwire/sysfs_slave.c
> >>>>> @@ -174,6 +174,16 @@ static ssize_t words_show(struct device *dev,
> >>>>>  }
> >>>>>  static DEVICE_ATTR_RO(words);
> >>>>>  
> >>>>> +static umode_t dp0_is_visible(struct kobject *kobj, struct attribute *attr,
> >>>>> +			      int n)
> >>>>> +{
> >>>>> +	struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));
> >>>>> +
> >>>>> +	if (slave->prop.dp0_prop)
> >>>>> +		return attr->mode;
> >>>>> +	return 0;
> >>>>> +}
> >>>>
> >>>> This changes the results slightly by creating an empty 'dp0' directory
> >>>> with no attributes inside.
> >>>>
> >>>> Before:
> >>>>
> >>>> [root@fedora ~]# cd /sys/bus/soundwire/devices/sdw:3:025d:0714:01
> >>>> [root@fedora sdw:3:025d:0714:01]# ls dp0
> >>>> ls: cannot access 'dp0': No such file or directory
> >>>>
> >>>> After:
> >>>> [root@fedora sdw:3:025d:0714:01]# ls dp0
> >>>
> >>> That should be fine, tools should just be looking for the attributes,
> >>> not the existance of a directory, right?
> >>
> >> The idea what that we would only expose ports that actually exist.
> >> That's helpful information anyone with a basic knowledge of the
> >> SoundWire specification would understand.
> > 
> > Is "dp0" a port?  If so, why isn't it a real device?
> 
> The SoundWire spec defines the concept of 'data port'. The valid ranges
> are 1..14, but in all existing devices the number of data ports is way
> smaller, typically 2 to 4. Data ports (DPn) are source or sink, and
> there's no firm rule that data ports needs to be contiguous.
> 
> DP0 is a 'special case' where the data transport is used for control
> information, e.g. programming large set of registers or firmware
> download. DP0 is completely optional in hardware, and not handled in
> Linux for now.
> 
> DP0 and DPn expose low-level transport registers, which define how the
> contents of a FIFO will be written or read from the bus. Think of it as
> a generalization of the concept of TDM slots, where instead of having a
> fixed slot per frame the slot position/repetition/runlength can be
> programmed.
> 
> The data ports could be as simple as 1-bit PDM, or support 8ch PCM
> 24-bits. That's the sort of information reported in attributes.

Why not make them a real device like we do for USB endpoints?

What uses these sysfs files today that would be confused about an empty
directory?

thanks,

greg k-h

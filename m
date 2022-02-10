Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110B44B1597
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343565AbiBJSyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:54:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbiBJSyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:54:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC64FF54;
        Thu, 10 Feb 2022 10:54:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8657A60C79;
        Thu, 10 Feb 2022 18:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E112C004E1;
        Thu, 10 Feb 2022 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644519272;
        bh=cJZMxTErs9pjcy2gQC8c6spFkWFZsvMX5ljqxIN6Or0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sR+cpFkta7JODYHVPFIsfrZrWtOsb8GI9mYFBMjDzH5XOHyasIWfqkDTsinc5TFnQ
         bhNBTFlgszBDGuZK0KqMAz3fHLFpb7gi9vjcoNcNEwk0dShcSLIX/T4AY+upT8M/HH
         kWzGim7Nw1RsK+c5dMgqPoXqH/3XVHtIRwOB7cNAfPez3JmDY+uU+XDQo20lTEuLP5
         iHzExPp2WRAeuvi/shfi/Z6PlXcGvHxJjNTSpinlN/rMpvoe4yeCVYLjQ3oOMstwSr
         y51pcQXVW/te9c5FuJSwF0wdyVZyfzAraMvX4D5O2qv91iVG/JFJ+Hmqvj3v3Gz3Ec
         9O2MzlHkB8SOA==
Date:   Thu, 10 Feb 2022 10:54:29 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        m.heingbecker@googlemail.com,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
Message-ID: <20220210185429.GC1617879@dhcp-10-100-145-180.wdc.com>
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
 <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
 <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
 <20220210145635.GA1617879@dhcp-10-100-145-180.wdc.com>
 <20220210182423.GB16171@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210182423.GB16171@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 07:24:23PM +0100, Christoph Hellwig wrote:
> On Thu, Feb 10, 2022 at 06:56:35AM -0800, Keith Busch wrote:
> > Apparently it works fine when you disable VMD, so sounds like the
> > acpi_storage_d3 is set, but we fail to find the correct acpi companion
> > device when it's in a VMD domain.
> 
> I guess the acpi_storage_d3 is set on the VMD device and we need
> to propagate that down the entire bus hanging off it.
> 
> Which kinda makes sense in the twisted world where vmd was invented,
> given that vmd is Intel's evil plot so that only their Windows driver
> can bind to these devices, so the property also needs to be set on
> the vmd device.
> 
> Nirmal and Jonathan, can you help to sort this mess out?

Just fyi, I'm not sure now if my previous comment is entirely accurate.
I'll get some more info from the reporter to confirm.

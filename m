Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B8547C29E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbhLUPS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbhLUPS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:18:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A435C061574;
        Tue, 21 Dec 2021 07:18:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19772B81729;
        Tue, 21 Dec 2021 15:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ED4C36AE8;
        Tue, 21 Dec 2021 15:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640099904;
        bh=9wtEm3CLIgpEal1GDu3i/CFeISSehb/nR6f/MpyuCnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VG2O/AsAC5IsTvzfW4QQppUZcf+cE0jBKLOWR1/+KtSU+7mCNAB5kfObXZAp0vLVm
         nCyDP29xLJl2YmudBH1KzizMgd1fRG0Yfv3VvYs/LCSFfWQMzRAMtnwM8UOhdVUPQJ
         JkMX9FHmnU9aKNl24PXkNmlEV02DOJynXpWmC1W8=
Date:   Tue, 21 Dec 2021 16:18:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 2/2] nvmem: expose NVMEM cells in sysfs
Message-ID: <YcHwPt2Uc8KSy3lG@kroah.com>
References: <YcF4E82M89huIbSD@kroah.com>
 <3cb1d0a4-6e20-f751-6d66-c1487ef31f30@gmail.com>
 <YcF+g0ra5tttXOQF@kroah.com>
 <0527135c-35f5-bc63-edb3-81cb03eb03f6@gmail.com>
 <YcHPGQ0FH0kTzpbq@kroah.com>
 <ab52292c-3065-789b-d5ae-ef24bab5fc90@gmail.com>
 <YcHWVMa6vjz3Gp51@kroah.com>
 <d626c2c2-5071-522f-330f-688254087d74@gmail.com>
 <YcHkS0iDUhplbqUc@kroah.com>
 <76fae18d-f4aa-450d-b8ba-19fda137fe25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76fae18d-f4aa-450d-b8ba-19fda137fe25@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 04:09:13PM +0100, Rafał Miłecki wrote:
> So both: kernel and user space need to access U-Boot environment
> variables (NVMEM cells). Each for its own purposes.
> 
> Kernel goes first so it needs its own parser of NVMEM content (data).
> 
> User space can either: get NVMEM cells exposed by kernel OR parse NVMEM
> content on its own. I thought it'd be nice to avoid parsing code
> duplication in user space and let kernel expose NVMEM cells.

Ah, so you already have the data parsed, and you just want to also
expose it to userspace.  That makes more sense (sorry, it's been a long
day of reviewing crappy patches, not yours of course...)

So sure, you can dynamically create attributes and then add them to the
device before you register it with the driver core.  Be sure to
initialize them properly with the call I pointed out previously and you
should be good to go.  You will have to keep a list of them around and
then free them yourself when the device is cleaned up, so watch out for
that.

And again, don't use a binary attribute, that's not what it is for.

thanks,

greg k-h

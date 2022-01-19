Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C16F4941AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357287AbiASU14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiASU1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:27:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34347C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:27:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFE54B81BB0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 20:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B317C004E1;
        Wed, 19 Jan 2022 20:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642624071;
        bh=LzLkZgOFjgp8994P3GdzCu+iD9iIF2FPHxl5u03Cm3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=leRyJTutY9tBkIC2Tl5Vbjw8ipFO8VSae1aoMMlosrD+dLUuwTzM3HtJ30nZunmR7
         tWir5vFjxe83f1xpSqg9t1kQDWgwl6Etxg2OujEXkhnvzSTdUAfojKHR67TJJHL4U1
         WUiLKkS/J9DuWbZwpaJH1/g+10LYkGaybMlv/mInYIoaAjNMOoHupis4ZkkYHXQLTf
         0zt6DS2byRCIOdnY28LoHME5SVeCR4pL8NAfzZVxrT2IujqJfSj9ih9UPHl8Eb3ys4
         CRbUYPnFNuKztAmWqiTdqJd8H68MprfTpSM7lwEEYck1YRcYlluY/MXfaJW8SqXhwE
         Il6F4y1C2iGTw==
Date:   Wed, 19 Jan 2022 14:27:49 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>, jkosina@suse.cz,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>, mgurtovoy@nvidia.com,
        linux@weissschuh.net, Arnd Bergmann <arnd@arndb.de>,
        stephan@gerhold.net, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Convert type of 'struct dmi_system_id -> driver_data' from 'void
 *' to kernel_ulong_t?
Message-ID: <20220119202749.GA959272@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa51355f-9ab6-7bbf-d7f6-e2af2d68056c@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 11:20:36AM +0100, Hans de Goede wrote:
> On 1/19/22 02:22, Kai-Heng Feng wrote:
> > I wonder if there's any reason to use 'void *' instead of
> > kernel_ulong_t for 'driver_data' in 'struct dmi_system_id'?
> > 
> > I'd like to use the driver_data for applying quirk flags, and I found
> > out unlike most other struct *_id, the dmi variant is using 'void *'
> > for driver_data. Is there any technical reason for this?
> > ...

> You are asking for a technical reason why "void *" was used,
> but lets turn that around, why do you believe that "unsigned long"
> is inherently a better type here ?
> 
> driver_data in most places in the kernel (like data for
> all sort of callback functions) actually typically is a void *
> already, because often people want to pass more data then what
> fits in a single long and this also applies to driver-id attached
> data.

FWIW, "egrep "context;|data;|info;" include/linux/mod_devicetable.h"
says 4 of the ~40 instances use a void *; the others use
kernel_ulong_t.

f45d069a5628 ("PCI dynids - documentation fixes, id_table NULL check")
[1] (from the tglx history tree) added the original hint for
pci_device_id that:

  Best practice for use of driver_data is to use it as an index into a
  static list of equivalant device types, not to use it as a pointer.

I don't know the background of that, but I could imagine that using an
index rather than a pointer makes things like /sys/bus/pci/.../new_id
easier and safer.

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=f45d069a5628

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9C64B1531
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245690AbiBJSYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:24:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245677AbiBJSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:24:29 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E518234;
        Thu, 10 Feb 2022 10:24:29 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A9E968BEB; Thu, 10 Feb 2022 19:24:24 +0100 (CET)
Date:   Thu, 10 Feb 2022 19:24:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Len Brown <lenb@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        m.heingbecker@googlemail.com,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
Message-ID: <20220210182423.GB16171@lst.de>
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com> <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com> <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com> <20220210145635.GA1617879@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210145635.GA1617879@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 06:56:35AM -0800, Keith Busch wrote:
> Apparently it works fine when you disable VMD, so sounds like the
> acpi_storage_d3 is set, but we fail to find the correct acpi companion
> device when it's in a VMD domain.

I guess the acpi_storage_d3 is set on the VMD device and we need
to propagate that down the entire bus hanging off it.

Which kinda makes sense in the twisted world where vmd was invented,
given that vmd is Intel's evil plot so that only their Windows driver
can bind to these devices, so the property also needs to be set on
the vmd device.

Nirmal and Jonathan, can you help to sort this mess out?

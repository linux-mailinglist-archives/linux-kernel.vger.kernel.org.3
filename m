Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34A45AED93
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiIFOj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbiIFOiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:38:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFA182D05
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:00:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 705BCB81632
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862A7C433D6;
        Tue,  6 Sep 2022 13:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662472455;
        bh=FSQhRjvX0X+fDqGJPUBo5nA4ZiDXWjwyJovPW0tGWmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWqcgbQb7C+Rxc7SwL5mlfXwC0B+By9QGWM7g/g62oNspiqYfmZLBz3e0GSp9wgUl
         GE6I/ghx8CfkWQM5ECyQO55x1YClPZzKz/gsCYf4OWcKdVOup+KQCDYzeErvZQnbCH
         8O1bon3YRKF5C8FqmJzm2KpeLSjCBneNps15QRTQ=
Date:   Tue, 6 Sep 2022 15:50:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Czerwacki, Eial" <eial.czerwacki@sap.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Message-ID: <YxdQLY3RWRRuFMKd@kroah.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 06:24:02AM +0000, Czerwacki, Eial wrote:
> --- /dev/null
> +++ b/drivers/virt/vsmp/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config VSMP
> +	tristate "vSMP Guest Support"
> +	depends on SYS_HYPERVISOR && X86_64 && PCI
> +	help
> +	  Support for vSMP Guest Driver.
> +
> +	  This driver allows information gathering of data from the vSMP hypervisor when
> +	  running on top of a vSMP-based hypervisor.
> +
> +	  If unsure, say no.

In wanting to test this out, I tried it but this depends line is wrong,
you have to set SYS_HYPERVISOR, you can not depend on it otherwise your
code will never be selected :(

How did you test this?

thanks,

greg k-h

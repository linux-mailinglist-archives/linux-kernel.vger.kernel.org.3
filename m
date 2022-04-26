Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D00850FC1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349598AbiDZLqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiDZLqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:46:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B93B3E6;
        Tue, 26 Apr 2022 04:43:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34450617E0;
        Tue, 26 Apr 2022 11:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E82C385A0;
        Tue, 26 Apr 2022 11:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650973407;
        bh=7H2/hjn47utv2t0JfKpspOcDqBY0b6iJY0AQIqJklaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLd5O1d8nJ3zfH7ToUBpdQH8C2QyWG10OcGAzPLlRAKpAZpQ2zv4fObf2OdAsM5kW
         SxlnxHgwlxWiXC7hebN6jA6Y/qBEhZL7NSC46IFsw+NhnuN7PcEvSVfPAO3KeHIpMH
         oBCUdSS+XHTGtdkqb7Y6PN2qplGJvz5WX+ibTWg0=
Date:   Tue, 26 Apr 2022 13:43:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 0/2] acpi: Remove acpi_release_memory()
Message-ID: <Ymfa3F83zxgqD2pk@kroah.com>
References: <20220425114544.37595-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425114544.37595-1-heikki.krogerus@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 02:45:42PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> It seems there never were and there never will be actual devices that
> expose the UCSI ACPI mailbox interface. There are now PD controllers
> that support the UCSI interface, but they do not use the ACPI mailbox.
> 
> So there is no point in mapping the mailbox with ioremap(), we can
> just use memremap(). That should make it possible to also remove the
> function acpi_release_memory(). That function was only there to make
> it possible to use ioremap() in the UCSI ACPI driver.
> 
> thanks,
> 
> Heikki Krogerus (2):
>   usb: typec: ucsi: acpi: Map the mailbox with memremap()
>   acpi: Remove the helper for deactivating memory region
> 
>  drivers/acpi/osl.c                 | 86 ------------------------------
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 19 ++-----
>  include/linux/acpi.h               |  3 --
>  3 files changed, 4 insertions(+), 104 deletions(-)
> 
> -- 
> 2.35.1
> 

Look good to me, Rafael, want me to take this through the USB tree?  Or
if you want to take it through the USB tree, here's my reviewed-by:
either is fine with me.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

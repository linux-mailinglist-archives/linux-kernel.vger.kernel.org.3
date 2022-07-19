Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D252579363
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiGSGoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbiGSGoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:44:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9B31D0E8;
        Mon, 18 Jul 2022 23:44:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DBE0B81862;
        Tue, 19 Jul 2022 06:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA369C341CA;
        Tue, 19 Jul 2022 06:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658213052;
        bh=E3bX6qmleWeGq12RkBURl2twNNBfbS4mSd/IGKxbwgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1OSijaaiRloJgzq5lYHvCJGRBoe4rlqxsuUg+pvVXZKa+0MwGfhQA8QkLqhKqjCfY
         PuOeIdJry8NeReMwXc9QXrHWWFj+OjiChxfiKuCJns9dUdLIRgwS5UX10bJL5HM4UG
         8FSPhmxT4or3LCKv/XtrcWq439ci7RUOhM0PXZ2I=
Date:   Tue, 19 Jul 2022 08:44:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev, bleung@chromium.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] platform/chrome: cros_typec_switch: Add ACPI Kconfig
 dep
Message-ID: <YtZSuI5X96w83S6j@kroah.com>
References: <20220718212754.1129257-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718212754.1129257-1-pmalani@chromium.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 09:27:55PM +0000, Prashant Malani wrote:
> Add the ACPI Kconfig dependency that was missed during the initial
> driver submission. Fixes the following compiler errors:
> 
> drivers/platform/chrome/cros_typec_switch.c:93:9: error: call to
> undeclared function 'acpi_evaluate_integer'; ISO C99 and later do not
> support implicit function declarations
>  [-Wimplicit-function-declaration]
>    ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &index);
> 
> drivers/platform/chrome/cros_typec_switch.c:93:35: error: incomplete
> definition of type 'struct acpi_device'
>    ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &index);
> 
> Fixes: e54369058f3d ("platform/chrome: cros_typec_switch: Add switch driver")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
> 
> Changes since v1:
> - Correct the malformed Reported-by tag. No functional changes.
> (Apologies for the quick respin.)

I already have v1 in my tree, so this isn't going to work, sorry.

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E74588F54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbiHCP2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiHCP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:28:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43191658B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 58297CE23C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E75C433C1;
        Wed,  3 Aug 2022 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659540490;
        bh=bNPdkVFgo8y7TFHkpyCYZo3hf4s+EbbUgOaCuZ/XapU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtDkPqDaAkMu0pAXBxk+rZWYGPOAXtyQYMWBUEBXhOKYx7nSmauQkHNwFmKLIs8Rf
         I3M1x2arvdZcy3jKYFRCIX9CabezLBAjze3B0TtdteuLBiQLXKwVnkXut+OnfpuCo9
         q0XwiDu1Hm430WYQVyL/ozhASmcAxVbxbSH5/t5Q=
Date:   Wed, 3 Aug 2022 17:28:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     bchalios@amazon.es
Cc:     linux-kernel@vger.kernel.org, tytso@mit.edu, Jason@zx2c4.com,
        dwmw@amazon.co.uk, graf@amazon.de, xmarcalx@amazon.co.uk
Subject: Re: [PATCH 2/2] virt: vmgenid: add support for generation counter
Message-ID: <YuqUCPN11aSUmjDy@kroah.com>
References: <20220803152127.48281-1-bchalios@amazon.es>
 <20220803152127.48281-3-bchalios@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803152127.48281-3-bchalios@amazon.es>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 05:21:27PM +0200, bchalios@amazon.es wrote:
> From: Babis Chalios <bchalios@amazon.es>
> 
> VM Generation ID provides a means of reseeding kernel's RNG using a
> 128-bit UUID when a VM fork occurs, thus avoiding issues running
> multiple VMs with the exact same RNG state. However, user-space
> applications, such as user-space PRNGs and applications that maintain
> world-unique data, need a mechanism to handle VM fork events as well.
> 
> To handle the user-space use-case, this: <url> qemu patch extends
> Microsoft's original vmgenid specification adding an extra page which
> holds a single 32-bit generation counter, which increases every time a
> VM gets restored from a snapshot.
> 
> This patch exposes the generation counter through a character device
> (`/dev/vmgenid`) that provides a `read` and `mmap` interface, for
> user-space applications to consume. Userspace applications should read
> this value before starting a transaction involving cached random bits
> and ensure that it has not changed while committing the transaction.
> 
> It can be used from qemu using the `-device vmgenid,guid=auto,genctr=42`
> parameter to start a VM with a generation counter with value 42.
> Reading 4 bytes from `/dev/vmgenid` will return the value 42. Next, use
> `savevm my_snapshot` in the monitor to snapshot the VM. Now, start
> another VM using `-device vmgenid,guid=auto,genctr=43 -loadvm
> my_snapshot`. Reading now from `/dev/vmgenid` will return 43.
> 
> Signed-off-by: Babis Chalios <bchalios@amazon.es>
> ---
>  Documentation/virt/vmgenid.rst | 120 +++++++++++++++++++++++++++++++++
>  drivers/virt/vmgenid.c         | 103 +++++++++++++++++++++++++++-
>  2 files changed, 221 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/virt/vmgenid.rst
> 
> diff --git a/Documentation/virt/vmgenid.rst b/Documentation/virt/vmgenid.rst
> new file mode 100644
> index 000000000..61c29e4a7
> --- /dev/null
> +++ b/Documentation/virt/vmgenid.rst
> @@ -0,0 +1,120 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======
> +VMGENID
> +=======

<snip>

This file is now just floating in the directory, not tied to anything,
so auto-generation of the documentation will not pick it up or link to
it, right?

So, why does this have to be a separate file at all?  Why not put this
in the .c file and pull it straight from there so that it keeps in sync
with the code easier?

thanks,

greg k-h

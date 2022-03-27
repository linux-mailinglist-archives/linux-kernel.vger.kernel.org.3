Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C587D4E8669
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 09:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbiC0HIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 03:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbiC0HIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 03:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F89A140EE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 00:06:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD97C60F55
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 07:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6962BC340EC;
        Sun, 27 Mar 2022 07:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648364817;
        bh=415DFYkmPefKhDTSw4PaJNUe8VG4ZSmdxIgk8FHrdyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wPDNc/bNtNFejTNEBeGSoE9hJdbVHyw2cd16UmRqci/BojcU/dUzsuek64QBHrrO4
         4/i9zPpH+HDJHqcvDEG8Wykxzx16MN68RkY8+gFSEoPJLpAIF0ZY4d75FZb7kxh369
         MtWSe7thH5lvuXQzWM3rtkzW0Bvi7U0l5HXbx9YU=
Date:   Sun, 27 Mar 2022 09:06:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, javier@javigon.com,
        arnd@arndb.de, will@kernel.org, axboe@kernel.dk,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v9 0/3] drivers: ddcci: upstream DDCCI driver
Message-ID: <YkANDAyCMBBBWEs0@kroah.com>
References: <20220327045845.144742-1-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327045845.144742-1-yusisamerican@gmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 09:58:42PM -0700, Yusuf Khan wrote:
> This patch upstreams(adds) the DDCCI driver by Christoph Grenz into
> the kernel. The original gitlab page is loacted at https://gitlab
> .com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.
> 
> DDC/CI is a control protocol for monitor settings supported by most
> monitors since about 2005. A chardev and sysfs interface is provided.
> The seccond patch in this series provides a backlight driver using
> DDC/CI.
> 
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> Signed-off-by: Christoph Grenz <christophg+lkml@grenz-bonn.de>
> ---
> v2: Fix typos.
> 
> v3: Add documentation, move files around, replace semaphores with
> mutexes, and replaced <asm-generic/fcntl.h> with <linux/fcntl.h>.
> "imirkin"(which due to his involvement in the dri-devel irc channel
> I cant help but assume to be a DRM developer) said that the DDC/CI
> bus does not intefere with the buses that DRM is involved with.
> 
> v4: Move some documentation, fix grammer mistakes, remove usages of
> likely(), and clarify some documentation.
> 
> v5: Fix grammer mistakes, remove usages of likely(), and clarify
> some documentation.
> 
> v6: Change contact information to reference Christoph Grenz.
> 
> v7: Remove all instances of the unlikely() macro.
> 
> v8: Modify documentation to provide updated date and kernel
> documentation, fix SPDX lines, use isalpha instead of redefining
> logic, change maximum amount of bytes that can be written to be
> conformant with DDC/CI specification, prevent userspace from holding
> locks with the open file descriptor, remove ddcci_cdev_seek, dont
> refine sysfs_emit() logic, use EXPORT_SYMBOL_GPL instead of
> EXPORT_SYMBOL, remove ddcci_device_remove_void, remove module
> paramaters and version, and split into 2 patches.
> 
> v9: Fix IS_ANY_ID matching for compilers and archs where char is
> unsigned char and use the cannonical patch format.
> Reported-by: kernel test robot <lkp@intel.com>

You sent 3 patches with all the same subject line, yet they did
different things.  That's not ok at all.  Please read the kernel
documentation for how to write proper subject lines.

thanks,

greg k-h

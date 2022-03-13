Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FE84D775E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 18:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiCMRx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 13:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiCMRx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 13:53:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C9D31900;
        Sun, 13 Mar 2022 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=L6L+s5wurYr5ANfsmIXWwamcGVfhyU1GIGdc/AUkZnI=; b=eb3rWG8TfXxGRSyrjFG12E8DO/
        czhUMs41ehm/mUZQzBNLmEni/8b35FfK2wy239cATn2vHfeyVqzntu9UHVOjZwbzthsqbPpisosnl
        HeuP/oxt7ZL1gG27i8/19eI/gCjF0jn8IsT7SzKQvBA/YFXxHVWi6lFvV38mp/+FiL+JAg9an4HXZ
        jneDtDANBbnKU+yIHJ2tp5JbNNeTfU2cKjP1AEgzzaraa0XRYL7fvVoskV5VwZmNNJTjlDeskWDv9
        +pLgI0ruKN3TaoHpv8E5snaBgDNfD6dOrv/f0O7i2ucZZ8eYPLWKuExQ2KOUAVRIcPYvC5B8XXLQV
        Hp11uE8A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTSOV-003NRL-PZ; Sun, 13 Mar 2022 17:52:40 +0000
Message-ID: <c98c9b7c-a994-d4b4-f8d8-88fd80ad6155@infradead.org>
Date:   Sun, 13 Mar 2022 10:52:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/3] docs: bootconfig: Add how to embed the bootconfig
 into kernel
Content-Language: en-US
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <164717976871.656425.6189991392886085524.stgit@devnote2>
 <164717979739.656425.17945326639021989871.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <164717979739.656425.17945326639021989871.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 3/13/22 06:56, Masami Hiramatsu wrote:
> Add a description how to embed the bootconfig file into kernel.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Documentation/admin-guide/bootconfig.rst |   31 +++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index a1860fc0ca88..a172c669997a 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -158,9 +158,15 @@ Each key-value pair is shown in each line with following style::
>  Boot Kernel With a Boot Config
>  ==============================
>  
> -Since the boot configuration file is loaded with initrd, it will be added
> -to the end of the initrd (initramfs) image file with padding, size,
> -checksum and 12-byte magic word as below.
> +There are 2 options to boot the kernel with bootconfig, one is attaching
> +bootconfig to initrd image, and embedding the kernel itself.

  There are two options to boot the kernel with bootconfig: attaching the
  bootconfig to the initrd image or embedding it in the kernel itself.

> +
> +Attaching a Boot Config to Initrd
> +---------------------------------
> +
> +Since the boot configuration file is loaded with initrd by default,
> +it will be added to the end of the initrd (initramfs) image file with
> +padding, size, checksum and 12-byte magic word as below.
>  
>  [initrd][bootconfig][padding][size(le32)][checksum(le32)][#BOOTCONFIG\n]
>  
> @@ -196,6 +202,25 @@ To remove the config from the image, you can use -d option as below::
>  Then add "bootconfig" on the normal kernel command line to tell the
>  kernel to look for the bootconfig at the end of the initrd file.
>  
> +Embedding a Boot Config into Kernel
> +-----------------------------------
> +
> +If you can not use initrd, you can also embed the bootconfig file to the

                                                                     in the

> +kernel by Kconfig options. In This case, you need to recompile the kernel

                                 this

> +with the following configs::
> +
> + COFNIG_EMBED_BOOT_CONFIG=y
> + CONFIG_EMBED_BOOT_CONFIG_FILE="/PATH/TO/BOOTCONFIG/FILE"
> +
> +You need to set the correct path (relative path from kernel build directory
> +or absolute path) to the ``CONFIG_EMBED_BOOT_CONFIG_FILE`` option.
> +Then the kernel will embed the bootconfig file as a default bootconfig.
> +
> +As same as attaching to initrd, you need ``bootconfig`` option to the

  Just as when attaching the bootconfig to the initrd, you need ``bootconfig`` option to the

> +kernel command line to enable the embedded bootconfig.
> +
> +Note that even if you set this option, you can override the embedded
> +bootconfig by another bootconfig which attached to the initrd.
>  
>  Kernel parameters via Boot Config
>  =================================
> 

HTH.

-- 
~Randy

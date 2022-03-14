Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F57C4D7942
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235797AbiCNCEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiCNCEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:04:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6661632983;
        Sun, 13 Mar 2022 19:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=8ceY7QKeUgsO8/lcXs53TEjBIa3l94LI5w3qVVPieYg=; b=Kvb9b6IgfJmJTrmInlMTdSvfFb
        htxpxtcFso1KOoR9cCR0QzB2Nfk332VA3MoL6wBTzxbd3lQqKMwDbP1AxkT4NUy8h1gm4vt8XOM16
        +WOkS+r9wRweoCFr9qQMFqr2wlnwIL+wbjeImSrQdgvHMz5IQdRHQBDi6+eHQs5zQa1ndQxmiHcwl
        YQTXUpvcEm/mQflBoP3n9k2AUJKvZLkvAKmra8sdoBhLow/aFFNy/SGHdRc686lxAqENywlKRNM0I
        Jn91mXk4uRPV/NqZslTlvd0noH8Txsq/hXCTV88Zc6OMQQlNK9Qg6bHdlbGcOQp0001i/0rxt5VI5
        zIAMOOyA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTa3S-003dzL-8N; Mon, 14 Mar 2022 02:03:26 +0000
Message-ID: <8ad1fb98-3141-1e57-b627-0c8184fef955@infradead.org>
Date:   Sun, 13 Mar 2022 19:03:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/3] docs: bootconfig: Add how to embed the bootconfig
 into kernel
Content-Language: en-US
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <164722283333.689258.144495814460576707.stgit@devnote2>
 <164722286373.689258.9817790360544187508.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <164722286373.689258.9817790360544187508.stgit@devnote2>
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



On 3/13/22 18:54, Masami Hiramatsu wrote:
> Add a description how to embed the bootconfig file into kernel.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Corrected the text accoding to Randy's suggestion.
>   - Do not reccomend to use relative path for CONFIG_EMBED_BOOT_CONFIG_FILE.
> ---
>  Documentation/admin-guide/bootconfig.rst |   30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index a1860fc0ca88..1af1a172fdd4 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -158,9 +158,15 @@ Each key-value pair is shown in each line with following style::
>  Boot Kernel With a Boot Config
>  ==============================
>  
> -Since the boot configuration file is loaded with initrd, it will be added
> -to the end of the initrd (initramfs) image file with padding, size,
> -checksum and 12-byte magic word as below.
> +There are two options to boot the kernel with bootconfig: attaching the
> +bootconfig to the initrd image or embedding it in the kernel itself.
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
> @@ -196,6 +202,24 @@ To remove the config from the image, you can use -d option as below::
>  Then add "bootconfig" on the normal kernel command line to tell the
>  kernel to look for the bootconfig at the end of the initrd file.
>  
> +Embedding a Boot Config into Kernel
> +-----------------------------------
> +
> +If you can not use initrd, you can also embed the bootconfig file in the
> +kernel by Kconfig options. In this case, you need to recompile the kernel
> +with the following configs::
> +
> + COFNIG_EMBED_BOOT_CONFIG=y

    CONFIG_

> + CONFIG_EMBED_BOOT_CONFIG_FILE="/PATH/TO/BOOTCONFIG/FILE"
> +
> +``CONFIG_EMBED_BOOT_CONFIG_FILE`` requires a correct absolute path to
> +the bootconfig file. The kernel will embed it as the default bootconfig.
> +
> +Just as when attaching the bootconfig to the initrd, you need ``bootconfig``
> +option to the kernel command line to enable the embedded bootconfig.

          on the

preferably.

> +
> +Note that even if you set this option, you can override the embedded
> +bootconfig by another bootconfig which attached to the initrd.
>  
>  Kernel parameters via Boot Config
>  =================================
> 

thanks.
-- 
~Randy

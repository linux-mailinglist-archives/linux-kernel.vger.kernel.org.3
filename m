Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42A94D78F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 01:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbiCNAp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 20:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiCNApU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 20:45:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8840C103E;
        Sun, 13 Mar 2022 17:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4D03B80CD7;
        Mon, 14 Mar 2022 00:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C34C340EC;
        Mon, 14 Mar 2022 00:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647218647;
        bh=U8pk9FBikMRQPOHsBpUcHCQBfRuztxrijrDYaEWbe0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iERe5nzMIn9t/ly/sLHswxnTVnoEg9mY4xOPM3CuTNuyujKMRNcwJJxl8W3fPuc9N
         nTUCRF6RXuTdgnUBJhFI7P5Zd+wXjSDD7y6ly5UFAOF/5mEiLqTgw92O9fbe40BN+z
         VzhIsZpXsZ2mhwsoR89Flizlqa+5rqmu6ckZWBkbpqhLrOFTniVOvlmnO4V6IT1ZNZ
         CtrPeIxp+d2DEcFHrdG1pY9iQ+IyOids+qElw1l9sssv7GytTdi+0Dh9IDfXDuk8Uh
         xgjMsgbNQrtvwjuoxVUi/49vXOGhT/4LHdNQSgjWnlCWhMCh76Gsm0dv1tIutreP0a
         N5hmZ1R/DCLhA==
Date:   Mon, 14 Mar 2022 09:44:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] docs: bootconfig: Add how to embed the bootconfig
 into kernel
Message-Id: <20220314094402.8c6354c2528e95775df56dff@kernel.org>
In-Reply-To: <c98c9b7c-a994-d4b4-f8d8-88fd80ad6155@infradead.org>
References: <164717976871.656425.6189991392886085524.stgit@devnote2>
        <164717979739.656425.17945326639021989871.stgit@devnote2>
        <c98c9b7c-a994-d4b4-f8d8-88fd80ad6155@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thanks for the review and fix! 
I also found that CONFIG_EMBED_BOOT_CONFIG_FILE should be an absolute path
(for example, if the kernel is built with O=DIR option, the relative path will
 be interpreted from the build directory (DIR/lib) but that is too complicated.)
So I'll update this document.

Thank you!

On Sun, 13 Mar 2022 10:52:35 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi--
> 
> On 3/13/22 06:56, Masami Hiramatsu wrote:
> > Add a description how to embed the bootconfig file into kernel.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Documentation/admin-guide/bootconfig.rst |   31 +++++++++++++++++++++++++++---
> >  1 file changed, 28 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> > index a1860fc0ca88..a172c669997a 100644
> > --- a/Documentation/admin-guide/bootconfig.rst
> > +++ b/Documentation/admin-guide/bootconfig.rst
> > @@ -158,9 +158,15 @@ Each key-value pair is shown in each line with following style::
> >  Boot Kernel With a Boot Config
> >  ==============================
> >  
> > -Since the boot configuration file is loaded with initrd, it will be added
> > -to the end of the initrd (initramfs) image file with padding, size,
> > -checksum and 12-byte magic word as below.
> > +There are 2 options to boot the kernel with bootconfig, one is attaching
> > +bootconfig to initrd image, and embedding the kernel itself.
> 
>   There are two options to boot the kernel with bootconfig: attaching the
>   bootconfig to the initrd image or embedding it in the kernel itself.
> 
> > +
> > +Attaching a Boot Config to Initrd
> > +---------------------------------
> > +
> > +Since the boot configuration file is loaded with initrd by default,
> > +it will be added to the end of the initrd (initramfs) image file with
> > +padding, size, checksum and 12-byte magic word as below.
> >  
> >  [initrd][bootconfig][padding][size(le32)][checksum(le32)][#BOOTCONFIG\n]
> >  
> > @@ -196,6 +202,25 @@ To remove the config from the image, you can use -d option as below::
> >  Then add "bootconfig" on the normal kernel command line to tell the
> >  kernel to look for the bootconfig at the end of the initrd file.
> >  
> > +Embedding a Boot Config into Kernel
> > +-----------------------------------
> > +
> > +If you can not use initrd, you can also embed the bootconfig file to the
> 
>                                                                      in the
> 
> > +kernel by Kconfig options. In This case, you need to recompile the kernel
> 
>                                  this
> 
> > +with the following configs::
> > +
> > + COFNIG_EMBED_BOOT_CONFIG=y
> > + CONFIG_EMBED_BOOT_CONFIG_FILE="/PATH/TO/BOOTCONFIG/FILE"
> > +
> > +You need to set the correct path (relative path from kernel build directory
> > +or absolute path) to the ``CONFIG_EMBED_BOOT_CONFIG_FILE`` option.
> > +Then the kernel will embed the bootconfig file as a default bootconfig.
> > +
> > +As same as attaching to initrd, you need ``bootconfig`` option to the
> 
>   Just as when attaching the bootconfig to the initrd, you need ``bootconfig`` option to the
> 
> > +kernel command line to enable the embedded bootconfig.
> > +
> > +Note that even if you set this option, you can override the embedded
> > +bootconfig by another bootconfig which attached to the initrd.
> >  
> >  Kernel parameters via Boot Config
> >  =================================
> > 
> 
> HTH.
> 
> -- 
> ~Randy


-- 
Masami Hiramatsu <mhiramat@kernel.org>

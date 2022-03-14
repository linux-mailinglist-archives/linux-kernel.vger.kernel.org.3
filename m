Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968B34D7D39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiCNIGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239328AbiCNIFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:05:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859CA338;
        Mon, 14 Mar 2022 01:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EFA4FCE10A8;
        Mon, 14 Mar 2022 08:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D6CC340EE;
        Mon, 14 Mar 2022 08:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647245016;
        bh=PLyOXRyp/joleXlKUaTg+BlpTSHFV9oVS+l3FdSBbwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CoNJ/MP0igatf0tWuoiMqW6Sx0dzD74K0reoXCLyI5WFnqrNwB5zJdwzzcXHBIYVi
         aIOCKgf8PevIfE98O8McZ5V88s0BjEHAreCAkiWXoutB1x+L0PVStbHDE7ej7Rm5t/
         FWCZ+lkC8wH7+PXs8frjFvPP84vAW9zfV6b0SWg13DsZ/0yeHiT54sud/7kjNZCB9+
         0mz/Djy/Bk0iHb4SYdXHoPTYRRfcHv7Op4VzYYEBq8S5tI5oFpFe3x3pcUia/liMNJ
         Rtywa7DcpdxWL3b5Or5cf0M2W14gUowW+jzKhcvlkdpm5uSLXNidTdDm374mmYDvtm
         aV3NQv3am6byg==
Date:   Mon, 14 Mar 2022 17:03:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 3/3] docs: bootconfig: Add how to embed the
 bootconfig into kernel
Message-Id: <20220314170333.0311c13a654c63d7ebe68e1f@kernel.org>
In-Reply-To: <8ad1fb98-3141-1e57-b627-0c8184fef955@infradead.org>
References: <164722283333.689258.144495814460576707.stgit@devnote2>
        <164722286373.689258.9817790360544187508.stgit@devnote2>
        <8ad1fb98-3141-1e57-b627-0c8184fef955@infradead.org>
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

On Sun, 13 Mar 2022 19:03:20 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> 
> 
> On 3/13/22 18:54, Masami Hiramatsu wrote:
> > Add a description how to embed the bootconfig file into kernel.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - Corrected the text accoding to Randy's suggestion.
> >   - Do not reccomend to use relative path for CONFIG_EMBED_BOOT_CONFIG_FILE.
> > ---
> >  Documentation/admin-guide/bootconfig.rst |   30 +++++++++++++++++++++++++++---
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> > index a1860fc0ca88..1af1a172fdd4 100644
> > --- a/Documentation/admin-guide/bootconfig.rst
> > +++ b/Documentation/admin-guide/bootconfig.rst
> > @@ -158,9 +158,15 @@ Each key-value pair is shown in each line with following style::
> >  Boot Kernel With a Boot Config
> >  ==============================
> >  
> > -Since the boot configuration file is loaded with initrd, it will be added
> > -to the end of the initrd (initramfs) image file with padding, size,
> > -checksum and 12-byte magic word as below.
> > +There are two options to boot the kernel with bootconfig: attaching the
> > +bootconfig to the initrd image or embedding it in the kernel itself.
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
> > @@ -196,6 +202,24 @@ To remove the config from the image, you can use -d option as below::
> >  Then add "bootconfig" on the normal kernel command line to tell the
> >  kernel to look for the bootconfig at the end of the initrd file.
> >  
> > +Embedding a Boot Config into Kernel
> > +-----------------------------------
> > +
> > +If you can not use initrd, you can also embed the bootconfig file in the
> > +kernel by Kconfig options. In this case, you need to recompile the kernel
> > +with the following configs::
> > +
> > + COFNIG_EMBED_BOOT_CONFIG=y
> 
>     CONFIG_

Oops, it's a typo...

> 
> > + CONFIG_EMBED_BOOT_CONFIG_FILE="/PATH/TO/BOOTCONFIG/FILE"
> > +
> > +``CONFIG_EMBED_BOOT_CONFIG_FILE`` requires a correct absolute path to
> > +the bootconfig file. The kernel will embed it as the default bootconfig.
> > +
> > +Just as when attaching the bootconfig to the initrd, you need ``bootconfig``
> > +option to the kernel command line to enable the embedded bootconfig.
> 
>           on the

OK.

Thank you!

> 
> preferably.
> 
> > +
> > +Note that even if you set this option, you can override the embedded
> > +bootconfig by another bootconfig which attached to the initrd.
> >  
> >  Kernel parameters via Boot Config
> >  =================================
> > 
> 
> thanks.
> -- 
> ~Randy


-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F266526CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 00:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiEMWmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 18:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiEMWmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 18:42:02 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BF212B266;
        Fri, 13 May 2022 15:42:00 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0B73D92009C; Sat, 14 May 2022 00:41:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0464692009B;
        Fri, 13 May 2022 23:41:57 +0100 (BST)
Date:   Fri, 13 May 2022 23:41:57 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org
Subject: [PATCH 0/3] Documentation: Fix issues with Oxford Semiconductor PCIe
 (Tornado) 950
Message-ID: <alpine.DEB.2.21.2205131712410.10656@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_HDRS_LCASE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Here are fixes for the Sphinx processing warnings reported with `make 
htmldocs' for the description of the Oxford Semiconductor PCIe (Tornado) 
950 driver recently added.  I have split them into two parts so that they 
can be considered separately.

 First, Documentation/tty/ has been moved to driver-api, which I find not 
suitable for user documentation, so I have now moved the description to 
Documentation/misc-devices/.  I found no better place, but I can update 
the change again if you have a better suggestion.

 Second, actual warnings have been removed.  I have corrected quoting for 
symbol/parameter references, quoted tables and rewritten bibligraphy in
Sphinx's style.

 Third, the document has now been wired into the misc-devices document, so 
that it is not an orphan page in the HTML format anymore and it is also 
included in PDF documentation.

 I have verified the result and considered it visually sound with output 
produced by `make htmldocs' and `make pdfdocs'.

 For the latter command however I need to note that several other 
documents in our Documentation/ tree suffer from a problem that causes 
`make pdfdocs' to fail (and the failure cannot be worked around with 
make's `-k -i' options, i.e. no output is ever produced), e.g.:

Markup is unsupported in LaTeX:
filesystems/9p:: nested tables are not yet implemented.

and similarly for: filesystems/erofs, filesystems/f2fs, filesystems/ntfs, 
networking/device_drivers/ethernet/dlink/dl2k, scsi/arcmsr_spec, 
scsi/g_NCR5380, scsi/ncr53c8xx, and scsi/sym53c8xx_2.  I don't know if it 
is a known problem, possibly addressed in a newer version of tools, so 
I've thought it might be worth reporting.

 I have worked around the problem by removing the offending files, which 
let `make pdfdocs' proceed to completion.  I have spotted another problem 
there then in that the table of contents is only generated in the output 
file produced upon the second or subsequent invocations of `make pdfdocs'.  
Similarly bibligraphy links (but not the list itself).  Upon the first run 
of `make pdfdocs' on a clean Documentation/ tree the Contents section only 
has its heading and bibligraphy links are dead with `[?]' showing (the 
section is correctly populated however).  It's not clear to me if this is 
a bug in the tools used or something wrong with our Makefile system, so 
again I've thought it might be worth reporting.

 NB XeTeX, Version 3.14159265-2.6-0.99999 (TeX Live 2019/dev/Debian) and 
Sphinx 1.8.4 here.

 The issues are not directly related to the changes proposed here though,
so please apply them.

  Maciej

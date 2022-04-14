Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C83B500942
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbiDNJGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbiDNJGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:06:34 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF21A6FA05;
        Thu, 14 Apr 2022 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649927045;
  x=1681463045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5reGpRw2ZgFSQZbtLRzu9ib8DlUy/I3RASjMk4c7wAc=;
  b=jVAm81si+ueDMpri6APpKbf83xGhXkIzuQTthfttlAW3X+zpQ5AqTvIm
   N4bZV/ygjHe+wshrhPvv07KKw92LpTmLYTj2ehlSmT7JDXeU7DgTwnQ4u
   6IDeW5ln/H6TtXxqgJ3QaCQMwDYfJzBHw3YIcBOuqA/086upjnqrUzERz
   gIgwRilTfKAt+89mYiUQPlWOvpTjL6xW6ZtnJ2VC8xB+sfSeiTkbF+euf
   SdYUGeW7Qy9v4GM2ilEQZgnQTqkfIW8eYxKlPzdIzHUxFQlsaLK92P6Et
   1KXb1txmSvZgL3gj3Yq7QFrs7j6wtJpFPe6J4PeC3Ka1pRcbERFTqNYyS
   A==;
Date:   Thu, 14 Apr 2022 11:04:02 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     kernel test robot <lkp@intel.com>
CC:     "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "joern@lazybastard.org" <joern@lazybastard.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        kernel <kernel@axis.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] mtd: phram: Allow cached mappings
Message-ID: <20220414090402.GA11067@axis.com>
References: <20220412135302.1682890-5-vincent.whitchurch@axis.com>
 <202204131446.omJ5mC54-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202204131446.omJ5mC54-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 08:45:59AM +0200, kernel test robot wrote:
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/io.h:13,
>                     from drivers/mtd/devices/phram.c:21:
>    drivers/mtd/devices/phram.c: In function 'register_device':
> >> arch/sh/include/asm/io.h:274:33: error: expected expression before 'do'
>      274 | #define iounmap(addr)           do { } while (0)
>          |                                 ^~
>    drivers/mtd/devices/phram.c:150:44: note: in expansion of macro 'iounmap'
>      150 |         cached ? memunmap(new->mtd.priv) : iounmap(new->mtd.priv);
>          |                                            ^~~~~~~
>    drivers/mtd/devices/phram.c: In function 'phram_remove':
> >> arch/sh/include/asm/io.h:274:33: error: expected expression before 'do'
>      274 | #define iounmap(addr)           do { } while (0)
>          |                                 ^~
>    drivers/mtd/devices/phram.c:372:53: note: in expansion of macro 'iounmap'
>      372 |         phram->cached ? memunmap(phram->mtd.priv) : iounmap(phram->mtd.priv);
>          |                                                     ^~~~~~~
> 
> 
> vim +/do +274 arch/sh/include/asm/io.h
> 
> d57d64080ddc0f Paul Mundt        2010-01-19  272  
> 13f1fc870dd747 Christoph Hellwig 2020-07-14  273  #else /* CONFIG_MMU */
> 13f1fc870dd747 Christoph Hellwig 2020-07-14 @274  #define iounmap(addr)		do { } while (0)
> 13f1fc870dd747 Christoph Hellwig 2020-07-14  275  #define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset))
> 13f1fc870dd747 Christoph Hellwig 2020-07-14  276  #endif /* CONFIG_MMU */
> d627a2ebd1a303 Paul Mundt        2010-01-28  277  

Thank you for the report.  This patch could certainly be changed to work
around this, but ISTM that the right fix is in the SH header file, since
the problem could hit in other cases too.  I've posted a fix here now:

 https://lore.kernel.org/lkml/20220414081257.1487499-1-vincent.whitchurch@axis.com/

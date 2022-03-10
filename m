Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64274D5527
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbiCJXN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243019AbiCJXNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:13:24 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5F619ABD7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646953942; x=1678489942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5QC0vRgugCINeAXN4k7EQqlRq0XcViaqPzPIXBZvqNY=;
  b=I9fyAPnP4JdKmjrxhhn++t+c0idEmUOl/3BrSgIoGZiVwYAjw/tHXgCD
   CuD+ahKZ/0hbjgeIIW2rWZg3uHzzz+qhVMPDyJ1gtQqiTXpASIBuxq1oJ
   r/byL0Vl6gCkH7k7FzK0UW1+aedt2VPIaHTaboUXnWpWUIszsirc1LHUZ
   rwxxEUC2yy0IZPkshEg+khI5cHoAU6GUKsS9I9ue6QKFc9/ppJiOY0r9j
   FwzfzzmsfuSuA6lgnVmD/zKbgEm9KnMp0w6rtNB9/Yc/w9AgSsQgK/Uhr
   nIz9pXB3pMnkw8gcVLThcAzoyhLKYEh5/gUcHRf5DumzjSlHBkpOI3NPc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="280146936"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="280146936"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 15:12:21 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="642757104"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 15:12:21 -0800
Date:   Thu, 10 Mar 2022 15:12:21 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/dax: Fix run_dax() missing prototype
Message-ID: <YiqF1a9VNiSWI5j0@iweiny-desk3>
References: <20220304203756.3487910-1-ira.weiny@intel.com>
 <CAPcyv4juDzD4W_xAff2CdTFzKQhqfFkn93Zo_4Mw23v+Rq=1+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4juDzD4W_xAff2CdTFzKQhqfFkn93Zo_4Mw23v+Rq=1+g@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 09:08:36PM -0800, Dan Williams wrote:
> On Fri, Mar 4, 2022 at 12:38 PM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > The function run_dax() was missing a prototype when compiling with
> > warnings.
> >
> > Add bus.h to fix this.
> >
> 
> Always include the warning and the compiler in the changelog.

Sorry.

> I
> suspect you hit this with LLVM and not gcc?

No this was with gcc.

gcc -Wp,-MMD,drivers/dax/.super.o.d -nostdinc -I./arch/x86/include
...
  -D__KBUILD_MODNAME=kmod_dax -c -o drivers/dax/super.o drivers/dax/super.c  ;
  ./tools/objtool/objtool orc generate   --no-fp   --retpoline  --uaccess drivers/dax/super.o
drivers/dax/super.c:276:6: warning: no previous prototype for ‘run_dax’ [-Wmissing-prototypes]
    276 | void run_dax(struct dax_device *dax_dev)
          |      ^~~~~~~

> 
> super.c has no business including bus.h. If the bots are tripping over
> this a better fix is to move it into dax-private.h.

It was not a bot just me using W=1.

I can ignore it or move the prototype to dax-private.h.

Ira

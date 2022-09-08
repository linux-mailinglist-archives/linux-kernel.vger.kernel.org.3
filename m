Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36245B13BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 06:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIHEfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 00:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIHEfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 00:35:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E4F4599A;
        Wed,  7 Sep 2022 21:35:08 -0700 (PDT)
Received: from nazgul.tnic (unknown [84.201.196.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 555AE1EC0662;
        Thu,  8 Sep 2022 06:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662611702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yj0XiI5SAxZERNji8RCiam0EWrxhSX89yYeXkz7KJQA=;
        b=RHRF14JX2l4NKBH/yE9kk9zL5oVZILZ6zAdSSHwupFCSqyUtLh0x/fO0dHc+ZLCzuRhK5a
        uLq5fV4wL5E5aXmVC8K4wfSFPz4kqH3KKq3WM34LYZceSB5o5OZs0MElX+U4NRBL+eJd3b
        1YPYUH/yp2cWRLMRRkEtLHC+ZbfPx8s=
Date:   Thu, 8 Sep 2022 06:35:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, x86@kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] memregion: Add arch_flush_memregion() interface
Message-ID: <YxlxAFgW65w8wgPy@nazgul.tnic>
References: <20220829212918.4039240-1-dave@stgolabs.net>
 <YxjBSxtoav7PQVei@nazgul.tnic>
 <20220907162245.5ddexpmibjbanrho@offworld>
 <6318cc415161f_166f2941e@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6318cc415161f_166f2941e@dwillia2-xfh.jf.intel.com.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:52:17AM -0700, Dan Williams wrote:
> To be clear nfit stuff and CXL does run in guests, but they do not
> support secure-erase in a guest.
> 
> However, the QEMU CXL enabling is building the ability to do *guest
> physical* address space management, but in that case the driver can be
> paravirtualized to realize that it is not managing host-physical address
> space and does not need to flush caches. That will need some indicator
> to differentiate virtual CXL memory expanders from assigned devices.

Sounds to me like that check should be improved later to ask
whether the kernel is managing host-physical address space, maybe
arch_flush_memregion() should check whether the address it is supposed
to flush is host-physical and exit early if not...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

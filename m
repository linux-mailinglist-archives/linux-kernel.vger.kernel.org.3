Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7100552A500
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349097AbiEQOfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348989AbiEQOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:35:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DA74FC79;
        Tue, 17 May 2022 07:35:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9F61A21CAC;
        Tue, 17 May 2022 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652798127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jgvKwJyxQy0RTaoF5NNfAc97nv5WUFvl/AOcJ3/X9dU=;
        b=RkBtCW1df314cInTItdNXWETZwL6U7kjsXupg+j/SZS8w+9tOhsI2t4gFksowOEmRppcLu
        zXBXN03IHw4gAlbkpovC5tg20aIvUHoAqjeyfvTEvjTdI86nBlXKFydqhAwJQPJkSZBSm1
        EgD3c5nCbWhRhhta3IUb8q6Wb/RKbcs=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 773712C141;
        Tue, 17 May 2022 14:35:27 +0000 (UTC)
Date:   Tue, 17 May 2022 16:35:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "ojeda@kernel.or" <ojeda@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "avimalin@gmail.com" <avimalin@gmail.com>,
        "atomlin@redhat.com" <atomlin@redhat.com>,
        Onkarnath <onkarnath.1@samsung.com>
Subject: Re: [PATCH modules-next 1/1] kallsyms: enhance %pS/s/b printing when
 KALLSYSMS is disabled
Message-ID: <YoOykGzkWB+k7Las@alley>
References: <202205111513.3AD646936@keescook>
 <20220421041542.9195-1-maninder1.s@samsung.com>
 <CGME20220421041604epcas5p414cf2e851d1bd828a151dc6b2b004680@epcms5p3>
 <20220517035810epcms5p3f7dc52887e356559b55a2cbf9d04a039@epcms5p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517035810epcms5p3f7dc52887e356559b55a2cbf9d04a039@epcms5p3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-05-17 09:28:10, Maninder Singh wrote:
> Hi Kees,
> 
> > 
> > I'd like this patch reverted from -next.
> > - too many logical changes is a single patch
> 
> ok, will try to break patch in separate patches.
> 
> > - addition of dangerous API usage
> 
> sprintf was alraedy there, just changed its position
> and in current logic it seems not possible to change it.
> 
> Because sprint_symbol interface is made without len of array
> 
> int sprint_symbol(char *buffer, unsigned long address)
> {
>         return __sprint_symbol(buffer, address, 0, 1, 0);
> }
> EXPORT_SYMBOL_GPL(sprint_symbol);

Sigh, the kallsyms API is not safe in general. For example,
the following functions have the same problem:

unsigned long kallsyms_lookup_name(const char *name);
const char *kallsyms_lookup(unsigned long addr,
			    unsigned long *symbolsize,
			    unsigned long *offset,
			    char **modname, char *namebuf);
int lookup_symbol_name(unsigned long addr, char *symname);
int lookup_symbol_attrs(unsigned long addr, unsigned long *size, unsigned long *offset, char *modname, char *name);


> So either we need to change API declaration for all cases.
> please suggest, then I can make one separate change to include
> size of buffer as argument.

It would be lovely if you could fix the API.

> otherwise there is no benefit to take care of size at some places only.

Well, the sprint_*() APIs are more dangerous because the underlying
__sprint_symbol() could do several sprintf() calls. It is not easy
to compute the sufficient buffer size.

The *lookup*() APIs are slightly more safe because the buffer is
just for the symbol name. The size always should be KSYM_NAME_LEN.
Anyway, it would be great to make it safe as well.

Best Regards,
Petr

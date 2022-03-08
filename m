Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ADC4D2062
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349379AbiCHSrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbiCHSrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:47:06 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C975252E68;
        Tue,  8 Mar 2022 10:46:09 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2db2add4516so212689657b3.1;
        Tue, 08 Mar 2022 10:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDC0XAilCgbcryKBRl2g4eDKDF5WNAkKN/Aq6JLLyNE=;
        b=A737hHPppRUMAJCj8EJW52sD56io//KFT1Y1snnJi+7h091fXu3VGul/s55kaUtJlu
         ActtZTpSqlaDW9ajxXw6LfaulnOW1vNOvwEEJPB7i9NlxvUnmu6Sy093dOHe+cAcsYdX
         8em5wNXB8cvnROkSl/B4cjx2QTOzKkJkg6kovvynd3m5WrOhNlmOCcvhveqmoEtHG3vS
         7kbNwXGoPUCoCLv/HZFB13sts5uTTvsDjTm/6YdCc39dfAEPaQ1mD3trIPzQDZ658vxA
         eg6s2z3jLpqDU/ITYQcLLg2zIXizuiAXxzNIb4OeWli4sICa9J/fTx4Y6x7Zqdu/u90i
         vHuA==
X-Gm-Message-State: AOAM531yI6CcWdXWGgBYTVMM2f6Xj0g+lMcG3F7vAxR7OqCI2VpWYbkK
        Y2Y1gq18j1u3bEZk139fWvvYD0RIxvFpezFLQag=
X-Google-Smtp-Source: ABdhPJwwaYpLQvtWeMoZt77J8Nl964tya0BpXQrxquUEcKDCHyWyIruttGdkBBl2DgUMyALCB/1ioplRwSR3YuToomQ=
X-Received: by 2002:a81:f20e:0:b0:2dc:56e1:918e with SMTP id
 i14-20020a81f20e000000b002dc56e1918emr14149104ywm.19.1646765168917; Tue, 08
 Mar 2022 10:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20220306024620.5847-1-rdunlap@infradead.org> <87fsnu7cnr.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87fsnu7cnr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Mar 2022 19:45:58 +0100
Message-ID: <CAJZ5v0hpesOogFv1g6h96xJnuaJ=paqWc3Bg2rOzMus4FMqTuQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: fix return value of __setup handlers
To:     "Huang, Ying" <ying.huang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 2:51 AM Huang, Ying <ying.huang@intel.com> wrote:
>
> Randy Dunlap <rdunlap@infradead.org> writes:
>
> > __setup() handlers should return 1 to indicate that the boot option
> > has been handled. Returning 0 causes a boot option to be listed in
> > the Unknown kernel command line parameters and also added to init's
> > arg list (if no '=' sign) or environment list (if of the form 'a=b').
> >
> > Unknown kernel command line parameters "erst_disable
> >   bert_disable hest_disable BOOT_IMAGE=/boot/bzImage-517rc6", will be
> >   passed to user space.
> >
> >  Run /sbin/init as init process
> >    with arguments:
> >      /sbin/init
> >      erst_disable
> >      bert_disable
> >      hest_disable
> >    with environment:
> >      HOME=/
> >      TERM=linux
> >      BOOT_IMAGE=/boot/bzImage-517rc6
> >
> > Fixes: a3e2acc5e37b ("ACPI / APEI: Add Boot Error Record Table (BERT) support")
> > Fixes: a08f82d08053 ("ACPI, APEI, Error Record Serialization Table (ERST) support")
> > Fixes: 9dc966641677 ("ACPI, APEI, HEST table parsing")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>
> Good catch!  Thanks for fixing!
>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Applied as 5.18 material, thanks!

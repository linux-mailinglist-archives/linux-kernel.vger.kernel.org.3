Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC145628C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiGACKy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Jun 2022 22:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiGACKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:10:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC44059277
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:10:51 -0700 (PDT)
X-UUID: 3344d0ebb64e47489c52e1d8195ecf08-20220701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:ace3f042-19d7-4a88-87e3-11a9f9a03709,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:87442a2,CLOUDID:81004ed6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:1,File:ni
        l,QS:nil,BEC:nil,COL:0
X-UUID: 3344d0ebb64e47489c52e1d8195ecf08-20220701
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1722577886; Fri, 01 Jul 2022 10:10:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 1 Jul 2022 10:10:43 +0800
Received: from mszsdtcf10.gcn.mediatek.inc (10.16.4.60) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 1 Jul 2022 10:10:42 +0800
From:   Haibo Li <haibo.li@mediatek.com>
To:     <samitolvanen@google.com>
CC:     <andrealmeid@igalia.com>, <atomlin@redhat.com>,
        <christophe.leroy@csgroup.eu>, <dmitry.torokhov@gmail.com>,
        <haibo.li@mediatek.com>, <jgross@suse.com>,
        <keescook@chromium.org>, <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <llvm@lists.linux.dev>,
        <matthias.bgg@gmail.com>, <mcgrof@kernel.org>,
        <mhiramat@kernel.org>, <nathan@kernel.org>,
        <ndesaulniers@google.com>, <peterz@infradead.org>,
        <xiaoming.yu@mediatek.com>, <yangtiezhu@loongson.cn>
Subject: Re: [PATCH 1/2] ANDROID: cfi: enable sanitize for cfi.c
Date:   Fri, 1 Jul 2022 10:10:42 +0800
Message-ID: <20220701021042.48037-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABCJKucgdTqDFyTumSCBHiyRVWgvJEhR2Fn=MxyMpTjWtvCV=Q@mail.gmail.com>
References: <CABCJKucgdTqDFyTumSCBHiyRVWgvJEhR2Fn=MxyMpTjWtvCV=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Jun 30, 2022 at 2:47 AM Haibo Li <haibo.li@mediatek.com> wrote:
> >
> > currenly,cfi.c is excluded from cfi sanitize because of cfi handler.
> > The side effect is that we can not transfer function pointer to other
> > files which enable cfi sanitize.
> >
> > Enable cfi sanitize for cfi.c and bypass cfi check for
> > __cfi_slowpath_diag
> >
> > Signed-off-by: Haibo Li <haibo.li@mediatek.com>
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> > ---
> >  kernel/Makefile | 3 ---
> >  kernel/cfi.c    | 8 +++++++-
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/Makefile b/kernel/Makefile index
> > a7e1f49ab2b3..a997bef1a200 100644
> > --- a/kernel/Makefile
> > +++ b/kernel/Makefile
> > @@ -40,9 +40,6 @@ KCSAN_SANITIZE_kcov.o := n
> UBSAN_SANITIZE_kcov.o :=
> > n  CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack)
> > -fno-stack-protector
> >
> > -# Don't instrument error handlers
> > -CFLAGS_REMOVE_cfi.o := $(CC_FLAGS_CFI)
> > -
> >  obj-y += sched/
> >  obj-y += locking/
> >  obj-y += power/
> > diff --git a/kernel/cfi.c b/kernel/cfi.c index
> > 08102d19ec15..456771c8e454 100644
> > --- a/kernel/cfi.c
> > +++ b/kernel/cfi.c
> > @@ -311,7 +311,7 @@ static inline cfi_check_fn find_check_fn(unsigned
> long ptr)
> >         return fn;
> >  }
> >
> > -void __cfi_slowpath_diag(uint64_t id, void *ptr, void *diag)
> > +static inline void __nocfi _run_cfi_check(u64 id, void *ptr, void
> > +*diag)
> >  {
> >         cfi_check_fn fn = find_check_fn((unsigned long)ptr);
> >
> > @@ -320,6 +320,12 @@ void __cfi_slowpath_diag(uint64_t id, void *ptr,
> void *diag)
> >         else /* Don't allow unchecked modules */
> >                 handle_cfi_failure(ptr);  }
> > +
> > +void __cfi_slowpath_diag(u64 id, void *ptr, void *diag) {
> > +       /*run cfi check without cfi sanitize to avoid calling cfi handler
> recursively*/
> > +       _run_cfi_check(id, ptr, diag); }
> >  EXPORT_SYMBOL(__cfi_slowpath_diag);
> 
> You can just add __nocfi to __cfi_slowpath_diag, right? There's no need for the
> separate function.

    You are right.Now there is no requirement for constant crc of __cfi_slowpath_diag.
I will change it later.
	

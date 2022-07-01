Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE3B56293C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiGACmp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Jun 2022 22:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGACmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:42:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F2A61D76
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:42:41 -0700 (PDT)
X-UUID: b47711d323db4ee793388f215db781f7-20220701
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:c36dd587-d974-4074-9594-77900939fd47,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:27,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:27
X-CID-INFO: VERSION:1.1.7,REQID:c36dd587-d974-4074-9594-77900939fd47,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:27,FILE:0,RULE:Release_HamU,ACTI
        ON:release,TS:27
X-CID-META: VersionHash:87442a2,CLOUDID:82f14ed6-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:IGNORED,Recheck:0,SF:28|100|16|19|48|101,TC:nil,Content:-5,EDM:-3,IP:n
        il,URL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: b47711d323db4ee793388f215db781f7-20220701
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <haibo.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 173100515; Fri, 01 Jul 2022 10:42:35 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 1 Jul 2022 10:42:34 +0800
Received: from mszsdtcf10.gcn.mediatek.inc (10.16.4.60) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 1 Jul 2022 10:42:33 +0800
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
Subject: Re: [PATCH 2/2] ANDROID: cfi: free old cfi shadow asynchronously
Date:   Fri, 1 Jul 2022 10:42:33 +0800
Message-ID: <20220701024233.52022-1-haibo.li@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CABCJKudz5O5_-1q1H0o2DFRcnpMQDBPv4STUVa2bOE9ePaeyDA@mail.gmail.com>
References: <CABCJKudz5O5_-1q1H0o2DFRcnpMQDBPv4STUVa2bOE9ePaeyDA@mail.gmail.com>
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

> Hi,
> 
> On Thu, Jun 30, 2022 at 2:47 AM Haibo Li <haibo.li@mediatek.com> wrote:
> >
> > Currenly, it uses synchronize_rcu() to wait old rcu reader to go away
> > in update_shadow.In embedded platform like ARM CA7X, load_module
> > blocks 40~50ms in update_shadow.
> > When there are more than one hundred kernel modules, it blocks several
> > seconds.
> >
> > To accelerate load_module,change synchronize_rcu to call_rcu.
> >
> > Signed-off-by: Haibo Li <haibo.li@mediatek.com>
> > Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> 
> Thanks for the patch! Please drop ANDROID: from the subject line, that's only
> used in the Android kernel trees.
> 
   Thanks for the comment.I will change it in next patch.  
> >  kernel/cfi.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/cfi.c b/kernel/cfi.c index
> > 456771c8e454..a4836d59ca27 100644
> > --- a/kernel/cfi.c
> > +++ b/kernel/cfi.c
> > @@ -43,6 +43,8 @@ typedef u16 shadow_t;  struct cfi_shadow {
> >         /* Page index for the beginning of the shadow */
> >         unsigned long base;
> > +       /* rcu to free old cfi_shadow asynchronously */
> > +       struct rcu_head rcu;
> >         /* An array of __cfi_check locations (as indices to the shadow) */
> >         shadow_t shadow[1];
> >  } __packed;
> > @@ -182,6 +184,13 @@ static void remove_module_from_shadow(struct
> cfi_shadow *s, struct module *mod,
> >         }
> >  }
> >
> > +static void _cfi_shadow_free_rcu(struct rcu_head *rcu)
> 
> I think this can be simply renamed to free_shadow.
   Thanks for the comment.I will change it in next patch.
> 
> > +{
> > +       struct cfi_shadow *old = container_of(rcu, struct cfi_shadow,
> > +rcu);
> > +
> > +       vfree(old);
> > +}
> > +
> >  typedef void (*update_shadow_fn)(struct cfi_shadow *, struct module *,
> >                         unsigned long min_addr, unsigned long
> > max_addr);
> >
> > @@ -211,11 +220,10 @@ static void update_shadow(struct module *mod,
> > unsigned long base_addr,
> >
> >         rcu_assign_pointer(cfi_shadow, next);
> >         mutex_unlock(&shadow_update_lock);
> > -       synchronize_rcu();
> >
> >         if (prev) {
> >                 set_memory_rw((unsigned long)prev, SHADOW_PAGES);
> > -               vfree(prev);
> > +               call_rcu(&prev->rcu, _cfi_shadow_free_rcu);
> >         }
> >  }
> 
> It's probably better to keep the pages read-only until they're actually released.
> Can you move the set_memory_rw call to the new function?
> 
   Since call_rcu and rcu callbacks change members in &prev->rcu,the old pages need to be rw at first.
 

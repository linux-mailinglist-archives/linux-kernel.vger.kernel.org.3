Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF5E53640C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 16:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353216AbiE0O2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbiE0O2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:28:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9277123886
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=7341L4ChNBrKLI/4kTfzKe7cMWslrU4u2g9ALhgh9pU=;
        t=1653661687; x=1654871287; b=I39K8qkDcTowR/EVjWM+p5pCYCrxFMXySDyATwRbWiojCrK
        Ni/f/bICOSHPq40e8Oi1yOuf6s6T41H0QyM5bAhqS9THQLPOXfZONY0dRqU7cBvhDRWCkb3H60Xuq
        M0mATYvu0tCFsRVyKDClDmuYvcdcYbJQKPL5hUWT6sykalL2sJeHE3Qn1lFVvfQ+n9oxEVd+BjYNF
        yOkvxl7SqbH+TdeIKsz45W3KEiLoVpMgqVImDncBMhaBGDmQi3vKoyAgPDLFvZ+apQbTSXZhF4p9P
        UY4+gKJuE1MLU8w2xHM8Z+9i7kYJfrfu4R8kCn03/S/fQ7+/76Sw3azIf23hNXbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuawW-0064cA-MV;
        Fri, 27 May 2022 16:27:56 +0200
Message-ID: <5eef2f1b43c25447ccca2f50f4964fd77a719b08.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Latypov <dlatypov@google.com>
Date:   Fri, 27 May 2022 16:27:55 +0200
In-Reply-To: <CACT4Y+aH7LqDUqAyQ7+hkyeZTtkYnMHia73M7=EeAzMYzJ8pQg@mail.gmail.com>
References: <20220525111756.GA15955@axis.com>
         <20220526010111.755166-1-davidgow@google.com>
         <e2339dcea553f9121f2d3aad29f7428c2060f25f.camel@sipsolutions.net>
         <CACT4Y+ZVrx9VudKV5enB0=iMCBCEVzhCAu_pmxBcygBZP_yxfg@mail.gmail.com>
         <6fa1ebe49b8d574fb1c82aefeeb54439d9c98750.camel@sipsolutions.net>
         <CACT4Y+bhBMDn80u=W8VBbn4uZg1oD8zsE3RJJC-YJRS2i8Q2oA@mail.gmail.com>
         <134957369d2e0abf51f03817f1e4de7cbf21f76e.camel@sipsolutions.net>
         <CACT4Y+aH7LqDUqAyQ7+hkyeZTtkYnMHia73M7=EeAzMYzJ8pQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-27 at 15:52 +0200, Dmitry Vyukov wrote:
> On Fri, 27 May 2022 at 15:27, Johannes Berg <johannes@sipsolutions.net> w=
rote:
> >=20
> > On Fri, 2022-05-27 at 15:18 +0200, Dmitry Vyukov wrote:
> > > On Fri, 27 May 2022 at 15:15, Johannes Berg <johannes@sipsolutions.ne=
t> wrote:
> > > >=20
> > > > On Fri, 2022-05-27 at 15:09 +0200, Dmitry Vyukov wrote:
> > > > > > I did note (this is more for kasan-dev@) that the "freed by" is=
 fairly
> > > > > > much useless when using kfree_rcu(), it might be worthwhile to =
annotate
> > > > > > that somehow, so the stack trace is recorded by kfree_rcu() alr=
eady,
> > > > > > rather than just showing the RCU callback used for that.
[...]
> Humm... I don't have any explanation based only on this info.
> Generally call_rcu stacks are memorized and I see the call is still there=
:
> https://elixir.bootlin.com/linux/v5.18/source/kernel/rcu/tree.c#L3595

Oh, that's simple then, UML is !SMP && !PREEMPT so it gets TINY_RCU
instead of TREE_RCU.

Unfortunately, it's not entirely trivial to fix, something like this,
mostly because of header maze (cannot include kasan.h in rcutiny.h):

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 5fed476f977f..d84e13f2c384 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -38,7 +38,7 @@ static inline void synchronize_rcu_expedited(void)
  */
 extern void kvfree(const void *addr);
=20
-static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t f=
unc)
+static inline void __kvfree_call_rcu(struct rcu_head *head, rcu_callback_t=
 func)
 {
 	if (head) {
 		call_rcu(head, func);
@@ -51,6 +51,15 @@ static inline void kvfree_call_rcu(struct rcu_head *head=
, rcu_callback_t func)
 	kvfree((void *) func);
 }
=20
+#ifdef CONFIG_KASAN_GENERIC
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
+#else
+static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t f=
unc)
+{
+	__kvfree_call_rcu(head, func);
+}
+#endif
+
 void rcu_qs(void);
=20
 static inline void rcu_softirq_qs(void)
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 340b3f8b090d..aa235f0332ba 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -217,6 +217,18 @@ bool poll_state_synchronize_rcu(unsigned long oldstate=
)
 }
 EXPORT_SYMBOL_GPL(poll_state_synchronize_rcu);
=20
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	if (head) {
+		void *ptr =3D (void *) head - (unsigned long) func;
+
+		kasan_record_aux_stack_noalloc(ptr);
+	}
+
+	__kvfree_call_rcu(head, func);
+}
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
+
 void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);




Or I guess I could copy/paste

#ifdef CONFIG_KASAN_GENERIC
void kasan_record_aux_stack_noalloc(void *ptr);
#else /* CONFIG_KASAN_GENERIC */
static inline void kasan_record_aux_stack_noalloc(void *ptr) {}
#endif /* CONFIG_KASAN_GENERIC */


into rcutiny.h, that'd be smaller, and export the symbol ...

johannes

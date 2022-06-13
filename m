Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47FC549C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiFMSw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbiFMSwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:52:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D3F33B1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:53:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w21so6152666pfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ITs/o5hQHbV0Vn0H0fKwSd6ykDSKzlbe/b9VvEaDGY0=;
        b=l94V0CMAYAhO8qc2+KxFaAQQzGPOQNEJ0Y7xfUBPcDKbtEGgyFrHF7uZaDpp1nIgeb
         shmIuWVGKwucUoXkuUXPv846GZzIxaPTXfeZhLxs9AHAO1OE9/7uW/uyTtfxzWP752hB
         Gb/zH87HwjjYX7vD/R8LBuPtud2NA3mhs56EC6ZIa7+MMDLL/o2tFbsQUzsUPivxnyvT
         VbFc5C6rgL0aBaS2LsDiI+OjsFMPwBjEDYregx0r6916nt2qkibt/DaWklhXnr9T+I2l
         1IJDhBtZlWobxOdtn6K2GFBF52eFsPPE61Hxq1Y7sPwl9lVFQMwFRgXC+PA9UynI/F/o
         3P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ITs/o5hQHbV0Vn0H0fKwSd6ykDSKzlbe/b9VvEaDGY0=;
        b=d163G1ZznZiFPjUxS2goVWbogl9p5oWiwrbDWsN/8Ru2dJ/Acz1NEXVat7OxXkb7X+
         b1NcvG4YKHTSIkf/k7rtMn/WXd2plMUg8qC2LSqF5q4gQQrjKoVqjoumWW/8nt+ckIl9
         bOVpPxktvbFf/ABWo3+EPJ7cBtnPhgcfOxskUeR5MssLAgMTmuo8yT3zrxCFf8T9ct6g
         +1ml/xn8BoA+fFmtIBKxprnI62qHh9wnzuQPP5wos0rB9DfteRIr1PiZNUsmavPM68HC
         em3LzzFPybDl/lhAhkg4E9wJTCh3tFfPjGcdtJDgPF8e7iPIqI9oo0O16UNnInM1lFcd
         uOMQ==
X-Gm-Message-State: AOAM533j5hl+sYAEdK8jxE6PiodU8f5Wp+CNXq77f31QL/5uzFYh20Zp
        3KrlkTUNt6fQmQiymfEhI/5fbQ==
X-Google-Smtp-Source: ABdhPJw0oB3rJMKGU4F6xcOksvW9tlW38gSH1oAQnyLSfsH0+xIUOfstojLpGyMDF7cpatpM8o4lKQ==
X-Received: by 2002:a65:6e96:0:b0:3fd:c8b7:5fa6 with SMTP id bm22-20020a656e96000000b003fdc8b75fa6mr204484pgb.569.1655135592440;
        Mon, 13 Jun 2022 08:53:12 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b00163e4410b82sm5293496pll.239.2022.06.13.08.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 08:53:11 -0700 (PDT)
Date:   Mon, 13 Jun 2022 15:53:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Gonda <pgonda@google.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: arch/x86/kvm/svm/sev.c:1605:30: warning: parameter 'role' set
 but not used
Message-ID: <YqddYy6nO0+G/kVK@google.com>
References: <202206131853.x4KJwC5Q-lkp@intel.com>
 <CAMkAt6oxQqRCMt54ZRsx_TGd2banbwAy4Hq+A6GHokpMsoo-AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMkAt6oxQqRCMt54ZRsx_TGd2banbwAy4Hq+A6GHokpMsoo-AA@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022, Peter Gonda wrote:
> On Mon, Jun 13, 2022 at 5:03 AM kernel test robot <lkp@intel.com> wrote:
> >   1603
> >   1604  static int sev_lock_vcpus_for_migration(struct kvm *kvm,
> > > 1605                                          enum sev_migration_role role)
> >   1606  {
> >   1607          struct kvm_vcpu *vcpu;
> >   1608          unsigned long i, j;
> >   1609          bool first = true;
> >   1610
> >   1611          kvm_for_each_vcpu(i, vcpu, kvm) {
> >   1612                  if (mutex_lock_killable_nested(&vcpu->mutex, role))
> >   1613                          goto out_unlock;
> >   1614
> >
> 
> I am confused about this warning. |role| is used on this line above.
> Is this because CONFIG_DEBUG_LOCK_ALLOC the subclass argument is
> dropped in the macro?

Yep, at that point the compiler can easily detect that there's no actual usage of
the parameter.

There's no need for the "first" variable, it's the same as "i == 0" and "j == 0".
With that out of the way, the role and mutex_release/mutex_acquire shenanigans can
be wrapped with ifdeffery.  Not the prettiest thing, but I actually like the #ifdefs
because they effectively document that KVM is playing games to make lockdep happy.

I'll send this as a formal patch, I think it'll make clang-15 happy.

---
 arch/x86/kvm/svm/sev.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 51fd985cf21d..593c61683484 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1606,38 +1606,35 @@ static int sev_lock_vcpus_for_migration(struct kvm *kvm,
 {
 	struct kvm_vcpu *vcpu;
 	unsigned long i, j;
-	bool first = true;

 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (mutex_lock_killable_nested(&vcpu->mutex, role))
 			goto out_unlock;

-		if (first) {
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		if (!i)
 			/*
 			 * Reset the role to one that avoids colliding with
 			 * the role used for the first vcpu mutex.
 			 */
 			role = SEV_NR_MIGRATION_ROLES;
-			first = false;
-		} else {
+		else
 			mutex_release(&vcpu->mutex.dep_map, _THIS_IP_);
-		}
+#endif
 	}

 	return 0;

 out_unlock:

-	first = true;
 	kvm_for_each_vcpu(j, vcpu, kvm) {
 		if (i == j)
 			break;

-		if (first)
-			first = false;
-		else
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		if (j)
 			mutex_acquire(&vcpu->mutex.dep_map, role, 0, _THIS_IP_);
-
+#endif

 		mutex_unlock(&vcpu->mutex);
 	}

base-commit: 8a6d3a6ec6a821c5ddb3972fdbad9c4149eabf1e
--



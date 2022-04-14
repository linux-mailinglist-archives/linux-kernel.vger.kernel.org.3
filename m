Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADD5501E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347025AbiDNWbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347019AbiDNWbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:31:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AEEC2A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:29:19 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c12-20020a17090a020c00b001cba1ebb20cso6958676pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UxPoFf2t5u+s0uISceiuQkf792IJ+jbIydpuaGQO9DQ=;
        b=nP/6SQFXpMUu3tuK0mnNqZ7AmYkQ/GFRolTz3PgEzzgxGxVz9uESKrDSzSoo/vO8eP
         S3JnL6U12W9U5r4HsjqwoCdO1WiGEHqJghC1KHK4TcjDrWSk/1SLi7b+0gPBO6Wj3Ey5
         LXmgazCVs+J6Jm5ZKeyxuxstFaMDNeG996WwvYmd/Va8FToGNiqPuT4lDTypoFNpX/oC
         PpmtUDxY7BNZIHoxHqsqp6kA9pR96i0+DPhYTM8zRBPp2zpx45fX8Ov2m72INCCmiEBe
         sVy7ysPZZInuwMnyKc2r17EB9gI8ZGM9ETdUkV/i56pXeMG719MUKeGav3lxlSJGhlBw
         KUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UxPoFf2t5u+s0uISceiuQkf792IJ+jbIydpuaGQO9DQ=;
        b=hta6KSdlTQWZnuDOdC9uzlHuk2Wo1VTFjIxwEDiEeZrV0ZYK3/k3IzIntYNGfAwkqJ
         vdAvHOT4M5EnJp46Lj0/6+3lK7Ydc6pGZ/zQA3NZm6ZuzuPVy0EatwrElwmtvrQa/mO3
         DhWAD/Ryi2OW00Zo+1NGUKcjEPbiMXSXE9rZqW1U+Z/TwOMrlM/jb/WV10yZEaYkTYu4
         eO5ue6bu4oedWrqegw60EbVAL45g58IQTVV9HhbdZugcqgtAmlACR3bCCS6CaLeWDK9K
         5TSFXyLM/5cfpoSfSbkmAdP3/cV0Wgd0dR2k/bhmZ6puS2HUpvs/Keh8dru5RuYOvNCk
         CNZA==
X-Gm-Message-State: AOAM531+3Gr/Rlh5ksMqEWLWt07X6gq+9Hpqs6XsPkTTWx3kOAhwDxIk
        tEeb+qjbJaEekkvxkdpdxAZWuQ==
X-Google-Smtp-Source: ABdhPJyimW5C+2lcyN6muRkrOOsyobCxgwfnT89oBCkWXVd+0MJ2XoKF57NjfZNDe1UEwqpwjyBxzw==
X-Received: by 2002:a17:903:18c:b0:158:7255:4bc6 with SMTP id z12-20020a170903018c00b0015872554bc6mr19562029plg.106.1649975359257;
        Thu, 14 Apr 2022 15:29:19 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k8-20020aa790c8000000b00505d6016097sm850896pfk.94.2022.04.14.15.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:29:18 -0700 (PDT)
Date:   Thu, 14 Apr 2022 22:29:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v5 10/10] KVM: selftests: Test disabling NX hugepages on
 a VM
Message-ID: <YligOuhn9HG0/uGO@google.com>
References: <20220413175944.71705-1-bgardon@google.com>
 <20220413175944.71705-11-bgardon@google.com>
 <YldTMfNEzsweKi1V@google.com>
 <CANgfPd85MST8Lf_LhQ++JjxwJRvBoYk8FpOwzYbOhBL1zz157w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd85MST8Lf_LhQ++JjxwJRvBoYk8FpOwzYbOhBL1zz157w@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022, Ben Gardon wrote:
> On Wed, Apr 13, 2022 at 3:48 PM Sean Christopherson <seanjc@google.com> wrote:
> > First off, huge kudos for negative testing!  But, it's going to provide poor coverage
> > if we teach everyone to use the runner script, because that'll likely require root on
> > most hosts, e.g. to futz with the module param.
> >
> > Aha!  Idea.  And it should eliminate the SYS_reboot shenanigans, which while hilarious,
> > are mildy scary.
> >
> > In the runner script, wrap all the modification of sysfs knobs with sudo, and then
> > (again with sudo) do:
> >
> >         setcap cap_sys_boot+ep path/to/nx_huge_pages_test
> >         path/to/nx_huge_pages_test MAGIC_NUMBER -b
> >
> > where "-b" means "has CAP_SYS_BOOT".  And then
> >
> >         setcap cap_sys_boot-ep path/to/nx_huge_pages_test
> >         path/to/nx_huge_pages_test MAGIC_NUMBER
> >
> > Hmm, and I guess if the script is run as root, just skip the second invocation.
> 
> Wouldn't it be easier to just run the test binary twice and just have
> the second time run without root permissions? I don't know if there's
> an easy way to do that.

I don't think so, e.g. what if there is no other user account to switch to?  On
the other hand, I doubt I'm the only person that typically runs selftests with a
user account.

Using setcap isn't hard, e.g.

	# If the test isn't running as root, verify KVM correctly rejects the
	# per-VM override if the process doesn't have CAP_SYS_BOOT.
	if [[ $(id -u) -ne 0 ]]; then
		sudo setcap cap_sys_boot-ep path/to/nx_huge_pages_test
		path/to/nx_huge_pages_test MAGIC_NUMBER

		sudo setcap cap_sys_boot+ep path/to/nx_huge_pages_test
	fi

	# The test now has CAP_SYS_BOOT, or is running as root.
	path/to/nx_huge_pages_test MAGIC_NUMBER -b

Bonus points if you want to save/restore the capability. 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8318C501D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 23:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244456AbiDNVjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 17:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiDNVjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:39:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706F36BDCF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:36:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so6943591pja.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 14:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZwqsSd8kK//Ty3psSXbHkN/qQik6vo6YZ0uDueArJzs=;
        b=rSdQRfJjuZsb4h+Fu1jiDnVTCJBmeCSwUBTVNomZ5qdc6nxby4DM9FZTFmV9m1HXGV
         JZF7Mhn7w+8f0QZ6saI+07Dm6ngeweQYMdPPnGIN5pqUWo++ilejxzQR4CXSJgsdcddH
         Z8BRvmrPDnhoobFy1t/iI8BLxqs9/dzBFRftvSKticHSkTLhZb4NJvzOlovlfQsk8+xO
         CcRiG3BScyhOvQjj+AQNKbqqBmU8bmvd8Fqf9NzlERdR/lof59yeFO9LlT2H7kP6JzFF
         PPXvNuwwEeE56IWQ30Lg7ZTTkcOq8exKo/9AQPn/8VTjlYFGbpwv94/xSM9PxauUho2o
         YJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZwqsSd8kK//Ty3psSXbHkN/qQik6vo6YZ0uDueArJzs=;
        b=SNPjwakBhHmz3tsnPWO0I8DppdCYq7uzNArMPzln3Rv0Mp1wGpQJlhL2UsXV1OAqML
         z7uw1l0LQyA8aHW/A53NwH54hzTGMKpk22mKunf0eK4m7f540nA51AdWU69kh7xSrikf
         neGwFtrxVmhghkJCgkn0nzb7DQHt3DEBEI68sbYqRoQN5euK3+e7Z6QpVLobHwQ3zmTY
         HG2AXTyAk6X9PJ5GNzlUDEs7sjBYqI+5Ggez7EKhevim2R1Kf/GHrckrpt0VWhG6odbo
         VWEcF07VKFAPnQ+EO+h+hW4lZ8X7jNmTcgRuWqj0DbJJm7y/q1Pbl3NI5nbTS94cwl/O
         N4iA==
X-Gm-Message-State: AOAM531oq53YcajrLDDqnbSgo+2QlASocv9piz84uHxazuXPN0ifhz8E
        NHtp101xiCGRowespjW52GBwcQ==
X-Google-Smtp-Source: ABdhPJxShsm33JtSld9PyGypzrkdDGtOwK8ZlnrDjirccYqaCHu+mWwMwAhczp8ZxD/X+N8l6YvZAQ==
X-Received: by 2002:a17:903:249:b0:153:857c:a1fe with SMTP id j9-20020a170903024900b00153857ca1femr49062962plh.44.1649972194773;
        Thu, 14 Apr 2022 14:36:34 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y3-20020a056a00190300b004fa2411bb92sm818081pfi.93.2022.04.14.14.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 14:36:34 -0700 (PDT)
Date:   Thu, 14 Apr 2022 21:36:30 +0000
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
Subject: Re: [PATCH v5 06/10] KVM: selftests: Add NX huge pages test
Message-ID: <YliT3rWLDDMjjLJN@google.com>
References: <20220413175944.71705-1-bgardon@google.com>
 <20220413175944.71705-7-bgardon@google.com>
 <YldQOJjqLJxRz6Ea@google.com>
 <CANgfPd-LOxaJSvOhxQQ2MvJauimUHugrKRi0TFxNpq0ShL8rRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd-LOxaJSvOhxQQ2MvJauimUHugrKRi0TFxNpq0ShL8rRg@mail.gmail.com>
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
> On Wed, Apr 13, 2022 at 3:35 PM Sean Christopherson <seanjc@google.com> wrote:
> > > diff --git a/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
> > > new file mode 100755
> > > index 000000000000..19fc95723fcb
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/kvm/x86_64/nx_huge_pages_test.sh
> > > @@ -0,0 +1,25 @@
> > > +#!/bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0-only */
> > > +
> > > +# tools/testing/selftests/kvm/nx_huge_page_test.sh
> > > +# Copyright (C) 2022, Google LLC.
> >
> > This should either check for root or use sudo.
> 
> Is there not any scenario where the below setup commands could work
> without root?

Technically, yes, someone could be running the test as a non-root user with
the necessary permissions.  Practically speaking, I would be surprised if anyone
configures module params in that way.

That said, there's certainly no harm in using sudo as a fall back.

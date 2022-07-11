Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD845707C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiGKP5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiGKP5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:57:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A6A33413;
        Mon, 11 Jul 2022 08:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S5eI42e6zt7NmkB9y9JfjDA8loQFmC6DlzCNO41e3LY=; b=0Rhdgwxibnfkm5r5i7jTEVBK19
        imIyo9ZmAX7xikNkYe0icYcht/V3sLap/GbLNgDJAHCwfkQv3ZJYLRibFZl1VuCir5FdwHUlLC6I9
        yEPK/yR2Kj/HfvPRXsIw7cIo9Y1ju6zCOcEIEMJ2miOaDQChtOKy0/66LTxGvsfbkL0fv/jUEoxwM
        8dSnBSh60s7lkLKOYf5NR9hHEYHCOPoLV/i/QWNb0gT52afidT4Nb2hxISHO2R2ZMuod1PNHOXJea
        cLVU6pRhwjgwNv+denF7LFANFKRsf/jMU8tP65kNbIiYqCHIhV8dyMDgM65Rm6nTu4URTOE4Kyq0M
        iDTquLRw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAvmn-0033fT-53; Mon, 11 Jul 2022 15:57:25 +0000
Date:   Mon, 11 Jul 2022 08:57:25 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Aaron Tomlin <atomlin@atomlin.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>, rostedt@goodmis.org,
        cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        ghalat@redhat.com, oleksandr@natalenko.name, neelx@redhat.com,
        daniel.thompson@linaro.org, hch@infradead.org, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] module: kallsyms: Ensure preemption in add_kallsyms()
 with PREEMPT_RT
Message-ID: <YsxIZfhgdQnh2QsJ@bombadil.infradead.org>
References: <20220704161753.4033684-1-atomlin@redhat.com>
 <YsXNVSAtO+VDggcI@bombadil.infradead.org>
 <20220707165750.tk4fadpv3d4zr2mb@ava.usersys.com>
 <YscV7ujYs6Q60N+E@bombadil.infradead.org>
 <20220707185619.sryhytlfkolmklnn@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707185619.sryhytlfkolmklnn@ava.usersys.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 07:56:19PM +0100, Aaron Tomlin wrote:
> On Thu 2022-07-07 10:20 -0700, Luis Chamberlain wrote:
> > This is incredibly important information which should be added to the
> > commit log, specialy as PREEMPT_RT=y becomes a first class citizen.
> 
> Understood.
> 
> > 
> > > So, I would say this was a regression since earlier preemption was
> > > not disabled and we would dereference RCU-protected pointers explicitly
> > > i.e. without using the more appropriate rcu_dereference() family
> > > of primitives. That being said, these pointers cannot change in this
> > > context as explained previously.
> > > 
> > > Would the above be suitable - just to confirm before I send another
> > > iteration?
> > 
> > Yes, I would send this to Linus for the rc series. Please adjust the
> > commit log with all this information.
> 
> Will do.
> 
> > BTW I think there is just one more fix pending from you right?
> 
> Yes - I will send/or prepare it as a partial revert:
> 's/strscpy/strlcpy/' with a brief explanation.

If that is just the kallsyms fix Adrian Hunter already sent a fix:

https://lkml.kernel.org/r/20220701094403.3044-1-adrian.hunter@intel.com         

  Luis

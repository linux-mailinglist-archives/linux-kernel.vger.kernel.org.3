Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE5556AB26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiGGS6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbiGGS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:58:43 -0400
X-Greylist: delayed 136 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 11:58:37 PDT
Received: from p3plsmtpa11-09.prod.phx3.secureserver.net (p3plsmtpa11-09.prod.phx3.secureserver.net [68.178.252.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF40F313BF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:58:37 -0700 (PDT)
Received: from localhost ([82.17.115.212])
        by :SMTPAUTH: with ESMTPA
        id 9WfjoIiykskDW9WfkoGRQw; Thu, 07 Jul 2022 11:56:21 -0700
X-CMAE-Analysis: v=2.4 cv=Xs8/hXJ9 c=1 sm=1 tr=0 ts=62c72c55
 a=9gipVNR6X1CoIeAWHwLoWw==:117 a=9gipVNR6X1CoIeAWHwLoWw==:17
 a=IkcTkHD0fZMA:10 a=eTMhzGaj8ZgCguw-XMsA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
Date:   Thu, 7 Jul 2022 19:56:19 +0100
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>, rostedt@goodmis.org,
        cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        ghalat@redhat.com, oleksandr@natalenko.name, neelx@redhat.com,
        daniel.thompson@linaro.org, hch@infradead.org, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] module: kallsyms: Ensure preemption in add_kallsyms()
 with PREEMPT_RT
Message-ID: <20220707185619.sryhytlfkolmklnn@ava.usersys.com>
References: <20220704161753.4033684-1-atomlin@redhat.com>
 <YsXNVSAtO+VDggcI@bombadil.infradead.org>
 <20220707165750.tk4fadpv3d4zr2mb@ava.usersys.com>
 <YscV7ujYs6Q60N+E@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YscV7ujYs6Q60N+E@bombadil.infradead.org>
X-CMAE-Envelope: MS4xfGEMyf6Pz6mlMCSJNtHLJiYMh7dgsvwhNEd4JPCgr+M9xzhH21w9OoBC0LiHe0S66f3rKR/w8RiPmVGRg6390rdCCMs//UhGAo2BvKBdnklQnxf8+gFT
 1MhEawYd4UqLCWcXpEk3+GrGzN9EIURTCAroHzZLExclzNaTkGCvHNxGJxzeS74uTqi5JPWp8JrAgO05BGu4tBYo3WT8m97ptLDry6Gmc35loe3tDxVjlacs
 CsqNlDPolZvTBv1oOEImTbHehwgM0YHlNMD4L7hjHvFvPUhXQG+PqHkr/Otf0+9oHNZjkS9DrTmiDtX5lRIxk0dkF4Noo1/MwaHMF56zY38O0OB/d4viQf1Z
 4QM9vOKQ/xsFbnPG14tezHJOQmHcpFEmB7Z33etagOYbihoQRMyASRKfqPeG6tlhrZ+xwx4S5AKoYScqAlYTdAaAwf01QRjtA0itnBcqGYRk60dattexZee0
 aD18YX/UGoaGphq3kh90S78TQVaXbrcvY1WDwS8/+DmS/gZ1/Cnjj+ZqFv1dDQWt1Q7w7Wsb/IKW7yDYZRLOyA+QvHxFkwKUxzUMraJ5yyVUC5A6fe5XffHB
 /wObdG1dGe0QNfR1UNQB1yw31rZNsVt8nEYLs5WGSQc/VcURgsGfRQI2YaAxqAWEuyIgmx9Turs4kQ79ttJEiOLSIs3j7NYqbD1nDcuOMyk2LlcNgKA7h4MO
 8wclV0+bWyY=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-07-07 10:20 -0700, Luis Chamberlain wrote:
> This is incredibly important information which should be added to the
> commit log, specialy as PREEMPT_RT=y becomes a first class citizen.

Understood.

> 
> > So, I would say this was a regression since earlier preemption was
> > not disabled and we would dereference RCU-protected pointers explicitly
> > i.e. without using the more appropriate rcu_dereference() family
> > of primitives. That being said, these pointers cannot change in this
> > context as explained previously.
> > 
> > Would the above be suitable - just to confirm before I send another
> > iteration?
> 
> Yes, I would send this to Linus for the rc series. Please adjust the
> commit log with all this information.

Will do.

> BTW I think there is just one more fix pending from you right?

Yes - I will send/or prepare it as a partial revert:
's/strscpy/strlcpy/' with a brief explanation.


Kind regards,

-- 
Aaron Tomlin

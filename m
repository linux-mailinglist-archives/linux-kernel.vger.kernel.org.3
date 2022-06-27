Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035DA55D5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiF0ILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiF0ILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:11:41 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4FF6175
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:11:40 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i64so8265236pfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W3ppXV9ADhCkNwjk09PpXEVjLYngtZSAN5zmynsUohw=;
        b=B+JGqBiyivQYZouaaGnqLMJTiNYHClos19cIuC6bk+a9yN/DypqE4vcEuTBFm9CqKZ
         yxAhmkHMiUeGDmoug8+DU0NZYWRgV6cql/UTqWp5bhP0wHNTv4wLQellpIc4OLZ2BxYa
         boKfnruiVDvNMHdlgEmKIF9xmypIUFcAbK2UrOy05YcQSrpslZXigVvXGWGn+gGjjDhJ
         rcNDY3TacsWMkg4ySbPkFS6O9WqH0W9uQgKDKYp1mOc3pm8iU1fQUmEJh4NDKnaVhIxj
         bULq+qMAyAm5w04hBUNQE33obtPaFaGu7dxSS5BL0WK2DIkIVY0aUn3pHsi9U2axhRQy
         a5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=W3ppXV9ADhCkNwjk09PpXEVjLYngtZSAN5zmynsUohw=;
        b=4S6RuT8PYWl3yFBbNg/AAGakpSWm/MgexCbrHax5O8irjNG2kkeVJyQoEH8u/yzVSP
         L9Xcu0cQgD3cN9jmXfD188bdwcb8ClFAmpAsS0u9wAsyP4fz+3OeLqtAECibj7Y25JhR
         YT1JS/2y+ywSAqtj3tBfwkl+dW31dEvqdgKPuLIlbe9n/IM41P91D/dP3jVFgLdchPe2
         iKigsWPkLYXl1PmFLDkv/5n9m+pvwQYRmWT+Ku1BryX35O80m4tl/+jt1UsnR9yAqqNl
         sWPEmPUAVgMpgcbj/OusnKP5mLXlgUBNapp1tIloxF4Fhn1Vlx1M3zj/azlwHPMOAC7r
         QRrQ==
X-Gm-Message-State: AJIora9gwvkpHZP8KQxlsIx1LvmM4LbWIgrCW3O9AYpj1x9Dory++YSJ
        64dWXYhn4zGOWFCerZvHDxs=
X-Google-Smtp-Source: AGRyM1vwpIHrCNGxeWEtpOJyrJodLmGJ1ELq7vRz784eu5BZf/54vth7svdeV5zHenbFo5EGlAEbyg==
X-Received: by 2002:a05:6a00:ad0:b0:50a:51b3:1e3d with SMTP id c16-20020a056a000ad000b0050a51b31e3dmr13602986pfl.18.1656317499754;
        Mon, 27 Jun 2022 01:11:39 -0700 (PDT)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id g10-20020a170902934a00b0016a11b9aeaasm6483669plp.225.2022.06.27.01.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 01:11:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 27 Jun 2022 17:11:36 +0900
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE
 (INCOMPLETE)
Message-ID: <YrlmOA/Xd+U7+b2E@mtj.duckdns.org>
References: <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
 <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org>
 <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
 <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
 <YrjAJN7dDJ9R7Ocu@mtj.duckdns.org>
 <Yrlavf4Ymnz4T3LM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrlavf4Ymnz4T3LM@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:22:37AM +0200, Peter Zijlstra wrote:
> Yes, I so wish C had reasonable lambda expressions :/ But even if we
> could come up with a semi sensible syntax and implementation, it would
> still be many *many* years before we could actually use it in-kernel :-(

Yeah, I have a hard time imagining this happening in C but maybe we'll
get pretty good closure support through rust-in-kernel if that works
out. That'd be pretty sweet even though we might not be able to use it
everywhere.

Thanks.

-- 
tejun

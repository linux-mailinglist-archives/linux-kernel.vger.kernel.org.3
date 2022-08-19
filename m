Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8366B599BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348891AbiHSMHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348496AbiHSMG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:06:59 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CDB100977
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:06:57 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11c59785966so4976216fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BS8rpDUuJ+C81koEbZ/S2EZJvVDKAj+JtFCwhraayGM=;
        b=rjyqhlsYjTLeLXmxYbxShSma7EjgClUCI9vd55cQl4/HYoiwbSOCLsnxtVsC5bS0dk
         6jiDG3E1MLDdD3aFzejOiBT88qGvpI1E+zY+KUpWRoj6+ToJQfzyQ7gy7EYH1ZzSNhzE
         CYjBAw9N45A5Ik1GciMK/Me4x9s5pKTdDV51njHzzPBNlcr7KflpzdPpZDCPjaI0Zq7v
         SlxhpX5gIkW+OL+HM6hDcd/q+fNBeQoN4I7vSuEgM/VhqkKbG+IcOTfhlYXJ+FoBklca
         dOZ3AD+0ASczp3kV8Q9zjtvBZk56QvlSoEp3WWzZxWD/+U8ySnndL1pwgs44AorqPLEb
         0d0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BS8rpDUuJ+C81koEbZ/S2EZJvVDKAj+JtFCwhraayGM=;
        b=U+aYss5EqejPZFecJnHQBPRIowwph3KEQ48T2/NvkHhG5goDowfV0JbaOOUCkbIIMt
         K17GOp9BaG7abS0Os8iHP7yOiOjD3O9iQjCU+ZqWJUsV/K+3FlVM2KydJo3Y/aAKOVHE
         gGzPBRD7xto3VP+pXjsgq7Fl7eFUFnQHJOTJvCxni0TcIbdj2pA9lPtnE7ZZ144pvWaf
         QlJZtS7rRNo0qd+MROQOA+shHqd/vhqr/Hlfo71vKXoPolCA3BpGeLxtADhyYEKN3UzX
         JdlfwInA14y40I4KaKS+u9Y/N75PSJ0eiSr3FkNfyOyVuRiTWndr0cwXVrZL0Jmc9Wgr
         yK8A==
X-Gm-Message-State: ACgBeo3M3xGYUycRIMWXIusrZ0VL1L8IZ/qqH45dsitE2mNpAYAc87LO
        yFYT029JhsOSj4mT4D7OVtfqUOON50AtOjqcL5kz
X-Google-Smtp-Source: AA6agR67JqLJbTsUMywSUV4CDMmds8+ClBQaMdh6BNCEFu6UwDXwsTiWYtKBclPxGnDjuicTj+ve4s+6uWG/VcY13Q8=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr3678091oao.136.1660910816244; Fri, 19
 Aug 2022 05:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAEHB248ft0LFUQDHNtB9NN_D3F=12Jndh13Ue=LokajXNhMk5Q@mail.gmail.com>
 <CAHC9VhTXNPWBDRoPcz-Jw=f+NNAEhxbh-ySc56CUd-ZbuboW5w@mail.gmail.com>
In-Reply-To: <CAHC9VhTXNPWBDRoPcz-Jw=f+NNAEhxbh-ySc56CUd-ZbuboW5w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Aug 2022 08:06:45 -0400
Message-ID: <CAHC9VhQnYY_wdUjBbL3NpPYTQcr0M_Nf1g8ObbHiUoUbHPYdYA@mail.gmail.com>
Subject: Re: data-race in audit_log_start / audit_receive
To:     abhishek.shah@columbia.edu
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Gabriel Ryan <gabe@cs.columbia.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 9:59 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Aug 18, 2022 at 6:23 PM Abhishek Shah
> <abhishek.shah@columbia.edu> wrote:
> > Hi all,
> >
> > We found a data race involving the audit_cmd_mutex.owner variable. We think this bug is concerning because audit_ctl_owner_current is used at a location that controls the scheduling of tasks shown here. Please let us know what you think.
> >
> > Thanks!
> >
> > -----------------Report----------------------
> >
> > write to 0xffffffff881d0710 of 8 bytes by task 6541 on cpu 0:
> >  audit_ctl_lock kernel/audit.c:237 [inline]
>
> ...
>
> > read to 0xffffffff881d0710 of 8 bytes by task 6542 on cpu 1:
> >  audit_ctl_owner_current kernel/audit.c:258 [inline]
>
> Yes, technically there is a race condition if/when an auditd instance
> is registering itself the exact same time as another task is
> attempting to log an audit record via audit_log_start().

I realized after I sent this and turned off my computer last night
that I typed the wrong thing - the race isn't between auditd and
audit_log_start(), it's between the code which changes the audit
subsystem state (see audit_receive() and the audit watch/tree code)
and audit_log_start().

> The risk
> being that a *very* limited number of audit records could be
> mis-handled with respect to their queue priority and that is it; no
> records would be lost or misplaced.  Correcting this would likely
> involve a more complex locking scheme[1] or a rather severe
> performance penalty due to an additional lock in the audit_log_start()
> code path.  There may be some value in modifying
> audit_ctl_owner_current() to use READ_ONCE(), but it isn't clear to me
> that this would significantly improve things or have no impact on
> performance.

Another thing I thought of last night - I don't believe READ_ONCE()
adds a memory barrier, which would probably be needed; although my
original statement still stands, I'm not sure the performance hit
would justify the marginal impact on the audit queue.

> Have you noticed any serious problems on your system due to this?  If
> you have a reproducer which shows actual harm on the system could you
> please share that?
>
> [1] The obvious choice would be to move to a RCU based scheme, but
> even that doesn't totally solve the problem as there would still be a
> window where some tasks would have an "old" value.  It might actually
> end up extending the race window on large multi-core systems due to
> the time needed for all of the critical sections to complete.

-- 
paul-moore.com

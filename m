Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33E45992DA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 04:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245068AbiHSB7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 21:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiHSB7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 21:59:14 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC80DC5E5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 18:59:13 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-11cab7d7e0fso2619286fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 18:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8i/BbB4J7UUtTj6wSLyEKQkjCMyvGUUhOuI103/eQ5w=;
        b=61/an7qQdUYzdYH7mxmknmmDqxAxFZI1I10rEvVJ3eCj2u2oHrR655doSL9QRLZf2E
         na6v1nEWzpa4ts/qZsNEU/fF3Gtng5HhoF3EEWJE07pWUnkOIFnVXgsRxhMW3QZPfvAS
         p5Q36U5QlRfwVO0arZrKkpzUoQoOGpjK6q0BQCn47RILME9IDH1jafFXgI+el1NauJJi
         XwUx0sjdRWzC1Kz9B0ef3wtoJ8XxUwARqyC98DAdC+2KPFktvr2Ndlam+klgSESQTfJ1
         rvBhi1AJPeoVtdT2dnR3RCLZwmg0zgiRnjUSt/5OHCVlVicgvvNq9EipvZbQEgwKJMf0
         VDMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8i/BbB4J7UUtTj6wSLyEKQkjCMyvGUUhOuI103/eQ5w=;
        b=dBQKatQ11zP/cR2JIDvFOtiUhgCxwXd5VY6Oq+qLuv0fVJjO5jo1fNZ07cEAVmalha
         Ply0Q/q5xyvSnfYqqNDn7CaiMJ0+5lTL8mldJVWFxewcsxPzWKDCCnmhtBJ0J5yrVCzh
         CNaQMMmAjYmXebMk9M91tpCMSa4Giv3weHu7zrJ1A+Jfp/wvYtvYB34yI43WYieFmdps
         xlB6r1FwiZJ/3xW4LgWfz67h0hflkPs1pN6amURXOw5mrzx2ZvuGllffH2pWsUAc/bxq
         djMhiM1IsDOf21RhLPVCX7hBvEPBxpI+e81fZfRZfY+gPf9HPU7RVBQAiHE3ULLMhxcl
         Si9w==
X-Gm-Message-State: ACgBeo0ljxGHDVYmaO9Ybhp5tuA/6BixO4+3ja8ZEF9AAXs6OXUIJX+M
        a8AS6piaSVAH07o+zBhfte8BkMDbTT78a0VXMepl
X-Google-Smtp-Source: AA6agR6kEYeSYs2Z59mtKeOewc1h/y2cKu34mOm7T2T0but7zsV0d3frO+g7bdSbunlx3YYSY6UFw4IsyyFdaajI2EQ=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr2821970oao.136.1660874353259; Thu, 18
 Aug 2022 18:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAEHB248ft0LFUQDHNtB9NN_D3F=12Jndh13Ue=LokajXNhMk5Q@mail.gmail.com>
In-Reply-To: <CAEHB248ft0LFUQDHNtB9NN_D3F=12Jndh13Ue=LokajXNhMk5Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Aug 2022 21:59:02 -0400
Message-ID: <CAHC9VhTXNPWBDRoPcz-Jw=f+NNAEhxbh-ySc56CUd-ZbuboW5w@mail.gmail.com>
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

On Thu, Aug 18, 2022 at 6:23 PM Abhishek Shah
<abhishek.shah@columbia.edu> wrote:
> Hi all,
>
> We found a data race involving the audit_cmd_mutex.owner variable. We think this bug is concerning because audit_ctl_owner_current is used at a location that controls the scheduling of tasks shown here. Please let us know what you think.
>
> Thanks!
>
> -----------------Report----------------------
>
> write to 0xffffffff881d0710 of 8 bytes by task 6541 on cpu 0:
>  audit_ctl_lock kernel/audit.c:237 [inline]

...

> read to 0xffffffff881d0710 of 8 bytes by task 6542 on cpu 1:
>  audit_ctl_owner_current kernel/audit.c:258 [inline]

Yes, technically there is a race condition if/when an auditd instance
is registering itself the exact same time as another task is
attempting to log an audit record via audit_log_start().  The risk
being that a *very* limited number of audit records could be
mis-handled with respect to their queue priority and that is it; no
records would be lost or misplaced.  Correcting this would likely
involve a more complex locking scheme[1] or a rather severe
performance penalty due to an additional lock in the audit_log_start()
code path.  There may be some value in modifying
audit_ctl_owner_current() to use READ_ONCE(), but it isn't clear to me
that this would significantly improve things or have no impact on
performance.

Have you noticed any serious problems on your system due to this?  If
you have a reproducer which shows actual harm on the system could you
please share that?

[1] The obvious choice would be to move to a RCU based scheme, but
even that doesn't totally solve the problem as there would still be a
window where some tasks would have an "old" value.  It might actually
end up extending the race window on large multi-core systems due to
the time needed for all of the critical sections to complete.

-- 
paul-moore.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D4D54A2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 01:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbiFMXqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 19:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiFMXqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 19:46:31 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0892632EFF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 16:46:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r5so274607pgr.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 16:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LMZMQK49gc47drd6Jd36STmC+qlFEdOKEq0ulnkEkFs=;
        b=KpQN3HSapyv/qKjWcCGtXvRNrg5pQGiNxmt8TNqgb1TKcG5DJbt9XHcO+8jhBvRA8r
         sSdkkSHdkmtN/7q7JB00iwiatLreKrwfpIv/rCQy0oTRWjxDK7urmoWJMjMKJPa4we2V
         VG34MAF0/wvkUIH61Lad0EWacF1Mz+tqeZXvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LMZMQK49gc47drd6Jd36STmC+qlFEdOKEq0ulnkEkFs=;
        b=IrT9brqP+D75k1Gl0rOht2StYNPgdL4rWZbs9OPKACUp8iNfEBYe8qNVpttl3GT28a
         2DoMIA8Q6zVPizL4YfoXzBgqJJ92yH4MVNHK+0TQSZF74kOFGlIFKI4zZjfxbC0BhnSy
         gFaKnZuHA7EQI4JTzpoh/x2ppoo6o6WUQCb8v9Q7jFZINZ8FSs68Q290u7es/4SQhsLX
         a1c6/s8sIrnBlC8wNocGLUmGoqkYlRkpmlmQ7eQKt9eIf84Vza3BHynsoEULWt+KUQan
         hPuXmAWjg1/KZfJYnl12+co/nwFvUArILBjs/QHp+KvgK31e1M7PPZRaZsOuTGViNoE/
         UwBQ==
X-Gm-Message-State: AOAM5328TEwthO7zOs/lgPrgXpTIyAQcLn3PTG+CiLFMoRlMWGHL3L0g
        pMjjRq45QOp1/VvAaMqGMHc2Vw==
X-Google-Smtp-Source: ABdhPJypGRCNuj+Vs7kbnSmWhSH8m6+5HFMpQVmxKwRrzBtjzjj+MG9/XNhAPxifXiFhp6arOdMKoA==
X-Received: by 2002:a63:5248:0:b0:402:de14:ab74 with SMTP id s8-20020a635248000000b00402de14ab74mr1882926pgl.18.1655163990389;
        Mon, 13 Jun 2022 16:46:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cp15-20020a170902e78f00b00168c5230332sm5672252plb.148.2022.06.13.16.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 16:46:30 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:46:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Micah Morton <mortonm@chromium.org>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        serge@hallyn.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] LSM: SafeSetID: Add setgroups() security policy
 handling
Message-ID: <202206131643.4FB2340C43@keescook>
References: <20220613202852.447738-1-mortonm@chromium.org>
 <CAJ-EccOhrYG6n6As72R7YzSk+Zzy=oFFJ62hG9476njprpJuvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-EccOhrYG6n6As72R7YzSk+Zzy=oFFJ62hG9476njprpJuvw@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 02:00:03PM -0700, Micah Morton wrote:
> On Mon, Jun 13, 2022 at 1:28 PM Micah Morton <mortonm@chromium.org> wrote:
> [...]
> > +static int safesetid_task_fix_setgroups(struct cred *new, const struct cred *old)
> > +{
> > +       int i;
> > +
> > +       /* Do nothing if there are no setgid restrictions for our old RGID. */
> > +       if (setid_policy_lookup((kid_t){.gid = old->gid}, INVALID_ID, GID) == SIDPOL_DEFAULT)
> > +               return 0;
> > +
> > +       get_group_info(new->group_info);
> > +       for (i = 0; i < new->group_info->ngroups; i++) {
> > +               if (!id_permitted_for_cred(old, (kid_t){.gid = group_info->gid[i]}, GID)) {
> 
> Oops, should be:
> 
> !id_permitted_for_cred(old, (kid_t){.gid = new->group_info->gid[i]}, GID)
> 
> Guess I won't send a whole new patch just for that one line

This begs the question: are there self-tests for this LSM somewhere?
It'd be really nice to add them to tool/testing/selftests ...

-- 
Kees Cook

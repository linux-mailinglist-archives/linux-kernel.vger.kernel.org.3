Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77028495681
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 23:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378132AbiATW6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 17:58:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233856AbiATW6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 17:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642719495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cin+GlfdvRxk53J1FH02Ed+P01nt3EuMJqBgh1QlF80=;
        b=aRYNOeoTmveGYHBmLr3BwhkkddyWKuoIuyu9rK/LAid/E0IvPMeg9e2VOvzbTmxMb77/Un
        Enm1yuvX6o501TJOevjQs0c36xBzT9NYq4v6d5nUkZZjWO8rZGvjsOjvBROAL3nd0dsnOF
        tNJFRBAxhQ6aiii0Kq1bwegwXYJqEBY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-423-xVOmxtb0PD2xhD06p3wyBg-1; Thu, 20 Jan 2022 17:58:14 -0500
X-MC-Unique: xVOmxtb0PD2xhD06p3wyBg-1
Received: by mail-qv1-f71.google.com with SMTP id ib7-20020a0562141c8700b0040812bc4425so7750353qvb.16
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 14:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cin+GlfdvRxk53J1FH02Ed+P01nt3EuMJqBgh1QlF80=;
        b=N/p7lhhRSw7pp3DneKJ/ZSSqlseI6U9jMEU98T77VKCvnCYeA3kj8bHBrnjjuyH8NZ
         AHmpTJn8aGiaWYj0W/HaYC3XW0/ImryOvcxtgAIAVzlkUhB+TJp+R2RfZoiTn3kaq1Br
         WK5jl0mkeQVPDJDXwtTbf5Qg9vAKdRCwIyoUXETeovFgv8s4gYHoMYQ5fm7YVG1WJS7O
         udxwT/GR2OZk+BiGabz6kvdkRE32Rx1dumtsqqR/pJGLhkvT5bYA/e8uwPiorwsBILzO
         +UNo19setA/ZKUqR5MStq803gMNCL+6Ag4YrzSHlJKWi0fqRevV17dHGBzAbA8uAY43E
         9tmw==
X-Gm-Message-State: AOAM532a27V8o08Y/PkMabv30p4N4tym/6eZRhcNawnqAAOTAb/txLPG
        v1xEkdf6taLWsWFxYou6URXo3wPlt2XW+VI4Wa8w61T908Lf5ZaZeYo9/+5glodjQYBrOd0IIiR
        e8zHpUq81ECfDdH3y6nP5hS0/
X-Received: by 2002:a37:be05:: with SMTP id o5mr844132qkf.783.1642719493963;
        Thu, 20 Jan 2022 14:58:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzh9bOTssAUlEx/CAMr/qvKfrFlvfMIFh5XdVJkMf/nad6znKIee9/eUFMMHArZxm90m/NwKA==
X-Received: by 2002:a37:be05:: with SMTP id o5mr844122qkf.783.1642719493766;
        Thu, 20 Jan 2022 14:58:13 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id x12sm2229325qta.79.2022.01.20.14.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 14:58:13 -0800 (PST)
Date:   Thu, 20 Jan 2022 14:58:10 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: check: give big enough buffer for pv_ops
Message-ID: <20220120225810.zqpbug6oj52c34cg@treble>
References: <20220114075756.838243-1-slyich@gmail.com>
 <YeE588tXLrgWoUu4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YeE588tXLrgWoUu4@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 09:53:07AM +0100, Peter Zijlstra wrote:
> On Fri, Jan 14, 2022 at 07:57:56AM +0000, Sergei Trofimovich wrote:
> > On gcc-12 build fails flagging possible buffer overflow:
> > 
> >     check.c: In function 'validate_call':
> >     check.c:2865:58: error: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 9 [-Werror=format-truncation=]
> >      2865 |                 snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
> >           |                                                          ^~
> > 
> > I think it's a valid warning:
> > 
> >     static char pvname[16];
> >     int idx;
> >     ...
> >     idx = (rel->addend / sizeof(void *));
> >     snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);
> > 
> > we have only 7 chars for %d while it could take up to 9.
> 
> Right, very unlikely to have that many pv_ops, but it doesn't hurt to
> fix this.
> 
> Thanks!

Alternatively, 'idx' could just be unsigned char, since pv_ops only has
about ~80 entries max, but either way works for me.  I'll queue it up.

-- 
Josh


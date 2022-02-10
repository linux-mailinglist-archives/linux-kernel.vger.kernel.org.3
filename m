Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA14B10B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243123AbiBJOp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:45:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiBJOp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:45:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35238C4D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644504358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M8Xicx5cO6JYsvcdxnszvP7E4kb3rIjZyILIbpstvnc=;
        b=CYrJsiEOXqga3cBQBRFxT2N2Wqqsg5FoD+HC0hAxm0ekLIJjG7pcg/UyImjKXkGgKrrAHp
        Vi+vau1LVwil6L1CQmothOvp6OsPZrce1RkMUvvMAFvguQX75CXbA8tA4r+aamQcLntvtb
        FCpeB8pXWYRz92sWReBCz0h5XJLpa+w=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-rij9qp0uOAu9OosIsM93HQ-1; Thu, 10 Feb 2022 09:45:57 -0500
X-MC-Unique: rij9qp0uOAu9OosIsM93HQ-1
Received: by mail-lj1-f199.google.com with SMTP id m13-20020a2e97cd000000b0023e09d49ce4so2673282ljj.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 06:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8Xicx5cO6JYsvcdxnszvP7E4kb3rIjZyILIbpstvnc=;
        b=W8S3q5OkUs5ILa8dRNdfOS+kE+WOBx/1fdKN1rlZedBN6ntDSflKsT66LKdhu6Hjpo
         5zHzX5ikaxL8LAz7DMmlRgjjGBggIwLAFDdgSnp0r4JJdKPiIE+xEUNFnZmz2G9vTb9t
         ZWj5JkdPKQ8hjNurF2ss+YG2vcwPkvFbtnEFnbn5ROnDKr1byzNC4Gr/SHfN2V6diXNJ
         rxBL4Up01RfATw/C1ASCcE3YUvYAFIP1UNC/uufBrwG002KrMPvDDSko0HYUZrqH1iAH
         gQPMqU+yR8///IEB6S40DrHTTRf2kFizRkoOaTn4C1Uv+SjcUyKCjMJbhb9/Hg5ZvYNe
         IOqg==
X-Gm-Message-State: AOAM53253GBorLtOtX0BGX82T7xTaZfOYYck00cZQ1q9eRs3jN+B0qnS
        H6ez8QE8omIqVW6q1i/O1Xcptv97pfh/+qdu6UhRI+t3DIYQjUT6JqxN7LVzcLumhxwgYh9Tgkk
        RchVE3v0QfuYFBwt3Q116ARG15HhUWmfHE41Qn4Q=
X-Received: by 2002:a05:6512:3f84:: with SMTP id x4mr4204730lfa.484.1644504355578;
        Thu, 10 Feb 2022 06:45:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwC9RjysectHKxeUKPhvllfxiSlrCWq8mr3WeL2XaNx5vQvpP7mOwVzJtA4X3KJF4uBtDLcN6dn9phCAV4+rt4=
X-Received: by 2002:a05:6512:3f84:: with SMTP id x4mr4204722lfa.484.1644504355403;
 Thu, 10 Feb 2022 06:45:55 -0800 (PST)
MIME-Version: 1.0
References: <20220209170358.3266629-1-atomlin@redhat.com> <20220209170358.3266629-2-atomlin@redhat.com>
 <a22eb1b0-3fb5-a70e-cf6f-022571538efb@csgroup.eu>
In-Reply-To: <a22eb1b0-3fb5-a70e-cf6f-022571538efb@csgroup.eu>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Thu, 10 Feb 2022 14:45:44 +0000
Message-ID: <CANfR36jh3yg9nqXkpCUWPeHV+sSD6yne9j1=uA5vyUpYOC8t9g@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] module: Move all into module/
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "void@manifault.com" <void@manifault.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-10 11:11 +0000, Christophe Leroy wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3e461db9cd91..7e6232bd15f5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13001,7 +13001,7 @@ L:    linux-kernel@vger.kernel.org
> >   S:    Maintained
> >   T:    git git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next
> >   F:    include/linux/module.h
> > -F:    kernel/module.c
> > +F:    kernel/module/main.c
>
> Shouldn't it be the entire directory ?

Firstly, thank you for your feedback Christophe.

Indeed it should. Moving forward: kernel/module/*

> > @@ -44,6 +44,7 @@ static inline int module_decompress(struct load_info *info,
> >   {
> >       return -EOPNOTSUPP;
> >   }
> > +
>
> This new line should be in patch 3 instead.

Fair enough. Given that the purpose of this particular patch is a simple
migration, style violations e.g. "Please use a blank line after
function/struct/union/enum declarations", can be resolved at a later stage.


Kind regards,

-- 
Aaron Tomlin


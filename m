Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63816561465
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiF3IQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiF3IPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:15:48 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FDF45795
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:12:14 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-101dc639636so24796776fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/EesN9M3QgaFKIPOr2CexXJ8wdX+PXxZvZvWhGBUik=;
        b=XB9F0ngX+EKqeYiPFXqTguzN/o+1HfI/vuZwg1NCa5wGDpFzBzmanZtNDM9XUfNVFS
         LR37llHYg+M9WqaaChQ5frIhVCfoL+6UhagiThWFuwiauYwaVwBrqJfQv9lEqVrSro3K
         covLCxi7GRs8+RXrXwohqRNDnly12o4Qqj3fuMKWZfE/QKk1XkDtrkopj/UJdD+m6hve
         8LQGfWVk5U5xrVFs7cDd6OV9ekWPefegBhQCiBjzmbsumnTLNsgQ8kggQYf76Dt0AUVA
         TiSeFBM8FAXwLYeUpzylR4vPWaALma6kYdT5dELFSO+sn/b0AeW5z3EghB4pSSLefn1e
         dUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/EesN9M3QgaFKIPOr2CexXJ8wdX+PXxZvZvWhGBUik=;
        b=C66ZqzBgF6dg6Z1+ehOrDryQmLmzmeZ6q3xxW/5xY8qPw8jbS38pDV61dSVtdMrVFX
         4v1G8H83f++Rh/0rD5NPu+HYpAkQFhZjSmB4kuhLvbE2QBcGdow4Gm/v1frM8nqvtLE8
         tZx5pDhbTYFwXKHxgMBtE9pOMdszBLtKC5jr97J1ISWKjzwy8MJL41bChTsZ9xbRs6NY
         HRgzWzys5WcjGldyRw3woMD9PqZSlKNgHQS621bZ8Jsj10ksWtokL8iKKaIJCvr+MPBQ
         TjRQt5PfNTWzrIv8DAONncuXz5FdUtBDGQW8cyMuhiDp/qCNT+49OSi1bYBpktQT9f1H
         xarQ==
X-Gm-Message-State: AJIora8mqcxwDp4JSk5COJ6GDjM+KtczxA4kWfsOIq7SfSki9kUqbaq+
        suoviltDz509mUwiVeolgRyRPj4g310dGGcHHYJS/n8RbXrNKw==
X-Google-Smtp-Source: AGRyM1vqyPrUb6S8d/3m/KvDVeDlmvwoFDdc2AfevYr30NHUjU9Ak+a7Cdd0mG5FL7lOp2hfIbrcu0kw/KVF38aJOSU=
X-Received: by 2002:a05:6870:f618:b0:f3:cb8:91b with SMTP id
 ek24-20020a056870f61800b000f30cb8091bmr5127939oab.265.1656576733938; Thu, 30
 Jun 2022 01:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220630040047.3241781-1-zys.zljxml@gmail.com> <Yr1QhjNGVJ7oPpRX@kroah.com>
In-Reply-To: <Yr1QhjNGVJ7oPpRX@kroah.com>
From:   Katrin Jo <zys.zljxml@gmail.com>
Date:   Thu, 30 Jun 2022 16:12:03 +0800
Message-ID: <CAOaDN_Tb9DJhOPXc=r9anoY3pdK3TcjX7Mwg2WQR_GUH66raqQ@mail.gmail.com>
Subject: Re: [PATCH] kernfs: fix potential NULL dereference in __kernfs_remove
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, viro@zeniv.linux.org.uk,
        LKML <linux-kernel@vger.kernel.org>,
        katrinzhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 3:28 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 30, 2022 at 12:00:47PM +0800, zys.zljxml@gmail.com wrote:
> > From: katrinzhou <katrinzhou@tencent.com>
> >
> > When lockdep is enabled, lockdep_assert_held_write would
> > cause potential NULL pointer dereference.
> >
> > Fix the folloeing smatch warnings:
> >
> > fs/kernfs/dir.c:1353 __kernfs_remove() warn: variable dereferenced before check 'kn' (see line 1346)
> >
> > Signed-off-by: katrinzhou <katrinzhou@tencent.com>
>
> Can you please submit this with your legal name that you use to sign
> documents?
>
> Also, what commit id does this fix?  Did you actually hit this with a
> real workload?  How can this be reproduced and tested?
>
> thanks,
>
> greg k-h

Sorry for the formatting issue. I'll submit a new patch soon.
This problem is found via static code analysis, and by now
I have not reproduced / tested it.

Best regards,
Katrin

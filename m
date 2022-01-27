Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A76D49E98C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbiA0R7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244692AbiA0R6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:58:40 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087D6C061751
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:58:40 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j23so4732778edp.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/WdrZt8APh+ImWs99heS/EAAslbj9KjZjoo2pBS7+c=;
        b=nFqidDLirWb5QmaEXBGreq9mA37G4EJ+Q2mpt9YciaCWN6z4xxhNtfYmkrxNHnaKLw
         OfEPBT0Xe0aXMGF9gnFX5fjFu/J4kr/Lf/pS+GlUlyM3xqTmw7ZYGmZT317MbXPPRQY+
         qPKCe9aXzTB3+Vqr98iv5i84h3v7XET37JW7wJtXNBgn47IcCqZpy9I6mrkDnLcWEuS2
         YT243GZrkCIBNdDUPyBjinEjmofSalSBeg6IIOZT43hnaxwNWKfUXfTgopMgEpG/DUiQ
         LnKVOY8QCobVPQN3ZJB5ATSLAYaMWJje/ltYhTTDai/TNx6UimZ1mw7fYow0lC8poKzv
         OTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/WdrZt8APh+ImWs99heS/EAAslbj9KjZjoo2pBS7+c=;
        b=2/kF5hfX23qlMDwDHjA2xPi15hCOIYUYat5XHHPtGCE4hMas1ibCWUttB38c0YLLKp
         jUQXWonVYKUZYe7AET3tP1La3GlEyc6XkSy6vqLWzkFqEth7mdq8wemsG79rT+m73ov+
         xDDyuA1CCMLSFEqeuPwhnKU6YypnyP9r29/nek8one9pbDXqgR/L8bWr5LlbjVqYR2md
         PQpih0Da2uAsJEL9aPe+qGZOVzWXr8mpNGO93eHwDTE8oKmHH54XiE4CMPHCUn5CD7bS
         iEjLCvXNAxci2PkKBXd4NAeBMem3eIDwFSYa/RtuDi+YquQCT9r2/CZP0TDBvy6LBflD
         24rw==
X-Gm-Message-State: AOAM532u0PqxDb9PsYVYyWVAtPu7zu6ujEpPlDiB7zq21yj8WEnWMzZ+
        3QcYNqiZOrPVm5m8hSbCn2R2sOZsPj/iHMlEPM9il0AfHuE=
X-Google-Smtp-Source: ABdhPJxQ1qzfs/DIElroXwnoIK8WHBiVv9xpOvqnXnZkbObAnsCfkpP9Ea4KnHjLw+73Nz8PNhZRrABfYFFZ4R9A2Q4=
X-Received: by 2002:aa7:c312:: with SMTP id l18mr4729705edq.334.1643306318361;
 Thu, 27 Jan 2022 09:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <CABVgOSnY8Ctc9vuVX+Fjmmd3L5kpXnzMXJQ0LPXAgmjCKsrYYw@mail.gmail.com>
 <CAGS_qxqx+wcruc7DAD9TQjk27OF+VDo1n9S6atRx+dDG5cr=6g@mail.gmail.com>
 <CAGS_qxpRqOAoBbkkFttZgB_Zm+KM=pwprgZ0wzDROh21mO0r8Q@mail.gmail.com> <CABVgOSnmfhPcMCy5yQEymyBnTWSqEFbmTnSbHYL7D1D=eJOk5A@mail.gmail.com>
In-Reply-To: <CABVgOSnmfhPcMCy5yQEymyBnTWSqEFbmTnSbHYL7D1D=eJOk5A@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 27 Jan 2022 09:58:27 -0800
Message-ID: <CAGS_qxrCRxEGUj_O+oZFkrDgE6PgvHNhfxMzF94Rez__CXbR4Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] kunit: tool: drop mostly unused KunitResult.result field
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 6:20 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Jan 27, 2022 at 3:55 AM 'Daniel Latypov' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > On Thu, Jan 20, 2022 at 9:19 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > > That being said, I can live with the current solution, but'd ideally
> > > > like a comment or something to make the return value Tuple a bit more
> > > > obvious.
> > >
> > > A comment to explain that Tuple == multiple return values from a func?
> > > Or something else?
> >
> > Friendly ping.
> > Do we want a comment like this?
> >
> > # Note: Python uses tuples internally for multiple return values
> > def foo() -> Tuple[int, int]
> >    return 0, 1
> >
>
> Whoops -- forgot to send my response to this.
>
> I was less worried about explaining the concept of multiple return
> values, and more about naming what the return values were: that the
> first one is the result information, and the second is the parsed
> test.
>
> That being said, it's reasonably obvious from the types in this case,
> so I'm okay leaving this as-is, though in general I'm wary of tuples
> when the order doesn't matter, and a struct-style thing (with named
> members) fits that better.

Ack.
Yeah, in this case I don't think creating a new type to name each
value is worth it.
From what I've seen of python codebases, this info is usually captured
in docstrings, but yeah, this particular case seems straightforward
enough that it doesn't need it.

>
> I'm no Python expert though, so don't let my whinging get too much in the way.
>
> -- David

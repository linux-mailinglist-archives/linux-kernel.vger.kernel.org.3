Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368FD491F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 07:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbiARGvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 01:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiARGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 01:51:20 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77892C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 22:51:20 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id n16-20020a17090a091000b001b46196d572so1905120pjn.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 22:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=werjgtfLJkCP6XvKlLZntqYlamvXmge4L1VauqJtNeY=;
        b=HagPAQv1Ulr0Q1aSVtQ+foapRIoRkSmyUk8RzGOS12R7ORrBCZqyr2Eju+pun2M/Hy
         pROOjIXbfjcJSJgJfoCevcoM237fiSrl0rDX+wNPtoECDCA/19JL7xF5di4a2pPy4Hp+
         DcheRu/b7G7ED2VnFJBP6yENS35azMfzs30oFltv7G6Kfs/9pycaQGwoQ6bSRfybsKPB
         0PDRoF8mFXZzlgo9B6MsEqYOw+IWmFr7mnL3dOw40b9HYbobDhfVxjo9z+vUaAn4hjJQ
         lcxcdgvcF042RhSjhFtW/Z0Y0h4qOZyZ+KuPMQ5ne1+Ivra0D+e/x7MG1EhdwrMcFCkl
         7dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=werjgtfLJkCP6XvKlLZntqYlamvXmge4L1VauqJtNeY=;
        b=8FYnPP7h3QNhJ+Hy46VUu4JSRY0yczvOhuNG5lBzbtjFzChX9YztWkHn6zxFe/DG0V
         0+Rueg1lSuIIZ6YUfDzUhsuUGXEJMebGYm4bhyHl7ddZucpmonhCAzqqAcrVHuiEezXD
         3SmQShz0ZkgOfJ/XTnD7Vdl2FMWtSFhDXRkxP36r7J+7ET+q0Om97wIMwdTYepQTIuer
         nLuP7hMlc7IdC5a9rPX55YBpkV3ecuMEdSIscZj4dNZ0Pl/UaBa6DlO46JqTtKo1U44p
         +gWol/zKW++OH7OytfmOfb7iIo4pibR7dBCmxc6d0Nm5W0qr+ubJNovwgIkdrBpqFVaw
         JyPw==
X-Gm-Message-State: AOAM533mGPtNnNmEubgnh66/5WIDcIoLRClOS07gryJKIo2RItWqebh+
        PRY7bzlVimicLD5lDxjOFkGl9KRDFsYaM2P3+biqtw==
X-Google-Smtp-Source: ABdhPJzIXVX7xNxzFzJpP0oBNgMI7a26OOC9KLGvwG4LcrItLCbHlO5/9AdqOQ2EnURmF7liRfqyT87olQGAXtDgErI=
X-Received: by 2002:a17:90b:1095:: with SMTP id gj21mr33900113pjb.121.1642488679407;
 Mon, 17 Jan 2022 22:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20211229112551.3483931-1-pumahsu@google.com> <Yd1tUKhyZf26OVNQ@kroah.com>
 <CAGCq0LZb8nQDvcz=LswWi4qKd-65ys6iPjTKh=46dVtYLDEUVw@mail.gmail.com>
 <Yd/g/ywBWZG7gF8v@kroah.com> <CAGCq0LZ3i8VaMfRWNKvH_-ms0TgNqKA6f+Zx7M=iz1t_-smW+g@mail.gmail.com>
 <fe411488-c67c-62ab-4709-98621b9f199b@linux.intel.com>
In-Reply-To: <fe411488-c67c-62ab-4709-98621b9f199b@linux.intel.com>
From:   Puma Hsu <pumahsu@google.com>
Date:   Tue, 18 Jan 2022 14:50:43 +0800
Message-ID: <CAGCq0LYwrkCe4X77x__CC6qUPaSvRXoO3grKODfP+eSGZfNm7w@mail.gmail.com>
Subject: Re: [PATCH v3] xhci: re-initialize the HC during resume if HCE was set
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, mathias.nyman@intel.com,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Albert Wang <albertccwang@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 8:20 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
>
> >>> This seems like a big hammer for when the host controller throws an
> >>>> error.  Why is this the only place that it should be checked for?  W=
hat
> >>>> caused the error that can now allow it to be fixed?
> >>>
> >>> I believe this is not the only place that the host controller may set
> >>> HCE, the host controller may set HCE anytime it sees an error in my
> >>> opinion, not only in suspend or resume.
> >>
> >> Then where else should it be checked?  Where else will your silicon se=
t
> >> this bit as part of the normal operating process?
> >
> > We observed this flag while resume in our silicon so far. According to =
the XHCI
> > specification 4.24.1, =E2=80=9CSoftware should implement an algorithm f=
or checking the
> > HCE flag if the xHC is not responding.=E2=80=9D, so maybe it would be b=
etter
> > to implement
> > a new API to recover host controller whenever the driver side finds no =
response
> > from host controller in the future.
> >
>
> As all the code to reset the host during resume already exists, and is we=
ll tried
> due to issues in resume being so common, I think it makes sense to add th=
e HCE case
> here as well. It's a simple fix that makes the life of users better.
>
> That said we shouldn't hide the reason for reset like this.
> Print a debug message telling about the HCE so that everybody working wit=
h xHCI
> can see it and start fixing the rootcause.

I will print a debug message in next patch version.

> Another HCE check could be added to command timeout code, but just to sho=
w a
> warning for now.
> Reset might not always clear HCE, and we don't want to be stuck in a rese=
t loop.
> This check  could be a separate patch

Maybe I can try to make this in the future. Thank you for advising.

> -Mathias

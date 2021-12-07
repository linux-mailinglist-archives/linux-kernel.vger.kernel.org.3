Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7286646C0F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239314AbhLGQyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239026AbhLGQyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:54:01 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59465C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 08:50:31 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y12so59187707eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eGczmUI3Q7tBDz6wgntLrYvORH2u57suFJN4sS9XHMg=;
        b=h+jSJvv4U2hz8lZ0qTT6h57or5ysrK7CX1MaYaEsHflXopDYDWkZp+ujegIa3ni/ul
         7vFWaUW1szDy3VDTKfAN1++t0mGJrJF10mMtB8Sis4OL+lBmHs9LqO3G/Gr0QasqJlot
         at+57ZwaGqiWrpuobuI0MohnVsK6cdwkjQS7VMFZ7iH7I9hLLUiXqlfVvkhh8DhLttPT
         luoppA3rGH/P+03Soa2jNXJ5ouZh3wXWy4pRZIwe7tifw6ileYrZyQ49o+fg8GARlLwL
         tKlikJZjkXlBm26/Knnap6TUwlEInX51M6iDyXhNsoUMILoorvFefWN3JCH81oBuZLMV
         uIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eGczmUI3Q7tBDz6wgntLrYvORH2u57suFJN4sS9XHMg=;
        b=W9LmuefEhm4dvZs4MJwetdKir2lhVJWLX4j4DGB4rufTnqGvpZ8gbKPlIBhS9Oog7B
         adW9Wj9sf9EzEoDhE/DMJrdT9B016J1rmFObFGs41OqGQY8azwwCDUJt+3TcZASrsKk0
         RlpxPE3uNIgrLa2ys2lmQxWgLFoQBNhzvHNHuLNLbrFmT8isIt2wsyWac8I+g8jPWzwd
         g/gyMi2XGFo8En0l5BlQwJWQHTWc68/LHAF5FWme+xBJjc3aZv1IgsLUIJppp7phYYIe
         tC9zJKSAOKY/ZeaBIitW7n/MZd6fPudNrLIpDQ9izL9q0uGJHzCSoPY+KRHQShGBI2Iq
         3qDg==
X-Gm-Message-State: AOAM531ZuoT6t0OXsvU7Gmh52nSCAcL2Nhm7tcRMBX/CtyFC6KTyTZ9e
        x+t2S/zD2n28urNmBLLbxYJ1snImA4RQ/xTmh7A=
X-Google-Smtp-Source: ABdhPJwbGG+m1iJpnkK/yaEn5v01ZZS6w6rDZoUqckpzvyOrPJ0jn6fOZ/xNJwPWLiCPx3ok51fvY92/wFCVliHB1NI=
X-Received: by 2002:a17:906:9b84:: with SMTP id dd4mr643814ejc.280.1638895829853;
 Tue, 07 Dec 2021 08:50:29 -0800 (PST)
MIME-Version: 1.0
References: <1638619795-71451-1-git-send-email-wang.yong12@zte.com.cn>
 <Yax01zjuzmNyyJK/@balbir-desktop> <CAOH5QeDhjyjAkS1bUju2cv67KFukUr0ov8uG+z3bM6Oa=iFrMA@mail.gmail.com>
 <Ya7uQingLC3fMJlt@balbir-desktop>
In-Reply-To: <Ya7uQingLC3fMJlt@balbir-desktop>
From:   yong w <yongw.pur@gmail.com>
Date:   Wed, 8 Dec 2021 00:50:18 +0800
Message-ID: <CAOH5QeC+0xDrgO+t3zwN4o48F9Q2CiTnzQDO78kuJLfyNJwoLA@mail.gmail.com>
Subject: Re: [PATCH v2 linux-next] delayacct: track delays from memory compact
To:     Balbir Singh <bsingharora@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, mingo@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <bsingharora@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=887=E6=
=97=A5=E5=91=A8=E4=BA=8C 13:16=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Dec 05, 2021 at 07:08:02PM +0800, yong w wrote:
> > Balbir Singh <bsingharora@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=885=
=E6=97=A5=E5=91=A8=E6=97=A5 16:17=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Sat, Dec 04, 2021 at 04:09:55AM -0800, yongw.pur@gmail.com wrote:
> > > > From: wangyong <wang.yong12@zte.com.cn>
> > > >
> > > > Delay accounting does not track the delay of memory compact.
> > > > When there is not enough free memory, tasks can spend
> > > > a amount of their time waiting for compact.
> > > >
> > > > To get the impact of tasks in direct memory compact, measure
> > > > the delay when allocating memory through memory compact.
> > > >
> > >
> > > Should we call this DIRECT_COMPACT and through documentation
> > > or name change imply that this won't work for kcompactd the
> > > kernel thread - based on my reading of the patches.
> > >
> > Using DIRECT_COMPACT is a little redundant=EF=BC=8Cbecause the
> > delayacct stats of delay accounting is specific to tasks, it has
> > nothing to do with kcompactd, which is similar to the RECLAIM field.
> >
>
> What would we expect when we call delayacct -p <pidof kcompactd>
> to be output?
If the slow path of memory allocation is invoked in the kcompacd process,
there may be delays being recorded.

> Don't feel to strongly, but it can be confusing that kcompactd
> has spent no time in compact'ing? Not that delayacct is used for
> kernel threads, but I am not sure if that use case exists today.
Yes, delayacct does not restrict the process of obtaining information=EF=BC=
=8C
but kcompactd is used for  compaction,  the compact delay of
kcompatd is not actually a delay.Maybe it can be added to the
document later to make it clearer.

Thanks for your reply!

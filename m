Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109DD489E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbiAJRba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiAJRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:31:29 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8D8C06173F;
        Mon, 10 Jan 2022 09:31:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s30so19130166lfo.7;
        Mon, 10 Jan 2022 09:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKh5zwaAA+AG9dnb55eEx8o7D6z8efkusi75Zx+oYp0=;
        b=ThccGbuYfjwem0O0WxSmK60//chmL2OuRuc+MnHBk8Si0lNpjn413nND/QqLwy6tGj
         ZAnoxyWcYfQ00esqoNmTvUF/goHHqmUaJIApc2KIm0gPInxySajvfNga/Y42qhnebnck
         f19OAUefAX1o2A+/qpU2D5KJTKY81AfEzPcoGR5zcjz+vr1XyayE+bMSgQKFthxoW1Jk
         Mw+osxMGgn3XD0JIKwmc1mZY8/BZWhrw351ULhOxnVM+DbgtKNpPmBy7cs7dNF5HgmuB
         ub/KPw8w+Z/ECo6fG41k/h/zSqp1MlIdQPbCyLowB9h1MxPAfv7j2H9PAyFoGB8AGUgL
         lDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKh5zwaAA+AG9dnb55eEx8o7D6z8efkusi75Zx+oYp0=;
        b=Cepst1pYJCBKzykOfB4Rj95ZFkhxit12oMDOejCosxRU5mv9i6aUWYDimJ05X4/zNM
         hbnz5f9nYe70GDMEVFd1MORC50QkQSPJosQqs0XUVCFEoML1SqDEKp9QAYObcs4uHecn
         +GgzzG/JG0wnqdDL1IWwzU2SmRhyITkxvNIjRJQ2oUt8Yp/NGj08mBnUR9tvzOI6H9o5
         dPtZv1xAl32J8/Aopbj/R9evZgpBnkG9GUBQFdhGKQCk4A5zeTS+HMEx8WcYmaYtfYmi
         zjA2BWmbF+nDoM8iPHg8VtzzAZdq2hgIX4wfDaHeR8SKZ/6m4SRld6PDqjasDclTyCZC
         XXGw==
X-Gm-Message-State: AOAM532QlqjrPOX9kC6+nfcjBRUVD5LBlW4jpPyHbg4ACjnuLJfE01gC
        cEYXiYAdptn68MUzsF0iOw6hZ5PPCNjpf41YrsBdOXoj5+g=
X-Google-Smtp-Source: ABdhPJxk0hkKshOHeXD8fJ72nlhrb5zi1Genlk9h+tLdKCvHIcJYbh6pYV8HwscVCx/6L97WWXUi+TppHbohLD9T7mI=
X-Received: by 2002:a05:651c:1505:: with SMTP id e5mr346187ljf.398.1641835887022;
 Mon, 10 Jan 2022 09:31:27 -0800 (PST)
MIME-Version: 1.0
References: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
In-Reply-To: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 10 Jan 2022 11:31:16 -0600
Message-ID: <CAH2r5mt_2f==5reyc0HmMLvYJVmP4Enykwauo+LQoFGFbVFeRQ@mail.gmail.com>
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     Davyd McColl <davydm@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I want to make sure that we don't have an unrelated regression
involved here since NTLMv2 replaced NTLMv1 over 20 years ago (googling
this e.g. I see "NTLMv2, introduced in Windows NT 4.0 SP4 and natively
supported in Windows 2000")  and should be the default for Windows
NT4, Windows 2000 etc. as well as any version of Samba from the last
15 years+.  I have significant concerns with adding mechanisms that
were asked to be disabled ~19 years ago e.g. see
https://support.microsoft.com/en-us/topic/security-guidance-for-ntlmv1-and-lm-network-authentication-da2168b6-4a31-0088-fb03-f081acde6e73
due to security concerns.

Can we double check that there are not other issues involved in your example?

The concerns about NTLMv1 security concerns (and why it should never
be used) are very persuasive e.g. many articles like
https://miriamxyra.com/2017/11/08/stop-using-lan-manager-and-ntlmv1/

On Mon, Jan 10, 2022 at 7:48 AM Davyd McColl <davydm@gmail.com> wrote:
>
> Good day
>
> I'm following advice from the thread at
> https://bugzilla.kernel.org/show_bug.cgi?id=215375 as to how to report
> this, so please bear with me and redirect me as necessary.
>
> Since commit 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c, I'm unable to
> mount a CIFS 1.0 share ( from a media player: mede8er med600x3d, which
> runs some older linux). Apparently I'm not the only one, according to
> that thread, though the other affected party there is windows-based.
>
> I first logged this in the Gentoo bugtracker
> (https://bugs.gentoo.org/821895) and a reversion patch is available
> there for the time being.
>
> I understand that some of the encryption methods upon which the
> original feature relied are to be removed and, as such, the ability to
> mount these older shares was removed. This is sure to affect anyone
> running older Windows virtual machines (or older, internally-visible
> windows hosts) in addition to anyone attempting to connect to shares
> from esoteric devices like mine.
>
> Whilst I understand the desire to clean up code and remove dead
> branches, I'd really appreciate it if this particular feature remains
> available either by kernel configuration (which suits me fine, but is
> likely to be a hassle for anyone running a binary distribution) or via
> boot parameters. In the mean-time, I'm updating my own sync software
> to support this older device because if I can't sync media to the
> player, the device is not very useful to me.
>
> Thanks
> -d



-- 
Thanks,

Steve

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FD94B3476
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 12:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiBLLYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 06:24:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiBLLYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 06:24:10 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E554B26130
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 03:24:06 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 4so12359912oil.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 03:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gxid+VMOks+Z278B3ciU0dNskRK6ktKfaLZmB1Olmd4=;
        b=Qb939wlv4CKlAJ6xVeF8t1o3QQMoZ897DgNU2HRBmPOLq3lYk4thq8Mo0xjNEWQ5Rl
         xYE0rfcoBeo4i1vKD6mlDF9NhgT9O2ZladUn8mf7uRzEGWKCecJ5Hm6YgEZCl+MtMOXx
         5AlWl0A/TKfY6dlLWgFGqNbbc3q5gZm26MNm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gxid+VMOks+Z278B3ciU0dNskRK6ktKfaLZmB1Olmd4=;
        b=cvCOFTgACFajy81sKcOow/2ouo2F/3EqlDwTMB08TV9sy3Nn37Vz6YHiZetdhgBTMD
         0sAL+7ugsPlyIxIm4NIxQ0Khcg0jn2ypJ8eZ8Nr6rSjvg6YvBhQWxloqqdP0fHsWae5y
         fXvAjpuVjXDzaQuq6u7qXNHkSgoOtmdcraeEgRYsLWXZAGgOX+ml9gQwmspwAeBL0sMX
         xKOAtlc7rzsWv5wZ0k6tiCw/VmNyYXJqBbi2Xai7Msp9tNFwr/jmOpNmMHR83I7jE0Jn
         AxTayrmevsl05dIsH7BaBpv0/+rlcKVXrefjotNoe3/ZXCbO2g7q2mEN2rM0wIbTJAje
         yFVw==
X-Gm-Message-State: AOAM530G/F0R0k/OlCDs9ITHlDEklxWXdbdaC1hq3c1EtWAaMviDzgD3
        HirVVLSYH5RV4NJc2WOMRIB7FYOsoxSJJ8VZZ3Dx/g==
X-Google-Smtp-Source: ABdhPJzGrnzJadnmXKM7XSlQ5XNFMUGbUZMnE1w9kzaG+mj8orByLRg8I4TFVFeTU5GnD9nwXyi5zQ8pinUTzLRQXmk=
X-Received: by 2002:a05:6808:19a5:: with SMTP id bj37mr2189889oib.243.1644665046278;
 Sat, 12 Feb 2022 03:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20220212042843.2993537-1-keescook@chromium.org>
In-Reply-To: <20220212042843.2993537-1-keescook@chromium.org>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Sat, 12 Feb 2022 12:23:55 +0100
Message-ID: <CAP145phC6S6Zda-ZWLH1s4ZfDPh79rtf_7vzs-yvt1vykUCP4A@mail.gmail.com>
Subject: Re: [RFC] Get siginfo from unreaped task
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 12 lut 2022 o 05:28 Kees Cook <keescook@chromium.org> napisa=C5=82(a)=
:
>
> Make siginfo available through PTRACE_GETSIGINFO after process death,
> without needing to have already used PTRACE_ATTACH. Uses 48 more bytes
> in task_struct, though I bet there might be somewhere else we could
> stash a copy of it?

An alternative way of accessing this info could be abusing the
waitid() interface, with some additional, custom to Linux, flag

waitid(P_ALL, 0, &si, __WCHILDSIGINFO);

which would change what is put into si.

But maybe ptrace() is better, because it's mostly incompatible with
other OSes anyway on the behavior/flag level, while waitd() seems to
be POSIX/BSD standard, even if Linux specifies some additional flags.

--=20
Robert =C5=9Awi=C4=99cki

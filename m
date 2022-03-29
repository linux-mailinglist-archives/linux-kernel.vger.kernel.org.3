Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FBF4EAE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiC2NNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiC2NNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:13:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D8E220D7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:11:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h1so20666164edj.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcDOqO8nUmp5U1arBgXD7fySeQ1KaFukzqTCAXe202I=;
        b=rD56zmPy9HkRm2KZQu60QRV2njPC7BVwxrSovvJFh9+wXZKo5tjwqGD0l7HxcwCf6E
         8t296tsMNXQt0Qo7EJM5Ug4GQ5mXh/58RYT6+4zeFzx5wwT9yrcBJ27rTtG4Fa7+zOHA
         aA3R7o3fHfpNvoPUj59wITjB4H+1ISjWCJnxMPeZCzdHjkZez3uRFOEN2W82DJP0UZTr
         bVUCb3r2IE0squDRYcJQ6r/gtKJZE773YW8F8U7105y5DuA9Yp3dsQwfmJMeHPAYU9vB
         aGNHSk/e8yoyZs8SIdrfk0hflFgNs1xDtCh+AK1IIMBrjTyYo6fqDHPwu+ygFl28h+SR
         piGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcDOqO8nUmp5U1arBgXD7fySeQ1KaFukzqTCAXe202I=;
        b=olRYY1wucJiNkco80kzgpoxP3qbB5xlImG4moWof9HJDRlewl6z5z7heF8zU5F2Yyn
         cpRcqf7lPR1Ov1OOQ2xyrqDKb5CwabNzaVeylthUeLKI+38pqvgH1EzpMRfAzXM3yt9t
         5HCKzfxM6DSfFTgs0wMIRIcZRN1aoM63/xwOh+k2mmAPPFR4mek84PQhzoSi9JL64CJj
         hpl8w7or1v6QHtsK0LCQ3/yIs1OWjIG3VYm9UoKn/qAfZevrYqP69NtiECGeTT2eXpNN
         P9kJ5YGWX9pG2+bexk5PQmqLgqSmYJctOf8N5cOdPrpkHb5b0AHXz5D4kwHtNK3Kka6o
         9o1g==
X-Gm-Message-State: AOAM530en4IPOEoMj337nhlj3FbgB3YTKtDCIZPaGqLc/iQ83XFwT86C
        bypB7rCls8QXW48HVRWVTZNps2g/7U6MwjXAxNJt
X-Google-Smtp-Source: ABdhPJxOcgcuUaenZFVnUVnrozrkTaNzmYnUT+MVYx2oXKPj7ymKKHcVopZoi4LcHJ66bLdJv9lD0HSfqLs3svqFJnI=
X-Received: by 2002:a05:6402:350d:b0:419:547f:134a with SMTP id
 b13-20020a056402350d00b00419547f134amr4528698edd.405.1648559489927; Tue, 29
 Mar 2022 06:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <202203270449.WBYQF9X3-lkp@intel.com> <62426553.1c69fb81.bb808.345c@mx.google.com>
 <CAHC9VhRNuoPH6AySUbe6h2D6kghhezyVQtTAvm-t-fTpXH6XwQ@mail.gmail.com> <62427b5c.1c69fb81.fc2a7.d1af@mx.google.com>
In-Reply-To: <62427b5c.1c69fb81.fc2a7.d1af@mx.google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 29 Mar 2022 09:11:19 -0400
Message-ID: <CAHC9VhTLTQmHaka9tTyuu=rQOzpsn_K2NxfJ==7-6FSY3KnuFg@mail.gmail.com>
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
To:     CGEL <cgel.zte@gmail.com>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        eparis@redhat.com, linux-audit@redhat.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:22 PM CGEL <cgel.zte@gmail.com> wrote:
> On Mon, Mar 28, 2022 at 11:06:12PM -0400, Paul Moore wrote:
> > On Mon, Mar 28, 2022 at 9:48 PM CGEL <cgel.zte@gmail.com> wrote:
> > > Sorry could anybody give a hand to solve this? It works well on x86_64 and arm64.
> > > I have no alpha environment and not familiar to this arch, much thanks!
> >
> > Regardless of if this is fixed, I'm not convinced this is something we
> > want to merge.  After all, a process executed a syscall and we should
> > process it like any other; just because it happens to be an
> > unrecognized syscall on a particular kernel build doesn't mean it
> > isn't security relevant (probing for specific syscall numbers may be a
> > useful attack fingerprint).
>
> Thanks for your reply.
>
> But syscall number less than 0 is even invalid for auditctl. So we
> will never hit this kind of audit rule. And invalid syscall number
> will always cause failure early in syscall handle.
>
> sh-4.2# auditctl -a always,exit -F arch=b64 -S -1
> Syscall name unknown: -1

You can add an audit filter without explicitly specifying a syscall:

% auditctl -a exit,always -F auid=1000
% auditctl -l
-a always,exit -S all -F auid=1000

-- 
paul-moore.com

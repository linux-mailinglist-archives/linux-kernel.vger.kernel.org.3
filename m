Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F85478047
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbhLPXFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237031AbhLPXFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:05:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408D9C061401
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:05:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y22so1181701edq.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GJ64TcgksQc3C6D3xtvHzgt3iSOg6McffYMs3O8prrE=;
        b=Z63xJiB3Ei8LRcpyHm+qEbadN02vR/u6ZMgg4wLoJE0RBSk+pzm39iXdJq7Pkoaym3
         MMbyLdHN9fgCKEgRW4gBwD50fE8DWWE5hHjRyN0UQFAaVIVWqcxkIU5nQIJ9R0LC/A3/
         8DMJt3Z7EQE/YKXLzc4ymVMUg1kH6LZ7B4bfgPC0zRoszkE1AdnT06n7mcKaFMsVpf7m
         wOkbgLJOmEd3n4TDlCDbofS10/+OnLap04+VhPnPjJlTRGFXqUIzrGNVVnayQAcTLbqy
         0tIGF7c19QMMGwLX8zMSbau5pEABlonMGEkPVmBSNiw9spvZiECzEoTvVPc/vToSHvw0
         lTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GJ64TcgksQc3C6D3xtvHzgt3iSOg6McffYMs3O8prrE=;
        b=w0WAUXKFeg3Q20qZdhwb9xxsM0DYZ9fLCRpxvijiCDUGwYDA4iaMf6CNHK0R9Xdo9U
         o2KmKtDaieTwIMNmyRxl3ylvBvPnhK0vpmCN1oYj/puRDr5TbeCVq7cuhfXqEU/DQLFH
         3jMfhO6MCFBGvdTPJhsVTCfDoJULQVwmKU4cVNceXxqgqX56Omd5w8BpmPO59fq59DF+
         Oc3BGHdNGJEYPWVtLbCq9ezqeURuO0tejD8lqf79BbrDiKJAjnZ4gW951K67EEKcbO5Y
         zXbfQrKl/DrtBUhwQe+a1fH1uhkb9TR0p2KRGuunbXGMbMKCR2HIXrb7OW1MMBqIbtUE
         ilgA==
X-Gm-Message-State: AOAM530mod5qCqtcLc5Tc7IEB8dKd8pTTtnse5VjG0HzDX3vwSn6VnyN
        QxnHF1mc6w4FqjXNTCS8y+mL8V5XDi4Z+JyMGgXZ
X-Google-Smtp-Source: ABdhPJx3SFGGswhmmu2r1dzkr+eLURRkoUYw4sDxRVomPchgoioBKl7e14g/fwAEf2396aEHS44SLD69T09wvRp1j0Y=
X-Received: by 2002:a17:907:e8e:: with SMTP id ho14mr268357ejc.12.1639695898735;
 Thu, 16 Dec 2021 15:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20211026133147.35d19e00@canb.auug.org.au> <87k0i0awdl.fsf@mpe.ellerman.id.au>
 <CAHC9VhTj7gn3iAOYctVRKvv_Bk1iQMrmkA8FVJtYzdvBjqFmvg@mail.gmail.com>
 <87tuh2aepp.fsf@mpe.ellerman.id.au> <2012df5e-62ec-06fb-9f4d-e27dde184a3f@csgroup.eu>
 <CAHC9VhRHs8Lx8+v+LHmJByxO_m330sfLWRsGDsFtQxyQ1860eg@mail.gmail.com>
 <dc5705cf-d47a-57b0-65da-2a2af8d71b19@csgroup.eu> <CAHC9VhQPizVLkr2+sqRCS0gS4+ZSw-AMkJM5V64-ku8AQe+QQg@mail.gmail.com>
 <1a78709f-162e-0d78-0550-4e9ef213f9c6@csgroup.eu> <102e59ba-fcf0-dd85-9338-75b7ce5fbd83@kaod.org>
 <5f83d1fe-4e6e-1d08-b0c2-aec8ee852065@csgroup.eu>
In-Reply-To: <5f83d1fe-4e6e-1d08-b0c2-aec8ee852065@csgroup.eu>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Dec 2021 18:04:47 -0500
Message-ID: <CAHC9VhTcV6jn4z7uGXZb=RZ5k7W4KW1vnoAUMHN6Zhkxsw1Xpg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the audit tree with the powerpc tree
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Guy Briggs <rgb@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 4:08 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Thanks C=C3=A9dric, I've now been able to install debian PPC32 port of DE=
BIAN
> 11 on QEMU and run the tests.
>
> I followed instructions in file README.md provided in the test suite.
> I also modified tests/Makefile to force MODE :=3D 32
>
> I've got a lot of failures, am I missing some options in the kernel or
> something ?
>
> Running as   user    root
>          with context root:::
>          on   system

While SELinux is not required for audit, I don't think I've ever run
it on system without SELinux.  In theory the audit-testsuite shouldn't
rely on SELinux being present (other than the SELinux specific tests
of course), but I'm not confident enough to say that the test suite
will run without problem without SELinux.

If it isn't too difficult, I would suggest enabling SELinux in your
kernel build and ensuring the necessary userspace, policy, etc. is
installed.  You don't need to worry about getting it all running
correctly; the audit-testsuite should pass with SELinux in permissive
mode.

If you're still seeing all these failures after trying that let us know.

> # Test 3 got: "256" (backlog_wait_time_actual_reset/test at line 151)
> #   Expected: "0"
> #  backlog_wait_time_actual_reset/test line 151 is: ok( $result, 0 );
>   # Was an event found?

...

--=20
paul moore
www.paul-moore.com

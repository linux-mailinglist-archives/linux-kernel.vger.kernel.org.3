Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3644809BC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 14:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhL1Ne3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 08:34:29 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44204 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhL1Ne2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 08:34:28 -0500
Received: from machine.localnet (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id D420D20B7179;
        Tue, 28 Dec 2021 05:34:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D420D20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1640698467;
        bh=gUN7vLkUlLwHdZwfe5G3vlcXicivw2yzNuKkuIr7QYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPPL7U6PNMLFVoBzJg1WS+o4vidLYuRNcS0l4OJhC1yTgu/9IL5aR0/7ktUOm1/06
         uTMAWv4MKsLq3pzoxuifdHocJeZtV9DCxZo7+b8GHrJnJwzKYXZJOEGiqHn1d5mqDE
         CEf7KQHlOH4cdq7rXIcPdFQqRCmy9Z9cdRlXc6s8=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH v1 0/2] Add capabilities file to sysfs
Date:   Tue, 28 Dec 2021 14:34:24 +0100
Message-ID: <2639798.l7ez0hRiAL@machine>
In-Reply-To: <7d1d7682-dd19-1b8a-ee5a-50fe6479589b@schaufler-ca.com>
References: <20211227205500.214777-1-flaniel@linux.microsoft.com> <7d1d7682-dd19-1b8a-ee5a-50fe6479589b@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Le lundi 27 d=E9cembre 2021, 23:22:41 CET Casey Schaufler a =E9crit :
> On 12/27/2021 12:54 PM, Francis Laniel wrote:
> > Hi.
> >=20
> >=20
> > First, I hope you are fine and the same for your relatives.
> >=20
> > Capabilities are used to check if a thread has the right to perform a
> > given
> > action [1].
> > For example, a thread with CAP_BPF set can use the bpf() syscall.
> >=20
> > Capabilities are used in the container world.
> > In terms of code, several projects related to container maintain code
> > where the capabilities are written alike include/uapi/linux/capability.h
> > [2][3][4][5]. For these projects, their codebase should be updated when=
 a
> > new capability is added to the kernel.
> > Some other projects rely on <sys/capability.h> [6].
> > In this case, this header file should reflect the capabilities offered =
by
> > the kernel.
> >=20
> > So, in this series, I added a new file to sysfs: /sys/kernel/capabiliti=
es.
>=20
> This should be /sys/kernel/security/capabilities.

I began to write code to move this under /sys/kernel/security/capabilities =
but=20
I realized this directory is linked to CONFIG_SECURITYFS.
This option is not required to be able to run container [1].
Also, kernel/capability.c is always compiled, so I think it is better if th=
is=20
file (i.e. the one which prints capabilities to user) does not depend on an=
y=20
CONFIG_.

What do you think of it? Does this sound acceptable for you?

> > The goal of this file is to be used by "container world" software to kn=
ow
> > kernel capabilities at run time instead of compile time.
> >=20
> > The underlying kernel attribute is read-only and its content is the
> > capability number associated with the capability name:
> > root@vm-amd64:~# cat /sys/kernel/capabilities
> > 0       CAP_CHOWN
> > 1       CAP_DAC_OVERRIDE
> > ...
> > 39      CAP_BPF
> >=20
> > The kernel already exposes the last capability number under:
> > /proc/sys/kernel/cap_last_cap
> > So, I think there should not be any issue exposing all the capabilities=
 it
> > offers.
> > If there is any, please share it as I do not want to introduce issue wi=
th
> > this series.
> >=20
> > Also, if you see any way to improve this series please share it as it
> > would
> > increase this contribution quality.
> >=20
> > Francis Laniel (2):
> >    capability: Add cap_strings.
> >    kernel/ksysfs.c: Add capabilities attribute.
> >  =20
> >   include/uapi/linux/capability.h |  1 +
> >   kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
> >   kernel/ksysfs.c                 | 18 +++++++++++++
> >   3 files changed, 64 insertions(+)
> >=20
> > Best regards and thank you in advance for your reviews.
> > ---
> > [1] man capabilities
> > [2]
> > https://github.com/containerd/containerd/blob/1a078e6893d07fec10a4940a5=
66
> > 4fab21d6f7d1e/pkg/cap/cap_linux.go#L135 [3]
> > https://github.com/moby/moby/commit/485cf38d48e7111b3d1f584d5e9eab46a90=
2a
> > abc#diff-2e04625b209932e74c617de96682ed72fbd1bb0d0cb9fb7c709cf47a86b6f9=
c1
> > moby relies on containerd code.
> > [4]
> > https://github.com/syndtr/gocapability/blob/42c35b4376354fd554efc7ad35e=
0b
> > 7f94e3a0ffb/capability/enum.go#L47 [5]
> > https://github.com/opencontainers/runc/blob/00f56786bb220b55b4174823188=
0b
> > a0e6380519a/libcontainer/capabilities/capabilities.go#L12 runc relies on
> > syndtr package.
> > [6]
> > https://github.com/containers/crun/blob/fafb556f09e6ffd4690c452ff51856b=
88
> > 0c089f1/src/libcrun/linux.c#L35


Best regards.
=2D--
[1] https://github.com/moby/moby/blob/
10aecb0e652d346130a37e5b4383eca28f594c21/contrib/check-config.sh



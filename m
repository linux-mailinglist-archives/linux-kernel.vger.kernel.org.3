Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330674816DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 22:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhL2U4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:56:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44216 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhL2U4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:56:54 -0500
Received: from machine.localnet (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2D44D20B7179;
        Wed, 29 Dec 2021 12:56:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D44D20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1640811414;
        bh=UU8ronrNd3j0ukiSb777vN/bd/mcwfaqLvvGrOt8aqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qLv3CPASYGEaVxdSOxLupj+tR0ITFPZs6yUPrMZP5t7C95t+gAWK2nHjhuesE4f9t
         aj7PyVDurt3WZvXHzEZw+7dlev/zkh7OB2De6nhIOs9VBWX9unmEO8NQB+KhSJpivo
         LuSDHHX/gUkpeWDCLEAHRRySt3dmiFvGtBtZMe+k=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH v1 0/2] Add capabilities file to sysfs
Date:   Wed, 29 Dec 2021 21:56:50 +0100
Message-ID: <2076353.rJHahMSf2P@machine>
In-Reply-To: <48103715-6e22-10ab-6b4f-06946e00a28e@schaufler-ca.com>
References: <20211227205500.214777-1-flaniel@linux.microsoft.com> <2639798.l7ez0hRiAL@machine> <48103715-6e22-10ab-6b4f-06946e00a28e@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 29 d=E9cembre 2021, 02:26:20 CET Casey Schaufler a =E9crit :
> On 12/28/2021 5:34 AM, Francis Laniel wrote:
> > Hi.
> >=20
> > Le lundi 27 d=E9cembre 2021, 23:22:41 CET Casey Schaufler a =E9crit :
> >> On 12/27/2021 12:54 PM, Francis Laniel wrote:
> >>> Hi.
> >>>=20
> >>>=20
> >>> First, I hope you are fine and the same for your relatives.
> >>>=20
> >>> Capabilities are used to check if a thread has the right to perform a
> >>> given
> >>> action [1].
> >>> For example, a thread with CAP_BPF set can use the bpf() syscall.
> >>>=20
> >>> Capabilities are used in the container world.
> >>> In terms of code, several projects related to container maintain code
> >>> where the capabilities are written alike include/uapi/linux/capabilit=
y.h
> >>> [2][3][4][5]. For these projects, their codebase should be updated wh=
en
> >>> a
> >>> new capability is added to the kernel.
> >>> Some other projects rely on <sys/capability.h> [6].
> >>> In this case, this header file should reflect the capabilities offered
> >>> by
> >>> the kernel.
> >>>=20
> >>> So, in this series, I added a new file to sysfs:
> >>> /sys/kernel/capabilities.
> >>=20
> >> This should be /sys/kernel/security/capabilities.
> >=20
> > I began to write code to move this under /sys/kernel/security/capabilit=
ies
> > but I realized this directory is linked to CONFIG_SECURITYFS.
> > This option is not required to be able to run container [1].
>=20
> You're going to need to handle the case where the file is missing
> regardless. It is hard to design a kernel feature based on what a
> container expects when there are so many definitions of a container.

The goal would be to always have this file, as if I need to handle the case=
=20
where it is missing, it surely means having hardcoded values for capabiliti=
es=20
like today situation.
I think it should be always here if its definition lies in a source file ma=
rked=20
as 'obj-y', right?

Nonetheless, I understand your point of having this "capabilities printing"=
=20
file under /sys/kernel/security.
But, this would lead to add CONFIG_SECURITYFS as a needed CONFIG_ to "run=20
container".
And, if "container stack" runs on a kernel which does not provide this opti=
on,=20
then "container software" would need to rely on hardcoded capabilities (lik=
e=20
today situation).

> > Also, kernel/capability.c is always compiled, so I think it is better if
> > this file (i.e. the one which prints capabilities to user) does not
> > depend on any CONFIG_.
>=20
> CONFIG_MULTUSER is going to be an issue if you really care.

I did not know about CONFIG_MULTIUSER and thinking a bit about at it, it=20
should be a needed CONFIG_ to run container.
Nonetheless, when CONFIG_MULTIUSER=3Dn and if my understanding of 2813893f8=
b197=20
is correct, calling capset() leads to sys_ni_syscall() which returns -ENOSY=
S.
Thus, an user trying to "run container" with specific capabilities on a ker=
nel=20
compiled with CONFIG_MULTIUSER=3Dn will have trouble with all capabilities =
(and=20
will then have to first fix its CONFIG_ issue instead of knowing which=20
capabilities he/she can use).

> > What do you think of it? Does this sound acceptable for you?
>=20
> Meh. I'm not going to get worked up over it, but your rationale
> is a little weak.

I agree this contribution will not revolutionize how user interact with the=
=20
kernel.
But I see two advantages:
1. By removing hardcoded capabilities values from "container software", it=
=20
will ease these software maintainability.
Indeed, someone will not need to add new values to their code base when the=
=20
kernel get a new capability.
2. On the user side, without hardcoded capabilities values, you can use any=
=20
version of "container software" on a recent kernel to be able to use all th=
e=20
capabilities the kernel offers.
=46or the anecdote, it was my case some time ago and I had to compile newer=
=20
version of "container software" to use underlying kernel capabilities [1].
This was not a big deal, but if this "container software" were capabilities=
=20
agnostic, it would have gain me a bit of time.
=46rom this experience, I had the idea of this contribution.

> >>> The goal of this file is to be used by "container world" software to
> >>> know
> >>> kernel capabilities at run time instead of compile time.
> >>>=20
> >>> The underlying kernel attribute is read-only and its content is the
> >>> capability number associated with the capability name:
> >>> root@vm-amd64:~# cat /sys/kernel/capabilities
> >>> 0       CAP_CHOWN
> >>> 1       CAP_DAC_OVERRIDE
> >>> ...
> >>> 39      CAP_BPF
> >>>=20
> >>> The kernel already exposes the last capability number under:
> >>> /proc/sys/kernel/cap_last_cap
> >>> So, I think there should not be any issue exposing all the capabiliti=
es
> >>> it
> >>> offers.
> >>> If there is any, please share it as I do not want to introduce issue
> >>> with
> >>> this series.
> >>>=20
> >>> Also, if you see any way to improve this series please share it as it
> >>> would
> >>> increase this contribution quality.
> >>>=20
> >>> Francis Laniel (2):
> >>>     capability: Add cap_strings.
> >>>     kernel/ksysfs.c: Add capabilities attribute.
> >>>   =20
> >>>    include/uapi/linux/capability.h |  1 +
> >>>    kernel/capability.c             | 45
> >>>    +++++++++++++++++++++++++++++++++
> >>>    kernel/ksysfs.c                 | 18 +++++++++++++
> >>>    3 files changed, 64 insertions(+)
> >>>=20
> >>> Best regards and thank you in advance for your reviews.
> >>> ---
> >>> [1] man capabilities
> >>> [2]
> >>> https://github.com/containerd/containerd/blob/1a078e6893d07fec10a4940=
a56
> >>> 6
> >>> 4fab21d6f7d1e/pkg/cap/cap_linux.go#L135 [3]
> >>> https://github.com/moby/moby/commit/485cf38d48e7111b3d1f584d5e9eab46a=
902
> >>> a
> >>> abc#diff-2e04625b209932e74c617de96682ed72fbd1bb0d0cb9fb7c709cf47a86b6=
f9c
> >>> 1
> >>> moby relies on containerd code.
> >>> [4]
> >>> https://github.com/syndtr/gocapability/blob/42c35b4376354fd554efc7ad3=
5e0
> >>> b
> >>> 7f94e3a0ffb/capability/enum.go#L47 [5]
> >>> https://github.com/opencontainers/runc/blob/00f56786bb220b55b41748231=
880
> >>> b
> >>> a0e6380519a/libcontainer/capabilities/capabilities.go#L12 runc relies=
 on
> >>> syndtr package.
> >>> [6]
> >>> https://github.com/containers/crun/blob/fafb556f09e6ffd4690c452ff5185=
6b8
> >>> 8
> >>> 0c089f1/src/libcrun/linux.c#L35
> >=20
> > Best regards.
> > ---
> > [1] https://github.com/moby/moby/blob/
> > 10aecb0e652d346130a37e5b4383eca28f594c21/contrib/check-config.sh
=2D--
[1] https://github.com/kinvolk/minikube/commit/
51bf81c816c004ca0d0f3e3e368bc59f8a208387




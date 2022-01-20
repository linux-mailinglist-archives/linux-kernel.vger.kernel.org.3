Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0974953EB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbiATSOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:14:21 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57736 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbiATSOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:14:20 -0500
Received: from machine.localnet (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 02A1B20B6C61;
        Thu, 20 Jan 2022 10:14:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 02A1B20B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642702459;
        bh=Dk7oCau3NPRZS/+Jkk3UnnvDE9WkuVx6eb7IIQKTP7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDcgMC5VFkHZu6/uJMm4VJANNiN6cyrtxoQZeNKwAeXvpr64gwKOUJZbvUPa4MxBF
         MJtkL1x5fZKwFs9tLq12bIAFdjXCiHL5v7TlGtSjR8os7VOa00TbhcX5lcfaCZch5e
         bf+r01RKDKT+sGw1e+rOp27OsQH1eNIOpmNobTdU=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [RFC PATCH v3 0/2] Add capabilities file to sysfs
Date:   Thu, 20 Jan 2022 19:14:16 +0100
Message-ID: <6086103.nWTFFhADWI@machine>
In-Reply-To: <0c3b5f66-1550-3b67-c5a7-c452ff463b30@schaufler-ca.com>
References: <20220120180116.167702-1-flaniel@linux.microsoft.com> <0c3b5f66-1550-3b67-c5a7-c452ff463b30@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 20 janvier 2022, 19:09:50 CET Casey Schaufler a =E9crit :
> On 1/20/2022 10:01 AM, Francis Laniel wrote:
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
> > So, in this series, I added a new file to sysfs:
> > /sys/kernel/security/capabilities.
> > The goal of this file is to be used by "container world" software to kn=
ow
> > kernel capabilities at run time instead of compile time.
> >=20
> > The "file" is read-only and its content is the capability number
> > associated with the capability name:
> > root@vm-amd64:~# cat /sys/kernel/security/capabilities
> > 0       CAP_CHOWN
> > 1       CAP_DAC_OVERRIDE
> > ...
> > 40      CAP_CHECKPOINT_RESTORE
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
> > Change since v2:
> > * Use a char * for cap_string instead of an array, each line of this ch=
ar
> > *
> > contains the capability number and its name.
> > * Move the file under /sys/kernel/security instead of /sys/kernel.
> >=20
> > Francis Laniel (2):
> >    capability: Add cap_string.
> >    security/inode.c: Add capabilities file.
> >  =20
> >   include/uapi/linux/capability.h |  1 +
> >   kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
> >   security/inode.c                | 16 ++++++++++++
> >   3 files changed, 62 insertions(+)
>=20
> For the series:
>=20
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thank you!
I will wait to get some comments on the v3 and send a v4 with your tag adde=
d!

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





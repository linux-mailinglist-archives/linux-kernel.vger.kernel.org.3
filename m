Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46449548F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377388AbiATTBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:01:39 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35262 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbiATTBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:01:38 -0500
Received: from machine.localnet (lfbn-lyo-1-1484-111.w86-207.abo.wanadoo.fr [86.207.51.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id EACA720B6C61;
        Thu, 20 Jan 2022 11:01:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EACA720B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642705297;
        bh=kdtMXI/QMCENV1QmZoIgG492Dlrx1MGtj6LQrmu+XL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NKE1bmX6cn9sN4st5nZULJUQWY0SZ9EkDCjyC5EmwzEb4gubO0X9VrX4vLHFbk6bz
         vk8Sihcd1Pd7V4ucx57YcKRquqdSYii06VzmZsm9OICVpbOO1yf+wjPz+6IMHAdIkO
         uRKcF71rvRRvVh5jE7kfGcUrygOWx4HYlQhD/kgA=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC PATCH v3 0/2] Add capabilities file to sysfs
Date:   Thu, 20 Jan 2022 20:01:34 +0100
Message-ID: <1749578.SSYB0VbhXv@machine>
In-Reply-To: <87wniu2rs0.fsf@email.froward.int.ebiederm.org>
References: <20220120180116.167702-1-flaniel@linux.microsoft.com> <87wniu2rs0.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Le jeudi 20 janvier 2022, 19:20:15 CET Eric W. Biederman a =E9crit :
> Francis Laniel <flaniel@linux.microsoft.com> writes:
> > Hi.
> >=20
> >=20
> > First, I hope you are fine and the same for your relatives.
> >=20
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
>=20
> Actually that is a file in securityfs.  Which is related but slightly
> different.  For sysfs this would be immediately unacceptable as it
> breaks the one value per file rule.  I don't know what the rules
> are for securityfs but I do know files that contain many many lines
> and get very large tend to be problematic in both their kernel
> implementation and in userspace parsing speed.

I was not aware of the sysfs rule, thank you for sharing it to me, I will a=
dd=20
it to my "kernel knowledge" and will make use of it in the future!

> So I am looking for what the advantage of this file that justifies the
> cost of maintaining it.
>=20
> > The goal of this file is to be used by "container world" software to kn=
ow
> > kernel capabilities at run time instead of compile time.
>=20
> I don't understand the problem you are trying to solve.  If the software
> needs to updated what benefit is there for all of the information to be
> available at runtime?

Actually, software like containerd hardcodes all the capabilities the kerne=
l=20
knows based on a per-version approach [1].
So if a new capabilities, say CAP_NEW, is added to the kernel, containerd c=
ode=20
would become something like this:
	// caps59 is the caps of kernel 5.9 (41 entries)
	caps59     =3D append(caps58, "CAP_CHECKPOINT_RESTORE")
	// caps59 is the caps of kernel 5.17 (42 entries)
	cap517    =3D append(caps59, "CAP_NEW")
	capsLatest =3D caps517
This approach has two drawbacks:
1. A user which wants to use CAP_NEW would need to use kernel 5.17 but also=
 a=20
version of containerd which knows about CAP_NEW. So, this user would need t=
o=20
wait for containerd code to be updated (or to modify it by him/herself and=
=20
compiles it).
2. Containerd maintainers would need to change their code to add CAP_NEW.

It would be easier for everyone if the kernel exposes its capabilities, thu=
s=20
containerd code would become something like this:
	caps, err :=3D readCapsFromFile("/sys/kernel/security/capabilities")
	if err {
		caps =3D capsLatest
	}
This approach addresses the first drawback I quoted above and partly the se=
cond=20
one:
1. If user kernel was compiled with CONFIG_SECURITYFS, he/she does not need=
 to=20
wait the last version of containerd to use CAP_NEW, as containerd would rea=
d=20
the kernel capabilities from "/sys/kernel/security/capabilities".
2. Containerd maintainers would not need to quickly update their code to=20
reflect last kernel change.
I agree they would still need to update their code in case /sys/kernel/
security/capabilities does not exist.

To conclude, this series adds a bit of code in the kernel to make userland=
=20
life easier while not doing nasty things inside the kernel.
What do you think about it?

> > The "file" is read-only and its content is the capability number
> > associated with the capability name:
> > root@vm-amd64:~# cat /sys/kernel/security/capabilities
> > 0       CAP_CHOWN
> > 1       CAP_DAC_OVERRIDE
> > ...
> > 40      CAP_CHECKPOINT_RESTORE
> >=20
> >=20
> > The kernel already exposes the last capability number under:
> > /proc/sys/kernel/cap_last_cap
> > So, I think there should not be any issue exposing all the capabilities=
 it
> > offers.
> > If there is any, please share it as I do not want to introduce issue wi=
th
> > this series.
>=20
> The mapping between capabilities and numbers should never change it is
> ABI.  I seem to remember a version number in the file capability so that
> if the mappings do change that number can be changed in a way that
> existing software is not confused.
>=20
> What is the advantage in printing all of the mappings?

The printing of all the mappings can be used by containerd code to know abo=
ut=20
the capabilities the kernel knows.
=46or example, the above mentioned function readCapsFromFile() could be=20
implemented like this:
func readCapsFromFile(path string) (string[], err) {
	var capabilities string[];
	// Open the file.
	re :=3D regexp.MustCompile(`(\d+)\t(CAP_\w+)`)
    	for line /*...*/ {
		matches :=3D re.FindStringSubmatch(line)
		// To simplify, I will make the hypothesis the regex matched and=20
		// everything is OK.
		// matches[0] contains the whole line expect final '\n'.
		id :=3D strconv.Atoi(matches[1])
		name :=3D matches[2]
		capabilities[id] =3D name
   	 }
	// Close the file.
	return capabilities, nil
}
It will mainly parse the file output to create the capabilities array.

>=20
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
> >   capability: Add cap_string.
> >   security/inode.c: Add capabilities file.
> > =20
> >  include/uapi/linux/capability.h |  1 +
> >  kernel/capability.c             | 45 +++++++++++++++++++++++++++++++++
> >  security/inode.c                | 16 ++++++++++++
> >  3 files changed, 62 insertions(+)
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
> Eric

Best regards.
=2D--
[1] https://github.com/containerd/containerd/blob/
1a078e6893d07fec10a4940a5664fab21d6f7d1e/pkg/cap/cap_linux.go#L181



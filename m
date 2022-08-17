Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23D4596DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbiHQLxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiHQLx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:53:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39DF6DEFE;
        Wed, 17 Aug 2022 04:53:25 -0700 (PDT)
Received: from pwmachine.localnet (85-170-37-153.rev.numericable.fr [85.170.37.153])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7AE06213B620;
        Wed, 17 Aug 2022 04:53:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AE06213B620
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660737204;
        bh=guH8y5jLjdbgCVWwxETH/SVdTiebIYChnq1hy4g1F+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGt0vt4bAB41b7jk2M7M4mq5m/iaNiKmjiVOafdLaAWJY2oah+vjeFZBKpFQGG+KL
         S0s3e3wnWEb/FEJJoXZu94v3gVYecCafOh39CXL1x+MeieNl3jgqwVXklG7wX3b5Nc
         tDiVn0BXPP8gFzho+8stOgZrGPF3wcmTwzd5zpC0=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BPF [MISC]" <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH v4 0/2] Add capabilities file to securityfs
Date:   Wed, 17 Aug 2022 13:53:21 +0200
Message-ID: <4420381.LvFx2qVVIh@pwmachine>
In-Reply-To: <CAHC9VhTmgMfzc+QY8kr+BYQyd_5nEis0Y632w4S2_PGudTRT7g@mail.gmail.com>
References: <20220725124123.12975-1-flaniel@linux.microsoft.com> <CAHC9VhTmgMfzc+QY8kr+BYQyd_5nEis0Y632w4S2_PGudTRT7g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


Le mardi 16 ao=FBt 2022, 23:59:41 CEST Paul Moore a =E9crit :
> On Mon, Jul 25, 2022 at 8:42 AM Francis Laniel
>=20
> <flaniel@linux.microsoft.com> wrote:
> > Hi.
> >=20
> > First, I hope you are fine and the same for your relatives.
>=20
> Hi Francis :)
>=20
> > A solution to this problem could be to add a way for the userspace to a=
sk
> > the kernel about the capabilities it offers.
> > So, in this series, I added a new file to securityfs:
> > /sys/kernel/security/capabilities.
> > The goal of this file is to be used by "container world" software to kn=
ow
> > kernel capabilities at run time instead of compile time.
>=20
> ...
>=20
> > The kernel already exposes the last capability number under:
> > /proc/sys/kernel/cap_last_cap
>=20
> I'm not clear on why this patchset is needed, why can't the
> application simply read from "cap_last_cap" to determine what
> capabilities the kernel supports?

When you capabilities with, for example, docker, you will fill capabilities=
=20
like this:
docker run --rm --cap-add SYS_ADMIN debian:latest echo foo
As a consequence, the "echo foo" will be run with CAP_SYS_ADMIN set.

Sadly, each time a new capability is added to the kernel, it means "contain=
er=20
stack" software should add a new string corresponding to the number of the=
=20
capabilities [1].

The solution I propose would lead to "container stack" software to get rid =
of=20
such an array and to test at runtime, if the name provided by user on the=20
command line matches the name of a capability known by the kernel.
If it is the case, the number associated to the capability will be get by=20
"container stack" code to be used as argument of capset() system call.

The advantage of this solution is that it would reduce the time taken betwe=
en=20
a new capability added to the kernel (e.g. CAP_BPF) and the time users can =
use=20
it.
More generally, a solution to this problem would be a way for the kernel to=
=20
expose the capabilities it knows.

Do not hesitate to ask for clarification if I was not clear.


Best regards.
=2D--
[1] https://github.com/containerd/containerd/blob/
1a078e6893d07fec10a4940a5664fab21d6f7d1e/pkg/cap/cap_linux.go#L135



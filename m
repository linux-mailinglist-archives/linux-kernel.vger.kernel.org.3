Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3841348A206
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 22:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344992AbiAJViv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 16:38:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55404 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244498AbiAJViu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 16:38:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A052861470;
        Mon, 10 Jan 2022 21:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4ECC36AEF;
        Mon, 10 Jan 2022 21:38:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nGSXNiOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641850724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ZvI34k5qopJ7LeVmPLQAXBYV6MHZ7fIrRCNdpRkt04=;
        b=nGSXNiOYP3xPcCFVhh+vex4wGgo61Z13xqOTxD+n+OXf3aRgZzDoKF11qBhecKxQrZ90RU
        CZxOYW+4nY2Wi61BstCVT9bIka0dL5Wd6/9dh4fxPW8vscFIfc+q5VoPaq6wJ8moj75fcQ
        u7F+z/UiWjBmqZXHGC+mDsNLGm1zMB8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9a7e174a (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 10 Jan 2022 21:38:44 +0000 (UTC)
Date:   Mon, 10 Jan 2022 22:38:38 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Simo Sorce <simo@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
Message-ID: <YdynXjhhuQfbYuSb@zx2c4.com>
References: <f4a4c9a6a06b6ab00dde24721715abaeca184a0d.camel@redhat.com>
 <CAHmME9qP9eYfPH+8eRvpx_tW8iAtDc-byVMvh4tFL_cABdsiOA@mail.gmail.com>
 <20211210014337.xmin2lu5rhhe3b3t@valinor>
 <20220110132349.siplwka7yhe2tmwc@valinor>
 <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu>
 <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu>
 <Ydx7D3H0PS0Zs9/B@sol.localdomain>
 <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just in case you were curious...

On Mon, Jan 10, 2022 at 07:44:23PM +0100, Jason A. Donenfeld wrote:
> (b) can be accomplished in userspace by just (i) disabling getrandom()
> (making it return ENOSYS), and then (ii) replacing the /dev/urandom
> path with a CUSE device or similar.
> 
> I suppose (b.i) might be able to be done with some bpf seccomp cgroup
> situation. Or, if that's problematic, somebody could propose a
> "disable getrandom(2)" cmdline option. That doesn't seem very hard.
> And (b.ii) could use combined inputs from /dev/urandom and whatever
> FIPSy userspace jitter entropy daemon you have.

The below took all of 5 minutes to write. Should be easy to tweak this
for whatever flavors required.

====

/* Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
 *
 * Usage:
 *   # gcc -O2 jrandom.c `pkg-config fuse3 --cflags --libs` -o jrandom
 *   # ./jrandom
 *   # chmod 666 /dev/jrandom
 *   # ln -sf jrandom /dev/urandom
 *   # ln -sf jrandom /dev/random
 */


#define FUSE_USE_VERSION 31

#include <cuse_lowlevel.h>
#include <fuse_opt.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <linux/if_alg.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>

static int rng;

static void fipsrng_open(fuse_req_t req, struct fuse_file_info *fi)
{
	fuse_reply_open(req, fi);
}

static void fipsrng_read(fuse_req_t req, size_t size, off_t off,
			 struct fuse_file_info *fi)
{
	char random[128];
	ssize_t ret_bytes;

	if (size > sizeof(random))
		size = sizeof(random);

	ret_bytes = read(rng, random, size);
	if (ret_bytes < 0)
		fuse_reply_err(req, errno);
	else
		fuse_reply_buf(req, random, ret_bytes);
}

static void fipsrng_write(fuse_req_t req, const char *buf, size_t size,
			  off_t off, struct fuse_file_info *fi)
{
	/* Swallow it, we don't care. */
	fuse_reply_write(req, size);
}

static void fipsrng_ioctl(fuse_req_t req, int cmd, void *arg,
			  struct fuse_file_info *fi, unsigned flags,
			  const void *in_buf, size_t in_bufsz, size_t out_bufsz)
{
	/* TODO: implement the various RNG ioctls */
	fuse_reply_err(req, ENOSYS);
}

static const struct cuse_lowlevel_ops fipsrng_clop = {
	.open		= fipsrng_open,
	.read		= fipsrng_read,
	.write		= fipsrng_write,
	.ioctl		= fipsrng_ioctl,
};

int main(int argc, char **argv)
{
	static const struct sockaddr_alg sa = {
		.salg_family = AF_ALG,
		.salg_type = "rng",
		.salg_name = "jitterentropy_rng"
	};
	static const char *dev_info_argv[] = { "DEVNAME=jrandom" };
	static const struct cuse_info ci = {
		.dev_info_argc = 1,
		.dev_info_argv = dev_info_argv,
		.flags = CUSE_UNRESTRICTED_IOCTL
	};
	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
	int ret = 1, afalg;

	if (fuse_opt_parse(&args, NULL, NULL, NULL)) {
		fprintf(stderr, "failed to parse options\n");
		goto out;
	}

	afalg = socket(AF_ALG, SOCK_SEQPACKET, 0);
	if (afalg < 0) {
		perror("socket(AF_ALG)");
		goto out;
	}
	if (bind(afalg, (const struct sockaddr *)&sa, sizeof(sa)) < 0) {
		perror("bind(\"rng\", \"jitterentropy_rng\")");
		goto out;
	}
	rng = accept(afalg, NULL, 0);
	if (rng < 0) {
		perror("accept()");
		goto out;
	}
	ret = cuse_lowlevel_main(args.argc, args.argv, &ci, &fipsrng_clop, NULL);
out:
	fuse_opt_free_args(&args);
	return ret;
}

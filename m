Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979AE466549
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358556AbhLBOf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:35:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48760 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358467AbhLBOfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:35:14 -0500
Date:   Thu, 2 Dec 2021 15:31:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638455511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfpilSAiB93X0QHEEb/x6Clvw75Wh0+juuCuTfCiLDc=;
        b=njMurX/MuhPQ5sVqKd1VdgnGbdhScGrR/tIWyP8YPOrGpft+2X0Qd93DJkO3d6Z+1FCXGu
        qa2Xc5J6aiRKQjb1KqHD23y+mIxYYuw/xVIxxxh6mZZgXfmf2Zdf5krXgw9W5MKDnjxPrU
        FB237IKiTY6dpeiafrH/tG1+8jZA1pKvdLL+MNXQqwpOoSVflpwxU8mGpB08VXq8TAO0Rq
        AMHGlL5TPSyoCwMuz5fQaqQALLWCC8MAYXdps+uHeGmeq4fVfiAlcKxZDJmw9ffYKsy6B/
        fLdRxvWBNkFCYpIu9xMMPEjvEruRHftISl52AXOEgCfO4y8b/TFIsFMtJaKmSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638455511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfpilSAiB93X0QHEEb/x6Clvw75Wh0+juuCuTfCiLDc=;
        b=2kbAllXzVwvSiGhA+YnjLJbNpXNpbugioi4W8Rkd90Ogcl6FGY2uNwFceIEAVLX88eu3gH
        JiCsm21/i4KC30Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] notifier: Return an error when a callback has already
 been registered
Message-ID: <20211202143149.jeqf4bhhsr534pwo@linutronix.de>
References: <20211202133601.23527-1-bp@alien8.de>
 <20211202141630.rdkrtrltxhzdqtyb@linutronix.de>
 <YajW6LRVJi2IEHlU@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YajW6LRVJi2IEHlU@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-02 15:23:36 [+0100], Borislav Petkov wrote:
> On Thu, Dec 02, 2021 at 03:16:30PM +0100, Sebastian Andrzej Siewior wrote:
> > >  	while ((*nl) !=3D NULL) {
> > > -		if (unlikely((*nl) =3D=3D n)) {
> > > -			WARN(1, "double register detected");
> > > -			return 0;
> >=20
> > This could be s/0/-EEXIST/ or do I miss something?
>=20
> It is...
=E2=80=A6
> > > -		}
> > > +		if (unlikely((*nl) =3D=3D n))
> > > +			return -EEXIST;
> 			^^^^^^^^^^^^^^^
>=20
> ... right here.

I meant without the extra function. I'm fine either way, just curious :)

Sebastian

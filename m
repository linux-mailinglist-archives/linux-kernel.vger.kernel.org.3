Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92AE47623E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhLOTyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:54:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:50047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229648AbhLOTyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:54:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639598081;
        bh=swQPX1FjMZ2t4/rIyJDymJRL7SG6qrTNIpAKma6KJWw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=ernfPgnb8R9vCILpUHbutd15r+ImqKtf2V5PGLZb7kyfoku2rmdkYhDVv+LDy7muU
         ZiHRDrEAf7OSHCuYNTEnGMHCgv1axLniGyJ+uk9mUDx9ooqI3NbkMoM+koRHhJhNTT
         WM06748LcjGW15EXdYpUfdH7VnFNVBQzGNzYLPpk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.62]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3DO3-1mwl121FzJ-003he7; Wed, 15
 Dec 2021 20:54:41 +0100
Message-ID: <254513dc01188ca3ff161fcb456bc96a610821a1.camel@gmx.de>
Subject: Re: [rcf/patch] netpoll: Make it RT friendly
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Date:   Wed, 15 Dec 2021 20:54:40 +0100
In-Reply-To: <YboSe4NfbCeoqF1j@linutronix.de>
References: <20211118163405.adczki7ibk22bw7e@linutronix.de>
         <773fd8246a1ec4ef79142d9e31b8ba4163a0d496.camel@gmx.de>
         <YboSe4NfbCeoqF1j@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n8ykRYWPdacXtHF+MxgjAnfwYCp4ox5DY/mZ2UhsDHtj6Vl5qnl
 hU1f3TXZttQEXApDw+wPxyIWPs+NOChKqu6Jly+QtZXWyH/fqqxeveFVTnQsXHDDzf+CrzS
 OHk5zTyhd7uWDXiDF21lUGSz/K4rFE2dHmF1uj6w/7FDQtEWtUOK7pbgNhZD8Gzh8w+gtB3
 RvjUIYNVnDkAk9FLfzIgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:61j7QCcUWyo=:XtlkPRr7VU6sa6DhisEFEP
 nC+W/i6MMJxjaBVLf0xY/SDKxpieql+1k6kjEokE7fuOghXwkoJPHCVhR5DcO32RN7DKjpF90
 b1WaXjI3AhStgXRzqiiuvyc7HOcLzJpn0iY/ZKtfMnfuwvhdQ5vY2HwwTmmb91mz+wUZ7tAJ8
 M2fXzvNIhlV+Yk5MOrVPK+0+wmObmXDXohsL/ddWufSmZ4st/IRMS7aqErMcrVOWhxhMt187D
 BwUqoBJOyZNZXXfJjaKEpQw+osAkPkmdHTHIXlMO4DZA2eDGvHerr6EKJyE8sSi1IBN/oMEgc
 EwULjlaalBroPC6RsCNJkldaOVOvrkB5d42rOB0y9/Tq4lnVbxOQyzvVCYaX2qWJrfch/+JDa
 lC8uZ0g4AY5z7CeD26H4/64rJbMGhEl7Mzb2JWUtoJfaURqPTzu498VCajvVUWd1hlygy9TqV
 NgRoNcQqHHjnFETGhx1n6PXZvqLTLxCeoZM46U/je2ixKyzV1BszhtldmH/v2nUZnBLQ36ktA
 P/bAJ4EDpDpS0yNiWG1XBDlUnnjj9ejkYi3h5mT+4SZ0tS5bhQH9vRCCFIVvzwDlgdOy+his6
 CfBGwaTexRbU05oU78qYqAsysRT+NSc/PrSKOwufE+Ru4Tn3ahbmbx2bbBsVlnHDFwDpRKWts
 Hr8Z0jPQTnxsP19V3pGf54ZQxn+o8+JEI+fbdV7Ftxkglh2uWfG3cNO8KXvzxWcfoSNQ7E5Eb
 kawXIpVihBoLADOJHzPxgakQtBjetbb2HeXugYAdr/KWd8+hj14USKvN8f/+qn94fQZgbnjcI
 9USXNIzW8dNEhegiwyc0Z55uniCSelyuko92gvPfzJ9GCDDlqrDu6dV09rO5KkUneYboyguP9
 +FWK0RarIkYliZk4B3UVW0z90H1KttHc37+SWM0/7bFS6xfip16tZNMSkhA17HaIrBy/qVMhl
 EgBs3OdAv2eVsD+buFHiMXmmMHpZ/tnoCsFUGoMHRPC0CG2u1/SF7i9N2Spk6+2W9PjC7ZUKM
 2UjryOmmc5wj2qPStZbdc1FCEr5j8qX5FxpCEpun0tJ1AWX235eeLFkVoBHkYHNIy7wAxQr5h
 YWp2sm41Hs2KIE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-15 at 17:06 +0100, Sebastian Andrzej Siewior wrote:
>
> What is the context for netpoll_send_skb()? Why do we need to disable BH
> + RCU on RT?

Because rcu_dereference_bh() says it better be, but..

> If interrupts are never disabled, doesn't this break the assumption made
> in netpoll_tx_running()?
>
> queue_process() is also busted.

..that makes it kinda moot, and wasn't unexpected. It works, or at
least netconsole does, and lockdep was fine with it, but I figured it
unlikely to fly.  In fact, I had already taken the silence as a "Surely
you jest" or such.

	-Mike

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4570D47919F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbhLQQl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:41:27 -0500
Received: from mout.gmx.net ([212.227.15.19]:56775 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238448AbhLQQlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1639759274;
        bh=fuBXtnmriSeK6f/W62rOX82r8KsWHFN4zqjAy4KFq/4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=IbAAY1FbXbgqlkyvROgZiGJOlDsLTjP2lo01sgk7E0D3Os7MEJM9J0fcnMiKC3nvi
         lIgDtg7FOWN/C1t5u53yVXYzfs9CT2wGpJdJ8orsQT1H1Yj9UOUK/2PFV6SxobdvH2
         9O0+TjwN4X0CPdhp+BFBco/LU7pT++3/Rh+uRQ/s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.196]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD6W-1mL3rU1F9m-00eKz2; Fri, 17
 Dec 2021 17:41:14 +0100
Message-ID: <aefb739c62186636cdc48e4fa7b78d31bdb21e75.camel@gmx.de>
Subject: Re: [rcf/patch] netpoll: Make it RT friendly
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Date:   Fri, 17 Dec 2021 17:41:13 +0100
In-Reply-To: <YbyX2gAsLFrq+mMG@linutronix.de>
References: <20211118163405.adczki7ibk22bw7e@linutronix.de>
         <773fd8246a1ec4ef79142d9e31b8ba4163a0d496.camel@gmx.de>
         <YboSe4NfbCeoqF1j@linutronix.de>
         <254513dc01188ca3ff161fcb456bc96a610821a1.camel@gmx.de>
         <YbyX2gAsLFrq+mMG@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ydz8IdKPdVY4knV+kUMcAcqmWALsmACw5h7OZGKr+aFpmoG+QME
 vTGoJAtt7SuZz6keTf+32IvhXz62f/EPiwdj3lVj0gq6s5aGHGcBa0NT8i1q+Am2mWD3p9f
 il/myCTPum7mGvY0p21sXnu3pUrUbuPn7eqYvPDynZhjmhlIuwVHUBd0rN62mh5AZqzRqNV
 blhFvAkgp3ci5LN7UyqAA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9EG92R1TmtM=:+8OQTqGjV8a0cx50sBBPoq
 aiQCCROedU6DXs43GQrGOK52MghinXGszTTVEYJjpO8mZjXsulyE8o3BlTZIOqfEcVcv+0eAl
 DZliW0aU0f7dJOAEjn8eVsIoudCo3ktA7C5+9Z2zWRM716Zuf0f4rIne1LOhjwQ6PJXRB39fH
 B2Nz1FSOSYSWawRX8re0WTkKjXwJQZdZySuDXoHty7NF/UAMy00S2nuSP8tYBYsmBQaTys8k0
 +YBVohRzwjGhKEcHrAajYU4gz7jUjAvmEFz8mKW3hE4+/NmChEVEUPquiFr9xxOXMflxNTqls
 za9mQf8dSuZY+r37oRl/1J14lezFdABFKKtHyeVlYhP6Xf3uba3yqgfELTrcWyagZuHe9ShTP
 1J0s0/8t74Euht6f4n2FD8mkJBMon5FyfbJVpnBBXqD/2QFXLVMZ3ak5Mh/qwqpG5YG4tle6v
 HzN0cMGT7mYa4HUMssMF/xw4YtCw52TvhdWwlv1S0CHgEoO0vTcVkkZ8GnkWrkcFTZvcWR+bo
 cUU4f0z3+jn4MyNQd9OhxWhGxRF4r9TDQbrvFRBJt2DSdlGh6AzMZt0KEyg7860ZGHA4c67mj
 gOg/wDRDSu8+XoCWBp5CRBMJcQ53AFvxBzQzVOMnvaiZvpYZtzYviGnUJuO9Dw6dwYdHp56NR
 Naa5xIz9EuTvA/XdsFcByecJOvu+ELVI5EnA6rFKjOM0+smu8nM1orgk1lFP+RWEpDj6AIEKn
 4FmHW4DI2rGyaapISpKBtWB3lod7V+Dumlllh4iPNzLV4A88srF+wDeGw0bGcVSGBJcC0c0p7
 +hBhba/TWv4r3NdrjiLaHLUC0CMmA5tj8zU1ndhdmezzCEJcjjIDc5hl5D28pjhnu0bjsZg5X
 4iSQsiVCWYEpFC7tHRH8Xa/NrmnNjduJ3c99U4ePYJ+dwlTXic4bgyaIGh9Gpu0YE21FLsrKe
 fUGDN6i+LspKcESeOCRTAhJVF0+Xb+ptCJRNIvf6eBtVvcYwHHhTUQWR6cagei3iSkK9HMu/f
 E8DgyzqQyLrtAKyEk4qQr6v1vs/wy5KzzIqGimSju3ePnUOWdlFxLBUJNF51PzdOSaQfKDMfn
 IzS76rwfmJ41uI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-12-17 at 14:59 +0100, Sebastian Andrzej Siewior wrote:
> On 2021-12-15 20:54:40 [+0100], Mike Galbraith wrote:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 In fact, I had already taken the silence=
 as a "Surely
> > you jest" or such.
>
> No, not really. netpoll is currently the least of my worries and I
> wanted to finish my other network patches before I start wrapping my
> mind around this in case something changes. But I have currently no idea
> how to do netpoll run/ detect and so on.

I was gonna toss a rock or two at those "and so on" bits since they're
wired into stuff my box uses regularly.. but I've yet to find a means
to make them be more that compiler fodder, so they're safe.

	-Mike

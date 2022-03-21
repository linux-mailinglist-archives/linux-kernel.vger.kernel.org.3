Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67CD4E2245
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345314AbiCUIfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243898AbiCUIfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:35:13 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35057B851
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:33:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A7505C0148;
        Mon, 21 Mar 2022 04:33:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Mar 2022 04:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=VtZrK2QJiD142HH3e
        GmHXidaImy2Iw8OCXmGcQVUc68=; b=QPY3fFhy5BPpxmLoGrFk6WJorIKyixJor
        69vOYsoS8sXfCDN+02J5Y771+jowJidfQwr2ENoq2z78TL+7P717CetjPCJvDQ8T
        qKQcM20/dIxJHY2kYw5AE8Qu4azDD5A7EoFvkK6J2qq0EaUTGKaSVcenZc54gtzK
        Y7KgRDUcR/dCn+hXm2paWWcY1Rdc0VlHHvpE6F94jd4iMxn2RVT17rgPo03cyVLd
        B+E3LUo8GpzdduAOLC9a1BKgTUvVVS7oveVM0m20uCRjyKcYtTGKba+walTdKVBw
        d2TyQoN5KkYPOE+rI7//VIShPPBKIkvyqhDpHbOA6UQ+xLu7KYdsQ==
X-ME-Sender: <xms:bDg4YlIWvlY11pNN6C5YQpq9YkfPMWGbEqkE24kIA5Z6vZmstLZ8gQ>
    <xme:bDg4YhJJi65ZonIC1Roo10xa-o-9Ye3r8wDczuIhRxGjSUNazHajFKvfC1IC7OlWY
    oGC7QsupScIR4-hALI>
X-ME-Received: <xmr:bDg4Ytug7GTBFnwV3KiJCAwQUt87jNzkDABa8MUKD4j096A1XzTNi6Fq-3Ht5X021df26BVNdgGrrzZmilUHwcx1POdXfJvJ9Ac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegvddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvufgjkfhfgggtsehmtderredttdejnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeefffejiefgheevheefvefhteeggfeijeeiveeihfffffdugfefkeelfffh
    gfehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:bDg4YmarDAoULOf4IE2EJh377O5zWgzcWqgeWJFynO8TfXFjrHO7mw>
    <xmx:bDg4YsZirls1e2q3o7Lxx3Sg78mXPniQQaJKJzSoSeHfq1pDEZglyg>
    <xmx:bDg4YqCObPnrhNwUdapayoyOR_dPwVoeX2ZPnJxxuq1XIfJeeGiBqQ>
    <xmx:bDg4YrnCPB4wnMmMWJFw1yr2VU2ve0PcMV4pG486hcvMPClzL0CUIQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 04:33:46 -0400 (EDT)
Date:   Mon, 21 Mar 2022 19:33:56 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] macintosh/via-pmu: Fix compiler warnings when CONFIG_PROC_FS
 is disabled
In-Reply-To: <bb6d3131-3c46-654f-d2a0-6d57bb8cbfbf@csgroup.eu>
Message-ID: <39f63c1b-5a1b-8c8e-5991-813d3d3c2576@linux-m68k.org>
References: <650f5577599a701fdd632cdd469a9cea9788cdf3.1647674431.git.fthain@linux-m68k.org> <bb6d3131-3c46-654f-d2a0-6d57bb8cbfbf@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463811774-1870743231-1647851636=:12278"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-1870743231-1647851636=:12278
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 21 Mar 2022, Christophe Leroy wrote:

> Le 19/03/2022 =C3=A0 08:20, Finn Thain a =C3=A9crit=C2=A0:
> > drivers/macintosh/via-pmu.c:897:12: warning: 'pmu_battery_proc_show' de=
fined but not used [-Wunused-function]
> >   static int pmu_battery_proc_show(struct seq_file *m, void *v)
> >              ^~~~~~~~~~~~~~~~~~~~~
> > drivers/macintosh/via-pmu.c:871:12: warning: 'pmu_irqstats_proc_show' d=
efined but not used [-Wunused-function]
> >   static int pmu_irqstats_proc_show(struct seq_file *m, void *v)
> >              ^~~~~~~~~~~~~~~~~~~~~~
> > drivers/macintosh/via-pmu.c:860:12: warning: 'pmu_info_proc_show' defin=
ed but not used [-Wunused-function]
> >   static int pmu_info_proc_show(struct seq_file *m, void *v)
> >              ^~~~~~~~~~~~~~~~~~
> >=20
> > Rearrange some code and add some #ifdefs to avoid unused code warnings
> > when CONFIG_PROC_FS is disabled.
>=20
> Why not just put those three functions inside an #ifdef CONFIG_PROC_FS ?
>=20

You'd get a warning about the prototypes ("declared static but never=20
defined"). Rather than add an ifdef around the prototypes as well, I just=
=20
reordered things a little.
---1463811774-1870743231-1647851636=:12278--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF59583DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 13:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbiG1Ljl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbiG1LjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:39:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9BD6A4A8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:38:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 15F3D33A33;
        Thu, 28 Jul 2022 11:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659008309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCTDsjMvQ42bPcKeynsewoMKhH82hXRbjXkjEys14+o=;
        b=omc4xCiOI34ZURPO6ixkP/uM/28AmQNQ9D/KYHl2zwrMmYPGWdhL2b8tO2Yl/f+MAJXFbl
        MwUaaiKaY8gIFi8D7dAWO6EZaHq9HDAVr0JYIbspFhGsFqvh8i/R/CRDDBM8AhHvsBGkM3
        hGTYXqshrC4Rgew4+48qfResC4jdvOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659008309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oCTDsjMvQ42bPcKeynsewoMKhH82hXRbjXkjEys14+o=;
        b=hLYRud54mwo3moDg6l4rB2DIBukOy5LJogc1A5UZIOtVgajMsk99MS0vV03xfWO52gSGjt
        QgYkrgNGATMdZcAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D20B213A7E;
        Thu, 28 Jul 2022 11:38:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XbipMTR14mKOEAAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 28 Jul 2022 11:38:28 +0000
Date:   Thu, 28 Jul 2022 13:38:27 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chenglin Xu <chenglin.xu@mediatek.com>
Subject: Re: [PATCH] soc: mediatek: Let PMIC Wrapper and SCPSYS depend on OF
Message-ID: <20220728133827.5f59e824@endymion.delvare>
In-Reply-To: <98eccbdd-3446-f44d-9278-79a4a60c1c18@collabora.com>
References: <20220728112216.13b10689@endymion.delvare>
        <98eccbdd-3446-f44d-9278-79a4a60c1c18@collabora.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Thu, 28 Jul 2022 12:51:44 +0200, AngeloGioacchino Del Regno wrote:
> Il 28/07/22 11:22, Jean Delvare ha scritto:
> > With the following configuration options:
> > CONFIG_OF is not set
> > CONFIG_MTK_PMIC_WRAP=3Dy
> > CONFIG_MTK_SCPSYS=3Dy
> > we get the following build warnings:
> >=20
> >    CC      drivers/soc/mediatek/mtk-pmic-wrap.o
> > drivers/soc/mediatek/mtk-pmic-wrap.c:2138:34: warning: =E2=80=98of_pwra=
p_match_tbl=E2=80=99 defined but not used [-Wunused-const-variable=3D]
> > drivers/soc/mediatek/mtk-pmic-wrap.c:1953:34: warning: =E2=80=98of_slav=
e_match_tbl=E2=80=99 defined but not used [-Wunused-const-variable=3D]
> >    CC      drivers/soc/mediatek/mtk-scpsys.o
> > drivers/soc/mediatek/mtk-scpsys.c:1084:34: warning: =E2=80=98of_scpsys_=
match_tbl=E2=80=99 defined but not used [-Wunused-const-variable=3D]
> >=20
> > Looking at the code, both drivers can only bind to OF-defined device
> > nodes, so these drivers are useless without OF and should therefore
> > depend on it.
>=20
> I would prefer that you solve this warning by removing of_match_ptr() fro=
m both
> drivers instead.

Actually we could do both. Once the drivers depend on OF,
of_match_ptr(_ptr) will always resolve to (_ptr) so we can indeed
save the preprocessor some work.

--=20
Jean Delvare
SUSE L3 Support

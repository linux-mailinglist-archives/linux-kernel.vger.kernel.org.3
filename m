Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A46B58D592
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240044AbiHIIma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 04:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiHIIm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 04:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311221EC78
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 01:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C492D61314
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398D8C433C1;
        Tue,  9 Aug 2022 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660034545;
        bh=zYaOTja4AIBD/WAKQ57pm5wPsgAuCtuZjUduy4rsppI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NEE2o3kJElgOO5kP4ieMEncdEyYu2gZlpT66wmKLnQurYorKcfwC+SnRfrkLvsp6C
         mjWZScnGZLtaeCkDKx5lF5+UVSMKhpyM6Tywx5lv1CsbFacpEMpyCa+ubQoUkhKwMH
         Ls/kWVR9bfp4TKXcR7kViO9tgYjud+TSul5DjVfbfXWWXvuog1+Lnh1vTtiLA3IKSN
         ap/FaqWE/myBrcf3iFhpyaD0myrWJHm4VlefQ9yWSuQy8hjVcwdhJcp5i4VCKWHQi+
         Y3q/z0QVYeqHNuE85g6LyqTL4AKQ1c3K+NfrtNJxJmvbCHy+J9zscleS1Aj2HYbwxR
         FimJxna+angiA==
Date:   Tue, 9 Aug 2022 10:42:00 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: fsl_elbc: Fix none ECC mode
Message-ID: <20220809104200.3dca43ef@thinkpad>
In-Reply-To: <20220707184328.3845-1-pali@kernel.org>
References: <20220707184328.3845-1-pali@kernel.org>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Jul 2022 20:43:28 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> Commit f6424c22aa36 ("mtd: rawnand: fsl_elbc: Make SW ECC work") added
> support for specifying ECC mode via DTS and skipping autodetection.
>=20
> But it broke explicit specification of HW ECC mode in DTS as correct
> settings for HW ECC mode are applied only when NONE mode or nothing was
> specified in DTS file.
>=20
> Also it started aliasing NONE mode to be same as when ECC mode was not
> specified and disallowed usage of ON_DIE mode.
>=20
> Fix all these issues. Use autodetection of ECC mode only in case when mode
> was really not specified in DTS file by checking that ecc value is invali=
d.
> Set HW ECC settings either when HW ECC was specified in DTS or it was
> autodetected. And do not fail when ON_DIE mode is set.
>=20
> Fixes: f6424c22aa36 ("mtd: rawnand: fsl_elbc: Make SW ECC work")
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>

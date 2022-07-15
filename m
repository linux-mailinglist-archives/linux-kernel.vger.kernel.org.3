Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65697575E69
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiGOJXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiGOJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:23:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF2565D6E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB3A462117
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 09:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BCDC3411E;
        Fri, 15 Jul 2022 09:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657877006;
        bh=zYaOTja4AIBD/WAKQ57pm5wPsgAuCtuZjUduy4rsppI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rvNxhMjRwcpvomEqfUu2I/STcWxYcOI0zICdthmOcc6kV2nluRIoTBraaUywHI+UC
         cT16yBFVX7ufZ71Pr0Ob1lxDXb2HIU6flVZ7Mkb3HcVZIPtxFFGqewszpU1zKp2Ejr
         5LHj0q4KujT0lpww71Egrllijvk7tPZJiUubR76bd7u//vmguiid6nN2na6J5mGH1U
         S5IWc+i6HomW2fBVeHXIauXydCDW87W5fYY9/g0SZ2qo0SrEb+871wekeMRvXRF9id
         IYrgs23Zuz7ffEPX215wvcn7wpUtk6OS4dOuWURmRj7gzRSqkYpAowbj50ulLXeDJ5
         exfdAKpPNHJiw==
Date:   Fri, 15 Jul 2022 11:23:21 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: fsl_elbc: Fix none ECC mode
Message-ID: <20220715112321.6c8ba00e@dellmb>
In-Reply-To: <20220707184328.3845-1-pali@kernel.org>
References: <20220707184328.3845-1-pali@kernel.org>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

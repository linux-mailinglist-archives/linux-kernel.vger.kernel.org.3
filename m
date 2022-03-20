Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA64E1AD2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 10:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243073AbiCTJU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 05:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbiCTJUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 05:20:53 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616E02CE12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 02:19:30 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h63so13807006iof.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 02:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSgE6yqkno7KzD+jL8KRzD/isTc5hJCWP4hnpiIR8X0=;
        b=CsH4edHw8WSKA94Lkc0rOnB7epUJgnoD9Z8QTIYRO+a7K5/9ktJb4FXPKuKdspVABe
         yO0B/EVW1+xR5TwBuBHBxQLHZVzQA0TtjFk3FeuKxKNnJbSMzPL3PF6amOdMsFRZ5FJf
         8+ULmopFYRwJzxXyZwFBXiB39pkcHq/ySbCSubyQ8wTiNHWUd+bDswhEjebmqkMkoZF2
         JN+MyQEDLTZuREXBzgl/oI1/ro9up2bOsQZE0fbod8i0DseBXBPEjm2J+qwIBlHztvWc
         VnVUJdbWnTWIgbCTeMflxK0zEbDn4BHzZ1gNX7sOddt7rMJzg+IMupiLUULkBl4Rm/El
         6H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSgE6yqkno7KzD+jL8KRzD/isTc5hJCWP4hnpiIR8X0=;
        b=M8vE0S7cCX4VwBzyDy4hwDOae7SFgYVCphR6SjSsciOTkhbAB5T1/u43BD3rCvR0wu
         +zK/88D+7lDnnAarVuggBT6U78shiBTdGX2tJm87yMS0kYyBexIcojAE61pTOQvrVtxj
         N4piTsC+4ayekX1pfSj420/EqbSKgHqFxQvlKO2SH5raPDnHKfh8Np8z3IHYUMmtD3au
         Rqrqbh7EQW5u+/ZNchMGQMEBoX8PFimhxKPxRMwBKh1bMdZNrDnDTxPCtX0tp+z4SGlR
         7RvGbakUVbq4zbj2RsiHZBDkWgPcJxRStTVy1+S0cEkEfZjj6sb/F1CisQ5r1wqYL0JQ
         ddtg==
X-Gm-Message-State: AOAM532G9aCA1mU2MXgF4DWFcOnBU7DSxim0fgqOtUnSrV8tu/cShB8W
        /IlYvbnmUbNDV3M3Omj1wUYL1+RZI+UN9RARrPA=
X-Google-Smtp-Source: ABdhPJwx5w7JImU6Tkv500kqsx5RX2SPwULSRkx+D7lzBJknKujzkeLLzikMQyYbCqkLa86AF4+AVAEjSZatRWHJpJk=
X-Received: by 2002:a05:6638:531:b0:317:af7d:d934 with SMTP id
 j17-20020a056638053100b00317af7dd934mr7797245jar.307.1647767969638; Sun, 20
 Mar 2022 02:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220319083301.87400-1-gch981213@gmail.com>
In-Reply-To: <20220319083301.87400-1-gch981213@gmail.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sun, 20 Mar 2022 17:19:18 +0800
Message-ID: <CAJsYDVLORFCt75Nv1+3wNd2=mMhHQm6Hb_iQ_HGO=Qgg6iV0eQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spinand: gigadevice: fix Quad IO for GD5F1GQ5UExxG
To:     linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Stefan Roese <sr@denx.de>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Mar 19, 2022 at 4:33 PM Chuanhong Guo <gch981213@gmail.com> wrote:
> [...]
> --- a/drivers/mtd/nand/spi/gigadevice.c
> +++ b/drivers/mtd/nand/spi/gigadevice.c
> @@ -39,6 +39,14 @@ static SPINAND_OP_VARIANTS(read_cache_variants_f,
>                 SPINAND_PAGE_READ_FROM_CACHE_OP_3A(true, 0, 1, NULL, 0),
>                 SPINAND_PAGE_READ_FROM_CACHE_OP_3A(false, 0, 0, NULL, 0));
>
> +static SPINAND_OP_VARIANTS(read_cache_variants_q5,
> +               SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),

I just noticed that only GD5F1GQ5 has 2 dummy bytes. GD5F2GQ5 and
GD5F4GQ6 have 4 dummy bytes instead.
I'll rename this variant to 1gq5 and submit a new version of this with
a series of
patches for other GD SPI NANDs.

-- 
Regards,
Chuanhong Guo

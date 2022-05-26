Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3784E5350A3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347655AbiEZO3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiEZO3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:29:18 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F55C6E73
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:29:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id x137so3167833ybg.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydnp/SkEaNui6oKHTmT2ANWb4DcH7fhI+J8O3cY/vm8=;
        b=lHoB8lWPRbxH8mzNXQ/OqDB1zLwRJRT60HTzLHg49lTanRVW+wFH9jXxaw4Guu5N1g
         +/6P9fIyX4dhl8p0sOnYMqqtWA5Vl6ptE5q31qPpmcW8B4WbSjWuzpUcDVx2FD2Ik+jx
         upku+j0FjvWOzFRmfYZZqGvijEVYSLPQXbUYrt0hvpj6dnW8J0VlSBXd2bZ5Ezr6IOcp
         1NX9ADMUhNk/ZDUhb0/S6jUYf7XYwEzrEvxcM66ESnYna6VQaev7E5it1ashPTkoHHGk
         TNvROvmiYcPNa5O0k64jMN/OXksW+V9Nel8hhLiyIU9YzWw9GaXVQ+W2DBEMWk96cPWU
         FXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydnp/SkEaNui6oKHTmT2ANWb4DcH7fhI+J8O3cY/vm8=;
        b=hdUN/TW2VMo1XWkbhJrFy5w88mChE8cwogcTQrGFBUhIGRbh52cju0IMIjTz+X+wR2
         4jMovRvSnnLWHo7F86WMcC3sSIz2/GvmTs1XHmNo9X4K2sETshzS1vY3bbF7WLzjJXLb
         oeJuXeKLpSvDtzxrPoyajZjv0jeSZn2D17hsW9qqMXV5qs01AIkK9n8L4Cm1afAVQR4X
         00B2qgdNDuhJ96tQmFwoVD9CVQwnkg8LAFYq58Fhf5+EcET7vHj5EA4LAsiKBVHwroed
         JvE+lD349XU9ljnmYJQRUMzBGSDXhRiDu/l1LI2ymq1Dkl2MACyihnF5BKbJKhzkxvH6
         T3Ow==
X-Gm-Message-State: AOAM533LwHlie9S9gRkRDJ5l6C8aIDBht4JlWZ97D0UXPf4yfI4X34Ge
        1Czt23Na9Sm3UwtB3g06mDNQ0BUPVvrcaVOWAJf3UA==
X-Google-Smtp-Source: ABdhPJzt1NOUwWqS9KMSfdhdmLFRvdVLkaRsRaWTXrveTqJ7fnZnUYJ7debsK2tbIb1BOC6ZpyW3j0vki0nJwktj1bo=
X-Received: by 2002:a5b:691:0:b0:64d:ab44:f12e with SMTP id
 j17-20020a5b0691000000b0064dab44f12emr35447124ybq.533.1653575357508; Thu, 26
 May 2022 07:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220526110652.64849-1-linmq006@gmail.com>
In-Reply-To: <20220526110652.64849-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 May 2022 16:29:06 +0200
Message-ID: <CACRpkdapKGvc75KV6ryJTLZdWCk=_dNrkzv_g0DnyNJm=1DvXw@mail.gmail.com>
Subject: Re: [PATCH] mtd: partitions: Fix refcount leak in parse_redboot_of
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 1:07 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 237960880960 ("mtd: partitions: redboot: seek fis-index-block in the right node")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A42B53DB6A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 14:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343625AbiFEMir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 08:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiFEMip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 08:38:45 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDA931344
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 05:38:43 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id w2so21351354ybi.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 05:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oPBRQZit+frysiswJmW7l8KQz4Nt3cvgksLt6M1PHGc=;
        b=OfloKZSq4RGAqyqHoHtzPuMCmuMdR/0id7xESYd99+YAW4Yo3oFsR/tzwQyUcAtVTt
         WDrgm3PGPU4HKwlAEVwaw+pQmabbVMiuCSUsI0gGffI8euanbS461OW0K/2zoUVXN/4f
         gMrnBEYEV4WVf4I3+YlFsk/ANKarOMLQytzacUBvdr2r8zPPicLwXpSDvDj/IGBHggOS
         PL5Itsp1X13ZXXR0IEAmODVgZxl+cSPfnIR1d1AQggFhaVqmweuZva7F2iC7gEGffX6C
         BzRqJT6zYvqqwJlGdD//8HezsM7bpJqqcRRHN4dOxVE/iywTwYfYBPGuxo4ZLLr6K6kD
         oFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPBRQZit+frysiswJmW7l8KQz4Nt3cvgksLt6M1PHGc=;
        b=T+IzEWT/ZBMHqs1qpcnKB1o7zsdoSoggcRnbALK7/+I7B9B8LEQZVCwzyumKFqd2Sm
         F6M/PWXSZhwolI2nhYNO51yHKeSn9ttfCPhqVkQvCuK4ejE77UuXKajj2QDcXNDGOhUL
         N5pxvnm9l9Pa/0NtHUU4vd8Dkn+627BJPUZnKQ68ljhL7wGFgMsPfD1Hv8i0E1z/IPIy
         5gKWUbTU97BtRkiI8DXYD9TIFtYAyxp3pnQ8fRDKQMSXcaDvb5pR/2AJvoQm78AxDrZj
         hwaD2KB5RZVQphm99njdh1J3SNxR0Q5Z5CxJCHsIhzvu3Zt0Lrv6A8R957SPzj/QcJZN
         9LuA==
X-Gm-Message-State: AOAM532wT2jrqBzDYFNPR/mjVorWNcjpF21PbytVwQxGqKngJE5+xYDV
        Fymw27j/q/s+4a+1S9+Hv+4YtU8PejsWyH3HBVEKkg==
X-Google-Smtp-Source: ABdhPJxBGQnupilQOyf9rrlU6c3WeJG8AAQAuDN8QRcjRs1QutMeyOSeLU0F84axDRQozVZa301nvX7xFaI8KUqhmWw=
X-Received: by 2002:a5b:691:0:b0:64d:ab44:f12e with SMTP id
 j17-20020a5b0691000000b0064dab44f12emr19698207ybq.533.1654432722820; Sun, 05
 Jun 2022 05:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220605065614.1332-1-linmq006@gmail.com>
In-Reply-To: <20220605065614.1332-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 5 Jun 2022 14:38:31 +0200
Message-ID: <CACRpkdZ_9c44Vwg+1tbnnjgT_fr6A=GviKPVNanYm25yscsB5g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btbcm: Fix refcount leak in btbcm_get_board_name
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, Jun 5, 2022 at 8:56 AM Miaoqian Lin <linmq006@gmail.com> wrote:

> of_find_node_by_path() returns a node pointer with refcount incremented,
> we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() in the error path to avoid refcount leak.
>
> Fixes: 63fac3343b99 ("Bluetooth: btbcm: Support per-board firmware variants")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Oops thanks!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

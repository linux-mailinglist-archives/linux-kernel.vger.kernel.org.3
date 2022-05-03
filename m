Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA855180F8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbiECJ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiECJ3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:29:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2605A220C0;
        Tue,  3 May 2022 02:25:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so32278503ejd.9;
        Tue, 03 May 2022 02:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soFnJ41OKBvmqjI8v9ZOzkK4Vn/5GzMNo6xdgyGAsMk=;
        b=o16dMaBBGcP4ajFdeIc4YtDD431tG9UWQgnozHcChAjvt8RBRtHU8BnLOmEknxo6G0
         Q9gbNg7ANq7+BnGKYZf0siuSctCicT302Hrn/G2ZCeiCkvCDPqnmEV5Lvxfb55pXRhg8
         rld0SzvAdBMtfkNyFnfB/N9cBYkrdkgwDFJ2C8+wFhu6TmtgSUVowdOjPytJajfxxwxm
         DBCcdC0RopnL4uHIP4TjZKa76cwSMnsp4VfP4pNZ68UdbCAP3RtO2+h/DwLaoax6HQP6
         1K/VNsIEM8BQ52sGkr4r0mqIoVtklaJzJEQ+rdkU9TQ+Ot+GKJQ0zsnOPEUYJRpjhhYp
         potQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soFnJ41OKBvmqjI8v9ZOzkK4Vn/5GzMNo6xdgyGAsMk=;
        b=ZgpcC90dFK7i0A8uEGQAOqbP5b2ksNGi5b78dZTsZsQttNmYVwnZYiQK9VtmY9ROTe
         wIF6fZpgJt053lR/l2jSEuxpq7vGS/ofysIaib+jndy5iaEUkCFDhKDrXt52h8tu6qA/
         ydMAQPM/u8bKoqBptos5RUjPeunRZIBTd6Bjt/Y6/qHzhrVUyTHsRR6nM7kyO6RAv4nY
         /SWbj18U4pLzoqX4doobmHyMFFJC0uZr/pQAmmuwFtccGzEspH5N4w2cHVcgqUfevSQq
         3eJELsfxrVJJBL4cRhE9JRoy0ArnUCt25591+HC/zAzlMXhxS19TfvA864XRrrNvHD8S
         aXbA==
X-Gm-Message-State: AOAM5334xiudVraM/uXROrbf09LVJpS5Fxe2sgOyvsK/e2FDr/qG10So
        eOrUkkQ+winU+ktOHivAeSGU8LQQTXnY8Ou3paQ=
X-Google-Smtp-Source: ABdhPJxAZtRQdRTR2mVaCYLHKzLeXAneNCOKyhgEZDPmcSKRYED8zMHxs8Q53/lzrisDk/Exxo47f/kwYbJ5LCX627Q=
X-Received: by 2002:a17:907:3e8c:b0:6f4:4fdb:6f24 with SMTP id
 hs12-20020a1709073e8c00b006f44fdb6f24mr8218039ejc.44.1651569929536; Tue, 03
 May 2022 02:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220503080613.27601-1-jslaby@suse.cz> <20220503080613.27601-2-jslaby@suse.cz>
In-Reply-To: <20220503080613.27601-2-jslaby@suse.cz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 May 2022 11:24:53 +0200
Message-ID: <CAHp75VfLw2pYMvaEoF+JuqN+H0wyo7ZfbkpefwtebCkOGVT0QQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] serial: pch: move size check from pop_tx one level up
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 10:12 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> 'count' is zero in the pop_tx()'s comparison against 'size'. So the 'if'
> tries to find out if 'size' is negative or zero and returns in that
> case. But it cannot be negative, due to previous (size < 0) check in the
> caller: handle_tx().
>
> So simply move this check from pop_tx() to handle_tx(). Now it's clear
> that pop_tx() is called only if fifo_size is non-zero.

I'm in favour of the series, but ideally this driver should be
converted to be a part of the 8250 family.

-- 
With Best Regards,
Andy Shevchenko

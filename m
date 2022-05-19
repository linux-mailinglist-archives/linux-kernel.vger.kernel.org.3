Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFDE52D3AE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbiESNOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiESNNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:13:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BBBC6E5B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:13:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kq17so9897200ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABD0ZCZzk6/rDV7fRx/jwgpu1GPtQwsEFN4C6UN6MEo=;
        b=q3grboCQq6GN18wZpshIHKTxPmmbScxb0uN9zgqSQzBNHBnGWd4JhKgVaY5/sT3MID
         1OuA4xXvLa9davt3/26E8OP+x+nad0SFYrj6UWRHt0FAuoOT0arDSj7NFT8/vzMCDY6s
         cENvjNurbAV9y0TJ7h06b9QrNhUrVn3urB5WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABD0ZCZzk6/rDV7fRx/jwgpu1GPtQwsEFN4C6UN6MEo=;
        b=jipQsG1Y1Bdypu1AQXximvLh1B/K6FDswjy0E3eVT7j+jH00AGY7EIyd9W9bcMVqiB
         SBNnJaeMZaLolDRBsuASlwy+2KcaHOQOGt96DGqknpe8A8ptIQWMBRO18lqUNfIyE/D4
         buxguqBpVaySg2UO921deC3GgQS+HWuf8NaYhxrbW/waIozs3M9dY9LamNOxHtY5rGGV
         /z7pHPZ0IvdsKAs4nzjnWOkiBEjrmrwnmIhPO2B6WGdJGGwaengfl3/ayjS2xDs/GR8e
         SbqkatTI8kPFZprXKGogjzaVNadk01JsGPlEI5ikjoMU/nyE+/5c/MW7UjFlZr+EWXyG
         EcTw==
X-Gm-Message-State: AOAM530Z5JoG9LO/6TQzX8ALP7sHmmqT5wkIISG7dWZ2yp917Y2Ol6Z8
        MHq99DZMAeqfWIzRd7YLL13A0Uoq0mMMg97lj/LTTQ==
X-Google-Smtp-Source: ABdhPJxB1NaudJ/GbhumUoLIwywBx8UlXQvhtgTCLbpiR08KfQyoCq62oz080Dkju6g7pJM9SsQSqzfuHaE0n8C9oII=
X-Received: by 2002:a17:906:58d1:b0:6f4:6e61:dae with SMTP id
 e17-20020a17090658d100b006f46e610daemr4231902ejs.468.1652966029810; Thu, 19
 May 2022 06:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220517100744.26849-1-dharamhans87@gmail.com> <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
In-Reply-To: <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 19 May 2022 15:13:38 +0200
Message-ID: <CAJfpegvpdms4QpecBWyu88mpKRcofDFLVtRQbcRs+4RiNoM6Ug@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
To:     Dharmendra Singh <dharamhans87@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2022 at 11:39, Miklos Szeredi <miklos@szeredi.hu> wrote:

> Apparently in all of these cases we are doing at least one request, so
> it would make sense to make them uniform:
>
> [not cached]
>    ->atomic_open()
>       CREATE_EXT
>
> [cached]
>    ->d_revalidate()
>       return 0

Note to self:  invalidating a valid positive dentry would break things.

Revalidation would need to be moved into ->atomic_open(), which is a
bigger surgery.  Oh well...

Thanks,
Miklos

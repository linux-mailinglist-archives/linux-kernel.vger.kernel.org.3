Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30594ACD62
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiBHBFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343617AbiBGXmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:42:52 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327D5C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:42:51 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g8so5895162pfq.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 15:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xL7zYBxlDA9OyfIUt1+hVo3jnzbaDpzhjP+X9npLjjg=;
        b=wphYccQt9nxerxeU/p5xPEp3OdfAMZRtra+QtigCBGV2rEpNVW9+U6vtvsejhTgn8e
         AjHdHHleGcguuyudfB/EYL8nXm+kpV8ZcSykDngC+byWUyRxqjSZ/RPjTH8AXc+RnLns
         uIgVupROuzl/7/rcKGowF45+b0zBguco1bdtkEO3QuTU6AEph9xDvvOseyxx2hOke+gU
         uNJF3+A19rkf9glt328qDrxjnlD9a+5MH5956bLQ7wt6C83PtpfdJpKPQIdDraMVj14L
         rYSrK3ggYTWNdNsRn2y7f5gnAE9dOOC2PJVNruXRQWVHXWccOP1/uFHHzbWsGMDwZaME
         cPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xL7zYBxlDA9OyfIUt1+hVo3jnzbaDpzhjP+X9npLjjg=;
        b=z7ZCPaSLiPly/bTo5huGvmVphLprvGlXELimUpyMh7LJifijQMHuoi038NovCZisKx
         4SAneQaLHwlCl5892BOWPecy0sy332YA0RunVYcv/9QNw5WTO7vQi4NlvqQDdaU7267J
         5qtZD5CBTChjc1yKEFGNQiBl0r9SZztZR6weOmVW39aQf7J1ISNPXT+6E1p9nrFjsCFO
         amNEHmRlx7S0WDQvlmOdaZ+h/RoTyZI7gerda452PW8GVuTfEZfcyeXYieNL6aML9c2O
         hgvqP5frcZb7wd8rEzP8TRmmGr9b8UaAyXB0bYX80Ki7h6u4Nf8zkqtWLk0I+JRetC5t
         +nlg==
X-Gm-Message-State: AOAM532RdaUbsTfzZDkWxUlby+9kREWeNW5z1Hiu50InX+FEwEk0kDGg
        mgYKV5Vs0iPUGJJa6VKrX74Tw2uZtApNzczcYNkPIRYSsjg=
X-Google-Smtp-Source: ABdhPJwrqWzltx/fzSQ9DuX2BTfk2qmQ+rOek9DuscJqYjd5cc23devekMbaCYKV7qKyZJb3bcu/cjHgnw2J/KhyG60=
X-Received: by 2002:a65:484b:: with SMTP id i11mr1385516pgs.40.1644277370737;
 Mon, 07 Feb 2022 15:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de> <20220207063249.1833066-6-hch@lst.de>
In-Reply-To: <20220207063249.1833066-6-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Feb 2022 15:42:39 -0800
Message-ID: <CAPcyv4iP=+jtVgdnuZjR3b-jM27zH5uk167HM=wz+=PBfvA49Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] mm: simplify freeing of devmap managed pages
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, nouveau@lists.freedesktop.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 6, 2022 at 10:33 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Make put_devmap_managed_page return if it took charge of the page
> or not and remove the separate page_is_devmap_managed helper.

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

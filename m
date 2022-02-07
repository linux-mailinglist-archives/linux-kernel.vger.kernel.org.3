Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6761E4AC931
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiBGTIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiBGTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:07:04 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B3C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:07:03 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n32so14609418pfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WVqg4iM1IK5woHe616yKoTPDV85yaqed+lmC/0zx4Q=;
        b=E8Yv+tJ27QtdnqCiahy1ynDTxSrIHFQS9v3T6SGxOtbvrS4oJdOaAbBOu5WkKuOBfd
         YZVQDjXpyCcHf5TePEiE9WLubJVn7pkXJNntqfcUu0FB+cpVUKi2U/fVQ/r2P4FuKOGP
         rrsKex566q7w8weRBoU0ZAbtyAsexA2NArqSSGJ8aSE3asKbO/kySJdCGSVU84OEGUiB
         QCLOFQgtfcBKBXnXRpXprEE7iAtFckobPiWULixyKadweXpHSIl4fOM/cfTnhyD31lEn
         X5EcS76XqYpJKN3mK9thEa6gK63RHYW8pEdrhtUg2qPw6l/cPnln0K7VaxQOTiViReVV
         h7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WVqg4iM1IK5woHe616yKoTPDV85yaqed+lmC/0zx4Q=;
        b=u13TvNZk/6tdfehbS9f2mVelkO0NiPWOyq/fzcjAbTgtGeCjHviXfSlRY5b3LitFgm
         jDUFDv3uLl7GiWIexz68p/fVMTfzXHArmVrhwrXgU7eZG0hDIJellCQFzhFn6idvlDb/
         cpm/LT9YkX0TSejxcMsg0kSPer6EhJAoOvcYVQIAtGsn2w8EyrucFuL8y5xKF52lhVL+
         lt547QKuHxCQULIYhtIkoqAC/ysAgbDoPE4Cv5OnLqst2dxluQPYhSGCQIYqBBV+orvD
         CuV1iLBJ6Yf4zT9tHhmQ+7bMV8VbRw29T2/MKWhBnvmdmw/9nlYGF5uY6P3SWaioD2Y9
         9HVg==
X-Gm-Message-State: AOAM531uzof4Djr4s/x7RDZrIFWwAAZwBLNyI6hq227o1bd7jUjy5jIG
        b+ipIyx8pg0UAotWkcX4fzBLAoeNKf/9ARMzyn7BKw==
X-Google-Smtp-Source: ABdhPJx4gFwHpx6eXlK2M23aHGpthiH4fAIYOpnEcI58LRfZznkCnIjyKeDQJsC3Q3CmCC8lC+fdRuCFIdo+hfnPs1A=
X-Received: by 2002:a62:784b:: with SMTP id t72mr939106pfc.86.1644260822995;
 Mon, 07 Feb 2022 11:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de> <20220207063249.1833066-5-hch@lst.de>
In-Reply-To: <20220207063249.1833066-5-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Feb 2022 11:06:52 -0800
Message-ID: <CAPcyv4ipZUeCjf5teFQuJX5DEs7ViGHW_PKKfoJEK8chjJTZig@mail.gmail.com>
Subject: Re: [PATCH 4/8] mm: move free_devmap_managed_page to memremap.c
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
> free_devmap_managed_page has nothing to do with the code in swap.c,
> move it to live with the rest of the code for devmap handling.
>

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

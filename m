Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7FF4AD2CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348877AbiBHIHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiBHIHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:07:48 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32457C0401EF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:07:45 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id y203so7041969yby.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXxGXqL0fSEKZMDAAFA60E1Rbs/msz2tQymkFw5ax8o=;
        b=qlzWW2qtvfYAAanbEMYNLuRx8ZSraE6ZerXTO+z8zhvTvhhuYlpIgqjAKGiZyn03oe
         dobQls8uADFSdqKk74wWyKhvtGm+6ci7zMlOM/25PMWhbnesE0+5XQtQJ1DQ4BSmrIVR
         KXs5u2kjzPM5yfRm+Agx/SxngcjD9ixaxLZX1vw+RU3PzkOEaYN8IUkGN+VCPNNtWbRa
         OkYOtxUahGsG7+n6hO78zD3yqAbAhOS+2yz1YaW3MqVv7bTnB7WgJxSZvd7dRu/1CoqZ
         ioyre/8Cv4eirgKtPsl7phMdGqzPgirLv2toaU5HewuA29ykBKN/lcY8q2AtU/epI3VH
         FJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXxGXqL0fSEKZMDAAFA60E1Rbs/msz2tQymkFw5ax8o=;
        b=m1lcFTok0nzCCmw5Ev6DvnjVHj3SS8ilEb9Q/7qfYYz37KLRFOQm74bHB5QQoHCdWG
         zykLMd7McamEwcVZKYDK5uuLp+9ExRynOeoAqPKgYVjdGr8IIUe4endTLNZV78NeqjJz
         nn6fznoWHQBDTSv8ghM9e7K6ATX4JiEIl8zE6dPQtTzLFXhAzWXgzKIuHB/bzW8c5fzA
         PdfTe4oCAqFHu3a7n/kL1hQW+hs4nN6KD7ppQOdU+TuR03NY3mi3CArmo/GmNdhDx3JC
         jcN1LSmbFiPZ9XPraqFZyb4+9eDhHow9EsYGoug7uwfqUS7o8sdwQvUH9c5rdLXi9tYq
         LHEA==
X-Gm-Message-State: AOAM533ZHB9zeWOlcFdapF+GTVTkUbl6NbHfLbKtDPanapF4pJIuj+RY
        aaGFPZKgd0YOh/vIQxPEeePVg7ZBlOIp2DNgVDKHXQ==
X-Google-Smtp-Source: ABdhPJxrFiobqvBhVclJNZluCx9G58Pv+JirZ6BIfPGVufYPFT03Bj1OgbKZjqvNPQBBROocQXaDN+k+XywWU2el4os=
X-Received: by 2002:a25:4742:: with SMTP id u63mr3440116yba.523.1644307664507;
 Tue, 08 Feb 2022 00:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de> <20220207063249.1833066-3-hch@lst.de>
In-Reply-To: <20220207063249.1833066-3-hch@lst.de>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 8 Feb 2022 16:07:07 +0800
Message-ID: <CAMZfGtWA3M+ck8WduwxyoDiXpjC1kXs=irVZ1m-SMSREJG17Mg@mail.gmail.com>
Subject: Re: [PATCH 2/8] mm: remove the __KERNEL__ guard from <linux/mm.h>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
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
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, nvdimm@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 2:42 PM Christoph Hellwig <hch@lst.de> wrote:
>
> __KERNEL__ ifdefs don't make sense outside of include/uapi/.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F264AD2C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348829AbiBHIHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348863AbiBHIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:07:15 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C2C03FECD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:07:07 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id m6so47493171ybc.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lrJ/uUGCKgoKFH52TnhTE0iJcbWnNbC2//ZX4wls2Dw=;
        b=kNP/DVt8Qf+7bUY3UT5ZfqP8u/Zt0jSOyRJstDT02WFgtxz0uQpIo4XqdFFTnYfT/M
         F2Df9FQ1s1DpZs0sKfObwDOAAXfKQ7/T2yeAjlKR3i/reWmzZVjWKP3xdxDfOd3jfA7b
         tz5+cjBNS6/V6VXodt+MN/KM9Uxi0esuP7iu1e3jkfmQt4QdsMTpVKtJq5SLYiKaO6wV
         GdLTObr64l6FVPZjPzvdKBJR2Rjj+n9hO45a68l8DCZafC6+U2M4uJdIA6MbLvDKJRJZ
         DYHtfhyDzmb+GdSk9jY5Magnd6SN2eMgQm2n0M1xh1E5HMRa0EDjVN/rUBMFIXJjqzfO
         gYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrJ/uUGCKgoKFH52TnhTE0iJcbWnNbC2//ZX4wls2Dw=;
        b=aVHINfNgMXms4sj3Omj6xWQXQGPuNri5D+rWi6nxW8HwVlb+L88V6wWAhAiKJSoj6T
         AWHpuo0YZbnjPe6jcXK+n0Rb/LcQf0M4jwV/1bSnmjlBKdU2pSZ4F4TanF3Yfks1T2Fy
         XbfMmqZVaJRZRJjd+Kwzo+e9Yn2e1o7tV5X4pTGjqpTkQN7NoeWFb+Xm7UuzD4Y1ZWIS
         5kQdq2pJ4ORsZTgK65jYJbD85e8oYn4sVeLjZAQDfF8I/w7AN7RpaJ3hZvZPviWVBWeK
         Jt6xeplX6zP+tThsP/9Nnj/24+dW0OQUKLoXHWPD6mZ7Xup1nQyKuwEs5fAXHuJZz61q
         l3Rw==
X-Gm-Message-State: AOAM531pUyzFb1bZg4Vl2OrlYDoS9961xMt6JyIwF6Doyn0T7/TsQxvj
        k6suZrxNZP3r2vHEe3WL7BKr94j/NgNQXfUltp+8dA==
X-Google-Smtp-Source: ABdhPJyc0mkGJILuXoiCncxc7dUnInOYzU71tTwuAgOjc/Gz6ioJ07N3R1Qa59huN3y/0lYz2j4xsFCGHPxb7jwVlxY=
X-Received: by 2002:a25:e406:: with SMTP id b6mr3405161ybh.703.1644307626738;
 Tue, 08 Feb 2022 00:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de> <20220207063249.1833066-2-hch@lst.de>
In-Reply-To: <20220207063249.1833066-2-hch@lst.de>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 8 Feb 2022 16:06:30 +0800
Message-ID: <CAMZfGtUfqoaJ7L7rLP2Vdfy_nvr30qppRX-RfTFUh8TeO3ZznA@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: remove a pointless CONFIG_ZONE_DEVICE check in memremap_pages
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

On Mon, Feb 7, 2022 at 2:36 PM Christoph Hellwig <hch@lst.de> wrote:
>
> memremap.c is only built when CONFIG_ZONE_DEVICE is set, so remove
> the superflous extra check.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

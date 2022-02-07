Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6DA4AC845
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiBGSI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344937AbiBGSIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:08:13 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34FAC0401D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:08:12 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u12so4635341plq.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxHF7bigQnfZfNGCQpq6EtXcG8/j6GHHAEIHGHy2fyU=;
        b=W2DDXQJis+1qeQfXY6E/rxnSkSH+QKQccGw4pZqh3cKQQ7Ll28D21ZTANWBpjdTXkB
         +oBg0dRp7zXiF2K9fvNxjOnqLQ0NU4tSCX/uoDUgYXiPcW3lrnrEZ8WrBiPWSBgY4/tx
         9wQBgc3U+/16XX6zr1IGWZp+OTMhC+7AmHWl4HQOtmJdf1TDvqV9PwZseP44xIAvTKTJ
         lY9+rCsDVlGtJn+K+JfRbJQJUoxEyKL8bHmbimQ1ptdoTfcpwUfxMxs8lIMS2tr1n+Up
         0WNvMspuYRbKnLIowW6FPQwT66Mrqlup7UTEmGoUmJqEmINAArubT4xrd5hjAe0QVo24
         gEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxHF7bigQnfZfNGCQpq6EtXcG8/j6GHHAEIHGHy2fyU=;
        b=co/3FWB2EGd01nA5PaQyTRt5r/ASHBFNpfwGOHrgEmE4HvQMIlQagMKudlE8H75Xom
         9IK7FFteqhCm30bzxFwdva22B0fjAGW0wxT8i4/9biYpGcBoSNB4Vy2g7L/aPZP/TdXo
         aNxUBwafM14H3BkH7bl2Dge4IK3H8IgVdvw1ebN1PzHdTzdHvj5U9rS056xpssAEiZjU
         qWOyYu2ymM+N4HrptW9wIGQwuGpcBqjZSsnh+RSx7hl1/IL11MdZwyhEsTzyej5yxSUA
         sUZ0QYcqrzZ0lCG6/uVb4E/vhgeTc2pR/MXceTM0W0WeUU0Z48HfJfrZy3KykZn1cBax
         PbaA==
X-Gm-Message-State: AOAM530Q1Zw59PNFjifFWzdlZ0YnONBUS7j4J77imtpvzOCUlyBi5WKl
        wGQ0zFH7+uKaVKBRQKQucFMPw0uIGzmKlh5mCmKquw==
X-Google-Smtp-Source: ABdhPJxbjfLp1vymzfVN/rUSu7NFfwM27TjFOxcEJErT+R82ivD+XXC3ZWylDTpvE/Ebzm6hUwz4bOsdTAqXcC6BA2A=
X-Received: by 2002:a17:902:ccce:: with SMTP id z14mr815477ple.34.1644257292200;
 Mon, 07 Feb 2022 10:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de> <20220207063249.1833066-2-hch@lst.de>
In-Reply-To: <20220207063249.1833066-2-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 7 Feb 2022 10:08:01 -0800
Message-ID: <CAPcyv4iKLXJftFL+jdAXFXt6-fjwSdK9D2un9PywfXDT0W7HzQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: remove a pointless CONFIG_ZONE_DEVICE check in memremap_pages
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
> memremap.c is only built when CONFIG_ZONE_DEVICE is set, so remove
> the superflous extra check.

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

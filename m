Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E397F484AE1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 23:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiADWoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 17:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbiADWoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:44:20 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173A0C061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:44:20 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q3so29138857pfs.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 14:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNI0FNXnZ92A9rcSSuTMSZWtPK6rcwK+FpLRa43srmk=;
        b=fOsqdC5v/Ljnlv2FEIyia5PEUe1s+e+1DuDDfE7u5MaVA4dXKJQHiE1mRK5iYBVsUJ
         /oowxIHxSAdxALfYzQ8kGvygGPJuCKMOHtF6DiXbqMs/059LnQCgFzEDESiTPsFxFWNn
         7Xesjj8J0CJQX2rv/u96W/GJ5UgdA6Vcv8mkPCkFc6h66hCg6QsUbB+sYNaSz3UzdXUB
         lpIWK+oGnTNcmd+TytJ0U91J0Sv00HD75sq8eRh6giDzO8BfqgCduSAOWJzJitKNXhRW
         Yz6dvrh+hntEc7AjvBGIeEmebsxBEkSVtpsKzv/uaTDYZj1X2da7fQ7LGbcS1ECRAlNl
         1k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNI0FNXnZ92A9rcSSuTMSZWtPK6rcwK+FpLRa43srmk=;
        b=MDSv4xH2Dkp+TShfDiz7JejpxEMuniZAf4mf2d5LPX1qUls45EEHFzZlorTUKQWK6r
         m4D2J3VgUwnSaBowYRUKS/ucmnePVGrEM8AT88g/z8yNklbjcdtpdV9tfltPAjifRCHC
         WvYGspVup4GOQoXLFUeprRNGbGrAOysM8u+HTlc5kDJGdpxikcc3lHWU76fg8vgUeomC
         f9qEBDtpZY09EOfDOGLLbC9BKApVnK/pNrzprOoL1vyjIv6wHRwZZEjDy5A31SMwgs0d
         Em203vpVz/r7InKRn4cTqIgLAOVxrOIfEGzAKrfYD8PS0fSJel6NT3V8q7uamk1IGOT3
         oQqw==
X-Gm-Message-State: AOAM531psh7kmt9euvOxdvLies78n80GnvwRIFRmXUBvGdTYW8qp6+1n
        zp/aqiZZCXgHzaaysX6fI4mys4COSUV8nOLmjua51w==
X-Google-Smtp-Source: ABdhPJyP9Z0MRBW2RS42p0axndXN+7aFakOWJ0+wGPrF9fRJBeJgr0Nw19jdOKV52TidJL0PgD7xQGTpsKPEnebLsUg=
X-Received: by 2002:a63:79c2:: with SMTP id u185mr876468pgc.74.1641336259609;
 Tue, 04 Jan 2022 14:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20211226143439.3985960-1-ruansy.fnst@fujitsu.com> <20211226143439.3985960-2-ruansy.fnst@fujitsu.com>
In-Reply-To: <20211226143439.3985960-2-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 4 Jan 2022 14:44:08 -0800
Message-ID: <CAPcyv4gkxuFRGh57nYrpS8mXo+5j-7=KGNn-gULgLGthZQPo2g@mail.gmail.com>
Subject: Re: [PATCH v9 01/10] dax: Use percpu rwsem for dax_{read,write}_lock()
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 6:35 AM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:
>
> In order to introduce dax holder registration, we need a write lock for
> dax.

As far as I can see, no, a write lock is not needed while the holder
is being registered.

The synchronization that is needed is to make sure that the device
stays live over the registration event, and that any in-flight holder
operations are flushed before the device transitions from live to
dead, and that in turn relates to the live state of the pgmap.

The dax device cannot switch from live to dead without first flushing
all readers, so holding dax_read_lock() over the register holder event
should be sufficient. If you are worried about 2 or more potential
holders colliding at registration time, I would expect that's already
prevented by block device exclusive holder synchronization, but you
could also use cmpxchg and a single pointer to a 'struct dax_holder {
void *holder_data, struct dax_holder_operations *holder_ops }'. If you
are worried about memory_failure triggering while the filesystem is
shutting down it can do a synchronize_srcu(&dax_srcu) if it really
needs to ensure that the notify path is idle after removing the holder
registration.

...are there any cases remaining not covered by the above suggestions?

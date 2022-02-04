Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC22F4A93A4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiBDFcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242596AbiBDFck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:32:40 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F8AC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 21:32:40 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l13so4212258plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 21:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vN8r1693du3PiFHORoF+6XkBaejut5sZwHBBBXAp4b4=;
        b=r5xBUQSBVK4ISHFSXxzu36dJntJrOd3LEYFsnEK/7xZA3g9zfHRU7BCTHBvx1bjTgO
         cfp/4StkgZzEWMH6+H8zE1/o9Prx5Tbajr7iBCm4uZRiYa3RHoqmZrFirUpqfyqklAwG
         /WgF/lds8HCPd96gV717iaR4n533kYGw/+0VwqJVTLNYO/lF3PvM5HRSY9GO4WL5kn3D
         gtofsBL9LRNlbft6Ok6aTyZFUmPKXHfZpL30NqpI5N042jUlMpk1MW1bbD+3KYQQp/o+
         Pb6K9hZGVgjc0zUK+yz3azRQiJHBU2duTLWFfxr7YCDxwtXrcDkUia5Edz1Qeeur7fH0
         1WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vN8r1693du3PiFHORoF+6XkBaejut5sZwHBBBXAp4b4=;
        b=ue54M/9qHMj3M2tCX7Jlkr3Y1zlDVCXSYd8w39J12zgnWxnHnhSqZbQS4YqkQL2aVa
         9Dmzs8jXSBh9HkVVYE779D9tB8qXAw9evk6iBBN0bZ7YkvuCjQlV+2fORMPvTB1P7qXg
         wZMBuwyLIbqFSrCY6naG2ON7R0oMeRKoHCW368vDer4AMKCTSxF8UwEKS+hOZXsEkcf7
         ZxkLQUdyGPdKz3XkJq7TZdZ99gN21i5XOGZ1dU4VrdBHCkwBCTt+or9De3jmH5ZjNQQW
         YItmH6qas5DJwwk+dgYJyE+RD1wKLhSKrMBAg4ZAigONOwIuMXWrkUNb7lmzf71KKdaC
         e4Jg==
X-Gm-Message-State: AOAM531lz2FBjL1gS7iW0izSHeUTRsAF8wAY1k5jQr85o7wr1Myyg+Jy
        vWyx89CCuJuxR9Xt+0mU3n7FyZuZA1NCqd4/jI/yqA==
X-Google-Smtp-Source: ABdhPJy9vypHCuWdO84lJf8sfhFb1AduhbIgpw26gq3zk7IXjR/nY4UR+40JWc/1sOTHJTqjh/dzaGGVoJ8T2er+1UQ=
X-Received: by 2002:a17:90b:3ece:: with SMTP id rm14mr1346519pjb.220.1643952759933;
 Thu, 03 Feb 2022 21:32:39 -0800 (PST)
MIME-Version: 1.0
References: <20220128213150.1333552-1-jane.chu@oracle.com> <20220128213150.1333552-3-jane.chu@oracle.com>
 <YfqFuUsvuUUUWKfu@infradead.org> <45b4a944-1fb1-73e2-b1f8-213e60e27a72@oracle.com>
 <Yfvb6l/8AJJhRXKs@infradead.org> <CAPcyv4i99BhF+JndtanBuOWRc3eh1C=-CyswhvLDeDSeTHSUZw@mail.gmail.com>
In-Reply-To: <CAPcyv4i99BhF+JndtanBuOWRc3eh1C=-CyswhvLDeDSeTHSUZw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Feb 2022 21:32:27 -0800
Message-ID: <CAPcyv4hCf0WpRyNx4vo0_+-w1ABX0cJTyLozPYEqiqR0i_H1_Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] dax: introduce dax device flag DAXDEV_RECOVERY
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jane Chu <jane.chu@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 9:17 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Feb 3, 2022 at 5:43 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Wed, Feb 02, 2022 at 09:27:42PM +0000, Jane Chu wrote:
> > > Yeah, I see.  Would you suggest a way to pass the indication from
> > > dax_iomap_iter to dax_direct_access that the caller intends the
> > > callee to ignore poison in the range because the caller intends
> > > to do recovery_write? We tried adding a flag to dax_direct_access, and
> > > that wasn't liked if I recall.
> >
> > To me a flag seems cleaner than this magic, but let's wait for Dan to
> > chime in.
>
> So back in November I suggested modifying the kaddr, mainly to avoid
> touching all the dax_direct_access() call sites [1]. However, now
> seeing the code and Chrisoph's comment I think this either wants type
> safety (e.g. 'dax_addr_t *'), or just add a new flag. Given both of
> those options involve touching all dax_direct_access() call sites and
> a @flags operation is more extensible if any other scenarios arrive
> lets go ahead and plumb a flag and skip the magic.

Just to be clear we are talking about a flow like:

        flags = 0;
        rc = dax_direct_access(..., &kaddr, flags, ...);
        if (unlikely(rc)) {
                flags |= DAX_RECOVERY;
                dax_direct_access(..., &kaddr, flags, ...);
                return dax_recovery_{read,write}(..., kaddr, ...);
        }
        return copy_{mc_to_iter,from_iter_flushcache}(...);

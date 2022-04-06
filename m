Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F7C4F65A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbiDFQdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbiDFQc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:32:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C201FAA29
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:22:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so1273685pjm.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 18:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GpAHmbeaClOABfDOq4xnFecCsaGHIekoRhkFacwUlXs=;
        b=DTGX679OZ1qKODLoERzJPs9u5x0CQ7BYYUpa2ouElTHNgAKbPpKoCPRTExB81qQ2US
         94dbMKZq/YmOeyWFp2JbpnvKA0jH4iSww8lz1A4p4C92e1wGL/hPVnaXi1g1ADkUAp6P
         RNhUno+35Z8wecDtsPPgH+m4yLNmQXPQLqx3+K7wiP9W7njPgLJqsTd3C7bY0GOn3iL4
         DU1KcaQsM6ar/F3C6nMFoc7ou3I3CvJEUZey03r8p0CmPUzHrg/bmaACtqdejQJ4iant
         V/TCZoYpa1rMEzqemePJkaBICzpAtqcCLdOPBkkwkXyPjciIJJUh7pdnmRJymCr3P0SZ
         hABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GpAHmbeaClOABfDOq4xnFecCsaGHIekoRhkFacwUlXs=;
        b=o/4AdjyKWi3YKrLDoHtZqOOMp0Zaikz1Mr5aimkeD+wRhL/MXrZMT4U5zyOSHBxXRB
         bp3hMyozrW2hB8l+rDX1Tj5aiYg59j+0KblTubzdh3Q4SLWSE9kIrArVR4i+75uNtgsz
         3e68SMGC+0q+KV45zatGDo3FOEyg8rUhsffTxQZ+NWBb3fSog5Z7rGV6gttctBx4fuqf
         mN2T9v5N5kFr9MG+iDSE++WosAypbzuyIW/xuVvUwMXsrf6Wq7QKgmIeWKr0SxJyBvJy
         QErD8grE2t4L2WPyxNtQcfHJx/mDDNIct4EExz0m99pKb/o5hB9ejdt4N/YcgpKr2Dj8
         3YsA==
X-Gm-Message-State: AOAM531FrfTiBN9b1WrvMZS5LQQO3j+0yYt2B+LRAITL1tZ1SXdWRMP2
        g6Bsnp5MOzTlXit5urW8VUSUCeL1N2Y884W3Wvo2H6aIvfU=
X-Google-Smtp-Source: ABdhPJy2l3ev5j2Q7pkZUUiX17H1f2uX0JiaFPO6bc09C7QOxwwhFdxA05PXl7UqsyY9sLkpv+RVessbAtwzpZwLwNA=
X-Received: by 2002:a17:902:d512:b0:156:b23f:ed62 with SMTP id
 b18-20020a170902d51200b00156b23fed62mr6252643plg.147.1649208179456; Tue, 05
 Apr 2022 18:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-2-ruansy.fnst@fujitsu.com> <CAPcyv4jAqV7dZdmGcKrG=f8sYmUXaL7YCQtME6GANywncwd+zg@mail.gmail.com>
 <4fd95f0b-106f-6933-7bc6-9f0890012b53@fujitsu.com> <YkPtptNljNcJc1g/@infradead.org>
 <15a635d6-2069-2af5-15f8-1c0513487a2f@fujitsu.com> <YkQtOO/Z3SZ2Pksg@infradead.org>
 <4ed8baf7-7eb9-71e5-58ea-7c73b7e5bb73@fujitsu.com> <YkR8CUdkScEjMte2@infradead.org>
 <20220330161812.GA27649@magnolia> <fd37cde6-318a-9faf-9bff-70bb8e5d3241@oracle.com>
In-Reply-To: <fd37cde6-318a-9faf-9bff-70bb8e5d3241@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 5 Apr 2022 18:22:48 -0700
Message-ID: <CAPcyv4gqBmGCQM_u40cR6GVror6NjhxV5Xd7pdHedE2kHwueoQ@mail.gmail.com>
Subject: Re: [PATCH v11 1/8] dax: Introduce holder for dax_device
To:     Jane Chu <jane.chu@oracle.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 5:55 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> On 3/30/2022 9:18 AM, Darrick J. Wong wrote:
> > On Wed, Mar 30, 2022 at 08:49:29AM -0700, Christoph Hellwig wrote:
> >> On Wed, Mar 30, 2022 at 06:58:21PM +0800, Shiyang Ruan wrote:
> >>> As the code I pasted before, pmem driver will subtract its ->data_offset,
> >>> which is byte-based. And the filesystem who implements ->notify_failure()
> >>> will calculate the offset in unit of byte again.
> >>>
> >>> So, leave its function signature byte-based, to avoid repeated conversions.
> >>
> >> I'm actually fine either way, so I'll wait for Dan to comment.
> >
> > FWIW I'd convinced myself that the reason for using byte units is to
> > make it possible to reduce the pmem failure blast radius to subpage
> > units... but then I've also been distracted for months. :/
> >
>
> Yes, thanks Darrick!  I recall that.
> Maybe just add a comment about why byte unit is used?

I think we start with page failure notification and then figure out
how to get finer grained through the dax interface in follow-on
changes. Otherwise, for finer grained error handling support,
memory_failure() would also need to be converted to stop upcasting
cache-line granularity to page granularity failures. The native MCE
notification communicates a 'struct mce' that can be in terms of
sub-page bytes, but the memory management implications are all page
based. I assume the FS implications are all FS-block-size based?

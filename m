Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B2C4CFFB6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242042AbiCGNOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbiCGNOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:14:12 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C7986E2E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:13:17 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id f38so30850763ybi.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FTOQLkPABjgFHbcpYh08NxXX3AnkIW8zDVxaxnJ63AA=;
        b=DcLYhdXta5yl8UjuFS/qcxIrxj4lqv9WyXc3/4S1ZfTA8qudVdOqOdtdNpJMh1qdof
         Z5ftjB+ehud2ofGMkDW6hVsPdsxvCOjZ/KA7pgDY12xY9Oigd3KsPHKfESy263khNi7/
         XVKs1s6U/dLC+N61e2D5BZGBGx38mYU78J6V/0KQWEi+JdAieZAqV8rGuOdc22jnqUxZ
         XD0z6sLwo5GMK0UpVzOw9JRI8LRLKdE/xG/nToRr22qZJ+M/LCUp/uWvZi0I1J4P1jdT
         wIKiJNWDrecTVLsOGttHwnSdbKob/edeHZbo6T5d6s517KcS2oA6GUQVQ0KrfyVuJjAy
         FFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FTOQLkPABjgFHbcpYh08NxXX3AnkIW8zDVxaxnJ63AA=;
        b=WdRikxgyxIvKHI+tDkDx7965KAge6hcDroTj+goie8eBfNkUvbYTzmTMf3jrIbv3K4
         7PKU0cq9spy9GCrS+/3GPbffrAK7TXKKH5u2zMT6Jp041zZL1caPJBkkjrTuoRVQ3bHU
         vZ493NihXrP1a9nchM7HAX2DcBcBseEXoyYbRt3WzzAGUG9cjky5DkC9lCsL5+FlPcuT
         E4I/ttqQhIn+cXD+PKGaXBtLuzFJsyeG15qDoZVmqJOiRABxelx95S2zHlc3GRRwSgt5
         GbkcMV3lGcjLqut3Giyu3dNP8+byWCKAyvpnZjl94iCHoC/5zLISHh0NALJZwRe6jFYL
         9+XQ==
X-Gm-Message-State: AOAM532lStdYS/OPj2DusY6SSbKqeP8qLHPKZtfhbOVVJV4IgD180CzJ
        93TdcagDlzPBd7z2crEVAOdUhk2azMJv0EU7VOEiNLYv8ERCITCq
X-Google-Smtp-Source: ABdhPJzwr0HyjzESewd0ZLqGIIXTOlieb/gEYoK49h1Rd5QKtQQsd809tOBlz8U2SyCY5D/c2nGkNyO3lxaUCXyAKDk=
X-Received: by 2002:a25:e0c7:0:b0:629:182a:4b75 with SMTP id
 x190-20020a25e0c7000000b00629182a4b75mr7234257ybg.539.1646658796453; Mon, 07
 Mar 2022 05:13:16 -0800 (PST)
MIME-Version: 1.0
References: <CAOtvUMeoYcVm7OQdqXd1V5iPSXW_BkVxx6TA6nF7zTLVeHe0Ww@mail.gmail.com>
 <CAOtvUMfy1fF35B2sfbOMui8n9Q4iCke9rgn5TiYMUMjd8gqHsA@mail.gmail.com>
 <YhKV55t90HWm6bhv@Red> <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red> <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red> <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
 <CAOtvUMePFR4e2jgHZKOvs3J3Xt4NzRbzD_=vr_49Qgs5HTrvHw@mail.gmail.com>
 <6cf91f43-df23-3ac9-e9b5-958d99d37422@arm.com> <CAOtvUMedqSNKx9Aah0R_aAyjKO0pn4K75MrCnbh_zX+Zw9vRQA@mail.gmail.com>
 <371ef3f2-883d-91ab-ed96-da8921efb465@arm.com>
In-Reply-To: <371ef3f2-883d-91ab-ed96-da8921efb465@arm.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Mon, 7 Mar 2022 15:13:05 +0200
Message-ID: <CAOtvUMcp8X9Zex9QE3qz5mKVR9MC3kdUymO1oXVdUc=k1NcwXA@mail.gmail.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen =
 authsize =0
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 3:03 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-03-07 12:47, Gilad Ben-Yossef wrote:
> > On Mon, Mar 7, 2022 at 2:36 PM Robin Murphy <robin.murphy@arm.com> wrot=
e:
> >>
> >> On 2022-03-07 12:17, Gilad Ben-Yossef wrote:
> >>> On Mon, Mar 7, 2022 at 1:14 PM Robin Murphy <robin.murphy@arm.com> wr=
ote:
> >>>
> >>>> The "overlap" is in the sense of having more than one mapping within=
 the
> >>>> same cacheline:
> >>>>
> >>>> [  142.458120] DMA-API: add_dma_entry start P=3Dba79f200 N=3Dba79f
> >>>> D=3Dba79f200 L=3D10 DMA_FROM_DEVICE attrs=3D0
> >>>> [  142.458156] DMA-API: add_dma_entry start P=3D445dc010 N=3D445dc
> >>>> D=3D445dc010 L=3D10 DMA_TO_DEVICE attrs=3D0
> >>>> [  142.458178] sun8i-ss 1c15000.crypto: SRC 0/1/1 445dc000 len=3D16 =
bi=3D0
> >>>> [  142.458215] sun8i-ss 1c15000.crypto: DST 0/1/1 ba79f200 len=3D16 =
bi=3D0
> >>>> [  142.458234] DMA-API: add_dma_entry start P=3Dba79f210 N=3Dba79f
> >>>> D=3Dba79f210 L=3D10 DMA_FROM_DEVICE attrs=3D0
> >>>>
> >>>> This actually illustrates exactly the reason why this is unsupportab=
le.
> >>>> ba79f200 is mapped for DMA_FROM_DEVICE, therefore subsequently mappi=
ng
> >>>> ba79f210 for DMA_TO_DEVICE may cause the cacheline covering the rang=
e
> >>>> ba79f200-ba79f23f to be written back over the top of data that the
> >>>> device has already started to write to memory. Hello data corruption=
.
> >>>>
> >>>> Separate DMA mappings should be from separate memory allocations,
> >>>> respecting ARCH_DMA_MINALIGN.
> >>>
> >>> hmm... I know I'm missing something here, but how does this align wit=
h
> >>> the following from active_cacheline_insert() in kernel/dma/debug.c ?
> >>>
> >>>           /* If the device is not writing memory then we don't have a=
ny
> >>>            * concerns about the cpu consuming stale data.  This mitig=
ates
> >>>            * legitimate usages of overlapping mappings.
> >>>            */
> >>>           if (entry->direction =3D=3D DMA_TO_DEVICE)
> >>>                   return 0;
> >>
> >> It's OK to have multiple mappings that are *all* DMA_TO_DEVICE, which
> >> looks to be the case that this check was intended to allow. However I
> >> think you're right that it should still actually check for conflicting
> >> directions between the new entry and any existing ones, otherwise it
> >> ends up a bit too lenient.
> >>
> >> Cheers,
> >> Robin.
> >
> > I understand what you are saying about why checking for conflicting
> > directions may be a good thing, but given that the code is as it is
> > right now, how are we seeing the warning for two mapping that one of
> > them is DMA_TO_DEVICE?
>
> Because it's the second one that isn't. The warning is triggered by
> adding the DMA_FROM_DEVICE entry, which *is* checked, and finds the
> DMA_TO_DEVICE entry already present. What's not great is that if those
> two mappings happened to be made in the opposite order then it would be
> missed entirely.

Please accept my sincere apologies if I'm being daft , but here is the
code for add_dma_entry():

static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attr=
s)
{
        struct hash_bucket *bucket;
        unsigned long flags;
        int rc;

        bucket =3D get_hash_bucket(entry, &flags);
        hash_bucket_add(bucket, entry);
        put_hash_bucket(bucket, flags);

        rc =3D active_cacheline_insert(entry);
        if (rc =3D=3D -ENOMEM) {
                pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
                global_disable =3D true;
        } else if (rc =3D=3D -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) =
{
                err_printk(entry->dev, entry,
                        "cacheline tracking EEXIST, overlapping
mappings aren't supported\n");
        }
}

Clearly we get to active_cacheline_insert() unconditionally.

Here is the code of active_cacheline_insert():

static int active_cacheline_insert(struct dma_debug_entry *entry)
{
        phys_addr_t cln =3D to_cacheline_number(entry);
        unsigned long flags;
        int rc;

        /* If the device is not writing memory then we don't have any
         * concerns about the cpu consuming stale data.  This mitigates
         * legitimate usages of overlapping mappings.
         */
        if (entry->direction =3D=3D DMA_TO_DEVICE)
                return 0;

        spin_lock_irqsave(&radix_lock, flags);
        rc =3D radix_tree_insert(&dma_active_cacheline, cln, entry);
        if (rc =3D=3D -EEXIST)
                active_cacheline_inc_overlap(cln);
        spin_unlock_irqrestore(&radix_lock, flags);

        return rc;
}

Clearly the check for direction happens BEFORE we ever attempt to add
the cacheline tracking data.

So it shouldn't matter at all which is first and which is second... :-(

I know I'm missing something. But what?

Thanks,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA05956F0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiHPJrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiHPJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:46:37 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69979A994
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:26:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p14-20020a17090a74ce00b001f4d04492faso8951396pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 01:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=dRB3ek2IpNC0KMnCzrclpPy72oUpKT4lQZi90BQ6jjg=;
        b=QJFyPrueNhZii7jHqZS60xLm2PgDusxYNWy+cySSKI3fXmsDG3G5JXPgZkPhn/6HY1
         pZgM3RycunhesOwm+3sEdwmXfpmfCiGBXxfZoNcGqMpdiSEa0QdTleulp5w/FGFb/xQ0
         Dfox8I3yRlhSyobXzDNQkF7RcbrOJEFWOY3o4/EbNo2yUGsuO0FNA+MOYampfHkS8Wip
         Fip69USX/7G9JkKWbsdxyGv3IlcNY5VozJ8qGBeJkbBTN70GHu1lYcX0p6zIC9ed8+fv
         tQ1mcJ98Afw95XG0qtzmoUL3/OqyDSaNdIbfqff//onYfcI+5XHKnHzfNADR/vf2b+ki
         UeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=dRB3ek2IpNC0KMnCzrclpPy72oUpKT4lQZi90BQ6jjg=;
        b=w3Scxk9nH+qbgnNOM6VfOpodjZ0pclFdaLvgEXwAVqOVycgm4pq7ePKvH9CIlvxcuz
         uyxRzuYfMrodutbL0op4zIu7sKgjuN2HUiB625AAQ2FmI5xc7rnmVW0nOTe2E8bLuScC
         LfbUMLfXtuA7f0ax//S2RfE03T/kU8Lf2P1GgnNU2lAn41L9zEGc56JsmLDsvPrn5MyD
         c70PypORNIES7un3YDOM1NVnY0gQgL/3j8UcMqFHmiLuiDA73BkSBq0PrjDIlxpolOjL
         0QmmHzxq5E+HoMU3cTP0zAnLjn/n/+fTgSikczZyJ0wfL7z2XVwemwQL5pnXRpz3KtNx
         F/ng==
X-Gm-Message-State: ACgBeo2d67FfXGShbGRZU2KXwgsxuHvQA9604QzHX2WHeEDM00Tr8yuv
        gVQCX1tziIf23sGLEwXsGgYP8IP5LBX4zkbPo2g=
X-Google-Smtp-Source: AA6agR6XkfYmfBwjv/IdordNIWylrsd5Y89YxpRHhuQFNJZLhdsj+xDFduk4v11d5WmXI0Ztk31LBOPt/YWg/uNJKm8=
X-Received: by 2002:a17:90b:190b:b0:1fa:a374:f563 with SMTP id
 mp11-20020a17090b190b00b001faa374f563mr546676pjb.52.1660638376362; Tue, 16
 Aug 2022 01:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
 <20220812055710.357820-5-aneesh.kumar@linux.ibm.com> <87wnbacjsh.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <cd1c13ee-6fc3-bde8-96f9-8c3c93441275@linux.ibm.com> <CAC=cRTMZZ9bqyC7pnxD1zUWqfBiQ9U7im+8EYa_8GVK8iA7HXQ@mail.gmail.com>
 <e5fbaf30-1f97-63de-a9a5-2ae5359120ff@amd.com>
In-Reply-To: <e5fbaf30-1f97-63de-a9a5-2ae5359120ff@amd.com>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Tue, 16 Aug 2022 16:26:02 +0800
Message-ID: <CAC=cRTO=+zdKGHRMLpzg2PfJ2rPSQL+xoqA5sAkafaaTYHPr+w@mail.gmail.com>
Subject: Re: [PATCH v14 04/10] mm/demotion/dax/kmem: Set node's abstract
 distance to MEMTIER_DEFAULT_DAX_ADISTANCE
To:     Bharata B Rao <bharata@amd.com>
Cc:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 4:12 PM Bharata B Rao <bharata@amd.com> wrote:
>
> On 8/16/2022 12:58 PM, huang ying wrote:
> > On Tue, Aug 16, 2022 at 1:10 PM Aneesh Kumar K V
> > <aneesh.kumar@linux.ibm.com> wrote:
> >>
> >> On 8/15/22 8:09 AM, Huang, Ying wrote:
> >>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> >>>
> >
> > [snip]
> >
> >>>>
> >>>> +/*
> >>>> + * Default abstract distance assigned to the NUMA node onlined
> >>>> + * by DAX/kmem if the low level platform driver didn't initialize
> >>>> + * one for this NUMA node.
> >>>> + */
> >>>> +#define MEMTIER_DEFAULT_DAX_ADISTANCE       (MEMTIER_ADISTANCE_DRAM=
 * 2)
> >>>
> >>> If my understanding were correct, this is targeting Optane DCPMM for
> >>> now.  The measured results in the following paper is,
> >>>
> >>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fa=
rxiv.org%2Fpdf%2F2002.06018.pdf&amp;data=3D05%7C01%7Cbharata%40amd.com%7C1c=
5015b55ff849e5275408da7f58e67d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637962317187856589%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l=
uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DSxSC8WaKEeT=
yfZXoqtI%2FZAoBXXp82PnTeyyavrV%2FGGg%3D&amp;reserved=3D0
> >>>
> >>> Section: 2.1 Read/Write Latencies
> >>>
> >>> "
> >>> For read access, the latency of DCPMM was 400.1% higher than that of
> >>> DRAM. For write access, it was 407.1% higher.
> >>> "
> >>>
> >>> Section: 2.2 Read/Write Bandwidths
> >>>
> >>> "
> >>> For read access, the throughput of DCPMM was 37.1% of DRAM. For write
> >>> access, it was 7.8%
> >>> "
> >>>
> >>> According to the above data, I think the MEMTIER_DEFAULT_DAX_ADISTANC=
E
> >>> can be "5 * MEMTIER_ADISTANCE_DRAM".
> >>>
> >>
> >> If we look at mapping every 100% increase in latency as a memory tier,=
 we essentially
> >> will have 4 memory tier here. Each memory tier is covering a range of =
abstract distance 128.
> >> which makes a total adistance increase from MEMTIER_ADISTANCE_DRAM by =
512. This puts
> >> DEFAULT_DAX_DISTANCE at 1024 or  MEMTIER_ADISTANCE_DRAM * 2
> >
> > If my understanding were correct, you are suggesting to use a kind of
> > logarithmic mapping from latency to abstract distance?  That is,
> >
> >   abstract_distance =3D log2(latency)
> >
> > While I am suggesting to use a kind of linear mapping from latency to
> > abstract distance.  That is,
> >
> >   abstract_distance =3D C * latency
> >
> > I think that linear mapping is easy to understand.
> >
> > Are there some good reasons to use logarithmic mapping?
>
> Also, what is the recommendation for using bandwidth measure which
> may be available from HMAT for CXL memory? How is bandwidth going
> to influence the abstract distance?

This is a good question.

Per my understanding, latency stands for idle latency by default.  But
in practice, the latency under some reasonable memory accessing
throughput is the "real" latency.  So the memory with lower bandwidth
should have a larger abstract distance than the memory with higher
bandwidth even if the idle latency is the same.  But I don't have a
perfect formula to combine idle latency and bandwidth into abstract
distance.  One possibility is to increase abstract distance if the
bandwidth of the memory is much lower than that of DRAM.

Best Regards,
Huang, Ying

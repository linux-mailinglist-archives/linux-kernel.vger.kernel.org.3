Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297BA5608C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiF2SLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiF2SLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:11:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D761C128
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:11:45 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id n1so23647006wrg.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKWWlQLOEb5CNhiWUSoPZ3c2KB23CiF89xYNjZt498Y=;
        b=hEzhln9y815dHz1vopcSdH6UgxjBQ26JMPrFOd0r0Zu7E85XmpX1Fgaq9jLqTdvA2A
         ugy4WoiHPI4PV1sZUEOJdIEE/5egU2gw0CQ9o5RICcrt/Qnb0UGZsKA+XkRV+kMguTLP
         XBEHP3+DdBmGEkZgDdNq+ap/hV7AQN6yT85mfawcMdKC3fupwE4J8wrg+V9qpPmcTgCD
         /TPvzIT2ORoWtHUpGKXY4RYVFCLM3ObAm1nIIUMbRC7HICkIffkc/sB0Potd2qiCEPcd
         x5Agw+5CcwkMv49GJwcU7KzsCbTEo/r7kiFakoN7nfHQvW+XZo3NDEHtFvSx/aL4zkwZ
         Wz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKWWlQLOEb5CNhiWUSoPZ3c2KB23CiF89xYNjZt498Y=;
        b=Z0O+ka1RuPD8akHl8UzzXWtBkz5auX9ldR97RZkXFRbsaEw9/wmJZu9BmLiUAKjoac
         V9MVonnga15IXi9kQS/C7PRf+5mDSaU8DsMp4g3a5rahY3cHy4R/6lAk9N954nLmkun4
         GeQSaKAWyae7pVfc7FKFv12IWkckkt3bNG8pcQyqeu3Ipd/LPLCEbBKkj7t81U4yog/n
         l1OACK0YFBfyk0H6emOI2/QiBXL7++7ALUyNsnHHh6iiGVHCYOe4Pl7XdtJhmSFltLPK
         kIvkstw4HF3PcAMMDq0/HqYTx+4FPAilRSpbSQH9KCR0YNWUef6Sfvxj9F6zZLC/I3Tf
         mZjw==
X-Gm-Message-State: AJIora9T51SHylnG1V2dTsu0rqiSE+tGDRCmlAt5NiToGMYb5MCLdrnC
        7wG0gjcCb31fwIrtq+IJQkcl5vNUDYKUlcWsKNGuRA==
X-Google-Smtp-Source: AGRyM1vH0mBEB9/AnxmPjR6pGfw0AEo6P2RAWOMhI9osqKlFGZXF67K7ExbW3VDb03ij4M6fTLPKIm/I3lVrqC03Jg4=
X-Received: by 2002:a5d:5983:0:b0:21b:b7cb:f84e with SMTP id
 n3-20020a5d5983000000b0021bb7cbf84emr4599496wri.654.1656526304117; Wed, 29
 Jun 2022 11:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220627025744.106527-1-irogers@google.com> <20220627025744.106527-3-irogers@google.com>
 <26fb5fec-500d-61c2-f009-556c5f7e86e6@huawei.com>
In-Reply-To: <26fb5fec-500d-61c2-f009-556c5f7e86e6@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jun 2022 11:11:31 -0700
Message-ID: <CAP-5=fXRnPoFZgaTSW5jyh5pcnUyHsMUZHzm9_RsDZpjaK=eyA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] perf jevents: Add python converter script
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <rogers.email@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 9:56 AM John Garry <john.garry@huawei.com> wrote:
>
> On 27/06/2022 03:57, Ian Rogers wrote:
> > +
> > +    def unit_to_pmu(unit: str) -> str:
> > +      """Convert a JSON Unit to Linux PMU name."""
> > +      if not unit:
> > +        return None
> > +      # Comment brought over from jevents.c:
> > +      # it's not realistic to keep adding these, we need something more scalable ...
>
> Since we're converting to python it might be a good idea to consider
> this - ever have an ideas on something better?

I think it is something ripe for cleanup, no particular thoughts on
this case. I'd like to make it so that jevents/pmu-events is aligned
with sysfs, which this relates to.

Thanks,
Ian

> Thanks,
> John
>
> > +      table = {
> > +          'CBO': 'uncore_cbox',
> > +          'QPI LL': 'uncore_qpi',
> > +          'SBO': 'uncore_sbox',
> > +          'iMPH-U': 'uncore_arb',
> > +          'CPU-M-CF': 'cpum_cf',
> > +          'CPU-M-SF': 'cpum_sf',
> > +          'UPI LL': 'uncore_upi',
> > +          'hisi_sicl,cpa': 'hisi_sicl,cpa',
> > +          'hisi_sccl,ddrc': 'hisi_sccl,ddrc',
> > +          'hisi_sccl,hha': 'hisi_sccl,hha',
> > +          'hisi_sccl,l3c': 'hisi_sccl,l3c',
> > +          'imx8_ddr': 'imx8_ddr',
> > +          'L3PMC': 'amd_l3',
> > +          'DFPMC': 'amd_df',
> > +          'cpu_core': 'cpu_core',
> > +          'cpu_atom': 'cpu_atom',
> > +      }
> > +      return table[unit] if unit in table else f'uncore_{unit.lower()}'
> > +
>

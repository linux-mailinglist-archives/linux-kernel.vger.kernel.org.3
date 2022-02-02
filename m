Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134884A7958
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347080AbiBBUZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241602AbiBBUZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:25:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC657C06173D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 12:25:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h7so755964wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 12:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXeP2Asa6VI1ijTa5MWMcKtJdHOeMnzXpwkKO33H770=;
        b=koWvksRitFj2vGJ5d7RelHWGlX6Y0rANFHa7Dg1AAvxz1rjhFn76MZz/Kca0zbvzTU
         WYNLJiTClaxCCNcUJcjWIq/4bYofYfdrKQY6Ln+jvpNnQJWOD+ZWddQZqxRuAYrVeSak
         W1uE0cBi9yS7FARYn1mdEhD4R9WfPSs2iWxv89QXYh0MUVaSDVi7wYaDO8GeJZWC6VLU
         4RTUIV5JD8jSM7Txnv0uklwZB/vu84o2lEgAI6ekPsxFZnLVs2lKs+lq5GOczafiUzNk
         x30XeW07wUgX/N4SJqCV02O6MqJ82N1xKd77ZQlT/4LHPHKTA4cOud0G2vB4G3D/c1/C
         JBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXeP2Asa6VI1ijTa5MWMcKtJdHOeMnzXpwkKO33H770=;
        b=3srcLVuUQxZ9V3BM3M9jUcaC0FaBlUClPUi4fq9cJqSlhjNf3LpqiGAcisfKBTt1h5
         eMJ2knWiJYwpZRTml8oAaPPH8/kNH2VunZgO5q9Q9poOlyZr5UGwl3KSh6aGb/0+IfvL
         8HVSkTk2CtMNAgtopDTT+/SGFd2uuhw1ALY4YinZUc48ushs0Wb9J+F6POav3Q2Ff35C
         KjxIoyycZohJ66ZPu5/z4ULslElb4FbTJDMK15fXRA2oBPJNn7tIlTcUKxhPK6zfSEMp
         vSB01x5p/HPkPVutEgQ9s2nt4XiV8jROCwGgHu/ynAwEt32aG3eKfdrCKXm7qYUsvgnF
         M4lg==
X-Gm-Message-State: AOAM532PsXIt1cP2C+qe5eXoVowfcXwyZL7t2It0Hoto0bzsY2Drq96X
        HgggHiUaB8YNdzx7VMe4ZiA8WkA72j0D06QLwkOzHA==
X-Google-Smtp-Source: ABdhPJyXr8CUHRxVbt5x0P8wajOLbHpUjLXq8yp3MW+H/JZlVC9MMHYaeCn4VpdhIAdBedzD/IpE6KguYHg90sGMonw=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr18766986wrs.111.1643833531033;
 Wed, 02 Feb 2022 12:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20220113091056.1297982-1-james.clark@arm.com> <20220113091056.1297982-2-james.clark@arm.com>
 <b3545a88-4743-db95-4676-b0b193cbea78@arm.com>
In-Reply-To: <b3545a88-4743-db95-4676-b0b193cbea78@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 2 Feb 2022 20:25:20 +0000
Message-ID: <CAJ9a7Vi584BcY49TaRn5CJT=wcpafMf-3cA0R+sZ54p6iUKmeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] coresight: Add config flag to enable branch broadcast
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <James.Clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James, Suzuki

On Fri, 28 Jan 2022 at 11:19, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 13/01/2022 09:10, James Clark wrote:
> > When enabled, all taken branch addresses are output, even if the branch
> > was because of a direct branch instruction. This enables reconstruction
> > of the program flow without having access to the memory image of the
> > code being executed.
> >
> > Use bit 8 for the config option which would be the correct bit for
> > programming ETMv3. Although branch broadcast can't be enabled on ETMv3
> > because it's not in the define ETM3X_SUPPORTED_OPTIONS, using the
> > correct bit might help prevent future collisions or allow it to be
> > enabled if needed.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm-perf.c   |  2 ++
> >   drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 ++++++++++
> >   include/linux/coresight-pmu.h                      |  2 ++
> >   3 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index c039b6ae206f..43bbd5dc3d3b 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -52,6 +52,7 @@ static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
> >    * The PMU formats were orignally for ETMv3.5/PTM's ETMCR 'config';
> >    * now take them as general formats and apply on all ETMs.
> >    */
> > +PMU_FORMAT_ATTR(branch_broadcast, "config:"__stringify(ETM_OPT_BRANCH_BROADCAST));
> >   PMU_FORMAT_ATTR(cycacc,             "config:" __stringify(ETM_OPT_CYCACC));
> >   /* contextid1 enables tracing CONTEXTIDR_EL1 for ETMv4 */
> >   PMU_FORMAT_ATTR(contextid1, "config:" __stringify(ETM_OPT_CTXTID));
> > @@ -97,6 +98,7 @@ static struct attribute *etm_config_formats_attr[] = {
> >       &format_attr_sinkid.attr,
> >       &format_attr_preset.attr,
> >       &format_attr_configid.attr,
> > +     &format_attr_branch_broadcast.attr,
>
> Does it make sense to hide the option if the bb is not supported ? I
> guess it will be tricky as we don't track the common feature set. So,
> that said...
>
> >       NULL,
> >   };
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index bf18128cf5de..04669ecc0efa 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -692,6 +692,16 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
> >               ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
> >       }
> >
> > +     /* branch broadcast - enable if selected and supported */
> > +     if (attr->config & BIT(ETM_OPT_BRANCH_BROADCAST)) {
> > +             if (!drvdata->trcbb) {
> > +                     ret = -EINVAL;
>
> Should we fail here ? We could simply ignore this and generate the trace
> normally. This would work on a big.LITTLE system with one set missing
> the branch broadcast, while the others support.
>
> Mike,
>
> Does this affect the trace decoding ? As such the OpenCSD should be able
> to decode the packets as they appear in the stream. Correct ?
>

Depends on what you mean by affect the trace decoding!
From the simplest perspective - no - there is no issue as the packets
will be decode as seen. THE decoder does not know that BB exists - nor
if it is enabled.

However, the reason that a user may engage BB is that the code is in
some way self modifying - so that following the code static image and
calculating addresses will result in a different path taken.

e.g. imagine an opcode:-

B <address0>

Without BB, this will trace as a single E atom, the decoder will
calculate address0 from the opcode in the static image and continue
from there as the next trace address.

Now look at the case where this is changed on the fly to

B <address1>

With BB, This will trace to
E
TGT_ADDR<address1>

The decoder will initially  extract address0 from the static image,
but the immediately following target address packet will alter the
next address traced to address1
This is why we have BB.

 So if the user has a reason to engage BB - we should really fail if
it is not present - as the outcome of the trace can be affected.

> Suzuki
>
>
> > +                     goto out;
> > +             } else {
> > +                     config->cfg |= BIT(ETM4_CFG_BIT_BB);
> > +             }
> > +     }
> > +
> >   out:
> >       return ret;
> >   }
> > diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> > index 4ac5c081af93..6c2fd6cc5a98 100644
> > --- a/include/linux/coresight-pmu.h
> > +++ b/include/linux/coresight-pmu.h
> > @@ -18,6 +18,7 @@
> >    * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
> >    * directly use below macros as config bits.
> >    */
> > +#define ETM_OPT_BRANCH_BROADCAST 8
> >   #define ETM_OPT_CYCACC              12
> >   #define ETM_OPT_CTXTID              14
> >   #define ETM_OPT_CTXTID2             15
> > @@ -25,6 +26,7 @@
> >   #define ETM_OPT_RETSTK              29
> >
> >   /* ETMv4 CONFIGR programming bits for the ETM OPTs */
> > +#define ETM4_CFG_BIT_BB         3
> >   #define ETM4_CFG_BIT_CYCACC 4
> >   #define ETM4_CFG_BIT_CTXTID 6
> >   #define ETM4_CFG_BIT_VMID   7
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

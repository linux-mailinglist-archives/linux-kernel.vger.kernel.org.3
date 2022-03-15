Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE2F4D91D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbiCOBAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiCOBAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:00:20 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7E12613E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:59:09 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e186so34280219ybc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikYhV7JTpMGbcJ3HAQYCBxOfCzMhRoKXLswTSf9Y5sU=;
        b=QJhi4LghX9e5JTgeh3z84BoLvpiFqJs4JOHdBLuVtbvYeISjglHa+vSa6RmNwOmkcl
         2nFD1eIgx/Pkypz183cJWU+P7aLNA3kBS0vilsyPJBSw2n2LL4L4LCVTLImPhiQikuhb
         PoR+IjN1U8ToLEx0OQPzOb7zaUpMZjFSnZKaS3Qp2lw69Jk9DlXnbafY9AGHV07l2x13
         mgwT5uddh/UNH11rYbpj58NL8oV1Itcqo5sv3v3hqp1ih1xGzHjPUuQgrNmwwhKGZK6u
         9LWXb88sLIHpBZghwBj7nNJBEv2U0oV6XrAUPCAbyRnhciNJvafF0Hd2VnzX8xKMaoRP
         f7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikYhV7JTpMGbcJ3HAQYCBxOfCzMhRoKXLswTSf9Y5sU=;
        b=HiCq3PBYkA/FddwGInIb3fx57IffQY7sDH6TERgXpB5SKviE113rHSQ1F3QTfM8LRy
         NenNQ1fX87SaIV52v54mJqDakHAL04Be7Nj7gHhxDg2Vvpq/jGAhlI3o7avZbaT2w00Y
         vuhXd6ZGhMJUkqlk8s/xxd5emJLSLT5+olYpENSQKofRUKH7pfmipbTdrKMRxzXStp1E
         3za6Wdcebr9lvzByWCUpWC4Rbdox2Y1ypTWeM9vWMMsqcUgDMVUTuRxHK+OrS5D+W4t/
         cFZYg/F5TnFy4P4YFq5GVO1tjDF7Ds6KnHmZ0jtU75R5Lv8k0cd9EivrA4RFjenqGNsc
         vNHQ==
X-Gm-Message-State: AOAM532w3WmBiRXOP1s8xQvXqhYeN5a+Yr1JS4+fqg+nW2ZN1/GUoAYU
        cFFDHL/jK5i55d+ASloGy/wtfpMVOazLfKtzvFEjUg==
X-Google-Smtp-Source: ABdhPJx3xEUVpjCu1JSwjkBA+ddKZTdkWoJYWjLsNnyEB1VMrpkqg8go3K+tgjz5W3BcyJ2NTSKqrTJVaSndcW045BE=
X-Received: by 2002:a25:6608:0:b0:628:d9bd:6245 with SMTP id
 a8-20020a256608000000b00628d9bd6245mr21150433ybc.560.1647305948369; Mon, 14
 Mar 2022 17:59:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org> <20220311161406.23497-7-vincent.guittot@linaro.org>
In-Reply-To: <20220311161406.23497-7-vincent.guittot@linaro.org>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 14 Mar 2022 17:58:57 -0700
Message-ID: <CABk29Ns1=2kc3JAESx_Ce7PP86KqiDA4O9K+vaOLZbKfq_XVaQ@mail.gmail.com>
Subject: Re: [RFC 6/6] sched/fair: Add sched group latency support
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, parth@linux.ibm.com,
        Qais Yousef <qais.yousef@arm.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        Paul Turner <pjt@google.com>, pavel@ucw.cz,
        Tejun Heo <tj@kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>, qperret@google.com,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 8:15 AM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
[snip]
>
>  static struct cftype cpu_legacy_files[] = {
> @@ -10649,6 +10673,11 @@ static struct cftype cpu_legacy_files[] = {
>                 .read_s64 = cpu_idle_read_s64,
>                 .write_s64 = cpu_idle_write_s64,
>         },
> +       {
> +               .name = "latency",
> +               .read_s64 = cpu_latency_read_s64,
> +               .write_s64 = cpu_latency_write_s64,
> +       },
>  #endif
>  #ifdef CONFIG_CFS_BANDWIDTH
>         {
> @@ -10866,6 +10895,18 @@ static struct cftype cpu_files[] = {
>                 .read_s64 = cpu_idle_read_s64,
>                 .write_s64 = cpu_idle_write_s64,
>         },
> +       {
> +               .name = "latency",
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +               .read_s64 = cpu_latency_read_s64,
> +               .write_s64 = cpu_latency_write_s64,
> +       },
> +       {
> +               .name = "latency.nice",
> +               .flags = CFTYPE_NOT_ON_ROOT,
> +               .read_s64 = cpu_latency_nice_read_s64,
> +               .write_s64 = cpu_latency_nice_write_s64,
> +       },

Something I considered when adding cpu.idle was that negative values
could be used to indicate increasing latency sensitivity. Folding the
above latency property into cpu.idle could help consolidate the
"latency" behavior, especially given that it shouldn't really be
possible to configure an entity as both latency sensitive and idle.

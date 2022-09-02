Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDF15AB569
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbiIBPjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiIBPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:38:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78778E68ED;
        Fri,  2 Sep 2022 08:25:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F779B82C79;
        Fri,  2 Sep 2022 15:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F30C433D6;
        Fri,  2 Sep 2022 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662132348;
        bh=FrFg+xmdEDkMXv1wDlDQ6uNNvv9sbAcSL1qiGhUUHdg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qAzEyJ1361X9yBv3PliR9wcd4XO7H+RmdlGFAu390ZDMbmvYP/CjsF42JrqBMXz0l
         xB44489KSJ9azPNBg8p+l+o5zdvGJVaeVN1tbsFAEUqD4WGxAqaT0a9Ly22xhSizvt
         nNhY7xtyWXtuO45YX3ntyDDuskIDaY9xJIkOeO9oAHtF8RMWWldFHxBAGMv3kIJO29
         BYztCdgzS8MRIVGSw4AQZv1oV2WHzc0JcUB7kWj3EPLi8TB1bGUfIUtoEH40w+DdbI
         zYB6AVm6+N/Yuiiuq0z8Dofa2jANlRfMxfpmXqFxtIwFdR14bKuZvK3kIyVVooigQb
         7FStAgoJri4Sg==
Received: by mail-vk1-f169.google.com with SMTP id o12so1129954vkn.7;
        Fri, 02 Sep 2022 08:25:48 -0700 (PDT)
X-Gm-Message-State: ACgBeo31uNpKv8N04c0HTB6ct6jRDXf5LQYmY7cm2/91kNF0pddOum5d
        DYK3M0R4bgWBAVZqhyZ7b5lRgTL5Sa9W9FiUSQ==
X-Google-Smtp-Source: AA6agR50oV56jYwuRURRAX9mWAXKrjgKJL8ObI8pOpCwrhYhlFYAz/zsj5ffn6XwdO7wZKYS9DBW31KW+9iwTRLO1nU=
X-Received: by 2002:a1f:1d4d:0:b0:382:59cd:596c with SMTP id
 d74-20020a1f1d4d000000b0038259cd596cmr10769792vkd.35.1662132347322; Fri, 02
 Sep 2022 08:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220901184709.2179309-1-robh@kernel.org> <CAM9d7chY6T-EAN3BT487MUK0LbfGp27X+2Dd_+S0azgh2GQn9w@mail.gmail.com>
In-Reply-To: <CAM9d7chY6T-EAN3BT487MUK0LbfGp27X+2Dd_+S0azgh2GQn9w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 2 Sep 2022 10:25:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLmszK=NzD_2nYnZG1dD=tU1fKGUtYL-dUG2a497LkEcg@mail.gmail.com>
Message-ID: <CAL_JsqLmszK=NzD_2nYnZG1dD=tU1fKGUtYL-dUG2a497LkEcg@mail.gmail.com>
Subject: Re: [PATCH] perf: Ignore format attributes with an unknown
 perf_event_attr field
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 1:53 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Thu, Sep 1, 2022 at 11:55 AM Rob Herring <robh@kernel.org> wrote:
> >
> > If the kernel exposes a new perf_event_attr field in a format attr, perf
> > will return an error stating the specified PMU can't be found. For
> > example, a format attr with 'config3:0-63' causes an error if config3 is
> > unknown to perf. This causes a compatibility issue between a newer
> > kernel and an older perf tool.
> >
> > The addition here makes any attr string up to the ':' ignored, but
> > still checks the 'bits' portion.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > This is the YACC mud I threw and seems to stick. Maybe there's a better
> > way to handle this. It doesn't seem like there's a way to do wildcards
> > (i.e. config.*) in YACC.
> >
> > This is needed for this series[1]. Unfortunately the best we do to avoid
> > the issue is applying this to stable. I think there's some time before
> > v8.7 h/w is deployed, too.
>
> Maybe you could change the format_term rule to take an identifier instead
> of PP_CONFIG* directly and pass it to perf_pmu__new_format().  Then
> it could check the string and create an appropriate PERF_PMU_FORMAT_VALUE_*
> or ignore it according to the PERF_ATTR_SIZE_VER*.

That only moves parsing of configN from YACC to strcmp in C. In doing
so, we'd be left with just the 'error' token case which seems a bit
odd (if there's another way to do it, I don't know. yacc is not my
thing). Is that really better? Unless there is some way to retrieve
the PERF_ATTR_SIZE_VER* from the kernel at runtime?

Rob

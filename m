Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BCB54B131
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbiFNMaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356594AbiFNM3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:29:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B0A23BDD;
        Tue, 14 Jun 2022 05:29:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id o7so16871760eja.1;
        Tue, 14 Jun 2022 05:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=axAoTgW4f9hEkpnjg5fk+kCuJUrcn/1GVTmzDalaTpE=;
        b=TC2i7XA7+9Xlrhf2dw40ePmPdZiuddA5zyiu0EL3XudVgt7iMQ76XXD090WPUwKYo2
         9Nynx4bkyvSKns2UbUrHBv83yWFIT6kEG5MsIa4E+VrqDkFyl5hIZ+VgoIkETMBGe3fr
         Nh1NH3Auzr8xBCYZo8Ms7ZoV8Q78axRaf6/zQRn4WQVypJ7x/KG/7+pZwuCdi6jGx9TH
         Y4Dc1xYnzdLx73qEjyzX6MwktZGp7uUy97J0M1P6csFAsVkuAhfl1qnKnwkIndBmmS8x
         TartraPrDPxftKMy0WCDH9SAqEvIRe2ZOktv9Pm/S5wMGjcTjug8uEzcNjdsjXJuegXw
         SkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=axAoTgW4f9hEkpnjg5fk+kCuJUrcn/1GVTmzDalaTpE=;
        b=2LxkQ/Me/QE6d449KCic8JPHrfv3nkBzZwXYNsymSmQF+tCEYFMLrdW7LoN9nHpA9p
         T1JwurqX1TKiXs4vqB1p26xLemyOF0HFMMs6cEXBwt5Wq2rwbDx/QM32u4y0XDKzeRAM
         UJo6h03Zs0slHbMtiYmCClQVdRAYPvhL9BZAy/iX2fv/jPaLRDyFwHplcVVOaN3jIHW8
         LZ6NAFUPkBe3k9R6TZyH8m4j/Hw5q++NPyw3bD3/d/wFoiZkVs3lA515jEqvyQsWW3bs
         80OgjKqUxcDgB9Cxv0r/XOllTHVpwZzyS1IlS6tGH2Bx61uBS59gKDE6OkPKL3lo3qnJ
         lR/Q==
X-Gm-Message-State: AOAM530bWCJvGoJc57dK70tSFCHJXb4M79ZB3JWA/gMyBq/OXeyLOVAX
        AMY0PIJfdf9M61OKlVKK318=
X-Google-Smtp-Source: ABdhPJyywCmnpHZqwVSmt50ed8p/dYmi/CUTgqEnog5vo72tdHnTWhxx4t9rRMHalfnoYRdREvIu2Q==
X-Received: by 2002:a17:906:51c6:b0:712:2a1a:afc8 with SMTP id v6-20020a17090651c600b007122a1aafc8mr4298295ejk.649.1655209749213;
        Tue, 14 Jun 2022 05:29:09 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id i9-20020a05640242c900b0042dce73168csm7170844edc.13.2022.06.14.05.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 05:29:08 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 14 Jun 2022 14:29:06 +0200
To:     Blake Jones <blakejones@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Add a "-m" option to "perf buildid-list".
Message-ID: <Yqh/EkVy99Bej46S@krava>
References: <20220607191550.4141024-1-blakejones@google.com>
 <YqZmSRS8UPQJzWFE@krava>
 <CAP_z_CgkJ8RgWevJnDiq-+JjB=ni0OzJ3npwW+S9RZ66i0Y3Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP_z_CgkJ8RgWevJnDiq-+JjB=ni0OzJ3npwW+S9RZ66i0Y3Kg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 03:02:39PM -0700, Blake Jones wrote:
> Thanks for taking a look at this!
> 
> On Sun, Jun 12, 2022 at 3:18 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > why 'modules' ? it shows all maps (including kernel)
> > so perhaps -m/--maps would be better?
> 
>  I called it "modules" because it only operates on the kernel. Calling it
> "maps" would suggest to me that it might also be able to show
> information about the maps in perf.data files, which it can't (just as the
> "-k" option only operates on the kernel). Given that, does it still seem
> like "maps" would be more appropriate?

still there's kernel map included, so it's strange to me call it modules

  --m/--kernel-maps ?

> 
> > also please state that it's from running kernel
> 
> Happy to make this change.
> 
> > any reason why not use the dso fields directly?
> 
> I was just following my general software engineering instincts to
> encapsulate implementation details, so that e.g. the caller doesn't need to
> know about details such as the "has_build_id" boolean. I haven't made
> changes to perf before, so if that's not the preferred style, I can do it
> a different way.

we have some helpers for dso fields, but AFAICS long_name and has_build_id
are used directly all over the place

jirka

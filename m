Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3032E58040C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiGYSc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiGYScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:32:54 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE30514D3E;
        Mon, 25 Jul 2022 11:32:53 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-31d85f82f0bso119380697b3.7;
        Mon, 25 Jul 2022 11:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=diB3p1SRruuk8rIBb0m/5aPwGr+R0gunx/X4Cv4OA/4=;
        b=jpH8UdkDgAs7SBVH5iWPtBLuR1LJbHnGGsm4yKT2HycOscXFUvoxM3b64W+acVBrP7
         Gifjb6K2YWoVn7w4Zt6eGcbc9bwkf7Zi28dufL5s2uKO07xsDgtJLfPZr0Vc9ajx+Jy7
         pdSpyp7vNZdNeQM6mQgutb+kjusZjL7qljUKpp8no9U8ZaL6K0p9hdOIemeLmf+6sCVp
         w3yxWeM3uo9k9s6Ks5XYv/KDDHZuJlrGyCcboItURzXZ8Kgm7iidTt+ZvBuQYilEjBs2
         1aPwrLcYnVo3trXXb+Keigyh1MC4kcHFapkcdUpgSnCLqru+RvnrNpfBy+fowYY7Fmyj
         hzsA==
X-Gm-Message-State: AJIora9V5OdwkZfRic7uFuiVTC/0mddBjp8BRXQD/Z/dqGSrR8MALeqt
        qox6GZx1465lGmCOPCuMsluuCY02KNZT8mOuKiM=
X-Google-Smtp-Source: AGRyM1t/2yqolCuy7NvaFFlADeAVfE18diU9YwO/Ko6oHTgQU6Qlo6mbYZ8Fa/A/2bJ4VJfg7HFrVwBrJmSRNZFY1jw=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr10873566ywb.326.1658773972961; Mon, 25
 Jul 2022 11:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220722200007.1839356-1-daniel.lezcano@linexp.org> <1aa3ae56-84ae-8a96-7a52-3181c47dcb07@linaro.org>
In-Reply-To: <1aa3ae56-84ae-8a96-7a52-3181c47dcb07@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jul 2022 20:32:41 +0200
Message-ID: <CAJZ5v0gvHqUy7c_Bo=wj9nDS0xzB-driY5Uyu813vPnMDQZCOw@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] thermal OF rework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Jul 25, 2022 at 6:34 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 22/07/2022 21:59, Daniel Lezcano wrote:
> > The thermal framework initialization with the device tree appears to
> > be complicated and hard to make it to evolve.
> >
> > It contains duplication of almost the same thermal generic structures
> > and has an assymetric initialization making hard any kind of serious
> > changes for more complex features. One of them is the multiple sensors
> > support per thermal zone.
> >
> > In order to set the scene for the aforementioned feature with generic
> > code, we need to cleanup and rework the device tree initialization.
> >
> > However this rework is not obvious because of the multiple components
> > entering in the composition of a thermal zone and being initialized at
> > different moments. For instance, a cooling device can be initialized
> > before a sensor, so the thermal zones must exist before the cooling
> > device as well as the sensor. This asynchronous initialization forces
> > the thermal zone to be created with fake ops because they are
> > mandotory and build a list of cooling devices which is used to lookup
> > afterwards when the cooling device driver is registering itself.
> >
> > As there could be a large number of changes, this first series provide
> > some steps forward for a simpler device tree initialization.
> >
> > More series for cleanup and code duplication removal will follow.
> >
> > Changelog:
> >
> >   - v6:
> >      - Folded patches 8, 9, 10
> >      - Removed thermal_zone_get_trips() and thermal_zone_get_num_trips()
> >      - Moved tz->ntrips => tz->num_trips changes into patch 11 to fix the
> >        git bisecting
> >
>
> I believe all the comments were addressed, is it fine if I merge this
> series ?

Yes, please!

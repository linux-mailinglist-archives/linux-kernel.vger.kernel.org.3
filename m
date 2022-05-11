Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFFD523B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbiEKRRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242783AbiEKRRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:17:34 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7513566F9A;
        Wed, 11 May 2022 10:17:33 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id i11so5238623ybq.9;
        Wed, 11 May 2022 10:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vD+1JoRhTRHmBfAogbA1m801BvLZBfvraleqvaICUvk=;
        b=CCh/ASH6OlwWTkfJXL58tKuzzwcGplXvhylbkD561mWi28rTvYIBhbQLFAqN9DZ3K1
         9mIrrxbV8zutxfa51cyQ3W3LQGA8U7LsHnQnkSagDvn9F+vHTXoJmpVHavivWUOTmruQ
         bQUD625yA84Z5MJEpqYMQY0pgJWbo2MExVFY0YHKRDwjkmnar4nKzAP58uIfgbs3TThg
         SeQ+O/lcjmvTZyaM6Z0YVbmhPM+NU0ySLb7T7U1CcW0NXZHumImuU0Ikkbfa088wQEaZ
         QRGksgaUSJJGllsfxktN4MOfhaj5kQlG2e3qPLn+6bsVxmiQRQ7/Xep/mEW+DnbXpcgc
         FOhQ==
X-Gm-Message-State: AOAM530XoohX0PglpVtdts2sOhwTarxumNputD/W1Gz7aCiyg049Dunf
        rjMGOG6jK7hJ+4OFwGlqR1V2knoWH4vIsg4qI8k=
X-Google-Smtp-Source: ABdhPJw4RNg1Tn0oZMYT4uWeN79BPHq44LwxtO1hn5Q/54sZe0nYI0IhXcgbmvtLDmAhYfJGrVDpWcBz14WgiU/yxxA=
X-Received: by 2002:a25:d288:0:b0:64b:4bb5:32be with SMTP id
 j130-20020a25d288000000b0064b4bb532bemr1088503ybg.633.1652289452685; Wed, 11
 May 2022 10:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220426144448.43682-1-pierre.gondois@arm.com> <8ee5dfd0-558b-5ad6-63d2-b142550f04a3@arm.com>
In-Reply-To: <8ee5dfd0-558b-5ad6-63d2-b142550f04a3@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 19:17:21 +0200
Message-ID: <CAJZ5v0i0BTOFZ8Rhh_da5_mgZQW0+qCoeiDpWLwVJfJwjgYAqg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: EM: Decrement policy counter
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 5:40 PM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> On 26/04/2022 15:44, Pierre Gondois wrote:
> > From: Pierre Gondois <Pierre.Gondois@arm.com>
> >
> > Fixes: e458716a92b57 ("PM: EM: Mark inefficiencies in CPUFreq")
> > In the above commit, cpufreq_cpu_get() is called without
> > a cpufreq_cpu_put(), permanently increasing the reference counts
> > of the policy struct.
> > Decrement the reference count once the policy struct is not used
> > anymore.
>
>
> Not sure if the tag there will be caught properly. Usually it goes on
> top of the Signed-off-by.
>
> While at it:
>
> Reviewed-by: Vincent Donnefort <vincent.donnefort@arm.com>
>
> Thanks for fixing this.

Applied as 5.19 material, thanks!

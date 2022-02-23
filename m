Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2927E4C1666
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbiBWPTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239424AbiBWPTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:19:49 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29BB5469A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:19:20 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id v22so23267806ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UoIc818TKFJQDB8ZDtpesqyQke/StDy/K3yrOaNnU+w=;
        b=c39BmkeOcZ7y8HmBehuyQIvQIxPXEIf3kKx6dR1Z7oy22fLgH2APdrdoJfpMEn4SW2
         Yb/dM/mAIdHr3Kuym/kzfcT2q3uxdKPf86plKwdgSenihYITSeu8QgWOnK26BhA8G0ZT
         4Rc4Xck3/BeY8PF6sS1TKUCOVUjBU2lA2kbanV2GNe8EFbJD4MKqnd2MshXZEz4ozxC8
         nTz24URG2M9XtwTxghgj7fgkeT/dZbNq9cbVwd5dkHISS8W8fijXI9ErzRH6cx/PTM+w
         SPesD7czzCbEmj9+fWMuzi8UuMhYihe32tiF/d7lS72VUZctJk39YsMZy+ElpAq5PnBD
         Yqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UoIc818TKFJQDB8ZDtpesqyQke/StDy/K3yrOaNnU+w=;
        b=PZ7GBYd1z/qvIW2AeCSiMz19e2mRimh9xogV2+xLtgqzCy7KUMp9/ABWKnkVIMN+wV
         rIhniowOFLPcESnGV/ClcQeEGor2xwMtaFg6FAeTbVyY0NnIblaw0Vh36kWy6KHmz7sm
         7RKIkBmuDR13k0dOSpJ00Cg4H4P3qQyvefExoPQJ8pcKjKeyGQxxxS3Xi/rNlJFhQple
         O4wUkcweseVMkGVQ1vuocI9fz4IG03FWabC8TokYV1LoTIg7vt2AJarSIMT+Pz5/0lFW
         vbSFWFf18c+wKRHi1G4WoIio6Ynk/Q2lnCHNZx0+WSNoStz4o7KEoxE0UYdxJkEk4hdv
         5LUg==
X-Gm-Message-State: AOAM530MOaHrkS6L1hjTYdAHcdILtMobhj58iTtGs0q5FrDqyEaQFF9t
        O5OGj13oA7QSgyZH89iwiz8Kcs1YRV4FbjJ59t7aOw==
X-Google-Smtp-Source: ABdhPJyG0ns8FoarM8C6bxPJMgUtvK27UsU9zqR5BTIhUBgDTVAEW/biii1mTDKGN5M2izXm15v9vYhmY+u0FsKaetc=
X-Received: by 2002:a05:651c:1542:b0:233:8ff5:eb80 with SMTP id
 y2-20020a05651c154200b002338ff5eb80mr21321595ljp.352.1645629559338; Wed, 23
 Feb 2022 07:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20220223100350.3523826-1-Jinzhou.Su@amd.com> <20220223100350.3523826-3-Jinzhou.Su@amd.com>
In-Reply-To: <20220223100350.3523826-3-Jinzhou.Su@amd.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Wed, 23 Feb 2022 07:19:08 -0800
Message-ID: <CAAYoRsWn_gjuBdS3vbo6ZxAXKur6YhXKTkZKpQY+k6hogcibUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] tools/power/x86/intel_pstate_tracer: make tracer as a module
To:     Jinzhou Su <Jinzhou.Su@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Huang, Ray" <ray.huang@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        todd.e.brandt@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        deepak.sharma@amd.com, alexander.deucher@amd.com,
        xiaojian.du@amd.com, perry.yuan@amd.com, li.meng@amd.com,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 2:04 AM Jinzhou Su <Jinzhou.Su@amd.com> wrote:
>
> Make intel_pstate_tracer as a module. Other trace event can import
> this module to analyze their trace data.
>
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>

HI Joe,
I have been using this version (well, with just 2 variable name changes,
which I see you changed  back) since you sent it (off-list) on Feb 8th.

Acked-by: Doug Smythies <dsmythies@telus.net>

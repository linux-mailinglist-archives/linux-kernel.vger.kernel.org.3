Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA1A4CAA69
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242735AbiCBQhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbiCBQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:37:15 -0500
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BB9C4B78;
        Wed,  2 Mar 2022 08:36:32 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id j2so4596333ybu.0;
        Wed, 02 Mar 2022 08:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvGAdBIf+bhILkDwd1RAEBaMeGjQHU2I0tTcLA9pmuw=;
        b=BjgtjKcdRg4y5tSWnwE6w/wAu/blR5Mf4UgGdHmH8dXcKcYUhxwM1btnFNA21tNSVC
         zCeJTJyjXkpOQz91UYu9r1n1E9vxHHp2aKCXvz3kXXlX3GwQ+SM4eOl/N8BcILf0EQim
         yM3nm6zjmK5QSDCyq4SZtF1bZ/vbqeoB9ufQdEwrbw5MGrzWKW2bIHLRIY71ZEKr0pp2
         6TGO4MClhmBf48c5vGAlkMSGynf4OHHVyCD9SzVyk2NVGstQCz3ld+UiyLkj5DDSBjuJ
         uFTwiU0YkZNQ7Kx2/7nxCzRPzDwDyamRD7C+a/10Xril6w421o0q5rfSBO37q/qcbyvn
         tTug==
X-Gm-Message-State: AOAM531nLR1a/GMQnMs744tPP07/Jt7QLRQjIOwgiCQNhAPnFBCoYMPN
        cDFq7Tlk3nSsKqTt2VO7xdwsv9RmfhbJhV4Wznw=
X-Google-Smtp-Source: ABdhPJxn9LMC8lwWO4YmbVkZlEVT1jBmWUWdBg1cMfWRsu7mg1BUeW+rNNGEaSftaTVtMzJb7bwJ16HO+lMGdkKcQfA=
X-Received: by 2002:a25:6649:0:b0:628:a0c0:f0e0 with SMTP id
 z9-20020a256649000000b00628a0c0f0e0mr3022520ybm.81.1646238991427; Wed, 02 Mar
 2022 08:36:31 -0800 (PST)
MIME-Version: 1.0
References: <20220211110423.22733-1-andriy.shevchenko@linux.intel.com> <Yh+SHs4CEWkiLxAe@smile.fi.intel.com>
In-Reply-To: <Yh+SHs4CEWkiLxAe@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Mar 2022 17:36:20 +0100
Message-ID: <CAJZ5v0g_3a7A5aFab6ZsM8nPDmivoTeNgdSG17Lt71mFKmNxmg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: Switch to use list_entry_is_head() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nvdimm@lists.linux.dev, "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
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

On Wed, Mar 2, 2022 at 4:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Feb 11, 2022 at 01:04:23PM +0200, Andy Shevchenko wrote:
> > Since we got list_entry_is_head() helper in the generic header,
> > we may switch the ACPI modules to use it. This eliminates the
> > need in additional variable. In some cases it reduces critical
> > sections as well.
>
> Besides the work required in a couple of cases (LKP) there is an
> ongoing discussion about list loops (and this particular API).
>
> Rafael, what do you think is the best course of action here?

I think the current approach is to do the opposite of what this patch
is attempting to do: avoid using the list iterator outside of the
loop.

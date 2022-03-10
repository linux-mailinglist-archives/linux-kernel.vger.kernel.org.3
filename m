Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654734D5255
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343541AbiCJTZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbiCJTZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:25:01 -0500
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864FB136EE8;
        Thu, 10 Mar 2022 11:24:00 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2dc0364d2ceso69807977b3.7;
        Thu, 10 Mar 2022 11:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CeYZZUdJ8x+MUxTR9mzmMaPoyMDUCoSVxfdYDVmJU0=;
        b=4u4ySlRmoAvfa7cEIL0yQDDOxaFNSXUacww1aqn+Om0LYV6RwCib+lRNUcmLH9QjDa
         GUNafXLdaKH6/S1Vy4MKqUx9oldStRswz6IM8/l+VfeqEKXjyvGbnBbJCCJBbbuGVhKW
         LKh8DU6RhZe10PvgHp3J8RbizlwB4pWp2tnSqI+Pk9jHb64XmHOhPc02gj95UJLvDqI7
         PmxvE9Xk422NjdGNtvMAD8FY6YTwnOzhfSZKJm4ZQXpeJJ9ZlXPM2nEp8rZRZRbqqhQU
         AIc06cQK7dzkWTpYrlB2xj8QKqY/B7MIhPPq4j6RD0BjhsX1mkfzIFoGA+WhaRpxW65V
         TgkA==
X-Gm-Message-State: AOAM533O/MzrUXewGVkojTc4XPXGvorbQFX0Jpja1vUBIoeyY4VdcBrA
        ZpAvWtgz57JUmYpTMtG/M588gSM1WsMKVBJnKcJKnB/J
X-Google-Smtp-Source: ABdhPJzeXNznKhyIoLOOZWCrGXsIp4fIwRizVyhgiy1n20P/2+ByqzugSbNefMI2gbdbjIRtSpD4pR3tgkYWrt1ZphA=
X-Received: by 2002:a81:bd0:0:b0:2dc:184b:e936 with SMTP id
 199-20020a810bd0000000b002dc184be936mr5308821ywl.7.1646940239792; Thu, 10 Mar
 2022 11:23:59 -0800 (PST)
MIME-Version: 1.0
References: <20220310145451.15596-1-ionela.voinescu@arm.com>
In-Reply-To: <20220310145451.15596-1-ionela.voinescu@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Mar 2022 20:23:48 +0100
Message-ID: <CAJZ5v0i1QJF+J=yeuf8toVWj+tctzx=xP_AbbWkFnKSJJUeTRg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] arch_topology, ACPI: populate cpu capacity from CPPC
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Thu, Mar 10, 2022 at 4:05 PM Ionela Voinescu <ionela.voinescu@arm.com> wrote:
>
> Hi all,
>
> v3->v4:
>  - v3 can be found at [3]
>  - rebased on linux-next 20220310 which contains patches at [4]
>    requested by Rafael
>  - 2/3 fixed obsolete comment as reported by Yicong at [5]
>  - Kept Acked-by,Tested-by as v4 has no code changes compared
>    to v3, but only a comment fix.

All patches in the series applied as 5.18 material, thanks!

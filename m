Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B960D52DC74
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243726AbiESSLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbiESSLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:11:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC4A4EA1E
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D57A9B82798
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C75C34100
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652983865;
        bh=qfrsVSac5p7s4s3/tao5faBYDdKOQTeF9rcknBTAI6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n5xa3krTyCU/0LFHvaxl9nV72wSAN+wptxohSNu1LJGjOf3eBWJQXM29fe8CWWt9/
         8/iEsYee40+jrC2083NGxEDv72DIHUPaZaU4MDrXgGAw6uK/lCd1O6Ui9NJtKq8ri0
         l8/5lLS4127Dz6GeUaNclEZtLLhn0q3N54eBfxuE4l8T7qyIvIiqtudmyGTqPbcXC4
         CwoNkPgHoCr961+/V+m261Xj+DwDjGO9/NviZlQ3iI/iqxxvzmci/tNkwADe6xQYG0
         kRK92Gz0z2/9oGeobimhLWUSwaZb7/JU+Nv8dDYp4brmBzv1zQgU//uZTg0SFWa48B
         XfRJmKVuJM0iQ==
Received: by mail-ed1-f43.google.com with SMTP id j28so7922104eda.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:11:05 -0700 (PDT)
X-Gm-Message-State: AOAM532f6PWVA7RdhaJSt0e8qsJ0g47cuFrgmzxBjJbl9ihJQbPzEoZq
        5uUolzZybcmFh4X5X3/2gplPz09bxOPCHZpjHw==
X-Google-Smtp-Source: ABdhPJxhP1Wba2opQ/Qs/q0Ub3BI7HdxkNRvDPWLuPYkNRluZEnIc5Y6vMACPPBUzeTAGTwweZnHRj217yThqyWAB3k=
X-Received: by 2002:a05:6402:5388:b0:42a:ba77:7669 with SMTP id
 ew8-20020a056402538800b0042aba777669mr6676016edb.89.1652983863801; Thu, 19
 May 2022 11:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220518093325.2070336-1-sudeep.holla@arm.com> <20220518093325.2070336-9-sudeep.holla@arm.com>
In-Reply-To: <20220518093325.2070336-9-sudeep.holla@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 19 May 2022 13:10:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKig8U4hQEtHW8ct1Pd0a29ZtoTp1HuWQv389yb+SuW_A@mail.gmail.com>
Message-ID: <CAL_JsqKig8U4hQEtHW8ct1Pd0a29ZtoTp1HuWQv389yb+SuW_A@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] arch_topology: Add support to build llc_sibling on
 DT platforms
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 4:34 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> ACPI PPTT provides cache identifiers and especially the last level cache
> identifier is used in obtaining last level cache siblings amongst CPUs.
>
> While we have the cpu map representing all the CPUs sharing last level
> cache in the cacheinfo driver, it is populated quite late in the boot
> while the information is needed to build scheduler domains quite early.

Late is because it's a device_initcall() rather than late in the cpu
hotplug state machine, right? The late aspect is for sysfs presumably,
but I think we could decouple that. Do all the firmware cache parsing
early and then populate the sysfs parts later. It's not a unique
problem as the DT unflattening and init code has to do the same thing.
I'd assume the hotplug and cpu sysfs devices have to deal with the
same thing.

Rob

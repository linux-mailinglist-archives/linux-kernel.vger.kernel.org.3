Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE5158263E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiG0MSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiG0MSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:18:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9DB248E84;
        Wed, 27 Jul 2022 05:18:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 168B4D6E;
        Wed, 27 Jul 2022 05:18:47 -0700 (PDT)
Received: from bogus (unknown [10.57.11.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FCE73F73B;
        Wed, 27 Jul 2022 05:18:43 -0700 (PDT)
Date:   Wed, 27 Jul 2022 13:18:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: riscv: Add optional DT property
 riscv,timer-can-wake-cpu
Message-ID: <20220727121838.tpy55twdkuasjab7@bogus>
References: <20220727114302.302201-1-apatel@ventanamicro.com>
 <20220727114302.302201-2-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727114302.302201-2-apatel@ventanamicro.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 05:13:01PM +0530, Anup Patel wrote:
> We add an optional DT property riscv,timer-can-wake-cpu which if present
> in CPU DT node then CPU timer is always powered-on and never loses context.
>

I don't have much idea on idle states on RISC-V but associating this
property in just CPU node seems like not so good idea.

This will be applicable for all CPU idle states which means you
can't use this even if one of the deepest idle state switches off
the timer.

We have local-timer-stop in each idle states node. IIRC RISC-V uses the
binding which is now not arm specific[0] and IIRC you moved the binding
yourself. Any reason why not can't be used and any specific reason for
needing this extra property.

[0] Documentation/devicetree/bindings/cpu/idle-states.yaml

--
Regards,
Sudeep

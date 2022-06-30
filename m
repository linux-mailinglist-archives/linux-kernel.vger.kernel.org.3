Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2533562415
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiF3UW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 16:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiF3UW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:22:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1A1B28E19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 13:22:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C20242B;
        Thu, 30 Jun 2022 13:22:55 -0700 (PDT)
Received: from bogus (unknown [10.57.39.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1147A3F5A1;
        Thu, 30 Jun 2022 13:22:52 -0700 (PDT)
Date:   Thu, 30 Jun 2022 21:21:41 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor.Dooley@microchip.com
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        atishp@atishpatra.org, atishp@rivosinc.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wangqing@vivo.com, robh+dt@kernel.org, rafael@kernel.org,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, gshan@redhat.com,
        Valentina.FernandezAlanis@microchip.com
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Message-ID: <20220630202141.37p5qhppkiz6wrcb@bogus>
References: <f1f4a30e-7a84-30e2-197c-4153b3e66b64@microchip.com>
 <20220629195454.vbsjvcadmukiunt7@bogus>
 <03433f57-04ed-44a9-a2f6-5577df94f11e@microchip.com>
 <b2ab0ac1-bfef-5ba0-4ee5-15e604d8aa2e@microchip.com>
 <20220630103958.tcear5oz3orsqwg6@bogus>
 <9d9e80b8-17e2-b1d9-14fa-f1d8d7dfbd9a@microchip.com>
 <20220630173513.dyrrmjbpxzi3e6fe@bogus>
 <3840dbf7-ca18-b7ab-4d7a-92c9305476fa@microchip.com>
 <20220630200717.zlc6z6zcqbsw7euk@bogus>
 <ddb8238a-003e-fe5a-2a11-cb34c324fb33@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddb8238a-003e-fe5a-2a11-cb34c324fb33@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 08:13:55PM +0000, Conor.Dooley@microchip.com wrote:
> 
> I didn't have the time to go digging into things, but the following
> macro looked odd:
> #define per_cpu_cacheinfo_idx(cpu, idx)		\
> 				(per_cpu_cacheinfo(cpu) + (idx))
> Maybe it is just badly named, but is this getting the per_cpu_cacheinfo
> and then incrementing intentionally, or is it meant to get the
> per_cpu_cacheinfo of cpu + idx?

OK, basically per_cpu_cacheinfo(cpu) get the information for a cpu
while per_cpu_cacheinfo_idx(cpu, idx) will fetch the information for a
given cpu and given index within the cpu. So we are incrementing the
pointer by the index. These work just fine on arm64 platform.

Not sure if compiler is optimising something as I still can't understand
how we can end up with valid llc but fw_token as NULL.

--
Regards,
Sudeep

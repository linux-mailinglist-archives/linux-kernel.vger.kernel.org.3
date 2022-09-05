Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0830B5AD956
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 21:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiIETAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 15:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiIETAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 15:00:12 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938B33AE56
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 12:00:07 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oVHK7-0001BA-Tp; Mon, 05 Sep 2022 20:59:55 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andreas Schwab <schwab@suse.de>
Cc:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com
Subject: Re: [PATCH v3] drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores
Date:   Mon, 05 Sep 2022 20:59:53 +0200
Message-ID: <8712127.JRmrKFJ9eK@diego>
In-Reply-To: <mvm4jxlao6f.fsf@suse.de>
References: <20220905141644.2468891-1-heiko@sntech.de> <mvm4jxlao6f.fsf@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Am Montag, 5. September 2022, 16:30:48 CEST schrieb Andreas Schwab:
> On Sep 05 2022, Heiko Stuebner wrote:
> > To work properly, this requires a matching change in SBI, though the actual
> > interface between kernel and SBI does not change.
> 
> What happens if you mix different kernel and SBI versions?

The interface kernel <-> sbi itself is not changed at all and this of
course only matters to t-head c9xx cpu cores, so I guess we have
the cases:

- non-t-head core:
  no behaviour change independent of versions


- t-head core with everything "old":
  would just uses the regular sbi pmu setup, but as the necessary
  sbi-side pmu config for the c9xx isn't set from u-boot
  (dt-properties mapping sbi-events to the values needed to be written
   to mhpmevent*), this is broken anyway with standard sbi
  

- t-head core with "old" kernel, "new" sbi:
  kernel does not detect the extended features, so should fall back
  to just use the standard pmu features
  

- t-head core with "new" kernel", "old" sbi:
  Same as everything "old", pmu isn't setup correctly in sbi anyway
  for the c9xx at the moment


Heiko  



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4874D1B62
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347796AbiCHPMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347768AbiCHPMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:12:05 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCDD39804
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646752268; x=1678288268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=11qjO4saXcBE/FZtwptBC1qhYkmlivHxUIX47RP5/Ak=;
  b=wdKwmD3g4Gf42hJ16VhH4utRovxQcxoiJfxhq4hqdYWoG0+B07MYMa1O
   xrjQ4NclXCjvVvdKUHLbWKiXPUiOo490lDGkFM3n5as7FAej12JgZaLoa
   v/QVAi94wbB7Fh8OA1+5YOocBCM1I1zwOl3U60ZrcyK75dOrpvlfIz8Bv
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 08 Mar 2022 07:11:08 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 07:11:07 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Mar 2022 07:11:07 -0800
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 8 Mar 2022
 07:11:06 -0800
Date:   Tue, 8 Mar 2022 10:11:04 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] configs/debug: set CONFIG_DEBUG_INFO=y properly
Message-ID: <YidyCKCO4y4L6fF3@qian>
References: <20220301202920.18488-1-quic_qiancai@quicinc.com>
 <20220308104215.q4asb6z3vicq2vja@maple.lan>
 <YidgcE0ypmKWzvai@qian>
 <20220308143029.j6wbbnmkmmmhl2jt@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220308143029.j6wbbnmkmmmhl2jt@maple.lan>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 02:30:29PM +0000, Daniel Thompson wrote:
> That is *not* an example of debug.config working correctly. It is an
> example that only works by accident because the arm64 defconfig already
> included CONFIG_DEBUG_INFO=y (that's why I explicitly disabled it in my
> example demonstrating the problem before I applied debug.config).
> 
> However debug.config is not specific to arm64 and, for v5.17-rc7 it is
> also not working with the defconfigs for (at least) arm, powerpc, riscv and
> x86 (both i386 and x86_64).
> 
> I'm still of the view that any change that removes CONFIG_DEBUG_INFO=y
> cannot be sensibly applied to kernels that do not include Kees' patch.

Okay, good points. I'll make a patch for v5.17, so people don't need to
wait for a few weeks for flip DEBUG_INFO without Kees' patch then.

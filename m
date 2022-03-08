Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2B04D19C0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245716AbiCHN5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241615AbiCHN5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:57:00 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA54649F87
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 05:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646747763; x=1678283763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fyqN8RLn8JO7kE1GkcGhN9M7OuJ6K/kGI6Eh5ScqH74=;
  b=jHFubqP+r1inoGIGAn4wFAn/opXzdLnqU0bdjCHQ/NKuN9MQ9w04rvPK
   WM22mQpK4K3Z3XwPeJ6usd+RYQ/eKEy/EDP249Ek/DZa3uoO2GO1V63qq
   zAugcftC5qydoAFBGj5PGSwBXg6aIb8VdcKRXf20IZBYEqOI4Na6BBhvb
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Mar 2022 05:56:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 05:56:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Mar 2022 05:56:03 -0800
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 8 Mar 2022
 05:56:02 -0800
Date:   Tue, 8 Mar 2022 08:56:00 -0500
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] configs/debug: set CONFIG_DEBUG_INFO=y properly
Message-ID: <YidgcE0ypmKWzvai@qian>
References: <20220301202920.18488-1-quic_qiancai@quicinc.com>
 <20220308104215.q4asb6z3vicq2vja@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220308104215.q4asb6z3vicq2vja@maple.lan>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

On Tue, Mar 08, 2022 at 10:42:15AM +0000, Daniel Thompson wrote:
> On Tue, Mar 01, 2022 at 03:29:20PM -0500, Qian Cai wrote:
> > CONFIG_DEBUG_INFO can't be set by user directly,
> 
> What do you mean by "can't be set by user directly"? DEBUG_INFO
> is fully controlable via menuconfig.

On linux-next, we no longer able to select DEBUG_INFO directly due to this
patch:

https://lore.kernel.org/all/20220125075126.891825-1-keescook@chromium.org/

Thus, this patch will work on both the mainline and linux-next.

> Does this change actually work in the kernels it has merged into?
> 
> DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT existence is predicated on DEBUG_INFO
> being set. It makes no sense at all to set the former without the later.

It works fine here.

$ git reset --hard v5.17-rc7
$ rm .config
$ make ARCH=arm64 defconfig debug.config
$ grep -i debug_info .config
CONFIG_DEBUG_INFO=y

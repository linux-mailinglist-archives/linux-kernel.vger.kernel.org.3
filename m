Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF895511B56
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiD0N1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiD0N1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:27:14 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EBF30F5B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651065843; x=1682601843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dc+dkNTYcw7030Vyc3+nXkbYveeQYwFvE3m5BPfUyyE=;
  b=UuRR7VeXkUn2ESBUu4W8jhGFfwxdD+8EqBcQMrlHcZRM7aiHLctyEkWD
   a16iueiP+yoPmxPRwY1F1GU9GlWWPfyPUQkqxw10Jm+IVhjPlxGRm0uJO
   2Z7F6sska+YJIBz5rlNWc7+rJS4c1whePRfZx5LHtMxEjs9WZfBeEQPiA
   R8Tas7fcMRvIuXYus683FaJD/33xGxwtjwvRYl57ivbtowuw9Oi4KMwPr
   wOL151bzI2305ZaWhfVrDCcoHQWJixjpdL8zHCuCIXA96jvCS8hAmgJh/
   JctlU7tV3u5f46ylqNsWVLJWUlPxCnoCBJuvyoXian5Rn+LoZ1T3B1OvD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265452111"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="265452111"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 06:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="580591131"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga008.jf.intel.com with ESMTP; 27 Apr 2022 06:23:59 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 23RDNvrf030907;
        Wed, 27 Apr 2022 14:23:57 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, gcc@gcc.gnu.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] linux/find: ignore -Wtype-limits to reduce W=2 warnings by 34% tree-wide
Date:   Wed, 27 Apr 2022 15:21:20 +0200
Message-Id: <20220427132120.3128595-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <CAMZ6RqJuUPuEJQvyHZr0Gxzh9ZZ2iACTHe3XE70jZ38hmePfuA@mail.gmail.com>
References: <20220426161658.437466-1-mailhol.vincent@wanadoo.fr> <YmhZSZWg9YZZLRHA@yury-laptop> <CAMZ6RqJuUPuEJQvyHZr0Gxzh9ZZ2iACTHe3XE70jZ38hmePfuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Wed, 27 Apr 2022 11:58:58 +0900

> + Alexander Lobakin <alexandr.lobakin@intel.com>

I was okay even with the previous solution to modify
GENMASK_INPUT_CHECK() and this one is fine to me as well.
The presense of warnings on W=1 doesn't mean we shouldn't fix W=12
etc. Especially when their rootfs are in headers and blow up the
output. Especially when it's 1/3 of all warnings.
`make W=12[e] path/to/new/file` is still useful to ensure that we
don't add more warnings to the already existing ones. When there are
problematic header, it's easier to miss something and impossible to
pipe `make W=12e` in a script to do that in an automated manner.
Thanks!

Acked-by: Alexander Lobakin <alexandr.lobakin@intel.com>

> 
> On Wed. 27 Apr 2022 at 05:42, Yury Norov <yury.norov@gmail.com> wrote:

[...]

> Yours sincerely,
> Vincent Mailhol

Al

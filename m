Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E885913FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbiHLQiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiHLQh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:37:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE10A74DB;
        Fri, 12 Aug 2022 09:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660322276; x=1691858276;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NN+mTdGQYqM989kWaaJ290E0qoRQJJxMNHO8nkCf2Zg=;
  b=d7GRN/umQdTYAj0BuKhXNuGrEIPKdr9nj3xlCzEKLH1nh267CHrrOovC
   Rr0KeKq2yJx64dpbk24ide/D/JLKtSWZBoy0edco1tyeejV4dVbAS8BO6
   nxPH8kPU6BAV5HhcCTkh7P5L7Ley5vBi+mGH9KSXAAZNNhmgMR9nkEhII
   4vIM0Mm7aHabpYAVC/G9dxMDgsVGYlAERkQJDwoi9cggeicbYGCdBtPqK
   uwNt+H98AK0OIs5J9KPGuIpIbpqEJKWSf8zSYGyNdam6GIjRGRd/b+yhA
   +/jgLxjnXEQFM5NBUKKgiBOPrkcYlH5w9dvSfYbEGJ2G68JqaLhwmzujp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="377921554"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="377921554"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 09:37:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="782012254"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2022 09:37:52 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH 0/7] x86/topology: Improve CPUID.1F handling
Date:   Sat, 13 Aug 2022 00:41:37 +0800
Message-Id: <20220812164144.30829-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel AlderLake-N platforms where there are Ecores only, the Ecore
Module topology is enumerated via CPUID.1F Module level, which has not
been supported by Linux kernel yet.

This exposes two issues in current CPUID.1F handling code.
1. Linux interprets the Module id bits as package id and erroneously
   reports a multi module system as a multi-package system.
2. Linux excludes the unknown Module id bits from the core_id, and results
   in duplicate core_id’s shown in a package after the first issue solved.

Plus that, a third problem is observed on Intel Hybrid ADL-S/P platforms.
The return value of CPUID.1F SMT level EBX (number of siblings) differs on
Pcore CPUs and Ecore CPUs, and results in inconsistent smp_num_siblings
value based on the Pcore/Ecore CPU enumeration order. This could bring
some potential issues although we have not observed any functionalities
issues so far.

Patch 1/7 and 2/7 fix the first two issues. And at the same time, it
reveals a reality that the core_id could be sparse on platforms with
CPUID.1F support.
Patch 3/7 improves coretemp driver code to be able to handle sparse core
id, which is the only driver that uses core_id as array index and run on
platforms with CPUID.1F support.

Patch 4/7 to 7/7 propose a fix for the third problem and update the
related Documents.

The patch series have been tested on Intel ICL/CLX servers, SKL/KBL/ADL
clients.

thanks,
-rui

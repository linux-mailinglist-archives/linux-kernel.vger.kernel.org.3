Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F075912A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbiHLPIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiHLPIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:08:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFD69E108;
        Fri, 12 Aug 2022 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660316931; x=1691852931;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=HnaSlb6OYMAXiBGdwWvnnpV3vlokdvryh4W77NkBu2U=;
  b=XijNUoNWH+n07tI9+PodiOe97PMuJO3TrL2ZxceIVsVihrLlI5hbGWkt
   4zZ/ajTIs/E0z0ODfWR9UfXxxz0aLvM3ATp5vL9xA5bkXqVz/ZJm9LmvG
   17pAQJqQeWXxDV6hf84ZturQ6cRwnNA3TVGOhQmEmBRoKGrrBwugBCL/b
   rJ7On6gM/8pN/x+wxTx0Dnk8zVdgVpAQ3KhnPdT34Yg2uYwxLHoRIriay
   IqKaDGpGOTHSkxM0/Hsn+CcooJKpWF+N93ZkgFf6Gb1AMRzAbdKiCF6/x
   zYm9P370bC0Ztk1AoTaqfcSPBZNiZ5xCf7KnQJ65ooWRgxaM8iM3+d3b9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355616147"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="355616147"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 08:08:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="609282402"
Received: from kokhaulo-mobl.gar.corp.intel.com ([10.213.45.243])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 08:08:45 -0700
Message-ID: <41fc865a1e207ea03e15067c06856a92c58e18f6.camel@intel.com>
Subject: [PATCH 0/7] x86/topology: Improve CPUID.1F handling
From:   Zhang Rui <rui.zhang@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, x86@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Len Brown <len.brown@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Fri, 12 Aug 2022 23:08:38 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
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
2. Linux excludes the unknown Module id bits from the core_id, and
results in duplicate core_id=E2=80=99s shown in a package after the first i=
ssue
solved.

Plus that, a third problem is observed on Intel Hybrid ADL-S/P
platforms. The return value of CPUID.1F SMT level EBX (number of
siblings) differs on Pcore CPUs and Ecore CPUs, and results in
inconsistent smp_num_siblings value based on the Pcore/Ecore CPU
enumeration order.

Patch 1/7 and 2/7 fix the first two issues. And at the same time, it
reveals a reality that the core_id could be sparse on platforms with
CPUID.1F support.
Patch 3/7 improves coretemp driver code to be able to handle sparse and
large core id, which is the only driver that uses core_id as array
index and run on platforms with CPUID.1F support.

Patch 4/7 to 7/7 propose a fix for the third problem and update the
related Documents.

The patch series have been tested on Intel ICL/CLX servers, SKL/KBL/ADL
clients.

thanks,
-rui

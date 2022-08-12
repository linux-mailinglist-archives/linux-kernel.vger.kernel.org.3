Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFBB5912AC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbiHLPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiHLPMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:12:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7B5A347C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660317135; x=1691853135;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0+YKWHa7B9b2YxlOc73g+pYnEyto0HY15V9J4Qg+RlE=;
  b=CVDoqOtaezJDOG7KAm3zgMEW5zYrshn2FL6jQrgrNIfO6GrJ4+Nm/B0S
   45wm59qeyFVppo613uG8ywMhe7t+DJ34RTEu6IBe2wrK0ZXGi0lhrEuM3
   SbZprxbS9E1sxQdx0bnPC2Tw7AF/yL4FGOubj1b2llkvle6GRRrGeeK7+
   57UM3HLc7Zhu2Vh+v0eMp43KxEImrTbDtWZ27xXilGnyBF5G9y9qYAIBi
   vlSMizWKZttm7/phwstjLT9FTlWjepClnO5kEg86SKxs4XOvik9wNe7O/
   PbZQW10rNHAsAP2zMTEyo3g+uN0ejjfeLx/vvDpJ1fE8+/kEybuyXbP+t
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="274667330"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="274667330"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 08:12:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="605940036"
Received: from kokhaulo-mobl.gar.corp.intel.com ([10.213.45.243])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 08:12:10 -0700
Message-ID: <a2fc8901e4fab5bde5e0ac3f4973e68b1fa83a0e.camel@intel.com>
Subject: Re: [PATCH 0/7] x86/topology: Improve CPUID.1F handling
From:   Zhang Rui <rui.zhang@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Len Brown <len.brown@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Fri, 12 Aug 2022 23:12:02 +0800
In-Reply-To: <41fc865a1e207ea03e15067c06856a92c58e18f6.camel@intel.com>
References: <41fc865a1e207ea03e15067c06856a92c58e18f6.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend with x86 mailing list.

On Fri, 2022-08-12 at 23:08 +0800, Zhang Rui wrote:
> On Intel AlderLake-N platforms where there are Ecores only, the Ecore
> Module topology is enumerated via CPUID.1F Module level, which has
> not
> been supported by Linux kernel yet.
>=20
> This exposes two issues in current CPUID.1F handling code.
> 1. Linux interprets the Module id bits as package id and erroneously
> reports a multi module system as a multi-package system.
> 2. Linux excludes the unknown Module id bits from the core_id, and
> results in duplicate core_id=E2=80=99s shown in a package after the first
> issue
> solved.
>=20
> Plus that, a third problem is observed on Intel Hybrid ADL-S/P
> platforms. The return value of CPUID.1F SMT level EBX (number of
> siblings) differs on Pcore CPUs and Ecore CPUs, and results in
> inconsistent smp_num_siblings value based on the Pcore/Ecore CPU
> enumeration order.
>=20
> Patch 1/7 and 2/7 fix the first two issues. And at the same time, it
> reveals a reality that the core_id could be sparse on platforms with
> CPUID.1F support.
> Patch 3/7 improves coretemp driver code to be able to handle sparse
> and
> large core id, which is the only driver that uses core_id as array
> index and run on platforms with CPUID.1F support.
>=20
> Patch 4/7 to 7/7 propose a fix for the third problem and update the
> related Documents.
>=20
> The patch series have been tested on Intel ICL/CLX servers,
> SKL/KBL/ADL
> clients.
>=20
> thanks,
> -rui


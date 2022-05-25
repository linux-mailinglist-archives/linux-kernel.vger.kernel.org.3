Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54B3533F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiEYOvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiEYOvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:51:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A556CF41
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653490262; x=1685026262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SPVKY5jn4vOqp7Zp0zGdbKJTsQST2hT5XGvvO3JQ2ik=;
  b=WBDMZ0xGXcie/Y2fohSvvMmjPFytoQ2fwzN9XVw6ruGRNQANCzBWe/hD
   u3oDg0awJigZKc124havW52d3uHsJOEqLoBMNI+vRoTi+SpCQLKcvH989
   xHhWzFs8HRzleGi5OzGiYmwt3nCkkyegLqMeihd5rN34i27PTMtQED5UL
   I/y+VZOVPeiMabl4iCTPshg9Noz+o1yvLvquwutAf1WhUGsG+9ysGDQex
   k4JMXIqNfs1tCNSSwDzFdHWqdciWsr3f94zoi8OdQ7nsV3oxwRCHtfOS3
   C8Oj0UxJD1DQH1zmuAFD+2yWmP/O3FrfP8MYCbGaNd1Ui6RLZdyHwgiTZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="273557877"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="273557877"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 07:51:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="676894917"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2022 07:51:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 25 May 2022 07:51:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 25 May 2022 07:50:59 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2308.027;
 Wed, 25 May 2022 07:50:59 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 3/3] x86/microcode: Taint and warn on late loading
Thread-Topic: [RFC PATCH 3/3] x86/microcode: Taint and warn on late loading
Thread-Index: AQHYb9MymCkCxlrsw0uEltRD6R05Oa0vn7QAgAAKeYCAAAHSoA==
Date:   Wed, 25 May 2022 14:50:59 +0000
Message-ID: <4644ff0530ba40948ed1f0e2e45a24d8@intel.com>
References: <20220524185324.28395-1-bp@alien8.de>
 <20220524185324.28395-4-bp@alien8.de>
 <Yo2ASBAElqrQvzh3@agluck-desk3.sc.intel.com>
 <20220525065940.GF2578@worktop.programming.kicks-ass.net>
 <Yo3cpb1yZhwhHEga@zn.tnic>
In-Reply-To: <Yo3cpb1yZhwhHEga@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gVGhlbiB1c2UgZWFybHkgbG9hZGluZy4gVGhlcmUncyB0b28gbWFueSBmYWlscyBhc3NvY2lh
dGVkIHdpdGggbGF0ZQ0KPj4gbG9hZGluZy4NCj4NCj4gWWVzLCBzaG9ydCBvZg0KPg0KPiBUQUlO
VF9ZT1VfRElEX1NPTUVUSElOR19EQU5HRVJPVVMNCj4NCj4gd2Ugc2ltcGx5IGRvbid0IGhhdmUg
YSBiZXR0ZXIgdGFpbnQgZmxhZy4NCg0KQXJlIHRhaW50IGZsYWdzIGluIHN1Y2ggc2hvcnQgc3Vw
cGx5IHRoYXQgeW91IGNvdWxkbid0IGNyZWF0ZSBhIG5ldyBvbmU/DQoNClRoZSBPVVRfT0ZfU1BF
QyBvbmUgYWxyZWFkeSBzZWVtcyB0byBiZSB1c2VkIGluIHNvbWUgZHViaW91cw0Kd2F5czoNCjEp
IENvbW1hbmQgbGluZSBhcmd1bWVudCB0byBjbGVhciBhIFg4Nl9GRUFUVVJFUyBiaXQNCjIpIEZv
cmNpbmcgUEFFDQozKSBXcml0aW5nIHRvIGFuIE1TUiBub3Qgb24gdGhlICJhcHByb3ZlZCIgbGlz
dA0KDQpBcyB5b3UgYWRkIG1vcmUgd2F5cyB0byBzZXQgdGhpcyB0YWludCBiaXQsIGl0IGJlY29t
ZXMgbGVzcyB1c2VmdWwNCmZvciBkZWJ1Z2dpbmcgLi4uIHNpbmNlIG5vdyB5b3UgaGF2ZSB0byBk
aWcgaW50byB3aGljaCBvZiB0aGUgcG9zc2libGUNCmNhc2VzIHNldCB0aGUgYml0IHRvIGRlY2lk
ZSB3aGV0aGVyIGl0IG1pZ2h0IGhhdmUgY29udHJpYnV0ZWQgdG8gdGhlDQpPT1BTLg0KDQotVG9u
eQ0KDQoNCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57B0546C29
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349996AbiFJSIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbiFJSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:08:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C6C43
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654884503; x=1686420503;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Hyb687MPpzGqP/P/gB+up5cmbGvi27zaeMhKDal5GUM=;
  b=QESOfIcdst5oWSnzDkpuYpGRoxleO2ARmhjOzi7CSB8qjZL90yU5CoKv
   LnWYIFXDtjks+wz7x9KfOm6B8jalxJWLSqAbMRUl/fwvysMd/eEXLYPfM
   C7lO9OOurhg7rl5JPzIbZqYAveuh3wMYvPz5YwCBYBta9tOPccY5gdhjU
   oHC95ExdZ+ULFVdENnScWHeylCNTbei1C6JjMrtXAnKDqWqKuU5q/Xrhb
   m1Xm1Go2AdtgRQzzsmCkVaBZFon+na+je/hT9LsE0qW8KtKSootEp9G6S
   0/GN2TFRC5s4qglJxCy3N/1TWEinVSgEefV20UTiR57DXGvo0pwRlTQPc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="275232700"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="275232700"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 11:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="586319977"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jun 2022 11:08:18 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 11:08:18 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 11:08:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 11:08:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 11:08:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMDurPMy/yBWbGlVUI/SrYwVKqawwn/2BxoswZBIeqthWAHLnalJbegioDPyhGubPibmQUyUn4NrDrUKLOm3yZTXkulXFOBXSnKDBNJ7vSYPYMKo2oPfDGvXNwhYbeMJ4YpjxEQ/ZMAFceHAWuxBFeJ8DIsNZRmZUFjGqQxp+FA3FMfAkq5ano9EB2IIDTwV33mBJ8wu8DjYB8iFyh6FbRwMvrv7pP73fwsNLIA8qMCfgTMdKjYm3EW8em1EQ62voLKCP9EwJsj3Fg7XuINEP1kfYiz/73+XRxJsvKERa0hK6C2FvjSwp4os+Hc0tOasixL7Zyu2RHYfPSXk0r2ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hyb687MPpzGqP/P/gB+up5cmbGvi27zaeMhKDal5GUM=;
 b=lQbUFza958wLVRKgyLRtdR2Mw5MJR8Ra0cVVDU/N1V/rQpHTTVE6gFTrTsRCY0rsrDlPKaJLAb+mJPJjtcSFcbA/pvQR0oa4as6asMzcTJltQWSlSptwI/ctN+NPBn7wKeCLihkMQihKRNGoCInzGhz5nrabP2/3OrdAZaC3dlQBHP+f63nUwXy16fA1yrd3WQ6aEAN+RO9Lhu0CTn1Sj21jCm9nQX/FGbDBBxtgWcv4rcp34UsdarqrMBJo4SDL5dOpzgD8xthhngrx+b/80MAvEmH51enrAKsfERWj5vJGDqMvIcOxYcTfUDpWJneDczMGVLso9ogTXKHQCfUzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN9PR11MB5548.namprd11.prod.outlook.com (2603:10b6:408:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 10 Jun
 2022 18:08:10 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4%11]) with mapi id 15.20.5314.019; Fri, 10 Jun
 2022 18:08:10 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Thread-Topic: [PATCHv3 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and
 ARCH_ENABLE_TAGGED_ADDR
Thread-Index: AQHYfNjBqEEvHjFqM0aC2BTrZ5Vx5a1I0Q0AgAAe5oCAAABwgA==
Date:   Fri, 10 Jun 2022 18:08:10 +0000
Message-ID: <5b56c88e477d879e5a0e3c15627cb05901a812f4.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
         <20220610143527.22974-7-kirill.shutemov@linux.intel.com>
         <c3b4f3ccf8ee547a588bf8a971064e4d62b6a44c.camel@intel.com>
         <20220610180635.l44opq2votd3gxpl@black.fi.intel.com>
In-Reply-To: <20220610180635.l44opq2votd3gxpl@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f33aff6d-9ece-4650-bb57-08da4b0c2db6
x-ms-traffictypediagnostic: BN9PR11MB5548:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB5548F490CF8876C8A100120DC9A69@BN9PR11MB5548.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Bwog7RtwbBluAY7pAJ3QWkm7S1cR+hVhN5ok0Hjs+tykjPpmsZ9Y4B/K9HlXvZDotoUVwF2t+T3ExQDUYS+mnrHWsjMbYDPI98nAglPSag6D2iI7TTeLGlzQk1Yn4RrXU19RBeLKpsPzXivfQJtd6Jecx6+plsHBhrFuqycbKotHTCvtlfNjeo95jBxx0jqhKZqHqlSCVdiKCFIqWFQDpLFpZ0EpfndmqcrS0WeSWODGhIf8gG5OVfw8mBYeOZElNlOeTaqJSkxHPCCVyIruMnTwCVAavqy2hQFJ/PXH6tRGZqNqztDlFVXTezp8xLF5nbTKfiQZgmNIp2pVt2gv305GVqpUEGkDBqsIpZjHX5NCsYD8HrDIfuzZM/9+Akma0hPX99zZ9vLBtB6jM4ygwjreQy+5wkbLrGfV/rRC7qOWgtfWn4t/0DnZ/53IShthlwBda61YuX5LxXyeN5MTjKVugZ5nVGilRnzzPU1z+S7oXTvr0Gm4K0OZ8yYLfFGOeP3iORpsdaqijoO9osFmx3mPRkBxAr3fIgGPYgoJMxFvAkXBZpxl6xsjqw6MR9IifgLjF2qfDSBml7J+RiWjx94EfWtoAdefvzvHbHPQy2yS/13VllrUKG8iasOYIC5VM+6fKSD7DLF8jKj+URsCkScKkJnUCLBLWWCFbzAGr2GQljcgDhjZmKBBBBRuQ/TBKV6Z8qGZEVON3Ul56fTbpk1nggkTucFPGBW2ebzVGY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230015)(366004)(38070700005)(71200400001)(86362001)(186003)(8936002)(2616005)(4744005)(7416002)(36756003)(6486002)(508600001)(83380400001)(82960400001)(4326008)(26005)(122000001)(8676002)(66476007)(76116006)(66946007)(66446008)(64756008)(2906002)(6916009)(316002)(38100700002)(54906003)(6506007)(6512007)(5660300002)(66556008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UThTdjV6aEs4WXdnbUxocFlQZHhvQlpJRG1aMUhLbEJLVWNEeEFwcG9tamU1?=
 =?utf-8?B?N2JkNzhvZTRPRTdtaExRRHRiYWVCMDB4ckNxdGZ2bHBCVXJQWTlSRXZlMHVG?=
 =?utf-8?B?a0g2YkxaZlVmZFU5T1hSSkQrMmVFQ2c1RVFLMnJxa0xNaGpPYWRpOUFiUUtW?=
 =?utf-8?B?RVNYOVh4V0dqeEJzeng2WDBjOVVPYStJQWoxRzFCdmxIWDc0bEZleEdEWDdM?=
 =?utf-8?B?YWh2Zlk0S0hwRlhUVlM1Y0FyU3RyU294Q2ZVV1Jxelo0cTJUK01JaVlESEVq?=
 =?utf-8?B?SnZlUFlqNlhiWFc1dklvVTZCcStOODhTOEFCYkRJOTJvRERXY2ZTWkEwVDhK?=
 =?utf-8?B?NkJWaVRWUk1MYnhTamRCOHhpRlo2WUVJeUVWN3c2ODByM1NWMEpTZ000ZDFs?=
 =?utf-8?B?SFJhWWdlaVdndU50aXAyaXluaDlCQVNxOW1QZ290UGJIcnRYYjkwRGFDZ3Uv?=
 =?utf-8?B?WTBnenRhLzdQNDlONXdvaW81MTU2Y2RhUzMrS2xLVXBTdVMxeVBTZVBSZ0xy?=
 =?utf-8?B?bEpURDR1b0owYWVLamtEMzZIWExOU3BsbXEvNmNQam5WUHQ2MXVMcDVJVFpa?=
 =?utf-8?B?bXlkVVIvdTVCZUhORkFiK3VTbEdCSDNCWk44RE9EU1BLYXpEN0hWOEh4T2Vu?=
 =?utf-8?B?RmRDV2czT01tL0JpeVRJZm1ScWVaYWFIV0tFSUlnNE5TSnFERk5qamx3UGRB?=
 =?utf-8?B?SExRb2JOaXFSd05Ca3RIME15ckFYV0wzRlAvTFkwMkpRVlZoRDByaFBacCsx?=
 =?utf-8?B?ODExU0xXNS9oK0xYVFcveTRwSHh0eGZWclBZWUpNR2V3SVlJUGJON0Jrd2R3?=
 =?utf-8?B?WWx6eXZFVy9Ka2l5Qi9wck1BL1FIUXpYUCtGUEI3NTZUai9nenAzUUx3bzl3?=
 =?utf-8?B?dWdoQUVVWFBiempCU0UvNC81K1U5Y1MzYlJxclNWc042YjdZVFMwWEY2TDZY?=
 =?utf-8?B?VUJ1NGwyRUZMdVFWSWlTdEo2OFZ0dTRmenJYRkh0ZjhONThGZmJheWN5eW1H?=
 =?utf-8?B?c3R4NFlWUU1CRm56UlE2N3p2MXVXTVFjSC9KN0VONDZsSm0yR1pueUNFQ3Fa?=
 =?utf-8?B?S0VqSTB0MHJTcVFad2J1Rzc5Ni9rYS9pdDR0dFYzcG5pdllSY1ZKK1Y3eUtk?=
 =?utf-8?B?N2tqZ0hKd0pWK1FGMjJDNi9PZ0NpVzBjUm4zRkhLVDRzQjVFd3FuTVhYTnow?=
 =?utf-8?B?amJzdGR0ODR0cjNXN3BsWFRiNGRSSmdkem9qU0RCWS9NYTM0Qk44RGorR1pZ?=
 =?utf-8?B?S3hKR0JjRDBFMmZzSDluSVI0VW5USDNPL1dHdGF2SzVxZHFaT0FwbnVrSElZ?=
 =?utf-8?B?SU03bkxLbzRxTXpLTlNXRWQ0WTY3Sm5aV0xmOUJ0ZHg1WXc3L2hMcUJtUzZZ?=
 =?utf-8?B?MzE4ZEp3ZTNrR0ZrOHhsa25wVEJaaGVkWE1XYS9lem52VGJXeDQrcUx0NHB6?=
 =?utf-8?B?N2ZmQ1VUL3B6QStrQmNQemkvVGJiSUlVcnBLb1pkanV2ZWdqYndPWFNvYXlJ?=
 =?utf-8?B?NFlEQWE1Um02ZzdueXFwSUE1MHBhdzRMQ09HL1UveWY0NFYybWRPWW94M01L?=
 =?utf-8?B?ZTNnVnMvdkQxS21ZbVUrUlgwaHZsbVJpdEZheDEzWFVTSlpGbFVVYUFXZWFq?=
 =?utf-8?B?ZGtTYW5tTmNGVXBUbW1PaHVsYVZJTmd4OFZzYXdkVnUrOXMzd2JqZ1VGaTJE?=
 =?utf-8?B?d2ZaVmxicDlLd1hyR0lrZ2tQQWxFL0hscU1UbXRLVEE1TGlQaEdCQ3BQZ2do?=
 =?utf-8?B?TUI5anQ1d3Azb3NJRU9FSmVwVjZXNGEzOUg1SjY2S0lwYXdFY01tVGVPK0h4?=
 =?utf-8?B?QTB4WXh1WW1GQkp4b2laMk1nQW9GR1FQZS9ZcU5yYW1GZHFYb09HVEJERnRC?=
 =?utf-8?B?d0xZZmFMQWNSYXh4VCs5VDd2V0xGK2w0Uk9JOVFzRG1tS2VETFBIZHFNUmF2?=
 =?utf-8?B?dXNEbkNoZzFLOHJXWDFHWDBmeE9UeXNLV3JvczRuMmRJL1BKVC9PYllFVnpv?=
 =?utf-8?B?c3k5Qk1hRW9RMndwTWgraWJOQzlQd2FXVWNDUmtrM3E1Z2ZxNjM0RXFmUHpF?=
 =?utf-8?B?VmxYallZVUVMdnhZdks5WllHVWowZWtwSklaUm1DVVc0RTNNMS9sTlBVejBa?=
 =?utf-8?B?YUltS2dxVlVOZlBSUkVtSGNBbUFBcVlFOURVU2FXc1BnY3pHUzNXcHRUdFBH?=
 =?utf-8?B?dW1rNEZzQlFzMVdNR1RuZHBRM29FaGVLdFhhL2FIQjVaKzd1UVFEdEQ1RDBB?=
 =?utf-8?B?RHU3VVN4dUhRL3RrWEtMTUFjNkZFcVZVcFMrYW5IVld4YUFuODFoKzdxNmxM?=
 =?utf-8?B?VXB0Y1EzcXdxRG9sdmN1eFdHandvcFYxeVRoZFkwUzJYc005ZzN0L2JMQnRG?=
 =?utf-8?Q?6+Kn50hGhMI+YXXS5TaDaOBvS4/e58fkUYZiS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB59AC866827C04FA3D7AB5A42F90FFA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33aff6d-9ece-4650-bb57-08da4b0c2db6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 18:08:10.4831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTD+dOThJMIwQ0Ry4j7gjSXSUFM3bMyx5NqM1KQeJHUF4d2pk+I+xM2FPmf0o9fFAKoVun0b0Bp2Jmasb8F3CdVUjEu1gNGlQOP8BRvrUGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5548
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA2LTEwIGF0IDIxOjA2ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIEZyaSwgSnVuIDEwLCAyMDIyIGF0IDA0OjE2OjAxUE0gKzAwMDAsIEVkZ2Vjb21i
ZSwgUmljayBQIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMi0wNi0xMCBhdCAxNzozNSArMDMwMCwg
S2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPiA+ID4gK3N0YXRpYyBpbnQgcHJjdGxfZW5hYmxl
X3RhZ2dlZF9hZGRyKHVuc2lnbmVkIGxvbmcgbnJfYml0cykNCj4gPiA+ICt7DQo+ID4gPiArICAg
ICAgIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tID0gY3VycmVudC0+bW07DQo+ID4gPiArDQo+ID4gPiAr
ICAgICAgIC8qIEFscmVhZHkgZW5hYmxlZD8gKi8NCj4gPiA+ICsgICAgICAgaWYgKG1tLT5jb250
ZXh0LmxhbV9jcjNfbWFzaykNCj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0K
PiA+ID4gKw0KPiA+ID4gKyAgICAgICAvKiBMQU0gaGFzIHRvIGJlIGVuYWJsZWQgYmVmb3JlIHNw
YXduaW5nIHRocmVhZHMgKi8NCj4gPiA+ICsgICAgICAgaWYgKGdldF9ucl90aHJlYWRzKGN1cnJl
bnQpID4gMSkNCj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOw0KPiA+IA0KPiA+
IERvZXMgdGhpcyB3b3JrIGZvciB2Zm9yaygpPyBJIGd1ZXNzIHRoZSBpZGVhIGlzIHRoYXQgbG9j
a2luZyBpcyBub3QNCj4gPiBuZWVkZWQgYmVsb3cgYmVjYXVzZSB0aGVyZSBpcyBvbmx5IG9uZSB0
aHJlYWQgd2l0aCB0aGUgTU0sIGJ1dCB3aXRoDQo+ID4gdmZvcmsoKSBhbm90aGVyIHRhc2sgY291
bGQgb3BlcmF0ZSBvbiB0aGUgTU0sIGNhbGwgZm9yaygpLCBldGMuIEknbQ0KPiA+IG5vdA0KPiA+
IHN1cmUuLi4NCj4gDQo+IEknbSBub3Qgc3VyZSBJIGZvbGxvdy4gdmZvcmsoKSBibG9ja3MgcGFy
ZW50IHByb2Nlc3MgdW50aWwgY2hpbGQgZXhpdA0KPiBvcg0KPiBleGVjdmUoKS4gSSBkb24ndCBz
ZWUgaG93IGl0IGlzIGEgcHJvYmxlbS4NCg0KT2ggeWVhLCB5b3UncmUgcmlnaHQuDQo=

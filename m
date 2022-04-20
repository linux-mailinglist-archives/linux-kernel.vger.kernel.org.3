Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3265B5093A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 01:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383241AbiDTXhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiDTXhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:37:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83C92F03A;
        Wed, 20 Apr 2022 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650497665; x=1682033665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cGwZaw/8dd4eUVO/bIsRxI1Wu5t/vKOnuW+hOBkWJi4=;
  b=eyR/3o5iBZ4Xm2nNCJqhOWPZz6g9H5fUSE1NszyvYqpD3hrzwQvTpHMW
   k7K+WMKqFrMhAk2YWC0nPVkUVrh78d45Hm4nkjYCyhMEPsUz8yD2SECpp
   TG8+LfL62IHYTU6fpfDUu8zO63YJlF905LmF6M+TzqQr2P/9K5wo2mSR4
   937/J4tVjHJ4sEhnhfc7btF9H8W8lXcVlhRCAnOve2rQINfuIMdYXjS7A
   SSKZcCuX9brroJKWNSCGDcRq9i+y8yzyZw7ba9YKxCWW3zmYPFaN4oXYH
   mU9qwQQZGZwqg1w1WMXdiAVRUDHe9rQC93puoG/z97mRQH4cflcrA00cm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246068124"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="246068124"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 16:34:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="669326179"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2022 16:34:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 20 Apr 2022 16:34:23 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 20 Apr 2022 16:34:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 20 Apr 2022 16:34:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 20 Apr 2022 16:34:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBanFcU+z9QI688PMmONYirHL/mGmFinUvS+8qRt/laCgeFqtl7jRp/s5wUCmUPjfCpEK9K9fMCMiWAoflGYKopoLcZFgmWsEgsaX1h1QhE54JBh7lSaQOUynJGSOMh3mld1uMAGeX9CqWlNKKFJ9p9iDXSspT58lewk+aDRqwZ3zteZ91nytK66hAqGMCrukQLLIPFF3lBH5X8S9g0g1ryR+Wz6jFWbxDwDp5pRgAdgd+EWwGVLEMuQT9LIM7QejGk5M43dHItwyQtY5z/APDq4Zcz+8sfmRnjNHD4cjuE3DQhKSsIoO8D8dxYSn/BlFxmwSyUVUbPaQ2DrJHbMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGwZaw/8dd4eUVO/bIsRxI1Wu5t/vKOnuW+hOBkWJi4=;
 b=VX6kARe+b0NJ4FEgchHjvWpi1R/Jy9B5f2No/huQ6pMsgiFfyzypXBi8yk7urBhrxKC13YVQuYvRPlvOKcqe7levc7hDxngwlMKOzJaoWR26pQl91JciAj8c2rdjtiLVQCVskVlBWDvn85rzlFD5Z2zRYtd6W1oQAla7D9YaNWUpwxZT8ZostoljlNMmQw2rJgbfQ7OyeLOfdnJVnMCGMtfa4egh14HBvUTudleSCDF3HnpEhM9BZG0cfZecviV143c2WFMuGrpKVuySMuswQKtmGGlM+F+IO54bdl3XcFUIamgVMPxwrRHFAMI35MCCbYLt3erOr66wC4rdv+NOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY4PR11MB1432.namprd11.prod.outlook.com (2603:10b6:910:5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 23:34:20 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b%3]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 23:34:20 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>,
        "Poimboe, Josh" <jpoimboe@redhat.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alyssa.milburn@linux.intel.com" <alyssa.milburn@linux.intel.com>,
        "gabriel.gomes@linux.intel.com" <gabriel.gomes@linux.intel.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
Thread-Topic: [RFC PATCH 00/11] Kernel FineIBT Support
Thread-Index: AQHYVFAS4O6JrHiwi0GbhmNrjuX0Aqz5da+A
Date:   Wed, 20 Apr 2022 23:34:20 +0000
Message-ID: <e57e01bb682da9443d0ad6e29eeb69dac22e2ffa.camel@intel.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
In-Reply-To: <20220420004241.2093-1-joao@overdrivepizza.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90d232a9-e314-452f-495f-08da23264b5a
x-ms-traffictypediagnostic: CY4PR11MB1432:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB14326269C5A0DBDBED2484EDC9F59@CY4PR11MB1432.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2nrAOu9Q76E2QL/NeZ37Ys34su9cNUI9Q41rVinBN/4gNlmRHJLdgNTUPN5Tik5GvQIEmdfV4OZfWPt65hYXizkHzSQSMu5ntdHk29dIbzKXlug1KGG7Cf6PPrchoeKW5T06Q4WZJCkCAhDpAZTvflxGkBz44GNIJ/BRVaVQUS4fX/rv+kg9MgZsi47BiPmQbqodEHU0U8eV65UvjNwYyt4fhY44DjiWT0sromHWuFrqJWoVGvxZul3Sbpc6TbVYUxrofKf3KPNphDRvkFtspnpmpg+sB8zAgunchVkoAS3SPzHmGG4xWuH2IKuRnR6iSHJ3dxNv9BbHtp0+LbxHs+nTor1FXdATTSjpRn2UnAqfN+WjorxFrnVnjeZWb71XrFoLwPhyhA6gS4RJ/KbUE4S6Au/PLRZ+Od+kKAXEVCulok2iET4tSHwVs/GitAfjOiH5B899aMK+EbJWgeD91x331sw/JUvWZvRJtZvXH3KENkiuHrO56XKB3XeiUWTxiiTeS7yqzWgZvl4IKYuwYeChiexLH5J/bvs8nBL99UpQypxSfK4+Qzht5mkuPAz+zHS1OTzqTRjmvLLfHzkw+iDXH4BF1W6GmzGzfb+Hy3lHnDF1Xyi6kgQvS3srf+c/yrov89B49NHsZoxaaRg6turwNenNM0ebQKSBkbRLHCFeplzCPHLuqXTLaPfIiOahnlevziCuwcswg58jWi5KuXsDM/Ry8FW2XuhsUOiTfYs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(66946007)(6512007)(64756008)(66556008)(66476007)(122000001)(316002)(66446008)(38070700005)(4326008)(8676002)(6506007)(91956017)(82960400001)(5660300002)(76116006)(86362001)(8936002)(38100700002)(186003)(36756003)(26005)(2616005)(6486002)(110136005)(54906003)(7416002)(83380400001)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ymxzai91OWhWbEhxOTlPZGxqcWJ4MXEzeFdjM3BscnlNNFVhV3B1UXZiWWdX?=
 =?utf-8?B?emMxVDh5dkxyME1wZHM4NUJrYXAwVnVveUNyRWE5VjVHK3RNMVgyNnV3OUxK?=
 =?utf-8?B?R3g5TTV1MnZLOTdJcGVPSGJOV090MmVnaFplN0E1c3hSaG5iUUQ3VDY2TzJp?=
 =?utf-8?B?eDlDNmd4QzlHS2w0dTMyRUhpM0FjTmFxbkdOcmhHc3NlTzdTdXN5TTlzZFZp?=
 =?utf-8?B?d21wL1RoL0ZWU1RiVnNBTUt2WkcyZzNhN2RJK2JRRUtjQktKVkRRL0xNL3I1?=
 =?utf-8?B?aHRIV0FLNzVMZFMweU0ybVFuZkEveVRtNG4xb0RNVFNwZSsrN0paRnlHclg3?=
 =?utf-8?B?K3RwKysvTVJaZjcxYzBsNTVTTmsyMElGb3R2M2FUNDV4WmNEbFd6QWZOSWZh?=
 =?utf-8?B?bGc1YVJ1YlNKQ0VES3FoNWdmVWVnOHBCenNEdWdUN3ZkOGREN3ErV0dINzIz?=
 =?utf-8?B?SnExbGR6bTV5RlRsQjBSRGNzZmNMUEkrMStvRmw3RkpJbHlwRHI4L1dqS0Ja?=
 =?utf-8?B?K05MOW43L29NK3VlU1FlcVRoRUFPR2dVM2hjYndLTEoyNDR4N3pzMVgzVHor?=
 =?utf-8?B?M1JlQjhUUkxHdUhWdjdlUkJhaWpLNElGT1Jtc3gzOS84TU91SW5oQXJHT0gz?=
 =?utf-8?B?dFYxU0QwdXRQZEJRZ1JuR3crNzVjOVFGT2pLRSs5a2NHNEhWelE0dldzSmtP?=
 =?utf-8?B?MCtVdGN3ekU2ekJ0TmVxMXRjOHdqQzl2dmlJTGU1b1FhY1BoeFZaUUlBbDZI?=
 =?utf-8?B?ekI4d05UY1ZCVlg0a2hzbmtleTZUQ1lMdFRyTG44QlJ1QWRrU2tJckJKaW84?=
 =?utf-8?B?bERCOUxOeW0xN3JVVG15YzBWOVplU1Z1OUIveXVUYWRadFU3OGxISUM1YklV?=
 =?utf-8?B?cVltMDlpT3lrRTdSazJsNmNnUjRQZDdjVmZ0VzUzblQ2T3RoYlNPZzJUMVRh?=
 =?utf-8?B?SlBnWkQzbXE0OThXbDlPRzB2NExKZFdvaWE4d0d2MkVxQlVlT0J5YW5tdUNv?=
 =?utf-8?B?SkFkd3hLem1QckFWa3NaR2FkU052d3RpcXBiWnJRL3dNTGJrdkVPQ21hYS9t?=
 =?utf-8?B?NmtvOHpOanMzbzJlS21JQlhnYWExU01NRUhjcDI0WmsyamVWQ0Q1WWZ3dW5R?=
 =?utf-8?B?VmdUTlFiMUhhL1Z4dGRxR2tIVWZ0dEEwdjRHSGZYNFl4QnBiamp3ZUdaYTkx?=
 =?utf-8?B?cWQyZ0QxWTY0N3cvY01ERzViUWg0TnlxSms1WVpzUjZQbjlQRmRSOXNkZk9k?=
 =?utf-8?B?bkFQSERORkRIUk1FZGt1SjFCWUdKV3RwVkZKZGtRNFFnMFcyUmNkUVM0ejds?=
 =?utf-8?B?Qmp5ejd5cVNpV1hmdTRBMzZ0NmdNYkxQWUR4VFZoV2t5am9wTVBxeGVrVUdN?=
 =?utf-8?B?K3Z4ek84aHl6L1ZYYTRUTWdPTk5NbzBwUFVMYzNUYmZhejBNd3Q0WDJzZlI2?=
 =?utf-8?B?anVkenZwQVFYSDl1VU1zTE9tYko0K1ZCNkduK2J3OXR2cjJxdDdRcTgzMGtq?=
 =?utf-8?B?MVVyckdSZ0xuV3BYSFQxblRaamVEU1BLZ0dEOGtkVERBMWpMRWxIU3BNSVpY?=
 =?utf-8?B?My85K3dzVmpyTlFQZHJ5cGc1Y083TzVnZXdQSGpjMHVpRlMwNG92dDFBcWtr?=
 =?utf-8?B?MW12NFJJSnFnYkxiYTgyVjRBWFdOTEs3N2d2ODJlU0lpYks3cXc0ODlwcVZz?=
 =?utf-8?B?SFBEV3ZYRW5qQVlKV2M1ai9Wdjh0azhONEVCOGFvLzRtU2dxdWpzeWV3UmRS?=
 =?utf-8?B?UVc2N3RiZlFCVlRaOHNLaW52RStyM2had216a1VDM2VuNnB0R1RZSndiSzYr?=
 =?utf-8?B?aS9lbUxheFk1eU1DZ3BLb2ZBRE5tZjMvMWtocU9PZWtQUXVDc3BucVlHNkZs?=
 =?utf-8?B?QlkxdVFaYnp4S3NiZXZyalVuTUt2V1NvTmxKN25Db0lscFFLZzM3bG1ReHFn?=
 =?utf-8?B?ZmpzRW5WU09FOTdSaWFuQUFYdXZyU0lVL3I0SXpxK3hDSU5NSGV2UWwwdndv?=
 =?utf-8?B?NkxRWFZQeUcrMlFxSmxIZGltOE9pcU1kTklIa1huRzE0Q0p3MUhod0pvNXhU?=
 =?utf-8?B?ejBFZnFxRTJlVE5INkhTc3VVbjdGeTlpL1VDVk84Tm1pTklsd0dndjVrTFNn?=
 =?utf-8?B?dGpPQXA2WTh0bEVsNWtLNDJnU3A4OU5BTFBMM0RUUnFpUE1tWkdqNm0wNzU0?=
 =?utf-8?B?VkQ5SVBWbFlQeFQ4TjB2bkFRMmpZbHJzMmpqWVcvSGF0SGJUaXRIVG8waEE2?=
 =?utf-8?B?TjQ1cy9JZGhPME5OZHZ5NlJGMUZwQ2tFNjFxZFV4NlNhMWtHdnZUYUxZMXY3?=
 =?utf-8?B?LzUvUUJPMjJ4Q3ExZzZNTVBWR01iVjYwVW5zM3Q5a0xLR2dKeXlwVFJRQmlG?=
 =?utf-8?Q?gT6xvCg1rmUAphS6jW4m5h2BcvZzLtdD8eHKZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E116317806870F4FBD97B86F7023039F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d232a9-e314-452f-495f-08da23264b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 23:34:20.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3jYOcwqjXZvXCH+vmMZ9h4Ix4bp+sE5vSViJNxEo2D5j+hhMj0h32snk+rhRaXKSR1biLG6dBqheA9JxYOGYat0871mhJUcsRW+97n+vAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1432
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTE5IGF0IDE3OjQyIC0wNzAwLCBqb2FvQG92ZXJkcml2ZXBpenphLmNv
bSB3cm90ZToNCj4gQSBkZWJhdGFibGUgcG9pbnQgaXMgdGhlIGZhY3QgdGhhdCBvbiBGaW5lSUJU
IHRoZSBjaGVja3MgYXJlIG1hZGUgb24NCj4gdGhlIGNhbGxlZQ0KPiBzaWRlLiBPbiBhIHF1aWNr
IGxvb2ssIHRoaXMgc2VlbXMgdG8gYmUgY29vbCBiZWNhdXNlIGl0IGFsbG93cyBzdHJpY3QNCj4g
cmVhY2hhYmlsaXR5IHJlZmluZW1lbnQgb2YgbW9yZSBzZWN1cml0eS1jcml0aWNhbCBmdW5jdGlv
bnMgKGxpa2UNCj4gaGFyZHdhcmUNCj4gZmVhdHVyZSBkaXNhYmxpbmcgb25lcykgd2hpbGUgc3Rp
bGwgYWxsb3dpbmcgb3RoZXIgbGVzcyBjcml0aWNhbA0KPiBmdW5jdGlvbnMgdG8gYmUNCj4gcmVs
YXhlZC9jb2Fyc2UtZ3JhaW5lZDsgdW5kZXIgY2FsbGVyLXNpZGUgY2hlY2tzLCBpZiBvbmUgc2lu
Z2xlDQo+IGZ1bmN0aW9uIGlzDQo+IHJlcXVpcmVkIHRvIGJlIHJlbGF4ZWQsIHRoaXMgbGVhZHMg
aW50byBhbiBpbmRpcmVjdCBjYWxsIGluc3RydWN0aW9uDQo+IGJlaW5nDQo+IHJlbGF4ZWQsIHRo
ZW4gYmVjb21pbmcgYSBicmFuY2ggY2FwYWJsZSBvZiByZWFjaGluZyBhbGwgdGhlIGZ1bmN0aW9u
cw0KPiBpbiB0aGUNCj4gZXhlY3V0YWJsZSBhZGRyZXNzIHNwYWNlLCBpbmNsdWRpbmcgdGhvc2Ug
Y29uc2lkZXJlZCBzZWN1cml0eS0NCj4gY3JpdGljYWwuIElucHV0cw0KPiBhbmQgb3BpbmlvbnMg
b24gdGhpcyBhcmUgdmVyeSB3ZWxjb21lLCBhcyB0aGVyZSBhcmUgb3RoZXINCj4gcGVyc3BlY3Rp
dmVzIGFib3V0DQo+IHRoaXMgSSBtaWdodCBiZSBtaXNzaW5nLg0KDQpPbmUgbWlub3IgcG9pbnQ6
IEluIHRoZSBjb3Vyc2UgSUJUIGltcGxlbWVudGF0aW9uIHRoZXJlIGFyZSBwbGFjZXMgaW4NCnRo
ZSBrZXJuZWwgd2hlcmUgSUJUIGlzIHRvZ2dsZWQgYmVjYXVzZSBvZiBtaXNzaW5nIGVuZGJyYW5j
aGVzIChjYWxsaW5nDQppbnRvIEJJT1MpLiBTbyBmb3IgY2FsbGVyIGNoZWNrZWQgc29sdXRpb25z
LCB0aGVzZSBjYWxscyB3b3VsZCBwcm9iYWJseQ0KbmVlZCB0byBiZSBhbm5vdGF0ZWQgb3Igc29t
ZXRoaW5nIHN1Y2ggdGhhdCBjYWxsZXIgY2hlY2tzIHdlcmUgbm90DQpnZW5lcmF0ZWQuDQoNCkkg
aGF2ZW4ndCBiZWVuIGZvbGxvd2luZyBrQ0ZJLCBzbyBhcG9sb2dpZXMgaWYgdGhpcyBpcyBhbHJl
YWR5IGhhbmRsZWQNCnNvbWVob3cuDQo=

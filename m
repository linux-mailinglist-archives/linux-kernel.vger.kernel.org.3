Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEE6579202
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiGSEfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbiGSEfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:35:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DCF277;
        Mon, 18 Jul 2022 21:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658205303; x=1689741303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1scWXMtm/rixeFtB1byHquHXnxxjNpNt6HE3lgd9724=;
  b=IW0qta/OxR8XkUhByvWkMmPsmc+cnwmcmrp7OQV7U238QVCfVeS3gmKW
   iI43nnXFjVV4joyLJS5mAEvCKE9BiXw/w6mkASagNVWSW/8rdRLJIH+Je
   rzjOtrw8g+DCxPOwi8EYAur3GiONVnh5UCpTHQUjoohnDlZsUG25HS80l
   mIAYev26TS3VS9BoLgMLP7M6omtsqx6YhiTX8XMibehN8eHupcGPvmH+U
   PoBIU4YcjwjKmL1Xi3ktEr2mLULRBuZiO990+Bca5WRa3wNT6k4ujT4Db
   UsuJmZhL1HuzYspJZNsI9axZftO6TO1g4axM70np9+YBCB5zaOd5feAJV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="283951624"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="283951624"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 21:35:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="655575832"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jul 2022 21:35:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 18 Jul 2022 21:35:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Jul 2022 21:35:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Jul 2022 21:35:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Jul 2022 21:35:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIFEW1et0LLQ+qJ2nPYuQw84BTHrdPXIsy39bh5LfIk0+ew25HMrsItXbVxtH2/yGjDdaCRv5uolHcBm94ELQMu916w7YHafIhSQd9Qo6pMTg3X1LirjnkjIA9MjPdDsuZE/8WAay+5zbaR0ptM6Fwni1e0Hsy7cH2kDE68D2IVq8bX8goqIN6jVtgCboa827TFVfdDMxlUvHQV7WjZMPzmmsXdefCy4ltsMUkViPy+GRh8K7Pm+T5lbM9PM0pbIWsegAiCXnNLRJxSFysvgH+9YcEp0iu2rIvk1t7pJ11Kn1z0AcLqIq31qroR5XDGHDttzxtILmDNDlxvJmlDdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1scWXMtm/rixeFtB1byHquHXnxxjNpNt6HE3lgd9724=;
 b=HbfdRknAsOzaqHM3E/TKxSIf7EE3KXcYuUDeBZsjsvcQWF3DLOxtXbXChHzasrCO8oN4KBORddYvCh/tuN/FpvDyXFLKKU5BI6420Xlm83bTWJbbGkIzXoRu9cNnncwRheSWQ8MXywVxnl0FAsQ2++bhhdMWpAnWrUX7Yy4wVz+ejnmnbSW+gY6eBe9PWjTFfZw/kojQEo6K5+hrHWJ5ovgPF36J/0Ts0ozxF5aZnN4D4cgTChsiuvJbhmErfV19ZMwvszDlscHZbgq9FAeEoYT/MHvATpEgZDklRLVLevSD1MxnmXgyk23HjpEeO1XL1hScLkrNq/wIqbS0heApYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CY4PR11MB0070.namprd11.prod.outlook.com (2603:10b6:910:78::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Tue, 19 Jul
 2022 04:34:59 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::b14d:4da1:a40f:b14%4]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 04:34:59 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu-tasks: Make RCU Tasks Trace checking for userspace
 execution
Thread-Topic: [PATCH v2] rcu-tasks: Make RCU Tasks Trace checking for
 userspace execution
Thread-Index: AQHYmjrwROV6N5Vt90OEhOEhgOcQ0a2EP6gAgACFbBCAABK4AIAAQuxw
Date:   Tue, 19 Jul 2022 04:34:58 +0000
Message-ID: <PH0PR11MB5880375F53618C19D944EB06DA8F9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220718001610.263700-1-qiang1.zhang@intel.com>
 <20220718152132.GE1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58805ADED62CE2AF94647967DA8C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220719002604.GK1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220719002604.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad1f9e82-f2b7-4faf-1bfc-08da694009d8
x-ms-traffictypediagnostic: CY4PR11MB0070:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1rd/B+ahZ4iTtD5hNr1zsbKGVLLcu8QuUssHQRDJ7DpRxuVx9xI0dCPUVrDQgCLAqrbcb9Bt9QmGYRgiZcIz53TurfAwHgTHmEOH6tI58JFXd7+4WWvEeX9k/3I5kAaS4b4uiXMiNkQNh4Wup9OmwVK7qYEC9A96QWHPQ3Ur6V0/XPa6IRf4d/phqtqK7ZMyyCF+vp+kj7lDf7/fNcMC17IutOPuoxLO7hh2N2Wfr/7HGmnJOe0kqbIZj3uN1EPtVJpmvShRT46E3xql0uYatee8MJfdE2WO97dUBUumVtiAMd4Yrt9CQkGRGlkb2kApJUZPTaDw5rHLLR9MfKhZ5vi0Im2j4AlxgFjbaddCZrXrAlRI4TeqGQ9FQmVZfJy1ywtorV85QsELygJJib1S0dN7iqAWANZE2Whfj08bwbNqD2FglnJpdF0IsnqLyL29QupR8nOKrJZ+y783npKLZ05hIWbqlsM0n62UBv+pwod0mrI3Nv2YoQhfHKtm1NVO5973LNKVjxOFy9SPeaqWsVFy/2Qt/FuziGz8fW1H+SqQc/+kh/GmUiHbYKgvBCjriv6SD51PE52GA6BK9RszwEtMYFoH52Z7jbQTlROObSNh0+SprXxG2POTXkL5XV1E8zxVTfmg5TSR2RtZ2PG9lWrTTlpoWBUvx7FQR0OmYEbJS+53cYdG4wTdeS+bg6XeUUpXNAd9VifhdYXYaFNTPPJdQdA0h0Eh1g4Cy0YvrBSf+rwrweM+oiq5mpUv6fN+hjf/9zaNBJvV1A1mz17mk0oDnmNgYEC+SxSbEFSYy5Jm0M9r8M1x6sC/xoHW+qyG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(39860400002)(136003)(376002)(8936002)(5660300002)(8676002)(66556008)(66476007)(38100700002)(66446008)(66946007)(4326008)(64756008)(52536014)(7696005)(55016003)(9686003)(76116006)(2906002)(122000001)(33656002)(38070700005)(478600001)(86362001)(82960400001)(71200400001)(54906003)(6916009)(186003)(316002)(83380400001)(26005)(41300700001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3RMclY1VTJUUlRWQ3I0dWd6bkszRnFVTk5UUEF5cUhXOG92bG92MXk0Q3Ux?=
 =?utf-8?B?OHRnL1IvSWNrb3VNM2I0K1R3NVpXamtQa29KZVVUQkM4UEVLVmZxcWxGdE9J?=
 =?utf-8?B?aURHNTVMM1hna1ZKN0EyZ09SRnQxTUdHQUlxWXNxUnI2bVE4bjE1N0VQVFVV?=
 =?utf-8?B?NFVIRmFnd0JJRjd5MisvUkdjQys0WHJQYTdCOE1ucTErSFM2OGtyL1ptdDE1?=
 =?utf-8?B?d0x0V2tSRGQ0NG8wL0VUTGtBWURiZVdMbXNHT3FmU0V5dVlsK2FhUHdTQk5T?=
 =?utf-8?B?MmkvZmE2RjMxYUtzMFVEU2VJQjQzRUNubmx5QlZWNFFoZlZOTy9zQ3BDejFa?=
 =?utf-8?B?eC95VnpYSEpXaTFCSXRzUEJ1U2l3dm5HUEhVN3BvblBKUzR6a2lHY2EwV1o3?=
 =?utf-8?B?dFBEOGNOV3psMXMybE5OWjN1Z1FMb3hTMXA2aTRiems1aGhIS0dINGx2b0Rw?=
 =?utf-8?B?cjlvNE1IdlB2NG1MMDJDcXFHUTN0VmRBUXZZSlBwWVNqdFB5cUVQQUJrUDlu?=
 =?utf-8?B?OTZYTjQ5V0RwNWtpelFwTlFWMVlxZUFRbjVEaGczT3llWm56emwzcEV6M3lV?=
 =?utf-8?B?OWhoSll2MGhybnJlMEx5bW50Qm5yUlhJZm01bXFEZldwYUkzb2FhVHNhSXBQ?=
 =?utf-8?B?bkh5dUlDa2lGU0ZGb1lXNTVsYjFQVTBmZE05cm9pcUZSQ3VYNnBvdDdtQ21r?=
 =?utf-8?B?N0lESHJyUkIxZ1dKZDBzbDFXOUFJMnZsRE1STXI2R1dDNmQ2Z1dVL1luRjZZ?=
 =?utf-8?B?TWs0UXhIczB6NC92QW1uWUNDUE5WMU9kb0RYdjZSbnQ4bmlhYUFHUUhFTU9t?=
 =?utf-8?B?bDkxVFRKMzM5S1RZTmx6N1pwTWtvalMyL0FXN21ZU0ZWdDVqMlQwS1RQN1J0?=
 =?utf-8?B?SFpDTld2d1pUUExYZlFpSjNNdHBxd3djRVMrUCtYejVnT0djNUpLeWhaTWpJ?=
 =?utf-8?B?bkZkamhCVFo2NndoRVR1Y2xhRVJEeGkwWk5rbmtid3lzbER2RGNSYzVnbUZr?=
 =?utf-8?B?Mi9uQktwbmErQysxMzJCSUpzZEJSVzVsZFgxVnhCRFlNbmxTR2N5U09MZGJk?=
 =?utf-8?B?K0tINWdBMFVMNDlGdjcxR2NHRlZZZ3VpMkJha1JjeThsUHQ1N0htZEU5ZTVC?=
 =?utf-8?B?dXV4U0ZNcGRQckJlV1E0cmFvaGhLTU5MRFFqM3ljMW1icXdoaXh3bjQxbG5Z?=
 =?utf-8?B?SUdGT0ZMbWVqUjlBdnNqMUg1L0lBWFVtaDFXOU9teWNUREM1ZWhLZjlVcnZK?=
 =?utf-8?B?akVlcVNDMFgrT3lTVE9mUEQrSmdBRUVxWExxZ1JRTWN6V3RyWjR2aHNKWnR0?=
 =?utf-8?B?QTI5T2Q2Rlc5NUt2K0pNT1hvbk5YQUVMUWcyajEwTm50eDAzRHlzSU9HclRq?=
 =?utf-8?B?eU0vUFJDYmM4Umk1b2JULy9rR2tLSTVFc1ZJUFFuaVNIRWdhVlRCbjRUUFBa?=
 =?utf-8?B?cFpjNWp1a1dUSGM1anpoaG4vck9NOXQ1dEE1VHc0STZhWFIwTkZsRHYvNmt5?=
 =?utf-8?B?VXZkVkJNREpjOTRtNHYydjdPY3htdzYzUmZFWnAvMW1MK0pid3Urc215OTNH?=
 =?utf-8?B?by8vbFJ4UkRIVzlNMWY2R0VIUVlsUHA0eWdhRFhTOVlPb3Q0UW4yUWN3eDNC?=
 =?utf-8?B?WjJ2cFpTRzlxZDB5RWR1MW5XcDJVbTQxT1lzOWg4aEN1dXgxRkNwQ1lIVGw2?=
 =?utf-8?B?azdMOGZkOUVJYzVRQnhrSGhiV0U2TDJmaFVtblViT2dCSU52RmVMQXpBTjFv?=
 =?utf-8?B?UjRGR3hEZDdPclNOc3NLZU15Yk5pMlJQVVh1SWxXOGJHV0RVRnlPclB6U1Ay?=
 =?utf-8?B?bGxpS0liR0ttUHp3T0RZbGYrdWNoS2Z4akEzWk4wbk81anRrSHBIUU1QUU5p?=
 =?utf-8?B?cnE0aEkvQVl5cWJCVmU0M0pqY2pVTGdwbGlsVitvd0dGR3d4dmV4SXRteStR?=
 =?utf-8?B?eXE3bEdCMkNJRDBxNDNWYnlaSlAwdkJOTHN6VUJreUxpdGN0ZktkMXhqaUFJ?=
 =?utf-8?B?Wm5YSVVlSU5HaDE4RTdzK2YwMUVubk1ScVAwL3N3MVFLejJRdTFZVlBuNEtx?=
 =?utf-8?B?ZEhiallENmNXY29UMWRLQ1JGYm9kblU4bDFjdExrM3ozdUlabnVVUnlHMVBm?=
 =?utf-8?Q?4oUxnulUj1ufkAaINaOBXwG81?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1f9e82-f2b7-4faf-1bfc-08da694009d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 04:34:59.0015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wI/xSy1mo/TxGoIlB0Hgxj6w4v9vo4Th7AXhuVb9ohLi1yioWb47NtU4krFdYP2vp0IcGrZaXHP0CNVQGSH63A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB0070
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdWwgMTgsIDIwMjIgYXQgMTE6NTQ6NTNQTSArMDAwMCwgWmhhbmcsIFFpYW5nMSB3
cm90ZToNCj4gT24gTW9uLCBKdWwgMTgsIDIwMjIgYXQgMDg6MTY6MTBBTSArMDgwMCwgWnFpYW5n
IHdyb3RlOg0KPiA+IEZvciBSQ1UgdGFza3MgdHJhY2UsIHRoZSB1c2Vyc3BhY2UgZXhlY3V0aW9u
IGlzIGFsc28gYSB2YWxpZCANCj4gPiBxdWllc2NlbnQgc3RhdGUsIGlmIHRoZSB0YXNrIGlzIGlu
IHVzZXJzcGFjZSwgdGhlIA0KPiA+IC0+dHJjX3JlYWRlcl9uZXN0aW5nIHNob3VsZCBiZSB6ZXJv
IGFuZCBpZiB0aGUgDQo+ID4gLT50cmNfcmVhZGVyX3NwZWNpYWwuYi5uZWVkX3FzIGlzIG5vdCBz
ZXQsIHNldCB0aGUgdGFza3MgDQo+ID4gLT50cmNfcmVhZGVyX3NwZWNpYWwuYi5uZWVkX3FzIGlz
IFRSQ19ORUVEX1FTX0NIRUNLRUQsIHRoaXMgY2F1c2UgZ3JhY2UtcGVyaW9kIGt0aHJlYWQgcmVt
b3ZlIGl0IGZyb20gaG9sZG91dCBsaXN0IGlmIGl0IHJlbWFpbnMgaGVyZS4NCj4gPiANCj4gPiBU
aGlzIGNvbW1pdCBhZGQgcmN1X3Rhc2tzX3RyYWNlX3FzKCkgdG8gcmN1X2ZsYXZvcl9zY2hlZF9j
bG9ja19pcnEoKSANCj4gPiB3aGVuIHRoZSBrZXJuZWwgYnVpbHQgd2l0aCBubyBQUkVFTVBUX1JD
VS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5j
b20+DQo+ID4NCj4gPlRoZSBsb29rcyBwbGF1c2libGUgdG8gbWUsIGJ1dCBjYW4geW91IHRlbGwg
bWUgaG93IHRoaXMgYXZvaWRzIHRoZSANCj4gPmZvbGxvd2luZyBzZXF1ZW5jZSBvZiBldmVudHM/
DQo+ID4NCj4gPm8JQ1BVIDAgdGFrZXMgYSBzY2hlZHVsaW5nLWNsb2NrIGludGVycnVwdC4gIEp1
c3QgYmVmb3JlIHRoaXMNCj4gPglwb2ludCBDUFUgMCB3YXMgcnVubmluZyBpbiB1c2VyIGNvbnRl
eHQsIHRodXMgYXMgeW91IHNheQ0KPiA+CXNob3VsZCBub3QgYmUgaW4gYW4gUkNVIFRhc2tzIHF1
aWVzY2VudCBzdGF0ZS4NCj4gPg0KPiA+bwlDUFUgMCBlbnRlcnMgYW4gUkNVIFRhc2tzIFRyYWNl
IHJlYWQtc2lkZSBjcml0aWNhbCBzZWN0aW9uLg0KPiAgICAgICAgICAgICAgICANCj4gIGlmIEkg
dW5kZXJzdGFuZCBjb3JyZWN0bHksIHlvdSBtZWFuIHRoYXQgQ1BVMCBlbnRlcnMgYW4gUkNVIFRh
c2tzIA0KPiBUcmFjZSAgcmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb24gaW4gc2NoZWR1bGluZy1j
bG9jayBpbnRlcnJ1cHQgY29udGV4dC4NCj4NCj5FeGFjdGx5LCBhcyBtaWdodCBoYXBwZW4gaWYg
b25lIG9mIHRoZSBmdW5jdGlvbnMgaW4gdGhlIHNjaGVkdWxpbmctY2xvY2sgaW50ZXJydXB0IGhh
bmRlciB3ZXJlIHRyYWNlZC9pbnN0cnVtZW50ZWQuDQo+DQo+ID5vCUNQVSAxIHN0YXJ0cyBhIG5l
dyBSQ1UgVGFza3MgVHJhY2UgZ3JhY2UgcGVyaW9kLg0KPiANCj4gVGhlIGdyYWNlIHBlcmlvZCBr
dGhyZWFkIHdpbGwgc2NhbiBydW5uaW5nIHRhc2tzIG9uIGVhY2ggQ1BVLCBUaGUgDQo+IHRhc2tz
IGN1cnJlbnRseSBydW5uaW5nIG9uIENQVTAgd2lsbCBiZSByZWNvcmRlZCBpbiB0aGUgaG9sZG91
dCBsaXN0Lg0KPg0KPlllcywgdmVyeSBnb29kLg0KPg0KPiA+bwlDUFUgMCByZWFjaGVzIHRoZSBu
ZXdseSBhZGRlZCByY3Vfbm90ZV92b2x1bnRhcnlfY29udGV4dF9zd2l0Y2goKS4NCj4gDQo+IElu
IHRoaXMgdGltZSwgaWYgQ1BVMCBzdGlsbCBpbiBSQ1UgVGFza3MgVHJhY2UgcmVhZC1zaWRlIGNy
aXRpY2FsIA0KPiBzZWN0aW9uLCB0aGUgdGFza3Mgd2hpY2ggcnVubmluZyBvbiBDUFUwIHdpbGwg
aW5zZXJ0IENQVTAgYmxvY2tlZCANCj4gbGlzdC4gd2hlbiB0aGlzIHRhc2tzIGV4aXQgUkNVIFRh
c2tzIFRyYWNlIHJlYWQtc2lkZSBjcml0aWNhbCBzZWN0aW9uLCB0aGlzIHRhc2sgd2lsbCByZW1v
dmUgZnJvbSBDUFUwIGJsb2NrIGxpc3QuDQo+IA0KPiBEaWQgSSB1bmRlcnN0YW5kIHRoZSBzY2Vu
YXJpbyBkZXNjcmliZWQgYWJvdmUgY29ycmVjdGx5Pw0KPg0KPkxvb2tzIGxpa2UgaXQgdG8gbWUu
DQo+DQo+Q291bGQgeW91IHBsZWFzZSByZXNlbmQgdGhlIHBhdGNoIHdpdGggdGhpcyBleHBsYWlu
ZWQgaW4gdGhlIGNvbW1pdCBsb2c/ICBQb3NzaWJseSBmb3IgdGhlIGJlbmVmaXQgb2YgeW91ciBm
dXR1cmUgc2VsZi4gIDstKQ0KPg0KDQpIaSBQYXVsLCANCg0KSSBoYXZlIHJlc2VudCB2MyBhZ2Fp
biwgYnV0IG1heWJlIHN0aWxsIG5lZWQgeW91ciB3b3JkaW5nIPCfmIouDQoNClRoYW5rcw0KWnFp
YW5nDQoNCj4JCQkJCQkJVGhhbngsIFBhdWwNCj4NCj4gVGhhbmtzDQo+IFpxaWFuZw0KPiANCj4g
Pg0KPiA+CUV4Y2VwdCB0aGF0IHRoZSBxdWllc2NlbnQgc3RhdGUgaW1wbGllZCBieSB1c2Vyc3Bh
Y2UgZXhlY3V0aW9uDQo+ID4Jd2FzIGJlZm9yZSB0aGUgbmV3IGdyYWNlIHBlcmlvZCwgYW5kIHRo
dXMgZG9lcyBub3QgYXBwbHkgdG8gaXQuDQo+ID4NCj4gPihZZXMsIEkga25vdywgaWYgdGhpcyBp
cyBhIGJ1ZyBpbiB0aGlzIHBhdGNoLCB0aGUgYnVnIGFscmVhZHkgZXhpc3RzIA0KPiA+ZHVlIHRv
IHRoZSBjYWxsIGluIHJjdV9mbGF2b3Jfc2NoZWRfY2xvY2tfaXJxKCkgZm9yICFQUkVFTVBUIGtl
cm5lbHMsIA0KPiA+YnV0IGlmIHRoaXMgY2hhbmdlIGlzIHNhZmUsIGl0IHNob3VsZCBiZSBwb3Nz
aWJsZSB0byBleHBsYWluIHdoeS4pDQo+ID4NCj4gPgkJCQkJCQlUaGFueCwgUGF1bA0KPiA+DQo+
ID4gLS0tDQo+ID4gIHYxLT52MjoNCj4gPiAgRml4IGJ1aWxkIGVycm9yIGR1ZSB0byB1bmRlY2xh
cmVkIHJjdV90YXNrc190cmFjZV9xcygpLCBub3RlIGluIA0KPiA+IG5vLVBSRUVNUFRfUkNVICBr
ZXJuZWwsIHRoZSBSQ1UgVGFza3MgaXMgcmVwbGFjZWQgYnkgUkNVLCBzbyANCj4gPiByY3Vfbm90
ZV92b2x1bnRhcnlfY29udGV4dF9zd2l0Y2goKQ0KPiA+ICBvbmx5IGluY2x1ZGUgcmN1X3Rhc2tz
X3RyYWNlX3FzKCkuDQo+ID4gDQo+ID4gIGtlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaCB8IDIgKy0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9yY3UvdHJlZV9wbHVnaW4uaCBiL2tlcm5lbC9yY3Uv
dHJlZV9wbHVnaW4uaCANCj4gPiBpbmRleCA0MTUyODE2ZGQyOWYuLjVmYjBiMmRkMjRmZCAxMDA2
NDQNCj4gPiAtLS0gYS9rZXJuZWwvcmN1L3RyZWVfcGx1Z2luLmgNCj4gPiArKysgYi9rZXJuZWwv
cmN1L3RyZWVfcGx1Z2luLmgNCj4gPiBAQCAtOTc2LDcgKzk3Niw3IEBAIHN0YXRpYyB2b2lkIHJj
dV9mbGF2b3Jfc2NoZWRfY2xvY2tfaXJxKGludCB1c2VyKQ0KPiA+ICAJCSAqIG5laXRoZXIgYWNj
ZXNzIG5vciBtb2RpZnksIGF0IGxlYXN0IG5vdCB3aGlsZSB0aGUNCj4gPiAgCQkgKiBjb3JyZXNw
b25kaW5nIENQVSBpcyBvbmxpbmUuDQo+ID4gIAkJICovDQo+ID4gLQ0KPiA+ICsJCXJjdV9ub3Rl
X3ZvbHVudGFyeV9jb250ZXh0X3N3aXRjaChjdXJyZW50KTsNCj4gPiAgCQlyY3VfcXMoKTsNCj4g
PiAgCX0NCj4gPiAgfQ0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4gDQo=

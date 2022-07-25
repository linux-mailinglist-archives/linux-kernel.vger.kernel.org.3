Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D047358056A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbiGYUT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbiGYUT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:19:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CB55FC0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658780366; x=1690316366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rY+hZe76F5pReHUpnlGT+21fhIqptYkHimRXCmOKSqs=;
  b=OxyFxb9W+DXzIDqclJIRMR/Yw1SakKskYp/MghhZGyefDAfuZc8H+EUJ
   Ds4f/stvcQ5ncyLdcNWgVgB48gMo73wRini/RAwviCAPYgFJcQnHbXLdW
   JmI4mpIJBu2q2LN++5OOSlGXsqWM2zjhx11B4aN1C+irZItTm42wNb0ta
   R5hyyWc6tJBKOlbd7EoxJo1WoD5ipRyI+0e5s6HtArh173FgVpym1thJU
   5hK9ZwYLZtMiWx7QR/L64cTONwS/BYlrG+W5RCvxWJZdJuEhX6wZfySee
   siawqC0rR6ouAitqsxDh356WgUdrTDg17b3gpkHCkEutxWJl3SmbP8gy4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="267558811"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="267558811"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 13:19:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="702627495"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jul 2022 13:19:26 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 13:19:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 25 Jul 2022 13:19:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 25 Jul 2022 13:19:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOzidH1sFxHXF7Ljay7EBnWWDb0V9i+0GixQA1rcZhFg51ro1IGrlDNSm6G554i2FIUkFXOrdqMPQlVlODDKsdouQTbvICtbtH+85cjYM/oz13GTynwKF1aUb8FN+TRR0whOcUu/0p8goP7c34TLGneZpOcsu91YFKT8uqNn0q8HECl0EYqZLHfY/E+dlE8lAcPSm+JbdQ2/CnsHOWBaqHSsy2HWd0XUeVjeWswxzxU4m0ZgbwrkEDDPTre5XAngFpzpRrdKgBJs/wI/xI1j/4GvyuTVyVGEoJ4AisNexT5cjMz6rPzkTSN53AjFdF7tnfub6Wt0nX6w/gCM9xnMFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY+hZe76F5pReHUpnlGT+21fhIqptYkHimRXCmOKSqs=;
 b=D5hA3pMQAnvXWmzkyfCCXWW5MY4dO9YpH2qgbxhfICqApiC7+k+Ss0b4dUNTBcJqqWz+4jCGoo8yD0Pc3jvCTPuYHxzmK417LoRYHfvzmx8tdEmRFSD3O28+oW1nmQfFomNzLNru2Uane0L9RWUT+Xj3SHPB7FuyXGPR9Fkua7SwfMFGdPBv97XY2tA4UZTqPikqJ3swOeszNFzYyJOgSA/Ozi9TJxTomCLr2hNrUjlu9Xp4nnbUQ69QAUpZXvbx1pZA9wQxndvfcm+4+qhl8/jDrsS/L2NwHFlEU34TviSxGd57dR+NK450XOxiV0eoiUkFc030Kg5w3W1vwGaINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4435.namprd11.prod.outlook.com (2603:10b6:a03:1ce::30)
 by CO6PR11MB5620.namprd11.prod.outlook.com (2603:10b6:303:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 20:19:22 +0000
Received: from BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::9817:ec25:4cf9:c4a1]) by BY5PR11MB4435.namprd11.prod.outlook.com
 ([fe80::9817:ec25:4cf9:c4a1%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 20:19:22 +0000
From:   "Nakajima, Jun" <jun.nakajima@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Wander Lairson Costa" <wander@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Thread-Topic: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Thread-Index: AQHYnhCuYSj3l4I2uku/oc/5LfogPa2Pi4oA
Date:   Mon, 25 Jul 2022 20:19:22 +0000
Message-ID: <4B48A192-8305-4E94-AA0C-10FCE23F424D@intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <403cfccb-7fff-ab0b-8ebd-e5b04e631571@intel.com>
 <20220722190524.GA3299911@ls.amr.corp.intel.com>
 <18578c5a-7a35-ab20-467c-80141b0410a8@intel.com>
 <b8ea1778-02c1-b688-896d-dbb231eddf23@linux.intel.com>
In-Reply-To: <b8ea1778-02c1-b688-896d-dbb231eddf23@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c22469f-2b53-4926-780a-08da6e7af65a
x-ms-traffictypediagnostic: CO6PR11MB5620:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LuaIDDOJdB6DM0F9F/nncITUNhCQ1nbN3K8Stfpxtf9PoS7j4XsO+sc2YoUUAmJQ8vVxchnnXo0RYTDjBTTxLgKeOp7/qoTclGkEXsPycR68Ns0MnAiHE2GegcOrBb40wPtSnQbt+3Gsozs2h5GiQ9ThLESd5JyJ+0QWWnEbtaa6nMgUTRTxf6cSXa1Ac8Vq50Br9seobqJkngMewQUuvDHphCQsVxqrgfBd3n7irRJ0we1XUsA+bV43qmS/TSzX3ah5OQptOrIxFq/PCiV0pFJeupA3tFkTeM5wUM+eM8LruTnPV9J+8MWM0EDj2++BiJtWabSiL+G8hQ0WO9hNvcAB+Uihu4i8lChRRjk3Bp7Neuj+r3K/IIQTPaOss+lWG0+MKiQGhFTY7rydYY2TgyMfaObut66YyGu60MhUSp5wJg4q5PahTcilq9/sMNL8p33yeb4xpIwDfCR2KO+IcGna5x6S/4B3Y1LTq5m3PLIyfKWXN4wUko2335rtiUiUcBxUPuIcjLXNyL8nkLa1p68nT2hK+9qtoy+40L6wJEPR2HaqtxMm8CNkO9WjXOJDanA1D2HSPNiPGxe8BURsNmUpHnRMk8VX9n0n7XZr7W6u0jcHqBJnw58+pjlzR94dJVXo/TxsX1TiEOMrQ9cwNjEJKjO2agdrzGVXEpXYkbeXe9F7+avcqAdLZD9xTT5UN4Q6eTcYtkpgtr9MjTmAGFHad+kzE7eB5TYj19//UJlI1w/2zQ77BDZxlL/HFQJisrR9lB4NgpxWhgaeEfhxYtFgH87c8MNVrmmYK1KLlQe7HT8K7+ghAW5pnG+XOsF5xHNQfgkj+7v7tamDFjGZsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(366004)(396003)(346002)(39860400002)(38070700005)(82960400001)(122000001)(33656002)(8936002)(83380400001)(36756003)(6512007)(86362001)(38100700002)(186003)(6506007)(53546011)(2616005)(41300700001)(6916009)(54906003)(6486002)(478600001)(71200400001)(76116006)(7416002)(5660300002)(4326008)(66946007)(8676002)(66556008)(66476007)(66446008)(64756008)(316002)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MklEeHdCd0MyY3ozZThOQ2lHRWJQa0MxNUdXazZYV0lzL3JEZ3hvOG40Tkwy?=
 =?utf-8?B?TFFtRTNXc2swZm4vakdPam0xY3lQbWxIUnp1R09wcC96QnhLTlg2ZTVwMC9x?=
 =?utf-8?B?bjN2K3pocEVUWjZFd0dvbHQzZnVNdWRLc3RSdUlUY2FTL2NsWjhKRjZObEJN?=
 =?utf-8?B?Zk5ickZiWFRBWXp1S1MxSGxnbHNoMFpJRy9Mc0tJempNM1BYOUpQNHBHV2Zn?=
 =?utf-8?B?d0ZzVlBQNzZiTXk0S0t1NDFvUDRiWS9EQTJQUTJrRzBNcjh0d2w1S2NKem9n?=
 =?utf-8?B?OXZyeW1BS2RRc3hIUTFpR0lSYnloRVNIUEsyODczUktmaE1vbEpIVzkyb2w3?=
 =?utf-8?B?bkR3Z0ZOSmZOb1FXZURQTUxNZGpBL3BSbGtERElxeGFFM0VTQUFIZVpBOTNS?=
 =?utf-8?B?dUt4OGFhUUM0bzFUOElncU9GeUlJc3J4TlpnOGI1YkVXZ1FNbTVVdlpZTWcr?=
 =?utf-8?B?ZnJLNVlNZFZqbFExcDZ5NTF6MS9FS3h0eEZyV3h0R1pPZFhuRVF0bGREalJL?=
 =?utf-8?B?RFNPdCtmL3hRNVhiRi9UODJ6aUFwbDR1b0NFZU5UYlV5dXdLNS92YXAvYWVG?=
 =?utf-8?B?all6Y1BpZ1JEZ2pQNDRqdGxsS0M4Z0RpSzQrTWl6blJnNVVDc2VTbm5reFds?=
 =?utf-8?B?cTd2OU5zWkplS2syL1RXTTU2Mi9URFhNTFBFSGpDK0VuMlpCK1RXWnIzRWVp?=
 =?utf-8?B?bGxwY3NqYS9RQzlEVVp2OGdDRktmbGNKOGVMVC9jSzZBUWROcmk1YVV6UVBy?=
 =?utf-8?B?Z2g1WU51TnVyRnpkd0xUTjVkWW80SVp5aVlBeEpEOE85eXlka0ZERTN3OW9s?=
 =?utf-8?B?R0x4bEkybnJKNHRlNGxvaGd0TkVDVS84dVV2aVl2UGgwWFlyT2NiUGFGb3lV?=
 =?utf-8?B?QzExaS9LSnBEMVJuYkRKVjdRaUdYVEhGcHNKWElReDhXWXV1Ulk5S21tck9p?=
 =?utf-8?B?SG5VdUl6SFNCYW93eXFuTE1FalgrVWx2U1Axa1cxeHdKRHNWQkIyWkt1VW1s?=
 =?utf-8?B?MWZONFU3ai9SUTlERUdYZ0xlcGtVbGhYQ294M1lqQXdtbXc2TGQ2OE1XcVdw?=
 =?utf-8?B?UE9CZmtOT0Z2VDdtMzNCOTZld3N6ZHNtM0tjcGZKbHdodkVoQk81bHlBZFdz?=
 =?utf-8?B?UlVRQ1JtQTVUcThtbTh5a0IrWmsvRVlZajZPWGtsejQ0d04xckFIblBYSmJZ?=
 =?utf-8?B?cWJMdm90Y2lvVXBqNWlnVm5idHFHcW5BL2FYZVhNK0NMYTVPelEzTERsYmk1?=
 =?utf-8?B?bDhGLzlPcmlLS1psWENKZkJFVDVXSEgwVkFqU1RLTSt1TjM2bTlEUDNTYnQz?=
 =?utf-8?B?WEk2ZHFwTnBmTWl3blQ0VVpHVTRsWTVlSDVPZFFwbHV5QUVKQVNXYnNGYTdY?=
 =?utf-8?B?WUxHUzFtd1pHeGZPUmhBbDU2TDliVFdwU2pjQ2pjMmpKcWJOQ29Hb0RpcUkr?=
 =?utf-8?B?dk5VRzNRZnVWYUFlR1JnUktYVmV4TnV2TjJqKzhuaTEvbC9acVdRQ1RzdG5S?=
 =?utf-8?B?M245UEtvcGt4NUxhQUhTMEFkUEMrQTZBckFBYjlBd05ldE5yUi9OT3J2azZ3?=
 =?utf-8?B?UXNIOFZQZHlvK2JXSzVZNXp3czI3Q1dtZjdJRThwWXlXWUV4YWovRC9EQWhm?=
 =?utf-8?B?T0xQNVM5bG1HaVR0RC9VMk9KK3cwdzFraitHRGo4L0c5NTB2bk51M1lkOFll?=
 =?utf-8?B?TXBDSG9hQmZMUGFoc3U1WE9NY0RyN2JxVlYybXZsc0ZSREw4eVk4MHVpMWYy?=
 =?utf-8?B?OEp0UUtuZTh4c0tndFIveThGbThGVzNoTitwWHc1Y0txUUpQNEhqRkxpbHA5?=
 =?utf-8?B?NDk2YTQ3c3h6QVJjZkQxVjc1VHE5TXQ5L1VBMEVkS2k4NEdOVWU1eG9sVDU1?=
 =?utf-8?B?M25ucW9vdEFWd3pjNDB3L0oxYVVvTS9oTEQvS0l5N1Juak1HdHFsaWZzV3lB?=
 =?utf-8?B?UDdKY05sN2tuMFBpMDN2dFcwKzlSaExBdzg5SjNTYU9GUDk1YVFFbDB5aFVq?=
 =?utf-8?B?OG45YmVSUlp5L3ZqU0g5Z1k1QTZHemozNXJnczBjVWR6VjR2VU1CTkNLa1dx?=
 =?utf-8?B?cXI5dGRoUjk1bk5YQlZPSFVCaTRKVkhUR3gwbGtieFduZGZaSDRtM0RnMnF1?=
 =?utf-8?B?RFdQUHg0RVhlanpwWUUvOU9hRWMzaW5zRUhiaTR5enpEQjVvMjJUeXVLdlFH?=
 =?utf-8?B?VzY5eGRvZmltTFQ4UEZ3dGdQUndBK3ZjWnRaeS9iNDBoRWtnVlp1V0hvMzVY?=
 =?utf-8?B?cEZ5L1dHeG9rZDErcEJVOVQzWXpBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AB4F24CD5534C43977E450195ACD051@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c22469f-2b53-4926-780a-08da6e7af65a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 20:19:22.4379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5r7OeVvL67IjQDRRPrru9rrpr0lAZ1zqWNTa7/sr9u1R/ZGVNKYHOJXMXQEhXI2OZNp2cTBPhJJkSj3t3J0/bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5620
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKdWwgMjIsIDIwMjIsIGF0IDI6MTggUE0sIFNhdGh5YW5hcmF5YW5hbiBLdXBwdXN3YW15
IDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiAN
Cj4gKyBKdW4NCj4gDQo+IE9uIDcvMjIvMjIgMTI6MTMgUE0sIERhdmUgSGFuc2VuIHdyb3RlOg0K
Pj4gT24gNy8yMi8yMiAxMjowNSwgSXNha3UgWWFtYWhhdGEgd3JvdGU6DQo+Pj4+IFNvLCB0aGUg
cXVvdGUgcG9ydGlvbiBvZiB0aGlzIGlzIGJhc2ljYWxseSBhIGJpZGlyZWN0aW9uYWwgYmxvYiBz
ZW5kZXIuDQo+Pj4+IEl0J3MgdG8gc2VuZCBhIGJsb2IgYmV0d2VlbiBndWVzdCB1c2Vyc3BhY2Ug
dG8gaG9zdCB1c2Vyc3BhY2UuDQo+Pj4+IA0KPj4+PiBEbyB3ZSAqUkVBTExZKiBuZWVkIHNwZWNp
ZmljIGRyaXZlciBmdW5jdGlvbmFsaXR5IGZvciB0aGlzPyAgRm9yDQo+Pj4+IGluc3RhbmNlLCBp
cyB0aGVyZSBubyBleGlzdGluZyB2aXJ0aW8gZGV2aWNlIHRoYXQgY2FuIHNlbmQgYmxvYnMgYmFj
aw0KPj4+PiBhbmQgZm9ydGg/DQo+Pj4gSXQncyB2aXJ0aW8tdnNvY2suICBJZiB2aXJ0aW8tdnNv
Y2sgaXMgYXZhaWxhYmxlLCB0aGUgY29tbXVuaWNhdGlvbiB3b3Jrcy4NCj4+PiBIb3dldmVyLCBz
b21lIHVzZXJzIHdvdWxkIGxpa2UgdG8gZGlzYWJsZSB2aXJ0aW8tdnNvY2sgb24gdGhlaXIgZW52
aXJvbm1lbnQgZm9yDQo+Pj4gc29tZSByZWFzb25zLiAgRXZlbiB2aXJ0aW8gYXQgYWxsLiAgRXNw
ZWNpYWxseSBmb3IgY29uZmlkZW50aWFsIGNvbXB1dGluZyB1c2UNCj4+PiBjYXNlLiAgSXQncyB0
aGVpciBjaG9pY2UuICBJdCBjYW4ndCBiZSBhc3N1bWVkIHRoYXQgdmlydGlvIGlzIGF2YWlsYWJs
ZS4NCj4+PiANCj4+PiBUaGUgZ29hbCBpcyBWTU0tYWdub3N0aWMgKGJ1dCBURFgtc3BlY2lmaWMp
IGludGVyZmFjZSBmb3IgdGhhdC4NCj4+IA0KPj4gWW91J3JlIGJhc2ljYWxseSBzYXlpbmcgdGhh
dCBldmVyeSBjb25maWRlbnRpYWwgY29tcHV0aW5nIHRlY2hub2xvZ3kNCj4+IHNob3VsZCBoYXZl
IGl0cyBvd24gaG9zdCB1c2VyIDwtPiBndWVzdCBrZXJuZWwgPC0+IGd1ZXN0IHVzZXIgQUJJLg0K
Pj4gVGhhdCdzIGluc2FuaXR5LiAgSWYgd2UgZG8gdGhpcywgd2UgbmVlZCAqb25lKiBpbnRlcmZh
Y2UgdGhhdCBzYXlzICJ0YWxrDQo+PiB0byB0aGUgaHlwZXJ2aXNvciIgdGhhdCdzIGNvbW1vbiBm
b3IgYWxsIGh5cGVydmlzb3JzIGFuZCBoYXJkd2FyZQ0KPj4gdmVuZG9ycywgb3IgYXQgbGVhc3Qg
bW9yZSB0aGFuICpvbmUqLg0KPj4gDQo+PiBXZSBkb24ndCBuZWVkIGEgd2F5IHRvIHRhbGsgdG8g
aHlwZXJ2aXNvcnMgZm9yIEludGVsIHN5c3RlbXMgYW5kIGFub3RoZXINCj4+IGZvciBBTUQgYW5k
IHlldCBhbm90aGVyIG9uIHdoYXRldmVyLg0KPiANCj4gRm9yIGNhc2VzIHdoZXJlIHlvdXIgcGxh
dGZvcm0gZG9lcyBub3Qgd2FudCB0byBzdXBwb3J0IG9yIGVuYWJsZSB0aGUgZ2VuZXJpYw0KPiBp
bnRlcmZhY2UgKGxpa2UgdnNvY2spLCBpc24ndCBpdCBiZXR0ZXIgdG8gaGF2ZSBhIGZhbGxiYWNr
IGFwcHJvYWNoPyBJIGFtIG5vdA0KPiBzYXlpbmcgd2Ugc2hvdWxkIGhhdmUgc3VjaCBhbiBBQkkg
Zm9yIGFsbCBjYXNlcy4gQnV0IGF0dGVzdGF0aW9uIGlzIGEgbXVzdC1oYXZlDQo+IGZlYXR1cmUg
Zm9yIHRoZSBURFggZ3Vlc3QsIGFuZCB3ZSB3YW50IHRvIHN1cHBvcnQgaXQgaW4gYWxsIFREIGd1
ZXN0IHBsYXRmb3Jtcy4NCj4gSSB0aGluayB0aGUgR0hDSSBBQkkgaXMgYWRkZWQgdG8gbWVldCB0
aGlzIHJlcXVpcmVtZW50Lg0KPiANCj4gSnVuL0lzYWt1LCBpZiB5b3UgYXJlIGF3YXJlIG9mIHRo
ZSBleGFjdCByZXF1aXJlbWVudCBmb3IgdGhpcyBoeXBlcmNhbGwsIHBsZWFzZQ0KPiBzaGFyZSBp
dC4gQWxzbyBsZXQgdXMga25vdyB5b3VyIGNvbW1lbnRzIG9uIHRoaXMgdG9waWMuDQo+IA0KDQpZ
ZXMsIGEgcXVvdGUgaXMgYSBibG9iLCBhbmQgdGhlcmUgYXJlIHNwZWNpYWwgdGhpbmdzIHdpdGgg
dGhhdCBiZWNhdXNlIG9mIHRoZSBuYXR1cmUgKGkuZS4gdGhlIGVzc2VudGlhbCBkYXRhIGZvciB2
ZXJpZmljYXRpb24pLg0KMS4gSXTigJlzIHNtYWxsIChlLmcuIDRLQiBvciBzb21ldGhpbmcgbGlr
ZSB0aGF0KS4NCjIuIE9uZS10aW1lLiBJdCBzaG91bGRuJ3QgY2hhbmdlIGV2ZW4gaWYgeW91IHJl
cGVhdCB0aGUgcmVxdWVzdCAoR2V0UXVvdGUpLg0KMy4gTmVlZCB0byBiZSBhdmFpbGFibGUgaW4g
bWluaW1hbC9lYXJseSBydW50aW1lIGVudmlyb25tZW50cywgaW5jbHVkaW5nIHByZS1ib290LCBl
LmcuIGd1ZXN0IEJJT1MsIG5vIHVzZXItc3BhY2UgeWV0Lg0KDQpJbiBteSB2aWV3LCBnZXR0aW5n
IGEgcXVvdGUgdXNpbmcgdmlydGlvLXZzb2NrIGlzIG92ZXJraWxsIGJvdGggZm9yIHRoZSBob3N0
IGFuZCB0aGUgZ3Vlc3QuIFRoZSBob3N0IG1heSBub3Qgd2FudCB0aGUgZ3Vlc3RzIHRvIHRhbGsg
ZGlyZWN0bHkgdG8gdGhlIGhvc3QgYmVjYXVzZSBvZiBzZWN1cml0eSBjb25jZXJucy4gDQoNClRo
aXMgcGFydGljdWxhciBwYXRjaCBhbGxvd3MgdGhlIGd1ZXN0IHVzZXItc3BhY2UgdG8gZ2V0IGEg
cXVvdGUgZm9yIGFuIGF0dGVzdGF0aW9uIHNlcnZpY2UsIGFuZCBpdCBjYW4gYmUgdXNlZCBmb3Ig
dGhlIGZpcnN0IGF0dGVzdGF0aW9uIG9mIHRoZSBndWVzdCwgaS5lLiB3aGVuIHRoZSBndWVzdCBr
ZXJuZWwgaGFzIG5vdCBiZWVuIHZlcmlmaWVkIHlldC4gSXTigJlzIHVzZWZ1bCB3aGVuIGdldHRp
bmcgdGhlIGtleSBmb3IgdGhlIGd1ZXN0IGNvbmZpZGVudGlhbCBkYXRhLCBzdWNoIGFzIHVzZXIg
ZGF0YSB2b2x1bWUsIGJlZm9yZSBtb3VudGluZyB0aGUgdm9sdW1lLiBDYW4gd2UgdXNlIHZpcnRp
by12c29jayB0aGVyZT8gWWVzLCBidXQsIGFnYWluLCBvdmVya2lsbCBhbmQgbGltaXRlZCBhdmFp
bGFiaWxpdHkuDQoNClNpbmNlIHdlIGRvbuKAmXQgd2FudCB0byBhbGxvdyB0aGUgdXNlci1zcGFj
ZSB0byB1c2UgYSBoeXBlcmNhbGwgKHRvIGdldCBhIHF1b3RlKSwgSSB0aGluayBzb21lIHNvcnQg
b2YgZHJpdmVyIHNob3VsZCBiZSBuZWVkZWQgdGhlcmUuIFNvLCBJIHRoaW5rIHRoaXMgZHJpdmVy
IGlzIHVzZWZ1bCBhdCBsZWFzdCBhcyBhIGZhbGxiYWNrIHdoZW4gdmlydGlvLXZzb2NrIGlzIG5v
dCBhdmFpbGFibGUuIA0KDQoNCi0tLSANCkp1bg0KDQoNCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5283558092B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 03:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237381AbiGZBq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 21:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiGZBqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 21:46:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B52720BED;
        Mon, 25 Jul 2022 18:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658800010; x=1690336010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yFqnu3hAEye69LDzT6S7bnC5DXVJnPlGx984ROKeT9w=;
  b=a4GSMMr0TtFf+Z8IMBkZ1MmpYOBv43XO3jLmNEwQlJorNRnEmesdrtxI
   aZD0vDaaafmqUAEH4LzT+armHCXuBDV8utVWtlXTxO2/GzUnz0sCBRiZZ
   JN8zvz3zQcYSdMS7sRIlEpykbRsyJWBJJv8OJwFy779YarFx9IKGoe2r3
   204GsSJmjJT2cKfgG6dnKWg7IkEYwc0oUATUOnGszE7kARMYH9HJ4I2uN
   dVPGhXky1nZERc3mkKj3oc0iUWo8rMkbL83yARnNuigJZuzVdzP0OL3Nl
   hagNg5I2GD4lzdIuHZUJWub5Xwqm17uX5194ZYYP4fK034nDlnKlxVDkK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="285382434"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="285382434"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 18:46:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="632566230"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2022 18:46:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 18:46:49 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 18:46:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 25 Jul 2022 18:46:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Jul 2022 18:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkkShh+8uiRVy7LJ4XBcqb0hza92NISJ+ZS7b0jrx87Cf3Pj2m11Ac99HTQcbOXByzB7ZejqIO0nAq27zlQFT22jX+xVoG/NoCWr6pOmydM8/u7JshCaS7+wns8SN6RF32URLeg+NdvGxT70YSs/TlVz3C+ZHFr9a40mFcBgEKX7OVpdb2F54oPK1dAAZ2V1sQo9dO3duTqIqp6etsFnIXc/bXl1soXcRLWu/Tu+Ex2/kg9zchjg9To5sXD2FnrIDw2P5uoMRsNxeO8rZTkfbDa76zwAUzEJdfm9Zm9BmFrUiCglQ1FL0r2Khqqlrl4Yj6TBSZIj3DmADK/fHLaKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFqnu3hAEye69LDzT6S7bnC5DXVJnPlGx984ROKeT9w=;
 b=FnpeSTO7m7rK2Y+szLxyAmjupm9sueG/VU4x79e21onSZZdpWzjBJl7AaWehms8u9dRNpgHt1YYZ0+kcuEmNt0nUx6RTkkPAqgPT5vs7jzyolB/RO6OhzW7W655REfJM/LG9PAfjEsoa672uWz1KuX9kOV/QIVY6MVX4GseZ//bnx8xzPTK9xagRAIwNH4519XJbuIcmPvx8YGYRCrwMJVxvFFzUC60ubrC2HR5+1RVWV6pj1xsem23GaxqPDp2DNyPh7XA5RAHbYK2Xqk/9Im0aJr2norlroIW0EviTgsfw4bCjpFGFoOK3LqUTfUGYsAZ2wcbIujlY+MyR+PulJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 by SJ0PR11MB5213.namprd11.prod.outlook.com (2603:10b6:a03:2da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Tue, 26 Jul
 2022 01:46:41 +0000
Received: from PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::6569:5ac:5138:1bc6]) by PH0PR11MB4824.namprd11.prod.outlook.com
 ([fe80::6569:5ac:5138:1bc6%8]) with mapi id 15.20.5458.023; Tue, 26 Jul 2022
 01:46:41 +0000
From:   "Mi, Dapeng1" <dapeng1.mi@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Bart Van Assche" <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhenyu Wang" <zhenyuw@linux.intel.com>
Subject: RE: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
 in Makefile
Thread-Topic: [PATCH] cpuidle: Move cpuidle driver forward before acpi driver
 in Makefile
Thread-Index: AQHYlpGUKmAjRm9DBkW5CrmRNbrVmq18lbSAgACLrhCACXorMIAAfRCAgAEKj7CAB9KsEA==
Date:   Tue, 26 Jul 2022 01:46:41 +0000
Message-ID: <PH0PR11MB482476E499FF0EE4A10F037BCD949@PH0PR11MB4824.namprd11.prod.outlook.com>
References: <20220713082426.850911-1-dapeng1.mi@intel.com>
 <CAJZ5v0gsHPav5Ax6+9OMmeApqn7qdJPQmo5MMh=ba6Rtj5NnQA@mail.gmail.com>
 <PH0PR11MB4824DAE06FE50711C3252D93CD889@PH0PR11MB4824.namprd11.prod.outlook.com>
 <PH0PR11MB482497A0CC93F430DA208EDDCD8E9@PH0PR11MB4824.namprd11.prod.outlook.com>
 <CAJZ5v0j57iCNcz8i2P6JtkbiCHB1QS8M6QTngKoiJrm0pnkgUg@mail.gmail.com>
 <PH0PR11MB4824E26602680EED90B7FE2ACD919@PH0PR11MB4824.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB4824E26602680EED90B7FE2ACD919@PH0PR11MB4824.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0e893e2-a40d-4858-46c0-08da6ea8b008
x-ms-traffictypediagnostic: SJ0PR11MB5213:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UQVoAZGHhLeLUnN9Q2LxSFLhHBI3I8P+bcXeGSR8ISeeT2y1Cf6dXlhjsOZnlwywJG4BKgY9zI5Yt+37O9AdUl9/i5s4yWPozUsCP+qIY5jctN2qZTEq8D/lou60/1uKAfp7nHODNC1Wr7VRpUa6lIND5B3BRynePWiUXsQBBH8/5D9r6eJ2jz/t0HN5z2uZKmrnIemxiB6RPfBRYM3L/FC0ODsM0S64rwH6o8AsfgZudj3Ty0aXVcRWNfiRYNgh9L+GL2kvOGUYA8f8X4t9BXKoSkWjLFm94JIBc5lJGE7/pMxJdemM9VoP6wTNrS168/BmZkD6Y6EsZVtAx0yx5NZLslotNwkaeSPmE12g5ObrnZjWCV7X2s57JTali/w1RNiU6H899m0LdguiaozTfcd+l83HIvb9OubIAI7kvma9CE1DICoeiw29PGNxlLiazHef9wO8DRdy/ls7i0uiNoZkRx2gCSYcTXlImhC87G30N5Qw5ooCqOXiU5koRIFKCY5x318D/jkIidlZenmIWFq8DKeNFKP3uAc8ZAnAxxevtE4P8MGQSj/j5iyOIgZZGowTablVCf3HhlgWe7DyQbYpfjq2XkkSVGEDRAGroQrYhBwsXqY040+6z/tn5brOkXgrAot7PQh83273n8cOMfhU/D6uvVyIG3xr2BuO3BWdeLVjk9ck3rXXOKFu+D3oDLOmO2k2WTkbovJC+oRH+oesUzJtL8tha39zbq4zvXh21upsnMj6tyAZ6kPXUNqXjJ7vubzDeo1BMViIKNfovxNrtMFD41Pyo0/4s0SjJ1HOMArDQHxyVWbJxurI1BDv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(136003)(346002)(366004)(41300700001)(33656002)(6506007)(7696005)(54906003)(6916009)(53546011)(478600001)(82960400001)(38070700005)(86362001)(186003)(9686003)(71200400001)(26005)(83380400001)(52536014)(64756008)(8676002)(66556008)(4326008)(66446008)(5660300002)(55016003)(66476007)(76116006)(66946007)(316002)(2906002)(8936002)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUh6end6bUVOcFQrWnlFU2xUM0dkUm52Z05XWGt6enE5NHh2WmIyQzh2d0hF?=
 =?utf-8?B?YXBoUHg0a2dyU1FlTWpjRjY5UmF3RGFkbGkrTmI2QW5SWklnQmV5dU0zTzVW?=
 =?utf-8?B?UWx2dm9MdU1xOHdidXpxRE9JQmhJNlF4LzRhUGIzWEVCOUlpWVBDb0g4Vkcz?=
 =?utf-8?B?NmtHRmdqYUF6cmp4Y3NYRWJoaGVxS2hIaFVjTlVybFdRT3J5OTljeFhNSm5D?=
 =?utf-8?B?azdDc05HSlpOanVDbXVUalo5YURUdGpyUGJpVTNCOEMyTlcvRXR0RDI3SCtw?=
 =?utf-8?B?ZDl1cy9mRHo0TnUzM2k4Y05maTNxRmMzRHdZMkpzVzA4dVNGa2k5SXIvUlFx?=
 =?utf-8?B?TmxuOStHdUF2dDhUVWpiT09iSDlISWhmRVNzLzVsNXgra0g1eVVrekpudFNL?=
 =?utf-8?B?MkFZWDFhOHlBZEluaHYwN0pwN0NqTnBEWU8zanhWQk5NYXo1R0M5SnZVNURD?=
 =?utf-8?B?dkhQVlpzK1hQeC9VcHhqdkNtS3pHZkdZOEdyeU9rV016bEp6bTJQOXN6aTBr?=
 =?utf-8?B?S29neTFydkhka3FMNW5vQmd5bmNjVWlSemtVdVd4R1JNM1I4M0xMWHU0Rkk0?=
 =?utf-8?B?SUpMTGxFbXZubERWR3Rjcmo4aHRyaTUvQlpvdnR5NEZLU21RMHRhZWw4WHNM?=
 =?utf-8?B?MWN3NDBvb0laRDNSWmhBMnBFZ2l5ZWdZOUdoM01FYUR3WXdmdFlYVlB2T1Vi?=
 =?utf-8?B?dDhjWVNXelNGZnp6QlNabURreVoxZE42Z3g3LzlvRXJadnhaU1RCRUZPSjVJ?=
 =?utf-8?B?bU4vd2RNdENYRnZuNUxWNnFSUjl6NklJbTBQWEJRMStEZjRHM1dScGJhYkpm?=
 =?utf-8?B?VE84VWIzSTdrTUROUCtNK0N0QjZBREo4RXdpdmt6aTRYR0hSRlVhZkdRQ2pu?=
 =?utf-8?B?TEg0OXlwUWpCeG1jL2ZxODl0M0YwQUtNRmdTek5Ya3VMWlpIVkRoRjJIQXQ1?=
 =?utf-8?B?cVJlUFU2SzlUaFNlYUFtRjdrMC9HMWtveWtOM2F0OU1PSEp0NVAyTFI4TEpl?=
 =?utf-8?B?WGFvUXRvSXBFVXJFTDJweFpITkRjbU5tY2ZDV1dZODA0MmtkZDd2MTBFdXBR?=
 =?utf-8?B?cXRYVlZZMW5zT2pXRm1GbUkwOGUzN0F1MW84OXdmQzlMVVVnOW5rUlZwWHRN?=
 =?utf-8?B?dERZZVdiZ29vLzNwQkhQV2MrUnVWbXBmMkhBWlNJenhaRnFIVlBZOElMS2xL?=
 =?utf-8?B?UEhzSWRxc1hLNzhBdVp3ZXo1WjJQOXBpQUVhRDB5MVBxM0JGaVFud1ovTDNP?=
 =?utf-8?B?aktHVXBqb3FuUDdRWFowelhxdzJFTW5qRWRDU3pCLzAzTllvb1NGcFR4VzMr?=
 =?utf-8?B?ZXlwY0R6ZFlXMFp2UDc3SVlQNE1tWHV3Nmx1NlBSVHFjRDdjWmZRYnVaRGlY?=
 =?utf-8?B?SEdBZFpiZUdvYTUyNXMvcTZLUmEzTVBMcEdaRmo5TTlZMFZ5R2p6STRPdVRl?=
 =?utf-8?B?SEpSVmFSd1JDcEw4RXk0elV2dFYzdFAwS0dOWDdGemlYdW9zTmNHU251K1Bi?=
 =?utf-8?B?SEk5eWM1ZTJqWWZKckFBdk5abGpOOFpqOGZLY0dnbXFmZFRBaEg0bHJFUk45?=
 =?utf-8?B?RXhEbzNzSmFWVUE3dHlDM1VETms1UXl0cmlCS0NpbmxvSmgrRTA2WkpWemF6?=
 =?utf-8?B?dmZrK1JPQlk3QWRNWUdFRkUvRzVWV1Y1VWZDTGdsTjVRUWlCTVVRMFRXM0p2?=
 =?utf-8?B?NTNYcDJXTDRWelhWMWlVRElJUVRhQmlGK3JUaHJydjBnVDNtWnVoWEJNWWJZ?=
 =?utf-8?B?TTdWWXhpeW5Bd2RXVm5yMzZBSTI5MFovaXQ5Vm00dDhEMVpqdzNhejgwYUd4?=
 =?utf-8?B?MmdsdW4xeXZFMDVrUithVkhaSmdXU0VKSlFKV0hUbm90d25NbWJwalFaTTFl?=
 =?utf-8?B?K3NtRVFrYTZCU1hYaERIdGZta0FjVzM5a0ZrQmROYTBsRE9QUVRoSXF4TURM?=
 =?utf-8?B?UW5QeEFyeWxGVXZCaFd4NVpBZlEwNENGSjJNbytUWm9lTGVpbHd0VWFYMW9W?=
 =?utf-8?B?Y1NGak5iQVNIbnNKaEJ4UEJuOHhvb1E3RHZ5NnZoRFJOazdZQmFid2tRRlY5?=
 =?utf-8?B?VlNFZFBJSWZobXlrVzhsVVVRd0JCcEFRQlBrR2JCd0h6OWhjZFVrWTdMUkhk?=
 =?utf-8?Q?LnjWIIhvhtouuodJ8yX5a17Ja?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e893e2-a40d-4858-46c0-08da6ea8b008
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 01:46:41.3084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTLH7PGevQ+eXrYQRR+VIo784GY78dNGfpmL2mwPR44HBr4B63FHGj69V3TGr2T6c4CMy/dbzb4KkCoRnvYxaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5213
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBNaSwgRGFwZW5nMQ0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAyMSwgMjAyMiAxMTow
OSBBTQ0KPiBUbzogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0KPiBDYzog
TWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT47IEFybmQgQmVyZ21hbm4gPGFybmRA
YXJuZGIuZGU+Ow0KPiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz47IExpbnV4
IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnPjsg
TGludXggUE0gPGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz47IFpoZW55dQ0KPiBXYW5nIDx6aGVu
eXV3QGxpbnV4LmludGVsLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gY3B1aWRsZTogTW92
ZSBjcHVpZGxlIGRyaXZlciBmb3J3YXJkIGJlZm9yZSBhY3BpIGRyaXZlcg0KPiBpbiBNYWtlZmls
ZQ0KPiANCj4gPiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+
ID4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDIwLCAyMDIyIDY6MjQgUE0NCj4gPiBUbzogTWksIERh
cGVuZzEgPGRhcGVuZzEubWlAaW50ZWwuY29tPg0KPiA+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8
cmFmYWVsQGtlcm5lbC5vcmc+OyBNaWNoYWVsIFMuIFRzaXJraW4NCj4gPiA8bXN0QHJlZGhhdC5j
b20+OyBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgQmFydCBWYW4gQXNzY2hlDQo+ID4g
PGJ2YW5hc3NjaGVAYWNtLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0K
PiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBQTSA8bGludXgtcG1Admdlci5rZXJu
ZWwub3JnPjsgWmhlbnl1DQo+ID4gV2FuZyA8emhlbnl1d0BsaW51eC5pbnRlbC5jb20+DQo+ID4g
U3ViamVjdDogUmU6IFtQQVRDSF0gY3B1aWRsZTogTW92ZSBjcHVpZGxlIGRyaXZlciBmb3J3YXJk
IGJlZm9yZSBhY3BpDQo+ID4gZHJpdmVyIGluIE1ha2VmaWxlDQo+ID4NCj4gPiBPbiBXZWQsIEp1
bCAyMCwgMjAyMiBhdCA1OjAwIEFNIE1pLCBEYXBlbmcxIDxkYXBlbmcxLm1pQGludGVsLmNvbT4N
Cj4gPiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+ID4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJh
ZmFlbEBrZXJuZWwub3JnPg0KPiA+ID4gPiA+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDE0LCAyMDIy
IDE6NTMgQU0NCj4gPiA+ID4gPiBUbzogTWksIERhcGVuZzEgPGRhcGVuZzEubWlAaW50ZWwuY29t
Pg0KPiA+ID4gPiA+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+OyBN
aWNoYWVsIFMuIFRzaXJraW4NCj4gPiA+ID4gPiA8bXN0QHJlZGhhdC5jb20+OyBBcm5kIEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPjsgQmFydCBWYW4NCj4gPiBBc3NjaGUNCj4gPiA+ID4gPiA8YnZh
bmFzc2NoZUBhY20ub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+ID4g
PiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IExpbnV4IFBNIDxsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmc+DQo+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gY3B1aWRsZTogTW92ZSBj
cHVpZGxlIGRyaXZlciBmb3J3YXJkIGJlZm9yZQ0KPiA+ID4gPiA+IGFjcGkgZHJpdmVyIGluIE1h
a2VmaWxlDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBXZWQsIEp1bCAxMywgMjAyMiBhdCAxMDoy
MSBBTSBEYXBlbmcgTWkNCj4gPiA+ID4gPiA8ZGFwZW5nMS5taUBpbnRlbC5jb20+DQo+ID4gPiA+
IHdyb3RlOg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEFzIGxvbmcgYXMgS2NvbmZpZyBBQ1BJ
X1BST0NFU1NPUiBpcyBlbmFibGVkLCBBQ1BJX1BST0NFU1NPUg0KPiA+ID4gPiA+ID4gd291bGQg
c2VsZWN0IEFDUElfUFJPQ0VTU09SX0lETEUgYW5kIGFjcGlfaWRsZSBkcml2ZXIgaXMNCj4gPiA+
ID4gPiA+IGVuYWJsZWQuIEJ1dCBpbiBjdXJyZW50IGRyaXZlciBsb2FkaW5nIG9yZGVyIGFjcGlf
aWRsZSBkcml2ZXINCj4gPiA+ID4gPiA+IGlzIGFsd2F5cyBsb2FkZWQgYmVmb3JlIGNwdWlkbGVf
aGFsdHBvbGwgZHJpdmVyLiBUaGlzIGxlYWRzIHRvDQo+ID4gPiA+ID4gPiBjcHVpZGxlX2hhdHBv
bGwgZHJpdmVyIGhhcyBubyBjaGFuY2UgdG8gYmUgbG9hZGVkIHdoZW4gaXQncyBlbmFibGVkLg0K
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFRodXMsIG1vdmUgY3B1aWRsZSBkcml2ZXIgZm9yd2Fy
ZCBiZWZvcmUgYWNwaSBkcml2ZXIgYW5kIG1ha2UNCj4gPiA+ID4gPiA+IGNwdWlkbGUtaGF0cG9s
bCBkcml2ZXIgaGFzIGEgY2hhbmNlIHRvIGJlIHJ1biB3aGVuIGl0J3MgZW5hYmxlZC4NCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEYXBlbmcgTWkgPGRhcGVuZzEubWlA
aW50ZWwuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgZHJpdmVycy9NYWtlZmls
ZSB8IDIgKy0NCj4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9NYWtlZmlsZSBiL2RyaXZlcnMvTWFrZWZpbGUgaW5kZXgNCj4gPiA+ID4gPiA+IDlhMzA4NDJi
MjJjNS4uOTIxZWQ0ODFiNTIwIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9NYWtl
ZmlsZQ0KPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9NYWtlZmlsZQ0KPiA+ID4gPiA+ID4gQEAg
LTI2LDYgKzI2LDcgQEAgb2JqLXkgICAgICAgICAgICAgICAgICAgICAgICAgKz0gaWRsZS8NCj4g
PiA+ID4gPiA+ICAjIElQTUkgbXVzdCBjb21lIGJlZm9yZSBBQ1BJIGluIG9yZGVyIHRvIHByb3Zp
ZGUgSVBNSQ0KPiA+ID4gPiA+ID4gb3ByZWdpb24NCj4gPiA+ID4gc3VwcG9ydA0KPiA+ID4gPiA+
ID4gIG9iai15ICAgICAgICAgICAgICAgICAgICAgICAgICArPSBjaGFyL2lwbWkvDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gK29iai0kKENPTkZJR19DUFVfSURMRSkgICAgICAgICArPSBjcHVp
ZGxlLw0KPiA+ID4gPiA+ID4gIG9iai0kKENPTkZJR19BQ1BJKSAgICAgICAgICAgICArPSBhY3Bp
Lw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAjIFBuUCBtdXN0IGNvbWUgYWZ0ZXIgQUNQSSBz
aW5jZSBpdCB3aWxsIGV2ZW50dWFsbHkgbmVlZCB0bw0KPiA+ID4gPiA+ID4gY2hlY2sgaWYNCj4g
PiBhY3BpDQo+ID4gPiA+ID4gPiBAQCAtMTI2LDcgKzEyNyw2IEBAIG9iai0kKENPTkZJR19FREFD
KSAgICAgICAgICArPSBlZGFjLw0KPiA+ID4gPiA+ID4gIG9iai0kKENPTkZJR19FSVNBKSAgICAg
ICAgICAgICArPSBlaXNhLw0KPiA+ID4gPiA+ID4gIG9iai0kKENPTkZJR19QTV9PUFApICAgICAg
ICAgICArPSBvcHAvDQo+ID4gPiA+ID4gPiAgb2JqLSQoQ09ORklHX0NQVV9GUkVRKSAgICAgICAg
ICs9IGNwdWZyZXEvDQo+ID4gPiA+ID4gPiAtb2JqLSQoQ09ORklHX0NQVV9JRExFKSAgICAgICAg
ICs9IGNwdWlkbGUvDQo+ID4gPiA+ID4gPiAgb2JqLXkgICAgICAgICAgICAgICAgICAgICAgICAg
ICs9IG1tYy8NCj4gPiA+ID4gPiA+ICBvYmoteSAgICAgICAgICAgICAgICAgICAgICAgICAgKz0g
dWZzLw0KPiA+ID4gPiA+ID4gIG9iai0kKENPTkZJR19NRU1TVElDSykgICAgICAgICArPSBtZW1z
dGljay8NCj4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXZWxsLCB0aGlzIGNo
YW5nZSBkb2Vzbid0IGd1YXJhbnRlZSBsb2FkaW5nIGhhbHRwb2xsIGJlZm9yZSBBQ1BJIGlkbGUu
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbHNvIHdoYXQgaWYgaGFsdHBvbGwgaXMgZW5hYmxlZCwg
YnV0IHRoZSB1c2VyIHdhbnRzIEFDUEkgaWRsZT8NCj4gPiA+ID4NCj4gPiA+ID4gVGhhbmtzIFJh
ZmFlbCBmb3IgcmV2aWV3aW5nIHRoaXMgcGF0Y2guDQo+ID4gPiA+DQo+ID4gPiA+IGFjcGlfaWRs
ZSBkcml2ZXIgYW5kIGNwdWlkbGVfaGFsdHBvbGwgZHJpdmVyIGhhdmUgc2FtZQ0KPiA+ID4gPiBp
bml0aWFsaXphdGlvbiBsZXZlbCBhbmQgYm90aCBhcmUgaW5pdGlhbGl6ZWQgb24gdGhlIGxldmVs
DQo+ID4gPiA+IGRldmljZV9pbml0Y2FsbC4gU28gdGhlIGJ1aWxkaW5nIG9yZGVyIHdvdWxkIGRl
Y2lkZSB0aGUgbG9hZGluZw0KPiA+ID4gPiBzZXF1ZW5jZS4gSnVzdCBsaWtlIHRoZSBpbnRlbF9p
ZGxlIGRyaXZlciB3aGljaCBhbHNvIGhhcyBzYW1lDQo+ID4gPiA+IGluaXRpYWxpemF0aW9uIGxl
dmVsIChkZXZpY2VfaW5pdGNhbGwpLCBidXQgYXMgaXQncyBidWlsdCBiZWZvcmUNCj4gPiA+ID4g
YWNwaV9pZGxlIGRyaXZlciwgaXQgd291bGQgYmUgbG9hZGVkIGZpcnN0IGJlZm9yZSBhY3BpX2Ry
aXZlciBpZg0KPiA+ID4gPiBpbnRlbF9pZGxlDQo+ID4gZHJpdmVyIGlzIGVuYWJsZWQuDQo+ID4g
PiA+DQo+ID4gPiA+IFRoZXJlIGlzIGFub3RoZXIgbWV0aG9kIHRvIG1ha2UgY3B1aWRsZV9oYWx0
cG9sbCBkcml2ZXIgbG9hZGVkDQo+ID4gPiA+IGZpcnN0IGJlZm9yZSBhY3BpX2RyaXZlciwgaXQn
cyBjaGFuZ2UgdGhlIGluaXRpYWxpemF0aW9uIGxldmVsIHRvDQo+ID4gPiA+IHBvc3Rjb3JlX2lu
aXRjYWxsLiBJJ20gbm90IHN1cmUgd2hpY2ggb25lIGlzIGJldHRlciwgYnV0IGl0IHNlZW1zDQo+
ID4gPiA+IGN1cnJlbnQNCj4gPiBwYXRjaCBpcyBtb3JlIHJlYXNvbmFibGUuDQo+ID4gPiA+DQo+
ID4gPiA+IFRoZXJlIGlzIGFuIHBhcmFtZXRlciAiZm9yY2UiIHRvIG1hbmFnZSB0aGUgaGFsdHBv
bGwgZW5hYmxpbmcuIElmDQo+ID4gPiA+IHVzZXIgd2FudCB0byB1c2UgQUNQSSBpZGxlLCBpdCBj
YW4gY2hhbmdlIHRoaXMgcGFyYW1ldGVyIHRvDQo+ID4gPiA+IGRpc2FibGUNCj4gPiBoYWx0cG9s
bGwgZHJpdmVyLg0KPiA+DQo+ID4gVGhhdCB3b3VsZCByZXF1aXJlIHRoaW5ncyB0byBiZSBhcHBl
bmRlZCB0byB0aGUga2VybmVsIGNvbW1hbmQgbGluZSBpbg0KPiA+IGNhc2VzIHdoZXJlIHRoYXQn
cyBub3QgbmVjZXNzYXJ5IHRvZGF5IGFuZCB0aGF0J3Mgbm90IGFjY2VwdGFibGUuDQo+ID4NCj4g
VGhlIGhhbHRwb2xsIGRyaXZlcidzICJmb3JjZSIgcGFyYW1ldGVyIGlzIGZhbHNlIGJ5IGRlZmF1
bHQsIHdlIGRvbid0IG5lZWQgdG8NCj4gYWRkIGV4dHJhIGNvbW1hbmQgbGluZSBvcHRpb25zIGlu
IG1vc3QgY2FzZXMgZXhjZXB0IHdlIHdhbnQgdG8gZW5hYmxlIHRoZQ0KPiBoYWx0cG9sbGluZyBk
cml2ZXIuDQo+IA0KPiA+IFdoYXQgeW91IHJlYWxseSBzZWVtIHRvIGJlIHdhbnRpbmcgdG8gZG8g
aXMgdG8gdXNlIGhhbHRwb2xsIGluc3RlYWQgb2YNCj4gPiBBQ1BJIGlkbGUuICBJcyB0aGF0IGNv
cnJlY3Q/DQo+IA0KPiBZZXMsIEknbSB0cnlpbmcgdG8gZW5hYmxlIGd1ZXN0IGhhbHQgcG9sbGlu
ZyB0byBpbXByb3ZlIHRoZSBwZXJmb3JtYW5jZSBvZg0KPiBzb21lIFZpcnR1YWwgTWFjaGluZS4g
QnV0IEkgZm91bmQgdGhlIGhhbHQgcG9sbCBkcml2ZXIgY2FuJ3QgYmUgZW5hYmxlZCBhcw0KPiBs
b25nIGFzIGFjcGkgaWRsZSBkcml2ZXIgaXMgZW5hYmxlZC4gSSB0cmllZCB0byBkaXNhYmxlIHRo
ZSBhY3BpIGlkbGUgZmlyc3QsIGJ1dCBJDQo+IGZvdW5kIHRoZXJlIGlzIG5vIHBhcmFtZXRlciB0
byBlbmFibGUvZGlzYWJsZSBhY3BpIGlkbGUgZHJpdmVyIGV4Y2VwdA0KPiBkaXNhYmxpbmcgdGhl
IEtjb25maWcgIkNPTkZJR19BQ1BJX1BST0NFU1NPUl9JRExFIiwgYW5kIGJ1dA0KPiB1bmZvcnR1
bmF0ZWx5IEtjb25maWcgIkFDUElfUFJPQ0VTU09SIiB3b3VsZCBlbmFibGUNCj4gIkFDUElfUFJP
Q0VTU09SX0lETEUiIGJ5IGRlZmF1bHQuIElmIEkgd2FudCB0byBkaXNhYmxlIGFjcGlfaWRsZSBk
cml2ZXIsIEkNCj4gaGF2ZSB0byBkaXNhYmxlIHRoZSAiQUNQSV9QUk9DRVNTT1IiLCBidXQgdGhp
cyB3b3VsZCBjYXVzZSBhY3BpIHRocm90dGxpbmcNCj4gYW5kIGFjcGkgdGhlcm1hbCBhcmUgYWxz
byBkaXNhYmxlZC4gVGhhdCdzIG5vdCB3aGF0IEkgd2FudC4gVGhhdCdzIHdoeSBJIGRvIHRoaXMN
Cj4gY2hhbmdlIHRvIG1ha2UgaGFsdCBwb2xsIGRyaXZlciBoYXMgYSAgY2hhbmNlIHRvIHJ1biB3
aXRob3V0IGRpc2FibGUgdGhlDQo+IGVudGlyZSBhY3BpIHByb2Nlc3NvciBmdW5jdGlvbmFsaXR5
IC4NCj4gDQoNCkFueSBmZWVkYmFjaz8gVGhhbmtzLg0KDQo=

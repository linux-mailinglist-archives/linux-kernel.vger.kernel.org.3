Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA806549D14
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347693AbiFMTL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351828AbiFMTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:10:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B423579BA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655141808; x=1686677808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AUEpW2YQ5J3rGVdCsjc1odTslxxPd99H/lDiXVbYybs=;
  b=kmFEC515dEZpAv/jjlFpoB3S0lfk+cfBoT40OXRNLQRJoBLbTbfTQ4cG
   zr8epfqQ4FbkZDQsM+9606tMrP1gcrMca+SxwKeb6uWwQ3gi2bMnjl66n
   61D79umRlWll7i7RRgEUQeQJmt/60ALd3M2QP6YLpWa8ZjLONsNkHFsbJ
   fI4fK+yc9zCsTZIh2+rqe895Kzn/RPTUhaGcWCaqzQ7cYC3JT66CW3/L8
   dPUB67HEZBp4qmThjUu/1TltIO0lWWnu8GigSmVhBS9ZTgP50Hip+F2aZ
   zDxFWkePdsdb7mLuJz0ImlTTmmUFCs7dY+NpyhUt8IseBNkvPwWr+12iV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="277134504"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="277134504"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 10:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="726370211"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2022 10:36:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 10:36:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 10:36:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 10:36:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhCPZCu785kjFrN7cYXaVF3rkffmZn7Ne205u50eYJBOQktBfX23T0ul8Eef/Nw4BJKBZt+3uyxdEErj+sqTt8PLqPYJMjNRu/gmoxEUT0EUf/Yi7wgKIHRv8TRbiPCcKePO9d4no8eSd3FZTt2Axq9zf3zntsDjxep2ptIbC34/57WcM1Ea+byAVfXe0Fb/+HU/h5Gl49e3/uPWAvCcUpEa9H//GcPXulwSSlUIQd/ziaGZQc7bcktf/C4VypOFv+N7SUBR/eOKRNKah5hmnxeaeYe2jTqhWmgu5La7BDSwrFbfJr6VEOyihiHMSczz6iTNRNzspqSaVvnQuhQZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUEpW2YQ5J3rGVdCsjc1odTslxxPd99H/lDiXVbYybs=;
 b=VXnZ0Ea7Kg9OZz6NwdZvm4sozJltZ19Rn0ObrhVN/v/aZvmh1wMjXZgXuSUzUIhV1W7Cx1NnedJb8Ri9LIjaAQEfCxIIXdGXwa+FGGaeSYNotK236o4EdHV26tGSIUvUxXWTsCQKINhAaPZNYeofFDDdME/P62OE26FmUV0wiWJBpeF7CnjG3LwgRxLhEb2+jF27LmrlrRaD90XtxSx7QHDBukSqoKovVUvo/T0FIQgPiqyiEbmIOBZBK2QdhTmvwTC3vzbTrzsU+b/Ajv4cLHIy+d3DqAods2Dxf2Y5ExI1ZCbBw9dotY4Vpl9/Gf7+tqErtwEdJQi8AeS25qmHaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4630.namprd11.prod.outlook.com (2603:10b6:208:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 17:36:44 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4%12]) with mapi id 15.20.5332.020; Mon, 13 Jun
 2022 17:36:44 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Thread-Topic: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Thread-Index: AQHYfNdsZ8qhjd5y50Oatxr0zO7+Ka1NnpyA
Date:   Mon, 13 Jun 2022 17:36:43 +0000
Message-ID: <c7e2f8fb44da067e7565d091edeac300977b65ed.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
         <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06d765a9-eedd-45bb-2bbb-08da4d634889
x-ms-traffictypediagnostic: MN2PR11MB4630:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB4630F4973BFB9BB92DFCBDC5C9AB9@MN2PR11MB4630.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: feVZiNZC4YkRl1t2nL/G0uF+zXWhYJktyVboYmKXEEzRQOiVMBP3EWNx8PjRDYzDl+A55j/OeG/0Acr2vMO+143SgVP8CHiARlXz+ze78TWxNEb+BWDJwsQUumob58V/T1wHaBW8NQy1a1wr8EfRXVy4wSetC9J2+cdQAbUEuXmYyteVGOr842jC7tph5l4JS5GtXBXCqr0e+AZLup9IUULw0P8v3mZ+/01RjTWgF5FIEEIHg0hAsm86PrRbJ6Emlpww5/cJAL3vRKiVbO3ON/r5aPAldV01krp92GtgSQ+1fuanASqSIilNV09z7Bh8mFIS+C2ydPmzWpyD/NVH1Rm8G3MlprWeDWbkLR4cEJJZ39po7pzxGdIopLARoo7BpEHUzZNLkeQhENAGZJ5apJ99XbrkTTPnhIlNFYmBI+qIUtRHu46m0E961aYHmhcda3wDLK1XMwYtauSKQEuY6c9BXGBA20N3zqkrONuo6sgURrfkmv+YbtjHGiwoGRkbssDOSP0UVckvNHd5UP1gX6qAhIwGjufOZEDaDBBORNO0Hov+6GIEmfCpP9s3kq31qrSrrJC3O73ooXyYWl9b5VBSZOmp3v96Vzu33Hj6ji8canhRVpSjlMBOlH9QRpv4yilWS1F94sKm1iSUiu+2DgCOq23w6a/eaVqCqReO4vzoGYRM+72cLueyC+MDXT2DGEq4yQnEtqlQx0GQIwPQ2AtLgdSwqKd9svcMmPO1sNI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(110136005)(186003)(26005)(38100700002)(54906003)(2616005)(316002)(7416002)(6506007)(38070700005)(508600001)(6486002)(5660300002)(122000001)(86362001)(2906002)(76116006)(82960400001)(66476007)(66946007)(66556008)(8676002)(66446008)(8936002)(4326008)(64756008)(6512007)(71200400001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S3pXcG1mM3FITmZ0QkhYeTV4OW8wQit4VkxGdEJjS1hlZnJkREg3dElyYmFF?=
 =?utf-8?B?NkxLakwrd3p3MDhueHg2K1JiZXk0SjZlUTlpUXlvWmpiWGY0dWFIVTFHMXdO?=
 =?utf-8?B?RGxOMEVMVmVFQjdvWUs5c3U4TDM4SmxWYmNyUlJScXhXV2Z1WUp3T1MvU0dh?=
 =?utf-8?B?dDdqZDJ0d01DVXB2bjVGR2RNVTlicUxSeFlZeEhBSEd6dEFSQkExTWgvbnBC?=
 =?utf-8?B?U0p3emo4K2VjU08yTG55Zzd3OXlLQmNWeXpicUd1dEJieU9sc0d2V0JHenpH?=
 =?utf-8?B?OXNBRjRwN0xBUy9QU0R6NGtwQk1TTXlGT3JYUkpqL2x5bCtmODZLejIwbm9x?=
 =?utf-8?B?NXhvQmNSZTJ4TGkyejJUMjFuNXRpdjAvc2dXVkV0VTBtczNVYmhPWU1reW1Y?=
 =?utf-8?B?cTNMZnhxK2VRRkxYL2cra28vVFAvbkt4MDB3UFgzUXQxQm1wQmUvY3pvaXNE?=
 =?utf-8?B?WEtoMWdVclM1UkhiaXVaMllnZWRLV0Q3dklra2J2aDhPWjFDaEVPRkVQbEpv?=
 =?utf-8?B?clR1eVFYcks4VzM5Y0JkemErTGNiSGlZd0hoUDkzWlBvZmJTZVBkQjVGYmoy?=
 =?utf-8?B?ZkFjRDRIUTZ0ZFVZTm0wOXJjY2dwSjA2U2dEMDd0MldWZ3RsRjNFSDdIalhJ?=
 =?utf-8?B?cU5kZVJQMGpUbnNQNjkxUlVnVExGd1NET0l6QUFNbnJxUWNqL2FLUDV6RUpl?=
 =?utf-8?B?L1YydTY1YjBIalJrMU9wSHFScDd3WmJNRGoyK2tRWjEyR0JYdW1Ed01BaFZ3?=
 =?utf-8?B?NHN0bFdqOGtNRU9qTWZNdVh4S2dIUUgyUHVKcEp5ZTZ2Q1VoSlRVbitmMkNu?=
 =?utf-8?B?L0FPQTYxVHYySzFFUTFzcGgrR1VSdURDa3ovVFlJUXcxMlFKL3JiL3NlQktC?=
 =?utf-8?B?cjdEQ2dSekhaQXkvOFBnRU0vejdrRFVYamJjRmxxeGtzOG1odmwrTzJyMVJ0?=
 =?utf-8?B?Zk50aVBtdzBneFdFUitEdWQyV2kyNkhNTGxRejlFS28ydjhxUnlFbDFiTG91?=
 =?utf-8?B?MHlWTlErL0pxb3REMDB5NG51dHFmYm04WVF1TlV3NFNZbkdNRUh2QkNrRmFz?=
 =?utf-8?B?clNBWC8xSU9RSFZqQ3BhQ3BCVWdmZ2RkdmFiRFVJMERmT05PUlo2ZXp4WHMz?=
 =?utf-8?B?bmNzNWJKWi8wKytyUnlBQ05DWVpKL2p2QUd3VVgydGFnY1lNQ3dGUGFrdExL?=
 =?utf-8?B?cm02VW5rb2QxUS9KN2dBNGFFS1Nrcm1GUTd1OENUZnFtNVdCZjNnb29wQzRp?=
 =?utf-8?B?L1dOQnFxdDhhNmdGQnRFUS9yTDdzZXJ6eFIyTHVYOG9GT25GRUIyWm5LdHdE?=
 =?utf-8?B?K282cTBBT1crdzVuVjlMUDA1Zm9HR0txU0lWQmREcUEwc2tOck4rZ01WcnJ1?=
 =?utf-8?B?ZUpPaEJHZWYvb2krM2kvUUt1c2xYSC9FNVlDVi9zOGtlMWV3Wm9rdURwUDhJ?=
 =?utf-8?B?R3A0Z2NMSDhxTFl2TFQybTZXcGEzeGRuZ2ppbkptazFpUUN3TUVQaW1tYU94?=
 =?utf-8?B?eGNaWU1WVFFEbVdlWXVYaUVLOEt4WC9aTDczV1lsUGJ1SXFqeWlCcmJmYmVa?=
 =?utf-8?B?SDVoWEFIZVZ4Mkg3M3hYRkMwei8zeVhYTXpoc0hUSGNmMGxwSmpJMkV6K1F2?=
 =?utf-8?B?TEFrVlhIajVrZ3hOdGN6bW1mTExBaGlORnFoazdYTEU4ZEZEQWxQNVJ0Z3l3?=
 =?utf-8?B?M1RDUHR1UFh6dG1BbUthK0gxVllQaVRINHNHNFlCdTBySjdvUnNkRGlCbXR5?=
 =?utf-8?B?bUtmeDUwdHpEcGJGcndybWpLVGJQVTlscktaZnBUWXlKNXJXdkR4cVE0Q1pW?=
 =?utf-8?B?QVNvY3JlYzUxOWtjdkc5UFhvTjF1WG9IRk9YZEFjeHNIR2xab1I0MFYrR0kw?=
 =?utf-8?B?Wk9MWkMwdjV1VGVHQUZPMm9HNWF3NTFObG01dlEzOEVMcW1hMUxlN3hrY3lk?=
 =?utf-8?B?alJNSFVNZGJRTUZleWlSQ0hHMHdjbU5EeG9PU3IydU5YUVY1QXJ6SXIwdGlO?=
 =?utf-8?B?UG93RDR5Yi9lWVhQTDl4YzlqOXhTM0pMVkk5blNUYnBZWGJialNNREo2UjR1?=
 =?utf-8?B?ZzEyYWxuYTZGYk1iTEw2cHNYbnE5VnFBenkrSlVTT2VBMmw2YnErM2NYSllE?=
 =?utf-8?B?TnZWVUltckNBaEFJY29nQmdNM3RQUGNaZFlkWnNMdVFFM1FhY1BqUzVNVk9S?=
 =?utf-8?B?ckM5R1FjMkVHdCtRYXA1ZlJCbTE1OW5takhJZzVSY29rdFFlRFZac0dEMHlJ?=
 =?utf-8?B?TnVLL0VsOTlQT1hXcHJLa2lSdXRCcXp3VURBTlZKQXM0MVBoOGcxZ3luRTJO?=
 =?utf-8?B?QzMzd0V2TG1MQW5VZ21IYzlBOWg1T1FyRGx3QThyWW5DSUlFVFo1WW1MVmtQ?=
 =?utf-8?Q?/L2lec6fcLJ/IGQECUEdDVnFHcxMwoDBPymHq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5113DE92016682458A74E2E69AF96088@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d765a9-eedd-45bb-2bbb-08da4d634889
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 17:36:43.9771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06hGmDIJCK4IHBVAuSgRWWyZYXhx+tC2ZRxxCN8+7kT8NWAQerPVoqi5GCD2KofxMQHxSjX6QfUDMSekgbevzSSXjijPhQssLrYFNcASzU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4630
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA2LTEwIGF0IDE3OjM1ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+ICsjaWZkZWYgQ09ORklHX1g4Nl82NA0KPiArLyoNCj4gKyAqIE1hc2sgb3V0IHRhZyBi
aXRzIGZyb20gdGhlIGFkZHJlc3MuDQo+ICsgKg0KPiArICogTWFnaWMgd2l0aCB0aGUgJ3NpZ24n
IGFsbG93cyB0byB1bnRhZyB1c2Vyc3BhY2UgcG9pbnRlciB3aXRob3V0DQo+IGFueSBicmFuY2hl
cw0KPiArICogd2hpbGUgbGVhdmluZyBrZXJuZWwgYWRkcmVzc2VzIGludGFjdC4NCg0KVHJ5aW5n
IHRvIHVuZGVyc3RhbmQgdGhlIG1hZ2ljIHBhcnQgaGVyZS4gSSBndWVzcyBob3cgaXQgd29ya3Mg
aXMsIHdoZW4NCnRoZSBoaWdoIGJpdCBpcyBzZXQsIGl0IGRvZXMgdGhlIG9wcG9zaXRlIG9mIHVu
dGFnZ2luZyB0aGUgYWRkcmVzc2VzIGJ5DQpzZXR0aW5nIHRoZSB0YWcgYml0cyBpbnN0ZWFkIG9m
IGNsZWFyaW5nIHRoZW0uIFNvOg0KIC0gRm9yIHByb3BlciBjYW5vbmljYWwga2VybmVsIGFkZHJl
c3NlcyAod2l0aCBVNTcpIGl0IGxlYXZlcyB0aGVtIA0KICAgaW50YWN0IHNpbmNlIHRoZSB0YWcg
Yml0cyB3ZXJlIGFscmVhZHkgc2V0Lg0KIC0gRm9yIG5vbi1jYW5vbmljYWwga2VybmVsLWhhbGYg
YWRkcmVzc2VzLCBpdCBmaXhlcyB0aGVtIHVwLiANCiAgICgweGVmZmZmZmYwMDAwMDA4NDAtPjB4
ZmZmZmZmZjAwMDAwMDg0MCkNCiAtIEZvciBVNDggYW5kIDUgbGV2ZWwgcGFnaW5nLCBpdCBjb3Jy
dXB0cyBzb21lIG5vcm1hbCBrZXJuZWwgDQogICBhZGRyZXNzZXMuICgweGZmOTBmZmZmZmZmZmZm
ZmYtPjB4ZmZmZmZmZmZmZmZmZmZmZikNCg0KSSBqdXN0IHBvcnRlZCB0aGlzIHRvIHVzZXJzcGFj
ZSBhbmQgdGhyZXcgc29tZSBhZGRyZXNzZXMgYXQgaXQgdG8gc2VlDQp3aGF0IGhhcHBlbmVkLCBz
byBob3BlZnVsbHkgSSBnb3QgdGhhdCByaWdodC4NCg0KSXMgdGhpcyBzcGVjaWFsIGtlcm5lbCBh
ZGRyZXNzIGhhbmRsaW5nIG9ubHkgbmVlZGVkIGJlY2F1c2UNCmNvcHlfdG9fa2VybmVsX25vZmF1
bHQoKSwgZXRjIGNhbGwgdGhlIHVzZXIgaGVscGVycz8NCg0KPiArICovDQo+ICsjZGVmaW5lIHVu
dGFnZ2VkX2FkZHIobW0sDQo+IGFkZHIpICAgICAgICAoeyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXA0KPiArICAgICAgIHU2NCBfX2FkZHIgPSAoX19mb3JjZQ0KPiB1NjQp
KGFkZHIpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgczY0IHNp
Z24gPSAoczY0KV9fYWRkciA+Pg0KPiA2MzsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCj4gKyAgICAgICBfX2FkZHIgXj0NCj4gc2lnbjsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiArICAgICAgIF9fYWRkciAmPSAobW0pLQ0K
PiA+Y29udGV4dC51bnRhZ19tYXNrOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAr
ICAgICAgIF9fYWRkciBePQ0KPiBzaWduOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgKF9fZm9yY2UNCj4gX190eXBlb2ZfXyhhZGRy
KSlfX2FkZHI7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gK30pDQo=

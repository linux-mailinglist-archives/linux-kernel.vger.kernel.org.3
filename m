Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79484E8F30
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbiC1Hla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbiC1HlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:41:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315B752E16
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 00:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648453185; x=1679989185;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AdYNDqNvC+tb2dqJFL7pRl7kTAvDoc1ytv0n5iYkPRo=;
  b=MHhoH6j4ngnoHDW+dZKc2VDpnbcHRlhzOfM7VKmii5Of0Zu7ffsq4Jaj
   zK0zxBiVAXNTvDD0kSsjhxuO2F42co0mizn0y2fWbVx13jyRA8V0ck98I
   1IRJOs/bXbaPaiuXF5X2lw6q4+NGbaUhFsdrT9OkKiDE37uHJ2UnJ9tO4
   3hOyEQESYHc2u/mwI9HGpMYtUIei6WG+mjpabYCycO/awpzN2MGCzd+uK
   7mjj1XoSefb9oiJpfN8+y5yQp6tcDMEk9Btrei5D1Sp1Aby9nwPoPTzxO
   gFU+uYU3kUcXiid4RbpabKw8cVjvpXX9CMAj6ckCsuJf0WpdqhohbMMTk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="238869200"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="238869200"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 00:39:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; 
   d="scan'208";a="563405570"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 28 Mar 2022 00:39:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 28 Mar 2022 00:39:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 28 Mar 2022 00:39:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 28 Mar 2022 00:39:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWm9gw5iBDie7fPPARXc2HZZSqt0BYklljZfU1fSaI4eyoBFpNuHueUdXZV4vnjkqzVa7109LSvfRSZ/a19ATjD3GLDWhLEz4ERoNI9KeuMbHma6BSXsmekbxTdw98UF0JLeKv2vd6rSSC73bpmk1aKDXv6vSr3InlS+4FK/UEtuYec2FndXGBPrSGCil74QczoaBlbMbG6+bw2zYteZNH0imcLUAi8DtxgSa1MG3rspHIikuhtn5QDOgGvtEyeMyYmGu5oTVEx4FGOKbE9w2WswMccGT1WxIA9qssyIem+10IjruZ028zyxQCEGYRUHKnmrJo2n2ats30wyEmFE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdYNDqNvC+tb2dqJFL7pRl7kTAvDoc1ytv0n5iYkPRo=;
 b=KbzVYryyRR+rJeIZ44N6b67hnBJ28Sun0hNr5SaFxt80oB76Rnolu5tisFl+i9e+kvrVHk6zMhw2CkBPymrOyZeUaa1rc7K8s70XUvUWYPk12z5XCLL8I5JtBH/pb2Lu+K37+C7BDJdhNC8d7caEtP1hOd416jl2wdtZoQaWewZVhgZpPggla3wsrt6bDvkyUVuABikzSpSRvW31MkybQoASa+4WH17jjJPY9sVVuXIJR33GNMOlIU/PJpJrA6+4dcL6t7Tura6N0gJbQHKJjkczOPGNXn9o807Px0kWsUEeV51VqpsNF1XD0uCzNbCB0hnjSYaNHj8fn72V5E3LvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by BN6PR11MB4098.namprd11.prod.outlook.com (2603:10b6:405:7f::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 07:39:41 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::b03c:fa42:ac18:7fc3]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::b03c:fa42:ac18:7fc3%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 07:39:40 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Tvrtko Ursulin" <tvrtko.ursulin@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Subject: RE: [Intel-gfx] [PATCH v11 0/5] Add driver for GSC controller
Thread-Topic: [Intel-gfx] [PATCH v11 0/5] Add driver for GSC controller
Thread-Index: AQHYOG5ebdHrAgZbgk6fnEPjxUsd2azL4MmAgAib7dA=
Date:   Mon, 28 Mar 2022 07:39:40 +0000
Message-ID: <MW3PR11MB4651A829B5849D219B355D15ED1D9@MW3PR11MB4651.namprd11.prod.outlook.com>
References: <20220315131157.3972238-1-alexander.usyskin@intel.com>
 <d318c7ce-3b9d-0a61-e501-52fd43b77f8f@intel.com>
In-Reply-To: <d318c7ce-3b9d-0a61-e501-52fd43b77f8f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8b46bc5-a846-446f-ceea-08da108e1e6a
x-ms-traffictypediagnostic: BN6PR11MB4098:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR11MB409880346C3F270ED1B67574ED1D9@BN6PR11MB4098.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FBfSCxT+EsdeEogOnNJHWgW2NcoKZg5ziU32ISku8Vgy0CXqxWdx01DEVQrlNn39MKqgorLeSPNdUN1WzryqRakzfi3ZNWpxo5TFkqFMAbcrmRgD+uEn/GKmwJR0mNdeaCmEHbCicl4vb3ydikQo0b+QbTwciCiJX84RsVP/gLeAiV+6SFIxKNWodeJ7Mrr4T6yu7WBz4j7BUOIOlOXCFxI9MkveoyGl/0nhLP/54jHIn+K4oIxBHuwSqB8RSzJlWM59SHkCwVciEIx/WRg5eDIxH/jevNgfMaBgEEoaYrcKVJavuFHgenbeWSBjgIYPFNTGKfx33SQoFQYN/giUIf/0KqMuCG3v+2XZNsZyT5vQOgd//tBiPw9mWpvgx7wdC0k2afkylRE1ZY9T9z0nqaRXimKEf3an9dgebeVPBkyBv54Gu9gnauyCl6LkPwTflfkVgcx/WzArCrd4fuHjD30TiicfkevZ5lSnUTBVLfo4rb9wCuUj5At/xdbH7TsaFGn9518JjGAj65uHFQyJ8zGV/7JRAYOJmS+pC7BYf9zdFuS9D7YL/EMQTi3Kb099xlREr+DgneBNMhr1+xEsA0TtaxXjrW4INqwKxqFpsFZLBOL1VaIfbtL7MFiImKfE5BbKljnLPT1Nj3yfKjTBli+izplZdzbtks7wltLRC06XxKda53Ssgu/NctRqJqO4UrgGd1fNPOmh/baxvzQhuoO1DG8g6kZ13oacbwU4FE19tTTR8aQnMsrg7X+h+87dCrLjl6n74RgEsogQpixvxgPjM/a5/kWEX9cNfX3ZPxMijlVDUPKoDIhjug1KSey6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(966005)(53546011)(6506007)(66446008)(66946007)(5660300002)(7696005)(55016003)(54906003)(110136005)(86362001)(2906002)(38070700005)(82960400001)(4326008)(316002)(921005)(26005)(186003)(76116006)(52536014)(8676002)(66556008)(66476007)(8936002)(38100700002)(122000001)(33656002)(71200400001)(9686003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vkw0bzJqVml3M2QyeFFoeVEzRDRCcnBiVHlZd1N3ck9xWmFDN2V3TFdXUG9m?=
 =?utf-8?B?MGZxbEtxc0xveUNQaC84L08wcFlVRkZPRG5zbXAyYnA2UHRGdks3VVhmYWZC?=
 =?utf-8?B?aUwvZVREQU1Yck1hNER2a2ozSXh3QktEamwwcEw0RGpPb2JEUzNsWU5DWGR5?=
 =?utf-8?B?RHpIbjdlSlFDOFBQZVNpSDRRY0lwRi9OODJnMkhiNGI5NE52cnJQOVExMGYw?=
 =?utf-8?B?NnAvdHdDTU9pakE2SDZwUW9nVk5iMFpZK3J2OExEb3RqdUZkZlNTUWtNN0Vk?=
 =?utf-8?B?MU9CUzlaZVp3RXlhcWlzT3VEYUczcXNXdmNOQURxQ0twdFZkaXo0dkRveTZk?=
 =?utf-8?B?WXFZN1d3SDcydmNrN0FYZS8wMFhHc0FOWDB2TkY5cjNuRm5sbktKekhkU3ht?=
 =?utf-8?B?eENjVzVadkFGS3hvTCtqUGNpRGF1L1ZDRFRTaWJod21HWnplYjJURmtzazh1?=
 =?utf-8?B?a3E1U0gwTUtGS0hZYmQwckQrTm5qdEx5RFc2NEJhWGw3MHYrT0xlOUF4d2NU?=
 =?utf-8?B?Nm9XeCtJeE1kNDBPbmtJSFUvSUJaSmNmME5kc05STHpHYk0xaFBrZktCRStG?=
 =?utf-8?B?OGtaR0pLakozNVVMajdBaENGUmlBb0hGLytzWXhQZUVRcnhuM2ErQmM2bmZw?=
 =?utf-8?B?UUxoOGMxQ0JiZzFTb0d1Y2lOQUVjUFpVbzFlRktvbVY3UmoyTVBEYTU5N0Jz?=
 =?utf-8?B?UUVDcVZDckJJeFBRTzQ4VDNPOHRkTjc3MWdIejhQQUF1NlNJZ3pYem02cVkx?=
 =?utf-8?B?UTU4UzlCN092cXJ2UG9FSGZNYzdPSGpMdVpFUjhQeDRlc3RvUlRWNmFVL0lx?=
 =?utf-8?B?VkhHNURRQXA5TXFnbnRQTE1hSjY1MTB4bmkrYUFteXBNQ215MHJvWmZwWWcz?=
 =?utf-8?B?bEpmS1hmR1h6ZnpMMTU0TkE4VGtxMU5aVGw5YWVlVU5YQ2xLVXhoclFZbWNh?=
 =?utf-8?B?SzdoVytTYnQxUVJSRGNvdThSYVBUN3lzMXpxcjE1WERGMkIrTk9UOG41cGhN?=
 =?utf-8?B?TXlXaUxnRTlPYlBIVndOTWhIaTlQMUVoUWkzTzdmK2QyWWhpcXhjZXd4TmNB?=
 =?utf-8?B?bkRFWjhUMjh3M0liRHpOblg4TTdjNFJxK3JTQkxUOURjcmxjSFR2VlN6MFNI?=
 =?utf-8?B?OXhwY2RkUTNYZjYvZ1Z4VDNXZFJ2UVFVUDBMUEQxTGgwdmRteGVrSy9MSmY1?=
 =?utf-8?B?d2dCbjM1a09JZ2RMT0JjQjM3elMvZnZhcnUvdTFLdjcwVkV1VmMzcE5Nb20w?=
 =?utf-8?B?aXprdXduQ0Y2anVaQXZUMTBIa0F2NGN1NmhlSEYwLzhPVU5SdnlJbWliWTdT?=
 =?utf-8?B?aXo3ZUZaeCtXbzRaa2xuVlorSENxS1BaM1J6Nk14ZjlUUVJGNFVWMElGdGRk?=
 =?utf-8?B?RkNyaVhlbndKU0YzbHJIeVBMbVJ1SGRnd3lTRHBLdXloektzUGxpY3hMNjdy?=
 =?utf-8?B?cE5MSHRCUG1zZFovVjhhVUpGbkUySks3d0J1Q294N01BeU9QekxGNmlpblpB?=
 =?utf-8?B?V3VRVEFkU2FiSm5Fd29leDlEcmJLb2JPaDcrblJJWXorRUhSRzFydWdnanFJ?=
 =?utf-8?B?cnFHV045WkY5bnk5MCszOUJ1eFViSzlGRWRMT3JPSy9qbkE2d3dKTko0VXhY?=
 =?utf-8?B?QzBnRXUrdjRJZitLaHp2UW5LL1ZraHhIYkFyaC91YnRMWHlEODlkNXRTUWdX?=
 =?utf-8?B?SFhtREV0WXpvWkVIM2RZWHBOOWdkblNpWXlmZmk5Ujl0Y01NUkx6czBVeVdn?=
 =?utf-8?B?RDNoQVlBODg2TTVybWhyZTZUYzVHQnBTa1Rua0NVQzZmL2ZRTGZhTGFERW1j?=
 =?utf-8?B?VXoxYjNNZEdBUkNYWVhXY3hOYVNqT21GYjAzTnd4aWRvKzMwS2VZdnJDMzJh?=
 =?utf-8?B?ZmUvbXJONmFVbCtxSzBsaFgxRWpLU0w2c3phTmV1MmNUM0tpaGlyVnZzR1g4?=
 =?utf-8?B?SWVZOWJkMHdjaHk5bU9CV0h4TER2WkxyM043SlY4dHhWWEdQeE5HbDN5RkZo?=
 =?utf-8?B?U3VQalFuaVJpdWRGWVVEa1BQcDZXREpXN2dEZHFBb0RVdi9PVTE3OVV5ZUZR?=
 =?utf-8?B?T3oxVzlZemhLNjA4MTk2RG42ZUtDdW9DMUhodG1oRDM3bnhqYW40SXNXdjha?=
 =?utf-8?B?anlBRVZ4RkJrcU5CRTZXajFUcVZQdmU0M0gvT01YZVV5MmZOejhld0Z5ekdJ?=
 =?utf-8?B?MG1VVVRoYm56eE9MUFYvT1BwaUZyWFRvSXEvYXA3dXQxUzFiWXdCaUNPMlJZ?=
 =?utf-8?B?eDFTbzhjYXVUM1NQcHpRQ3VCcExodVM2K2h6Mm50YjdMNmVjMjVzU1VwclBq?=
 =?utf-8?B?TmR4RVJhWTNiMlZpa283QVhITHBKdmZJWTAwVTFNekttYXRmY2FZaHlmNVJD?=
 =?utf-8?Q?kbCo9k1uDtDBXTTQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b46bc5-a846-446f-ceea-08da108e1e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 07:39:40.6019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYcizKMAfp8sO+i3B1FiE4CfCwZNC3ZaOdfZS0nb9NW8RKLEClG++p/EU104zR1JxtSVhTzx2ooId5Zp8mUgm99pOXEusBwezUbAdMT3S/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4098
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkNCg0KQXMgSSB1bmRlcnN0YW5kIHRoZSBjb25maWcgcGF0Y2ggc2hvdWxkIGdvIHRvIGh0dHBz
Oi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9nZngtY2kvaTkxNS1pbmZyYSBrY29uZmlnL2RlYnVn
LCBicmFuY2ggIm1hc3RlciIuDQpUaHVzLCB0aGlzIHNlcmllcyBkb2VzIG5vdCBuZWVkIHRoaXMg
Y2hhbmdlLiBBbSBJIHJpZ2h0Pw0KDQotLSANClRoYW5rcywNClNhc2hhDQoNCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDZXJhb2xvIFNwdXJpbywgRGFuaWVsZSA8ZGFu
aWVsZS5jZXJhb2xvc3B1cmlvQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMjIs
IDIwMjIgMjI6MTANCj4gVG86IFVzeXNraW4sIEFsZXhhbmRlciA8YWxleGFuZGVyLnVzeXNraW5A
aW50ZWwuY29tPjsgR3JlZyBLcm9haC0NCj4gSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+OyBKYW5pIE5pa3VsYQ0KPiA8amFuaS5uaWt1bGFAbGludXguaW50ZWwuY29tPjsgSm9v
bmFzIExhaHRpbmVuDQo+IDxqb29uYXMubGFodGluZW5AbGludXguaW50ZWwuY29tPjsgVml2aSwg
Um9kcmlnbyA8cm9kcmlnby52aXZpQGludGVsLmNvbT47DQo+IERhdmlkIEFpcmxpZSA8YWlybGll
ZEBsaW51eC5pZT47IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD47IFR2cnRrbw0KPiBV
cnN1bGluIDx0dnJ0a28udXJzdWxpbkBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBXaW5rbGVyLCBUb21hcw0KPiA8dG9tYXMud2lua2xlckBpbnRl
bC5jb20+OyBMdWJhcnQsIFZpdGFseSA8dml0YWx5Lmx1YmFydEBpbnRlbC5jb20+OyBpbnRlbC0N
Cj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW0ludGVsLWdmeF0g
W1BBVENIIHYxMSAwLzVdIEFkZCBkcml2ZXIgZm9yIEdTQyBjb250cm9sbGVyDQo+IA0KPiBDYW4g
eW91IHJlLXNlbmQgdGhpcyBzZXJpZXMgd2l0aCBhbiBhZGRlZCBwYXRjaCB0byBmb3JjZQ0KPiBD
T05GSUdfSU5URUxfTUVJX0dTQyB0byBiZSBzZWxlY3RlZCBmb3IgQ0k/IHdlIGRvbid0IG5lZWQg
dG8gcmV2aWV3IG9yDQo+IG1lcmdlIHRoYXQgYWRkaXRpb25hbCBwYXRjaCwgYnV0IEkgd2FudCB0
byBtYWtlIHN1cmUgd2UgZ2V0IENJIHJlc3VsdHMNCj4gd2l0aCB0aGUgY29uZmlnIHR1cm5lZCBv
biBiZWZvcmUgd2UgbWVyZ2UgdGhpcyBzZXJpZXMuIEknbSBhbHNvIGdvaW5nIHRvDQo+IHBpbmcg
dGhlIENJIHRlYW0gdG8gc2VlIGlmIHdlIGNhbiB0dXJuIGl0IG9uIGJ5IGRlZmF1bHQgZm9yIENJ
IGJ1aWxkcy4NCj4gDQo+IERhbmllbGUNCj4gDQo+IE9uIDMvMTUvMjAyMiA2OjExIEFNLCBBbGV4
YW5kZXIgVXN5c2tpbiB3cm90ZToNCj4gPiBHU0MgaXMgYSBncmFwaGljcyBzeXN0ZW0gY29udHJv
bGxlciwgaXQgcHJvdmlkZXMNCj4gPiBhIGNoYXNzaXMgY29udHJvbGxlciBmb3IgZ3JhcGhpY3Mg
ZGlzY3JldGUgY2FyZHMuDQo+ID4NCj4gPiBUaGVyZSBhcmUgdHdvIE1FSSBpbnRlcmZhY2VzIGlu
IEdTQzogSEVDSTEgYW5kIEhFQ0kyLg0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgaW5jbHVkZXMgaW5z
dGFudGlhdGlvbiBvZiB0aGUgYXV4aWxpYXJ5IGRldmljZXMgZm9yIEhFQ0kyDQo+ID4gYW5kIG1l
aS1nc2MgYXV4aWxpYXJ5IGRldmljZSBkcml2ZXIgdGhhdCBiaW5kcyB0byB0aGUgYXV4aWxpYXJ5
IGRldmljZS4NCj4gPg0KPiA+IFRoZSBwcmluaWNwYWwgdXNlciBvZiB0aGlzIGludGVyZmFjZSBp
cyB0aGUNCj4gPiBJbnRlbCBHcmFwaGljcyBTeXN0ZW0gQ29udHJvbGxlciBGaXJtd2FyZSBVcGRh
dGUgTGlicmFyeSAoSUdTQyBGVSkNCj4gPiAoaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2lnc2Mp
DQo+ID4NCj4gPiBJbiB2MiB0aGUgcGxhdGZvcm0gZGV2aWNlIHdhcyByZXBsYWNlZCBieSB0aGUg
YXV4aWxpYXJ5IGRldmljZS4NCj4gPiB2MyBpcyB0aGUgcmViYXNlIG92ZXIgZHJtLXRpcCB0byBt
YWtlIHB1YmxpYyBDSSBydW5uaW5nLg0KPiA+IEluIHY0IHRoZSBub3QgbmVlZGVkIGRlYnVnIHBy
aW50cyBhbmQgZW1wdHkgbGluZSB3ZXJlIHJlbW92ZWQsDQo+ID4gICAgICAgICdzZWxlY3QnIHdl
cmUgcmVwbGFjZWQgYnkgJ2RlcGVuZHMgb24nIGluIE1FSSBLY29uZmlnLA0KPiA+ICAgICAgICB0
aGUgbmV3IGluY2x1ZGUgZmlsZSBub3cgbGlzdGVkIGluIHRoZSBNQUlOVEFUSU5FUlMgZmlsZS4N
Cj4gPiBWNSwgcmViYXNlIGFuZCBhZGQgR3JlZyBLSCBSZXZpZXdlZC1ieQ0KPiA+IFY2LCByZWJh
c2UgYW5kIGRyb3AgcmVkdW5kYW50IGFzc2lnbm1lbnRzIGZvdW5kIGJ5IHRoZSBrZXJuZWwgdGVz
dA0KPiA+IHJvYm90Lg0KPiA+IFY3LCBhZGQgR3JlZyBLSCBSZXZpZXdlZC1ieSB0byB0aGUgaW5k
aXZpZHVhbCBwYXRjaGVzDQo+ID4gVjgsIGFkZHJlc3MgVHZydGtvIGNvbW1lbnRzIGZvciBpOTE1
DQo+ID4gVjksIHJlYmFzZSBhbmQgYWRkcmVzcyBtb3JlIFR2cnRrbyBjb21tZW50cywgdXNlIGRy
bSBlcnJvciBwcmludGluZw0KPiA+IFYxMCwgcmViYXNlDQo+ID4gVjExLCBhZGRyZXNzIFJvZHJp
Z28gY29tbWVudHMgYWJvdXQgY29kZSBzdHlsZSwNCj4gPiAgICAgICBzZXQgbWlzc2VkIG1hc2sg
aW4gdGhlIGludGVycnVwdCBjb25maWcsDQo+ID4gICAgICAgYWRkIGV4cGxpY2l0IGRldm1faXJx
X2ZyZWUgdG8gZXJyb3IgYW5kIHJlbW92ZSBmbG93cw0KPiA+DQo+ID4gVG9tYXMsIHBsZWFzZSBs
b29rIGF0IHRoZSBkZXZtX2lycV9mcmVlIHBhcnQuDQo+ID4NCj4gPiBBbGV4YW5kZXIgVXN5c2tp
biAoMik6DQo+ID4gICAgbWVpOiBnc2M6IHNldHVwIGNoYXIgZHJpdmVyIGFsaXZlIGluIHNwaXRl
IG9mIGZpcm13YXJlIGhhbmRzaGFrZQ0KPiA+ICAgICAgZmFpbHVyZQ0KPiA+ICAgIG1laTogZ3Nj
OiByZXRyaWV2ZSB0aGUgZmlybXdhcmUgdmVyc2lvbg0KPiA+DQo+ID4gVG9tYXMgV2lua2xlciAo
Myk6DQo+ID4gICAgZHJtL2k5MTUvZ3NjOiBhZGQgZ3NjIGFzIGEgbWVpIGF1eGlsaWFyeSBkZXZp
Y2UNCj4gPiAgICBtZWk6IGFkZCBzdXBwb3J0IGZvciBncmFwaGljcyBzeXN0ZW0gY29udHJvbGxl
ciAoZ3NjKSBkZXZpY2VzDQo+ID4gICAgbWVpOiBnc2M6IGFkZCBydW50aW1lIHBtIGhhbmRsZXJz
DQo+ID4NCj4gPiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDEgKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2k5MTUvS2NvbmZpZyAgICAgICAgICAgICB8ICAg
MSArDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9NYWtlZmlsZSAgICAgICAgICAgIHwgICAz
ICsNCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2d0L2ludGVsX2dzYy5jICAgICAgfCAyMDQg
KysrKysrKysrKysrKysrKysrDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9ndC9pbnRlbF9n
c2MuaCAgICAgIHwgIDM3ICsrKysNCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2d0L2ludGVs
X2d0LmMgICAgICAgfCAgIDMgKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3QvaW50ZWxf
Z3QuaCAgICAgICB8ICAgNSArDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9ndC9pbnRlbF9n
dF9pcnEuYyAgIHwgIDEzICsrDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9ndC9pbnRlbF9n
dF9yZWdzLmggIHwgICAxICsNCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2d0L2ludGVsX2d0
X3R5cGVzLmggfCAgIDIgKw0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2k5MTUvaTkxNV9kcnYuaCAg
ICAgICAgICB8ICAgOCArDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1X3BjaS5jICAg
ICAgICAgIHwgICAzICstDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vaTkxNS9pOTE1X3JlZy5oICAg
ICAgICAgIHwgICAyICsNCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2ludGVsX2RldmljZV9p
bmZvLmggfCAgIDIgKw0KPiA+ICAgZHJpdmVycy9taXNjL21laS9LY29uZmlnICAgICAgICAgICAg
ICAgICB8ICAxNCArKw0KPiA+ICAgZHJpdmVycy9taXNjL21laS9NYWtlZmlsZSAgICAgICAgICAg
ICAgICB8ICAgMyArDQo+ID4gICBkcml2ZXJzL21pc2MvbWVpL2J1cy1maXh1cC5jICAgICAgICAg
ICAgIHwgIDI1ICsrKw0KPiA+ICAgZHJpdmVycy9taXNjL21laS9nc2MtbWUuYyAgICAgICAgICAg
ICAgICB8IDI1OSArKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9taXNjL21l
aS9ody1tZS5jICAgICAgICAgICAgICAgICB8ICAyOSArKy0NCj4gPiAgIGRyaXZlcnMvbWlzYy9t
ZWkvaHctbWUuaCAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiA+ICAgaW5jbHVkZS9saW51eC9t
ZWlfYXV4LmggICAgICAgICAgICAgICAgICB8ICAxOSArKw0KPiA+ICAgMjEgZmlsZXMgY2hhbmdl
ZCwgNjMzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3QvaW50ZWxfZ3NjLmMNCj4gPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vaTkxNS9ndC9pbnRlbF9nc2MuaA0KPiA+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbWlzYy9tZWkvZ3NjLW1lLmMNCj4gPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L21laV9hdXguaA0KPiA+DQoNCg==

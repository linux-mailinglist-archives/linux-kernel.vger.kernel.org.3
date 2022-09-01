Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62335AA339
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiIAWmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbiIAWl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:41:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BE867171;
        Thu,  1 Sep 2022 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662072118; x=1693608118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XLUuR75fRjQSsbDJ7rDBg3RlfqEj4SrKxFLQh0E2tnU=;
  b=hi1TuO8nMVNico6LPZPastaGl5YZ2YkkabDxW+kB8Bf7AnDVSn00MNMs
   J/qYPFQI3xRUDHrBQEnAmla8XQjZmxvpX5uCPmcHCie/MiWhKAOTfYO3s
   gaVNW/5N7tZKq74oXlb0G+0u7xkViT46eYzb6Cfy2uQhp1hwWIuV53Ma5
   l8WX/B6FIfklFT0tBnjgruZ/dksB7erPf2bcufJgQV87m59TBHdLeg6CC
   UolI4Y9oyZnrMfNnxd4Q/Q6ZasQxcSc/iRc+2Iv4McTOJL5M26wvhFpsr
   zmTCYwhu1htAcu/szvTlvr+yIpnnwukhSW73MvQlDgJfOMDhUgpRYh639
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="275589409"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="275589409"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 15:41:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="681054035"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2022 15:41:58 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 15:41:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 15:41:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 15:41:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJ4WOwNC2WC0DmofTxVWdbmxCDZnPgRBqYqbnoo1ihLNQSErSskKoBfzt+VPI8c9QOTJxDTbsXyJxOkXkvsNBS5TJ6MhqxVWucSibq7tUM1RcmJMAsMHipvof0wjKBZ9vpWmX3vTcOxtLBOVpT9Sd15TB2T4WBQaXY9idHP5C1bUr7/gBRztu9cbwmj6eObMvGb+Cft90vXR8+BdhC1T4rb4EKyrrQNOpsoix39DUIJ7y9e+0Fg7lhvQbW++Rf0+HxRKveqw9ASVn4t4cmHZSwg448xOmKdbNdJu1nzuQ2F0KvDcuEOtCJuNXsDugHtDHZ2r6spP8mc/NQlSvr9doQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLUuR75fRjQSsbDJ7rDBg3RlfqEj4SrKxFLQh0E2tnU=;
 b=KQeFC00RpIWl+31h5ggtcfNbFjtABgqaLNgNsHU8vAm579xh6TtbETWFqhHkdifvbuUxp/j7cwnpLWg2in8iAJd0Uz+pwP1esIg21hI0eAjKDj0yoiNxCC2uCyoQWyxdzMp4teargIYxqMkQb1ssizf/ANB7yLGA+8xcoHFF/XZ5gAgb7ScdiWkrofVbtuhhAk4a5Ph3vOn+K/xGW8wmlazCIE5YPwzNvBlOGzWyeUXvUMGHbU+L34gglR7PRlJJkvUDCRSZjDiVmonliYik559TN4GrCaXTj6iWZs/wu3493+KwdMsbLeYOuzApq4pvoqZysZL2G4zLsuQXYAUltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM5PR11MB1241.namprd11.prod.outlook.com (2603:10b6:3:15::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 22:41:54 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708%8]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 22:41:54 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "jarkko@kernel.org" <jarkko@kernel.org>
CC:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Topic: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Index: AQHYvB5Zhte1gFzwtkKh12BdFyDkBa3IDqyAgAAq44CAAA1sgIAABY4AgAAChYCAAAMQgIAAAG0AgAAFhYCAAMlpAIAANTGAgAAB5gCAACO1AIABr4AAgAAEDoA=
Date:   Thu, 1 Sep 2022 22:41:54 +0000
Message-ID: <e1229a770fd2b4ec6642b921ec4a7e9ed0d11a3b.camel@intel.com>
References: <Yw7EX5GCrEaLzpHV@kernel.org>
         <d07577c3f0b4b3fff0ce470c56f91fb634653703.camel@intel.com>
         <Yw7LJa7eRG+WZ0wv@kernel.org>
         <c3c085d69311ed759bff5bb325a2c182d423f91f.camel@intel.com>
         <Yw7OEh7QP8tb7BR1@kernel.org>
         <a91f65ad5c392b6e34f07bc6d3f35c89a76a98db.camel@intel.com>
         <op.1rrt4aecwjvjmi@hhuan26-mobl1.mshome.net> <Yw+oR3FKlwbeOl6I@kernel.org>
         <ea61a9ee-96dc-4f23-9de3-34e033391abc@intel.com>
         <94993d90b0b3c59fae61427cf0cc78dd10c381bb.camel@intel.com>
         <YxExyuA/+ptl0Y4G@kernel.org>
In-Reply-To: <YxExyuA/+ptl0Y4G@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d97fcfe-8864-4850-c4fe-08da8c6b2baf
x-ms-traffictypediagnostic: DM5PR11MB1241:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1cJvqaw0qdKrsLRDjmjouYemH96jJ9/pJWBD1qdoo2zKQnW8sXUDGQsFRF7per/Ff1/TwPQMEcqoNhgkfa8HV3xtdmsUOpnNeVg6rCESxieHHr7Jim5a9uLDkObviHPH0ZJB4XuWCJ0OwhYERocDMTvpIaoH8oa5cNI2arlASwn89DKhHq/jROmquH26P17//kiIWLNgS1OcNNhJKWcwHdpmNNdEkuhLEq4Jv+4GRVDogC9FmUi82RwY1BKYmaXd1iHRfeTVb1fsBSRLd626qti3Jt4Cd//3YNy6GQO7eJJrn5n4CKpxY82TBdPyZfeaHozMqgziT3B7oW++RFFL8oo6XyDTzHNcf7gMy8Cv7pXBh6Vm8Cf0YPboAnpO6vgayj+mEJzujI8uoaI02OFmdCP2HrwaezLpMtchW4RzZU6EF1/lLcdVu93jipamHNljUPZfQbNO3lvyUlVOUL37KfAUsQWoHNrlhCF0m+qfAa3UqHftbNGLjRqicSJvSSufxl0fyny8Z3QJOu+R+OXeHnXKeYcNXff2lSC/bNO8MFIikT5fNu0XuN9B4xoljQfzsmpmQFLI+14uKxwGVm0R/bCX/Zs6GykXrWI9ucKLJgg0wKEtiYdZiq+vCsWwBMHYyTvf7DTJ/h7mfdwcrjsTXIvs/xUtyqihPaFKruO73NoUXS5LpcSVd0POvCIMCzkg0nL/Vu+YgUY0jn4SOppNl47ZXgE1gGmaXdhs81wKBwPXww3aMLw60TCUwt/vZSkMNcI/+I+r0bGqsEwD3nw4wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(136003)(376002)(366004)(122000001)(66946007)(5660300002)(4326008)(91956017)(66476007)(66446008)(66556008)(64756008)(186003)(76116006)(7416002)(2616005)(8676002)(53546011)(6506007)(38100700002)(316002)(41300700001)(36756003)(26005)(6512007)(8936002)(2906002)(6486002)(478600001)(54906003)(6916009)(82960400001)(86362001)(83380400001)(71200400001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0FQdzJaeCtweDNuc3pYMjRncHYzcW91NU9heVhIdkxFYm1kekZNM1p4bVFP?=
 =?utf-8?B?cVRNT2dHaU0xTVBWelR0WU5IaGwrWUo1QmZUR3hxTTE3V0dTVFBpdXRxSHVX?=
 =?utf-8?B?YldwNDU1WSttY1NXSHFBcEViOVVwNXMzM2VWbGk3YTZDSzA1bnlqNlFLNFRH?=
 =?utf-8?B?bnJFYThkWlFEUEFCcmlnMzExNzVlSUhEUmVWcXZrZG5yU29KeUZpV3A4M1lu?=
 =?utf-8?B?NjdDbXhRQTlqYlJvd2FXTFpQSU9xcmVkczVhMUNzS1o2WENuWHBzZ3RTNnVl?=
 =?utf-8?B?ZUFBSXFRbjgyOXBDSGJ5QkRQQm1wcTRIL2RHWmNXL0VVQVBCd3gvOER0WkZU?=
 =?utf-8?B?YTF1Qzd5RlN3K0tsb1VYWFNWZjJjeC92UVNYck9MZ3gvbjcyRGMveXQzWnpS?=
 =?utf-8?B?SWs3ZHNpb084dG1DeHpCSGN5eE1rREd0WkFES1BQenkvOEV1NlY4Tmk1RmpZ?=
 =?utf-8?B?K0p6bFNPNnZrQldxbWpuZkFJMXA1VUpWamMva3M3RlBiamU2bStBRXhZMDFS?=
 =?utf-8?B?eDVwS1p6TGN3MkNwbDFpRTc1ZHRxeE1BbXprZFFQRTNmQXRxQ1VvNE5PK0hF?=
 =?utf-8?B?a2wxL1ZrN2JWbGZ3VjhMSGdoQ0ZWRlBFZW1Bc1A1U0E1NmtYb3dYS0xrKy80?=
 =?utf-8?B?ek9ubkNkaVFNZFdwcEJVMkE3MkpLd2lKelpmTW1PNDkvbm5TbUJFMk5hdWZM?=
 =?utf-8?B?ZFBwMFZxejRSY2ZlRXdPS2pmNU80MytiSUZGd2Jkb0xEOU80Q0Y3WWR6Vjg4?=
 =?utf-8?B?eFBMdmtzbU1HZllWQ1NGbllwR0dxK3FuOHk4ZzQ0Mjkrd282azN1bTRvMWJF?=
 =?utf-8?B?U2hiazQ1L3BKWHRYNEZHWWtjaGFtRkE5NHcyREJ4UENraGdhMmxBZjFlQ3ZO?=
 =?utf-8?B?bDdmdStSZVpnSEpsVHZIdW1DOGJ2SHlXMTIzMDdsZnJpNUJjOFM1bmJHaHdY?=
 =?utf-8?B?M0FaR1VSbjdsQlF2NVNWNndXUFZEb0VlYmM1NVI1RE5TWDFoOCtFejlrYWhQ?=
 =?utf-8?B?bnhEdGl2cmdhTW9nSzg5Mk1aeG03eHRkN2ZQTUVOZDQrcENkNnFLQkJYbmVu?=
 =?utf-8?B?Rm1MakFLN2ZJa2duYzN3RGRPWUcxZGUzQlA4S1NRalQzVWpNaW03cTBXbGgx?=
 =?utf-8?B?ZklOKzRpeEN4VnZ6aVg5K2x3UEhOQTM4Y21pZVlFV2NWd09QRG1RbFcyb2Jw?=
 =?utf-8?B?NEFmSzd1Wk1xT3ZQOUZ5djJPYXUyT2o4K2RBcHFhQlFucFA5NnJYTVhoSW9h?=
 =?utf-8?B?N1dQRms0YjZJNW5BVWRwQUV6MDlXR1NNT0xPR0Z6MUhha0hwTERiTS9oMWNu?=
 =?utf-8?B?amRpcTEvWkxEakRnZ2hLTk9mK3prei9XbEo1VkMwM2puVWxnbmxiR09sNy9t?=
 =?utf-8?B?b0hhbzVlbDJEU0l3TDdXY2s0dlRrUzZWeDI5YXYvaFA1SzM5Qlp3RktJNFlS?=
 =?utf-8?B?L2Q3bURmYStwcFQxTDZFNytmL0RLcjMvZmV1MnVlbHBKYVp4SG5RTUovRy9a?=
 =?utf-8?B?d2NIYUorVHdPVFFvNEs1ajNrVW5pQTFkbUNTZ2pCdng2clZnSituZ0h5VWZU?=
 =?utf-8?B?blRjazBHWTVmUGtyTkVpTVFJb2RuZ0RlaUF6ZGYxNUlUSUlHdkYzaU56UGJI?=
 =?utf-8?B?d2Nyejd3NVhTZGhEcllocGdwenRTcTdTWmNYdmZYTGN0dXpheDdkeGN2Q1Ro?=
 =?utf-8?B?S1VGZDA1VFBSaXplTmZDR3F5NC9mZSt0SmhvbUx5QThEUzVzYUl5a0JtVmpD?=
 =?utf-8?B?L3AxMTVzMW9teGtUZEQ3SzQyc0I5UnVJRzBxZVMvS20zY3FOMlE1a2tvOVBL?=
 =?utf-8?B?MEJSakc2dkhHZUxXR3VzR0xMaDhEOXZBQUdaRHVtQjBoMWxJZCtxSXBLRWRB?=
 =?utf-8?B?ckU2Y1BEM0NuellwNmZhT2lLRXhjKzFxbnJRYUN0Nml3QmZ1YlBsTHpqWFM4?=
 =?utf-8?B?Q0FrY0xGTkNBZmQ1ZnZreXhrbmNJeUxPQkhLZEFoWmxQbWIvYUpoUkc5eFBO?=
 =?utf-8?B?R0xOdjRJWU9qYVZYcXhhcnFYN2k5dXRLdGRQcmhtT2dyZXBtUHNmSSszU25P?=
 =?utf-8?B?QitkWVlRMjRoZWFjUGdxT0ZiNWpZSEJNakp2S3gwRjlyM2FmYW1uWHhVQ0E3?=
 =?utf-8?B?SGJaVzRrdEt4SVNReWRzMFlRQ1cyOXJEZnVkZStGRERTWXUyK2RlTCsreGlN?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABB5FAA376A3C948B44EC10A9E85F1D3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d97fcfe-8864-4850-c4fe-08da8c6b2baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 22:41:54.8050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MaDy1LShTeV5f8vVeb7+dz8Q26Nh6qhqCuwArlAViTSfrmhvgtu/WZx+UsSeoXR/LCNzbPqWgZFZZkmA7g0TOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1241
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

T24gRnJpLCAyMDIyLTA5LTAyIGF0IDAxOjI3ICswMzAwLCBqYXJra29Aa2VybmVsLm9yZyB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMzEsIDIwMjIgYXQgMDg6NDI6NTlQTSArMDAwMCwgSHVhbmcsIEth
aSB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjItMDgtMzEgYXQgMTE6MzUgLTA3MDAsIERhdmUgSGFu
c2VuIHdyb3RlOg0KPiA+ID4gSmFya2tvLCBLYWkgYW5kIEhhaXRhbywNCj4gPiA+IA0KPiA+ID4g
Q2FuIHlvdSB0aHJlZSBwbGVhc2Ugc3RhcnQgdHJpbW1pbmcgeW91ciByZXBsaWVzPyAgWW91IGRv
bid0IG5lZWQgdG8gYW5kDQo+ID4gPiBzaG91bGQgbm90IHF1b3RlIHRoZSBlbnRpcmV0eSBvZiB5
b3VyIG1lc3NhZ2VzIGV2ZXJ5IHRpbWUgeW91IHJlcGx5Lg0KPiA+ID4gDQo+ID4gPiBPbiA4LzMx
LzIyIDExOjI4LCBqYXJra29Aa2VybmVsLm9yZyB3cm90ZToNCj4gPiA+ID4gPiBXaWxsIGl0IGNh
dXNlIHJhY2luZyBpZiB3ZSBleHBvc2UgZGV2IG5vZGVzIHRvIHVzZXIgc3BhY2UgYmVmb3JlDQo+
ID4gPiA+ID4ga3NneGQgaXMgc3RhcnRlZCBhbmQgc2Vuc2l0aXphdGlvbiBkb25lPw0KPiA+ID4g
PiBJJ2xsIHRvIGV4cGxhaW4gdGhpcy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNvIHRoZSBwb2ludCBp
cyB0byBmaXggdGhlIGlzc3VlIGF0IGhhbmQsIGFuZCBmaXggaXQgbG9jYWxseS4NCj4gPiA+ID4g
DQo+ID4gPiA+IENoYW5naW5nIGluaXRpYWxpemF0aW9uIG9yZGVyIGlzIHNpbXBseSBvdXQgb2Yg
Y29udGV4dC4gSXQncw0KPiA+ID4gPiBub3QgcmVhbGx5IGFuIGFyZ3VtZW50IGZvciBvciBhZ2Fp
bnN0IGNoYW5naW5nIGl0DQo+ID4gPiA+IA0KPiA+ID4gPiBXZSBhcmUgZml4aW5nIHNhbml0aXph
dGlvbiBoZXJlLCBhbmQgb25seSB0aGF0IHdpdGggemVybw0KPiA+ID4gPiBzaWRlLWVmZmVjdHMg
dG8gYW55IG90aGVyIHNlbWFudGljcy4NCj4gPiA+ID4gDQo+ID4gPiA+IEl0J3MgZGljdGF0ZWQg
YnkgdGhlIGRldmVsb3BtZW50IHByb2Nlc3MgWypdIGJ1dCBtb3JlDQo+ID4gPiA+IGltcG9ydGFu
dGx5IGl0J3MgYWxzbyBqdXN0IHBsYWluIGNvbW1vbiBzZW5zZS4NCj4gPiA+IA0KPiA+ID4gS2Fp
LCBJIHRoaW5rIHlvdXIgc3VnZ2VzdGlvbiBpcyByZWFzb25hYmxlLiAgWW91IG1ha2UgYSBnb29k
IHBvaW50IGFib3V0DQo+ID4gPiBub3QgbmVlZGluZyBrc2d4ZCBmb3IgdmVwYy4NCj4gPiA+IA0K
PiA+ID4gKkJ1dCosIEkgdGhpbmsgaXQncyBhIGJpdCB0b28gbXVjaCBmb3IgYSBidWdmaXggdGhh
dCdzIGhlYWRlZCB0bw0KPiA+ID4gLXN0YWJsZS4gIEknbSBjb25jZXJuZWQgdGhhdCBpdCB3aWxs
IGhhdmUgdW5pbnRlbmRlZCBzaWRlIGVmZmVjdHMsDQo+ID4gPiAqZXNwZWNpYWxseSogd2hlbiB0
aGVyZSdzIGEgd29ya2luZywgdGVzdGVkIGFsdGVybmF0aXZlLg0KPiA+IA0KPiA+IEFncmVlZC4g
VGhhbmtzIERhdmUvSmFya2tvLg0KPiANCj4gUGxlYXNlIGRvIGEgcGF0Y2guIEl0J3MgYSB2ZXJ5
IHJlYXNvbmFibGUgc3VnZ2VzdGlvbiB3aGVuDQo+IGNvbnNpZGVyZWQgb3V0IG9mIGNvbnRleHQg
b2YgdGhpcyBidWcuDQo+IA0KPiBJZiB5b3UgZ28gcmVhbGx5IHJpZ2lkIHdpdGggdGhpcywgdGhl
IGNvbXBpbGF0aW9uIHByb2Nlc3MNCj4gc2hvdWxkIG5vdCBjb21waWxlIGluIHNhbml0aXphdGlv
biBwcm9jZXNzIGluIHRoZSBjYXNlIHdoZW4NCj4gb25seSB2ZXBjIGlzIGVuYWJsZWQuIEl0J3Mg
dXNlbGVzcyBmdW5jdGlvbmFsaXR5IGluIHRoYXQNCj4gY2FzZS4NCj4gDQo+IEJSLCBKYXJra28N
Cg0KWWVhaCBJIGFtIHBsYW5uaW5nIHRvIHdvcmsgb3V0IG9uZSB0byBzZWUgaG93IGl0IGdvZXMu
DQoNCi0tIA0KVGhhbmtzLA0KLUthaQ0KDQoNCg==

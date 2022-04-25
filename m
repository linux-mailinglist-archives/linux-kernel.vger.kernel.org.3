Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C9350D9B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 08:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbiDYGrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 02:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDYGq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 02:46:57 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6268833A3A;
        Sun, 24 Apr 2022 23:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650869032; x=1682405032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aVDP4yPJZPudTpvtUoyi7kPCz1nWMifCX7OAS2fEt8o=;
  b=YkICP/Ld3CQ9l/QE87k+w0r/3IND1T/ouhxlIMMiWDZVD7jkgkdUk9kp
   ZzGO6iU/YRLtNnd3Z/8XCXuyqQKTfLNV6k1Mn2lAuQlpy7gdu0I1DRw7f
   QSURxeeLMR9rwlRP2PUk01iWfI3HC3kQOSdU02pNptalc65Zyh7ySrhqW
   rj+0kAhUpGH7063KSfpJTQ4sBsDm9mbxHFpQeEaZMKmZScPe8yGd96zSc
   mUck/R5/r7bIbO27P7UOod7hCJ1Fd07To4zFzAGbXZ7Qku15R8/o3sQ/j
   ha+tbUcWzz3j4aV6MpBD7hKIvC3q9BexQRtQGePPBP0qb2BUznDbPvRsC
   w==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="203597503"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 14:43:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHdQKntv4oRapa/afxOhrDKKyfN1kY4iFoYeOc5a9iYesVqNPFjoLNSIokqzE86jWfNLyw+0lUQNpCRwbJ4U2cvTiDgENHGTsohq4I3MCf/EPJ1sEER0IlvZ2MWvyZr/cC/r3apKdM4jLCN9neNTOuAdrlmOXKh90oNLUJDbR2qT0tYLdx+keNAijmEipf5Zh/bAFABrps55Xrrf/x/V0T77VUYMpdPdMgJJ1X0rBsB9MILjGUvzYNONfuj4qGlPzDfR2I2IhYUriEVfCKsxpn4tuzLuJIAQC2r1OsfRpcliBun4fllfRgziuS36zHEoLlYMVq118EyyapombuAuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVDP4yPJZPudTpvtUoyi7kPCz1nWMifCX7OAS2fEt8o=;
 b=LEa2CpANiN+GoxDq1Lt8vlcJhlaLmvqrvRW8dlIC+uafO3H5nWeffICeF4Pfa/P7MPd8M9Rg/D97f/j8kkH9nwk7ycmAbMbtJq08dxlCgmN8O1eNDfU6XMHlgm6qQVXeHiV7gwya707nGx+CPnRGhGZCf5YHR3UxkJRORuzX+8TOuNKipHbUoP+8irayMlhUo/vKHl2HsWmh6jKoOkLiZ4/8psyluqJ8DtMywIojCIMRqKagJNyvasepNsIrLJeOVOayuzpDrqhlJ68vtV6mgJ9QIwM+iB+GVg3wMn1fEySgETorhQI1ENZ84YJFvoFiDwDEMZzk+hCEJiAPZsBVyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVDP4yPJZPudTpvtUoyi7kPCz1nWMifCX7OAS2fEt8o=;
 b=HuwNU3DdI6Ek3dgBPKeexBotnubUWh7CDqRIQ9u5vlZTWhgJjxCbG796Lvgdr61I1qY1tQN91UbLwbRYcdGajRIfylZkEOceXS/cBlF+tHC3qR9KNLkuDPNEI3Zfb6uRcYfKINa3IdfA3BceUwoPFkI8+Ual/qyk5FZstkHSnbs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6397.namprd04.prod.outlook.com (2603:10b6:208:1ab::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Mon, 25 Apr 2022 06:43:51 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::b049:a979:f614:a5a3%3]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 06:43:50 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <huobean@gmail.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "keosung.park@samsung.com" <keosung.park@samsung.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/6] scsi: ufshpb: Add handing of device reset HPB
 regions Infos in HPB device mode
Thread-Topic: [PATCH v3 5/6] scsi: ufshpb: Add handing of device reset HPB
 regions Infos in HPB device mode
Thread-Index: AQHYWCeyktbVq8mOmUiqJJw3p1lrD60ALTIA
Date:   Mon, 25 Apr 2022 06:43:50 +0000
Message-ID: <DM6PR04MB6575DE756EE25ECA7DF17669FCF89@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220424220713.1253049-1-huobean@gmail.com>
 <20220424220713.1253049-6-huobean@gmail.com>
In-Reply-To: <20220424220713.1253049-6-huobean@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 006a0ad4-41dd-4464-90ba-08da2686f53e
x-ms-traffictypediagnostic: MN2PR04MB6397:EE_
x-microsoft-antispam-prvs: <MN2PR04MB6397559B5A70B6BB7D96251AFCF89@MN2PR04MB6397.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aZxzg7koDAZKWATUFu/Nk7rf1Ofz6E/9sqlfcnxbYyh+Ck1qL2rxT2LlHCziIxegY3+EMzCPE1hd8gHTF5a4rr0MEIyAWWwxOeywazcxz/wyUjj30jxHKSi63jDm0M6cvWAf++vAAcbE5aZXGEuKxDtCWinJGpc164UJJDTqE0OQi1WjcKbmYjgdP4LUFWgV0LMpRMXUtJbXYthjuiKwFs8mbCUQqZm2DBiTadFq3NL6+cSS7IUckPmMCOMBZlN/uMD1DoEeZCJDQrBtkLucBNMA0NJDcng752mVqv9E6ZgleO8qgh7LOOlR3UxHCzzB1euDLTzxExSOLX8s3Qba1p6K9cx/yKFo69QOrJtyz2j+kjN1FmzoTVXuwTUzpR2KwU+wkmRrcg73DPUfnJuGnj/98Sy0nMA68J0C+4dUkxwijAtUcPYvRdVcmB4IjyXCBA+fLosmtExTCyhK1wnXvu/MKYMUOCjKk0IdrlWcSDNv+7r1PbStVN9S+mItojpkWdgG9dihZ5p+r4qNC1Wa7kYy91ED6Kv2qbBFL42vOXGl8CpZleGOu1OeWKG/Z0A0NaISDQlikSNo1VbFYLBBdYLt+RwCURiyKiBYTGcekDmVIvAti8Blz60fCKI1hQmNCXPK7XaIGtVXqnzgHC473BCSfwpOPJITuZvfZAV89OXeagjRsGxZGAIDH5NLAAmiuxPrh06U53vH5g5XBnzDzjiPHPgTHOw1JdbGkYVft6I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(186003)(38100700002)(38070700005)(83380400001)(921005)(508600001)(82960400001)(110136005)(86362001)(52536014)(7416002)(5660300002)(8936002)(2906002)(55016003)(33656002)(6506007)(54906003)(7696005)(26005)(66446008)(64756008)(66476007)(4326008)(8676002)(66556008)(9686003)(76116006)(66946007)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUtpUkhVZEcreVNPandDS3VleE15aU5TRnBEdWIrZGJMMzlrdWh0elNRU2NU?=
 =?utf-8?B?OWUyUldSakc4WFlZM2NsS2ZuRC9pQUJoSmt3bFJNQnhBZllFN0U3NmQ5WCt2?=
 =?utf-8?B?ME1HNkFWcVRlbnZpbnczby9sOFVBOTlkM2thNXR3bGJqb0JHUXRMcTZ6Zktu?=
 =?utf-8?B?b0RDVllyS2ZLZ0JhUUxTYUxkK3JOTFRCQXZjTHlGakd6WFh1clZVclBRUEEv?=
 =?utf-8?B?NmVjSWFLQk5uVDZIK3cybVVoSXVjS015cld3c1FOaHQ3M2h0K2toQmEySTh4?=
 =?utf-8?B?b0ZzTlZubjkxSHN3b0ZxQk5RQm5WZGVoelJxT1c0cjBhUm8yNjN4TElDcG1y?=
 =?utf-8?B?V2V3enZHUGNTSUpHMkFnVUd1TVJLamkrYjNIdVNlSjEzS083MlFGRyt6bTN4?=
 =?utf-8?B?U240bS9CVTZKbEtNZy90bVJxKzZMZVd2UFh5aGdlWm0xUjhiSnp4a2k5by9i?=
 =?utf-8?B?RjMrWUdEMHByYjdhWWg2RTd5WjRQRkgzZ3oyV2dweXhVUlN1QU5Rd0IxZy9Y?=
 =?utf-8?B?MFFPTW41V1pXRXBaZ3liOXNUUklSU1RKT2VuU3Z1UTVrcnREQzZmNERQRG1z?=
 =?utf-8?B?MzhENHZ1dVk1QVRsMlhIVzFVMEJXaElGQUdUekczaVc2YWUxOS84ZEtEUjdX?=
 =?utf-8?B?WjR0N2I4R3BrUkRhQ3ZvdGg5a3BhWldOdEVyWDNXMGJ3SUV0MmEyeUkvNmF1?=
 =?utf-8?B?SktMZWJIOHdhdG1IdFlXb0F3NlNEenpwNE9VeTB2MGp4NmxhMk0raTRMUVZZ?=
 =?utf-8?B?dzd3aWdCbFR1UXEzd094N2RYUzZkQzhTY3VwRnllOXVZMUo1NE9tRmZ0S2ps?=
 =?utf-8?B?d1ljTEQzOW9hdEtOdDVwKzYxbjBvbkNiVnJIdFZiSWYvVjk1Ukp5dE9hZzlq?=
 =?utf-8?B?RXV3QVNpTHJtK3B2UDBkWThic0J0SlQzOEFZemtxdllQTjBoZmw3OGUyT1ZQ?=
 =?utf-8?B?R0NhQlNpSytvY1dxTFc0M1paaFppNzNFNFBIcXAwcXhENmRaaWdxY04zSS9P?=
 =?utf-8?B?eWRtZ09nRDZHUks2SjJ1SFVPZFRHcFE5YUR2aFVrVlBvVDZCa201dlF0S3Br?=
 =?utf-8?B?NUlZRU9ZY0lBNnVsT0M3SWIxeVdSejFiUmpGOEVhcnVkc1VDeEorTEloVWRR?=
 =?utf-8?B?ZEhHNmczUWovOXhNdGwxOUpUcjFMZXBybjFWTHl3OHN1b0pBY1I3aldtODJn?=
 =?utf-8?B?QkhpZkhNQ3FvYmphTkpEc3ZsaUVpaUV0MS8wT21xTE1IMmFYbFpzcnVJTzUy?=
 =?utf-8?B?d1FrYW1sZjBsUXByWS93ZHJaWWtwSk9FeVVWUHBTcmlWUHVtK3kzUkQ5V0Vn?=
 =?utf-8?B?VGhJMDZ3WDhGZndTU0N1TUtsSmlLMnlMYWFkejhiRE0yUi9lOTdtLzkvUER4?=
 =?utf-8?B?OVpYdzRiMmFyTlMwdUZQSm0xUXFJVVp0OXZMeU5ncVU4cGpVSlVJUC9HQk45?=
 =?utf-8?B?SWNxQ2E0STBreUlIcWlYWVdSSFp1NkR2RzFCaVJINGcyVCt2aTdSMkNiUkRN?=
 =?utf-8?B?V2ZuWVBXZXNrcXdsMVQyMkNBN3MrWHdZRjhxSnVCQ3E0YnJnNU0yeEEvVFQ3?=
 =?utf-8?B?OUFDUzZlTDRHem1pb3VZS3gzQUNsTFd2dmJTNkdEeUMyWVRKa2xhOFVzNFZi?=
 =?utf-8?B?YndwQVZ2TjFOUXNhejdmMUR2UDBGUjFQcVc2VmN3RURzSjRnM1UxRWxROVY4?=
 =?utf-8?B?L1J4bGFkdjdDZHpqMmFOdHpnQ2xBbTA0NGVnMTdiNHpDd05MYXRYMFBENWor?=
 =?utf-8?B?VG13VG9mWW1ZZlJXaVdnbFRMVGVkWmtXUW5DcEc2bk5aQU1sT0pkK08rYXA1?=
 =?utf-8?B?UEdmSzBRVmF6c3BMZVJtY01WMnBzS24wL0gvMFdLNGlLbUswR3dEd21weGE3?=
 =?utf-8?B?M3h0TENWdU9udjhmM21keTBOT0d5QU5Oa05jRnlUYkR1L2JZVmw5VkZTRlZr?=
 =?utf-8?B?UjZmZWNqZ0RBUC9pOEdJMnh6bjk2SDBreHVIcFIvMVd0TEZaOVVXazNlUUgr?=
 =?utf-8?B?M05TODBmRXN3RUQ4K0ZtZTZXSXQ5bCtuSUd0RXFycFM5cDY5aHR4dStKdXor?=
 =?utf-8?B?alVKaWZCRklxWm80MmNtQjFWZTh5dldaSlcxY2VST25tdW1QRDFzK0tUakl3?=
 =?utf-8?B?b3o4b0xpNE1TV3UrMDl4aFdkZnphQlFpUXJFZzRlaGgvVEZOMkdLNmI1V1VP?=
 =?utf-8?B?T3l0Z1NPbTlGb2JTam9tYlV1VjJka3E4TlhhNzkrZjV1aXljMGVPVyt3dHMr?=
 =?utf-8?B?K2VSVnM5S29pUm1qRkxBc1dmaUxxOTRzRWJkQ2ZDRFdEYURYY2JIWWgzUnMy?=
 =?utf-8?B?M0ZvZktMTEVPb0dsdFEyQ3dvN1pMZ2dMa1FpQVRQREN0bGJ0UG1IUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006a0ad4-41dd-4464-90ba-08da2686f53e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2022 06:43:50.8181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JbAYd43N792ygOnoip5oC8ppr8MsD6mKPwATzKKTicwMvJ9/8u69NbRbkWowILfpWZptCBggzp0uKFNk+q7/pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6397
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCZWFuIEh1byA8YmVhbmh1b0BtaWNyb24uY29tPg0KPiANCj4gSW4gVUZTIEhQQiBT
cGVjIEpFU0QyMjAtM0EsDQo+IA0KPiAiNS44LiBBY3RpdmUgYW5kIGluYWN0aXZlIGluZm9ybWF0
aW9uIHVwb24gcG93ZXIgY3ljbGUNCj4gLi4uDQo+IFdoZW4gdGhlIGRldmljZSBpcyBwb3dlcmVk
IG9mZiBieSB0aGUgaG9zdCwgdGhlIGRldmljZSBtYXkgcmVzdG9yZSBMMlAgbWFwDQo+IGRhdGEN
Cj4gdXBvbiBwb3dlciB1cCBvciBidWlsZCBmcm9tIHRoZSBob3N04oCZcyBIUEIgUkVBRCBjb21t
YW5kLiBJbiBjYXNlIGRldmljZQ0KPiBwb3dlcmVkDQo+IHVwIGFuZCBsb3N0IEhQQiBpbmZvcm1h
dGlvbiwgZGV2aWNlIGNhbiBzaWduYWwgdG8gdGhlIGhvc3QgdGhyb3VnaCBIUEIgU2Vuc2UNCj4g
ZGF0YSwNCj4gYnkgc2V0dGluZyBIUEIgT3BlcmF0aW9uIGFzIOKAmDLigJkgd2hpY2ggd2lsbCBp
bmZvcm0gdGhlIGhvc3QgdGhhdCBkZXZpY2UgcmVzZXQNCj4gSFBCDQo+IGluZm9ybWF0aW9uLiIN
Cj4gDQo+IFRoZXJlZm9yZSwgZm9yIEhQQiBkZXZpY2UgY29udHJvbCBtb2RlLCBpZiB0aGUgVUZT
IGRldmljZSBpcyByZXNldCB2aWEgdGhlDQo+IFJTVF9ODQo+IHBpbiwgdGhlIGFjdGl2ZSByZWdp
b24gaW5mb3JtYXRpb24gaW4gdGhlIGRldmljZSB3aWxsIGJlIHJlc2V0LiBJZiB0aGUgaG9zdCBz
aWRlDQo+IHJlY2VpdmVzIHRoaXMgbm90aWZpY2F0aW9uIGZyb20gdGhlIGRldmljZSBzaWRlLCBp
dCBpcyByZWNvbW1lbmRlZCB0byBpbmFjdGl2YXRlDQo+IGFsbCBhY3RpdmUgcmVnaW9ucyBpbiB0
aGUgaG9zdCdzIEhQQiBjYWNoZS4NCldoaWxlIGl0IG1ha2VzIHNlbnNlIHRvIG1lLCB0aGlzIGlu
dGVycHJldGF0aW9uIG9mIHRoZSBzcGVjIHRha2VzIGV4dHJlbWUgYWN0aW9uLA0KQ29tcGFyZWQg
dG8gd2hhdCBpdCBpcyB0b2RheSwgYW5kIHlvdSBwcm9iYWJseSBuZWVkIHRvIGdldCBhbiBhY2sg
ZnJvbSBEYWVqdW4uIA0KDQpJZiB3ZSBhcmUgZW50ZXJpbmcgYSB6b25lIGluIHdoaWNoIGVhY2gg
dmVuZG9yIGlzIGFwcGx5aW5nIGEgZGlmZmVyZW50IGxvZ2ljIC0gDQpJIHRoaW5rIHlvdSBuZWVk
IHRvIGZhY2lsaXRhdGUgdGhhdCAtIG1heWJlIGluIGEgZGlmZmVyZW50IHBhdGNoIHNldC4NCg0K
VGhhbmtzLA0KQXZyaQ0K

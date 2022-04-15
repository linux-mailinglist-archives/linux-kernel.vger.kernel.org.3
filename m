Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806C450212F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 06:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349365AbiDOEPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 00:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349350AbiDOEPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:15:12 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C743386;
        Thu, 14 Apr 2022 21:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649995963; x=1681531963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G7atpaMoNEfq7jGY/OPvClgHqCKsSFVTgtRPK1n6ARo=;
  b=ZPe6oSq0wDzoyyVQJnO1jNq7nF/660TzQvahNrK30V34V66Oxamuxhdn
   vtCOGcmO6Qn7PNXqneYD2TYb/JeouXZsuX8Cau6U3cus627EYEku7UPMk
   T+czkuTdgcBUs5KWZaSVlisUpYlDWJFr+8jJEbDgyNcmaXNPy5dxVy6ba
   ERKHDNY317AHuREujqmGLnw2s5SNEAa5K9r+36JDWUtgdILtG3smvDKdA
   9AMghFVIp5uVKmoTWQf26u0/bv+0JNp9fBCU+vAfDqfPOnsWCkugfTbcg
   jRP2RKsIO6PvqRUvpwPrRs3hkSLUDYrNEx8a7WOxtlEUoGAwy9dXrrUtL
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,261,1643644800"; 
   d="scan'208";a="197967484"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2022 12:12:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XF0Gf+Tlajt2ve2SK+6lyOinhO0QiITt2zzuYZQ7dFk2NS5tDbFAzoxQG93C1LlfpIfHceal8UdZQhK0wwIm7GNavV4inF0YvVNyyj9gS33hK2/pV5Bvn89R2G4KPmCkGUr//0IfYFVDIpgRs7EqdFVj4b6tIUIbzR2sduzpWa8Sd7RVwS/zHvFQ2oSHlIxeZIIcntlZ4MBkJnYNr9bOuD3q4KfVa8Qm6M6GQ6xtaKJXRs2as5Fel3mGELZzyPZous6rlnaWNyzms9bEJ4ZpOWcZR6+dTpdojG/MGdGfcMRvXm9NcSu0lOCxowgZalOEMg12eg85qcFWMa2DRf6wXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7atpaMoNEfq7jGY/OPvClgHqCKsSFVTgtRPK1n6ARo=;
 b=H70OzFknihY7ZBjztRCruAI/hdzmChyWh97ceJNqgG+YWAt4Lov6Bln/lRsZkWLl28fo/h6HFecNKDSByld3O4QKm2ovmnDUy3mlVOjmnN6CoH65+HOD3ha1e1Lsn7kgBHsZdMoT6n3ighyH4BoF6na1ESwDzjed7FXG+ClMLxizGACeysLxppE9n4pFUQyzVCGavG3iJj04mlY/BlKzYtz34gLZO05Yu5SybPh6ia1/oVIrDB3XF/QZyZUKh4kY6iEw7cD9yX0IH7mRJg7RPHHrGIotM2OmuDSxPshVcAf1GDbqPYfWUiKh+V7cghtA+CA7SsBDBHOfc6oRGdmIrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7atpaMoNEfq7jGY/OPvClgHqCKsSFVTgtRPK1n6ARo=;
 b=RLAGF4Psf4NYxKJoizfOorirOBcGJdr1IvSPge3MlTR/yI1PA5IKPOlZD898LiLBb1reRJR7HckV/0qVgz+WXo/i1yYxp9Zg//gWvVkIGliWbxiGD63kqZYrtMEs/TaUAmPIDK9ikBDJ1Dpe0hUuBCfCeHPlxOrompDbvBAKWB8=
Received: from BL0PR04MB6564.namprd04.prod.outlook.com (2603:10b6:208:17d::11)
 by BN6PR04MB1061.namprd04.prod.outlook.com (2603:10b6:405:46::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 04:12:40 +0000
Received: from BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::eda4:f764:fae0:b89e]) by BL0PR04MB6564.namprd04.prod.outlook.com
 ([fe80::eda4:f764:fae0:b89e%3]) with mapi id 15.20.5164.018; Fri, 15 Apr 2022
 04:12:40 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bean Huo <huobean@gmail.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 0/4] several UFSHPB changes
Thread-Topic: [PATCH v1 0/4] several UFSHPB changes
Thread-Index: AQHYUEs5uATTVlFhl0mC8MLRykr5SqzwXUcw
Date:   Fri, 15 Apr 2022 04:12:40 +0000
Message-ID: <BL0PR04MB6564084277248525A4FAA74BFCEE9@BL0PR04MB6564.namprd04.prod.outlook.com>
References: <20220414220127.587917-1-huobean@gmail.com>
In-Reply-To: <20220414220127.587917-1-huobean@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9fbcb22-6504-459f-f807-08da1e962ee0
x-ms-traffictypediagnostic: BN6PR04MB1061:EE_
x-microsoft-antispam-prvs: <BN6PR04MB1061A8631F11B3E9AAE486CCFCEE9@BN6PR04MB1061.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dCovVGNgMVgxY3PotB/2k/rXrbXRsbsYRj50Y0uREmViBG6Bj+cbmeuWXBDr8w4Zd+gT8Ws+hBD6ElUXjjX3F0d2UfK8cbLB//KWVuIZJ3p9bjt+pWtL/D8X1JBAmr6RIJh7s3q/k2XYaZyk8SoquMaEk/c/VSMRHIV2BW2u6FyzBApJd63f8O0qLUEPT5QbxU7fWl2hgX1s9HMX/KoW6Yu6rnHbGRWlv++U/ta2fWLwwEuJW8UNV3Cwf22RIM74nQxW8mjb2CORjc7gyf/ILexfpCvkwemzm9fuqosPQZLKj3jtz5EZT07uiIbCTLV2qw6jS3p9pA60e+vzG16UDfpIhc20Y7Q3DF+cE0y1BITtxCzOPLsA6/QG8x20iglzNhIuOeTUt5v4tN1L71lOOQxmBhqjNWinVrrgscTC2BYwznmH6ruM4im45IrFLwNNnBwnW1wcs2Uja+WeSu+nvJmo0YYL/tQNx27TyjmDcP5Hs/8AMPaw/mvFyp7u+aqxEkUAI982QT85O3aBYyYN6mYNXtgW0gAqPqtrn6KizMdy3StMMbWVa2XJGPPi9GGe220GKG6nRzTVgzdnch+BMrZMHHNoVVbDFMlbxe/Y8CM7WNOIorHTQkhyAJJ9wNOqTAVR8H3EV/hWTyhbXvd87ljNlhE6eA7zpGjxk/Efi9vc/GPL28vENuPoTTmSPKsKdmZapyy0tuqwVpm1yli7HsZ25NNIPr7SYHA2VbBt9nI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6564.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(55016003)(921005)(71200400001)(38070700005)(54906003)(82960400001)(186003)(316002)(8936002)(26005)(558084003)(8676002)(38100700002)(9686003)(52536014)(5660300002)(508600001)(6506007)(86362001)(7696005)(33656002)(64756008)(66476007)(66446008)(66946007)(66556008)(122000001)(2906002)(4326008)(76116006)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0VJOGU5eEdjL2o3SGM4aCtLa2lOaXJwYVA1eU9XUHB5QkFuYjNndWYwR1c0?=
 =?utf-8?B?cXNxRlFicm1SWEIwYXhEUTI3TEQvV3EyWm13Q2Ewc3NJNjRzZnd1VUhvb01r?=
 =?utf-8?B?djdId0IxTHk1Y0RtY1diZWY1bjZBU29ZUmVHSGoxL2FvSmd3OW50dG85NlBF?=
 =?utf-8?B?THBBQy9VMm1wcjgwR2hKSC9XTFFHc000Q2hmTm5GYWdqZWlXdlNaUThSZWhl?=
 =?utf-8?B?NTVjV1dWNlB1dVQ0d1YyNExuMlV4RkNNb3ZjTEFiN05FemEycFpYNUhGeUVo?=
 =?utf-8?B?VmMyaExwWnpRTWQxU2RLQXpWNHJ5ekI2SGR6NHBWa3ZJS1VwaXd2RUMyQzF0?=
 =?utf-8?B?ZVRwUGRJUkVZd0toUW9KODdnSHlvT0tnOEtzVTNuYStwSzRvRE9FVmJQeEtN?=
 =?utf-8?B?K1ZpNGlRU20raVdJWjJqQ0NvNVc5U29nNlp3SWlZZUZzTW9rRVhoaEJhRXBN?=
 =?utf-8?B?RFJEcjBMMU5YalJ6ZklPWmdMdkRkMFhEdVZPWS82WW8vZEtNdU9mQThTemJ4?=
 =?utf-8?B?Tjl1dnBWOG5nQ3NtN3NlNzBUdXltTWhxVllVNktob3d2alFKWlhRNnZXVGpw?=
 =?utf-8?B?M05IY3VNL3R0b21la2NsaGVJcWhJaXgyakpiRTR4WWh0a3c5L2U4b2tRaGxS?=
 =?utf-8?B?eDhDUTRCT3lqUHBCQjc5LzFsZm4zdjJHRDhibHJFc2padnNDQTlua0F3UUFu?=
 =?utf-8?B?U2p6SU5DTk5PZDJmT2FVck8xZERZUERBNXU4VFl3RmI3OHYrWEZPMTJNQVhs?=
 =?utf-8?B?NGxHUWh0Q1c0bVJNTTNiSjBLeU5LeEo3M3lwak8xc1RDRXpOWktKMG5tTmRn?=
 =?utf-8?B?YTlLdjl6RnBxYTJQbVYzWE5IM2x5VllNSnRDVjk0OGRDN3h1VW5sMUtMSE0w?=
 =?utf-8?B?Q1pRV3NRYjFqcUtwQkx2d1BDNzBGNU1neVdjVnhMVTJESXNUNFJCZkRodDl5?=
 =?utf-8?B?VFNPK0F5WlRLZ2llMDJyL1dXbHBlc1laREdzMlhYNXZ0dmV4RStwRE9ET21i?=
 =?utf-8?B?UldLcE5XQlVtbXk3NXZMV0FhZkdGOElmajZKbkZibEhpMUUyTWxzSWFVMFh5?=
 =?utf-8?B?SHdWY1MvU3pCU1lvR1NpM2pFRFNrWWJIc0FHbFQxQk1GTHowQVRoQU9ZS3Zp?=
 =?utf-8?B?STdla2xkVmtwVHN2c1M1ejdHUTF0U0ZKdkphdlVXelFSOEpDaFAzL2I1d0Z5?=
 =?utf-8?B?dVIyVTNJcXUxd1dGdU9OdHFRRUZHejAwcEh4NW45c2NKdkhXZEhCSHBsMUs2?=
 =?utf-8?B?UGJ5Sll2TEFIcHpRREE3K3BLTUdXU3BzTWU2NFVESWR3Vktkd1JMZzZGdHhS?=
 =?utf-8?B?cHppdDhmajF1ekR6dHg4TkdhK3FLV3pLREczMFlvYlp2c1JOQW80bkxxKzJl?=
 =?utf-8?B?OUNwK0ZtNEhPeXVqcHhEZ1M1WGlHRHg0d0l6cUFoUkRPNVZVaTlOdjBHUnB4?=
 =?utf-8?B?YjVIZHZnZ253QU9XWE1Zd0JpYTdSSW1jN1NONkJTelh5dS8zODkyUXpPVGZV?=
 =?utf-8?B?eURPRmZqR2dBTmd5NzVld0xpUWNvWUxKOEl2WVpzSS9vamVNbllQaFZQVjRC?=
 =?utf-8?B?NVgzK2pMZ0dXaHkwR1EybTZqSlpyRGFsVCtTU0RzZHpsMUN2ZUQrdGVuYkZQ?=
 =?utf-8?B?YXlkY0h6c1B4R0xuNVV5Z3Zodm51S2VRcnphakVvemE0cDRmeXJac2MzQllQ?=
 =?utf-8?B?UVBrQUFBUHBRc0NvYkwyVWRmbEtVeE5WUjhkcFE1eCtUck5Kd1gwQklWSWdE?=
 =?utf-8?B?ODY3anh1bnNKZEJMZmg2ZmI3dTBZcGFwQkhyS2hYVnR1S2E1ZlltQkFQRWJW?=
 =?utf-8?B?T0t1cVovM2FaQ2dMZkRqZmM1RGtpcWFmQmtmc0NUUGJkTi8yTXFub2pmRUx4?=
 =?utf-8?B?cGxKS0swS0RnTmdmUG52dTFJclNhQUJTZWlTZTNlR3ZEb0czT3ZLYU83RVdk?=
 =?utf-8?B?bWpxRHByQXRQRGNuekp1MExLUXVKSnJjL2hXM2VQc2pBSzdGQ3lpVkpKQnlM?=
 =?utf-8?B?Q1lwOUUrbDJhWmxMYTJud3dkQWJ4K3RjR2JYdkM2REg2OC9CV21EOU1tMUtO?=
 =?utf-8?B?eXNIem9jd2Z5SEdrSHhDQmU5OVJzSkZHK2d2b2doY1VTVUYvMW9UeHVqbFFZ?=
 =?utf-8?B?YU5PaWgrQ2JNYmNNUXRFYzFhV0FGL3oyc0dDWlpDUFhjL2lkU0xPRzhJZTl2?=
 =?utf-8?B?cjh2bzJKVDNkd1pyZDhSV2E0eC9FcUY1cWEzZklQeGNnVTBOcFdtYUtVbUJD?=
 =?utf-8?B?V0NiWEg4ZmRXMytVNWZkMFB5VEU4Sm5rbjN0NmhKOTdqZFlHTER6VE9HTUt0?=
 =?utf-8?B?SGF2VjBteXhaaStYN2pXY2NQa0NVeCtHNlYrVWZzNWx6Vlh4N0MzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6564.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fbcb22-6504-459f-f807-08da1e962ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 04:12:40.5363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsYRcg7WZXas5tbfRYRAg+7VNJ/rL9XjnU9IGFvfrAUwziCj1hT9hrIxGLDWo+oQCPAgFgvATOunZdfk6qDzbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1061
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gRnJvbTogQmVhbiBIdW8gPGJlYW5odW9AbWljcm9uLmNvbT4NCj4gDQo+ICoqKiBCTFVS
QiBIRVJFICoqKg0KRm9yZ290IHRvIHBhc3RlIHlvdXIgY292ZXIgbGV0dGVyLg0KDQpUaGFua3Ms
DQpBdnJpDQo=

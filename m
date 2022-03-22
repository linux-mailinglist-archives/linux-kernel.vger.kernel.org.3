Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E254E4944
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbiCVWny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiCVWnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:43:52 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A040C5BD0B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:42:23 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22MMcUVA027563;
        Tue, 22 Mar 2022 22:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=QlMFEJ0Z/zC9FuebklJB2qHGuL/XY2HXVrM24rgXBiM=;
 b=CLFESAeF288lwnujA7HPF76VIXmO0AOZEkGQZK0bmvDWmbtiuBB/IqUtUkG9DbVRrfcA
 ZTvX51aMTLT25+/HcF8vG62jT/5vPjtv8RPYgcjSSOHttl+0AVWOvqtWv1txroB2vRO1
 r6RaWKUO8qyMF6s+mNDH3dL1CzN2CptLBd3BqsnfhxIyjHmzzISugQ9UktVJVXu1hv3S
 VhSxxf0hi2JyxTD6x328inIbPvY535iqi53IB4HuO9SqwK1+1jTVDikBEDWkR2RXvK2C
 xDpfM0ebGF3LKu7ORiGibjb/HGDF/kBB9QviWysQQmfOoOXTNwpCAxzeS07bsrV6qpll 9Q== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3eymc1s86y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 22:42:03 +0000
Received: from G1W8108.americas.hpqcorp.net (g1w8108.austin.hp.com [16.193.72.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id E9DB3CA;
        Tue, 22 Mar 2022 22:42:00 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 G1W8108.americas.hpqcorp.net (16.193.72.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Tue, 22 Mar 2022 22:41:51 +0000
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Mar 2022 10:41:50 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Tue, 22 Mar 2022 10:41:50 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 22 Mar 2022 10:41:49 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTGpRoqzl9sA824MfItN4Qne7fYbnb04kOdgrZcWwyloY3DXG4zXQ4Lq23siaHjAV/hdDVUwEFgI2CH1T3RvUOWBmtlhPWiyk3bCplhiVNupxrogG4oW9gF07rbznzvpvmdxEVEpuFz7vZO8KR1ghlNui/USZfidQJbQMQwEP9ZSJtAcWKbk90ME15s/JP3DSOphFpeMXWEtA433iW4gmHO6vrQuW1ZhzBq9pRi21n6QqCDPmsXAqOWWfnfDLLvxli32BlO3Yq2Xptqw9EQUilyDixk+lx12dKNPBNdbsGrSJRAzBbn3dJ4cRawA+BB0xSIwlUep9K27NA7ywT//cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlMFEJ0Z/zC9FuebklJB2qHGuL/XY2HXVrM24rgXBiM=;
 b=mdJv2MfmgQpvY8WXYXfQqg24JudoJsuQ8mfoh1K7EmqnygJ61oV+kA0Pr/QXDKiR6QIVsMkBJDBQ7V37e9FgV2yn+LvnbIb8WplIz/Ru5yi5bybhumbOZ3Z1NIzk4crGfngCJGsjzV7VUjVPuObf57uj2gdNi7jLRWUNfqiJV3ztaJDcr0vfXRZeuBE4+N39t1oapFRUcptISCJq1BcPlqPiYPyypwdBpLYC3dLZ6FizJbaV95rlJbycELdKI17TVrizolqBycjAgi0hMTZC06eNexusItvCNh8iDVwUm/tpT4T+jrEYMWKEdf1JJZVqIMdJ5c8uNk+3Zi27rvuLsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 MW4PR84MB1513.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Tue, 22 Mar
 2022 22:41:48 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f9a2:fe09:a133:e21e]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f9a2:fe09:a133:e21e%7]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 22:41:48 +0000
From:   "Verdun, Jean-Marie" <verdun@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v1] arch: arm: configs: gxp_defconfig
Thread-Topic: [PATCH] [v1] arch: arm: configs: gxp_defconfig
Thread-Index: AQHYI2Pt+fLVSCbpEEG4Jh+m/2IR7ayWuYMAgCh1fQCAAQhWAIAB2wCAgACaZYCACRMtgA==
Date:   Tue, 22 Mar 2022 22:41:48 +0000
Message-ID: <4CD3E272-3C69-441E-B4DE-7004701614EB@hpe.com>
References: <nick.hawkins@hpe.com>
 <20220216183704.42084-1-nick.hawkins@hpe.com>
 <CAK8P3a2Ryjr738XgLsGQngvc7j=Kk620LMjWpu-_HiwdK_fX4Q@mail.gmail.com>
 <9FE3F625-39FC-4ED7-A2CC-567EF0181886@hpe.com>
 <CAK8P3a3sR98Ujk5AFA=F7aTWWEx93-Jjan1yXqaqaw-6x85NwQ@mail.gmail.com>
 <483082A1-A464-4D3D-B994-66B09E5D54B5@hpe.com>
 <CAK8P3a2n=yVfe+QiBvxAXw=5DmVY+Mjaag2s2fq+F=sQngos-Q@mail.gmail.com>
In-Reply-To: <CAK8P3a2n=yVfe+QiBvxAXw=5DmVY+Mjaag2s2fq+F=sQngos-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 372aa893-e6e1-4987-0d44-08da0c552682
x-ms-traffictypediagnostic: MW4PR84MB1513:EE_
x-microsoft-antispam-prvs: <MW4PR84MB151310F64A5D04C3FBD9DCB5D6179@MW4PR84MB1513.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHL/bfYg8r/9V+ngr+YtKVLS2WMr97n+A5ZSrs5jFIuQ1/szEtnxZlDY5m9MQXZuZAnpjRhXpaAhB/tkTvNYXGpbMxUVsqEizPfKaMahGwj+9cPoEijM+RT42YJ3a4DZQb11mu0PWdTP1h1jefjAgEQYM8peRm3jlgRXl3mDfKnkGTyq7jqy3j+uQ1IPqN6HgnJ5VcFNHJvl3L9E6VTc7WzY/hzKHsSJ3r0+vLWJ5BJSygMeVeiRQY/eE3cDjpDvc1vb/sit+b8U/St/7abYl0V5PKYsrChWKqY2BPGPii5rf8SNhKq9mnXMKGVuHTohT4u9TEZfuKlg6AZ8WCk/nsLZ8wHlx5FI5EBhX08Jtu5GcJdeHtcJlyoB/Vi7+4ImRrUAWU9Pa32kxBn6Pf8HsOb2b/hKbrthxLf45q7sJqfmvdrKadcpsiLQLekwPURIXJHDRmtXatF5hjHTf5XIZLFAkCTdcltczdeo/Ejq0D9cKMOA7MprQPs+mIq6eQ+w4FMfC0y8GsuFAgdJdLbEWFoDG4IeaKXUacAAMaNDQxY2D8fsaLSnnaFosoX9GbVnOQabiQX++PLIJqUCfMZHJMVvGs4YAOeXTLWHmjXUjnuhmz63NMhUFtl3dXwcaUYFUPgrjHDkqd48RhBkb++nOl8DhWaB/AB33W8XUAlrBc7nqRC9ozQG+6gfwalRIXMdDFvLMgKXvWikmj5EFpXOphmsJqokCIy7v7mLjWgRprf6gM00C3TdFuN5TewSDCTlXZHiEpBMSETdWWPqXR97hmDvpbcjaxLRGa26cXMZSjvoxXd2K5a2Wll9rO/efo6pxw6PdrhadjpLdK7yDcr4ZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(86362001)(966005)(66946007)(71200400001)(66556008)(64756008)(66446008)(66476007)(76116006)(91956017)(2616005)(33656002)(186003)(8676002)(508600001)(6506007)(6512007)(83380400001)(4326008)(2906002)(82960400001)(5660300002)(122000001)(38100700002)(38070700005)(36756003)(8936002)(6916009)(54906003)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEhvVFUwaXArbEFrKy9HbDZlQUd2MmRxNDg5RFBscTVaNklTaENTZlk2djBD?=
 =?utf-8?B?NyszekxiOTVTVjFtZUdLdVBZMnEyZjlBUHRuWXl2WVVDdWdSLytUU0dmYWlR?=
 =?utf-8?B?dFVNbktxL2g2TWhOZS9jSnVGbHphUldqaEE4TGppbFZJRlQ4Z1puRlNyTU00?=
 =?utf-8?B?MENESnpvaDBDem15dmJ3T3AxZnNkNDBId1BFdDh0NmxMOEpHTXNJWkFVUm9G?=
 =?utf-8?B?RndsWC91M2FheVJFMi9UdlNpTks3aUlUNTJNN2FyVm8yVlR2cHl6SkxuVUVx?=
 =?utf-8?B?ZVlZS2IreGlEYVdiYUFrUkJJU2RkdTIzKzk0Y0w3b21kWkRERkJpTVp5RFpn?=
 =?utf-8?B?SnJLekIwNUV1SENQamlkUjFZcmQwYWZLRlVmeEp3Ti9odytFdmhjK3AvYnlG?=
 =?utf-8?B?dzQ0K3BaR2RHRUkvQkYwbzdaSnNLRVhFWUJwTE9vdTJJVm9JMlZBUHU1eDBz?=
 =?utf-8?B?Y093TURnOFZ6OTZvQit0NGVweDJDRVRwVnlOZCtWT1VJMHhQYkVwSVN3aG1m?=
 =?utf-8?B?OXdqRjZNcVRXS1FVQUhXNFE0RlY3Vk4rV1VJNlQwWVk1WHVGK1VoTWVIampG?=
 =?utf-8?B?bzBpelpkTnFXS3M2dUdmSCtGWTRaOHU4VHhZN2hsRWJtODFCbjRVRFI2Ri9p?=
 =?utf-8?B?czBDdnFJZGJZT0FoTXVzcFk1NTNpWjJBWG4yYk1RWVJQRTIrRnFUcm5aTmw0?=
 =?utf-8?B?QTRPRU83Z0kxU2RmeHZjcjlHSXpMbWJ3cHQwQXpaRmErZkFSUlJyZ0tzWDdz?=
 =?utf-8?B?MmFLTFJnNnd1L1UwVHZzUy9IL2FqZE1wZ2tUT3pONEovUDNKZXdLa2FHcWd4?=
 =?utf-8?B?UFM1cDVwTkVsRnBVd3RvWnlZSjdBQy9LTDJrc1pTQUsrNmZOODVheVVzbDQv?=
 =?utf-8?B?NThNaERjQTdFRXZVWWw3NnZQckY2b2tNNTk3L2ZiV0ZvcXlndHNja05IREdk?=
 =?utf-8?B?NENRWEl3OUFpR1NvMEZVODFjSEIvcUNyOStYRkpETFdZdSswUFg1aHBBZnpj?=
 =?utf-8?B?K1lIcnlGWDhGdGR1Q0V4R1A2czlOZHZxNHhMdEp5UVpaTzdITFhiUzFGVjNU?=
 =?utf-8?B?V3BVL3BOTURmUWF1NVFuNzlVbmlncWJYUG9Sd3kxcE05ck9JWXVkelpoeTh4?=
 =?utf-8?B?UnFRcTJKa2MxZUhCRStTTnIwb3BySWJkMnBzRXMyNlNSc1VZamp4UldYQTNF?=
 =?utf-8?B?dkQ5T20yTUFLcG5aRFBaSEVIUDJSYmJVbmhaTnpkdU5wWFVaNnFQOHY4TkNM?=
 =?utf-8?B?cnUvbFdxSTNGbHBZcGNzNWovZWI2Y2ZvS09ja1ZOWEs1aUpIOU8vc2Yra2dL?=
 =?utf-8?B?ZzhycExuYkhROHlwUmFwMEZKQVNiOFJkZDY3OVI2QitNb2tUbnV2WHBOaEtp?=
 =?utf-8?B?WEZNVFhubEYyV1hxaTVhNjA2WDVkODJmaDJCdnVxdlk2VzNUSjJpbDR3ODNL?=
 =?utf-8?B?dUlSRXl6emRjZXlrdzZPOFlNOW4yRDJkbHBzaXY1aE9BTHFmWVg0ek5RRjBD?=
 =?utf-8?B?a0NTTCsvWWVsT2t6ZU9WUEJzZHd2SnJsbGYwa1BHTVNNMmJnM3lwNEtsQlg5?=
 =?utf-8?B?ZzFhVjRScGV4RWlIaXBDSUY0RGV0Q3c1bVNlSG45TkE3TVh6b0Vnalo5R2Ni?=
 =?utf-8?B?bnFCWjdBV2VNMVVXRlIwRmlKMlAwQ0c0Q0phVDBVRGs0czRyMUVORUljMldW?=
 =?utf-8?B?bHphd21FejJwTjFZdWsyMFluNERlb09mU0o0bVFCUGVVTHIrMmRiMWxjZndi?=
 =?utf-8?B?dkpQdmlsNDVQcTN6N00rVE5DTlAvUXRxRUhWV2JwdEFnM3NkQkFRQ2ExeG81?=
 =?utf-8?B?emdrS1puNG1UNXI5S0RBZ1djM1NVUVlITFVHYjZmSmpHRFlOaTc4VHRzNkl0?=
 =?utf-8?B?OXN1emViaVRkbk56MUVPT0hTMkxCZjFpRTFjYmJVTzJFUzZCaDdBeEV2WnNV?=
 =?utf-8?B?YllBRlpKTFdqRzIxZFcwYjF1TFZuVzhnekI2KzVmUUp6M2JlVGs5bTFKU2dz?=
 =?utf-8?B?TmJpaU5oL0NGUlBpUUREUGdUaXExL29QTktLcEdRaUJ2NzlkazM1eGR1SDdp?=
 =?utf-8?Q?B6EJZl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD7670C710BC6B45A53CDF202ED985F2@NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 372aa893-e6e1-4987-0d44-08da0c552682
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 22:41:48.3689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRJnRrLMWDd8il6hLbH1pCBBV4fe5ur7eUhhOrTBXWlFugYOIIfs6CfhV0dZ8aGr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1513
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: kRnMuqm-vbesIi4yAm1Jf1xpChiTR1ec
X-Proofpoint-ORIG-GUID: kRnMuqm-vbesIi4yAm1Jf1xpChiTR1ec
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_08,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=715
 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220113
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCiAgICA+IEknbSBub3QgZmFtaWxpYXIgd2l0aCB0aGUgaHdfYnJlYWtwb2ludC5jIGNv
ZGUsIGJ1dCBJIGNhbiBzZWUgdGhhdCB0aGUNCiAgICA+IGdldF9kZWJ1Z19hcmNoKCkNCiAgICA+
IGFuZCBjb3JlX2hhc19vc19zYXZlX3Jlc3RvcmUoKSBmdW5jdGlvbnMgYXJlIGF0IGxlYXN0IGVp
Z2h0IHllYXJzIG9sZCwNCiAgICA+IGFuZCBDb3J0ZXgtQTkNCiAgICA+IGlzIG9uZSBvZiB0aGUg
bW9zdCBjb21tb24gQ1BVIGNvcmVzLCBzbyBpdCB3b3VsZCBiZSB1bmxpa2VseSB0aGF0IHRoaXMN
CiAgICA+IGlzIGEgcHJvYmxlbQ0KICAgID4gd2l0aCB0aGUgQ1BVIGNvcmUgaW4gZ2VuZXJhbC4g
TXkgYmVzdCBndWVzcyB3b3VsZCBiZSB0aGF0IHlvdXIgYm9vdA0KICAgID4gbG9hZGVyIGNvZGUg
aXMNCiAgICA+IG1pc3NpbmcgYSBiaXQgb2YgaW5pdGlhbGl6YXRpb24gdGhhdCBpcyByZXF1aXJl
ZCB0byBwdXQgdGhpcyBpbnRvIHRoZQ0KICAgID4gY29ycmVjdCBzdGF0ZS4NCg0KDQpJIHNwZW50
IGFkZGl0aW9uYWwgdGltZSB0byBhbmFseXplIHRoZSBpc3N1ZS4gV2UgYXJlIGNsZWFybHkgYWZm
ZWN0ZWQgYnkgdGhlIGVycmF0YSA3NjQzMTkgbWVudGlvbmVkIGhlcmUuIChjaGVja2VkIHdpdGgg
b3VyIHNpbGljb24gdGVhbSBhbmQgdmFsaWRhdGVkIHdpdGggSlRBRyBkZWJ1Z2dlciBhY2Nlc3Mp
IGh0dHBzOi8vZGV2ZWxvcGVyLmFybS5jb20vZG9jdW1lbnRhdGlvbi91YW4wMDA5L2xhdGVzdC8g
YW5kIGNhbid0IGNoYW5nZSB0aGUgaGFyZHdhcmUgYXMgaXQgaXMgYSBwcm9kdWN0aW9uIHNpbGlj
b24uIFdpdGggdGhhdCBzYWlkLCBJIGFsc28gY2hlY2tlZCBhIGZldyB0aGluZ3Mgb24gb3VyIFBN
VSwgYW5kIHRoZSBtYWluIHJlYXNvbiB3aHkgd2UgZGlkbid0IHB1dCBpdCBpbnRvIHRoZSBpbml0
aWFsIERUU0kgaXMgYmVjYXVzZSB3ZSBhcmUgImRpc2FibGluZyIgaXQsIGFuZCBpdHMgaW50ZXJy
dXB0IGlzIG5vdCBjb25uZWN0ZWQgdG8gb3VyIFZJQyBzdWJzeXN0ZW0uIFNvIGV2ZW4gaWYgd2Ug
ZmluZCBhIHdvcmthcm91bmQgdG8gQVJNIGVycmF0YSAod2UgYXNrZWQgdGhlbSB0aGUgcXVlc3Rp
b24pLCB0aGUgUE1VIHdpbGwgc3RpbGwgbm90IGJlIGZ1bmN0aW9uYWwgYW5kIGhhdmluZyBpdCBw
cmVsb2FkZWQgYW5kIGluaXRpYWxpemVkIGlzIHByb2JhYmx5IG5vdCB3aGF0IHdlIGludGVudCB0
by4NCg0KR1hQIEFzaWMgaXMgYSBTb0MgZGVzaWduZWQgZm9yIEJhc2Vib2FyZCBNYW5hZ2VtZW50
IENvbnRyb2xsZXIgcHVycG9zZS4gSXQgaXMgaW4gc29tZSB3YXkgYSBkZWRpY2F0ZWQgU29DIG5v
dCBkZXNpZ25lZCBmb3IgZ2VuZXJhbCBwdXJwb3NlIGNvbXB1dGluZy4gV2UgaW1wbGVtZW50ZWQg
aXQgd2l0aCBzZWN1cml0eSBpbiBtaW5kLCBhbmQgaGF2ZSBkZWJ1ZyBzeXN0ZW1zICh3aGljaCBh
cmUgbm90IHNoaXBwZWQgb3V0c2lkZSBIUEUpLCBhbmQgcHJvZHVjdGlvbiBzeXN0ZW1zICh3aXRo
b3V0IFBNVSBhY3RpdmUpIHdoaWNoIGFyZSB3aGF0IHlvdSBjYW4gZmluZCBpbiBtYW55IG9mIG91
ciBzZXJ2ZXJzLiBPdXIgaW50ZW50IGlzIHRvIG9mZmVyIGZ1bGwgbGludXggc3VwcG9ydCBvbiB0
aGlzIFNvQyBmYW1pbHkgYXMgdG8gYnJpbmcgT3BlbkJNQyBiZW5lZml0IGFuZCBtb3JlIHNvZnR3
YXJlIGNob2ljZXMgdG8gb3VyIGVuZCB1c2Vycy4gDQoNCldpdGggdGhhdCBzYWlkLCB3ZSBjbGVh
cmx5IGRvIG5vdCB3YW50IHRvIG92ZXJsb2FkIHRoZSBsaW51eCBrZXJuZWwgd2l0aCBzcGVjaWZp
YyBjb2RlIGFuZCB3aWxsIGFsd2F5cyBwcm9tb3RlIGZsZXhpYmxlIGFic3RyYWN0aW9uIHVzYWdl
LCBhcyB3ZWxsIGF2b2lkIHVubmVjZXNzYXJ5IGNvbmZpZ3VyYXRpb24gZmlsZXMuDQoNCldlIGlu
aXRpYWxseSBjcmVhdGVkIGEgZGVkaWNhdGVkIGd4cF9kZWZjb25maWcgYXMgd2UgdG9vayBpbnNw
aXJhdGlvbiBmcm9tIGFzcGVlZCBpbXBsZW1lbnRhdGlvbiwgYnV0IEkgdGhpbmsgdXNpbmcgdGhl
IGdlbmVyaWMgYXJtdjcgaXMgd2F5IG5pY2VyIGFuZCBiZXR0ZXIuIEl0IHdpbGwgYWxzbyBwcm92
aWRlIGJldHRlciBiZW5lZml0IHRvIHRoZSBrZXJuZWwgdGVhbSBieSBpZGVudGlmeWluZyB0aGUg
dmFyaW91cyBib3R0bGVuZWNrcyB0aGF0IFNvQyB2ZW5kb3JzIGxpa2Ugd2UgYXJlLCBhcmUgZmFj
aW5nIHdoZW4gZW5hYmxpbmcgbGludXgga2VybmVsIHN1cHBvcnQuIA0KDQogVGhlIFBFUkZfRVZF
TlRTIGVudHJ5IGZyb20gdGhlIG11bHRpX3Y3X2RlZmNvbmZpZyBpcyB0aGUgb25seSBpc3N1ZSB0
aGF0IHdlIGZhY2UgdG8gdXNlIHRoYXQgZGVmYXVsdCBjb25maWd1cmF0aW9uIGZpbGUuIEkgbWFk
ZSBzb21lIHRlc3RzLCBhbmQgaWYgdGhpcyBkZWZjb25maWcgZmlsZSBpcyBjb25maWd1cmluZyBQ
RVJGX0VWRU5UUyBhcyBhIG1vZHVsZSwgaXQgd2lsbCBhbGxvdyB1cyB0byBjb21waWxlIGZyb20g
aXQgYSBwZXJmZWN0bHkgd29ya2luZyBrZXJuZWwuIEkgZG9uJ3QgdGhpbmsgdGhpcyB3b3VsZCBp
bXBhY3QgYW55IG90aGVyIGltcGxlbWVudGF0aW9uIHdoaWNoIHdpbGwgaGF2ZSB0byBsb2FkIHRo
ZSBtb2R1bGUgaW5zdGVhZCBvZiBhc3N1bWluZyBpdCBpcyBpbnRlZ3JhdGVkLiBGcm9tIGEga2Vy
bmVsIGZlYXR1cmUgcGVyc3BlY3RpdmUgSSBkbyBub3QgZmluZCBhbnkgZ29vZCByZWFzb24gd2h5
IHBlcmYgZXZlbnRzIHNoYWxsIGJlIGFjdGl2YXRlZCBieSBkZWZhdWx0LCBhbmQgSSdsbCBiZSBp
bnRlcmVzdGVkIHRvIHVuZGVyc3RhbmQgd2h5IGl0IGlzIGZyb20gYSBwdXJlIGludGVsbGVjdHVh
bCByZWFzb24uDQoNCldvdWxkIHlvdSBhY2NlcHQgYSBwYXRjaCB3aGljaCBpcyBzd2l0Y2hpbmcg
UEVSRl9FVkVOVFM9eSB0byBQRVJGX0VWRU5UUz1tIGludG8gbXVsdGlfdjdfZGVmY29uZmlnID8g
VGhlbiB3ZSBjb3VsZCBhZGQgb3VyIEdYUCBkZWZpbml0aW9uIGludG8gaXQgbGlrZSBvdGhlciBj
aGlwcyBhcmUuIFRoaXMgY291bGQgYWxzbyBoZWxwIG90aGVyIGNoaXAgdmVuZG9ycyBhZmZlY3Rl
ZCBieSB0aGUgc2FtZSBidWcuIEkgYW0gcHJldHR5IHN1cmUgd2UgYXJlIG5vdCB0aGUgb25seSBv
bmUuIFJlZHVjaW5nIGRlZmNvbmZpZyBmaWxlIGFuZCByZWx5aW5nIG9uIGdlbmVyYWwgcHVycG9z
ZSBvbmUgcGVyIGFyY2hpdGVjdHVyZSByZXZpc2lvbiBtYWtlIHRvdGFsbHkgc2Vuc2UgdG8gbWUu
DQoNCnZlam1hcmllDQoNCg0KDQo=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603354DB515
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245249AbiCPPnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242407AbiCPPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:43:30 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890DF4BB9A;
        Wed, 16 Mar 2022 08:42:15 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22GDmXUe023020;
        Wed, 16 Mar 2022 15:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=cIVVzgQF4hY2GpE9JoNsuthYClUiQO9ffsc1c8rTVn4=;
 b=cHklWh+W3wW82sG3Y28va2lhLlakDg9/+0qqhgw+KpEoSwycYB9QQb1D3y/ISSABxSqa
 +MxhXS8Beyj32UlyV5jxU9UQjtd25R0nqAs84QrCt8M4is5bXwpACaJbiCcnh/o3DAz8
 9si6KR/6AvqK299p63qtNtMEEM01UjDJaBBIlHJP6B6vJig3sX0kK6e3NQzS4IZQxwHK
 yG23D7y9Sgry8Y3kApwkt4DzxShf1sjV2CSM8Kg6XaN9Gcubk4IFZbL8796waapH/44n
 OUc2KF1+1RE6Y72EffgmaS2PEboP8Ru94YIgIPu+WARpNKi4s227uq5pD9CMb6r2n0rk Qg== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3euh399jub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Mar 2022 15:42:02 +0000
Received: from G9W8456.americas.hpqcorp.net (g9w8456.houston.hp.com [16.216.161.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3426.houston.hpe.com (Postfix) with ESMTPS id 1174F5F;
        Wed, 16 Mar 2022 15:42:00 +0000 (UTC)
Received: from G1W8107.americas.hpqcorp.net (2002:10c1:483b::10c1:483b) by
 G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 16 Mar 2022 15:41:59 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (15.241.52.10) by
 G1W8107.americas.hpqcorp.net (16.193.72.59) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Wed, 16 Mar 2022 15:42:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bh2zbvkJT86Kd56KHbklVhMua/81nID4x+FQbwSH97mIUz3v7sz6S+3mytKsixG52F3mrUorlXABtjn5z7jEze6KT4NLTUmDBpNPanUQE+fnWVvJuvF2RCpb9xcRjCv9/QdcOvEgN3jZ8j1LqQZrmgO4pQcBDTekKBV+NW7xHlS7REUPwrQd+DqLAyHownBmB8TbYpvWhHZDqR1RE+X6pFSV5OQqZBsAJMTsPfHWQKCxcsqXdR3b69okPWmq+CKyDO8WSkYsSVtG+Qp4ep68ELE1nt8X1jI73NLkMY0J1b+xOX/KGh+QeUrgtNvOIUSKXpcjvJ3y1h32gpMV0Bsqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIVVzgQF4hY2GpE9JoNsuthYClUiQO9ffsc1c8rTVn4=;
 b=L6uqBGttFhu1Cg/vZ1828Uw82YkokT77rHzToVULbg+sy0nBAmJ/Nl6Oh2XncYsYBDNIegydcCj9mxS1I43PD8jh8Z19H6G92XVTMmdR10jvLLXiMmjeGGIqyETFJ3UYC/QfSQr4Dd2HRZ7cuQHxkSZ7ZrwgjfO5KiFvTLwlnEBW86yef+gSJCvzXLVqmzbilJKmYtZDPyRW/0jeGsxBak/d54/JYHyN+Q7JKzlFfB9SGyFNjCdtAeckhFw9DOt+Tk+e45JOH01XoYReieKMDM1yt8/oev7YEL4tooxClydXBZ3QSy/B5TuQ8LcEY1HLjuSthhYG2bvLihgPqeWA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by MW5PR84MB1379.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.29; Wed, 16 Mar
 2022 15:41:58 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e40c:dff1:1884:c484]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e40c:dff1:1884:c484%8]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 15:41:58 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Thread-Topic: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Thread-Index: AQHYNLgx692NqDgvU0iOWKp+QCe0Uqy5/HOAgAgo3qA=
Date:   Wed, 16 Mar 2022 15:41:58 +0000
Message-ID: <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com>
In-Reply-To: <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa49bd6d-bbc6-43f1-ce2d-08da076381b4
x-ms-traffictypediagnostic: MW5PR84MB1379:EE_
x-microsoft-antispam-prvs: <MW5PR84MB1379B446FF3DEB34D0BB433988119@MW5PR84MB1379.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pRK+aBjDSJQYwXyVs4WVLjq/fszDIezEuyt4zEthbDfGBcwTs2obxiF1Usrrvkh1by5GzuGL9yom5XDQsQndaVJyQ/B79wED/gg/HifNxPRbcRlDP3xeot0snrzAUhsWeY7B0xKWZ8grjd3nRWu7qL7xQdmvSFsIxvoSuvN3Q5pFAub0S3PKubE3IHTr/my6ZGU8qE+SRfp0YwrpsrQ4AqRO9ld+vldvlEp+DgvOUV/17EXrEnO8ihBT/teh/Frnl4atDpym4Wt3qkEV00kC91EBjO21PWB9NaVPYF0IenX2aAwu3zbz7Po/R3QHFNxrzh791sxrhBgW35RPI8+wChbuJge1kutSGahwshFEwP98VBy0FiXWMFP2i9ldfdvYxqcL158KJBoqN4Qp/VlqNJzqKFYYSV8FxhP2uYxFK62utMQDyJYyITDoY0BYFKhIUz2WXlxK9vNVQ5VIb2CLC1iLjvZ49Z1KPZRQeQLy4SavMBJ5KOOWpSnfyTtgpG2P7ME2JlKsv6Dd8VeRIKCrw5gcO6PGFQkJUnW9EfnyUvoXWKLWjvV2Mtjz6XpZW4q0BeI6O91z2e6PvB+Ceq9pMkoSJFu88IQU4qWtm49odpFohnQXGlfVNSuXPGexY1Jvtltmg+fbWXHIyFu2I+CJIfd1HuwwUYkSUbVkIa7s+sDazsUdYqolR3WTnDoYJAAFPiSpDb03Q9VEc0kP5PZprg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(38070700005)(83380400001)(26005)(186003)(5660300002)(4326008)(52536014)(64756008)(8676002)(66476007)(66556008)(66946007)(66446008)(2906002)(8936002)(76116006)(33656002)(6636002)(82960400001)(508600001)(316002)(9686003)(55016003)(55236004)(53546011)(6506007)(7696005)(54906003)(71200400001)(86362001)(122000001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1BTRnlYMnlBbCtsWUxlUUlRb2R5SFVSL1l4MkxJNFNyQ2ZJUU5SSW1NMFZB?=
 =?utf-8?B?QStyMVVNUDNuKzlwUXJtdmtneWNjK2hUUTBOazRjTnRxeUNGd3UrbUhKWjVW?=
 =?utf-8?B?RmpPRmRXdjdrWW1zekNsR2VtUkV5elhMQkgweWpRS1BmYTE0V25DbFlWU25l?=
 =?utf-8?B?aTVObkkvdnZzRnRKSVRLQUZLUmxQTU9OYWh0VTFScEZqSkljVjNQV0xIeTJt?=
 =?utf-8?B?RmFIOTFhOVptLzd6dnNWNXhlZGhJZHFUaXdaVHVBU0xlSlMwNlFIaWRMZ2VD?=
 =?utf-8?B?NlM0bVRhU2tCSzEzVktwbkxUUlpJcTg0OW1GRmJqSlF4M0dBYXpYRUh1czVi?=
 =?utf-8?B?RXlzRzFIMUJwRkdLSjNjSFh3dzhZaXluM0Y2ZWEyaStqL04wMnBubG1xaTVC?=
 =?utf-8?B?UVhpc1dvR0RXcWxFcFNzT2tEYzhqc2ZZQU85UlFKWDRLeU5YVmFvNTNyRmVU?=
 =?utf-8?B?R3ZrbU5QdVpZaWVmaXl3NW9FUEFEUVJHYm1mblhmRWVLelUyZzA0dlNKeVNw?=
 =?utf-8?B?WUx5L2tSbjhZYnFhSnBzTldKcDVFbDZTZjVXUzR0REVuc0gyS2RLVWYwUUh0?=
 =?utf-8?B?OWEvak81SUdoWXpQQWVXQXhKMTg3WXcxdzdCOE1sbXgwdk5YNzhPdWd5dENS?=
 =?utf-8?B?VHprN3NPQmFMT2hsbVR3SGpENVRxbElLbTdtZVZtZUtDcFVZWVVidnlBYjZY?=
 =?utf-8?B?OWJJSnpiYXNPMDVBWFM4MThCbGt2dzNxTXpvNkVyWHpVenRvK09CUHF6RG9j?=
 =?utf-8?B?UXFYNlpKa3VwRHB4czJ5aFFSaFUrTUdZUFlSVzNhTmRvT2xtS3MrZ3J0M3Bu?=
 =?utf-8?B?VGZIaW5WQWRXOUVyOGc4cDNPbWxXOENBdlIxbHJ3b2krYkZJSXhvK0I1ZXdi?=
 =?utf-8?B?Y1lUcXRsVUdXR1BLQnJPa1BxeHpJYWRqdUl1UjF3NTlGTzlaekE1MGJUU0c1?=
 =?utf-8?B?RU40TlAyUkRycnAyUzdOSHBpZWJkM0JweWhocm5HS0hWWVArOU8vdG4wUEpJ?=
 =?utf-8?B?d1VBWTVsbTM1VmNSMitaT3JIV0VzMC95dWRXeFZCbzlXQTErNVhXRk1zUThN?=
 =?utf-8?B?OGVIc2NmeCtDdUdqUDBKNjZoQVhFWGVBTlgwN2JuU25JMWoyVEk4eUVQTU9T?=
 =?utf-8?B?WVhscVhLaUJwbHhnOWJuOUJhUFRZMFNNenhhWEV2NEw1MlRZYzY4K2gvYnBj?=
 =?utf-8?B?YnpIU2ZETVFhMkVmNmtITHc1MTRNMVV0QWlWY3ZjalNuY2ZJTHV4SUIwRmFM?=
 =?utf-8?B?bWJNR1VhK0xKWUU1R2NkbWN4dzJzaDQ4V2hMb2ZCSFplRjRzNkcyc1lzbVhX?=
 =?utf-8?B?KzZDdjR3NHpucXdraXJSQkVLaTBWcm84OE5wNjh6dGNFVXdYMVNoR1VGQVVx?=
 =?utf-8?B?RzlwZ2tuRmdNc1lnSEV1UGd2Tmtxa2IxOVhkT0EyRGYzdjVhOU5wRzBvN1BJ?=
 =?utf-8?B?b25XSjZjeVBiR2JrT2d1dnpWNVN2NmVndUVjcmptNWg0aXBMNXRKL3hhK1JF?=
 =?utf-8?B?dkRtdnk2b1UycUFqRkFTcmUyMzE0dXlKN053WU04MzVLSFBxd3NmQ05BbzN1?=
 =?utf-8?B?VXIrVzhqS2ZMRUxDTll1K3lRQ0VxK0NwVU9CRGJ3RkdIdDcwaWxybFF3T0Z1?=
 =?utf-8?B?MlA2cVJOZFFPTzNmMElIRC8zMHF1QVVXZExDeldwMVBOQlpaNlFBbEx2SGxT?=
 =?utf-8?B?ajFPd21zL3p0RUEzd0RvYWFONnNFckJpMElzUHZCRHg3QkV2QlEybCs2cGRD?=
 =?utf-8?B?alJtcWxPQTRkTVExdmtULzBzZkFGcitZeDRZRCtXVFZvbnhjcUJab1o5dExO?=
 =?utf-8?B?MldoNE53cTVpRDBsb3owc1lMVitiUVBWQUxOT3dxb0YrTVQrVG1aU3Uxa3hr?=
 =?utf-8?B?R05xMWh0L29sZXN0WnJEY1BGZXR1K3EvOEZaeVkrL05EZjVqN0tZQmV6cDRx?=
 =?utf-8?Q?bPeIjXEzud1kFHjwd1N24W/RV8nnIwWB?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fa49bd6d-bbc6-43f1-ce2d-08da076381b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 15:41:58.4207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mNdI2JEFhBXLonrl9vmkNJyrPiVUJUtsj8IPKkg0hUWq3XWQtnXYlYF8ASirktWkhQ4Scz487+VEGSajL79WUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1379
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: u2DOZA6B905KVCa-gVEz1tgeSoZ8g8Dk
X-Proofpoint-GUID: u2DOZA6B905KVCa-gVEz1tgeSoZ8g8Dk
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-16_06,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203160097
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtyenlzenRvZiBLb3psb3dza2kgW21h
aWx0bzprcnp5c3p0b2Yua296bG93c2tpQGNhbm9uaWNhbC5jb21dDQpTZW50OiBGcmlkYXksIE1h
cmNoIDExLCAyMDIyIDQ6MzAgQU0NClRvOiBIYXdraW5zLCBOaWNrIDxuaWNrLmhhd2tpbnNAaHBl
LmNvbT4+OyBWZXJkdW4sIEplYW4tTWFyaWUgPHZlcmR1bkBocGUuY29tPj4NCkNjOiBBcm5kIEJl
cmdtYW5uIDxhcm5kQGFybmRiLmRlPj47IE9sb2YgSm9oYW5zc29uIDxvbG9mQGxpeG9tLm5ldD4+
OyBzb2NAa2VybmVsLm9yZzsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4+OyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYz
IDA5LzEwXSBhcmNoOiBhcm06IGJvb3Q6IGR0czogSW50cm9kdWNlIEhQRSBHWFAgRGV2aWNlIHRy
ZWUNCg0KT24gMTAvMDMvMjAyMiAyMDo1Miwgbmljay5oYXdraW5zQGhwZS5jb20gd3JvdGU6DQo+
PiBGcm9tOiBOaWNrIEhhd2tpbnMgPG5pY2suaGF3a2luc0BocGUuY29tPj4NCj4+IA0KPj4gVGhl
IEhQRSBTb0MgaXMgbmV3IHRvIGxpbnV4LiBUaGlzIHBhdGNoIGNyZWF0ZXMgdGhlIGJhc2ljIGRl
dmljZSB0cmVlIA0KPj4gbGF5b3V0IHdpdGggbWluaW11bSByZXF1aXJlZCBmb3IgbGludXggdG8g
Ym9vdC4gVGhpcyBpbmNsdWRlcyB0aW1lciANCj4+IGFuZCB3YXRjaGRvZyBzdXBwb3J0Lg0KPj4g
DQo+PiBTaWduZWQtb2ZmLWJ5OiBOaWNrIEhhd2tpbnMgPG5pY2suaGF3a2luc0BocGUuY29tPj4N
Cj4+IC0tLQ0KPj4gIGFyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlICAgICAgICAgICAgICAgfCAg
IDIgKw0KPj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2hwZS1ibWMtZGwzNjBnZW4xMC5kdHMgfCAgMjcg
KysrKysNCj4+ICBhcmNoL2FybS9ib290L2R0cy9ocGUtZ3hwLmR0c2kgICAgICAgICAgIHwgMTQ4
ICsrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCAxNzcgaW5zZXJ0
aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9ocGUtYm1j
LWRsMzYwZ2VuMTAuZHRzDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRz
L2hwZS1neHAuZHRzaQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFr
ZWZpbGUgYi9hcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSANCj4+IGluZGV4IGU0MWVjYTc5Yzk1
MC4uMjgyM2IzNTlkMzczIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZp
bGUNCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlDQo+PiBAQCAtMTU1MCwzICsx
NTUwLDUgQEAgZHRiLSQoQ09ORklHX0FSQ0hfQVNQRUVEKSArPSBcDQo+PiAgCWFzcGVlZC1ibWMt
dmVnbWFuLW4xMTAuZHRiIFwNCj4+ICAJYXNwZWVkLWJtYy12ZWdtYW4tcngyMC5kdGIgXA0KPj4g
IAlhc3BlZWQtYm1jLXZlZ21hbi1zeDIwLmR0Yg0KPj4gK2R0Yi0kKENPTkZJR19BUkNIX0hQRV9H
WFApICs9IFwNCj4+ICsJaHBlLWJtYy1kbDM2MGdlbjEwLmR0Yg0KDQo+IEFscGhhYmV0aWNhbGx5
LCBhbHNvIGluIHJlc3BlY3QgdG8gb3RoZXIgYXJjaGl0ZWN0dXJlcywgc28gYmVmb3JlIENPTkZJ
R19BUkNIX0lOVEVHUkFUT1IuDQoNCkRvbmUNCg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2hwZS1ibWMtZGwzNjBnZW4xMC5kdHMNCj4+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaHBl
LWJtYy1kbDM2MGdlbjEwLmR0cw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAw
MDAwMDAwMDAwMC4uZGE1ZWFjMTIxM2E4DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9hcmNo
L2FybS9ib290L2R0cy9ocGUtYm1jLWRsMzYwZ2VuMTAuZHRzDQo+PiBAQCAtMCwwICsxLDI3IEBA
DQo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+ICsvKg0KPj4gKyAq
IERldmljZSBUcmVlIGZpbGUgZm9yIEhQRSBETDM2MEdlbjEwICAqLw0KPj4gKw0KPj4gKy9pbmNs
dWRlLyAiaHBlLWd4cC5kdHNpIg0KPj4gKw0KPj4gKy8gew0KPj4gKwkjYWRkcmVzcy1jZWxscyA9
IDwxPj47DQo+PiArCSNzaXplLWNlbGxzID0gPDE+PjsNCj4+ICsJY29tcGF0aWJsZSA9ICJocGUs
Z3hwIjsNCg0KPiBNaXNzaW5nIGJvYXJkIGNvbXBhdGlibGUuDQoNCldpbGwgYmVjb21lIGNvbXBh
dGlibGUgPSAgImhwZSxneHAiLCJocGUsYm1jLWRsMzYwZ2VuMTAiOyBJZiB0aGF0IHNlZW1zIG9r
YXkgdG8geW91Lg0KDQo+PiArCW1vZGVsID0gIkhld2xldHQgUGFja2FyZCBFbnRlcnByaXNlIFBy
b0xpYW50IGRsMzYwIEdlbjEwIjsNCj4+ICsNCj4+ICsJY2hvc2VuIHsNCj4+ICsJCWJvb3Rhcmdz
ID0gImVhcmx5cHJpbnRrIGNvbnNvbGU9dHR5UzIsMTE1MjAwIjsNCg0KPiBJIGhhdmUgaW1wcmVz
c2lvbiB3ZSB0YWxrZWQgYWJvdXQgaXQuLi4NCg0KUmVtb3ZlZCENCg0KPj4gKwl9Ow0KPj4gKw0K
Pj4gKwltZW1vcnlANDAwMDAwMDAgew0KPj4gKwkJZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsNCj4+
ICsJCXJlZyA9IDwweDQwMDAwMDAwIDB4MjAwMDAwMDA+PjsNCj4+ICsJfTsNCj4+ICsNCj4+ICsJ
YWhiIHsNCg0KPiBXaHkgZG8geW91IG5lZWQgZW1wdHkgbm9kZT8NCg0KSSBkbyBub3QsIHRoaXMg
d2FzIGEgcGxhY2Vob2xkZXIgZm9yIGFmdGVyIHRoZSBpbml0aWFsIGNoZWNraW4gd2hlcmUgSSB3
b3VsZCBwdXQgYWxsIHRoZSBib2FyZCBzcGVjaWZpYyBzdHVmZi4gVGhpcyBoYXMgYmVlbiByZW1v
dmVkLg0KDQo+PiArDQo+PiArCX07DQo+PiArDQo+PiArfTsNCj4+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9ib290L2R0cy9ocGUtZ3hwLmR0c2kgDQo+PiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2hwZS1n
eHAuZHRzaSBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleCANCj4+IDAwMDAwMDAwMDAwMC4uZGZh
ZjhkZjgyOWZlDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9o
cGUtZ3hwLmR0c2kNCj4+IEBAIC0wLDAgKzEsMTQ4IEBADQo+PiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjANCj4+ICsvKg0KPj4gKyAqIERldmljZSBUcmVlIGZpbGUgZm9yIEhQ
RSBHWFANCj4+ICsgKi8NCj4+ICsNCj4+ICsvZHRzLXYxLzsNCj4+ICsvIHsNCj4+ICsJbW9kZWwg
PSAiSGV3bGV0dCBQYWNrYXJkIEVudGVycHJpc2UgR1hQIEJNQyI7DQo+PiArCWNvbXBhdGlibGUg
PSAiaHBlLGd4cCI7DQo+PiArCSNhZGRyZXNzLWNlbGxzID0gPDE+PjsNCj4+ICsJI3NpemUtY2Vs
bHMgPSA8MT4+Ow0KPj4gKw0KPj4gKwljcHVzIHsNCj4+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+
PjsNCj4+ICsJCSNzaXplLWNlbGxzID0gPDA+PjsNCj4+ICsNCj4+ICsJCWNwdUAwIHsNCj4+ICsJ
CQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTkiOw0KPj4gKwkJCWRldmljZV90eXBlID0gImNw
dSI7DQo+PiArCQkJcmVnID0gPDA+PjsNCj4+ICsJCX07DQo+PiArCX07DQo+PiArDQo+PiArCWd4
cC1pbml0QGNlZmUwMDEwIHsNCg0KPiBOZWVkIGEgZ2VuZXJpYyBub2RlIG5hbWUuIGdweC1pbml0
IGlzIHNwZWNpZmljLg0KDQpXaWxsIGRvLiBCdXQgbW9yZSB0aGFuIGxpa2VseSB0aGlzIGlzIGdv
aW5nIHRvIGdldCByZW1vdmVkIGFzIEkgdHJ5IHRvIHB1c2ggdGhpcyBvcHRpb24gaW50byB0aGUg
Ym9vdGxvYWRlci4NCg0KPj4gKwkJY29tcGF0aWJsZSA9ICJocGUsZ3hwLWNwdS1pbml0IjsNCj4+
ICsJCXJlZyA9IDwweGNlZmUwMDEwIDB4MDQ+PjsNCj4+ICsJfTsNCj4+ICsNCj4+ICsJbWVtb3J5
QDQwMDAwMDAwIHsNCj4+ICsJCWRldmljZV90eXBlID0gIm1lbW9yeSI7DQo+PiArCQlyZWcgPSA8
MHg0MDAwMDAwMCAweDIwMDAwMDAwPj47DQo+PiArCX07DQo+PiArDQo+PiArCWFoYiB7DQoNCj4g
QnkgY29udmVudGlvbiB3ZSBjYWxsIGl0IHNvYy4NCg0KPj4gKwkJY29tcGF0aWJsZSA9ICJzaW1w
bGUtYnVzIjsNCj4+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+PjsNCj4+ICsJCSNzaXplLWNlbGxz
ID0gPDE+PjsNCj4+ICsJCWRldmljZV90eXBlID0gInNvYyI7DQo+PiArCQlyYW5nZXM7DQo+PiAr
DQo+PiArCQl2aWMwOiBpbnRlcnJ1cHQtY29udHJvbGxlckBjZWZmMDAwMCB7DQo+PiArCQkJY29t
cGF0aWJsZSA9ICJhcm0scGwxOTItdmljIjsNCj4+ICsJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsN
Cj4+ICsJCQlyZWcgPSA8MHhjZWZmMDAwMCAweDEwMDA+PjsNCg0KPiBQbGVhc2UgcHV0IHJlZyBh
ZnRlciBjb21wYXRpYmxlLCBldmVyeXdoZXJlLg0KDQpEb25lDQoNCj4+ICsJCQkjaW50ZXJydXB0
LWNlbGxzID0gPDE+PjsNCj4+ICsJCX07DQo+PiArDQo+PiArCQl2aWMxOiBpbnRlcnJ1cHQtY29u
dHJvbGxlckA4MGYwMDAwMCB7DQo+PiArCQkJY29tcGF0aWJsZSA9ICJhcm0scGwxOTItdmljIjsN
Cj4+ICsJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsNCj4+ICsJCQlyZWcgPSA8MHg4MGYwMDAwMCAw
eDEwMDA+PjsNCj4+ICsJCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+PjsNCj4+ICsJCX07DQo+PiAr
DQo+PiArCQl0aW1lcjA6IHRpbWVyQGMwMDAwMDgwIHsNCj4+ICsJCQljb21wYXRpYmxlID0gImhw
ZSxneHAtdGltZXIiOw0KPj4gKwkJCXJlZyA9IDwweGMwMDAwMDgwIDB4MT4+LCA8MHhjMDAwMDA5
NCAweDAxPj4sIDwweGMwMDAwMDg4IDB4MDg+PjsNCj4+ICsJCQlpbnRlcnJ1cHRzID0gPDA+PjsN
Cj4+ICsJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZ2aWMwPj47DQo+PiArCQkJY2xvY2stZnJlcXVl
bmN5ID0gPDQwMDAwMDAwMD4+Ow0KPj4gKwkJfTsNCj4+ICsNCj4+ICsJCXVhcnRhOiBzZXJpYWxA
YzAwMDAwZTAgew0KPj4gKwkJCWNvbXBhdGlibGUgPSAibnMxNjU1MGEiOw0KPj4gKwkJCXJlZyA9
IDwweGMwMDAwMGUwIDB4OD4+Ow0KPj4gKwkJCWludGVycnVwdHMgPSA8MTc+PjsNCj4+ICsJCQlp
bnRlcnJ1cHQtcGFyZW50ID0gPCZ2aWMwPj47DQo+PiArCQkJY2xvY2stZnJlcXVlbmN5ID0gPDE4
NDYxNTM+PjsNCj4+ICsJCQlyZWctc2hpZnQgPSA8MD4+Ow0KPj4gKwkJfTsNCj4+ICsNCj4+ICsJ
CXVhcnRiOiBzZXJpYWxAYzAwMDAwZTggew0KPj4gKwkJCWNvbXBhdGlibGUgPSAibnMxNjU1MGEi
Ow0KPj4gKwkJCXJlZyA9IDwweGMwMDAwMGU4IDB4OD4+Ow0KPj4gKwkJCWludGVycnVwdHMgPSA8
MTg+PjsNCj4+ICsJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZ2aWMwPj47DQo+PiArCQkJY2xvY2st
ZnJlcXVlbmN5ID0gPDE4NDYxNTM+PjsNCj4+ICsJCQlyZWctc2hpZnQgPSA8MD4+Ow0KPj4gKwkJ
fTsNCj4+ICsNCj4+ICsJCXVhcnRjOiBzZXJpYWxAYzAwMDAwZjAgew0KPj4gKwkJCWNvbXBhdGli
bGUgPSAibnMxNjU1MGEiOw0KPj4gKwkJCXJlZyA9IDwweGMwMDAwMGYwIDB4OD4+Ow0KPj4gKwkJ
CWludGVycnVwdHMgPSA8MTk+PjsNCj4+ICsJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZ2aWMwPj47
DQo+PiArCQkJY2xvY2stZnJlcXVlbmN5ID0gPDE4NDYxNTM+PjsNCj4+ICsJCQlyZWctc2hpZnQg
PSA8MD4+Ow0KPj4gKwkJfTsNCj4+ICsNCj4+ICsJCXVzYjA6IHVzYkBjZWZlMDAwMCB7DQo+PiAr
CQkJY29tcGF0aWJsZSA9ICJnZW5lcmljLWVoY2kiOw0KDQo+IEkgdGhpbmsgb25lIG9mIHByZXZp
b3VzIGNvbW1lbnRzIHdhcyB0aGF0IHlvdSBjYW5ub3QgaGF2ZSAiZ2VuZXJpYy1laGNpIg0KPiBv
bmx5LCByaWdodD8NCg0KWWVzIHRoZXJlIHdhcywgSSByZW1vdmVkIHRoZSB1c2IwOiBlaGNpQGNl
ZmUwMDAwLiBJIHNlZSBub3cgdGhhdCB0aGlzIGlzIGluIHJlZmVyZW5jZSB0byB0aGUgY29tcGF0
aWJsZS4gVGhpcyBpcyBvdXIgZWhjaSBjb250cm9sbGVyLiBXaGF0IHdvdWxkIGJlIGEgbW9yZSBh
cHByb3ByaWF0ZSBjb21wYXRpYmxlPyBEbyB3ZSBuZWVkIGhwZSxneHAtZWhjaSBwZXJoYXBzPw0K
DQo+PiArCQkJcmVnID0gPDB4Y2VmZTAwMDAgMHgxMDA+PjsNCj4+ICsJCQlpbnRlcnJ1cHRzID0g
PDc+PjsNCj4+ICsJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZ2aWMwPj47DQo+PiArCQl9Ow0KPj4g
Kw0KPj4gKwkJdXNiMTogdXNiQGNlZmUwMTAwIHsNCj4+ICsJCQljb21wYXRpYmxlID0gImdlbmVy
aWMtb2hjaSI7DQo+PiArCQkJcmVnID0gPDB4Y2VmZTAxMDAgMHgxMTA+PjsNCj4+ICsJCQlpbnRl
cnJ1cHRzID0gPDY+PjsNCj4+ICsJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZ2aWMwPj47DQo+PiAr
CQl9Ow0KPj4gKw0KPj4gKwkJdnJvbUA1ODAwMDAwMCB7DQo+PiArCQkJY29tcGF0aWJsZSA9ICJt
dGQtcmFtIjsNCj4+ICsJCQliYW5rLXdpZHRoID0gPDQ+PjsNCj4+ICsJCQlyZWcgPSA8MHg1ODAw
MDAwMCAweDQwMDAwMDA+PjsNCj4+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwxPj47DQo+PiArCQkJ
I3NpemUtY2VsbHMgPSA8MT4+Ow0KPj4gKwkJCXBhcnRpdGlvbkAwIHsNCj4+ICsJCQkJbGFiZWwg
PSAidnJvbS1wcmltZSI7DQo+PiArCQkJCXJlZyA9IDwweDAgMHgyMDAwMDAwPj47DQo+PiArCQkJ
fTsNCj4+ICsJCQlwYXJ0aXRpb25AMjAwMDAwMCB7DQo+PiArCQkJCWxhYmVsID0gInZyb20tc2Vj
b25kIjsNCj4+ICsJCQkJcmVnID0gPDB4MjAwMDAwMCAweDIwMDAwMDA+PjsNCj4+ICsJCQl9Ow0K
Pj4gKwkJfTsNCj4+ICsNCj4+ICsJCWkyY2c6IHN5c2NvbkBjMDAwMDBmOCB7DQoNCg0KPj4gKwkJ
CWNvbXBhdGlibGUgPSAic2ltcGxlLW1mZCIsICJzeXNjb24iOw0KPj4gKwkJCXJlZyA9IDwweGMw
MDAwMGY4IDB4MDg+PjsNCj4+ICsJCX07DQo+PiArCX07DQo+PiArDQo+PiArCWNsb2NrcyB7DQo+
PiArCQlvc2M6IG9zYyB7DQoNCj4gS2VlcCBub2RlIG5hbWluZyBjb25zaXN0ZW50LCBzbyBqdXN0
ICJjbGsiLi4uIGJ1dCBpdCdzIGFsc28gdmVyeSBnZW5lcmljIGNvbXBhcmluZyB0byBvdGhlcnMs
IHNvIEkgd29uZGVyIHdoYXQgaXMgdGhpcyBjbG9jaz8NCg0KV2UgYXJlIGluIHRoZSBwcm9jZXNz
IG9mIHJlZG9pbmcgdGhlIGNsb2Nrcy4gVGhpcyB3YXMgdGhlIG9zY2lsbGF0b3IgYnV0IG5vIGxv
bmdlciBuZWVkZWQgZm9yIHRoZSBtaW5pbXVtIGJvb3QgY29uZmlnLg0KDQo+PiArCQkJY29tcGF0
aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+PiArCQkJI2Nsb2NrLWNlbGxzID0gPDA+PjsNCj4+ICsJ
CQljbG9jay1vdXRwdXQtbmFtZXMgPSAib3NjIjsNCj4+ICsJCQljbG9jay1mcmVxdWVuY3kgPSA8
MzMzMzMzMzM+PjsNCj4+ICsJCX07DQo+PiArDQo+PiArCQlpb3BjbGs6IGlvcGNsayB7DQo+PiAr
CQkJY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+PiArCQkJI2Nsb2NrLWNlbGxzID0gPDA+
PjsNCj4+ICsJCQljbG9jay1vdXRwdXQtbmFtZXMgPSAiaW9wY2xrIjsNCj4+ICsJCQljbG9jay1m
cmVxdWVuY3kgPSA8NDAwMDAwMDAwPj47DQo+PiArCQl9Ow0KPj4gKw0KPj4gKwkJbWVtY2xrOiBt
ZW1jbGsgew0KPj4gKwkJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KPj4gKwkJCSNjbG9j
ay1jZWxscyA9IDwwPj47DQo+PiArCQkJY2xvY2stb3V0cHV0LW5hbWVzID0gIm1lbWNsayI7DQo+
PiArCQkJY2xvY2stZnJlcXVlbmN5ID0gPDgwMDAwMDAwMD4+Ow0KPj4gKwkJfTsNCg0KPiBXaGF0
IGFyZSB0aGVzZSBjbG9ja3M/IElmIGV4dGVybmFsIHRvIHRoZSBTb0MsIHRoZW4gd2hlcmUgYXJl
IHRoZXk/IE9uIHRoZSBib2FyZD8NCg0KVGhpcyB3YXMgdGhlIGludGVybmFsIGlvcGNsayBhbmQg
bWVtY2xrIHRoZXkgd2VyZSBib3RoIGludGVybmFsIHRvIHRoZSBjaGlwLg0KRm9yIG5vdyBJIGFt
IHJlbW92aW5nIG9zYyBhbmQgbWVtY2xrIGFuZCB3aWxsIGp1c3QgaGF2ZSBhbiBpb3BjbGsgdGhh
dCBHeHAtdGltZXIgd2lsbCByZWZlciB0by4NCg0KPj4gKwl9Ow0KPj4gK307DQoNClRoYW5rcywN
Cg0KLU5pY2sNCg==

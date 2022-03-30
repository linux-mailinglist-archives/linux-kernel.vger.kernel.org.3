Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99A74ECFA0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351611AbiC3W3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiC3W3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:29:46 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB7357B01;
        Wed, 30 Mar 2022 15:28:00 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22UL276Z010398;
        Wed, 30 Mar 2022 22:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=h85gZ3jehhB2SGE1ZvNIwZxqTTQDVUXTh3aQs3kzapI=;
 b=EHd1Fu0LNNFWsfXv8z0n+BpiOrugtP90wpsPglt4Vw7Ka8cey8gPbJGrmIqYjYw0doHS
 mzTmqQuEZFIuGMuyhOp1Hvo8vf7sdWgZOYgPuKs974Tn8ST08emLtFbZKO/GXYeVM4pM
 UilPhyka0Qq7z2pB96Kj9VOoIx2Nk8JTxDTBWpUZyD6m4nzKTJNgWTYFQg3ybd4awcfv
 BNK+yTntCnWTTEjjnpfgX+Gbmr+HX53vG6/Dyuy/K5sHQugVzbtfdeSaOLLb07htIgx5
 Egerin8eFQtCbgO3L+24wF9bVbroi+T747qwZ85/1zpXNtcytj+MVb8sdH/vatsKrKoH 1Q== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3f4vwd9gh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 22:27:39 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 2955B131BA;
        Wed, 30 Mar 2022 22:27:34 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 30 Mar 2022 10:27:11 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 30 Mar 2022 10:27:11 -1200
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 30 Mar 2022 10:27:11 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzMTUy9jBzZjuDSv0ogndxsP87RTcinIKkCh0IQSw+SoLI7hQ280Sr0zZm/iQgkHKibggSXIPtCwoeBqw+OQlFDVAAtgx7ZcoTtXdmVoZQLbatLm6ymj0f3P9L1mAq4t21mflVdMCvTYhBbd/MsLRC5mqDwlIY3pmLBKAZWGpA6VtMSESzccaLM1iXi9nf99h/+xli0X5hDUwiXRHiXhNBW7eGrYcsht1US+7vFf+xl5fzNAGkjnenEnPp/xXJMi5cuxLW43MzTuMuDSFCaVq+RtQg5hyOhh6MnEVLMfDcpKyff0RAq1bE+zDGQwCorf+s6OnPTLIzB4b+82Hlu99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h85gZ3jehhB2SGE1ZvNIwZxqTTQDVUXTh3aQs3kzapI=;
 b=isPQ++NFXLFakHMFJWz7iVA/BDQrI3lWaqrasKHTVMEuVihcQawE9YcTlzi3LB9c+L7R5HGrw6aUd/zq4UCnICwwJKdp98nF22/Vdfj83kZRkfiTbw8OwtbuECg7FFAKQBaE7LMry7gAWYs5HMosBwpUgkHer3ph83FhZjDYk2HIRLav6kDUOpxz9a+n43IbEaj+LKXe8d58ZpFHLiqx3XioFUkqFrUvYunbt4c+v2WRkkcdhP64O9YBzAygQsnTp7t7YR6bNttBRCCb1iEUNJDy+m5zSccKxXCJC6A7VEmob7kXKQ5/PbVHn2N09Q/yG6rd9nmQsVdNtC+vlCAfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by MW5PR84MB1962.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Wed, 30 Mar
 2022 22:27:10 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4%7]) with mapi id 15.20.5102.022; Wed, 30 Mar 2022
 22:27:10 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Olof Johansson <olof@lixom.net>,
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
Thread-Index: AQHYNLgx692NqDgvU0iOWKp+QCe0Uqy5/HOAgAgo3qCAAAx5AIAAD3gwgAEJmYCAE5R/wIAAGtkAgAAFszCAAZ7G8A==
Date:   Wed, 30 Mar 2022 22:27:10 +0000
Message-ID: <PH0PR84MB17185ADBA824F9CC9EB3E022881F9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com>
 <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com>
 <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com>
 <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
 <PH0PR84MB17181C316E55073EBC28C386881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB17181C316E55073EBC28C386881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80a30164-19da-4306-664e-08da129c6e81
x-ms-traffictypediagnostic: MW5PR84MB1962:EE_
x-microsoft-antispam-prvs: <MW5PR84MB1962CCB248252E848B8B7AEB881F9@MW5PR84MB1962.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zd6T+eVpQTgZT5NI2AqTMAiZoekchjH80miNi2o9ri0LKxNgou06zcFrjCSzJFS1j1qrEuJ/1uRqkJ0LtI4RSAu5dYzoCDmgxvWJ63SXPo/wd+ERKTLVO6ZMW9CZj2z6a6fZLTmQCVDHj4KtgRLFs6mv2/+M3o9VyBX/JU54h4LziqpTpGw7xdJsUtBY+FMuzmwzlE9/5c4TLRoTU4b6MA8nGw9SeskOgzqrSg/kX3gPK2r1XWufdqbRoSsJ23lo3iCGIlUCbjesfr2HLNk0mVk0WFDbkm2jRQp/vTulp6s1dZexStTf+vtdN/WQk+gZGVh2VDKkREAoja6OXWTBOdIRQeMSDCy8Iqg2E7ecZeLWSWIdvXDscoetZbbY8Z9SD86QsPUcO945ZSTNOnLEgMYalLyJ7EB25rNycGXBuGx/2mUE/WXVO3fy/qsO3V/9Lm1ae5e3PqYO9OX5S92ZglOzAbaf8rLFatDv6QVWxaTqLxKvrsHqSlR4uYfIBQNfe2UcGaVapTRKLfqmJ7VJm7t1qvNnAKCRZTCaBzddgmVxH0nCqS8B9SqEDMGgOuqb/Dk0AzNR8bCPValy6pfwHzNLJy9GtTI6LfvFeXr0ayG45LGIEpetgK4D0GM1S6Vptnwgw5WcQ7mrtq+05c5g9ujIDblc5nbQ6ZAqwh65Il1Py8IRbfpXJpRenrbZrXg1WfXeX5vSeFRHlU0qC8m2+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(54906003)(6916009)(8676002)(83380400001)(76116006)(316002)(64756008)(4326008)(5660300002)(86362001)(55016003)(66446008)(66476007)(26005)(33656002)(55236004)(2906002)(38100700002)(38070700005)(8936002)(71200400001)(66556008)(66946007)(82960400001)(52536014)(508600001)(122000001)(53546011)(9686003)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU91M2k2M1IxMkNiYis1MUVaazlDbndMLzRDa3dINmlGeGFCVzFNZHFuZDds?=
 =?utf-8?B?REc3Mjh5OGpld3ZrUHBnVmY5VlJ2a1pQR1UydStiOER1L0JySFg2ZzFjVS81?=
 =?utf-8?B?cjJGZUNtdkE1ZTN6MmpyY0RYWXMrcWdybEI1R0JBcWJLWXpHVUdMWG80N1Q4?=
 =?utf-8?B?RDF3eDZRZFRRNTQvR3dCZlFTcjNtRndCRE8wbk5wQmt4SHRPRWhlWkMydGpK?=
 =?utf-8?B?SW5QeVExZE1QYUxLVUErSlhxQzlrSHhnMm9IWWVmVVRVRlU4Nk91ckFReWty?=
 =?utf-8?B?RnZRVGZYTFBmR1BXYzdoSk1XWUNJVEpLdjNxNUFXWmdkaktFaSt0WVB3YmJn?=
 =?utf-8?B?eXFoZlZoM0luOC9PWFdOVkg2T0prVzY4NUxycWlkWEQyOSs0T3JPY2h2Tkg2?=
 =?utf-8?B?OThYMUh5UmxJY0hqK0NmWGZQZ0hvSlVlL3kwUjdNeU1TVGUxQzVNNEVyQVV0?=
 =?utf-8?B?TThsVXVkQXl4ZWpHVStpdDRXd0R3U2dsbStSQ0ZsdGc4U2FwcGVnelhxU0Iy?=
 =?utf-8?B?K0wwcXl3Ty9IVEhRMUZ1cVVFUkxBeUQ2Y0V4U015WGdkdEpvQVNKQjJwaHBx?=
 =?utf-8?B?ZnNFNWllc24rNEdTUWRoSGliOHFEMjRCZlR1aUVoK1MvYnY3dzVuUnZpMFRw?=
 =?utf-8?B?YTY0djlZNE94QUtmZ3JJL3NyUmNKRFl3SFdyZk1HTTc4MWV2TVVSYnAxQlB2?=
 =?utf-8?B?ODFtN2V5UWZ2d29meVl3TkZlU0s4aXpFTG0rM0JGTTM1QmZ2QXhLRDRmS0c5?=
 =?utf-8?B?RUl1bEJOWHoxTGorZGxrWmpXNjNYRThFL3R3QkdpcFRZQ1g4bEpPK0swVFg3?=
 =?utf-8?B?RWh3bXYzNFVYUnc3K0xSb0w2S3JneUw0Y01FMGN1UXdjVjFOc3ZqcmNHK2dt?=
 =?utf-8?B?N1R3U0QwYlAwRmZBOENiZS9IOGd3MnNCT3F5RUdHYjNkaDl0RWJtamhOZVpn?=
 =?utf-8?B?YlRrT2FRcmhEK2xpRWcxSDdqb2ZZVEZMQ1RpR3lJNUg3cFhYSXZscWIzQUR5?=
 =?utf-8?B?NWQ2aWxRazlybWl2YUc3SW5kd2dNNzF4a1ZQRmh3RjZJYTVIYzNvSVFWTFJx?=
 =?utf-8?B?VnNhUnZhSnNYaVJOZWVUcU5nSlFsOVNVVWt0d2FzWWNaa21vTDJHNEsrbFRE?=
 =?utf-8?B?OFYwZ05kdzdSdlgwL1FuRXRRTUx5VFVnL1VCenMyY3RTS2FRRmJuMG1KcnRY?=
 =?utf-8?B?R1B4cGk1OUFKK21yV09NUDB2Yy81UWJlYzlySUl1UDlnQjhXQXlwK3JXQVhN?=
 =?utf-8?B?Z0NJQmtkaDJJZkdUWW9zY2RFc0RqYVJib0NKcE5ueWIyMUptNXJldHJGZU5s?=
 =?utf-8?B?ZWpoeXBqVVZjK2czcERUVEZsQ1UyV0xjaW1tVFBucEhGZlREZGFYTmhwWjcz?=
 =?utf-8?B?M1lwU2J3WEhXc3RvSEVjbU1wS0krNUxnWktCcnE3eFl6M0ZzV2VpWmF1TXc5?=
 =?utf-8?B?dVAwc3NqaE9NYk5FY1hjd2NvU1dvYWNxZzZIdnZYSnphSXpZeHp6TXhLdjlN?=
 =?utf-8?B?YnNicU5WNDk0RFVxbU1uK0drckZldW1IVHloZ2xXcndUZHZyMFBaWmgyNkRw?=
 =?utf-8?B?Q0RwNUkwMko1N3ZSMGtEZE1yVXg2cHZDTDZKbkZkUHFrN2lkaVVCTzhmZHZW?=
 =?utf-8?B?bXRnbndDWGdVajJHOHhPd054NmtQbmJSUkNPYlZyZ3dKRDJmSmtkbGFoL09i?=
 =?utf-8?B?OXM3b0s5TTJhRzRSeUd6QmxYb2hyQnpYL2Qvd1hkQ3hRalA1OC93d3h1V25S?=
 =?utf-8?B?SlhZeUNHWXk1a1A1eFJMVGF3d1lydCszdzVuVzJOWUp2dzlUYTR4VmlIMVNI?=
 =?utf-8?B?aVYrUEFBQm4za1RSWURCVjNHbE5ETktKVjNkeHZveWdZSUpwNVcyMFlvb2Jv?=
 =?utf-8?B?NnpxZlRLTzRFUVJjU3BiUE1RZTZCMmNlY3QxRzkzVHJpWFk5R1FqYjdJdk84?=
 =?utf-8?B?YlhzU3Q3OGJzWWRIbmlZTlRDZ01kd1Z0cndPdlIxVlFyZU5LaVVVcmxDTkJq?=
 =?utf-8?B?d2ZKVk9ZZWFiVlRpaExQU3g1aG9LRjEwVTJhQ2FMRVo0Zlh1UXdIWmZOTWJD?=
 =?utf-8?B?eFEvUkNvLzM2L0JTMUhwK1NSZnAvbHJsVTZ4NWQ4Wm5vUjlZOGl0K3N4QTNL?=
 =?utf-8?B?b1BzdEc2bEVQQmdRczVlN1U4Kzlhc2RYSll5SHlmMnZjN2QzS205dnJwYVZ2?=
 =?utf-8?B?RjkvWWRabVcyajMvdGxldlZ4d29OYUpMVXhLemNPSlVDZDhQUmRjVUVGUnlk?=
 =?utf-8?B?bGFHUllJMTVJNXh2YVY3NTM0NnlPVFNMNmtkb3VoZk9vRkdTOWhTR09DbnBM?=
 =?utf-8?B?eEdPWDBrMDZzVmIzSTRUeHFtNjVBa29MV0tRRHlydVgyRk5RU0R1dz09?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a30164-19da-4306-664e-08da129c6e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 22:27:10.2957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 42PKFM77cYe4ICGYkNdzEGcrpZi5KWC/Hmru8M3rvBt7LV30IRv2KOa1t9o3q/qY4BQ9CRvK40F7iafHFyj+2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1962
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: yk_BYZMnbBQGdNVRQ4nqIFQBPRrKPQKa
X-Proofpoint-GUID: yk_BYZMnbBQGdNVRQ4nqIFQBPRrKPQKa
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_06,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300108
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBcm5kIEJlcmdtYW5uIFttYWls
dG86YXJuZEBhcm5kYi5kZV0gDQpTZW50OiBUdWVzZGF5LCBNYXJjaCAyOSwgMjAyMiA0OjEzIFBN
DQpUbzogSGF3a2lucywgTmljayA8bmljay5oYXdraW5zQGhwZS5jb20+DQpDYzogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBjYW5vbmljYWwuY29tPjsgVmVyZHVuLCBK
ZWFuLU1hcmllIDx2ZXJkdW5AaHBlLmNvbT47IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+
OyBPbG9mIEpvaGFuc3NvbiA8b2xvZkBsaXhvbS5uZXQ+OyBzb2NAa2VybmVsLm9yZzsgUm9iIEhl
cnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDkvMTBdIGFyY2g6IGFybTogYm9vdDog
ZHRzOiBJbnRyb2R1Y2UgSFBFIEdYUCBEZXZpY2UgdHJlZQ0KDQpPbiBUdWUsIE1hciAyOSwgMjAy
MiBhdCA5OjM4IFBNIEhhd2tpbnMsIE5pY2sgPG5pY2suaGF3a2luc0BocGUuY29tPj4gd3JvdGU6
DQoNCj4+IEkgYW0gaW4gdGhlIHByb2Nlc3Mgb2YgcmV3cml0aW5nIHRoZSB0aW1lciBkcml2ZXIg
Zm9yIExpbnV4IGJ1dCBoYXZlIGhpdCBhIGRpbGVtbWEgYW5kIEkgYW0gbG9va2luZyBmb3Igc29t
ZSBkaXJlY3Rpb24uIFRoZSByZWdpc3RlcnMgdGhhdCByZXByZXNlbnQgdGhlIHdhdGNoZG9nIHRp
bWVyLCBhbmQgdGltZXIgYWxsIGxheSBpbiB0aGUgc2FtZSByZWdpc3RlciByZWdpb24gYW5kIHRo
ZXkgYXJlIHNwcmVhZCBvdXQgdG8gdGhlIHBvaW50IHdoZXJlIHRoZXJlIGFyZSBvdGhlciBjb250
cm9scyAgaW4gdGhlIHNhbWUgYXJlYS4NCj4NCj4+IEZvciBpbnN0YW5jZSB3aXRoIG91ciB3YXRj
aGRvZyBjb250cm9scyB3ZSBoYXZlOg0KPg0KPj4gQDkwIHRoZSBjb3VudGRvd24gdmFsdWUNCj4+
IEA5NiB0aGUgY29uZmlndXJhdGlvbg0KPg0KPj4gQW5kIGZvciBvdXIgdGltZXIgd2UgaGF2ZToN
Cj4+IEA4MCB0aGUgY291bnRkb3duIHZhbHVlDQo+PiBAOTQgdGhlIGNvbmZpZ3VyYXRpb24NCj4+
IEA4OCB0aGlzIGlzIGFjdHVhbGx5IG91ciB0aW1lc3RhbXAgcmVnaXN0ZXIgYnV0IGlzIGJlaW5n
IGluY2x1ZGVkIGluIHdpdGggdGhlIHRpbWVyIGRyaXZlciBjdXJyZW50bHkgdG8gY2FsbCBjbG9j
a3NvdXJjZV9tbWlvX2luaXQuDQo+DQo+PiBXaGF0IHdvdWxkIGJlIHlvdXIgcmVjb21tZW5kYXRp
b24gZm9yIHRoaXM/IEkgd2FzIGNvbnNpZGVyaW5nIGNyZWF0aW5nIGEgZ3hwLWNsb2NrIHRoYXQg
c3BlY2lmaWNhbGx5IHBvaW50cyBhdCB0aGUgdGltZXN0YW1wIHJlZ2lzdGVyIGJ1dCBJIHN0aWxs
IGhhdmUgdGhlIGlzc3VlIHdpdGggZ3hwLXRpbWVyIGFuZCBneHAtd2R0IGJlaW5nIHNwcmVhZCBh
Y3Jvc3MgdGhlIHNhbWUgYXJlYSBvZiByZWdpc3RlcnMuDQoNCj4gSSB0aGluayB0aGlzIGlzIG1v
c3QgY29tbW9ubHkgZG9uZSB1c2luZyBhICdzeXNjb24nIG5vZGUsIGhhdmUgYSBsb29rIGF0IHRo
ZSBmaWxlcyBsaXN0ZWQgYnkNCg0KSSBmb3VuZCBhbiBleGFtcGxlIGFuZCBjb3BpZWQgaXQgYWx0
aG91Z2ggSSBoYXZlIGEgY291cGxlIHF1ZXN0aW9ucyB3aGVuIGl0IGNvbWVzIHRvIGFjdHVhbGx5
IGNvZGluZyBpdC4gQ2FuIHRoYXQgYmUgaGVyZSBvciBzaG91bGQgSSBwb3N0IHRoZXNlIHF1ZXN0
aW9ucyBpbiB0aGUgcGF0Y2ggdGhhdCBhY3R1YWxseSBjb25jZXJuIHRoZSBmaWxlPw0KDQpzdDog
dGltZXJAODAgew0KCWNvbXBhdGlibGUgPSAiaHBlLGd4cC10aW1lciIsInN5c2NvbiIsInNpbXBs
ZS1tZmQiOw0KCXJlZyA9IDwweDgwIDB4MTY+Ow0KCWludGVycnVwdHMgPSA8MD47DQoJaW50ZXJy
dXB0LXBhcmVudCA9IDwmdmljMD47DQoJY2xvY2tzID0gPCZwcHVjbGs+Ow0KCWNsb2NrLW5hbWVz
ID0gInBwdWNsayI7DQoJY2xvY2stZnJlcXVlbmN5ID0gPDQwMDAwMDAwMD47DQoNCgl3YXRjaGRv
ZyB7DQoJCWNvbXBhdGlibGUgPSAiaHBlLGd4cC13ZHQiOw0KCX07DQogfTsNCg0KVGhhbmtzLA0K
DQotTmljayBIYXdraW5zDQo=

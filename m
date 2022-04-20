Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF70F508CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380387AbiDTQLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380380AbiDTQL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:11:29 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7694731DD8;
        Wed, 20 Apr 2022 09:08:42 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KEWq7N027644;
        Wed, 20 Apr 2022 16:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=AEbkXteE5+vXzDUal952IYG8lqkutm7ltYppebn6vT4=;
 b=H0XOA3QEKn3xpWkyzq2s/mKWtF4RwlNHNPB7vHu5E8tIqyG8dt6HFaJtlChasmh05ugC
 fN/ow+17rb4J9dJdvwzZG1ElrInuCWmjItJ+UjUTqEryBGD3Npkfjamn00FARxfPRYGE
 uFn4fdONbD2lFWpmYNoh50K4eXFaV1DGTextv20kJwzj3f12MzkTOb18+o6tEokoQ8ZM
 QgVpn9sVFOadDwOGQh9zY3hVSbZMb+EvksYyzcRdgL8K1V8oyhhEMdBB423i591vH829
 rE4GZCK3YZtl5wePUestn87sVEh1ni0AOuV4KKlKN4MwnEmzJAIX2ZJ/Q8LXTvAoqa8r 5w== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fjm1k8yxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 16:08:24 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id F320413161;
        Wed, 20 Apr 2022 16:08:21 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Apr 2022 04:08:09 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 20 Apr 2022 04:08:09 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Apr 2022 16:08:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhEGxn16h5n56sAaV93YlFEAq7i7biaHI9uHW+tF+ITtu33dJzoEhJzI9LFtRADYYK7X6tTeOdetSeqHNHmvDU3ymwA3j/XmU4FoNTmUOfoFHhpTqiGK382PD5Uzix7RUsz9WCc+fZClxPvPMf13BkzrJVYgEc1RBkY5QXvQY5b7mDhlB0lohATaHvs3Bc1NT0B8DhF+MgnesEtnB0aY2Ocl/FziaRN7qQgjIQtChSuJgWtAzslp+2VZySHfalhpjIk5L3Wp2zsm5Ldbh0ACoKwv3UZsPfK8aA1m9koUbAFXqYQvT7XOiehnhMQJt1ClENKta5DWN8e6QY3QDv0cWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEbkXteE5+vXzDUal952IYG8lqkutm7ltYppebn6vT4=;
 b=KaRPeBZbr29Gsvc5FQswNnYlpKWKwkghWaku8GJsc8djdAllRq/40MkrBjR4W9N80ozybmLYoMwR15mMRdAQfuyGQ+VMlAGVfVv+esxfahA5Nn8vtHIzJ8jGqDFH5++ti2t8uZ+t+KDwuKFXxaCn5Rzg3h8/iIxs6OrGgfAPiuRsbsL1po3rTehl5cnvYQcwi7q2MNIrijSLmaSr5Fpc5XkqkObO130MkUU5KLziKUGXa73yoPCUa41YrMBrrGpcA8LTxfPlDW0XhfWh++d8I97EplnaGY4RWA0nXO7iMiLJURBWBNPebbmoyViki11+57JzMnYsnmRPhXBAGxOV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by PH7PR84MB1677.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:150::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 16:08:08 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 16:08:08 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Harders, Nick" <nicholas.harders@hpe.com>,
        "joel@jms.id.au" <joel@jms.id.au>, "arnd@arndb.de" <arnd@arndb.de>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog
 timer binding
Thread-Topic: [PATCH v4 06/11] dt-bindings: watchdog: Add HPE GXP Watchdog
 timer binding
Thread-Index: AQHYVMdYBHOjKisUtU6pCrQgRrNbl6z48/GAgAABmUA=
Date:   Wed, 20 Apr 2022 16:08:07 +0000
Message-ID: <PH0PR84MB17181A87E72D66C7F669F90288F59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
 <20220420150156.47405-6-nick.hawkins@hpe.com>
 <7d039d13-8512-29a8-31d1-48284d561bf0@roeck-us.net>
In-Reply-To: <7d039d13-8512-29a8-31d1-48284d561bf0@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dfe8cb5-e026-4b36-e1a3-08da22e7f5b1
x-ms-traffictypediagnostic: PH7PR84MB1677:EE_
x-microsoft-antispam-prvs: <PH7PR84MB16775298A999348F2D61F61B88F59@PH7PR84MB1677.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V0r/gBHsMqugXpG7JxPNLx6Kq0wAaJaV75SFX4bm3Rb2HMP+X/obxUowALmMSXuazc23ez+XZklW6WdMQPeNJjmztAw+vHBmG6HpNz007dpZRp26sIn4t9UIDM0FjwkdOr4L3+sm5mOMIsJtMO4h63HI78nPsbRQ5PEPKrLapZsXGTVNdpUTaUZBd19wXzc+LMb8rvzScpxtGnIhhsmdHAfz54VeS/Lkt2suriYj20U8PmY/do+xDHBsZW27wHAfXU9+VtfCHyAdEA4YApvHtIZHSGNZd5Nib+MCsHlI1Fp5qMgQwpQEjMx0hj9V0h5Yzu6OtSPcI961lBbQJGqFm1ggpp6NIkdUdnQnszpM4glKadtbZcRhHBgQFgLSnss//06A6LJIxfhcDYjrUQgn5WqsI0Om2qKuPq68SSjha3M3xAMzhub0yzuuRR16L6UvZnhPAw42z1gc/1cRINb7+ju1+AwWPxinNBNUOMeBPIShcmP7lt0Y1RFwqtopRLz8gM+/0VaAGImJ/ctZwgob68CSFpdq09E/77IhpYI0Wqk38AUsnsbFur51PJkK/Vw7y4ujl3PLgg4tWAZUinqZCcY0X11p07NDjPYhOq5UwIvaQopgXa4B5Xc3eKr4Z4d4mXRDqUouxkf/Hzs8pKjzzB5dRkH3v/HcAm9T6sowxCULRxa82VPnqfXmYXR0HlI05r01waCYbeNzvgi+SgMcxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(26005)(7696005)(6506007)(82960400001)(53546011)(38070700005)(52536014)(5660300002)(508600001)(2906002)(8936002)(9686003)(4744005)(33656002)(122000001)(186003)(86362001)(64756008)(66446008)(83380400001)(55016003)(4326008)(71200400001)(8676002)(110136005)(316002)(66946007)(54906003)(76116006)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDMvWmFneHZ5aWdZNmh1UzFqZXd5MzVHV0RvYUMvRjZUYWlTajJwRll5SFNG?=
 =?utf-8?B?ZThqNk9PVVhNNHFrb2pPOFB4VzNUS1JTTEZ6WnhJNTJ3NFUvNVZrZDVFTGo5?=
 =?utf-8?B?eWpEeUNRME9yQzZnc21tMG5wRFlvZGdwMFY3SFBqU3NsM0c3ZzRzMmRtYzY1?=
 =?utf-8?B?aitmK2laVFVFcFB5ODZxNnB1S3A4MHk2cUZBY05QNFJPQXJEbG5HVndGNHlM?=
 =?utf-8?B?UE5ZVnpQa083TThjSEhmUS9tNzlFR3BMbCtjTnBKSVFESmJNaVREYjIzZ09m?=
 =?utf-8?B?dEZJSGw0MTFlMHd3VXRhTlV3d0J1bUh2MktLZG8zdVBJeHBZTEI1MldPTW40?=
 =?utf-8?B?c3BLcVhITGJMTTdvdE9USWplQjZTaWs4UEM1VUMrNHFrMW8rL1BhYTlqZWtp?=
 =?utf-8?B?MXRucFJ0TVh3ZlM3VjNoNTRzZWFnTlJnVW1GTG5ZWUlqbFR4VzREMlU4N2l2?=
 =?utf-8?B?NDI1MVJoMWFibWgvblFXamR2MklGdzJxZmtHeitVclZ3Z2l0QkJickRsR1hM?=
 =?utf-8?B?Q2ZMaVo3a2xUakZCMzFzbkxjOCtSUXZqUG5sbFhwUTB4VEdlSGRCcEo4L2xB?=
 =?utf-8?B?M3l6MGJSMFI0N0dIZmNBOEpLMHBEb0swOUhIWXdSazNyK0FwUS83ZXNRV1Vo?=
 =?utf-8?B?SDlTdkxRVUJaemp1aitoZlJ5elU3TldYL2hZdVFEalRuSkhLc2c3SXNSQ0Ju?=
 =?utf-8?B?VHAxdmd4UkJURWdYQmlXeUxlTTM3eTk3SmdEUmFlczR6MkdwVjZzQU5OTlNo?=
 =?utf-8?B?NGYyWDV5a0dLblF2Mjc3dExkTldpQi83bHJMSmUwY3B3bUhtN1pQNmpZMEdG?=
 =?utf-8?B?eEg0QmxvV2VMM1BicE1XNDgydDRCMWtkcnVCckZTUVdQNWNhZENhYS9xSm8w?=
 =?utf-8?B?amtQamlvelc0d1JEN282UG84YzV5M0diaTR6ck80SWlJVUhqbzM5VDVJdW4w?=
 =?utf-8?B?MFJ3RGFvbmtBbHcrbWFzYWdVZVYrcVAxQVlNMmYvMnkxMy9vRFg0QVFjSE45?=
 =?utf-8?B?YmJrOXVhRzZoVWk2d3ZYSTExTERTaXl2ajhnckdOdUQwcGpEcHRwandqS0Iv?=
 =?utf-8?B?S2pTSVR1cVFCQ0U2Y0hQMDc5b3FrNnJRcFpMWXJrOXdNN1lIdHVSeXZYT21u?=
 =?utf-8?B?dFpWeFN4MnRFUUx5UDAreGEzV3Byd0Nrb1RaRGtFaHR6R1djSENGZDR5UFpx?=
 =?utf-8?B?Zm9RT25WdkRjbXVyelJ5aXFYbmtBeWVINjhNUmVldDJVRVdkdjlMTExSZjBa?=
 =?utf-8?B?SElFQ1NjOXZCVHg5bG5iUnlWN01uM002K2h1Y3cxVjRUVHI5U0t4WGgxbGVK?=
 =?utf-8?B?Y2FwdFRjdWJyaW9FZE13dTBCWWFVTkUxS2JDMWZDcUF3aG5jd09DTU1SMHdm?=
 =?utf-8?B?a3VjSjdSNDhrTWtzZmRlRmZEOXFrdWdPK25ubDVjSUxpSktHSVlDYXA0WGYx?=
 =?utf-8?B?VVhCMnZ3cEZJaHhoblpONmdUN0hwMjhZc21PU2R5RWUvVDR4K3B2dDJSOHV1?=
 =?utf-8?B?STM4bU5ZMUNiQTNxaHIwQU1vZllYYlVWNTZTdnNUUjRVVklncVB2d2xraFdF?=
 =?utf-8?B?aEl6eVkxRkFxbGs4L0VwMndzK3JURG5LN2g2YmQzRFl2TjQwbkR3LzN2S3Yz?=
 =?utf-8?B?eGIvV252RnppRG9wcURRb0xQeHJCVlVvMlFSOTMyNzNhYXFBNjF0VkkrazVY?=
 =?utf-8?B?QnRWbFZpbjRObWxVN204L0hLNi9sWHBiRm4zc21Qak1FTHNEN3VPQVQwOXBV?=
 =?utf-8?B?ekNUUU1VUkhldVRHWTVJS2UxWnJtRm5NS3Yza0xWenc0N01WbmIxd2hnUGdO?=
 =?utf-8?B?YnV3dTZQWjl2L0lUc1NJaGwvbnR5V3B3dnZjOVYrTUw1ODB1UU9WOTlsd0RF?=
 =?utf-8?B?eG16STBJRVdYbm4weC84T2thK01mTTFWSDJnWEhLYW83ajE4LzQ4RXVETVJU?=
 =?utf-8?B?bFh4ZVlRQnJPT0pvcE9iemt4aTBKanNYTWRzNW1jNkM5dUFrY29rR1VXdWV6?=
 =?utf-8?B?NHlBaGRDWFhmc1pibXNzMUppa0EzcEJFUWpiRWdnMjVacHVZSlJ5RDU1dkFX?=
 =?utf-8?B?N2RubkZmeUR0aGsxcVVaMmNBdkdDUE4xdVM0ODk4N0hjTHRldHBZM2xWN3dI?=
 =?utf-8?B?b3UwWXcxeTdjbzFlb2ZxVzJtUGpwUWdzQTVVd0hKSitWV1FRUGdXaUxteE9I?=
 =?utf-8?B?dEJwZkR6K01tTjh1V25YeDQyMkdBZ29ySFJPNllaK0t4UnRnbDZiczZJOEd6?=
 =?utf-8?B?TDIwZzEvN0gyWlJEaU0wdTRuME0weDloZ2ZPSTdQcXJzcU1vT0Y2SHJuOWhz?=
 =?utf-8?Q?mjn7BguRCSyxqJ9quv?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfe8cb5-e026-4b36-e1a3-08da22e7f5b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 16:08:07.8598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4zaDDprwsloE6Y619R+UOy3xXGR4LurZEsN0QfTZsaJCv/icj1nsKxcJ6t0o1TUM34JGAmA68+y8gqbRVRdNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1677
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: mBaLjCBS3gBE-vGszIj7PQ--oU09XHWH
X-Proofpoint-GUID: mBaLjCBS3gBE-vGszIj7PQ--oU09XHWH
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200096
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBHdWVudGVyIFJvZWNrIFttYWls
dG86Z3JvZWNrN0BnbWFpbC5jb21dIE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQpTZW50OiBX
ZWRuZXNkYXksIEFwcmlsIDIwLCAyMDIyIDEwOjUzIEFNDQpUbzogSGF3a2lucywgTmljayA8bmlj
ay5oYXdraW5zQGhwZS5jb20+OyBWZXJkdW4sIEplYW4tTWFyaWUgPHZlcmR1bkBocGUuY29tPjsg
SGFyZGVycywgTmljayA8bmljaG9sYXMuaGFyZGVyc0BocGUuY29tPjsgam9lbEBqbXMuaWQuYXU7
IGFybmRAYXJuZGIuZGUNCkNjOiBXaW0gVmFuIFNlYnJvZWNrIDx3aW1AbGludXgtd2F0Y2hkb2cu
b3JnPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IGxpbnV4LXdhdGNoZG9nQHZn
ZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDYvMTFdIGR0LWJpbmRpbmdz
OiB3YXRjaGRvZzogQWRkIEhQRSBHWFAgV2F0Y2hkb2cgdGltZXIgYmluZGluZw0KDQpPbiA0LzIw
LzIyIDA4OjAxLCBuaWNrLmhhd2tpbnNAaHBlLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBOaWNrIEhh
d2tpbnMgPG5pY2suaGF3a2luc0BocGUuY29tPg0KPiA+IA0KPiA+IEFkZCB0aGUgaHBlIGd4cCB3
YXRjaGRvZyB0aW1lciBiaW5kaW5nIGhwZSxneHAtd2R0Lg0KPiA+IFRoaXMgd2lsbCBlbmFibGUg
c3VwcG9ydCBmb3IgdGhlIEhQRSBHWFAgV2F0Y2hkb2cNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBOaWNrIEhhd2tpbnMgPG5pY2suaGF3a2luc0BocGUuY29tPg0KPiA+DQo+ID4gLS0tDQo+ID4g
djI6DQoNCj4gdjMgYW5kIHY0IGNoYW5nZXMgYXJlIG1pc3NpbmcuDQoNCkkgY29uc2lkZXJlZCB0
aGlzIHRoZSBzZWNvbmQgYXR0ZW1wdCB3aXRoIGEgdmFsaWQgcGF0Y2hzZXQgYnV0IEkgd2lsbCBj
aGFuZ2UgdGhpcyB0byB2NCBhbmQgYWRkIHYzIHYyLiBTaG91bGQgSSBtYWtlIGEgdjUgdG8gc2F5
IEkgdXBkYXRlZCB0aGUgcGF0Y2ggbWVzc2FnZT8NCg0KUmVnYXJkcywNCg0KLU5pY2sNCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66935508E47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356067AbiDTRTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344220AbiDTRTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:19:07 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C2221812;
        Wed, 20 Apr 2022 10:16:16 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KFP2lx015902;
        Wed, 20 Apr 2022 17:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=pbopzz7D+1jynxKVY5+9kMSl0qHyP9WGTyQjlRF31hQ=;
 b=X8WkPanJeSkze7YvlBCCQMObGj3O+iW0iwtDRL69IcuXFVU4XFjmL51rkV38F3+2elVA
 Qipa77gIpRZkmz6UzrxcmsNB3gufXvAkZSJM50RhN0UqCHF2nkgkyz+c7FdrHL8JZqxt
 ITVydJPbpkJYEP5F+qLIwMnLsK45aFk1BqIYaD0n8hmAGcV/xizILgmRHp+QotN5RlJp
 HC+NVKRJlHFt8jXmxgOkFjQwf4k4P9dAjXIG3Xrb12hN+bMRmcv280sXAuBT8ZzxvBGO
 byrBKuzosIDssq+q/6Tq2QPef5ewmFHswn5Y5Pa8lbmbrpNVFdeqJomZw+zQ5ELOMiIc Gw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fjmsp8y40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 17:15:58 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id D73F313081;
        Wed, 20 Apr 2022 17:15:52 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Apr 2022 05:15:32 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Apr 2022 05:15:32 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 20 Apr 2022 05:15:32 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Apr 2022 05:15:27 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYoW46JadyCZ6LMPg2iCX6qnlocaKfJ/99wiNq2/tUtGKiht01x1Ch1kF+2FKZWAF3pz/xKHkEem1PBNLah/U/3/cSfISLlh6SWF3DDatNpvfO04RvIBB/owtwQKHfktAGomEpI4CU5VhGOaUU432bnKT9M5pf++CasaEXEvlWVsBgNormuyfrtXgbh+JVG0pu1vQ+brCt7eDab1m8Rpek7K+qBIkvUMIb3cGs+PqhtwHmQGeFg8qN0qs7rqIpE4/9aI5x/tI+nO5iWaSO26DiXtAiRgkAuW32EtLBrg7I1mBDXKpCZNAKzAQLMMP8/U3vPQdPbFGrmLKgAclT2Vog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pbopzz7D+1jynxKVY5+9kMSl0qHyP9WGTyQjlRF31hQ=;
 b=EqmbN7tN0wz0LoRV957el4WOPLXNUWSfcUA8o2m3PgjcClqQQmS3FP8i/dcyeDISLrRBKEJtB8kjKpEN3jJVlJdmkqoUyStMVEF6qMCQtQblVeOS/x54z9k0ictEcn43XfLeFQnmVsasex4pteOVHN+Tm0FKGveXNJTVEGcFDxpaqfF+WmwqTXFQCrgwWHx7cjKhahqQQsbuf6hMpx+Ehzk3qkv/DpZgKe2bsUA2slQ0DgLyWbVH8o/AwqNGhxP9y5ptCD8p7D7somzxI3KEQ8rKvD2VQf//hNBESRk79iVy/pdDTrtvzkkDCGlWrwezBZX8zuzN8kLBa72PU3W92w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by PH0PR84MB1646.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 17:15:26 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 17:15:26 +0000
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
Thread-Index: AQHYVMdYBHOjKisUtU6pCrQgRrNbl6z48/GAgAABmUCAAAqEAIAAClYQ
Date:   Wed, 20 Apr 2022 17:15:26 +0000
Message-ID: <PH0PR84MB1718C171E29974C8C176952388F59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
 <20220420150156.47405-6-nick.hawkins@hpe.com>
 <7d039d13-8512-29a8-31d1-48284d561bf0@roeck-us.net>
 <PH0PR84MB17181A87E72D66C7F669F90288F59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <d84f994d-e291-84d0-5576-571984cf5018@roeck-us.net>
In-Reply-To: <d84f994d-e291-84d0-5576-571984cf5018@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e554b548-8153-4c97-238b-08da22f15cf5
x-ms-traffictypediagnostic: PH0PR84MB1646:EE_
x-microsoft-antispam-prvs: <PH0PR84MB164664B0FA19FAF81DD9186388F59@PH0PR84MB1646.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Cz8wDIBTJOj5cPypKzcu5+B7xWQQnr2ByxTD9+zzzNlKpesMt07dbAABlRODn71UVt7fu3c+eoE78DwP+8COmfka645Cy/pAWKZGcTbw0U1f6Fff/nvFdcKIOFJAI0Mr/eSrUC9/OtFSDz9iRcipOo4NvGKc6hjFSqlvFMs73I+YzSkNwRAbX07SkuqrybdgAl+z8NAe8ZAdrwI4TSXyp5AwBq4YZ81gu0FKvAYmGjy3CqDOMYrmZgWXIt3LOS+1QsdGNu0/ekD4E2BULZZ97/pvMcxxDPrH6Bji+qFW/xLzRafExEj1vFk86F32Wk9b44R+STgPv1EZsVZ2MaGs5FaiOVza5VSyoUTkBJKzMqMftngMrfmZyIumcRv6m7XvBKzVyKl3YQb1KZJXzMjDi23cY0AiOcoX2mVowyEdEMZ8Sp8cteFalRpGfWTCQ5omZ/wv3XsKHuab9rfZBxg1An6/phmTisOOsCZIPxVUcez9QqRXRRLaJRfxIFqEhw9oedxd4LIkzXxEGPz5lwth7v6RLPsJaQHSvJ+vpAbT9LvZ+cgGtmcXqGS9O+rrYf1nvkccp+xbQS2DRuF7/7ZjLC8esBwRgJ9nfTBb3QYs9pTLlKLHCck/eOn3nSs+qQmLWH/cR8oNls2NNBSR664L9ZwXFhO7MzC5DS3q3wUextyhO4/NT3kSwFax5hhBZLXfPzh7U4owlclfIMEtZs6Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(26005)(83380400001)(55016003)(186003)(122000001)(71200400001)(110136005)(54906003)(76116006)(64756008)(4326008)(316002)(66476007)(66446008)(66556008)(66946007)(8676002)(9686003)(508600001)(6506007)(38100700002)(53546011)(8936002)(82960400001)(38070700005)(52536014)(2906002)(33656002)(5660300002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nyt5T1ZodHpFN2p2R1JFR2tsZ0hDY3JadzNIU29GU2FUOE92cS9XZGhjMGdR?=
 =?utf-8?B?d0xkYlBUa1FyN1hXTnNZSzBNeEk3Uk8rR3BaQU04TWdLN2gvNU01V2Y3SjUz?=
 =?utf-8?B?WGc5b3JNaElSdVNnU2hSOFozcDJiazlicnBnRUYwWUQ5Njlib0V0eUJIS2tU?=
 =?utf-8?B?RG1Jb0lKamdndHI3bk9QT1c2Qk03Sm4yc0l5R2o3YVVEeHZNUTg0UkNtZGxR?=
 =?utf-8?B?MnRoOGxpN0VHWGlYQWR4cml1ZEhENkRZUW1TY2ROSkgrQjdyNEpjY1gwWEcw?=
 =?utf-8?B?L0VFSUZIck13TDhHSWtDcEpNZFNqR1NVWnVzK2lhbEM1eXZ3VE5UVUE1RU52?=
 =?utf-8?B?czZwWTJWUmptVWJYSG1BYmNmMkF1dFBDUWt5MXFMQkdvMHR6V05tWHJsSkt0?=
 =?utf-8?B?dGgrR2pVczQ1TUJyaDZPZVVkQU9FUHB6YktSZ2F3VXhQZDZzTDhORVppRlI4?=
 =?utf-8?B?ZU9iTDlYbllEN3hRd0JxNEYxdXl5RUh1clBTZ3F1VjdUN1RKNXpnbjFkWXFq?=
 =?utf-8?B?YVNMYUxaYkxlZldOTjVrSE5IS2w3TENEMVFDUUFyM0xnOGNvekpmR281OTNC?=
 =?utf-8?B?SGZsNDlaamxwSHZhMFoyaG8vWTF3QUdzVS9WRGV6Ti80QkRlQ1RmL0NoMUtR?=
 =?utf-8?B?RnlGeGNPRU1sMVhWK0xmUVllNUhjM3dVTWRaRUpRenBJb1RFWmUvMEc0K2s0?=
 =?utf-8?B?UTg3SmY5YnAyem4vMkF3OWFuMkFyNC9ucFM1Mi9PYkJNbzdMcTdQeUdHN1lX?=
 =?utf-8?B?YkNSU3RHUnpTZWdlaGJWSHhBWVNyR0lZN0tmYnBMUDdxZmJ3clN2V0hhWGhn?=
 =?utf-8?B?M3VsbSttdlZWM2NUakVNK3lqaWFvK2pPT09IUm1zRjhnQmlLREZiMDUySXVn?=
 =?utf-8?B?OXRiNnFEY3VpMUVoK1RSL0VoUTE2ZmxkZFBLT1grSUxjTGlxbkNMajFnS3ZO?=
 =?utf-8?B?Umpob0xiMEYvTE1LZDZIMjFXVitUSi9VV0dxUlpmNE5QRnlRQmtUK1orSGJs?=
 =?utf-8?B?SXlmU1BHQmsxdWNxMlFxeVU4SDQxQzRZMEhmcmdzbDRra1E3R084bjZWakNR?=
 =?utf-8?B?SUlaSDhSSmZVcDkzb0h2QmFHaGV4Z3AvNnBZTWVqZnNWRkVnRkNjNkxaUnJK?=
 =?utf-8?B?ME5IVXZ0RkJrLzYvRERrSllBSUNkcmlxZ2tZV0Z6aDhreEcyOXRBSkUyVzNJ?=
 =?utf-8?B?eHVNbjYwQTR1N1hjeXNjTEZZQUV6UkpSME4rZDlkRGxaaDFGZ0tKR0FYVU9u?=
 =?utf-8?B?a25nUEE3SnpIdUExeHlBV2JidHoySUh1YUJYU1k0bHFIdHdvOTdaRXVSV05K?=
 =?utf-8?B?bTdqazd5eG1QRDczc0tLcmszRGFWYlpRWGIwV0JkZjlvejJDekZkSm0rMnRM?=
 =?utf-8?B?T1ZGQjNtVUpwaDNKQnRXNE9TSTBtaGQ4OUNCVWtPbHQvYzNpN2l1N0tySHB5?=
 =?utf-8?B?VENqSXFmZ3lHSDNSdklIT29LaGE4TUxxNGZQYUwvNU9XaG5kQytGT01LZlF4?=
 =?utf-8?B?L0VuVWg4OWowc0FlU0lMVzAyY3QxZTcxYjB3eVZFbUg5c28yUXM4ZnZmdmxv?=
 =?utf-8?B?NFA3bUdWbXhtNk5xZmhtU21lSG5sVDBYRW5zOWoySGVqamE0V09DbHlvaEYx?=
 =?utf-8?B?NDJmZFZBUWY2TVhvMEZySkd2MGNhcG5GNVFpT2YxczNSYm5tbFhSUktTVnZt?=
 =?utf-8?B?cW1sY1JVdkZOa2U5ekk1a3dKcmZOZFFtWGhUT1cwdFlWWnVmQ0g0YVhUT3Ro?=
 =?utf-8?B?R0pMRE9Td0JZZ21mLzFtakcrbWZkOHNSMDU2UG4yaVRCY1BIOTdLVW9vYlIv?=
 =?utf-8?B?UkRnbnVNTkJUUXhWbmsvZmtrakc2MzhXdnU3RmJTc3FnbitBSS9QTTY0Sk1U?=
 =?utf-8?B?bzN2UTBIVGNEYlB1QmM1b24zV0VHNXMweFRDdU1HSG9qYTh1YVIrMHVuL0Za?=
 =?utf-8?B?TzUvdUFHQkZjaE9uaTFDNm9HWU9acXVWTE5xS05OenRIWTZHK2hjWUt4ZmJS?=
 =?utf-8?B?VVJFUWFhWnJwYWg4VUVxbXU5dXVVNWk5MFZzeTZmUG1PU3BxSmFPbkR0QlVI?=
 =?utf-8?B?M3pDYVB1MDdWWXVHTWx6cjNSUFIySnJNNEEyVFBDUHQxS1h1M0ozYTdLWCtt?=
 =?utf-8?B?Q3UxZzNMaGJuT1YrMXhUZGRsZlYySEJ2QkJoamJmczdBMkJ4RHBUN3RuMDJH?=
 =?utf-8?B?UDFzSG1CSUh4MXFObklNTHBWakFEYmJxSDQxWmZZbjYrem9RQThWdkNKZU45?=
 =?utf-8?B?RHZLOGxETzVyaE1UOUQ2VVhhK25DdmZ5RDMzU1Jycm5CcVk4aFd0TnhFd3h2?=
 =?utf-8?Q?068mZcycNvPqrSWqjg?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e554b548-8153-4c97-238b-08da22f15cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 17:15:26.6661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1x2DaQ96TE7X6eIOTTKyBO/jCCF5rQlcODFr1gwOyE7SeDwnWu9NUZH9h12EMUV48gsCJZunDQi/eWJb+DYTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1646
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: coFByf_16x9PY1Z1k1twx36xIW_2V3Gd
X-Proofpoint-ORIG-GUID: coFByf_16x9PY1Z1k1twx36xIW_2V3Gd
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_05,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200102
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
ZWRuZXNkYXksIEFwcmlsIDIwLCAyMDIyIDExOjM3IEFNDQpUbzogSGF3a2lucywgTmljayA8bmlj
ay5oYXdraW5zQGhwZS5jb20+OyBWZXJkdW4sIEplYW4tTWFyaWUgPHZlcmR1bkBocGUuY29tPjsg
SGFyZGVycywgTmljayA8bmljaG9sYXMuaGFyZGVyc0BocGUuY29tPjsgam9lbEBqbXMuaWQuYXU7
IGFybmRAYXJuZGIuZGUNCkNjOiBXaW0gVmFuIFNlYnJvZWNrIDx3aW1AbGludXgtd2F0Y2hkb2cu
b3JnPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IGxpbnV4LXdhdGNoZG9nQHZn
ZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDYvMTFdIGR0LWJpbmRpbmdz
OiB3YXRjaGRvZzogQWRkIEhQRSBHWFAgV2F0Y2hkb2cgdGltZXIgYmluZGluZw0KDQpPbiA0LzIw
LzIyIDA5OjA4LCBIYXdraW5zLCBOaWNrIHdyb3RlOg0KPiANCj4gDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEd1ZW50ZXIgUm9lY2sgW21haWx0bzpncm9lY2s3QGdtYWls
LmNvbV0gT24gQmVoYWxmIE9mIEd1ZW50ZXIgDQo+IFJvZWNrDQo+IFNlbnQ6IFdlZG5lc2RheSwg
QXByaWwgMjAsIDIwMjIgMTA6NTMgQU0NCj4gVG86IEhhd2tpbnMsIE5pY2sgPG5pY2suaGF3a2lu
c0BocGUuY29tPjsgVmVyZHVuLCBKZWFuLU1hcmllIA0KPiA8dmVyZHVuQGhwZS5jb20+OyBIYXJk
ZXJzLCBOaWNrIDxuaWNob2xhcy5oYXJkZXJzQGhwZS5jb20+OyANCj4gam9lbEBqbXMuaWQuYXU7
IGFybmRAYXJuZGIuZGUNCj4gQ2M6IFdpbSBWYW4gU2Vicm9lY2sgPHdpbUBsaW51eC13YXRjaGRv
Zy5vcmc+OyBSb2IgSGVycmluZyANCj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IGxpbnV4LXdhdGNo
ZG9nQHZnZXIua2VybmVsLm9yZzsgDQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDYvMTFd
IGR0LWJpbmRpbmdzOiB3YXRjaGRvZzogQWRkIEhQRSBHWFAgDQo+IFdhdGNoZG9nIHRpbWVyIGJp
bmRpbmcNCj4gDQo+IE9uIDQvMjAvMjIgMDg6MDEsIG5pY2suaGF3a2luc0BocGUuY29tIHdyb3Rl
Og0KPj4+IEZyb206IE5pY2sgSGF3a2lucyA8bmljay5oYXdraW5zQGhwZS5jb20+DQo+Pj4NCj4+
PiBBZGQgdGhlIGhwZSBneHAgd2F0Y2hkb2cgdGltZXIgYmluZGluZyBocGUsZ3hwLXdkdC4NCj4+
PiBUaGlzIHdpbGwgZW5hYmxlIHN1cHBvcnQgZm9yIHRoZSBIUEUgR1hQIFdhdGNoZG9nDQo+Pj4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBOaWNrIEhhd2tpbnMgPG5pY2suaGF3a2luc0BocGUuY29tPg0K
Pj4+DQo+Pj4gLS0tDQo+Pj4gdjI6DQo+IA0KPj4gdjMgYW5kIHY0IGNoYW5nZXMgYXJlIG1pc3Np
bmcuDQo+IA0KPiBJIGNvbnNpZGVyZWQgdGhpcyB0aGUgc2Vjb25kIGF0dGVtcHQgd2l0aCBhIHZh
bGlkIHBhdGNoc2V0IGJ1dCBJIHdpbGwgY2hhbmdlIHRoaXMgdG8gdjQgYW5kIGFkZCB2MyB2Mi4g
U2hvdWxkIEkgbWFrZSBhIHY1IHRvIHNheSBJIHVwZGF0ZWQgdGhlIHBhdGNoIG1lc3NhZ2U/DQo+
IA0KDQo+IFNvcnJ5LCBJIGNhbid0IHBhcnNlIHlvdXIgc3RhdGVtZW50LiBJZiB0aGVyZSB3YXMg
bm8gY2hhbmdlIGluIHYzIGFuZCB2NCwgdGhlIGNoYW5nZSBsb2cgZm9yIHYzIGFuZCB2NCBzaG91
bGQgc2F5ICJubyBjaGFuZ2VzIGluIHYzIGFuZCB2NCIuDQo+IElmIHRoZSBjaGFuZ2VzIHdlcmUg
bWFkZSBpbiB2MyBhbmQvb3IgdjQsIHRoZSBjaGFuZ2UgbG9nIHNob3VsZCBzYXkgdGhhdC4NCj4g
SWYgdGhlIHBhdGNoIHdhcyBhZGRlZCBpbiB2Mi92My92NCwgdGhlIGNoYW5nZSBsb2cgc2hvdWxk
IHNheSB0aGF0Lg0KPiBFaXRoZXIgY2FzZSwgdGhlIGxhc3QgdmVyc2lvbiBpbiB0aGUgY2hhbmdl
IGxvZyBzaG91bGQgbWF0Y2ggdGhlIHZlcnNpb24gaW4gdGhlIHN1YmplY3QuIFJldmlld2VycyB3
b24ndCBvdGhlcndpc2Uga25vdyBob3cgdG8gbWF0Y2ggdGhlIHBhdGNoIHZlcnNpb24gd2l0aCB0
aGUgY2hhbmdlIGxvZy4gVGhleSB3aWxsIGhhdmUgdG8gZGlnIHVwIHYxLi52MyB0byBjb21wYXJl
IHRoZSB2ZXJzaW9ucyBhbmQgZmluZCB0aGF0IG91dCB3aGF0IGV4YWN0bHkgY2hhbmdlZCB3aGVy
ZSAoYW5kIHdoeSkuDQo+IEluIG15IGNhc2UsIHRoYXQgY29tbW9ubHkgdHJhbnNsYXRlcyB0byAi
bW92ZSBwYXRjaCB0byB0aGUgZW5kIG9mIG15IHJldmlldyBxdWV1ZSIgYmVjYXVzZSBJIGp1c3Qg
ZG9uJ3QgaGF2ZSB0aGUgdGltZSB0byBkbyB0aGF0Lg0KDQpVbmRlcnN0b29kLCBJIGhhdmUgZ29u
ZSB0aHJvdWdoIHRoZSBlbnRpcmUgcGF0Y2hzZXQgYW5kIHVwZGF0ZWQgdmVyc2lvbnMgdG8gYmUg
aW4gbGluZSB3aXRoIHRoZSBwYXRjaHNldCB2ZXJzaW9uIG51bWJlci4gVGhlIHBsYWNlcyB3aGVy
ZSBubyBjaGFuZ2VzIHdlcmUgbWFkZSBJIGhhdmUgcHV0IG5vIGNoYW5nZXMuDQoNClRoYW5rcyBm
b3IgdGhlIGZlZWRiYWNrLA0KDQotTmljaw0K

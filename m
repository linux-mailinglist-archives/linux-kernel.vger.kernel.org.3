Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823424D06DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbiCGSuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiCGSuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:50:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58603674D1;
        Mon,  7 Mar 2022 10:49:19 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227ITDwR010017;
        Mon, 7 Mar 2022 18:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+mcVh6K5Awlkdwf/+ABEK70vEOy2Ow7i6woe3P/m/QA=;
 b=wvW9kwuVnjNRSxSdxx7F6BiPxQ+cAQaChvAiCP6S379kINptCIfjVV7Lr8ife5YrxAAd
 BXhIWH/Y/pJ9MPR2ti7K+rCTspNkCnI3V4L6F3I+y/MLfMQ/PTvolf4/3AyTEoALsOAz
 UUxR7ICOwtfKYMa1ONYZgLVXLU+1NpamPp4pBzmY3gpYdHVKYQ4RQxM2eZdzF1aPuj+V
 mcyS+JhyMFiCLT1wVJZ0rzyqUXfa/2M1zwrSzWIa1/T3Ah0ztgR7TxzUGGMbNnfAQNcu
 /TLTdFBCeCzGkWi0IYrlwu58JIxrOSgqxcfir/7Uz59Od+etMpucY+GIMN8BR9WH52h9 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3em0dtvtv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 18:48:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227IeAUS041515;
        Mon, 7 Mar 2022 18:48:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3020.oracle.com with ESMTP id 3em1aj9xjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 18:48:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt15XLacmk5V2Ff+eSTBziidY9alFGVnWS0lzFHKJnbK+NjwDus1AnIzZQqWl8NgLuoa4E5sbpNsLQ0nLI/yAQjADIJJq3NgbyvLIfUhEH03lDT+C5yhvkqem4YyVYXHImRfdig6+I31uwO2Zy4fuN8+pxt7l55sybVLExvWCJN73L5ali8ZUPo5n6XK/PoMUdCEWTI/zsWM3xmHwwYiC9U8Fpdlqj8aGS2Od7BbaUi9ydNs6/WRcm/4eO0woMXsy/GghMd+ouW7DGPjzgoh8X7rrvNxAtEhAk7GFAOZS0r3++lgwZx2LFjpkLDTUCsiTXw3owlPuV7cH+9Kp4J54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mcVh6K5Awlkdwf/+ABEK70vEOy2Ow7i6woe3P/m/QA=;
 b=DexYEfuC3qhIyuwhqy0k3krloVvjriJ1An4IhzMOlM4JaPcAvjOFh/au1HAAeM1EDKCGa6jejIbTDFXg+kjPQ8iG59o6atyeOSEwnGtOQ8OXm4lThCWxlaTGtvfkz8+Zc55VFHtXHVGaFnbEUpRXGKhlA7RYKfgdwv8KY1Y/h2VCOYevkLRUpy02wpu72dEV/gpgaSDQLUpdtSknUwjqFgnxdP7kPp4zaJLrujFdu7VdpEZHjEEKCUYLVyZDicu7enKC0CK0O5v5YLV4gYlWfXMjsh+UFf7zTrFwazmYmLBnm0PxPnJ3hRe/KWGI65zyGsLKXOsvCf/PcS6Pt/sksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mcVh6K5Awlkdwf/+ABEK70vEOy2Ow7i6woe3P/m/QA=;
 b=QG5LAACr6tpJuYXq22SjPpU2gJkfqiEsPy27pInqlTFObTJ6rLgXcnQhRi552AuSTRpdTAX66eLr5anknGDqyZPc/Bu5FdHdkD6JDzxZt6U+HacTPhyPHs3ivQpqorTpyQ1rGbhKMUbKLJ7Q+ZvhjuVKKbMi8BI/1lUHXeQTTEg=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN6PR10MB1316.namprd10.prod.outlook.com (2603:10b6:404:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.26; Mon, 7 Mar
 2022 18:48:33 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a8c4:c418:5d49:fe1a%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 18:48:33 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "mic@linux.microsoft.com" <mic@linux.microsoft.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 4/4] integrity: CA enforcement in machine keyring
Thread-Topic: [PATCH 4/4] integrity: CA enforcement in machine keyring
Thread-Index: AQHYLZNB/4y9NCkFlkOR37jouCPamKyv4ZWAgARhOoCAAAahAIAAA0qA
Date:   Mon, 7 Mar 2022 18:48:33 +0000
Message-ID: <07C3792F-2567-4415-AD2F-DC25C63300D0@oracle.com>
References: <20220301173651.3435350-1-eric.snowberg@oracle.com>
 <20220301173651.3435350-5-eric.snowberg@oracle.com>
 <59f08890-f3f9-43fe-e1cc-6648071e33e0@linux.ibm.com>
 <64A87331-C97E-4565-B222-9BF7208E5010@oracle.com>
 <571dbcce-e97f-fe4b-fdff-34f84a43e1a8@linux.ibm.com>
In-Reply-To: <571dbcce-e97f-fe4b-fdff-34f84a43e1a8@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37a42b80-6041-4161-ba88-08da006b149a
x-ms-traffictypediagnostic: BN6PR10MB1316:EE_
x-microsoft-antispam-prvs: <BN6PR10MB1316C91CB0D4B568EC0A3B8287089@BN6PR10MB1316.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gh7VMDQ4iW4FI7qEw4Ay/M9BXEwbZOh7RX5CD9CppKTa9ezrwZ+S7bOc645gb1O3Y7WCr4aZF0LIcrI8/dJOCbRf1voSWf890RrPgoSOVAAF4/jqnV7sVyZqI98znJhuaKQfHw26828xd9WKz95Vih48hXmBO2+CzO4m/AvsJfHXxYKSMi+e2TMmYbi6cd/xEIBW7Hn+jrmmYp2V2fCD8IsheltR1S+POHBJoLSoI+O8zGDBxl3TwHvqNCobRvxwggGH6H8FhZCpd43JZ7yyqyHkq01NjG74OA7tnb78zPoW2dvAiWGqfbCzsi1MXlT3U3siGIfjHAetzr2JW/pa8dkbKaiTAhWBS1iSf+1Tud8Puo5UO7EDN/ESOzk0G3rDzQA+4Nqv8GlFHzdalqXp3WHly0I8yJs6w/dp4us5wABG106L2QkZyqS2cr+45JPr03LTOoYARvVZN0iNzxLf3Gt14VHv0x1DDymO8CeXmu7bgnTnYOKAaORXhA5HZWQTZl4z4thrHZGcQikstbxHUuIOD17Xsnhc9ENvlFn/EubL60yXnanP6ppoOyv743ZnrI1kz4iKAZ1d7By0F+JPTiGHbjWKE3UsxeGSq8LAJp5wVYQCBEhhA/qLiWaG+maO4w3vCZTTsrwwdh7/bTNFp2s6YOppdPPd4tL4c6GNB/D/MoAMRkGZtEQ/6WjDqN0FJpnUbynwUyLCkkkX9zqIBDIn/3u9Y7aErIFQw+DKiOY84YFQUPa/MxrjJfZeqDJPraXZK9OkB5Fv0L/KcWh4i8vn1sOtTsF2NQJY3LTLBMnvPuaJB11KVRjGki0eOQaxB0XGckCcV7fb1/6UxW8jGG2n58HeDU9G6U3RNIUxFzg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6486002)(966005)(5660300002)(38070700005)(33656002)(6512007)(316002)(53546011)(54906003)(6506007)(36756003)(6916009)(71200400001)(76116006)(91956017)(2616005)(508600001)(83380400001)(86362001)(26005)(186003)(64756008)(66446008)(66476007)(8676002)(66556008)(66946007)(4326008)(44832011)(7416002)(2906002)(38100700002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWhvNUQzTmR4SjdJVkszVVppVVVJOTJraWlJVWxjckdWKy8wWUFxQmpCTnFr?=
 =?utf-8?B?OFJJVWVUeUZBNGVCZDBiQUxDWnZoaGtpODRVTU9VREZ5Qm1JakF0THMxaTVO?=
 =?utf-8?B?UHBzUVY2Z3plRUxpN0s2S0UzZjhpRUNMYzNVOTZUcGpuTDZXSnNuRTFDYUJ5?=
 =?utf-8?B?b1AxOElZSlJEMFNYK1VVUGV4UHJGOWRaZnNXeHhMOHM3OWwvYi9BYjBiRW1r?=
 =?utf-8?B?MDRNYkU4Q3ZVNys4aUtsaGJaa0NjS3JJWE1tTnZpaCtEKytjZ0dtTXRiZjly?=
 =?utf-8?B?UE1Fa0x5b0VXRVNPbTBMSmY2STZoeW5lbm4wTVB5dHlMNEN1dmxlekFROThC?=
 =?utf-8?B?Y2ZVNUtWK0ZoSHA5ZHk4ZE9oKzZYQncxNWs3b0ltaWVyUWpoTnczQzhzSG9T?=
 =?utf-8?B?Yzh4ZlNQeWlFZkhXdkdIOExwYVdjSEdZSkEzUWlHNlYrdTZtbENuZnlSK1VR?=
 =?utf-8?B?SjF5ZTBTMXJqODNXQWIwbGdGOW9lWEQrMDdyd3crb0hyelpJS1hiSjA0OFBI?=
 =?utf-8?B?OTZRL05abEpoenUzUGtXd3pZMjdSUG1GUjBqN1k0VUpZTGNvRUpOLzExOWRH?=
 =?utf-8?B?YzJMRXVSeTJ5ZU9HanJBSlhIaVdyMDVmYXVGbGVGSjFxQ1J0TXVlOUVxZWZq?=
 =?utf-8?B?Y291TnB3VDQyaDFtS0xQQ3dYZ3hTTWVNWmNBQXM5YUFMRHJPNnl3VEhjb3pS?=
 =?utf-8?B?OWV4Y0NHMjI4Y0p1czVEUXhBd1RCN1gxUUg4VXpDSkhzaE8yUS9yNHJDWFFE?=
 =?utf-8?B?VlF6Zm1hTGVxeldmbWhzaGZKRzJ3UTk2djRhaWNwN0k2Szh0d1poY2JzN0dL?=
 =?utf-8?B?Q21OOEtKdkFVM1BlajA1cTVJNUZBZ0pObzlWMURSOE04VFBUc05KNnBEUkYy?=
 =?utf-8?B?dUxuQk16T3RKRXU5TGpGRjZsUGMyOVF2eExub1NEOVllNVkvVlhxTTR4SVQy?=
 =?utf-8?B?WU5BTXZkSmswMUM4ZzIvVXhMWlgvSU8vdGhGRXNqc1Fhdi84Y1R0OEVYTzZn?=
 =?utf-8?B?UmhUTkpQQTFoNzl5eDRMS3pwa0xIRzF2ckd6clU3eXV1eTM5d042NjA1ak1J?=
 =?utf-8?B?OWpXclBsYlZlbklDQ1EzS09LVWcvcHQ4R1FvWkVXelEvN1JqOEhDWi9mMkl0?=
 =?utf-8?B?MzNOS2RnMDdtVjhaenN3bUtXYXhOcEZna0tkY3UwRldVVGdhNTB2MHNMVGtq?=
 =?utf-8?B?Sm5MSmxDeHg4RnJGYTRTbFY0ME14ZnZNYTlxWlIrT2k2TU5McjJZcWlhRENL?=
 =?utf-8?B?elYxSWUxam0wVFhjUDVpdms3NENqNS9yTWtiUFpoM01GeDhGdlN0RXhlUk8r?=
 =?utf-8?B?N2JVZWxOVlZPRytXcEt4am9SY3M3cUhqNFozL1pBQ2YvNDIwMVR3TzhXeUVK?=
 =?utf-8?B?V2Y5MnFwcVJ5RHJ1aEtTNFQ0UzgzSHlWU093TnpBc2gwMUdWbEZQelpzQ2Mr?=
 =?utf-8?B?dXd6QlhBQ2RiMUxHcnpHYzVYVjBoYlhGR3l6L3Y4emUzRWhMMkpITmw2Q3Rn?=
 =?utf-8?B?cHlUd2pvd2tTdlVKWU5qOGNKY1pUV2p4SWZoTkJualo4R1VkV0x4dWpXSUpF?=
 =?utf-8?B?Ui9iVnFBTjR5RDQ4T3FnR0dMbmRkcG8rcHBrWUZEQTcwUUkzZTUwVTkyTGFv?=
 =?utf-8?B?YkJ2akg0QjlRWVJlMGJDUlpsYm92TGE2OE5ydWZlYUdDVEF5aGFZSk14eDFW?=
 =?utf-8?B?ekx2RmVkSHg2LzFjaWNqSlNoaXJkank4cnJqbk9BeHo0WVVVYTUwNHkzQzdT?=
 =?utf-8?B?aFl1cVFpTEI4d3krS0dTTUJBVDZDWVpRaGFMNDVPVUlkSWk4OGM1MTd5S3pr?=
 =?utf-8?B?dCsrNHY0Ulh0Rkgya0N5Qnl4MDhDQlFiY2hva013ODVoY1JIZk9GT2JpY3hC?=
 =?utf-8?B?RkNnMi92Y3FEbzBLWXpsL3F3MTR4UlZ3aHB1SU9TZ212UktVT3RXZnlPRjJK?=
 =?utf-8?B?MERyajc3aDdpMUo0cVZnV1hCVVRQTFIrblNCdDZlUjdJOVB6QU5mWk8xb2tW?=
 =?utf-8?B?MnJwcklKT0NZQkR0citFSHNZZDVvQ3dnZ1ZPZEwyaUpGYkFBcy81QXFLRndk?=
 =?utf-8?B?Tzc4aWJiMThHVHNwV04rVEk3N25kcHlPQTR4Yi9VOFQzaU1YdU1mdE1nQkw5?=
 =?utf-8?B?c0V6RmRwdUhMVkUrajhpM3puRlNKVW5QbHZ4Q1BTR1NYeDcrcXJVV2ZwYUc4?=
 =?utf-8?B?MUVnL0RXUnp4aVI2UXdlclgzSE1hbVhCUzVGbG02TXJqb1J5M1lLS0MwcUtU?=
 =?utf-8?Q?lwlFRCReppmMnTiBgU4KkFqgBw/YqlZsg4eHpO6xmQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3735A0AD61FB1A46BA67FFE22ED1D5DA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a42b80-6041-4161-ba88-08da006b149a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 18:48:33.2594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1UbcSyCYwNArPyak3MczVFks1v1D6USPS2eV0oL0zcI4bvH8gHlabVVFfvfbMrzmfSW3JHzgmDZKH66nvOxFcfiyJCZ5vqCSeUaz1QilNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1316
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203070105
X-Proofpoint-ORIG-GUID: bp6O9HlMWd11ekxMSoE1HM5Q2lCUMqDc
X-Proofpoint-GUID: bp6O9HlMWd11ekxMSoE1HM5Q2lCUMqDc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDcsIDIwMjIsIGF0IDExOjM2IEFNLCBTdGVmYW4gQmVyZ2VyIDxzdGVmYW5i
QGxpbnV4LmlibS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPiBPbiAzLzcvMjIgMTM6MTMsIEVy
aWMgU25vd2Jlcmcgd3JvdGU6DQo+Pj4gT24gTWFyIDQsIDIwMjIsIGF0IDQ6MTkgUE0sIFN0ZWZh
biBCZXJnZXIgPHN0ZWZhbmJAbGludXguaWJtLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4g
T24gMy8xLzIyIDEyOjM2LCBFcmljIFNub3diZXJnIHdyb3RlOg0KPj4+PiBXaGVuIElOVEVHUklU
WV9NQUNISU5FX0tFWVJJTkcgaXMgc2V0LCBhbGwgTWFjaGluZSBPd25lciBLZXlzIChNT0spDQo+
Pj4+IGFyZSBsb2FkZWQgaW50byB0aGUgbWFjaGluZSBrZXlyaW5nLiAgQWRkIGEgbmV3DQo+Pj4+
IElOVEVHUklUWV9NQUNISU5FX0tFWVJJTkdfQ0FfRU5GT1JDRUQgb3B0aW9uIHdoZXJlIG9ubHkg
TU9LIENBIGtleXMgYXJlDQo+Pj4+IGFkZGVkLg0KPj4+PiANCj4+Pj4gU2V0IHRoZSByZXN0cmlj
dGlvbiBjaGVjayB0byByZXN0cmljdF9saW5rX2J5X2NhLiAgVGhpcyB3aWxsIG9ubHkgYWxsb3cN
Cj4+Pj4gQ0Ega2V5cyBpbnRvIHRoZSBtYWNoaW5lIGtleXJpbmcuIFVubGlrZSB3aGVuIElOVEVH
UklUWV9NQUNISU5FX0tFWVJJTkcNCj4+Pj4gaXMgZW5hYmxlZCwgSU1BX0tFWVJJTkdTX1BFUk1J
VF9TSUdORURfQllfQlVJTFRJTl9PUl9TRUNPTkRBUlkgbWF5DQo+Pj4+IGFsc28gYmUgZW5hYmxl
ZCwgYWxsb3dpbmcgSU1BIHRvIHVzZSBrZXlzIGluIHRoZSBtYWNoaW5lIGtleXJpbmcgYXMNCj4+
Pj4gYW5vdGhlciB0cnVzdCBhbmNob3IuDQo+Pj4gDQo+Pj4gSSB0cmllZCB0byB0ZXN0IHRoaXMg
YnV0IGNvdWxkIG9ubHkgZG8gaXQgYnkgZGlzYWJsaW5nIHRoZSBNb2tMaXN0VHJ1c3RlZFJUIHZh
cmlhYmxlIGNoZWNrIGFuZCB0aGVuIGFsc28gdGhlIGNoZWNrIGZvciBzZWN1cmUgYm9vdC4gSXQg
ZGlkIGxvYWQgdGhlIGV4cGVjdGVkIGtleXMgb250byB0aGUgLm1hY2hpbmUga2V5cmluZywgZW5m
b3JjaW5nIHRoZSB4NTA5IGluZGljYXRpbmcgYSBzZWxmLXNpZ25lZCBDQSBpZiB0aGUgY29tcGls
ZSB0aW1lIG9wdGlvbiBDT05GSUdfSU5URUdSSVRZX01BQ0hJTkVfS0VZUklOR19DQV9FTkZPUkNF
RD15IHdhcyBzZXQsIGxvYWRpbmcgYWxsIGtleXMgaW4gdGhlIGNhc2Ugb2YgQ09ORklHX0lOVEVH
UklUWV9NQUNISU5FX0tFWVJJTkc9eS4NCj4+PiANCj4+PiBJIHRyaWVkIHdpdGggdGhpcyBicmFu
Y2ggaGVyZSBmcm9tIG1va3V0aWxzIGh0dHBzOi8vZ2l0aHViLmNvbS9lc25vd2JlcmcvbW9rdXRp
bC90cmVlL3RydXN0LW1vayBidXQgdGhpcyBzZWVtcyB0byBjcmVhdGUgYW4gRUZJIHZhcmlhYmxl
IHdpdGggYSBkaWZmZXJlbnQgbmFtZS4gSSBndWVzcyB0aGlzIGlzIHRoZSB3cm9uZyBicmFuY2g/
DQo+PiBUaGFua3MgZm9yIHRlc3RpbmcuICBEdXJpbmcgdGhlIHNoaW0gcmV2aWV3LCBQZXRlciBy
ZXF1ZXN0ZWQgYW4gRUZJIHZhcmlhYmxlIG5hbWUNCj4+IGNoYW5nZS4gVGhpcyBkaWQgbm90IGlt
cGFjdCBhbnl0aGluZyBpbiB0aGUga2VybmVsLiAgSG93ZXZlciBpdCBkaWQgaW1wYWN0IG1va3V0
aWwuDQo+PiBUaGUgbmVjZXNzYXJ5IG1va3V0aWwgY2hhbmdlcyBhcmUgYXZhaWxhYmxlIGluIHRo
aXMgcHVsbCByZXF1ZXN0Og0KPj4gaHR0cHM6Ly9naXRodWIuY29tL2xjcC9tb2t1dGlsL3B1bGwv
NDkNCj4gDQo+IFRoZSBmb2xsb3dpbmcgaXMgaW4gSmFya2tvJ3MgdHJlZToNCj4gDQo+IGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2phcmtrby9saW51eC10
cG1kZC5naXQvY29tbWl0Lz9pZD00ZDgzZTUxNDRlMjI0YjkwZjY1ODlkMTFiNWZlY2RlMzNjMGRk
MjExDQo+IA0KPiANCj4gKw0KPiArLyoNCj4gKyAqIFRyeSB0byBsb2FkIHRoZSBNb2tMaXN0VHJ1
c3RlZFJUIE1PSyB2YXJpYWJsZSB0byBzZWUgaWYgd2Ugc2hvdWxkIHRydXN0DQo+ICsgKiB0aGUg
TU9LIGtleXMgd2l0aGluIHRoZSBrZXJuZWwuIEl0IGlzIG5vdCBhbiBlcnJvciBpZiB0aGlzIHZh
cmlhYmxlDQo+ICsgKiBkb2VzIG5vdCBleGlzdC4gIElmIGl0IGRvZXMgbm90IGV4aXN0LCBNT0sg
a2V5cyBzaG91bGQgbm90IGJlIHRydXN0ZWQNCj4gKyAqIHdpdGhpbiB0aGUgbWFjaGluZSBrZXly
aW5nLg0KPiArICovDQo+ICtzdGF0aWMgX19pbml0IGJvb2wgdWVmaV9jaGVja190cnVzdF9tb2tf
a2V5cyh2b2lkKQ0KPiArew0KPiArCXN0cnVjdCBlZmlfbW9rdmFyX3RhYmxlX2VudHJ5ICptb2t2
YXJfZW50cnk7DQo+ICsNCj4gKwltb2t2YXJfZW50cnkgPSBlZmlfbW9rdmFyX2VudHJ5X2ZpbmQo
Ik1va0xpc3RUcnVzdGVkUlQiKTsNCj4gKw0KPiArCWlmIChtb2t2YXJfZW50cnkpDQo+ICsJCXJl
dHVybiB0cnVlOw0KPiArDQo+ICsJcmV0dXJuIGZhbHNlOw0KPiArfQ0KPiANCj4gSSBkb24ndCB0
aGluayB0aGlzIHdvcmtzICB3aXRoIHlvdXIgbW9rdXRpbCBQUjoNCj4gDQo+IHN0YXRpYyBpbnQN
Cj4gdHJ1c3RfbW9rX2tleXMoKQ0KPiB7DQo+IAlyZXR1cm4gc2V0X3RvZ2dsZSgiTW9rTGlzdFRy
dXN0ZWROZXciLCAwKTsNCj4gfQ0KPiANCj4gRnJvbSB3aGF0IEkgc2F3LCBNb2tMaXN0VHJ1c3Rl
ZFJUIHNlYXJjaGVzIGZvciBhIG1vay12YXJpYWJsZSBlbnRyeSBpbiB0aGUgTU9LLXNwZWNpZmlj
IGRpcmVjdG9yeSBpbiBzeXNmcyB3aGlsZSBNb2tMaXN0VHJ1c3RlZE5ldyBjcmVhdGVzIG9uZSBp
biB0aGUgRUZJIGRpcuKApg0KDQpNb2tMaXN0VHJ1c3RlZE5ldyBpcyBzZXQgYnkgbW9rdXRpbC4g
IFRoZSB2YXJpYWJsZSBpcyB0aGVuIHVzZWQgYnkgTW9rTWFuYWdlci4gIA0KV2hlbiBzaGltIGJv
b3RzIGFuZCBzZWVzIHRoZSB2YXJpYWJsZSBpcyBzZXQsIGl0IGxvYWRzIE1va01hbmFnZXIgaW5z
dGVhZCBvZiBncnViLiAgDQpUaGUgTW9rTWFuYWdlciB0aGVuIGFza3MgdGhlIHVzZXIgaWYgdGhl
eSB3YW50IHRvIG1ha2UgdGhlIGNoYW5nZS4gICBJZiB0aGUgdXNlciANCmFjY2VwdHMgdGhlIGNo
YW5nZSwgc2hpbSBzdG9yZXMgYSBuZXcgYm9vdCBzZXJ2aWNlcyB2YXJpYWJsZSBhbmQgdGhlIE1v
a0xpc3RUcnVzdGVkTmV3IA0KdmFyaWFibGUgaXMgZGVsZXRlZC4gQWZ0ZXJ3YXJkcyB0aGUgbWFj
aGluZSBpcyByZWJvb3RlZCwgc2hpbSBjcmVhdGVzIHRoZSANCk1va0xpc3RUcnVzdGVkUlQgYmFz
ZWQgb24gdGhlIGJvb3Qgc2VydmljZXMgdmFyaWFibGUgcHJldmlvdXNseSBzZXQuDQoNCg==

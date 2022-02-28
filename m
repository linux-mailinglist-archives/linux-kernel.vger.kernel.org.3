Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353CB4C7EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiB1Xwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiB1Xw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:52:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07E212CC3A;
        Mon, 28 Feb 2022 15:51:48 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21SLhxk4009902;
        Mon, 28 Feb 2022 23:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MQhZqbop40DTpDgy5vBhHrYUglvp4gOxA1bNygJsgvo=;
 b=ZiXjgGcYM1Die/p/iavffq6ffIFLkBvNheRwTthqJitqfH167L/uTjcVpFpc2qgIh6Cc
 hIZyUGxzbIKwqVS1jxzoBMcZ5fMpgJrt4CFaTRh3kLjCj5GhQ6I2jCFgIvBdu4OSDj02
 9d76X8+z3Z9O1f8kKSIRn9yhCdwlA3qnNGpq3lP1jx0R4cfD2+IZ14Rqh3NfV4aEjcwS
 EjtTZySOQTh1uH7cW1t8NIUsVhgMm7H8i+YRs4FYeK0+QrEPKKr9CP2EtC69zvgXUmky
 eBFgEdMFupFCqP1D+UjvJfjV22XLIiPM4O0w7+1pFJiKpvR8WtHeBT+XkkXLiZe4SMKh 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eh14bs7e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 23:51:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21SNV2Jl138131;
        Mon, 28 Feb 2022 23:51:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 3efc13jyp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 23:51:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F70d7gmJyeI5fUARGoEruwesY5dcuuxugArvgfJCbWjPc08P5YUTt/ugH8QJzCYTW0llqhQnmt32Qt8ldJSbKPNOVW61LXbdR8p9NPLmp730o3kqo76+yj++ZFNRv/3cJkwlG1EKAotRkyd4MiGFg3E2Wv0KEGLxNDhYy0CyPESbLWCtmVNagcj0T5c631yxKQuBAh/Ugr/YgiowZFF426QmnbAb/4BAjrNAj8aubuoAdYDHdz0yjmUdrXzch9SXoIZihhXkT0aUPNrRg4qqUXx6WiSbnHrB8AN/9YU9kiOmpaClZ7dmT6L1keBKk7ubJHtF9o4g0sODVTFMngXTZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQhZqbop40DTpDgy5vBhHrYUglvp4gOxA1bNygJsgvo=;
 b=AfQUVqrh7ScgDt3DpbcApIQ4G/omh00oaQw4MUWh4kNJXqvPCY0Girwvs4wIwgd25aCOdFoMI0DKUgnbIapgFQD2K6e1WH5v76B1E2xiGgvCHoRFQaS+Mh2dEjK2TfpYxMFYjnBrB3K8FYBpzH/5L6GUgmDxj445jpCClEuw4aQid2F+7UU2U860SQR/syeAeTzlEmd6gkGSmZvrINzbNUdnOKoPYgTsilQrm0BUT60MQMR2umm1eXHCtnZMufd+HRceZebKCUeuvtPE9oN5e6zpXBMDZ4qS6bks/T/OyvpQnrqHDK0Z1xPDKnh3JcB5RYerOYFyJhsG0AhVc/9TwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQhZqbop40DTpDgy5vBhHrYUglvp4gOxA1bNygJsgvo=;
 b=ZURAnjsUfzFoxAMoUL3+P+1i86NhMlfmvcSCsoMGxqKnawruDcDk7G29MWABe3S6uDXV46U4TH/rNTvSq4XiewuUCfxmmSKFOkbvhfbZrufvauI0oO5GfmXmGtBG7s9HYgI/cy2tlNNW511HuZY86/wCGWHS3T2OChkS+/hu0Fg=
Received: from BYAPR10MB2934.namprd10.prod.outlook.com (2603:10b6:a03:85::22)
 by PH0PR10MB5658.namprd10.prod.outlook.com (2603:10b6:510:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 23:51:23 +0000
Received: from BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::e1f4:60fe:ab1c:ac]) by BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::e1f4:60fe:ab1c:ac%3]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 23:51:23 +0000
From:   Henry Willard <henry.willard@oracle.com>
To:     James Morse <james.morse@arm.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Colin King <colin.king@canonical.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH][V2] ACPI: sysfs: copy ACPI data using io memory copying
Thread-Topic: [PATCH][V2] ACPI: sysfs: copy ACPI data using io memory copying
Thread-Index: AQHYLP4W9EVDlmGxqUajEdrQm/1p8g==
Date:   Mon, 28 Feb 2022 23:51:23 +0000
Message-ID: <88DFC1B9-D444-4D44-963F-34D0F5B9EC01@oracle.com>
References: <20200317165409.469013-1-colin.king@canonical.com>
 <20200320131951.GA6555@lakrids.cambridge.arm.com>
 <698da6fc-3334-5420-5c97-4406914e4599@arm.com>
In-Reply-To: <698da6fc-3334-5420-5c97-4406914e4599@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2098e5f7-3e45-4ab8-2f9c-08d9fb153a1f
x-ms-traffictypediagnostic: PH0PR10MB5658:EE_
x-microsoft-antispam-prvs: <PH0PR10MB5658FAD9449E08EBFC5528038C019@PH0PR10MB5658.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aAYEVGSp8el8dopWPphYhBlBRq4jNbdaa0zD9bNJ9eMKkQNxDstO1zQdAiDz4zuk7VEZP0hi9+Sua0NL2cfvZOWW0aJpn9T+uQ/1Qi9XWdermjNq/Olf8jMSO1R6mv6ZTQYl5nYcpozueXWryVsLUSPlaChVg6wkXEP7Z4ca6pr/SgT9kvmdqBpVcl9HY1pJJaJEKBAybElrp0NPMl4BBIJ8cYyT1Taq4cKLq8XRGoCN7rP/Onkz4hiXpgUC+/iev2pHS4J9OmY6W6K3nEr3sR7pV+EjAyfUjNsjHmksEuEkjICNnoXK5uGRx9CaZ4DNZ5ZLCsJgDysMrKCMSdP7OUojLc3GVevqHFyBEQAF7DMdd1b8YaHKtqBxzHq5n8f0/KcLgsX7p0KB8TJgQ7WWiI0I3kTrwxRViasjniRaxZj4b4NXDuudrXXnqsMlc0Q7+XzrMYXVvyOz2gFDy3UM3jnq9BOjpWa8HpnBIA9D2R9EGUmWyjJSxLGr9AhFcnb8fEJ2Dxgy5hjAUqjKNFWauC2orpvoHL9gTvzLw3Crt5mfR1X/bdLrjUeXKCYMp3yjyOxkOCySLR/MtmI9/SjHvxElH0ldhzvH6XH1JgMpnyiobwMxwcA4GCdWmdlYEt2dv5f5pF/vaHg3TZBtmFugWWtWl4j5EZFHhHqU726D3LfURTFc++mS+JCEei1cph+F6vrepPdT26i/p2Pz2EAy/vX+BzAVbTTAQu7pXZfYIafbxUY4dyapg2mYKPVI9btg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2934.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(66556008)(6486002)(83380400001)(38100700002)(71200400001)(122000001)(508600001)(33656002)(66476007)(7416002)(6916009)(26005)(54906003)(186003)(2906002)(91956017)(44832011)(8676002)(316002)(66946007)(76116006)(64756008)(66446008)(4326008)(86362001)(5660300002)(6512007)(53546011)(6506007)(8936002)(36756003)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDRuSC92a0cyMG11aytOZTF0Y1p1VkVhL2FwOVZwK3FXelhHY05OWFltTUw3?=
 =?utf-8?B?d0pFYkJpV0M0YTd4SzdSQWdZSlhJTGFTUlZaKzE5akQzdjBqSk9tNU1HWnd3?=
 =?utf-8?B?Z3RNZ29SSGhWRTF0N2xhTTVIbUUrZEhUTUsxeDFVUTI4RXVpeWV1dDBiejR5?=
 =?utf-8?B?aEQvd1B4VkdTa3JZc3R2ZlY0U0ZhS09FRDZ2eGF5MWF2dkNWdjVnbUpud2dC?=
 =?utf-8?B?RTRzNWREcXpMK1k1VFlBYXZTVVczcGRWUVJmNDFVNk03WUZrdGEzQTF0QVNY?=
 =?utf-8?B?OXlPQmJYcDFMZDdIVG1GcjY2S01aQytrcEpJbERNdElTMlUrRGkzcmpJcWlk?=
 =?utf-8?B?Q2NwOWQrV1ZGS0xwUW0wN1pVMXZqQjJIa3d6b2s3cmMxR0NUWHNmNjk3U3oy?=
 =?utf-8?B?cXZRWVhKZzZpTTNYbG1Lb1JnN3NGbXdyK3BZMXo4Q3IvUFp5V2t1OWlzR0dk?=
 =?utf-8?B?UE9Vc3hibkprcWVtT1Y4eTk2ek45WVQvcGhLanF5dFlhb1lHQmd4TktGLzBk?=
 =?utf-8?B?NzdlUk9WcWV6N3pBRWR4YzUrS3c4Y0JwM1VkUGVVVE1pNlpIZ3liN3ZSc0R0?=
 =?utf-8?B?UVFISjF6REUwaVBESHVka3dkOGJQNUxFdDA1Q0xMdG5Qenp1VGtvNm5rOFpr?=
 =?utf-8?B?R3V4dTE1RkZvWTlIQnR1RHhTbW8zTytwRnJXMlhHWmVDcTZLeWtoczFmOWk0?=
 =?utf-8?B?R2VFSTJQUFl1ZkF0clNMdlJjQ1lkTUNaSTIvTjNWb3AyTmJpQ2RYemZvOXkz?=
 =?utf-8?B?VnZqQlZlNEpqTEw5dVEyYWQ5N0ZHNEg5TmR2N0p6WjJFMXQyUTE0elM3Rnh2?=
 =?utf-8?B?WHUwWXFYRFppM0dzMitVOGdlZ2ltRngzZGJJVlAxVjdLV2JiTFNlNThYanVo?=
 =?utf-8?B?T2xjMFVBeUd1OUoxOTgyTTNkbGFSZC9PcmZiRTRUUldzOHNaZ1RJY0srMHNN?=
 =?utf-8?B?N0F3UDkrVGh4K0F4MmE1RXhlVkpkNFRtTUxZZU1jVThCcnkzZ1NEbUdJTDBR?=
 =?utf-8?B?T2FwSS92c1NpVGNldTVzbzRKbExLMUlLKzZlZWhVdDIwbDNLYlRQdm43eUV4?=
 =?utf-8?B?L3d6d1REaVQrcklCa1Vrb3JxYXpsN2xzREsyU1h0TjNzTmZQVlpKWDVvNjZW?=
 =?utf-8?B?OHcrVzRmM0N6WkprNlhRZWtSaEhIZSszeU5ER3BGQWlxdTY1ME5ROHdUc1Ay?=
 =?utf-8?B?bUx1emxhS0hkV2lqMTI1SnR2YzR3K3RpWDVydEpKeDZpSWQ3aUhuYVNJeG1l?=
 =?utf-8?B?SDh0WlQ4NlRBWHd2UnIzVVlCaTY3amw2bG9ja1BXT2VTWkQ4TlNURUxHQnR5?=
 =?utf-8?B?VUFzNlplRmF4aXBNOU1VZ21mUkNWWXJoSWsyaG56NVVETDNBeTNpZkZxV1RZ?=
 =?utf-8?B?U2xlZTR2L1o4a21BQjA2a3hKYjE0K3piUCtlbGJXNElYSGFzckhEMkZkT3hZ?=
 =?utf-8?B?T0QrMWNpTFV5L2c0TzlURlpqd2dGbmpWTVdYK3hoRm5RdDduUnNYYk04cnl2?=
 =?utf-8?B?Ynl4S0puOEJHYjQ4RkJZV01DR2pHTXlXNHlyVXI4M0RFRlRET0dMeFR1WS8v?=
 =?utf-8?B?bjI2MHQ4QnVPSjdnbUVzak4wd2Z3bTVhZzVPRDdjVnBoU0tmRXJEcEg1VTMr?=
 =?utf-8?B?K3JGUWZlWll0c1JGczZmaFpGbVRIbzdpWFczZkZSdGUwMUhhOTVXM0p6Q0Q2?=
 =?utf-8?B?TE9xOC9oVUlxdHBiMS8yUUJuU3U4ZkloUkpFZ2p2RW04cTdmSUdUOWlDSGh4?=
 =?utf-8?B?OFEyTm9GUVh1djBhVndTait6dCtrRVRRNC9Bdkc4QVBNbVY5R0RzM3J2M2pl?=
 =?utf-8?B?SWhubnVseFBGRkhqQzNnVnR5eTlMMGR5dVlDWXdMMzUvUkZHdkNpazdHR3Av?=
 =?utf-8?B?T3Q2NzN4YU96Nnc3TWVRT3hnR0d6MzZJcDV0Q0VUeDk3MWVXNkxkMXp3bDhX?=
 =?utf-8?B?dm4yY25mbGR3UTdYTzZKYjUzRXJ4UjFUM3M1ZzJLNnJRWnkvU3AyWjM3dkFw?=
 =?utf-8?B?VExlWjVsWjJ0bWhMOHd1b05PWVRmNjV3V3pCUlBJZTQ4M0J0R0ZML3ZGY3c2?=
 =?utf-8?B?MmdjdnBvRDBwR0NidE9jTmxiWkZoU2RRWFRlN0pMbWtJL0tkd0hZNFhZK3Nt?=
 =?utf-8?B?VjRDZVRqSFJKTDhVZG40ZFVXNFFETzJCWUh0VW9UNm13ZERMb3lyejBmK0p4?=
 =?utf-8?B?RWdOckFMR1YwMjZrRDlGZERIMklsdlI3ajVtbFN3b0NmMlZZd2UwOWlpQ1RL?=
 =?utf-8?Q?zFuEJHuHu8hUSbrqmdvbf6Qr6xHsJ1GumipWkZSzSc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F88A3C75E887DF47AB8BCB67CED62CD8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2934.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2098e5f7-3e45-4ab8-2f9c-08d9fb153a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 23:51:23.3893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xWCeX8V+Ztg8OeXp1jI5pW0TLkfOA4cgcujPktR39avAqTiRchC6y71QSFARCy3GrICXyPVykabDOPp8HtTyP+YCZIwls0HQKKcCNZT04FA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5658
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10272 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280119
X-Proofpoint-GUID: sSGBm6frCWbv5dat7qJUNmOHjnHlJkkG
X-Proofpoint-ORIG-GUID: sSGBm6frCWbv5dat7qJUNmOHjnHlJkkG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXByIDEsIDIwMjAsIGF0IDU6NDQgQU0sIEphbWVzIE1vcnNlIDxqYW1lcy5tb3Jz
ZUBhcm0uY29tPiB3cm90ZToNCj4gDQo+IEhlbGxvIQ0KPiANCj4gT24gMy8yMC8yMCAxOjE5IFBN
LCBNYXJrIFJ1dGxhbmQgd3JvdGU6DQo+PiBbYWRkaW5nIEphbWVzIGFuZCBMb3JlbnpvXQ0KPiAN
Cj4gKGJ1dCBub3QgYWN0dWFsbHkuLi4pDQo+IA0KPiANCj4+IE9uIFR1ZSwgTWFyIDE3LCAyMDIw
IGF0IDA0OjU0OjA5UE0gKzAwMDAsIENvbGluIEtpbmcgd3JvdGU6DQo+Pj4gRnJvbTogQ29saW4g
SWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4+PiANCj4+PiBSZWFkaW5nIEFD
UEkgZGF0YSBvbiBBUk02NCBhdCBhIG5vbi1hbGlnbmVkIG9mZnNldCBmcm9tDQo+Pj4gL3N5cy9m
aXJtd2FyZS9hY3BpL3RhYmxlcy9kYXRhL0JFUlQgd2lsbCBjYXVzZSBhIHNwbGF0IGJlY2F1c2UN
Cj4+PiB0aGUgZGF0YSBpcyBJL08gbWVtb3J5IG1hcHBlZA0KPiANCj4gT24geW91ciBwbGF0Zm9y
bSwgb24gc29tZW9uZSBlbHNlJ3MgaXQgbWF5IGJlIGluIG1lbW9yeS4NCj4gDQo+IFdoaWNoIHBs
YXRmb3JtIGlzIHRoaXMgb24/DQo+IChJJ3ZlIG5ldmVyIHNlZW4gb25lIGdlbmVyYXRlIGEgQkVS
VCEpDQoNCkkgaGF2ZSBzZWVuIHRoaXMgb24gc2V2ZXJhbCBwbGF0Zm9ybXMuIFRoZSBsYXRlc3Qg
aXMgYW4gQWx0cmEgYmFzZWQgbWFjaGluZS4gSXQgc2hvd3MgdXAgaW4gdGhlIExpbnV4IFRlc3Qg
UHJvamVjdDogbHRwIHRlc3QgInJlYWRfYWxsIC1kIC9zeXMgLXEgLXIgMTDigJ0uIA0KPiANCj4g
DQo+Pj4gYW5kIGJlaW5nIHJlYWQgd2l0aCBqdXN0IGEgbWVtY3B5Lg0KPj4+IEZpeCB0aGlzIGJ5
IGludHJvZHVjaW5nIGFuIEkvTyB2YXJpYW50IG9mIG1lbW9yeV9yZWFkX2Zyb21fYnVmZmVyDQo+
Pj4gYW5kIHVzaW5nIEkvTyBtZW1vcnkgbWFwcGVkIGNvcGllcyBpbnN0ZWFkLg0KPiANCj4+IEp1
c3QgdG8gY2hlY2ssIGlzIHRoYXQgY29ycmVjdCBpcyBpdCBjb3JyZWN0IHRvIG1hcCB0aG9zZSB0
YWJsZXMgd2l0aA0KPj4gRGV2aWNlIGF0dHJpYnV0ZXMgaW4gdGhlIGZpcnN0IHBsYWNlLCBvciBz
aG91bGQgd2UgYmUgbWFwcGluZyB0aGUgdGFibGVzDQo+PiB3aXRoIE5vcm1hbCBDYWNoZWFibGUg
YXR0cmlidXRlcyB3aXRoIG1lbXJlbWFwKCk/DQo+PiANCj4+IElmIHRoZSBGVyBwbGFjZWQgdGhv
c2UgaW50byBtZW1vcnkgdXNpbmcgY2FjaGVhdmJsZSBhdHRyaWJ1dGVzLCByZWFkaW5nDQo+PiB0
aGVtIHVzaW5nIERldmljZSBhdHRyaWJ1dGVzIGNvdWxkIHJlc3VsdCBpbiBzdGFsZSB2YWx1ZXMs
IHdoaWNoIGNvdWxkDQo+PiBiZSBnYXJiYWdlLg0KPiANCj4gWWVzLiBUaGUgQkVSVCBjb2RlIHNo
b3VsZCBiZSB1c2luZyBhcmNoX2FwZWlfZ2V0X21lbV9hdHRyaWJ1dGUoKSB0byB1c2UgdGhlDQo+
IGNvcnJlY3QgYXR0cmlidXRlcy4gU2VlIGdoZXNfbWFwKCkgZm9yIGFuIGV4YW1wbGUuIGJlcnRf
aW5pdCgpIHdpbGwgbmVlZCB0byB1c2UNCj4gYSB2ZXJzaW9uIG9mIGlvcmVtYXAoKSB0aGF0IHRh
a2VzIHRoZSBwZ3Byb3RfdC4NCj4gDQo+IEFsd2F5cyB1c2luZyBpb3JlbWFwX2NhY2hlKCkgbWVh
bnMgeW91IGdldCBhIGNhY2hlYWJsZSBtYXBwaW5nLCByZWdhcmRsZXNzIG9mDQo+IGhvdyBmaXJt
d2FyZSBkZXNjcmliZWQgdGhpcyByZWdpb24gaW4gdGhlIFVFRkkgbWVtb3J5IG1hcC4gVGhpcyBk
b2Vzbid0IGV4cGxhaW4NCj4gd2h5IHlvdSBnb3QgYW4gYWxpZ25tZW50IGZhdWx0Lg0KDQpUaGUg
QkVSVCBlcnJvciByZWdpb24gZG9lc27igJl0IGFwcGVhciBpbiB0aGUgVUVGSSBtZW1vcnkgbWFw
IG9uIGFueSBvZiB0aGUgc3lzdGVtcyBJIGhhdmUgbG9va2VkIGF0LiBUaGlzIG1lYW5zIHRoYXQg
YWNwaV9vc19tYXBfbWVtb3J5KCkgd2lsbCBhbHdheXMgbWFwIHRoZSBhcmVhICBhcyBQUk9UX0RF
VklDRV9uR25SbkUsIHdoaWNoIHJlc3VsdHMgaW4gYW4gYWxpZ25tZW50IGZhdWx0IG9uIGFuIHVu
YWxpZ25lZCBhY2Nlc3MuIEZvciBzb21lIHJlYXNvbiB0aGlzIGRvZXMgbm90IGZhaWwgb24gc29t
ZSBpbXBsZW1lbnRhdGlvbnMuDQoNCkl0IGlzbuKAmXQgY2xlYXIgdG8gbWUgZnJvbSB0aGUgQUNQ
SSBzcGVjIHdoZXRoZXIgdGhpcyBjYW4gYmUgaW4gYW55dGhpbmcgb3RoZXIgdGhhbiBub3JtYWwg
bWVtb3J5IGFzIGJlcnRfaW5pdCgpIHNlZW1zIHRvIGFzc3VtZSBpdCBpcy4NCg0KV2UgaGF2ZSB1
c2VkIHRoaXMgcGF0Y2ggdG8gcmVzb2x2ZSB0aGlzIHByb2JsZW0gb24gdGhlIGFzc3VtcHRpb24g
aXQgd2lsbCBldmVudHVhbGx5IG1ha2UgaXQgaW50byB0aGUgbWFpbmxpbmUga2VybmVsLiBJcyB0
aGVyZSBhbnkgY2hhbmNlIHRoaXMgd2lsbCBoYXBwZW4/IA0KDQpUaGFua3MsDQoNCkhlbnJ5DQo+
IA0KPiBPdGhlcndpc2UsIGxvb2tzIGZpbmUgdG8gbWUuDQo+IA0KPiANCj4gKE4uQi4gSSBpZ25v
cmVkIHRoaXMgcGF0Y2ggYXMgaXQgd2Fzbid0IGNvcGllZCB0byBsaW51eC1hcm0ta2VybmVsIGFu
ZCB0aGUNCj4gc3ViamVjdCBzYXlzIGl0cyBhYm91dCBzeXNmczwtPkFDUEksIG5vdGhpbmcgdG8g
ZG8gd2l0aCBBUEVJISkNCj4gDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBKYW1lcw0KPiANCg0K

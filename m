Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7559555F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiHPIdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbiHPIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:31:56 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2073.outbound.protection.outlook.com [40.107.113.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426A79E139
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA6UA0gZEvRTPnoEF2NIC0h+Aj3sCO2wlMBwZLM8g9D4tvIDAUAfHfeSg6nifjdr6+a2KRWQRy7QFuw4DHXAiWqS4GMthPiAZnY3hlao9BbyPjCSxVZLU0Ht5qobbi4KNg3IcG2UrWu6X0YwcX4PgtUFU3AIhr6mplTvb50K+RtcIBI/biQRDuPl5Hv4KI6Tzi7bij69aid7q3yO/LKnFmnNStWkZ7oMp7qpnmDWyDdT2Nz43423kzB/7Sd/l3hvOQIA/PVOmJrzq2UzaM7CuLbD93FQ6YjFaPFUn05011rafFhhFIsvn5CeqA6yYvahlG7k43o4lbWPtqHm5IxYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqcCU8Wk2Tie5GjGW7DHXxgfAb5JlEWOFzCmDBJqHZw=;
 b=DYyQomZYNXeb9zCCjzqAQPIMP+FX3hSoto2ZvpCdHQB2LWd+gl0nygJmJha8GTMlcjkaWVJBzZOqaBB8Ud77Wyxlq7Au3cvKycwHZK8wxwMaEUJQ9Ez+OWJSK1IDDZ+8xTkyzmnRsoqYUacJYi2JTzzBW95IRGi50NcvY0W2e+6tj0oSVlgSmiUMnwRns/sBhnOFcaMtcmgDlKIosF5IMx5MOXhqZnc3K/GLzUelwc5PxYq1b1Sn1icHx+nOBF4Y/mEj7pOLWtrMeLcfcpo7aJjrNUChptARhfYCTyReYZh9HJYa+DLn4aprbxXA5IyDXHxuLXqidV8SKJbNwQL73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqcCU8Wk2Tie5GjGW7DHXxgfAb5JlEWOFzCmDBJqHZw=;
 b=lETznEQr7haBNPI9lwcr15AZW7Dvf8kv14j9quUPo+64Ak48eDcAqXZZJaixBfdus3hqcvWixlTxjEj30Jlm7KnBU0aLiB2aY6Vch+B7FU1G46FiP69CpCpSw0FTTUZDctzcXlzDkN/glGcO2BVVPQo9KCmEQCAoaoU/JJKkPGw=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSZPR01MB9519.jpnprd01.prod.outlook.com (2603:1096:604:1d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 05:47:17 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::8541:c36f:a141:ddba]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::8541:c36f:a141:ddba%8]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 05:47:17 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: memory-failure: cleanup try_to_split_thp_page()
Thread-Topic: [PATCH v2] mm: memory-failure: cleanup try_to_split_thp_page()
Thread-Index: AQHYq+Dh6HCR6RtLXk6dmu8yA/Swg62xD4YA
Date:   Tue, 16 Aug 2022 05:47:16 +0000
Message-ID: <20220816054716.GA496220@hori.linux.bs1.fc.nec.co.jp>
References: <20220809111813.139690-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20220809111813.139690-1-wangkefeng.wang@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bec0756-4937-4bf7-2e84-08da7f4ac711
x-ms-traffictypediagnostic: OSZPR01MB9519:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pePdBS9O8DH8RApBLu6XB2Y9HZvJ0fPeCvvzZFp8sKw7K7mSn5OkVUSyYngimiFou/RZLoM7ePf0xk8NvWh3UJ76anJLqAH+8OW5WOLV3C4tQ0ogsljsS/OJm9Xk/xAW57PN7RN3LB51q4eEcFGwWMlqwsyaeGPvoan8dBarQcQNJ2u806HBgOkc1RTKGfV3vN48DH8brF/K3TXhE1QAmUpkm2pcN/M2g+YprRVNJQgObtmVGFEaahGopoI1y4YKHkY0HBfCqsXcGq51p6dyJfG14mh3afpaojkJ2vzjamtq1QIRJX157u6LASX+FzP49NwxHdEyQ5k7ZZX6yfk8AIGjKJf5dCZp45myS6lWEbX+yyFkj7i/TNAYhyVlWDSBSb2+kjLOOLiB84fydbn2gKbC2drWdQnIXC1H4XVB4zsmmcAXCx/AgS/XhZfdfJ19o20hc2BV31gXly3ZC1I+pI14F15RSHgMYq1LGWvKKOt9OpFV18jvLU42ojet+BZioQzz8H4l7JI3knLEsCSubQ3gF5hgA3fL91I6CQqMdFt7ood73zEFG4brQTKOYz8zwAxy8VcWOUEgR2foNDqyLa75wToSsFGBNe3R3shI0qKRiXnBtKnt1chy6jWjBX9LwdGzALdEkMrktgKcCcra6luhJAUEL3mLmhrEhkm5lZZPFzbb2TjRYG4Mds4Y0nUiGxrVSiP7VCVs+s8wsCBFvATLyrzbohwnknrxa56w3GT/hIWUm/salFO+OvwlzDBoG64YSzFPexIiG256p7xOlDWP4e1WK5P0sfvBvLzalUc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(6506007)(6512007)(2906002)(55236004)(9686003)(38070700005)(82960400001)(5660300002)(8936002)(478600001)(4744005)(33656002)(41300700001)(122000001)(26005)(86362001)(38100700002)(1076003)(83380400001)(186003)(6916009)(54906003)(71200400001)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(85182001)(76116006)(316002)(6486002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1JXTXdLQnZXQlNlcFQ5TWlvWXg0d1pkdy9DckV5RFN0UmRzRVJSeHROeTBa?=
 =?utf-8?B?RkZrZFZaenRaNmo5Tk5MSEw4MUZPZHk1M2UwVEtFWEtrcURGLzY4WXRlYkNk?=
 =?utf-8?B?Sng1a2dLNTJWN1FYWVlyazFCRm5acmtpTGF5VGpib3haK1I5b2RkaXNPbjhi?=
 =?utf-8?B?ZkRiTmhjVVBJa2Z2UVFCODh5bUhTZ0RVQkZ3b0pYNVZYVGpWRnJmYzcyNldt?=
 =?utf-8?B?Uk84bmFERjg0eFhpaCsyWk9UVS9YL2FFbXBYbE9qOWZvbXRKTXY2Ukx0U3Nh?=
 =?utf-8?B?V1cwOXhmRDBVSTM3Y1JNTUl1YUdRSEdHMjZSOElRYmM4eUVrVGNHY2xLbWQx?=
 =?utf-8?B?bEF0eWZ0Ymw3OTRGVVFLT3RWUUNKTDB5azdCeTlkSHduQlpiNzhiTWlwa01k?=
 =?utf-8?B?dWxDanBvb1lhN1NPQ3MxTTF6N091MGRIUFkwSFBzZVdWdmFZRDBTS2RHZXlK?=
 =?utf-8?B?RWlHUmw3UXd6MmRFS3M4RDRpK3l2NVpzL3UweHV5Q3A5MWJIMG40SlhFOG1j?=
 =?utf-8?B?TVVNYWJIWm5MOG4xbm02ak9KL1UwMFlGVUpvditQdzlIZGZWVkpkcnJHc0J5?=
 =?utf-8?B?eUpBSDFnNU16N29uclRQRHBvMStHTU5oK3RUbEhkeGZXVWFxTGtkek5NL0R0?=
 =?utf-8?B?cVhhZFgrV3B4NmtHNnNTc05KNVJsS2RFN1h2clVpRlQ0Z2ZiQ2pOQkkvUHhk?=
 =?utf-8?B?WHBGank3aURJR1lwaTQrUE9mR243cDhRZmV2SXpXdzZtdldlMytXRWdBNVVR?=
 =?utf-8?B?OGtDMnlJcXRjTmVBZTFFS09Hemo4c1FiVUFZcUVVMnVLRzNKQjBQa0t4ZE9Y?=
 =?utf-8?B?MkRFU1NMNVR2a1dTUHFmQlorTGVZNVVxRVhYdU0yTGZMZTJtWEsxd2twbnVX?=
 =?utf-8?B?SnVNTWlzMnp5T1VwSnNoWklRNHoyWWUrcVd3enNSN09yTTdza2tvU0dJc3pj?=
 =?utf-8?B?T2EwOWxsNHRjbjJVNmhsdzNwSGlUYStqZ2xmT0l3ZDhNT1lDVldSc2EybTJy?=
 =?utf-8?B?M1pqTjRUMFdIQ2NTYWFoMXo5R05rNWhBTDdHUzEydjZ4NlN0aDJPT1ZGQnY4?=
 =?utf-8?B?ZFk3Q0FWWEZHOEQ5alV4MlJWQjVPU3pFYm1LVHdUMk9MdWZkYlYvVFkxMU1F?=
 =?utf-8?B?dUdQR3hRT0ZkUzRjWmoydmdnMHYxMVBJaEJnSVVNY3U0U1RaQTNWczhoRmhO?=
 =?utf-8?B?QVJiZGJKTWxZZm90bFYwVFo1R0xPWjBvMVM0VmkrK2pHUEk5WHluTkVwSE0v?=
 =?utf-8?B?elpKYTNld3NLanBLZFp3eU5PRlBXRHlIRE4xeTlIeHQzaU5RdzRPRllpdTJn?=
 =?utf-8?B?clF3SFVHTnF6VVoxc1phZjA0RGtFZ3FvbnFQSm0rYlVtNVJzdWg0K2lmVzd0?=
 =?utf-8?B?VG13QkFPWEdNbUM0Vmo2b1hmMmFyRkNjMnJpbVlMRXBGa0VTQVphbmFjZ3ZZ?=
 =?utf-8?B?Mm51TkRhd2FzVlhiUjc0b3NVR1JsT1dJeHJpZkhXbEk5V2VGaGtPdXo5MFV0?=
 =?utf-8?B?NHJrNHdlZ2pFWUhsSTNVZi9hTDMwQXdqazB0L1hhd0JWYmZzNnZqckYvWmZo?=
 =?utf-8?B?aVR0bWprSk9CUWIrdHlVZWtKRGVsenBzQTIwRmpwdXlVR0dmNmZVQnNhNE9k?=
 =?utf-8?B?T3hlT1crN1k2ajlKaVFuY1k4YzU4b0JITHg4VHBtQUtucHpZWjRHWG43OWVy?=
 =?utf-8?B?SUZnS0Q0V1R3ZVZiTmtQQ2g5UFJZNE1RaUdybEpLQXhHY0NLUjdpSkF4RzhB?=
 =?utf-8?B?TFpuTWxpaWZ2NkdGMUt5WHVXai9LSHpQVEc2M2xNcW51WnpvTURjQmt2V25x?=
 =?utf-8?B?WXJqRGhLZ2RtY2lZcTVFZWovbzFyUjk0QU1aYXNGdW5GcG80Y29xemVHMDlp?=
 =?utf-8?B?bUdOUTRlalpxMkQ1Mjk5Wm10ZUV1THJweEhVbE4zRWdTNXpLb1R0eFdPVWNq?=
 =?utf-8?B?MnRKMm14TkJ3WnNON29yUHhwdDZqMGtBQkcrQnBobFVzWE9LRUtFSlptcDJ6?=
 =?utf-8?B?KyszYkVCTGw0OG42Tk96QmUyckgvTjZTZVRiYU9uZE5kVHFTR1pyQWRwZmlI?=
 =?utf-8?B?QVNaQTkyL1RncEdDSUN2SUZtYy9CT2NCUjJwMEZTZEQ0YjllQ05ZQVFKQS9I?=
 =?utf-8?B?RUdkanRaRDJ6bU95TE94WWVYTmtRRit0SEJSMnY0MG92L2FIcXdwSGRMNEda?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCB142B155619C499E5A4EBE89332CD4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bec0756-4937-4bf7-2e84-08da7f4ac711
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 05:47:16.9821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mwPeBX0cvqRQ78rnx2wj6ln7RPVEkvuq8NxG7+LGQtxKXiGP4z1sgmI0dVUbbYMJTdHaPstCyq2jDqM5K4MYag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9519
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMDksIDIwMjIgYXQgMDc6MTg6MTNQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6DQo+IFNpbmNlIGNvbW1pdCA1ZDFmZDVkYzg3N2IgKCJtbSxod3BvaXNvbjogaW50cm9kdWNl
IE1GX01TR19VTlNQTElUX1RIUCIpLA0KPiB0aGUgYWN0aW9uX3Jlc3VsdCgsTUZfTVNHX1VOU1BM
SVRfVEhQLCkgY2FsbGVkIHRvIHNob3cgbWVtb3J5IGVycm9yIGV2ZW50DQo+IGluIG1lbW9yeV9m
YWlsdXJlKCksIHNvIHRoZSBwcl9pbmZvKCkgaW4gdHJ5X3RvX3NwbGl0X3RocF9wYWdlKCkgaXMg
b25seQ0KPiBuZWVkZWQgaW4gc29mdF9vZmZsaW5lX2luX3VzZV9wYWdlKCkuDQo+IA0KPiBNZWFu
d2hpbGUgdGhpcyBjb3VsZCBhbHNvIGZpeCB0aGUgdW5leHBlY3RlZCBwcmVmaXggZm9yICJ0aHAg
c3BsaXQgZmFpbGVkIg0KPiBkdWUgdG8gY29tbWl0IDk2Zjk2NzYzZGUyNiAoIm1tOiBtZW1vcnkt
ZmFpbHVyZTogY29udmVydCB0byBwcl9mbXQoKSIpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2Vm
ZW5nIFdhbmcgPHdhbmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tPg0KDQojIFNvcnJ5IGZvciBteSBs
YXRlIHJlcGx5LCBJJ20gYmFjayBmcm9tIHN1bW1lciBob2xpZGF5Li4uDQoNCkFja2VkLWJ5OiBO
YW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24D153CC4F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245532AbiFCP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239051AbiFCP3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:29:48 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3FF5FE0;
        Fri,  3 Jun 2022 08:29:47 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253C1wGj002546;
        Fri, 3 Jun 2022 15:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=OByb2wclSgnx/iL/WhLiWUud9/IcVfFwCTNkIPffRXo=;
 b=fo60D7kYpme3lQmf4VNX1bfiN/enCc+NxS/W3CHpKutLZfuBPpA7fNF1Qyx5vC3vWAa9
 p/Xi1X9ywel2WZDgRJ8PzxP2belVycI0OTM9uaWTQW/P4oDOoa0c1LDleDfImClgqudR
 +3RwRMaWC+E2aOfkq53tO6FKxitk/ld/5sbnVwefIDOTp7KBNiVyBruqa5nsQiumkX8S
 LoS21ByFWtE8zI+6l6bzyD4Kn4HI0WQ48URpUcmsmLjiKrvhUM3yes+9AsUBmbPq/H81
 yCzoJmj6KTvrhepoXoka0k5gfWp1pnewL6CBZ5ogKTAof6GxqIpUJbPhrQSnMp2sfi9L EQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3gf3kgh6y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 15:29:29 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8B30980024F;
        Fri,  3 Jun 2022 15:29:26 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 3 Jun 2022 03:29:26 -1200
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 3 Jun 2022 03:29:25 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 3 Jun 2022 03:29:25 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 3 Jun 2022 03:29:25 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZBaKoEEYwKjaKZkvjYHnOADOMs8R56xeaVZe4eHrx+YvqjC4QgFf/shBFsOyjxqet5wcnPomAJNNXt5jcMW9mGa7fjP1uwthPz8CBKImw2sWPj0WFqbuxetx4PuG9mAVbuorwNytAqR2fpOxWg4dAGS6np1qlgv4Wku1UuiAH3DvcE+nvf2iB0RADTqVo9ahrZsfJt1i3848UGs645cEQP2e/dgho1eASrj1qL7VNnHzczZzWQyTi9s1RMeGk2WVX/vCuGVg3GOQX5tIDM7Mgjw41FSImvue7PuTB5ozNSXL9XzAhFrE+4Rf5YHbqSJb3GMGD5duQcZzCzqYBYj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OByb2wclSgnx/iL/WhLiWUud9/IcVfFwCTNkIPffRXo=;
 b=ifgNIN7/UiK7VJAluLD7mPRngh23NDSYc5vADUFeYqPVipBFgD78a7ZWvWCozU1b2XwQOWQ+YGTknMh6XaYoAuF0PV5370jWqzSNcPXCn+keKqRYiFRDc5NmGltYUorEXevpugPc5bdpyoiq7LInOBv8XOzcB6gJ8FEdri+I8qJGrTRz9mKdw3yO0TaQdUAwxJxTrkngmEHnbxDg36n4om+F+isBQOqNrQDeljE8trXnwgtQJDu9Y4s4l8/u6r4oUpLx3SZrZfClXEWQagHxg+UUGiASHM5QlYHZQtQGEfSfqmk4rmgE+q/UDLgJGQ1BLlltStFHAyEuy1Xfrl20bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Fri, 3 Jun
 2022 15:29:24 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::152:caab:fcbf:4e43]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::152:caab:fcbf:4e43%3]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 15:29:24 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Wim Van Sebroeck" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: RE: mainline build failure due to 6b47441bed49 ("watchdog: hpe-wdt:
 Introduce HPE GXP Watchdog")
Thread-Topic: mainline build failure due to 6b47441bed49 ("watchdog: hpe-wdt:
 Introduce HPE GXP Watchdog")
Thread-Index: AQHYdzEoYVfmQEAQt0e/gUDKtDyIj609qamAgAAk6ZA=
Date:   Fri, 3 Jun 2022 15:29:24 +0000
Message-ID: <DM4PR84MB19274BAD84AE7497C663F70C88A19@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <YpncSXSTTyKGprLi@debian>
 <10f49cf3-3f92-e5e2-d69a-77c37f12a1fe@roeck-us.net>
In-Reply-To: <10f49cf3-3f92-e5e2-d69a-77c37f12a1fe@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99598428-509c-4d6a-dd95-08da4575d6c9
x-ms-traffictypediagnostic: MW5PR84MB1713:EE_
x-microsoft-antispam-prvs: <MW5PR84MB1713C36A36FF013FD676FEA188A19@MW5PR84MB1713.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Znt736w7M31ol40b1ztQ8vqrwdtdcZNAEjEY0gBlok+0SL5xIUMpg2RZaEjt5PtqlV/vpA/BqorigI9/1ytF+5PBQCNx0GijWIsqdJ051DhLop9swGwzXGJRcoyLFya3n2eQJ5LFTCISb9YT8P6hrltbnuVkqNYvue/q6MRff6NCXs5D2ePs8gSVzjazHjosMZBjJNcrsQ5vhjMFJqiBI04UkxlJTWl9ot21w9ep6ue2OE4bzxmyac0tc7eQoip51zANuMC9Z7pNcfEKD4mx5NylgrD/gWtUziKv5dz1NvldGx9WEC34vrbqb70xGWChw3U9bkJdgAhgyIhG0XV2LwiT5MwpVZpYAyq4PGPv2aGKs9Am5NCIJ+jy8XMIgt2MQYdAt2/ZctWwJ/PfLKIrr3TpTxEmBUI7wXkVzcm6Kj+udtVAe/9jGM9hVT2d5QQ8iHLrjDeQoD/PcZ0MpWm4Y5bJ4sXzavXZeTfQ1N2DyO3M5Rkly9jOsnhcokvYtWscin/k/rVfWgDyR2l0Jc92C+KpcLUXwnsYWQfTR6Svq5ccnZZM7o88tV8wYxYN8UT5KHf2P2ZRB9YRrRRP/Q8s7hJCuqOmYKYIX2sa8l6MGcTcsXHkFS0x2UKxyEFAfhvHKG9etCmJ2y4Y1Vh7n0wcgyeb9N+4Sr7gu+6K1o8HaqimheN33m3Kn7JxSiz+gOrQsoRcMF6YCxQOLQ4RXAoRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(33656002)(54906003)(508600001)(110136005)(64756008)(8676002)(4326008)(71200400001)(66446008)(66476007)(66946007)(76116006)(558084003)(66556008)(38100700002)(26005)(9686003)(86362001)(55016003)(2906002)(122000001)(82960400001)(38070700005)(52536014)(55236004)(8936002)(6506007)(7696005)(5660300002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEJVclRXcFZ5dFlJZDhOTVhvM3RBSFcwYlpSbGNacjhma3ZxMnpta3U5TlpR?=
 =?utf-8?B?U3UzU1ZueDk3M2VSSkFCR0xSa254SHJLZzRRQ1NHd3h4OEhKOGZwcHNmL3U5?=
 =?utf-8?B?NDRualYvbUtIY0ZmU29YZ1ExemdhbEJmTDZ1LzBjVHVyRE9scUtBa2tSQXdR?=
 =?utf-8?B?VkNvUnhnSUVFTkozRVRQbnRVWHlTeFNKWkJDYjhHN1RjbTdoTTQ0UG9pSEor?=
 =?utf-8?B?cm1UYWFxUVBFZW1rWTlXWEdBaEdRbXl2djBraUdIVVMvRHlReUV5amRGQTBp?=
 =?utf-8?B?NlppWFFRSFFCVEJUVUk0ZkZ2ZGRTTlZiUnAxR3N1dDJGdW50YnA1aEdwQ2NG?=
 =?utf-8?B?YnFyMFR6SGVhZ1ZGcmM4UFlXM0ltYUJOR0dHMnN0SXYrUEJEbkFkNFVoN1J0?=
 =?utf-8?B?NkJhYnIxdXU0ckVRRjVVRnMwbDF0QnVlS2llUTNWcnEzUWppYWRGdGQ5dXJW?=
 =?utf-8?B?eUozMFZITlA3YzJrTkdMTjBiejB5dWlSVlJMNGh1WUhkRHdYWXViQVBNbXJx?=
 =?utf-8?B?WCthRUJnZDRzWFBZNTh3d29JZVVoNVVMNnZISnN0NzZyTWgxSVN4U2FPaERV?=
 =?utf-8?B?eXQrNllHb0tyYXd6UEE4M2pJbkVLcktRd2ZkakRTSFhObWg4ZG5aUm9vTGFJ?=
 =?utf-8?B?RW5KT1Q4a1M4TGV6QW5nMkViVS9yYjVYK3JFa0podnJJTUttYXpHV2ZBSUJj?=
 =?utf-8?B?cUIva0ZoSmc3TFE3dm54dUlGMXo0YTJ5aDdoRVIwWlB6NkxZWnhCZGx6SUJV?=
 =?utf-8?B?YWI3T0p2dVA1Y0RwQnlNV0xjTHdEWUdBRnNWeHpTaTNTdUpoY1F1cHZYdzNK?=
 =?utf-8?B?V3lBWmRFYnJQcTlRc1FGZmNSR3Y2am9aMEU2bGtnbXJGd25FMExnVVlqQWg5?=
 =?utf-8?B?YlpHbnVmUFdBN3FMUU04elpOWERWNnVzUndkV3ZsNVlMY3FDQVNqMDdnUm1E?=
 =?utf-8?B?OUc1SEtGS0QvajlPZUJpY1VsRDE5QThQcWNRZjVoeUM3cG5vQkJrZysxWjR6?=
 =?utf-8?B?OW1rY2xidzJYb2kwWHhZRXR6MjVzNEY3VW9mUVFXN3FDcFdMNmc3MDRoMTlz?=
 =?utf-8?B?ZHBCVWtCYkdkTWZuVTBSbmJmSXZaRHdKSC9oU2lMSlR3S21IdTdDRTlxczRa?=
 =?utf-8?B?ME8wQXhqRFNMKzA5ZFFrNHRKL3dBcnc5ZytQNnIwSUdTKzY0d080eXI3c2g1?=
 =?utf-8?B?cE03dHNiVHd4K0xJSlZabjhONGczUnM2cjA5YW4rS1hhREpHMlRrczJyaEhj?=
 =?utf-8?B?TVUyMXpzZ1hXalN2dTJFaFR1RGpJU1JLM0ZhY2JaY0lDK21pOGh2aVIydElq?=
 =?utf-8?B?VTBiWTZ3bCtvaXZCeXN3QnlRZ0dtZ3BSMlUrSVRsSW9HQTVTRjJ1amt2WDZI?=
 =?utf-8?B?UVdMSndlb1FxZ0NYemNlek1WemQyaWV3dmlLVFpCOW9vMXFuS3Z3dmJjcnpV?=
 =?utf-8?B?czVuc3JpMnhLelJwb3h2cXYyaDByS2l1VWN4KzNlSSsvZ3psVW14MnpIWmlh?=
 =?utf-8?B?Wk14OUVyQXlDYkUwYXFabTJCbElHYXZJT0VxRFI2eHlrOENPMmtqck1sMVZl?=
 =?utf-8?B?dXVGTk1vM0oyVEYxY0hELzdzSThockxqQXk5MmdKRUVISVVERkNFL2QvRXRK?=
 =?utf-8?B?TDRkOThCSWlxZ01DbzFFYmluNXBFajR0ak13VDlERVZ5RTJDYWEwblpKNjdU?=
 =?utf-8?B?aHFjeEtHQkJuUlZuRWlOSmtQVklCc045cGdwNUE1T1RlckJQTzJCQWFlMTJI?=
 =?utf-8?B?UW53cm1XcFF4MThtK0ZNUTFtaXFCbmNWVm4yclpNU05KMmxkVTA2UUtSaUxo?=
 =?utf-8?B?U2Q4cWVteml5OVFZSktvQXJaQ3FvMTVteFBJNnJlRjJWTTRCK0RYTU9OWjNG?=
 =?utf-8?B?Nm9pN2lxc01sTVBORVdIRW5jYkJGV3cvMFlhc2NPRmxKRUFrT0RtVFIvbEFD?=
 =?utf-8?B?UE93QlNCMEhQOU01NVZIaS90b3E4UGErN1pPZDVRbEtrcTNCOFhWSzJ1eGJ3?=
 =?utf-8?B?aDdOYzdFMmRvMkFSR0ljd04xdGIyYXdEUEZHK1Jua1hLZlB4NVdISUtnckln?=
 =?utf-8?B?dVV2NWV2WHB5c0tKMXh5RVlNczlIU2c0TmN4UzZOTXArUE5jeGdvNVk1QUc4?=
 =?utf-8?B?eHlkdTNXWFE3d3ljclJkWUt0eGhMeEN0REYyM0xKdEtweFpOd1JkcGM1YnJX?=
 =?utf-8?B?QkhhdDJ1TWdrL3B5Rk5PS3g0ZWJJNnNsK1JDN2hLcWh6Sk5xMmliMHBqaWtC?=
 =?utf-8?B?am9kdXFVQTVqanAzTVhrMFd1eENlaWpwb3FQQ1lrS3Q0K2FOeU0ySEJYNkZM?=
 =?utf-8?B?RWk4bkhMSmZMR1BzY3FwS2VaMDI4V1JPd01NcDFibXNQNzFvSEk1Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99598428-509c-4d6a-dd95-08da4575d6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 15:29:24.2922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZYmUU1eU6CMZzxBIXYjAUL4AADrgK8DGxqwbG/O53UW54kMd5NXS+hpKPbAJ0vGSEKxEbwoPVv0b7hVaM0FHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1713
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: sjm4hNkeNvZUJ2ap_W5XxH8iowvfikX5
X-Proofpoint-GUID: sjm4hNkeNvZUJ2ap_W5XxH8iowvfikX5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_05,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=488 priorityscore=1501
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030068
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIHNlbnQgYSBwYXRjaCBmaXhpbmcgdGhlIHByb2JsZW0gYSBtaW51dGUgYWdvLg0KDQpUaGFu
ayB5b3UgZm9yIGNvcnJlY3RpbmcgdGhpcy4gSSBoYWQgdGhlIGNvbXBpbGVyIHNldCB0byBXPTEs
IGlzIHRoZXJlIGFub3RoZXIgb3B0aW9uIEkgc2hvdWxkIGJlIHVzaW5nIHRvIGNhdGNoIGVycm9y
cyBsaWtlIHRoaXM/DQoNCi1OaWNrDQoNCg==

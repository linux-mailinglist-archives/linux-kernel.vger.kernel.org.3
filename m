Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662E44B723F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbiBOOr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:47:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbiBOOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:46:03 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EAC11942A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:44:40 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FEhu07022175;
        Tue, 15 Feb 2022 14:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2g34oeaEstuR6k1KnVWoqEnaAj9qxbo8IU7t0rZ31aw=;
 b=dp86RNqIH1IE+6vVCp6b3yxa1CfNgyK7eqINZ1Ch1XTTu1Wh+MyG3n8Fc6c+ffKB8VKi
 LZBCjrCWaBGEUQI31daWrZMYYPAm7sqGVRcbdgL8AsC/Hj8aXTKRIn7E2BYtbmQViSY/
 /E8adMXE/W8xNA/I7eSh9mcaDS1ZD+l0uex5nPwnPz3TSgoROgfzy0uCFfA6pOufgc37
 Eat1pokzxhpOmjh7L2svC+RvVOT5i9emgxrSDsTJXp6SBQ3o/yAtzF5JJhG0bXAnzTWm
 fr71LDew/i3cdyW9N+AqXomKKPrlqFJnsTrzUYTUwxTcRl5Am1Z8/ouxNmMSfhV16kBy ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r97jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FEe5V8157068;
        Tue, 15 Feb 2022 14:44:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by aserp3020.oracle.com with ESMTP id 3e6qkya227-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 14:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHtjMOsR2E9iwSMoypU+zu0JhHmF3zVY64N9bjfKqDf1qW0QegIHwIqpJxhHkxl6+K6hoNmmoZXzwiwtEW5dY/O0wtR33vxlWlRu7QjSlWhHrQIf2K5PJ750ysUt6JTuHTgwCfzXWNFZWjbuR1J94OlKbTM4oNDYg6uXopcB8xYra3gwPLSYVlssJO6y+Ix79+bXUHqVFFB1X6jjuS5C3qMokepQpFW0EWAJJ0oPE3n2uuaOGJ113QsfIIC/bKa48I9fzd9gSML0b4Er0VekdE9oPzl9R7kWnA2xnumKIs/UX8AJ1op6hEUhPtk0k+dwz1Z6giRVZ/NTANmtz/VaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g34oeaEstuR6k1KnVWoqEnaAj9qxbo8IU7t0rZ31aw=;
 b=I8ODKaAtZXnyhkmFbFXdd3GAUUSeNOR+o0iAsLmEuYEZCd3rwBNV9WpHkYCAOS5fsp3J1Pw5hIkewuliDQu1ip77C/ozPgPJRlyTB2a99+YhNABb8PFoGCKRE+6302+uyw7aM9jfF7inw/l+gJuN6KsEwvvp9MuSPkAlLtZtIPVEOASJDgXa1CAQ96fFAqRfhGBhiJYMJy8q+YPIPEt+mgZ8FM6IwUV7spAvAn7yRtr4cInFBD9h1CV21fldxzBPqYzcDCgo98RKL82Lyr3lBZ2/Prmd5DQWR8UP/P8MzEvNxZx8rPEQnCcTDQlCubjnzsRYkBRS0J8pUuNwT4b3FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g34oeaEstuR6k1KnVWoqEnaAj9qxbo8IU7t0rZ31aw=;
 b=S05KwP33+T/yhtN+/pmi+YFuWQI5diDevyRegF5x3odGUrWqsMuJpJQB5XQsA0nMVT8xhMjCIhn+0jrQ2NcYNBvV8wS1yON5CYQ/NjhN7spT5bF2x9t7DxltIFVFJ/ZqN7COp+l0AYQ6p554W6VsLEXz/9EVMTi1JPfi8ojaKgY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1863.namprd10.prod.outlook.com (2603:10b6:903:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 14:44:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:44:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v6 62/71] mm/msync: Use vma_find() instead of vma linked list
Thread-Topic: [PATCH v6 62/71] mm/msync: Use vma_find() instead of vma linked
 list
Thread-Index: AQHYInpjHUEWWNQ6MUCOfqD9MZRPwA==
Date:   Tue, 15 Feb 2022 14:43:26 +0000
Message-ID: <20220215144241.3812052-62-Liam.Howlett@oracle.com>
References: <20220215143728.3810954-1-Liam.Howlett@oracle.com>
 <20220215144241.3812052-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220215144241.3812052-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52a4c0cf-cb6f-40e6-4463-08d9f091ae6f
x-ms-traffictypediagnostic: CY4PR10MB1863:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1863210CA4309D30BCAA8D6EFD349@CY4PR10MB1863.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZusC7cf9HWae+sb4q6aeQLQe0VvvNoTbBPkeScwY61WDu1nJubZPdMJTkwXdTpWr187IxR31j+NSIDtQyZENb5zI9TXHgLAun2CTVlmVHlvBrWtkf0Sef55kIpDY/jBbCszqxNuO26Kzcgn2v+OSKf/NW7sSodFFCovFUIr7ptBtNbARzIVSQFkCGUT0yiPq61wE0SjDWSW8gX8et2d+/cTesEz4r8UET8PTSEwXszjgC/4mZA9Wzeo7ZeiPoTcC18zbPikjmvBc9WxuVSlP+QNc0WbEbvv2imOuegW0vu30tTmQD4cm2fywZ+V9HKTX76rRDrkunjYDG5iyjoLhEZ19LbDuisuDub4NWBP9flT0mNyNAcjvf6ji9t8IErDJRYtmE76MSKaAwLaK0HF55/mHH+ceozYtdqT9LANYBna2V7cga2h+kpiK7sD+RzLzqHAks4EAJajt+t2mBEZhbUBckuFdOZSl0cp9cLGP8mrlpJ/kCl3sGoxwsS27zu+f/Av5svEruAJWkyXmuVKfEs9QYeo4tjY9jbs3OLExZPOu/NcLq2y/Ajnksizbgf57TShdEhNZxxRSwRMwfNXe4OVf/ypvnDnwvNIxXbpa++mipFW0yVeTHvlmYRvorK0eXYBBBqyS1e7BNTzPd8igKa4yhnJTzi47k7+pZNHSfTNlblF6OzvkHrAKf203hrKoMctdkm/+BB9NyPY8Tg/0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(86362001)(66556008)(8676002)(64756008)(316002)(2906002)(44832011)(122000001)(66946007)(66476007)(110136005)(38100700002)(76116006)(91956017)(6486002)(83380400001)(1076003)(5660300002)(8936002)(186003)(2616005)(38070700005)(36756003)(71200400001)(26005)(6506007)(508600001)(6512007)(6666004)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zFPD81oj7FH9hFVdX6n7TVFtFavQ4aM/N7e0t6U/cf5IkOTMlsaQX+tJCl?=
 =?iso-8859-1?Q?PU0KWLAPl8xAdWfk0HOBSItdvwvGJsQy9zx8dX+IjJvdhiKSOplNwFVYyg?=
 =?iso-8859-1?Q?fjGO9E+QmxrFbNRNtyf2IWTfWfJOUzCVuJ1O3DPdXqBaSL4FZXh4kj1J0W?=
 =?iso-8859-1?Q?AgYU+mQb4ePCW8+WUunV8w/eD9yxSn8y1JzETWdMS3XikrN7dcaROobDdM?=
 =?iso-8859-1?Q?hJqnXN3q4DaL9stSy2MC5Rj7UqE4p900WWOcxKxjvP4AnXEQ5Y4KM35+0x?=
 =?iso-8859-1?Q?Q6aovTjXNHByAlkPWmYY/OCSjhl34VJl0ENCnQh/rFnX/l4HWtR96WyjJ2?=
 =?iso-8859-1?Q?JwfMp9PtZ/dAD67iZgpxa7U5vDXygX4hFYD02CAVGpOd3hBSKphgJNN/VX?=
 =?iso-8859-1?Q?bUCzmXMZBzzj6cO7AGERK2fZQGhuNUMVPA0gjFpjjcPq7zEDUL5rLASBnr?=
 =?iso-8859-1?Q?TwiKZA+PSF0d8tJDRKJev5/lv1Q7OQy/KNHS7VyEeZjGVMdCAfju+/I/2Q?=
 =?iso-8859-1?Q?H8Te4EAzSrGwUe721ypEMEA7fYnLESgBH6UdSmakCJ8EZcBNrt3gqTEOwJ?=
 =?iso-8859-1?Q?9n/8MEav4QWZT8shVhdBChpSWoaTSQOhBuz5sA/NnuuWPUEqxmCYKVCKMe?=
 =?iso-8859-1?Q?j2S/u8bm7HrCHKyFQ42LphpeZiTHKqOhBXeFItIjmjPyXZRuHstuu7OoAC?=
 =?iso-8859-1?Q?LfGvVz1zAl7Z59kgGeO5qhL31JknOm3JGLgE6IONc+dkQV66ZWxfFUU4m5?=
 =?iso-8859-1?Q?SYz0Iv8vshfpFNV9CvWGGmcLrrwDiJNbbCQBnnCVgF/kkAHzSBtTBCRgYF?=
 =?iso-8859-1?Q?2bQAgH3iGkXqaQfgRLjpE223je6H0t3y6z6AVtN0if89B8XAQoqV+otzkG?=
 =?iso-8859-1?Q?E2Ymubacamf7tLp8XgP2e/wJ9Pxo1wGQAH0c0QLP//1ANIYUBwotUq+6NS?=
 =?iso-8859-1?Q?UOgvcNTzol1fYYmCx5+DleLY0GkEzCCD/r1fl7KfNSST2bwEyiYpF5ogVW?=
 =?iso-8859-1?Q?D3Th66gFUC0FCvRS+ONyzZQ+0MxUm3lk/DgpSBKtlp3oMmHSdeWE8Sxg3u?=
 =?iso-8859-1?Q?IbdGygp5HXyA2F4bcewPFubCXVbrre7Z/Ku8D0bvcsUfMoN6BBfU79UTSG?=
 =?iso-8859-1?Q?8C8kSei7vBwSA127T+s+leXHcrkYK8VKYnqQSXfoY7xPzES2zh0yDG4diP?=
 =?iso-8859-1?Q?5SorIQzKOAJ0RwLmbmbCX2xBfS1tLbTghJsufcShNF4cFHzVpwHw3qvC2d?=
 =?iso-8859-1?Q?xlGY7OvmE/yqQ/pxAMWHtZdu9tqdDPrVcSdYFtIYqpS8a/TPRhj7cOxPUG?=
 =?iso-8859-1?Q?FPkoeryJpJPDNfX4eHBxpB/eBCOJtXAgQP6Ph9yLzWkliVYwfdgVLKIlMY?=
 =?iso-8859-1?Q?gQ5bfZpn3zmWPTO8+fl2VqnRbpTYE/M6/4Cn2XP/OIn+e8DI+wmU/VHspn?=
 =?iso-8859-1?Q?GZN86fDGC3O92S/LmkhgHCBGN4dMeB+uWvpmxmsRCZJX0CSKrVwBpbURFZ?=
 =?iso-8859-1?Q?R/bdtAUHJnERsQMDMSlXYotn0aFXzTqmt4O8zlAshFWqoL6xWBpoQr6Dvw?=
 =?iso-8859-1?Q?vPUNxKhbI7OesSI4y10nRgdYIihqnHU3l3NMGLBQKPBxxv6OIojoe4vGAq?=
 =?iso-8859-1?Q?O9xrJ1D8eP/DZON9SHacoAu8LDLsUY5oP1mfWs42xkWCM4FokBFVFlP/QU?=
 =?iso-8859-1?Q?cmskWn5mf0qK+xdpQGE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a4c0cf-cb6f-40e6-4463-08d9f091ae6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 14:43:26.2445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IpYni3V2cyGsDXbQ2aUUzOdDjpVstu/a6Z9VJwczG29JZAFdkVtuBb7uz0UeyeQZEoIkGM+5DhiEnsnHgnnydw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=968 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150085
X-Proofpoint-GUID: qPk3mw0I5TxCvoqtTCfjS1UD2nRauZo9
X-Proofpoint-ORIG-GUID: qPk3mw0I5TxCvoqtTCfjS1UD2nRauZo9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..ac4c9bfea2e7 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D find_vma(mm, vma->vm_end);
 		}
 	}
 out_unlock:
--=20
2.34.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C7A512A46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242191AbiD1ECE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 00:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiD1ECA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 00:02:00 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915BB83032
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:58:46 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S3LY5V023554;
        Thu, 28 Apr 2022 03:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=J3PF/70ppGlVrRM0zIxYlLu2rF7QstxJltSpWllQs4k=;
 b=MOJ4DpkqnipfktyuCFHBG48t5Vnw8tSj7ph9CajRHYODVkG6G1uUxQ8PZBCG36Tk+cMx
 8udaa3Dz8rcp080Fbix7Zr4QwJ6W9ynkzmqBaptSbfhj2SAYnhqTDQpsWcLy8kZLIutu
 IyKnILDwL1VTBNV4f8c4xy0XCdnqRbi9FYlBZLxvgOOdWj0ewvAKYp/Tc/ukg5T1sPsL
 ZdYClAeN1whvzZIuGEkB+eUz87SPU3WDbKzoDmkR24BjeWwoc3XGCVrArXyyyF+cKjkZ
 QX13iQHHk1O9cM4c3ZUs4x+RVPm4CX+zGWOhLPuBnJmqtn6Jj5YDVxQIpKf/wZSZY+gp PQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fprtcs2sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 03:58:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5eUsumyf4DB0KVMsSWltj7/VRdLqIGe7BEu3zVHCtKK6NnLIIeusX3o1HbnS+usVRcw1MGdKuaPTwsqTiF4wMRWBnGqqoU62NHPzwuETOFWFod8+1uUQrJcQMfol3/0mHVcsAvKx104R/J/IxnGSgvrnHx5iIHPR9zcAk6Gw5Gthz4AE+GswF8Th54QvbiYP5PKn7algsSoAXLH3PEczatoIVMs0uXzTVV/1IIP6JsGWKPRi1lYaSJ5/P3+/080brKOvd9wWlXqurCnafM4jMXYGBlcP5hnMBx4sjn1QfRMVyZyW6E4clGNlXcok+zkXgisMMfKUu6LO2F/gKHpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3PF/70ppGlVrRM0zIxYlLu2rF7QstxJltSpWllQs4k=;
 b=TkTN1IqCyCqdO1VliadbTNb9mpzSK3c7RdphzPIByPQM4Ez4hpzXOjCpey8Hy4FTxwFA0LhiRcJJiO3yFLvyMWj0H8ULHdup+GE2lFOY4j5E8g0VboRGUFPtRPL39nmrieGgTG9HQek/rIar7q6zWPDzWhYk37AIN+cS8Mto8k15k3pTC1aHrpkC/oNCTcRCchY265BE1ToN329zZCYRZaM2GoH70z+4SGY4nu4uuNIHQaDkBrzJuDdoRwdQyXOlbLnZXnQgPsehqxM2Q+O4edp9ptp9DWbRy6MTTVHCQwNNHIGT2eRdybF9f8QT1D8ecoKkzwv39H0zb8x71b3a1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 03:58:42 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%5]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 03:58:42 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] scripts/bloat-o-meter: filter out vermagic as it is not relevant
Date:   Wed, 27 Apr 2022 23:58:24 -0400
Message-Id: <20220428035824.7934-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::10) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: feb3b63e-5d4c-49a3-b6ee-08da28cb6296
X-MS-TrafficTypeDiagnostic: SA2PR11MB5129:EE_
X-Microsoft-Antispam-PRVS: <SA2PR11MB51292F764D1C6F0EBFEDD84683FD9@SA2PR11MB5129.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ZCjZQdfFHZjGuX6yFATCtLzNjT+YIgrqTbY+ufEIJYQ58cc5/1b//WymTDLKkMuZPDUgF6v5mGiiLpySKV6RwalkrwvzMQsJKD0AHWbeVT31BXRqLXOPvB/1yFCfW85Nth82bhkz1McT220Mbrm9M8HZC1y70SCf/PeDxx5Kh4mlAD2a6KI/pKh2c+1iBA2T7c6SY1xD4f8ylrIUgd56VDmo0TXVceLJSGaC1fIrMC+4wDjZkFiRFeKbwBUs9MfIBImDz+h6V+SglVyyxGtnS7Qz6NQ4p7zNDQNJeaCprkAUfTXrrVxLuYNqqumsph1RjJnuCSdFgSBvIMw5Pm8tMhz9HZsU9xOrIS/SueIBSbGslroHVwRAZJG2rMlUS+noYIqCnBR51xkDeSX0YOspOptiWErcEujUp+wMuLI6oa+VO6gv/G9FCFKHC7vRcE9iZkO9qMoDXA200UMQ7H8QzofN9jWdFiEfrFVnfAhgeV4JO7Jj5U3+U0hbbTGeKZmyXYo/0XugdaCwHOsJRSZ+theOq0W3BaiI1yxXfilAN349NxaS87Fr5bbOegEohzNAc+UwMQbfs36YDxy5MBbQ35EeLnjW503D4uscjtueVchJX3NMk5pVa/2Jty+b0t5rfnEoH24lLphlVPE0gZjqgq5PTUQQs8Xa5cY/x22G3OCSZDPUgHoIfUQ6SPlK/f7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(6486002)(38350700002)(54906003)(38100700002)(508600001)(4744005)(4326008)(66476007)(6916009)(66946007)(66556008)(8676002)(8936002)(86362001)(316002)(5660300002)(44832011)(26005)(6512007)(6506007)(2616005)(186003)(36756003)(1076003)(52116002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?joxAp1BUVJLukbKVgC003Gn9NW1vwDxorw6Qx6cPEshe4qcZJ+nVddjnhVxk?=
 =?us-ascii?Q?LqiLnNZQV3zf+CnKHKFEOnV/pTIkEf8GvzVlVfJSj0lqebdVO/rGKd+PBpbh?=
 =?us-ascii?Q?zrJKBmoe3WxBIiyjAUtitJNaMOGNdfGYiRS6bUbNGuxu4BcxvQzB6KQkgKdC?=
 =?us-ascii?Q?XlfPzOTm1KmwEeVBYS4w/MUb9AElbiHDV9VzjS3nH9M8BbXWmNeYHpkeqjN9?=
 =?us-ascii?Q?7VudO7erZKd8V+NGvtlTYSwLDtcd6C4lNmOHKZy3VBafnyVjlgX/ONRDHOxl?=
 =?us-ascii?Q?5COHQj4NHZtPp6UoUewAJ6iLF7Y43U8i0tglnEORy19mJs2RUdOxHxKdKUIR?=
 =?us-ascii?Q?m12X8tZuUyVuS1AjgEV5hddaPM+g8DDFbww6G2XEi34jchSUlZ3Sk7j2GV8l?=
 =?us-ascii?Q?ekdzTGSZ6ULIDkNXuLKpmOaS/jmKcFJHL55EqYYeLG2fke++JZngciI8IemE?=
 =?us-ascii?Q?nn6FBhiw/xVOhqA8kiUSaw78X+QGGgvudNwAa7gxFBvq4Nqoa8Ux4+x16keN?=
 =?us-ascii?Q?wrYHKhI5K+OcOyjKknbyMVoljBUrEi7m0eov7kKQjOhNhY4gW+ZQkmkqcUgD?=
 =?us-ascii?Q?ymqqs2n5RIm/7K/PgzoV/ZfQBWVNKJD+3Ls9s+taxE44RAhuquH/yOBw6Djk?=
 =?us-ascii?Q?Dlaj6a5lhJvA1Zr8L1pGRtgQtceWVLyfUxD8hYbN1Cx9u8LkJ43hKEmytN4q?=
 =?us-ascii?Q?PKssvpPxhY+nfF+vd2eFsGsjP60k1nx0t+nLIi3+1kJiV9CN1UhIIBb9678t?=
 =?us-ascii?Q?JF48dAZRPwGJMI7AOQl7D6TRvVvpRmIIAO14gVoiOddM9fD4jA5kfq3QO+Sm?=
 =?us-ascii?Q?i1wPgd21+COu/ElURWV37T7WMEraOxwsDTMwwqkuhBMFAvW1jRsRQKaOg0mV?=
 =?us-ascii?Q?iwGv1cP2b51FOo2Xu3iM1i004WITrc15FcgEYo0zd0D6M/OSgEcaF6orbr5g?=
 =?us-ascii?Q?kC1Id1TJFoNzmSca75b5xq8kdHpVPU0I4bef/wBhsP6kmX62JnQ3oqJKBzSm?=
 =?us-ascii?Q?3c85pu8UI+Xep2djwbAJ6BAtmFxu+C5qFEZAlval087b2hpwURYxOF0eYQaf?=
 =?us-ascii?Q?QhXeC3kJgPUnSEHRHacATwA5pa5SLfC2fAMpihpzhrClnvcNZC6Yk+O28wT5?=
 =?us-ascii?Q?eVeL97RIwV7RU/uNRfHBjXQWFg5kKhlE7cKvH+uYE0wkkUw6ZWX2jdvRCJn/?=
 =?us-ascii?Q?6TtuYRzNScPQbRrAt0mmObBlt4JvetoxlI07ifY6pfCeNOUub/yblxO+2m/F?=
 =?us-ascii?Q?dG2bsjV/C08nbFG04qyC+vbEiALUav+LRlWNhHBMw3LsVQTYRIM0at9X6kq7?=
 =?us-ascii?Q?AcGlb1290aMFZlKVafoQtoe+LEGGvDBaCp7Y7ByqmhcT9NTW8OBse/Kv3yv5?=
 =?us-ascii?Q?n/ENdODUcKZ0Dbh71gtqFdj5D9yeHduW+hXJMGTdXtgEoc5xUrxPPqRYTTog?=
 =?us-ascii?Q?QeLskeJMHfiEvKIHJ8mNZpqBI/IVJL0qBy2qhE3vs/nVUt9418Wbs7E4/b9P?=
 =?us-ascii?Q?AgUHL2jwcX7VqS6SQaqYYjNvKOlgt3gfl74NjCYt5/Iaf5paefwsLyabMcEw?=
 =?us-ascii?Q?8DgQEAKmZs4656BhslI6dsMvc/sMra6Rcfwt8PsFgOpiCyYGXq2CnBPRxPsQ?=
 =?us-ascii?Q?UmX7mluHkJ24zTaJNC954FIGJ4kQlyNnZViUxO/itAEfpZ/YEFFPusXgndsr?=
 =?us-ascii?Q?l/UJ7CyK2kyIe9aqMl7Ab4+Iis+O1JpiFwJuDwJg1XKQZ2iQw8OBrRFXYP85?=
 =?us-ascii?Q?Tctl2lFCc3AjeupTMk7ufpv8K6jFR90=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb3b63e-5d4c-49a3-b6ee-08da28cb6296
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 03:58:42.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHsBjlEAcE71wmRZW7Mpraeyj543A2ofsPUfVLbyHJiC0f4i/sov7WKNfmnjwby05XYIN6GJLPAycpb2PXgvzQ5wbOo261QmciYuB5jzKzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
X-Proofpoint-GUID: sv50uuIGkUX7n6QYcTkSEY5zjvVm7482
X-Proofpoint-ORIG-GUID: sv50uuIGkUX7n6QYcTkSEY5zjvVm7482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=853 mlxscore=0
 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280022
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing it as a false positive increase at the top is just noise:

   linux-head$./scripts/bloat-o-meter ../pre/vmlinux ../post/vmlinux
   add/remove: 0/571 grow/shrink: 1/9 up/down: 20/-64662 (-64642)
   Function                                     old     new   delta
   vermagic                                      49      69     +20

Since it really doesn't "grow", it makes sense to filter it out.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
index dcd8d8750b8b..4dd6a804ce41 100755
--- a/scripts/bloat-o-meter
+++ b/scripts/bloat-o-meter
@@ -36,6 +36,7 @@ def getsizes(file, format):
                 if name.startswith("__se_compat_sys"): continue
                 if name.startswith("__addressable_"): continue
                 if name == "linux_banner": continue
+                if name == "vermagic": continue
                 # statics and some other optimizations adds random .NUMBER
                 name = re_NUMBER.sub('', name)
                 sym[name] = sym.get(name, 0) + int(size, 16)
-- 
2.17.1


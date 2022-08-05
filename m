Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272B058B138
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbiHEVqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiHEVqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:46:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF8876449
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:46:49 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 275HHCiQ026098
        for <linux-kernel@vger.kernel.org>; Fri, 5 Aug 2022 14:46:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=YIno3lv1CRYNO2Nu2QMz3IyBrp4x0sl72sClHK3SpAY=;
 b=rbXfokB4Wxuw8EPTaDBNOSE8giDwLsIgO2bBKG9GO/Q4zBATgQu+EQ1Y4/AUch1glOSB
 fKwV5z1OIKM7kWn/nasI0tZI7/W9iNyZIRtDp3HW6p977PFXA6LjHUJ1VIi+iGw5N77i
 NL2gDFo+cw2RuuVU8Zv49x1VGgGls7Y+CsQ= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hs6rg1xhw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 14:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv7jaSVef68ysxXNpExeTU5wNBkr+BlRPimq++98E+3DUD6u6Hf3qmCzWzXHJRwOhTetrM/LU7Ys0/vxlveueNcLy03mD5PbfRy6jBHsZMsfEt+1cOk4AYRLCDYhiv9aHTMvBcR7XqN32r8u4Pkv7J3F3ICx+KA7p1/g5pRPo6Orzxsjsg9QaKSU6ditXXTY9nIvqsQTtzoJXBtMFahLy1/QOk4iE5kSf04/QW84WGrrkPoWByAeZzDkSIPthWRHosAO8tqO+CSi9ytEiJzjgTLI5+T++TFQB11TB7BSMJfPxkO2DdNItiEbxoaE3XddUg9KuXpS2MbNaoZiBeKGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIno3lv1CRYNO2Nu2QMz3IyBrp4x0sl72sClHK3SpAY=;
 b=AoxJZHc78RSqO7b5WvJmurZtdOZgJFV73JWxycBeBrx6HwOzeY8+Uro6RCul2BjgAmuE7m0YTlu8ApAzsNG5Sq3SYhjzdHtwzSR5Wtw0Hj6gC9slR80DaMfbEgTaCdkm0ytW5PMCzjQxKD/gSEp7g9WTIXIRnKihfmaLPAbddJ3o8dt0ZUs00ytSDpM7KD9YInUZ3ScYlIWekNjq2exqV02O3SkKyxR1qkWhgpqHhPB88EwUe3f6vPGQOjVALTjYfnUv9Awi6CUmZnM1AnoMi+KmLL39RTvNBOZoWRX74xZNWP2sj74xRCuwFlSV6WV8IvVPoSZqrWv3JSvGtwe8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by BYAPR15MB3253.namprd15.prod.outlook.com (2603:10b6:a03:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 21:46:42 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 21:46:42 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     William Kucharski <william.kucharski@oracle.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Topic: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Index: AQHYqRBThWx3+ROj9kK56+lh+SclzK2g15GA
Date:   Fri, 5 Aug 2022 21:46:42 +0000
Message-ID: <4875F747-54AC-4820-A3DA-51B5A96776FA@fb.com>
References: <6210179C-4DF8-4C32-9735-3EB1495CDB3D@oracle.com>
In-Reply-To: <6210179C-4DF8-4C32-9735-3EB1495CDB3D@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 323f8f7a-20f6-4140-cd94-08da772bfc18
x-ms-traffictypediagnostic: BYAPR15MB3253:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lw0OYqQgrZBW1RZfJquGUFc2X7gCKO1hOAavH/N0bjA1/zHLhVVF+V2fIBZLtuClfVtUDUojV+CE8j1jgqXUyld7A1Qx8VUsO65XDeTGhttEvGFPHfwlMj5iIc5Xoy2zNpxYFZc5fFc6IQBIiIXF2aVjQp4etuE1+HqWE/mFJjZncognOuGsc3AjpNXCxxbT4buwFnoNttoXeEuYkXf8zY+BEaRthfMW+vz818bS3d9nOXKmDkq96pby64LaIRTmcnUDfjMeBgRgsDS9HjZJ4nRl1NeimOZA1QPJENbQ5tdoF9225SsI/VV1jOQHlHsC/YdcgST3+WE+ZStxyFRaSFk51gnTlt7JbiQihGBj7I7Ppvd9++afkTrwg5trWXuNmhXdt/Hl6UhSdR3d+1OK0Rg4lQLJIJDetjSyvfdF5ltVEbC9YmX4PcIqLWaer4ax+ntcFLWIYNlNQtBZo044NHiE3kFWpf/G2s1lrRxbn+YskCAn8+KHVFhIFgGARf+8uAY/SU60TLe9+sN3FkUnDB2daYfd85i/ACA8VTcPAHqknzn4dMa4PtFPJT/XaPxzGJoI6EHNrNtEK/6criAr4n5yOnhYqxBfigjM4WyYrJmv/C8/63L3OD056OG/KwecPpiyYwnqPdYiadOyeMKFUG1mhIgG1vlc7IO5mWjVBEcvf+nq3HtjlMh79gs7qcRfICB4Ij+cA9vmJCL4h+IqfhDPsrGH7t6Y3Df3SCCdSZKrlhXZ5QZCOHemHp8ZUwVZmVe1cZ2xWUj8GCcVELfM0b9BPdlbDVlWY7vy7uudipVJaCNEME5+NkdmTEZZNrA2/Kb/EGWm473Ar6XLrgCrQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(6486002)(71200400001)(33656002)(4744005)(5660300002)(41300700001)(2906002)(6506007)(478600001)(8936002)(6916009)(36756003)(38100700002)(86362001)(122000001)(54906003)(2616005)(38070700005)(66476007)(66556008)(83380400001)(6512007)(91956017)(66446008)(4326008)(8676002)(76116006)(64756008)(186003)(66946007)(316002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CbgIa4R3FVozwOYjaP7DbVtcaQU6plVKPAUOUXW7Fc4su1T6uLuPm9b4e4K7?=
 =?us-ascii?Q?u5pv6EemYELmNaI64qZ3QCHj4gDmp2rxTQvpTwOQapOR/kMcIiJTzIgGgXK7?=
 =?us-ascii?Q?cnD9fiSgwJB9qOx5IzjWwbqwDj6fr8KybJqCYAxMX9oa0W/KRt3XDzA+rS9s?=
 =?us-ascii?Q?kNL8j7XTzBn9h8ZWa1gX9PvBDUAnbHIi9v7qNw5mkQiihBAYNZfjLukfAxrj?=
 =?us-ascii?Q?3xbNFo8UfutkxRwtOo/oS9bf8f5zAl75OZHItX8OEsdX7cwU2NDglgm0m9dY?=
 =?us-ascii?Q?OWnPm5Ka7HLYjaOPFZEvK0K1OqYgdT7KlpIgS++k16sLi+T6X/QyRiD1USK/?=
 =?us-ascii?Q?KaUA71lRhGOLQ2PArBxSSZCOs0VMvnKLVolzLJRZ8SoW+EdGdO9alSrTmDnp?=
 =?us-ascii?Q?l4m+ypNvolWbtZl0gehjYH0awp+ZXGgi3UJa+qkkNoQIwkBnUp6vFj+hOLQ2?=
 =?us-ascii?Q?YZYj0RBZzfd2bkZ2mOBabKoUA1D5vQ8kTsGwJRL/bBdtbLy2kdjoeyApqBV3?=
 =?us-ascii?Q?MHGwnGliSThdRSDEOhcnrDg54aiE5SH6HVN9/h3m7Ao/MgSxaQJTHk8YrfFV?=
 =?us-ascii?Q?eYrUke8gS/iPU320yGRW9YK87r0lQbx5/DrLwpAx5szoQ7axuzK68tNUkhH9?=
 =?us-ascii?Q?e/bq4PJC6TiGi7gQqep+gxO1Vy/goCoWU+b+H0qWLOTXRZNmay+omU2TSYOY?=
 =?us-ascii?Q?A30RyH0CnVsAcHXKeLorPSrcpEiQM8ezh91vOffWS07yjpUITEqLqcwCypLC?=
 =?us-ascii?Q?+UiC5tmWSmbASqagrFAIbMKrpvA3Bb+FEThMCiEQbngy5+09GITlbYX1v0gL?=
 =?us-ascii?Q?KH4Cu77S3xhA6Jbw6vu+MYVGFMjAGtn8g0AggRPulfI9ZndspnI5niZQrTtV?=
 =?us-ascii?Q?x8uvRRQYv20rU6taT1QvGXWq2VHG84vKUePJviz2IM1hk88GuREXLXcFkDoZ?=
 =?us-ascii?Q?9Y8bZlQoOQxZPMdcSeOGHB1DuQ3IMaNZ+WmiWLyNek8y8MQg/yUrHAbKVC4T?=
 =?us-ascii?Q?FPPIcH7iZJbpQSL4b0cYqm0X8ctenh1YQeGTQde34hsTxpnjyDXOhZZwal2a?=
 =?us-ascii?Q?V2y225iYffjt49BIn5NCAWSqk6H3gocpGgs4ZiTYsXx6KzG57LSwaQCbKEco?=
 =?us-ascii?Q?YDfNylA5tn6JepM7dUsV4QL0/GG8iT4gE7pPdUWkxnOmU1ZvjVdM1hgFoPo2?=
 =?us-ascii?Q?O6saOvCuYrxEKHcwCheNP2KPNIiYaV3Q9paQyrUqaa5gkbentLlfd4FMIGla?=
 =?us-ascii?Q?XGjXhNZpoV5/3/6xCvKUdeS9HlZbaADpMtfiIz9BpOIplaTqUPA91u0na8Q7?=
 =?us-ascii?Q?zi/89Wimcecmo2Ss1oLbTlrEQn4QUeuDlOlcovQ/XH78sF/ajJMMKtOdfDfV?=
 =?us-ascii?Q?LUFL77yl4SUlAqgPnmUvRNK2IDmaJZghia6i7B1qVR0Xboa4JXlkHHzYPR79?=
 =?us-ascii?Q?T6SB6wwv23vFX/WVg7wwxrNgHRTIMo4wZ9W/hEH8YSJj7m57vNeEoKZijhBn?=
 =?us-ascii?Q?0api3F6gC1uL1cpCKbP5+1CmTUwI5Lvj5yiF9D/6qAGz2mxQTsnb+FoQvC2F?=
 =?us-ascii?Q?UA4GfKX/Am2koBkqhkB8bwJXTC9cBnbaBD6PP1RPaAVPiSYSJtg0eeRb5u2C?=
 =?us-ascii?Q?e1obOyjywBNalxPb921C2xA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AF3DC707B6D84F4694B7B7BF11B9A440@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323f8f7a-20f6-4140-cd94-08da772bfc18
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 21:46:42.2660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dqhz+MrHbpEtUidFX7CrzEIaFx1GbNxsJHNEZoSzLZyDdxPHZ5mklBB6piji45Qa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3253
X-Proofpoint-GUID: 1_xHldlb5458uZDtcJT53B6OqjShaSxc
X-Proofpoint-ORIG-GUID: 1_xHldlb5458uZDtcJT53B6OqjShaSxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_11,2022-08-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Out of curiosity, do you have any statistics on how much of a performance impact scanning may have?
> 
> We've reached the point where we've finally been able to show previous admonitions to not enable THP due to a negative performance impact no longer hold true, and I'd hate to see systems on which enabling THP now would cause a performance hit due to this scanner.

There are no noticeable performance issues from running the scanner itself from our experiments. As written, we check 256 pfn s at a time every second, which does not appear to be an issue. 

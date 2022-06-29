Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3144255F259
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 02:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiF2AZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 20:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiF2AZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 20:25:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACE2248F8;
        Tue, 28 Jun 2022 17:25:50 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SMXtJR031263;
        Wed, 29 Jun 2022 00:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=An0ODL+Yja2FJ2SPIimIPek1MCwhvoc1rXsLS9EE2CQ=;
 b=BQOl9Qj7ZOuOX+s7zzjh3NfshaEX0bygBueWKIwBSALWjH8UspGSyE7gyJ7L3mtyaIeG
 +e6VWbDyoyCNNEeMl4qGB1JYuAjFLLh63pSm2Jx2IbeOftkontcT5J2Yns1d3djrmymH
 Baimpmjl/DbBL8ybKoimt+2/Ep8P0NQ+DH4Cd0VdwqD0JQWGBk5pSw8dZPa3CNtgs23f
 5Vi7Ii4w7XRjW6p9Ipu2HS69lViNsd+hCwiha/sScTbUZxQoWJquZO0ksxH/tMl2GnB4
 jWAyUXpJSJPztdKBITT5KJzaOi6uqD3+Hyv1Z+UupFtdZM89rsVdzLEI3zPeJC2h1ZrE bQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwsysfpa0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 00:25:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25T0BU9v018872;
        Wed, 29 Jun 2022 00:25:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt2abf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 00:25:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nomfWTWMaBadABWTNQIMG8GfV5DQgvksByYhBTUlZfjJnsPdjhagOaVRL2bmzEhXConvl6nhHxVBCvdmqSFJ9R6EoNziMaCu7nBFHFrazVzq+eQILIYPtuuXJRAMHR+kIGznIG1kcYBDFWBuNlaUY9UEHWfHzDAo6vSrGsarYtUZQ5QLZpr2tiHBNLiBdAQRZOijf5rAJ/mF2aIL+hFVRmZwLpbw9tjPt9MdEsrLsydrYeHQt9JUiKFPDSG+Zx1S7Sh8rfdhbIhyDDgsbY6PJgT0pHrwDmN+U2jxyNQ20+j0GqBuWjWHh+S1uWP/iQzG13YGTa3vk+NwGcci81JmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An0ODL+Yja2FJ2SPIimIPek1MCwhvoc1rXsLS9EE2CQ=;
 b=eJt8bZvANlmTnCkgpCJz2oKMl6PNM5rLB6BYEwFJaorAYCE/HxcqmEecg5Or0+eaRvzYI9i8mgSdH+l2abtYZ+hXir5iIWUK1DePj5JkPvrm47uAQ9hOl9obe7HYu6Cu5HTIz05HZqi8xlwk0NYTGL/Kbf/KNWVnA0rixrqiPxy6SvCSqdopqG3dUn5eqat/ExifcIYAD+gyXbDf+ZVIr6fsCKyET8HSL+anUpbz7gHrC4OZnk5IV+RwcCS6/Vjw/+gccUYdzPI0gKqN5RsDRUJJRKWclOOv89ZDC9drCRP9Dl3C3nprtD2whFQhKLh+Di9jDc9iGL/2NvmT8OjewQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An0ODL+Yja2FJ2SPIimIPek1MCwhvoc1rXsLS9EE2CQ=;
 b=KoWZXFttKs479blvBER7vjKVz3QHt9yiOs8CNeRUP+CLMJ8GzKTa9WirRg0UUGx9S+zHrwyutld38Cd2BtLvuvvwZZXFBzPkNkMRdkBflCaJaQw7OA4LK2gS6TAjCKb8VFZswweqK4c0zeeQboD9PmYORhUzJZpnH/kB1bxZX7U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5593.namprd10.prod.outlook.com (2603:10b6:510:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 00:25:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 00:25:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 15/22] mm: document maple tree pointer at unmap_vmas() at
 memory.c
Thread-Topic: [PATCH 15/22] mm: document maple tree pointer at unmap_vmas() at
 memory.c
Thread-Index: AQHYitP43WO/YWbn3keMiniJGtEfGK1lh8KA
Date:   Wed, 29 Jun 2022 00:25:24 +0000
Message-ID: <20220629002517.7xzweisyydh2mseb@revolver>
References: <cover.1656409369.git.mchehab@kernel.org>
 <d2690118414c5458c448348cc94f831d8e8444ce.1656409369.git.mchehab@kernel.org>
In-Reply-To: <d2690118414c5458c448348cc94f831d8e8444ce.1656409369.git.mchehab@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af7c25c8-e539-4819-b38e-08da5965dbe7
x-ms-traffictypediagnostic: PH0PR10MB5593:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f3SaUnRIwvK9ExSSnqXniJ+zvG4hEOC08F3mjJI5pB1GdOfOrExknrVtEGklbA0pgq6O0Eza8vi4Esu/EhopH0Aonh7tr9SziwbyP27w+dVVNPBtPcFJiAKw8HMDOXln+11VGTcOo3x5wtpSaLCLTpR+Q9aOP7d/orm7HrN4FjpQKsBVxsU3mfnmOvJdDHYBRoUD0nN3HmQqQsNbiktsoYMk1z86msoZzPI6kdRLfTc2/s8rZuKH4v+mJWQ/XX6+vUSp/3WLE2nNMMUrxqoTB7gC4jQCCLqL6CjIXxMjURrs8/iY/H7Zdlqf9Wl4RJw6rkcccT8MDqNSsRirHUvkd/XPZYagI/LGA7D3yyWwrlN3/d6LXcZgfwyUcmLESnHYKqaiToPUcMCRvgwMO20B+jGl38n8Whjwz2CrpglIIL+M5hq2dFl29par56bs31IyNDNR2G4SSdsLwP4unSXYWdK3IlkXlK0fslXH33LC/GTB1XAEx4JONOYAGpym6jdbkKPIR1t1OqerCyMd+EZFK8lU+oQg8O7neRbZPns7xGDTw8ppZWxf+iox6BdsHROEibVsbU0Ry1/zkxxlHwAZkuV5elLH1jbEH8qT6FPnqFNc3jTml9Q7h9+M2MG1YE4gQN2Qqiy3I0NfnK4pORsMBVAO2Y9+YbZKud3jMaruD1G6v6euutug7ES+Nt1nB728tdIlwfX2ubVFE/caHFOgG3onwOtLtWY6Mu6K8Md9lsCUo+yr+WmID3N8Nuq0t2eB+oemKvGLPtM7o70wyf3pFzXDkg2KwklT9GEkIyOMs8bHoE3l1JceXJHRQSxIbSoF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(366004)(376002)(396003)(136003)(1076003)(6512007)(5660300002)(83380400001)(41300700001)(9686003)(86362001)(38070700005)(6486002)(966005)(6506007)(38100700002)(26005)(8676002)(66446008)(44832011)(316002)(478600001)(54906003)(64756008)(66476007)(2906002)(66556008)(91956017)(33716001)(8936002)(122000001)(71200400001)(186003)(76116006)(66946007)(6916009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ps/ju7C9RyxL/620RXTlgl/paJ8qcISLRbtkw0P1Oyqm8p66mQ+wMfyaHmZV?=
 =?us-ascii?Q?TPUFR3/8TPS6l7X54VaOaAfdhuIEsM3Uo8x5WLqV9bI5h9AY/+MKONSoL+do?=
 =?us-ascii?Q?vO/ssEXKIxoTkwM+GWDNstNAdF+uEq/0go7AvWBZCS8XBqCoOm43PvQ6wD7m?=
 =?us-ascii?Q?8vHoO6v1H8BXrGSC2ImQrvySJst6F9kWzUJL8wlQMEagKm0yAsRV+8JHFVb1?=
 =?us-ascii?Q?V2KT/jQ+AqUF5r/JKBnnFbvWqW8Xsu/+n2vCreRMocf6oTYa3A/pyORWsjC7?=
 =?us-ascii?Q?gxVZTxn5hKT5ZNzRCYBHoFpzSYu6J2akqC28cTFLYI8vAttwde60D+gPbQZv?=
 =?us-ascii?Q?r/hVL/Sb0jFCRk1jM1F4MCWPKeoHNFbe6LTduOZ71y6QJ97yYw0VV7n88Xjx?=
 =?us-ascii?Q?xfIz8rK212027aAJeco1TAd3xlWnRZNpZGd8niTx8DZnEdEhbeusXVz48CHW?=
 =?us-ascii?Q?0hmst1Z3Xbe0pn6o7tgOy7ksuiz5NigU6x8anjRkLruGzwBkFUgMSEcs3+Up?=
 =?us-ascii?Q?apLUgK6SCONAiHLSnM2hDHB3Ldiz1wL7xFZKVh+Rm9ZC0ECQMxuvMNWE7zXN?=
 =?us-ascii?Q?y4ci8eN/M3OwDK4fGk4GrrDIpII8PpRV4GnrslxdZKZ82+S/U0J5vrOggdUA?=
 =?us-ascii?Q?5dinE//fx99IoI9wHq0Ce9cNrnR21oMYNxBF0nT2JqIwlVycmbuup+cK2WqN?=
 =?us-ascii?Q?2LS0SQVOfVRaqb1KgAxG2Wr6gvgRTTCYIuLCFgFSF1j7o4JFuRRMhJWrKeLL?=
 =?us-ascii?Q?UfDgfJZPThsglSByrVltBZZqNdcZgszK+kY63ppruY2Z0jlWyrridq2/dHRx?=
 =?us-ascii?Q?4akx/YdnPzl0EHBtvPhPYuP65XMEGOiSaSPi2n74tF7vGLS2RAkFGf+wEo4i?=
 =?us-ascii?Q?C8VHiCsSqgSeAZTb1kaHZdT/+BO2n8oG4gp2GHaHHwHolDqRW0zuxaO2BSb3?=
 =?us-ascii?Q?pXu//EIWGV5nU48MiVS+2qEszMyq9HXS7BP9n33JXojCnJb8rX8xpmSwHAc9?=
 =?us-ascii?Q?CHOTaNw75Y93hWdH5hyXAmbO5F8kyZ89kwSVxeNdnLvqH1r3XzrWV6K/lebL?=
 =?us-ascii?Q?J6c7Cwkt25PdLKxZJDRR+jxNRWpYHnAiRnscBFjjKmjL/y3halCwEzFcsf39?=
 =?us-ascii?Q?ePuzEQEQGnR42bA8auU8AnZ/PwdQsC51iYnoqZsp2XFFfHBavR5GgjoZG7J4?=
 =?us-ascii?Q?Rn5Gwp9cUPgS3i0WN0J0pjSjXu97AlXJe0r55uAbvfRgYVrMQjuuYv379LxV?=
 =?us-ascii?Q?hKHDbmA5bgo9PP9CMoAq1EnIxQPhPyww+mdYjoibUZ6hAAKi0kfRpJJ/2+LE?=
 =?us-ascii?Q?6XhslgNjZMJ9Q2MVdazj+edhl5oyYeCZohcbkr3blag5LNC8Ygv4MqOMreh3?=
 =?us-ascii?Q?kjoT1WxSIPwdn/95CW0igtHhBoPCYBPWSbHyFWlyxASKF0sRyu1wxxlX7OcZ?=
 =?us-ascii?Q?IA7hru88T+R3eeSYkTYap8rC/9PBW72oHfgeB+Ni/fErjIen3DHdbeQzdBRX?=
 =?us-ascii?Q?7hmK7qjEJLaMdKRGz2juz/ww7SetKBqeaRNZBiyFUAMohjHAXwR1d29GiHMQ?=
 =?us-ascii?Q?1/pZumKXwOwu7p9xMgYRpa1SWHStoeurR5DZgDqJw2g7FNQL6wB+3eBwVP5V?=
 =?us-ascii?Q?kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <33791F33C9A83B489F24AD5552D818CB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7c25c8-e539-4819-b38e-08da5965dbe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 00:25:24.1685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryQx+/ipJKU/wE4NbwXz3a58EwBK794Ig7swVdd1XwbCBjTgvm4IN8s1Bd402Bsh2VDD959RFpGpujQdN5i4KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5593
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-28_11:2022-06-28,2022-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=851 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206280095
X-Proofpoint-ORIG-GUID: vWhxlCoFIMBHaV1o00VNYNS6O_qqwLGG
X-Proofpoint-GUID: vWhxlCoFIMBHaV1o00VNYNS6O_qqwLGG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mauro Carvalho Chehab <mchehab@kernel.org> [220628 05:46]:
> A maple tree pointer parameter was added at unmap_vmas() without
> description:
>=20
> 	mm/memory.c:1729: warning: Function parameter or member 'mt' not describ=
ed in 'unmap_vmas'
>=20
> Document it it.
>=20
> Fixes: 5966e5c968b2 ("mm: remove the vma linked list")
> Fixes: f8acc5e9581e ("Maple Tree: add new data structure")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>=20
> To avoid mailbombing on a large number of people, only mailing lists were=
 C/C on the cover.
> See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mc=
hehab@kernel.org/
>=20
>  mm/memory.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/mm/memory.c b/mm/memory.c
> index e3d3596068f2..771b61444507 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1707,6 +1707,8 @@ static void unmap_single_vma(struct mmu_gather *tlb=
,
>  /**
>   * unmap_vmas - unmap a range of memory covered by a list of vma's
>   * @tlb: address of the caller's struct mmu_gather
> + * @mt: maple tree pointer. A maple tree is a RCU-safe range based B-tre=
e
> + *	designed to use modern processor cache efficiently

Thanks, but I think that's a little too descriptive of type and a little
lacking of description of what this tree actually holds.

Maybe something like:
@mt: The maple tree pointer for the VMAs?

>   * @vma: the starting vma
>   * @start_addr: virtual address at which to start unmapping
>   * @end_addr: virtual address at which to end unmapping
> --=20
> 2.36.1
>=20
> =

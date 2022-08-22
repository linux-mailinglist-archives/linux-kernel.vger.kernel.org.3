Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E778459CB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbiHVWRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiHVWRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:17:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446F648CA7;
        Mon, 22 Aug 2022 15:17:42 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MLZMWQ005895;
        Mon, 22 Aug 2022 15:17:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=CSTST6yibS2o4I48kgBps4jOf8Eo3QvPyhOf+kUZf5w=;
 b=ZXLD05qDtPurgmXX7MP9ieoYUOeX6PlBqWGyIUjhzqwdPsv6CFp/sgTlrTgp8zrYq9ug
 CrMAf556f8fmDa6EDzvzqD4G96DK9tWG1IP6eREYOqAbmkbuFK3jeCanqPBjydG8zDN6
 kf7ZGsohOim1U/QZIX8DC6deT6/v6dhSOL4= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j43hpe90q-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Aug 2022 15:17:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuw3GVB1JrVdwAnoMxxV8Tj7oL8tPqwMYFu81yNUl72WdPwKZ0PnGsnT5LU3MPKQEE31O0q7I0nn2DioRIqUzF97l3osQbMwIQQonPZPWrNHawTgQq/lA5dUu8KSoaubBa0WfBIGQTtR0WcaFqcDC+uu+lM7KPfFYHv75FTutuKl2ZGlyipULS5NbUZ0zhdYGrlvx015BRyq4XIGLygqbs27L19aaopdlCmcnrIPUP3g9UuGAIrsGQDI/vjCPriav59jlqP/zhCSHaJAuJh7ec1p3upf+Y+ddVFv6t5atfqcUwkgNZzGJUTZ9bQcUGIG+K3rFjplf/sq2HOXJ5s2PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSTST6yibS2o4I48kgBps4jOf8Eo3QvPyhOf+kUZf5w=;
 b=ioaNs38jF70dY/IXG0nZm+8aMTc+L8/atrS6l9b0dci69Jyf6mPGY7h2WnPTcbm9S77lcVvCY6aQ14SmChk0tQqen+dcs0SsqtwBWE1Y9pz6B3hXDt+jPKpVMkI6mF+4T4QBvxZ8saEgLyGvnp0FAAZ7uz2vNTf97gb5fDaAoF6KcdbuLzZlhjrmxHjRyOsmKauAqPwmkEwPruV4oZYVHgojib3Z3QaT7G4ljJ0KP16QVpr5OUWuLUf3IsEVoucAIRwia/MPV0KEL654BC0YU+tsdHXOLj3rwVy3fbI7+DQs/StyZSlcxPN46j4nrA4/dKewrbvog9c66qHPsQRqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by MWHPR15MB1533.namprd15.prod.outlook.com (2603:10b6:300:be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.23; Mon, 22 Aug
 2022 22:17:38 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5525.019; Mon, 22 Aug
 2022 22:17:38 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3] docs: admin-guide/mm: Improve grammar on MM concepts
 documentation
Thread-Topic: [PATCH v3] docs: admin-guide/mm: Improve grammar on MM concepts
 documentation
Thread-Index: AQHYtCfhNj42WT9pmEOvz3V/N6XPRK23bkeAgAQTYYA=
Date:   Mon, 22 Aug 2022 22:17:38 +0000
Message-ID: <3C5EA425-A548-47B2-8590-35C38D6D47F2@fb.com>
References: <20220820000024.2494003-1-alexlzhu@fb.com>
 <86a26310-eae0-35e8-ede9-e71825db1416@gmail.com>
In-Reply-To: <86a26310-eae0-35e8-ede9-e71825db1416@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d389b1bc-8b8b-4ae4-7982-08da848c1f46
x-ms-traffictypediagnostic: MWHPR15MB1533:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kdT0hIdK12UWGtQZTrQbORR0yjVNfHHUDVpRk4opSloeUBTxb7lNPyhJQidIWPSeyBtIaX7h9R0rSXH+8BhqsI6HsxYhGVbW6vd5Mk67jWY+E4KnUZKbCuMvHugE5save03VOhtdYW0xWYCcawEPfIGvb7qC5k0i6AflCOzbWbbYL//XNCuvrZuViwDPnWVvkzYMUWojY+pmsfEqFH4oo91M1nKEStdwAFGbs6ETEdNVvG4RbNHamKmZ4OaelhOvbb2WKGt+28uTm3/6KPxkVk9a4cqiTcS1SHDwX1ExeV2d0XUQK5bs4MeLE02gPU9aSaEUtaX9TnMr9X6Ez1yJdB1wh1wXnvPBQTjy47jTOQWrbWf4IfPcpd4+GqJa2AnfZIUcbewHXD0mZzp5z4GUUOrxpLt4sCfxCQX5Az9vks4AE6O1YAMCKzTjdMXayVHXje9OR+3JF+mw8WJO/sqjWlD/oIfZQz3qsfCEScpPvYdiNCro8NtL4Bu6cpceGTIVwHdkjlnjTgwewZw54+QwK42BUtz4km/1p+dd8DArZqI/Jnq0m0ha+SxJ8xgLBDNgspiyaUKD+8WoYwRWD614Shx7g1rsEcHH2KHBoS6TD+RL48ssMUENVUCtV/x3fknPP872GndPVi/OVzvOupQw5TI4otI2dkjszwIV8a3nYW/HPxIRyA+Oh3/ugt2DvPclp1b0/RyC6emhzF7ucJyaJtUZCD0oNsSur23J1ppYbvSlAD2Aq057cgryVIR38oBs/3IBS12qSaagEOJOGcpnY8LYA3phjuDO2lx9gW9GGPw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(71200400001)(316002)(478600001)(6486002)(66946007)(76116006)(36756003)(91956017)(4326008)(66556008)(66476007)(66446008)(64756008)(8676002)(41300700001)(4744005)(6916009)(8936002)(54906003)(53546011)(86362001)(2906002)(2616005)(5660300002)(6506007)(122000001)(33656002)(186003)(6512007)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UTjGdJD+c1xHp0AE5HM/k7XF3Qofs82byIuclW/qgu/yRqnt0lpTitQlb4kE?=
 =?us-ascii?Q?4lz8PdaKjis9ACQiJBY1s3gg75OEgsMIcTVn/TZS/JO+/TZ/fLcHNT5J3KNI?=
 =?us-ascii?Q?Zeg4L2dQVxIh/s9OvSFWCZz9a8+xkIx4SF4jvOhHBHlITNaY6XdETO8FnnZX?=
 =?us-ascii?Q?YUyIp0J2LEqqQBw8PNnj001X4peCgA0Bv/pHvAd0ljCRyU/bsl19u1yFk+wX?=
 =?us-ascii?Q?QHW5MMdILgNnZeHnfAn9pn3lNoxwTKo+JWO87+fDcY/QBtBjV+XpVDY3fW6g?=
 =?us-ascii?Q?g2GhCm2fyU7RGRLfWVy6C0h+8bc5oM76798RJG72ydfjvTZotDRlUR4Nh4s0?=
 =?us-ascii?Q?4IWTiVy/MaTsMnJzcSqZoViwvd8hAYaBnNraCR1/Z6Da9uktLnCRYbqG/jRE?=
 =?us-ascii?Q?NzkyrACp6Xv8nVSqyCu5WwVjSgoAlp1YWZJ3SjeUS+E93VhiSo83JqFPs9+G?=
 =?us-ascii?Q?lsiGGlbhxXg1YuOleuFhweGJNlwjNaQgMygaonG5GBRF35MjYffrvMM+DMi4?=
 =?us-ascii?Q?Yiifa9nakVdT8F7Jek1xK1qibD5uC0XxKapNqFp6clRKXfTGcLu7LrN0edfT?=
 =?us-ascii?Q?Yd5cLxDrzVDZRnzjFsr8qZfHTeZFe+UrhyRNZpbgyZJvFed2m2Qto00VKwkU?=
 =?us-ascii?Q?bFw/Yyf8D8/HrkLGqLc98nGCJIu7sJ8m4MNQa2XCB9NPDo9z5yHd6OhQ7cAD?=
 =?us-ascii?Q?eIqlxnYABp5TmyGeWZUfO6lE1YH86eRBdqJs9FFnwHujfIdoMZTJEcm7lyn7?=
 =?us-ascii?Q?UiCvKMSH9vmr43zFxKgnW4ZTG3tFU5B33yQUbBkGOWmk9BTssuCONNnsT+4U?=
 =?us-ascii?Q?HvajPfeYy+kDmsHoyPGvTz+PJfyGHZXruil63p9OCJAldBmn+agDfeF5BQge?=
 =?us-ascii?Q?491/oYhgGaubPmxqmFmOiPTmxa1NCay+WKFb6fOdugFRVP6uogrMiBQPD9Uu?=
 =?us-ascii?Q?WM/YcfJnG/EbqOkSQUvbUObkTiCAdNpE4T8yxzjqWUxQkiZ8xQkgSSXlSDRr?=
 =?us-ascii?Q?6BOs27+IqJskLBYCDQgYSouqK7Y9L2mt0awYmck6MEgYMcrF5W1VffUhVtuZ?=
 =?us-ascii?Q?yunDeFtq+rCtcdbZ9OigHjCG2LK+L+vDkAvVxbkpwuEqO4rSdAAcua0XI7QM?=
 =?us-ascii?Q?5LaRK0Uvfg2pX/tJn8GDkyJxKNpKyVtya1yRKOHcW5RmoXb2HiXzRWjsRJy1?=
 =?us-ascii?Q?z/Yk2u2YThbAe2aqOunyTA1l78sw55BISfQjp3k44lIVmFsAjeeTJ80FEAwV?=
 =?us-ascii?Q?9ofW8yLGCdK6tbQD9p7pBIUQjaKVoJdtyuCI54i97CujfCxCv4Mepzn6cqAN?=
 =?us-ascii?Q?tRBwvbiWUgMAtEQFVg6jhZw/AGc4eHNSu5axlR6Pin716zCFlnea9XaEgTUt?=
 =?us-ascii?Q?TG1ZYMqCBpfViR8hw6X0jvypXy1V4vjB8RjJOTNzGcODuT5T4rIkOuUH1Oc1?=
 =?us-ascii?Q?GX6XhgmDfal7pwilBLQ7l9m2tsbUtlE+TmZFb1L3gttsYGkYHCJPAsLjD0pi?=
 =?us-ascii?Q?e9B6bQeOy1St7thsdUNUhtcLVpCMrXG2DYE4F0VJ9ZANzHio5bPIa0mjpoPN?=
 =?us-ascii?Q?EpQVbG5VMIAp8UNPMMyypjaNtot0VVVEgX7ZgVwpz2j8S7f0CqxkvbimG5kJ?=
 =?us-ascii?Q?zNqsWwmAIaDz8TYudFM79nM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D85D27530622B64A880226012C04C169@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d389b1bc-8b8b-4ae4-7982-08da848c1f46
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 22:17:38.1034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/AgFsKTQG8yQ43Y/1yQ6HP17iKNDxCZ4FeMkRDxLtDWiYVh3W2Pnr2XiEewHklD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1533
X-Proofpoint-GUID: 0DoYxsDIG0-QUh_vJlqWX3am4RxDdg2w
X-Proofpoint-ORIG-GUID: 0DoYxsDIG0-QUh_vJlqWX3am4RxDdg2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_14,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 20, 2022, at 1:03 AM, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
> On 8/20/22 07:00, alexlzhu@fb.com wrote:
>> From: Alexander Zhu <alexlzhu@fb.com>
>> 
>> Improve grammar on MM concepts documentation.
>> 
>> Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
>> 
>> Changes in v3:
>> -Correct punctuation based on previous comment
>> 
>> Changes in v2:
>> -Correct the subject
>> -Adjust the description
> 
> The changelog should be below the dashes. Otherwise LGTM.
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> -- 
> An old man doll... just what I always wanted! - Clara

Can this be merged then? Or is a v4 needed? 


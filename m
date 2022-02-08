Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A010E4ADF02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383821AbiBHRMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383783AbiBHRMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:12:00 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895B1C06157A;
        Tue,  8 Feb 2022 09:11:59 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218G3XfO012758;
        Tue, 8 Feb 2022 17:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IKunN+2Qh4lX6Uwr8KeaDxLTxFw5q8taE0b1rJ09qTk=;
 b=OWDvGxqlgA7bJHDgxuJsQUUpTxW9hwDaWvV/6cZKHox2qjzQcsvwWCLFpwsLBQdHW/5q
 hBXzeaVlZOczqA1avLZeTpaoPsxLWtYEe2kCUxEnyVha+pYX0/xQLcorDWelJPaNnY95
 mHFtHAHvkMrvThA/7C2VQGnjR9q69hK3LH3Ql9fyawEdaZj8LWvxiKDMgcnVH82Yo6di
 MOFqhtla5l5H7N18k3kdjxMQnad8eed1G9dtnGCFzrGBhL1FOGqaekH+9Kz07Sj0AdR1
 FZKycZSMklpUhOV+s5s+nkdFsJLHrzm5kcA7MzZW56xGLz/zEt9RG3MR3wwl3EKE6axc vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgj3m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 17:11:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218H7nBH072619;
        Tue, 8 Feb 2022 17:11:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3030.oracle.com with ESMTP id 3e1ec0q8vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 17:11:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0rPZxf3EITWc++NEQ9OHxFoUwWzEvvBXpzKQ3z4zywbbE3ynxYwJaIcFeSEkhBSKve6D9yoo7ts8Z6hbJKPxXuSIU2qaY7cZOeB+H2QRPIHUzzFk1llkbw5dZ2bd1FYfKTqY4eiIgz1c5Hy/R7GxFWj7bPnbzQvjMg4e2i2EcpIEWtKeC+RfvQ4JhleypJQChw9ND64dHWPBtW6z/ZlOHvvMX2fWSTSb3PIWLGTlP1yIBnDV0MkOuhFrZyRxmAmTM4lTEnbPEfnE5yzBLxFDB8q6nZSC308HQwQRTEBpZ6nRa4tyQc9RJozhmizHHuu3VYryA5SU8rRf2Sj1wbRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKunN+2Qh4lX6Uwr8KeaDxLTxFw5q8taE0b1rJ09qTk=;
 b=Movfp6Q0C9g59KzSmFSLLOvEG6EbiUK64o+hc5TBI8fQoC1+Upi82W9hbjMRY5FBzyvWDt7ojYZ1/3Jg+yvumN6TX44rOzwvPoVr9pdrYuN+vNO13HEteUmz9bhA9jyfErLJXl13GwEitlHxjjnkzY94kyd04Z1WSFxGRme9N5rvut9V8O1MOyxVD24XTQBgGgFzjeQcnciMXyJJso/cMZ9VZpQ6r/q0RxA1Gt4/ySt5vJRikFFy7foXc7Ekedex0KnGMk2asLXe/mgSrII6P5LtVMwAGfx5acuSJI8QXoKE9XV7IYxfa4yEZmTy8D7priHXgGe71fPU2yCLuazrMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKunN+2Qh4lX6Uwr8KeaDxLTxFw5q8taE0b1rJ09qTk=;
 b=RRpiK4AWT9j1G7gyW30JaN3pP/G+AumVB4T35+WU8CDz0qqTghhawCVA6/B9C/E+c5Abfu8E/ap9/FYGiJOjG9eefYUQWSs5Sux/uG3QkNGSDlYnNS9oo2EqJRuHRFljkKX25Kk4Y479ZCx3yehLGMd2Hro6uunkBUH1YyGHfh4=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 CO1PR10MB4724.namprd10.prod.outlook.com (2603:10b6:303:96::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Tue, 8 Feb 2022 17:10:58 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 17:10:58 +0000
Message-ID: <ce037c65-6eb3-6bce-0e79-4e483e090396@oracle.com>
Date:   Tue, 8 Feb 2022 11:10:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [BUG] scsi: qedi: possible ABBA deadlock in
 qedi_process_tmf_resp() and qedi_process_cmd_cleanup_resp()
Content-Language: en-US
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, njavali@marvell.com,
        mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e468fdcb-f47f-e01a-da65-68da79020165@gmail.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <e468fdcb-f47f-e01a-da65-68da79020165@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0086.namprd06.prod.outlook.com
 (2603:10b6:5:336::19) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6507e610-a34a-4702-2104-08d9eb25f99a
X-MS-TrafficTypeDiagnostic: CO1PR10MB4724:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB472428FF27521478A04F3208F12D9@CO1PR10MB4724.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhchwuQr9p2ylhh18WLp8qvlCUEq5omy8Z4iloTtPjeX+siIdx1sfj1l4lopbxP3xgmm3kjR+2JXLDaFgRfLakvwHc1zsp1GOS1p6WDKnjwCDkwewZQlA3Dkikig2myBSXXHo+mjaA5+2zCwPBpJjBXUZalPPBCBWP2h872a4Jl/QEKatX7w46K9TnsPX+QBGlcMtRaCTO6xdg1JnPhgmgfup1O20RVRPIC3jNlv1tDaSCTF5LbgEfeNg227/2VeriRgSNgJri0p1/ohI2xAFL5quvfYbGwkTolfZ5MQBnzZC7WeII32a+rq7BI7O/QgmWkGGZwqKo22hiziC6rBzmgrJR/en0lbv2s3GTsJ8asw6oTxdkEQcWguQKpERwr6Vks/czmv0mod5WgP4dItgvVyG0gYcSsth/+ApzayLiUE+RkK7zQCwl1MFPqxvPpgXYynWDGNMBnahc12hjvSqfWYKEzL1cWbmZgD6PxkVLdDoNamRP9OzWSdKZFliH0K926ElNOooVhEoN/viTFIX1D4WAFLhJ2tX3wceOlE6GwtbS09/VTjzpRzRxQUUARQr5+gsF4SBrp711cR2haWi3vj1MOnAvXO0B5vUGengU1u4hQrX1u4ZwcRsoligbYaZzqshKhI/77FmvaaoZZ2Gh1ER/ydHU1AloD0SWNL7CNKjCwCDXVwTqOA/2ucgPfIKvHxEZLrlt2h0o20UH5lP1zReevEcEZ85dEtAYRXu6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6636002)(5660300002)(4744005)(2906002)(2616005)(316002)(36756003)(8676002)(66946007)(66556008)(66476007)(6506007)(8936002)(6512007)(4326008)(38100700002)(53546011)(31696002)(86362001)(508600001)(83380400001)(6486002)(31686004)(186003)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTdPYXkzd1pJRFQ3NVEvU1dRWGtQT0VDYnNQL1FCWEdvTEQ5N1Zocmh4WlY1?=
 =?utf-8?B?eXdidFh5dlBjUW9SWm9Eb3BCdkFJd0VBTHlUcytwK1Vod2lYZlpRT1dNYjh1?=
 =?utf-8?B?SUxia3NMYUdqMUt1bXh6K0cyaFFEWW11YUNBV2ZhanREVTN4bTR6ZEc1dWZQ?=
 =?utf-8?B?MnlVRzYvLzgxQmZzM0tlTjhNWkRGbFoxMyt2Q05OcjIrdWNvU3JaY3hDRzdO?=
 =?utf-8?B?YnowVVk4L1lLMFhUYmZ5OVFpbXVOa3dBak10Sms4KzkwdWtOOFFOYUFRRVhN?=
 =?utf-8?B?Ky9uQWh4R2tqeisvTXh5eklscDNvVmFmU0k0QnNBdHpPd1ZOQ0pBa3JwYXAz?=
 =?utf-8?B?Y0IvdytESWJCQkpKT2JKYXBZTld4SnZ1SW5sMkZzdE51WklheEpDMmxWNEx3?=
 =?utf-8?B?VmNhMm1Ga0RhUExkdnBrcFNiQkRGazF4RjNTdTRlOXNIOWFuVVhHQkNvUzk1?=
 =?utf-8?B?eHNSM0xtcC8zaGJJN1NPc3piOWh5ejRzdWdqM3VOdnNzTlFOSjdWTTcvWmE0?=
 =?utf-8?B?cEVCdEo3cFdLb01pTEM2L08rRFR0Z2FSa3ArTlpzYzkxK2JlZXpiV3VHeFFm?=
 =?utf-8?B?NzVOd1g5Y0xXUWlyOHQzWmxocE9vam92K3BsZkJGSGRzUGhoVkx1emsrQy9M?=
 =?utf-8?B?UnNURG85cmRRNXNzWkh6V3RFYy8xU2ZJaTFFSER5VDNyclFKUE44TW5hSXVO?=
 =?utf-8?B?RmM5cFRyTVYrNWlSTk43UG4zL0lJc2Zva1hzNDdNeFhTaExaUEJvdWMraGRP?=
 =?utf-8?B?M2I2aWp4UmVXZ2hQVjVkeWFkN2xtSGt3OEJUTDllZjc0TWZZdk9BcDN5UTMv?=
 =?utf-8?B?ME1OK1dQcUlUdExlZmtaRTRJLzJndnRBeXJ2ZS94N3RHREpFeUlYK1N5dXhw?=
 =?utf-8?B?bjJ4TEZkUDY0bnFYOW9XWlJQTGdCcUZuSGdsdmppNTE1YkphOXZxSjhlSDRh?=
 =?utf-8?B?bldFa2tMRW80WHUyS0NmTVpMenZiakdHWm5WaG40TUJ4NElmZXNVL2REOWZS?=
 =?utf-8?B?RWlCdk5BUDAwODlWNXVqbXhBV0VTc0x5NXc1VmlyMDFhMUQ5QzM1NVJWZU8r?=
 =?utf-8?B?akgxSXlVdVAyei9lQytxSFh2V0Zocmt5Qk5rMnZ2bE4vVVg0WWxjVTZnM0Za?=
 =?utf-8?B?ajE3Rnc3VG1EaWphbFh1US81S1QweG5QTmdnN0wzS0VuV0tYT0FmNGJ4OWN3?=
 =?utf-8?B?Z0N3Z1owUkw2L3dxVFdicUZuSmR6KzRFM2FSdUd0ZDhqTWhtNjNlaHdUQWNR?=
 =?utf-8?B?YXNES2lFallwREZGNHpuYS8vei8xTlNwU3hqdzZuWVd2SmFGM3NqMTVmQm1m?=
 =?utf-8?B?bHFYWFhLMU5NSXNCclZhZk9qd0l5em1kcloyYnJSS1VKaFN2Y0pYeGdxbjZO?=
 =?utf-8?B?bWZnVzMzNGZoeFQ1U0xDZnNXWkJHYy9SS05ySDh5ZFo0R3Bua0Rnd3E2dkZl?=
 =?utf-8?B?NzZyZE5wc2k0RnV1SktPMkRxdDhYZnJYbkdEUG9BbmNXdUdVU3lJNDdqZmdv?=
 =?utf-8?B?V09VVzA1WGFIbC93bXdVdUZ3TnBBS0pFMlJzdHI1dndyZmJyZ3FPblRsOEdw?=
 =?utf-8?B?MzljNE1nQUdsV0xvYktqd2h6dmsrRXJQczVzSXhEU3RMclZBdlVGMm8wUlFl?=
 =?utf-8?B?ckNEcUxURktaU1pXWVRTeEx3R21Tc0VGYkV4NWkxR2h1ZEFmR016b3BmVnBa?=
 =?utf-8?B?ZjVXSitaUlh0QTRpcDA1VDdHMVRRYjNUWlJQVW5aZHZaUmlYTHJmYnYvaWw3?=
 =?utf-8?B?Z1NUV3pIMWdGTFBpN2RvazNhUlJSYkZZdk92eWp3d09wRDVJYW9JOHl1SkRR?=
 =?utf-8?B?a3FBNGNmRnd1elFtYnNVQ0F1S08zV2JUdlljOXVQRjhFUWhkMjlKa2lhSGh3?=
 =?utf-8?B?NUVNUldFOGcrQUtiN1dXbFEyeGRYRG02QW5HZFMvaVhTbm9icFhYbWh3bjg3?=
 =?utf-8?B?NXVoYjF4cjBZWVpQVzRVNWM3R3kwOHl0MlhCTGpTUjlSUUN5aVR1dEVyZEx3?=
 =?utf-8?B?NGpYY2JocE0zaFZyRTV4QUI4Nit1R0lPcHpFNXU0RTMydXpEVzh5WjRUNzJs?=
 =?utf-8?B?U1d6bnc5MktZRDEwSWtWOU5ST3IrNHdmcm0wT2pWUG9aVEY2ak15dEs2Qjcw?=
 =?utf-8?B?RENYNEExRURkdUJvV3ZIN3NSTERlclp3Yk1ZZnJhMTlocDBqanR1NSt0c2o4?=
 =?utf-8?B?YXBNUWNPL0ZIaUd2L0xRU3dyRTVQLzRVTUN6Ymt5TFRSSFFOdEhYS1p0bVgr?=
 =?utf-8?B?T1YwVkE4Z0VhTDh1UVEwOVAvNE53PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6507e610-a34a-4702-2104-08d9eb25f99a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 17:10:58.5612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhd9NY97sngN1A+STDFoJeRhLZkY47VCryvTvCnJBMQyymQrPKnus5qRtnt8ff9Ehg6jduwc8ZnUfUNc6XvEU41ytDr1xUJq73rRTwiCoO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080103
X-Proofpoint-GUID: flomxpigIjhSKl4fBnQ17XTwPiAdYE_N
X-Proofpoint-ORIG-GUID: flomxpigIjhSKl4fBnQ17XTwPiAdYE_N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 5:23 AM, Jia-Ju Bai wrote:
> Hello,
> 
> My static analysis tool reports a possible ABBA deadlock in the qedi driver in Linux 5.16:
> 
> qedi_process_tmf_resp()
>   spin_lock(&session->back_lock); --> Line 201 (Lock A)
>   spin_lock(&qedi_conn->tmf_work_lock); --> Line 230 (Lock B)
> 
> qedi_process_cmd_cleanup_resp()
>   spin_lock_bh(&qedi_conn->tmf_work_lock); --> Line 752 (Lock B)
>   spin_lock_bh(&conn->session->back_lock); --> Line 784 (Lock A)
> 
> When qedi_process_tmf_resp() and qedi_process_cmd_cleanup_resp() are concurrently executed, the deadlock can occur.
> 
> I am not quite sure whether this possible deadlock is real and how to fix it if it is real.
> Any feedback would be appreciated, thanks :)
> 

That looks like a valid deadlock. I'll send a patch. Thanks.

> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> 
> 
> Best wishes,
> Jia-Ju Bai


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD5D4C3E02
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbiBYFol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiBYFoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:44:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90B1172264
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:44:06 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4e4Hi030036;
        Fri, 25 Feb 2022 05:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=G5xXt3uXoVgMfY434LtFaI3/lLjB5449SHuwVt5v6Mk=;
 b=b+SjafkiVG0UgPzg3b8Z+yAs6MAVZz0BZZzYA/BoCwJ8GbsNEJbvawBzaUpoq2BOaKJ5
 bGiLIEHNgrzlbpn70veUUFQVbTFGi5s3iD4oM5b5FVCX7e9wP57p+0jiVIF6EJxu7ptI
 99xbkogVHADf/zKypLCJvkNSJRtmn7jHcJ4RHYYNpgzf2sNCm4hCh6stfd3p8bSNtFzG
 SiFdoKVHU7nvL5Ebap9k8dtQBynST6AaPRJhM3y7SP8lXqYTuP2mA4kkIha+UQteVzh/
 4IlNxxyhxUeT3lBbqFA7gmDDOEwVhKAAFhEPbcNIYou5iZWceDdqqwXgNNwgn7psfNEM Fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ect7asa61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:44:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P5UZMq002968;
        Fri, 25 Feb 2022 05:43:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3020.oracle.com with ESMTP id 3eb484ejc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 05:43:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZc2JhOfaJCgImT7DVShBE3VjSgvGJBQ1bW+LB+yFEY0wvxWfAFxL/Hen+/fn/ivEkMgTNSZIagNJ6Cj/yVUepixuVDo62H8HOMdr7Km3S4uSO4ReTV4AK1UjcxigGYvNy2m1fcJ4k+N3XuVAV8sZqY05IFaXibEtfsal7/75ja6/hhX3UedIbSehhDjeGSoE0pMaxPWnui4uW3jMBIaYvSVc+RZymXEkUUePxkolmE/UTtvdw9B4MuNbphUz5EHmyZO9TqddDjOTzhHizqWCBa93BZZOm2YPvD1mOjymZ2yJDNaQ9ar1kB3CYrnrvEDPDPNakgvC245yhIJ81oW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5xXt3uXoVgMfY434LtFaI3/lLjB5449SHuwVt5v6Mk=;
 b=If9PL53MZEfjOQF9KCwDIbwAqLS3iMHhduHM0tpz+vvdZQb3Oq6nNLefROl09iWnzeKE+20dMaZJpKSwFSE7wzOd0Hv6NZsY80E/6lyu4VVMDjK4qzHYXkjBSy1tNOSmb6iXYIr6s92FbdD3wvVjRDRbSld8lgyRLtyzHuprsAmyGn1KGYqGtqh+mtYzrbH5krFwN4C/hzIfR1rDju3TUAgW7mK8vonE0xgclYLPNx8OzrxIPjL10jhERTkQcuwLjrQgrgnwDk9hFGwDlS0+f3RtaA+zmbQBrjRPHeM6W7XfjYx6zNYDo9akE5Cieav2LUHRN3eyJf53P8u35VE/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5xXt3uXoVgMfY434LtFaI3/lLjB5449SHuwVt5v6Mk=;
 b=ITzxXf9ovIENDb/nJOiSmoQCLXwgyxYYfq4xnV1bdDE/zXm5y7kLlSeoo44U2jS10Zy59z9DxyOS0UrK1E+0I5oaHoHOUdi2DB9gpapklF3IROYfD8DXUOVY8z3cq3qdRjY4Eip4hG1fCem8VyRfHOhVp0Qu7TiziLH5aAXxcJ8=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MN2PR10MB4029.namprd10.prod.outlook.com (2603:10b6:208:186::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19; Fri, 25 Feb
 2022 05:43:57 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 05:43:57 +0000
Message-ID: <39b74b28-d029-ad05-0f73-2db8c8eefe92@oracle.com>
Date:   Fri, 25 Feb 2022 16:43:48 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v6 0/7] kernfs: Introduce hashed mutexes to replace global
 kernfs_open_file_mutex.
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20220214120322.2402628-1-imran.f.khan@oracle.com>
 <YgqcSwrhToLXX5Cm@slm.duckdns.org>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YgqcSwrhToLXX5Cm@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY3PR01CA0094.ausprd01.prod.outlook.com
 (2603:10c6:0:19::27) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84e803d3-add4-4ac0-dedc-08d9f821d0dd
X-MS-TrafficTypeDiagnostic: MN2PR10MB4029:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB402925DE7045827A91829E1EB03E9@MN2PR10MB4029.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yh8mhULgZS1v0f8B/WyawH7rlwraLK4unHJk5ce+M3Y82VBkGNmLqjmD9IjPtaDjlhU6rmdR47ovd3wL67UTYmoYfxalF9mZIHBl2ZinQU2PsDjaJTL1guZgsI9D3hdoylwAVjpR8GoWikCHZJJ0VWeHe9VLqNMOMaEg7h0YcnmIP+5YY96m96Vnu6E/NMIy+n328ajSzPr54MXNBBHF72lHkoTncn+cc9hV5A6Ziwt0NHEDrj2JTlL8i0WUEt1jvvhes38Zj9ZHXacDpz9rUV2gFsuhwBnUrb9uyLERqR3Qo3cQKS+3seFRwS3TGvUwbNcS/ExymCh1Doo959VBIfbJ8dHFITm+EEgd/lggIHyqagolEXuMfaSa+tABkciHe+AMqcExMz5YAC33utB6zUf6bM+xQqg5R6XxNhgbgAgZR4YUCykZZktcDbBGBUpObTqqoC431Px3jVnANuVN4kztlNTuaGZfzBNuoAe2miCVDONFe0Ab04ysge2/EzwQKLGmFSili8pC+1gSoVIOKKdjMW+sP0VQ08fGZWqSUNydeaAR2OSLHMV5GJl4xY/yB5Gtl4/9nnSCNR/hNwbHDGebqTM6vuojFhfbAEFVY9NP4GSkNaISJteGkQdXD7I//oKl+GSPXltp9sR3U87GVgh/7wd6LonQeLGB90ijhe2Ema1M4Ofok0veiDO6MMrc1K064JIIVZ8DfISWQ+P0rBrNPVIATGw5D3q93ekq+OHQiiv9tqDnfJ2lJ0e66IzKzQnYFxpXQn874DzMvcDnIotemeL3JHfb427EyObPZx4YgIzjhUwOzWdPG/kpZnyK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(31686004)(2616005)(4326008)(316002)(5660300002)(966005)(6916009)(6486002)(6512007)(26005)(66476007)(83380400001)(66946007)(66556008)(6666004)(4744005)(8676002)(186003)(6506007)(8936002)(508600001)(38100700002)(53546011)(86362001)(2906002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzBGVktyU05TM1J4ODdCdFdGL3cxK1lNcllzeEsvbEVYRm5MSkdxRVd5OXlw?=
 =?utf-8?B?ZDcwelRSLzUxOC9NYTNCdlQzcjZ2bUQyOVcvaVdpQ3paL1VLaU9zKzhJdldt?=
 =?utf-8?B?SkEzMWJ4eFRvNTYwYWdLRlhwYWtpV2JScit6cUsvODN0S05WZldrbGdaaWhw?=
 =?utf-8?B?MW1vcXRUSzFkNXZSZmZYL1BXc1pDRFZYSXRlSlVlWUZudmJlQThRRzB3Z01U?=
 =?utf-8?B?QjNkTCtuTmllbndYSUFSc01OQitlNU90VlNDbzltbWJVUC9RK1lUUjgzQkR3?=
 =?utf-8?B?WjVUSFR4a1haUTJXblJzcG10RHF0ZU5iWDhqVFZLVjRsZng1VllMbzFnWXhN?=
 =?utf-8?B?ZytTTHd6QnRlMjBtS21QYjd3WklDQ0VHQUZJR3ZQbmVLbm15QTczNUMvZ0ZH?=
 =?utf-8?B?a0Q1V0ZOVnhRaXgvRkJEVi9sbjJGbWZralFkbEtVUm43S2w5MzZjWXVEUHB2?=
 =?utf-8?B?b2Q1RjI4UW9scTJ4RjQ5VnlmUHo0MXdyaEovZTBDczg2bGx3Zm5LM1BYRkVl?=
 =?utf-8?B?cmdZMkpTWkdpcVp1aWtmdCtQRHJuVFl3dXJ5REN5MmJ1K1ZNUElHM3Z3VTlp?=
 =?utf-8?B?YXNhaTdiWFBmVFpBUkxxaldzYzAvR0tLVmEvRG5XNkRrVmx3NUQ5cXl3RXE4?=
 =?utf-8?B?R1dyS21TQnoxQ0xmMDNPTXYrdUpKbmZIdFNIM1NvcEJnZVgvMmtabk5HdnNL?=
 =?utf-8?B?ZTczTWNIWU9BV2M2dlFnSWU3SEcya0VQVll2MjBXVitxQkR0dzkzNnFFTXZV?=
 =?utf-8?B?a2hTYlFGcGt4ZVorZ2pJVXdBVEE4UGNYR29KZFBIRXF5ZW1uNTIvSFFIUXJZ?=
 =?utf-8?B?L2IvbWMrazJFS0kxYnRacFFyVzYvM3ZLek8vUlppMjZRVUpOMjYwZFpGZHU2?=
 =?utf-8?B?WWFicU02cjUrdC9pNGo0M3pabkc1VldNSTJyNzEzNGh1b2RpTy9QT25XalZ3?=
 =?utf-8?B?ZzR0TXJEL3JVYWZTY1BxTDMwYUZnRWdTRDE2bDQ1RGwxNW1QWFRUOVZOU05t?=
 =?utf-8?B?OEV4TjRUOXZvbFZrcnJVNVprVDB4cEE1WmtHYUVDV21iNGdTdElmSjFycDIr?=
 =?utf-8?B?RVhFOHUvMyszR1ZvRXhndGZaeUoxYTlpRHFxdGFHdjl4UXhjTkd0cVpPK294?=
 =?utf-8?B?VlRja3ExRWFyU3lZQURZTlRlelNuRkMwYnBLejZxUHN3TTIvOUI2YXB6MCsw?=
 =?utf-8?B?NXpVY0lucEdwaVVvMFhUeWpPdGYxalBUUGFmaVc3YkhSNy9ObmN3enBmY2t5?=
 =?utf-8?B?MDRLWEpNQXdaSUNqTGVMSnNRbFdzQ0dpMmNnWW00aU1SSSt1ZEJ3RVE2V0kw?=
 =?utf-8?B?U1Zlb3ZZZWwxVW5ScnRxVUw0OE53ZHpsQkhvVStWTTVPU0lDb290amNPVDZM?=
 =?utf-8?B?eGUvZnVNRnNxSUVTbytBb0xGQ2Z4aXM3L3lOQzRYZC9MMjE4WTVaYkVjYldx?=
 =?utf-8?B?Ri85Q0wxYlBFRXF1TDMyYUtkZDYzMDJGT0dZeWhtRjJUZ1NVOGk3VHlYZWc0?=
 =?utf-8?B?QzdFU2tBOC8xVmNNeTJ4MUVmTS9PM2xwek9wSmIyclZhbkU5M2ZsWnMyeFBE?=
 =?utf-8?B?eTNlZzM3S0F2eVhHMkF3SWRHMEt3ODdOQ2tsOGhkMklzWG1LRlB6dm9TaGxV?=
 =?utf-8?B?d0ZvNkhXK09oaHpjQzZyMW5BRlNQY3hKeWtvRFp5WXMvT1h3WUN3bWtuYkFO?=
 =?utf-8?B?aVU4NVc1RW4rbThsUzF6dzJ2Z2JyMStqRE1ucWFBUnBVYUdYa04rVVZTbEhk?=
 =?utf-8?B?akZWNnMzRXJFK214M1ZiY2VCcUU5T1dCbVBodlZVQWZJRWVwV05KYXBxQ2Y4?=
 =?utf-8?B?ejI0c0lwMFpjN01UTlBuSGxMVFBPWXlIVGJFYm9vMGlYc2lwZFA4UTZ0YlZM?=
 =?utf-8?B?YXNEU0ZQK0VzYVVKbVk5WU9hWG5UZWM0OWkwc2F6SnVDdk5HeGVKZS93Nk1T?=
 =?utf-8?B?a0VUTHQwSWdmUFErTGNSYmUzK2JHVVAydDFVZGZQdWViTUNWbWpHZlJ4ZXlT?=
 =?utf-8?B?R0dLcnJ6QzR3d0hmK3BFQ1Uvem9pTVFCZXJxZDh6MDd1UUV4Q2VvRTdVcXdz?=
 =?utf-8?B?eFVJR2JVSlp6MkFMMFBCQ05QN25vSU9VQk1TQkduMFA1a1hpWmowRjJyWGdw?=
 =?utf-8?B?TisvNTNKeTZtK3g3TlNtNVhhc0sxdU82V3pIZmorS0hjMjVMRnhsMmZFQ3ds?=
 =?utf-8?Q?YB2SF1JZfI60lHZy7xSypEM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e803d3-add4-4ac0-dedc-08d9f821d0dd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 05:43:57.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOAFBMRZkiFWi71CDLN4ni8e2SE2HcOi1au8F4/hgs+hfx69wSnUQQFhDTtyUHbXOd0vY298LApE+O20NRp7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4029
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=894 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250028
X-Proofpoint-GUID: FgS1OlCB9e8Fd4W845GfubYdAMQ-fiqP
X-Proofpoint-ORIG-GUID: FgS1OlCB9e8Fd4W845GfubYdAMQ-fiqP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

Thanks again for reviewing this. I have refactored the code.
I have also added a document to describe lock usage and proof
of correctness in the new patch set at [1]. This took some time
but it can highlight if I have understood something wrong while
making these changes.

[1]
https://lore.kernel.org/lkml/20220225052116.1243150-1-imran.f.khan@oracle.com/

Thanks
 -- Imran

On 15/2/22 5:15 am, Tejun Heo wrote:
> Hello,
> 
> The patchset generally looks good to me but I think it can be split a bit
> better and the locking helper code can be more compacted. Also, it'd be
> great o include the benchmark method and result in the commit log so that it
> can be looked up easily later. It just has to be in one of the patch
> descriptions whether the first or last of the series and the rest can refer
> to it.
> 
> Thanks.
> 

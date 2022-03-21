Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D1F4E1EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344110AbiCUB6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiCUB6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:58:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A1617F3DA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:57:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22KKxfWL031084;
        Mon, 21 Mar 2022 01:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jjPvhcWItxpRLOkngkwj0ymPdc7pOhPTEbKNEQXHo6w=;
 b=PMbhPg9aVrlJ4vjnDqFYHxyDUl0NrHekcqKJrlgXqo4D3ECvM66PpL/krgqP35lXefFA
 i+liThu49jHreiEiqn0h37fGMllXIXRaR55+hHhFNP4r8QQI47+7J8a5GBChJSeGrdJq
 hu1Nm0MynX6SJ/j7ydnKivi9MEQ7xeVsru1sIQKi7oXoHBRRMQn++FOdgKwAfPsWGtzL
 tuMDp1q0b8mTCRsTBilUwsXjaIrlFyyu0iCQHNwjng62BOxcMEsPiKKbfrOEgqnnZ/QV
 31VN1l2j0I3Z882k5C065OdJfcqOcpOW49a5eDUZbvwdttbhg8nE89ptyBfW6BKdt4hj hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kchwyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 01:57:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22L1thLk171383;
        Mon, 21 Mar 2022 01:57:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3020.oracle.com with ESMTP id 3exawgb9pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 01:57:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBQzrnYvtgPiTplJiTt2xwhBbRBhAzBeW77SK8lGuBAKaXuNAm46Zo9UqU0GmRNC5b9T3gyg7N22YaM81uP2awydZl5IQySgTHxgijeOiXtSu03zHFB+5iCDX/+5oZ+2TL0/Hym1vmBHhOZw7v3wYTtkfAOic8+bEwAI1vdMstjaLI8fCPSYU/z0sMXmH/HxZjPPx5M5EjRMkx9zCu1BRt8jzC0JOlrvJwmTO+iIcCZqjYOWRBaiieOY94ldjVAfl0m22sE8wuReg3qBL/NsKFwtIkzhGSRbPlud/CBtNgqZNwKKCSaaTEcn6pBUiAw82Eshx6qWhQdyd80u9f4vxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjPvhcWItxpRLOkngkwj0ymPdc7pOhPTEbKNEQXHo6w=;
 b=AaDodyOK9xcfwpRN2wlNiD5cRnIIxQNqNrcekfYjxBJF0/DN8hxfijQBSba9zR8v0NaRbU6hSNvbYu8G95Ppq6JGi4KPM2ydmYUt7QT/oETVIyBdyePcSE9Io3WhSZgfIVIEu9WZ1LJ7dgevvzu2JYwo5VcsOlwtVfRzD5f7lcEH2yfgqdYHZEK7E5qzK5TrHCoz+Qfsibg9D312EBuY81D4bbKjy50/6SyZgOrDFicDu4kVV+Yhzt11+8rb1wcU0/0eu2+VMLIzDdYsCPgrTUL65e2mgvOJH6HmMCRKsnaeoPmpcfs3gmICEdZZ/AIOEEyqXogNRZnhqzgHBtCrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjPvhcWItxpRLOkngkwj0ymPdc7pOhPTEbKNEQXHo6w=;
 b=OAyaZr8gGbg7Om5w5RT6lnIQ1dYUCyA2TpSfxEc43tdxcwpbiG0aIL8ppjc6/63osvyg9vvgB3xouE7dsBJfTREq1+zAHFoix1tvsh5RUQAXAWlkZjGpr90+HIsvROu+JsxddGDwNYM/I6GsOvf/IEAhn7Jqc5IOIXNcEdL+ds8=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1598.namprd10.prod.outlook.com (2603:10b6:300:2a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Mon, 21 Mar
 2022 01:57:15 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 01:57:15 +0000
Message-ID: <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
Date:   Mon, 21 Mar 2022 12:57:07 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-8-imran.f.khan@oracle.com>
 <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:332::27) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c78ace83-4f9c-4e1d-4de1-08da0ade1f8c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1598:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1598696786664CFD064822C2B0169@MWHPR10MB1598.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cIWCofxMlfm4UJI5Q5NqqhP/3tK/jTfWlNjOkwbrQVhqj4uTvFctNV6XfBo0LTLm36NVnhclpA/w77c8Tmayvv3cejx8YDqkZqopzX8vfc0E9l1ZYIJmuoeNZxd6CYY29UL1Zae0pAHcTnkQqcJWsF3ZWNyQpY0qdn754YOFOThhp30IOklBsvURQue09r8OCFLmiKFWulc3nJehY9DiZjw+BCZzqKix0Ifx09/RdGuCSabjTLl9wLK2fBr25F+GChAuve49mB2utdmFsvcm5T40mbRvzOtUxOkA2RPsj5DCJoFMPbTe0nHCVJeg6/2EwPzZL/pBDkF8MFAwcRT1Iyz42+GCxRta/nmZNq5MD4DYGwfL/RXtTT9Z4zRF+PLD4nMApAOfWfV98d/i/1V6sYZq4W1JB3m3GPAXugop7Pmf6z+tIP6w/3BqPqhc4C2I00GdgNTgrnJ/ylu4HSH6tbesXoufJNJA49udKGSHos9F1+PJfbUN5vBZVzfHTbSYaM2R0B+XYI9+jDiQcFwGHENEjhHOn5W5HIWttIG3JVxxSk8oKfcF/N9pVXx4xfL1mKVmHJEPDxdzs3+g5Pqef7uEI/iOwPEn0tpcLQInwJtU1MoKQt2lLDRta8v/SJT6Ja9RotXl3XiRRYqu3rHh1YijvE+9WK7SbZOSrEyFx1xUKO8+XfsUeaTywKLkwZSNxqgPrVtdM/vwwBIxxj+hIaYIVQpxJPfqcdwXMI8MGc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(36756003)(31686004)(86362001)(6486002)(83380400001)(31696002)(38100700002)(6916009)(316002)(508600001)(186003)(26005)(66946007)(66476007)(66556008)(4326008)(8676002)(5660300002)(6666004)(53546011)(2616005)(6506007)(6512007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJiZkIrVkpYaTV3cGs2eWZLWGxqRFhOOWpVSzdrRTJWazl3RUtxeWx6RERi?=
 =?utf-8?B?UlQxTmlFSG0xcmJDT1A2VlBuSmxkbnNFbFRFbzY5NEg5c1JUNUZwVVVoY290?=
 =?utf-8?B?R3diWXVmNXJMOEdMcEZ4Wko5N1lsVkdNS25qOVJjVmU4UFNyMk1PRkYvR3NS?=
 =?utf-8?B?WTYrTzdLclFtVkZNRDEzbUd5cG0xYkFVUVc1OWFyc2NVY0hUcEhZck4wc2JN?=
 =?utf-8?B?RUlMRkN0Z1ppWmFoQitKd1FaZDFUUW4wNmtLZ045TnIxaCtXNmJJdHdTeHlS?=
 =?utf-8?B?a0dDWlNPNEdYeG5hTXM4d2Z2Vm1UcGRpS1kxSWhlVW12K2kxejZWL1BrTy9C?=
 =?utf-8?B?Z1YrZW00dVpUb2RmREhUNm05eDlkdFVVWlFQOGR1ZVoyMG44THZwaHd4eFI4?=
 =?utf-8?B?akxpU1cvbytTVlJWRlVTS0N5bjdUbFQrSmdzQno1OVFNalRSUEdvL3BJZ3Jq?=
 =?utf-8?B?akdJUkczZ21Vd1VNcHYwT0d0SjdYYzlFUEtZMHpYSm9qc3EzUVV3TEd3SlU5?=
 =?utf-8?B?a3hZbWNMQTF4dzdFMS9iUEN1RndtSUY4dTFyNDZjSFFLcFhoTW40TGVVKzlX?=
 =?utf-8?B?YXZCY0JVRExOb2Vwa2lISm51TW9pYVlON2RpRjlTYm1kaHkxc1MzREo4LzRz?=
 =?utf-8?B?UDBSV3ZIMUJ5VkhuWi9uNU43UTJyajBQa2lpN1JaZWpDYndYRkdzOXFXT0ZR?=
 =?utf-8?B?T2Y0Z1VtcUdid2NYTjZKOU0xZkhtaDlKSGJBUVE4NHc5bXVCZjhpbFFsWWp1?=
 =?utf-8?B?eGFqTjhSejd0bHphZktVNWRsM2RIQnlkTjRmWG16MGtwWkluM2pXYis0WERZ?=
 =?utf-8?B?aUJMQldtVE40OThiMERQNTcrSllidThUL0x1ZVlMYXRXQkxFeEJaT1FPb3NU?=
 =?utf-8?B?dGE5YUtPWkdrVitKWVNLd3QwdE5rakpPN0ZoL3phb21RdDlwQk94YzJYcTJw?=
 =?utf-8?B?OEFZdDhQcTFJMDBUaUMwTmtaY01Ic3FCN1ZHbzUzN1liMnlaaFhOQlFBNFNi?=
 =?utf-8?B?NHdmbm5DT25IMStGUXpJUXFKQzJqcEZxTldjZHlDb3djQXFiRi9DMzhVd2Ex?=
 =?utf-8?B?aGdoeUdvTDdxVGZpcWQxRGx5RjhDT3JCS2tjZDAyWFc2Q1E5aDY0V1Qyb0VU?=
 =?utf-8?B?NUtaNWlUTFdZRHRKZS8wNzhJRkxvQ3grQ2dzNjBhdCtITFM5V3ZlWVVCa3lo?=
 =?utf-8?B?SW95WGVCczRmQURndGV0d2c5SEo3NlFzazZuWCs5SWRGeTNEcVVaNFFnb1cz?=
 =?utf-8?B?UHN2OFpsTFJ5cWZqM3k4THJVVkVIT0FsNE0zcGs4Y2JYZjlCdnBiTEV4WnF4?=
 =?utf-8?B?RjdrUDFYbXBzWHJHclVRTWdmZE4yemh5TG9BNGJQL2dma0hxSVdkblZ4Y0di?=
 =?utf-8?B?S1VqMWZmcnF1TlJtUGJaMSs3a3NYbVJyQ3V3V0dKQ28rYXQ2bnhZQU1CbzAr?=
 =?utf-8?B?M3JNd1RDSWpsMHVtU2ZKZy9OMEJrUkt4bFVDdGNvNWZ0QjJqK2JtWWJsQ1NS?=
 =?utf-8?B?djlxNytJbjlTMk1iUGFGWnpGNEo5d2c3NitDVVJBR29za3lGU2FHZFdZekxh?=
 =?utf-8?B?VTZ2Q3JGL2VNc242ajJNTTdMazNLZHhDdWdPdHA2anpVWm52dTlZcTlNQ2sz?=
 =?utf-8?B?UFY0T240S012Tko3bVFVNWszTFlyVmdNOHBWbzc3UXBFUUFLUStoWHdidG92?=
 =?utf-8?B?QWhtYlIrU0loMTFIS0FVUUxrVVpwZmoxYnNiZzQrYkVFZ3BsL2duRDQ3VmEy?=
 =?utf-8?B?d3Nnak9BNDh5Z1JteUwzeWs2NVo0K3EyN1BUS2VsRUhZOVNGc3ZON0pxVVlh?=
 =?utf-8?B?UXFDaVU4M3Y0WkR4d0dhRzJaTTBNVUVVak9CWTFZRTVta2dPZHoyZFBBVmpq?=
 =?utf-8?B?ZzZwZlJkU1ZUS01pVmRhL1pKOFpielJhZXZ4QW5CZXVMQ1VhVW9DRDhLbExu?=
 =?utf-8?B?UXlzWFNOWmJQVG0rNFU1cFR6ZTBIRXhsWkZVVG5jMHNIdXBjNU9FTFVmbll0?=
 =?utf-8?B?eUp4c2c5OTV3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78ace83-4f9c-4e1d-4de1-08da0ade1f8c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 01:57:15.5589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFLk4Dx3S6R2GlZYNF0NHulFjjUhrcGIlaONaqThj2xHDBuxyHugh/8d35Di+rc04cnLNAUj8PerAh4u6nlwmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1598
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203210009
X-Proofpoint-GUID: oImxH-JB4dUockDjBveyYLnj3Lin4G-7
X-Proofpoint-ORIG-GUID: oImxH-JB4dUockDjBveyYLnj3Lin4G-7
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Al,
Thanks again for reviewing this.

On 18/3/22 11:07 am, Al Viro wrote:
> On Thu, Mar 17, 2022 at 06:26:11PM +1100, Imran Khan wrote:
> 
>> diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
>> index 9d4103602554..cbdd1be5f0a8 100644
>> --- a/fs/kernfs/symlink.c
>> +++ b/fs/kernfs/symlink.c
>> @@ -113,12 +113,19 @@ static int kernfs_getlink(struct inode *inode, char *path)
>>  	struct kernfs_node *kn = inode->i_private;
>>  	struct kernfs_node *parent = kn->parent;
>>  	struct kernfs_node *target = kn->symlink.target_kn;
>> -	struct rw_semaphore *rwsem;
>> +	struct kernfs_rwsem_token token;
>>  	int error;
>>  
>> -	rwsem = kernfs_down_read(parent);
>> +	/**
>> +	 * Lock both parent and target, to avoid their movement
>> +	 * or removal in the middle of path construction.
>> +	 * If a competing remove or rename for parent or target
>> +	 * wins, it will be reflected in result returned from
>> +	 * kernfs_get_target_path.
>> +	 */
>> +	kernfs_down_read_double_nodes(target, parent, &token);
>>  	error = kernfs_get_target_path(parent, target, path);
>> -	kernfs_up_read(rwsem);
>> +	kernfs_up_read_double_nodes(target, parent, &token);
>>  
>>  	return error;
>>  }
> 
> No.  Read through the kernfs_get_target_path().  Why would locking these
> two specific nodes be sufficient for anything useful?  That code relies
> upon ->parent of *many* nodes being stable.  Which is not going to be
> guaranteed by anything of that sort.
> 
> And it's not just "we might get garbage if we race" - it's "we might
> walk into kfree'd object and proceed to walk the pointer chain".
> 
> Or have this loop
> 	kn = target;
> 	while (kn->parent && kn != base) {
> 		len += strlen(kn->name) + 1;
> 		kn = kn->parent;
> 	}
> see the names that are not identical to what we see in
> 	kn = target;
> 	while (kn->parent && kn != base) {
> 		int slen = strlen(kn->name);
> 
> 		len -= slen;
> 		memcpy(s + len, kn->name, slen);
> 		if (len)
> 			s[--len] = '/';
> 
> 		kn = kn->parent;
> 	}
> done later in the same function.  With obvious unpleasant effects.
> Or a different set of nodes, for that matter.
> 
> This code really depends upon the tree being stable.  No renames of
> any sort allowed during that thing.

Yes. My earlier approach is wrong.

This patch set has also introduced a per-fs mutex (kernfs_rm_mutex)
which should fix the problem of inconsistent tree view as far as
kernfs_get_path is concerned.
Acquiring kernfs_rm_mutex before invoking kernfs_get_path in
kernfs_getlink will ensure that kernfs_get_path will get a consistent
view of ->parent of nodes from root to target. This is because acquiring
kernfs_rm_mutex will ensure that __kernfs_remove does not remove any
kernfs_node(or parent of kernfs_node). Further it ensures that
kernfs_rename_ns does not move any kernfs_node. So far I have not used
per-fs mutex in kernfs_rename_ns but I can make this change in next
version. So following change on top of current patch set should fix
this issue of ->parent change in the middle of kernfs_get_path.


diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 1b28d99ff1c3..8095dcdd437c 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1672,11 +1672,13 @@ int kernfs_rename_ns(struct kernfs_node *kn,
struct kernfs_node *new_parent,
        const char *old_name = NULL;
        struct kernfs_rwsem_token token;
        int error;
+       struct kernfs_root *root = kernfs_root(kn);

        /* can't move or rename root */
        if (!kn->parent)
                return -EINVAL;

+       mutex_lock(&root->kernfs_rm_mutex);
        old_parent = kn->parent;
        kernfs_get(old_parent);
        kernfs_down_write_triple_nodes(kn, old_parent, new_parent, &token);
@@ -1741,6 +1743,7 @@ int kernfs_rename_ns(struct kernfs_node *kn,
struct kernfs_node *new_parent,
        error = 0;
  out:
        kernfs_up_write_triple_nodes(kn, new_parent, old_parent, &token);
+       mutex_unlock(&root->kernfs_rm_mutex);
        return error;
 }

diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index cbdd1be5f0a8..805543d7a1f2 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -113,19 +113,22 @@ static int kernfs_getlink(struct inode *inode,
char *path)
        struct kernfs_node *kn = inode->i_private;
        struct kernfs_node *parent = kn->parent;
        struct kernfs_node *target = kn->symlink.target_kn;
-       struct kernfs_rwsem_token token;
+       struct kernfs_root *root;
        int error;

+       root = kernfs_root(kn);
+
        /**
-        * Lock both parent and target, to avoid their movement
-        * or removal in the middle of path construction.
-        * If a competing remove or rename for parent or target
-        * wins, it will be reflected in result returned from
-        * kernfs_get_target_path.
+        * Acquire kernfs_rm_mutex to ensure that kernfs_get_path
+        * sees correct ->parent for all nodes.
+        * We need to make sure that during kernfs_get_path parent
+        * of any node from target to root does not change. Acquiring
+        * kernfs_rm_mutex ensure that there are no concurrent remove
+        * or rename operations.
         */
-       kernfs_down_read_double_nodes(target, parent, &token);
+       mutex_lock(&root->kernfs_rm_mutex);
        error = kernfs_get_target_path(parent, target, path);
-       kernfs_up_read_double_nodes(target, parent, &token);
+       mutex_unlock(&root->kernfs_rm_mutex);

        return error;
 }

Could you please let me know if you see some issues with this approach ?

Thanks
-- Imran



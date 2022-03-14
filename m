Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1593E4D8A53
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbiCNRDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242644AbiCNRDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:03:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D798F3614A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:02:11 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EFTHSe009865;
        Mon, 14 Mar 2022 17:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mISrCX70z/rxHRfGjFIF8J8xRhQQTFBktE2pHIBhCt8=;
 b=a5pjN9WCFh/+rG1xaBeXSMvXbHDoyI+3aryG9ZjG8x3dpLhaWjM8QTIy4/gz4quGLHaw
 6ybocbX4k6mWTiQi6IknIsFdHVMoYbpcIyTljUACxMlkqwEcZzhX+wyyGpRprX5yExJE
 aqj2kOfIflqAdJXf0gbx0c+rwkgz35oyMXfVM3vhas7UHscd8GKSzEvJi1Yd40Ezkn7T
 5lGxafDoK1XivlKFWSYDcc2iW1UEjUCii8kCwutMv77nYWCcp1aY2Q//FqB5Q52rCNxh
 Fn037ywcj2JyC70t4yYAJ/jQl4Wyx66JzCkUCQywaPeZd8rauEgAe62g+/jK7qiVklb6 3A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5xwgts1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 17:02:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22EGojRj016295;
        Mon, 14 Mar 2022 17:02:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by userp3030.oracle.com with ESMTP id 3et65nwjpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 17:02:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHuG44u4DtoXp4U0Woj4VdlhnRjFao0A0/cQ0hGBVbvHBgtdNhnEPiwq5beRKxtZ5wObbB+hyDvFZMIRj0A2n9oR/rN4NBciJ9sIl7XTjbvksgJefunK88F8h6tuVoMjLUU75hQd95iWbIxSypZobIIrkHeQ0cfKqY14xAKUPtwtuLY/QuACnBDqpTTuLxuNuc8zmoTcdg5sF9YzNeo35QkWAGOJr5kI3GSOhC0hW8WM+s7lQMfClpJ14WrQy4WGtZQMO5pIvCzBXDq+MLiFg2lEu7efES6O5Ty1W86Op6hY56DnTCYZtYGQ/VUwVKDPVN6gmV3xkfnTF/zk1U69vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mISrCX70z/rxHRfGjFIF8J8xRhQQTFBktE2pHIBhCt8=;
 b=Rqm74Wi6kbWDEt9d5gRu8xqcFkONxwu50JmYN2Ee3w6vQ3DwuLcVGBvZOBmdlJret1/FSaLUvvsVGb8E1svcus6CARJkOwDirJ0U1xEBff9rz5r27yis6noisyTrP4o+xFR2TzpvpgLCg32A7D1mnwqk+a86GD3LfjIeHk7/SvC7RNNxvrudBiEI+aMVgUitk5m+rWv5DWhUPKJLf0U6Z9DAmeRL4ftKt84eEhHSMAjWGJBuHZGfT0HLezQrVl94bqUHFgC0N22JNXi0N13NNlQRHPK+igk+x2sMPHHhbJ8htvBoToD25hGQQV+hPCDUYUtxmDezsL2tj6xh28btxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mISrCX70z/rxHRfGjFIF8J8xRhQQTFBktE2pHIBhCt8=;
 b=Vs8qVifXL3QpV3ES6A49cMJVSZaAj0aBozXpnxSh4dg4lKJbhUmKFh2C5YmEuVhXSWSBMJs6z27y7HuCVWLyzKAIEjeQ8FO5LCZaTpYHhAlcf8508fmSkzfFR89Zwd4CQ8ME4WzNMfafWjyGxw746CGK4BjSlqYhnhnC+DV2YCM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN8PR10MB3251.namprd10.prod.outlook.com (2603:10b6:408:c9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 17:02:03 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 17:02:03 +0000
Message-ID: <3d22ac50-f13c-c2db-f5b7-dc229c3709f1@oracle.com>
Date:   Mon, 14 Mar 2022 10:02:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [cel:nfsd-courteous-server 29/39] do_mounts.c:(.text+0x66):
 multiple definition of `locks_owner_has_blockers';
 init/main.o:main.c:(.text+0x0): first defined here
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
References: <202203130709.dYmfXVEC-lkp@intel.com>
From:   dai.ngo@oracle.com
In-Reply-To: <202203130709.dYmfXVEC-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:806:122::35) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f36f094d-13e7-4384-be7a-08da05dc5cea
X-MS-TrafficTypeDiagnostic: BN8PR10MB3251:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3251C548364CF4DFD7336A4B870F9@BN8PR10MB3251.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c/HOZeaAbgKv+yRSbL/RCaTPbG3ZR1dQ66sVeE75JFi0o5JWhGO2NlQUQHS3yTmFhsdzzxzTUemuE1TO2RysacOtcIME0ST/RWGuM0QjNZB7jcLZwrfgUOv6YptlF48tzIt1O9CgzwA9b3SMapy1qsKf2dZPODsntPn0UThdJHJRVWy3A8nNv0fFBJOD5CfapcbROr0URgBQN/ALpSYGNTs4tHNByGeqKhPr2/muEzgjzvlk8wpi9zhOsrRv3jEZ8jMiV9xHTXq0ZrM3RNxSkpi2F5ODt5B2mTvnL/MwDOq6Ytm59u7CHK//GWiNC16+wPwukW+wErEKoLnvTxa4Bk02trUMhPnhu0EBE7VVhJer8Wp+nEQDtb69uZDaL9cLGi8NlWwTJsh7Yi/Xy3NRzeteMYAPala9JPZaWAspvgXZfD3zwespaN3YwSDFpI6h+6/Up5ojJv4w0+sChy/2Y92aDNfREoTbgZVEIk+QlOV9vOuSD1EmIEUGbU9RDehWd7YtpdKW3LGzyYIuU6oFKvGU1leDA/WOsmgV8fnfF0YYrPSfYd/glxO9zm/P4XZtFfX4+GMKQ/4Hzzi1OboifKwBZagvRxwHtDTV0MHDXQIVW/fHpXE1/hAOBwCrPykFQuysoHx8Smn18RVt7e9i8Ynwr8Oer3CgFAc5aUh6WSCs3tuUdcCjL/ye74zhRfnl8KvG+qASTr4XCZpT9HAU5ZtGl+CL4tu1SKHBWT9qWls9PNOBkVrADuPp3At61KZBt80XyOAWoNtEJB2QOpz0wnyEQpnakH4h1UaKduHnyKmShixQKbE6MR/4J3b99xyTd6k4QrIK7BZuhTnCR9H8qQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(84040400005)(186003)(83380400001)(26005)(8676002)(316002)(4326008)(6916009)(66476007)(66946007)(66556008)(36756003)(31686004)(966005)(6486002)(6512007)(508600001)(31696002)(86362001)(2616005)(107886003)(5660300002)(8936002)(30864003)(38100700002)(9686003)(53546011)(2906002)(6506007)(81973001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHBPMzkyN3NEang3YmEvVmNVa09Wb05tRDQ4ckxZS1dUR3FnWktqU01Jc0FX?=
 =?utf-8?B?ckpMMGUwclZEeVlLUkVuM3pRRU9yZzRmUm5MNVBndlZINHl6UFQwc1U5bkpv?=
 =?utf-8?B?ZDNqVUpwL1NUSVRpMllMa3Z4WWZoUS85RXdZRS9ON2JtVVl3bTJwNHlaOUtK?=
 =?utf-8?B?VGlISFB3UFlGN0Z4SGtQcmk2WXFiWXpvK25Ldmdtc1dvZjd5ZDNOMVRDT1pS?=
 =?utf-8?B?aTVXdVdpd1BFVXgyOUFHWUFBWkJpbVhMYWNGWWFCMzhvZi8rdXBHaGNwak5O?=
 =?utf-8?B?NG8xdU5FVEo2b0UxclMxUWhzeTh3VGNBR3dvblpOWlBrY0FEODR6MllnUGo3?=
 =?utf-8?B?SjU2dlc5OCtIU3d6NHJTdDRlYi9DYnhJOGZvVlBzM1Vod1ZmNitCYnZsckJy?=
 =?utf-8?B?ZXd0Zy9xT3VTTWpoSy85R2k3NndjOGNLTUJzcHU4OGlpN3FTTk1RRDhydE9i?=
 =?utf-8?B?cWRHdUFtQkgzeHdjNTRyRGNQRDF1cXlqWC9nY3FHMDhPcVQyS3VYL1Jmc011?=
 =?utf-8?B?TTBvWjQ5VUhlT09CajJiU0NXWUtCUXViaGtFUnhIL09QUVZqYXZvZEV5aVFq?=
 =?utf-8?B?K08vUExOejNWKzA2YTFXd2lLSWNaUm8wRUlaWkNkOGR6QUk1c0RzUis2MFZw?=
 =?utf-8?B?WHdiWERSSVRnaTEreTFKOFZtZDYyRlM5bExITFZpNXlwb08xSGNWa1hUbHZx?=
 =?utf-8?B?VXJIOE9IWFBwRFdNczVhNmZzMVd4VE4vNXROWThBUjdsVkhBNnAxNG5DOENS?=
 =?utf-8?B?UVR1T0JzaXVTOVlIV05pZHlRbzZTVGphMUVXK1czYng2Q2ZmMTU2Y0hkVElh?=
 =?utf-8?B?ZXZXd1dGTE54WDZSaG9vazByam43ODVrQ3hWQ1dUK05QbXF2SGQ1cFFvTmRZ?=
 =?utf-8?B?TThPVThoYVZ6TGFmdzErL3JMWCtmVVhMUU5pa0IzVW9kSFNkWGEzRTVFSXQ0?=
 =?utf-8?B?ZkZWUm0rTE45bWdyVi81VTZJSEh4SG9zMzJjMDZWTEk5WGI0NyswNEM2NTBx?=
 =?utf-8?B?Q1lBV1h5TG1nQ1ZXSHJkenNUMHNpMkg0Y3lpZ1JtQlF2QmlMMzhTTFZlYnlX?=
 =?utf-8?B?dWZhYWtvc1JGVDV5ZEdyaHJPTVV6YlZHR2NUWTl1bjNDMzZpWWN1dDgwb2ln?=
 =?utf-8?B?bjVLdHE1WS92NXVsa2d2eit2M1dkU2FLUXFoV0hzMjJ2dmNEVU5OUkZsOGcz?=
 =?utf-8?B?dE9pWUFYaWwrL2xpckI2REx0emZremE0Vit5RG92cThSV0Q3NFgxcWp0NnJE?=
 =?utf-8?B?QzNSQlE2d3k2VmZxd2R6NFlJVTZLcS9qb01ybDlCRWU0dHlCWWZxcVQwVVo3?=
 =?utf-8?B?alNrTC9GVnQrSDhOL1hUb1NnRkk0dFNJZjBMZU5lWW9NNW9qUGVNZ3lOTmRj?=
 =?utf-8?B?emJtMENEeUQzOS91KzNvVUswUkl4WnlzRzNzd2c0czJUUGwwTE12djlKN0Nk?=
 =?utf-8?B?VFZFTjNHMVVyUFJsT1lDS25DQjJnZEhUaEI4QTVLd0tpOFdxalEzdE9VZFpw?=
 =?utf-8?B?MVU1blBOR2VpaTNVNmNFbm9yV2Fob01aZDRQVzJzMUpOTFM5empWSDNqSDFU?=
 =?utf-8?B?OXlvMjA2MlB6Sm1BUnA0bkl0cXdTdlVmWVNERUpBTFFDNndDUmt1TFNVNXQy?=
 =?utf-8?B?aURFa1R1a3VGRDFYYncxejdYUDdvUHhXdUxldjMwMHROa0xqZWFJQlAxNzYr?=
 =?utf-8?B?MGFzdGsveEMweXd0Sml1Y2R3R01IK3k3L0swRDV3QzlvRVdPRUZpWnVEd3c0?=
 =?utf-8?B?SmtTVkFwNzJUM0lWSG04ckVFdWEzSVhJQnFwZWxZN2ZGZTdqQjhBUk5HNktZ?=
 =?utf-8?B?VzFKWEFoQWo4c2UwN0M2cjBlK0tUdjlZN0pMNWNtVlpyQ3Awc0NwM2dzSXBl?=
 =?utf-8?B?emhOSmYySlJQRlBjNzlhdE81ZTduaHZuL1dRVFlOanAzRlI2VExwb2ZkUmpv?=
 =?utf-8?Q?Dq8iCjrbm6ZQgZy2x+NNft8AhSltDZNk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36f094d-13e7-4384-be7a-08da05dc5cea
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 17:02:03.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MU1H3kObasUF8cDieHTub7zmkVcLI0EYyzjH4J98G+dYNPlbxKyjBBfGaKZ523t8LCObDW75mATGZf1/4tzGRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3251
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140104
X-Proofpoint-GUID: vqrdMKIfQinWMdpKpEvxqyvgWGsCBPmW
X-Proofpoint-ORIG-GUID: vqrdMKIfQinWMdpKpEvxqyvgWGsCBPmW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/12/22 3:38 PM, kernel test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux nfsd-courteous-server
> head:   ca4d8c00bb753707519f438e5286b2349af53054
> commit: 3a59c0f1c4d6cb882410bfc086ad81458d4cbcaa [29/39] fs/lock: add helper locks_owner_has_blockers to check for blockers
> config: m68k-randconfig-r031-20220313 (https://download.01.org/0day-ci/archive/20220313/202203130709.dYmfXVEC-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=3a59c0f1c4d6cb882410bfc086ad81458d4cbcaa
>          git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
>          git fetch --no-tags cel nfsd-courteous-server
>          git checkout 3a59c0f1c4d6cb882410bfc086ad81458d4cbcaa
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     m68k-linux-ld: init/do_mounts.o: in function `locks_owner_has_blockers':
>>> do_mounts.c:(.text+0x66): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here

I looked through all the functions listed as having multiple
definition of `locks_owner_has_blockers' such as init/main.o:main.c,
arch/x86/kernel/head32.c, init/do_mounts_rd.c and many others.
None of these functions has 'locks_owner_has_blockers' defined.
I think there is a problem with the tools that detects this
error, can you help to verify?

Thanks,
-Dai

>     m68k-linux-ld: init/do_mounts_rd.o: in function `locks_owner_has_blockers':
>     do_mounts_rd.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: init/do_mounts_initrd.o: in function `locks_owner_has_blockers':
>     do_mounts_initrd.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: init/initramfs.o: in function `locks_owner_has_blockers':
>     initramfs.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: init/init_task.o: in function `locks_owner_has_blockers':
>     init_task.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/kernel/irq.o: in function `locks_owner_has_blockers':
>     irq.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/kernel/module.o: in function `locks_owner_has_blockers':
>     module.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/kernel/process.o: in function `locks_owner_has_blockers':
>     process.c:(.text+0xe): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/kernel/ptrace.o: in function `locks_owner_has_blockers':
>     ptrace.c:(.text+0x182): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/kernel/setup.o: in function `locks_owner_has_blockers':
>     setup.c:(.text+0x102): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/kernel/signal.o: in function `locks_owner_has_blockers':
>     signal.c:(.text+0x3a0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/kernel/sys_m68k.o: in function `locks_owner_has_blockers':
>     sys_m68k.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/kernel/time.o: in function `locks_owner_has_blockers':
>     time.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/kernel/traps.o: in function `locks_owner_has_blockers':
>     traps.c:(.text+0x12): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/kernel/dma.o: in function `locks_owner_has_blockers':
>     dma.c:(.text+0x62): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/mm/init.o: in function `locks_owner_has_blockers':
>     init.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/coldfire/device.o: in function `locks_owner_has_blockers':
>     device.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/coldfire/vectors.o: in function `locks_owner_has_blockers':
>     vectors.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/coldfire/m5206.o: in function `locks_owner_has_blockers':
>     m5206.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/coldfire/reset.o: in function `locks_owner_has_blockers':
>     reset.c:(.text+0x14): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/coldfire/timers.o: in function `locks_owner_has_blockers':
>     timers.c:(.text+0x56): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: arch/m68k/coldfire/gpio.o: in function `locks_owner_has_blockers':
>     gpio.c:(.text+0x26): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/fork.o: in function `locks_owner_has_blockers':
>     fork.c:(.text+0x6b4): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/exec_domain.o: in function `locks_owner_has_blockers':
>     exec_domain.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/panic.o: in function `locks_owner_has_blockers':
>     panic.c:(.text+0x1d6): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/cpu.o: in function `locks_owner_has_blockers':
>     cpu.c:(.text+0x296): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/exit.o: in function `locks_owner_has_blockers':
>     exit.c:(.text+0x948): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/softirq.o: in function `locks_owner_has_blockers':
>     softirq.c:(.text+0x12e): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/resource.o: in function `locks_owner_has_blockers':
>     resource.c:(.text+0x6de): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/sysctl.o: in function `locks_owner_has_blockers':
>     sysctl.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/capability.o: in function `locks_owner_has_blockers':
>     capability.c:(.text+0x288): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/ptrace.o: in function `locks_owner_has_blockers':
>     ptrace.c:(.text+0x474): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/signal.o: in function `locks_owner_has_blockers':
>     signal.c:(.text+0x9cc): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/sys.o: in function `locks_owner_has_blockers':
>     sys.c:(.text+0xdd4): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/umh.o: in function `locks_owner_has_blockers':
>     umh.c:(.text+0x47a): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/workqueue.o: in function `locks_owner_has_blockers':
>     workqueue.c:(.text+0x1e40): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/pid.o: in function `locks_owner_has_blockers':
>     pid.c:(.text+0xc6): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/task_work.o: in function `locks_owner_has_blockers':
>     task_work.c:(.text+0x24): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/extable.o: in function `locks_owner_has_blockers':
>     extable.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/params.o: in function `locks_owner_has_blockers':
>     params.c:(.text+0x998): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/kthread.o: in function `locks_owner_has_blockers':
>     kthread.c:(.text+0x6c0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/nsproxy.o: in function `locks_owner_has_blockers':
>     nsproxy.c:(.text+0x1fc): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/notifier.o: in function `locks_owner_has_blockers':
>     notifier.c:(.text+0x12c): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/ksysfs.o: in function `locks_owner_has_blockers':
>     ksysfs.c:(.text+0x180): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/cred.o: in function `locks_owner_has_blockers':
>     cred.c:(.text+0x11a): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/reboot.o: in function `locks_owner_has_blockers':
>     reboot.c:(.text+0x1d2): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/groups.o: in function `locks_owner_has_blockers':
>     groups.c:(.text+0x32): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/sched/core.o: in function `locks_owner_has_blockers':
>     core.c:(.text+0x918): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/sched/loadavg.o: in function `locks_owner_has_blockers':
>     loadavg.c:(.text+0x38): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/sched/clock.o: in function `locks_owner_has_blockers':
>     clock.c:(.text+0x0): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>     m68k-linux-ld: kernel/sched/cputime.o: in function `locks_owner_has_blockers':
>     cputime.c:(.text+0x76): multiple definition of `locks_owner_has_blockers'; init/main.o:main.c:(.text+0x0): first defined here
>
> ---
> 0-DAY CI Kernel Test Service
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

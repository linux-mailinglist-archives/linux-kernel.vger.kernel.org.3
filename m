Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412CE4E8B35
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 02:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236954AbiC1ASg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 20:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiC1ASf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 20:18:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8687BBF69
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 17:16:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22RBvcFA003735;
        Mon, 28 Mar 2022 00:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yB/GOMsz/FKwzBR4mnvjleJiedvtXZYoDxcMOaJ9oq4=;
 b=qFW2mfX/zqL32Qz5evMcTuv3RKVauvFDgvonSOiyK5tsSva46ij1kgufr+7fGkUgXYU/
 zpn6k940Ur4kuEG9DhFC/uiN5vSZMRTtj6zzxlS6J/aI8Axzh/hiknC9CNViK0ndjsNy
 dedJ4zsgiUxoHcFv4+VXf2PFfY7UbJe9uItMWdDvnd5UDV/uBWr1uBSxk9ukwAj6L058
 sk4Y7h5eMa0bmUg7QbQaWLUxmgz+6ZyW6kwNN7UFBsPK/M6YNTXr0LH7lTfkVyzZjf4c
 DpRr2dRXyivSM+vTaKTzEJ9idRTxB0ZQn5956KxqJw1qSH43dyStJPfQLDKfbgs9n7Ai Gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqb211k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 00:16:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22S0Do2F154680;
        Mon, 28 Mar 2022 00:16:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3020.oracle.com with ESMTP id 3f1tmyeut4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Mar 2022 00:16:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5FFQlXZkmujxE8wn4mAcHgCkS0VVX/qdX0GAwywUqXmlYowXaT8eH2fd/6ZFUk8gMKPiqYF9UFsIA32Eet3HG9dBuSQnJasueGzY2EiC8CoDkA6hzgJ4dfhHCT7OPi1Pzk0Sa/qHZVcw3+TtInFONBjBTPIRovaCT76HIjxhVjVvEwvgloOxfKR5zi7s2G5fE78dmrcvpoxg1+kUdfZ6kqyBA4yJY+B+gKCHUZ6s53crgmm5DxrDzyRbtnVAvG8MWiSjHoPxhXEBAOpd45js8vQ5Y2wDXzEFv7J55CFOMW8ZCSh9bdIv5TkeYb1gObUdXN+S5LNb4XAxq0QNmwuwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yB/GOMsz/FKwzBR4mnvjleJiedvtXZYoDxcMOaJ9oq4=;
 b=OnpsNz2nmXlPBw8yvDDmYvDMoVzI81Sq25pOtHq8qeZOhpKYAq6qQDZpqTMi7rdiGkvKVPFaBJpNiF3rggzMFyIWe9N5E6UVw8+0j16qlUJfpGrI08MdDT1Tm27P3iajqUxR+6R/kLSlrnqra/i/XHv+uO+B89Tj8tyDMgmP4VyoUGZoIb7mjwaEe9zSZei/zVtOLAAxYo4kbXJZ6ljBSkBtUczsQ3HPG0T4vTDmAHU1WXm1avdewus5hsFxjbNmuIk6P0SCzYtBC5u6ijuFRE3ZCLOEdO99vPKzOwkgimIKEZFhfjAXW51zKXxRD0h9jsoWMYY56MmsI7uNzT+9UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yB/GOMsz/FKwzBR4mnvjleJiedvtXZYoDxcMOaJ9oq4=;
 b=jJ8xHErsp3nhzqf05qQwCDPLJ1ycDOOcrS/vG41l0jABPEPu/ewwHv/0Gl1UBEKgRCwHQ3dM/KyF8LxLzITHBJiu4iJnqRX+iPhQbTlyKpzmDDccykvaW3QUIjCRUcRRyt1Y6i9hngGoIMCLlrEJrjJWjHiVU1+meuqDidXqtvY=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by BY5PR10MB4356.namprd10.prod.outlook.com (2603:10b6:a03:210::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 00:16:42 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::b5ab:1c3e:6540:d2fa%9]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 00:16:41 +0000
Message-ID: <a692a5af-158e-ad0c-63a1-6525ee6d3898@oracle.com>
Date:   Mon, 28 Mar 2022 11:15:30 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH v7 7/8] kernfs: Replace per-fs rwsem with hashed
 rwsems.
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20220317072612.163143-1-imran.f.khan@oracle.com>
 <20220317072612.163143-8-imran.f.khan@oracle.com>
 <YjPNOQJf/Wxa4YeV@zeniv-ca.linux.org.uk>
 <536f2392-45d2-2f43-5e9d-01ef50e33126@oracle.com>
 <YjgpaeFfFandY999@zeniv-ca.linux.org.uk> <Yjir/d5S3J1PTiux@slm.duckdns.org>
 <Yji8KT2K7ZKOQ+6S@zeniv-ca.linux.org.uk> <YjjP5ldCCGYqD+UV@slm.duckdns.org>
 <Yjk3Nqft/U6vDvd1@zeniv-ca.linux.org.uk>
From:   Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <Yjk3Nqft/U6vDvd1@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::14) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c012c8b1-f7b0-432d-d61d-08da10503be1
X-MS-TrafficTypeDiagnostic: BY5PR10MB4356:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB43566ADB87E638DBBB94BEB6B01D9@BY5PR10MB4356.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzNt77f51LCKqPHwlSSq7ITyiVbLkiq/2p83zhS/iRxfUFES+1jHHpsvDLnHJAXZwIWzftADI0o1DGRspVTueBvRGinaBpQ6k3j50qtROGECfHJUAV/obfElgRL3a7eKYNicFfzrN9VEm480W3S9JTAavQDYhdA8CM9yXnM1gLGmXLeVnojZaUa0HuZcrcAkblBrEgAPSPdLUK+9eoDQV5DzzImJcgEpZgjjfNM2B1BducnGz/h1Pr5kIjW2co9dtuoFlRT4i9HxJ6TYTyjajKrpR9tuGs0kkMfDGLJdYBjQyKvn47QsZKFJ2WmDJOJVTcL+1mWvCmc0DYCz9rLJPf4/3uD9A1EkYeFlFZabpHpUVb2/EHqtkW05WsdBTucTbfu0CmNVSvOGRY2ABv2i2LdqqupoP8NY8axsUDHKozdbdhpyR6Pn5wyTYMYq79UdJzLmWtvkJBtkdnjwOeFCx7OQ+SskKWJRdjh3DV4KiPoWfMgfDvLx6lRe/uJXK7nfRYD08HH86m54HTVG4Ryi8lfgtSPZrtER7grht96FuHauDhvpjY+tt15R1BKxRK1/96SA8CFbL6fYa14jWP1QzH7NxoWxHw5g1XT2wtcPrbl80jtg/U4pAWICreWP7Zu5rfU+igXfunoNFudMML8Pqsihpz+Ave6CClXW+QpXt7Cz4AyPrpLhgwsREUrIlA+DWx5h+0qEJMt1i0WkqFHDDoKKUwAb/MstCcXPM6EKS+c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4326008)(2906002)(38100700002)(6512007)(36756003)(6666004)(53546011)(6506007)(31686004)(110136005)(8936002)(26005)(508600001)(186003)(86362001)(31696002)(6486002)(316002)(2616005)(66476007)(66946007)(8676002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmpFcmxEakNucjdyMVdpZjhONldzeHpHd3h0ZjV1VXNhWm81eDU0azRFTVhu?=
 =?utf-8?B?WmpaRFhLR0ZHbnR1bjVYRDlxOUJjZW5udHluSXExWDJDcVRWQlhta0pvdXZs?=
 =?utf-8?B?bTF1cHI5d2xpUUxRcjhuTEN3WXZUMFlIdThHT1BLREZsNzNjVy83U1JzT0Vm?=
 =?utf-8?B?MWQ2bDg4b0RuWXp0OUdGbWR1MVNPeC9qRHh0SHg5QU9ZYmJxUmNPaFF6OGRW?=
 =?utf-8?B?ZGUzWFpGSkFpWjhRUENqQStsZGJCSjdvWC9xdWEyenhJeURNL2tXbnVaMkVr?=
 =?utf-8?B?T3FXN0xmNXpOZWcvVjk2M2ZIRFBMaGhkMkdVeVRsMTdoeERnOWU1WUYwdm9H?=
 =?utf-8?B?cnEzb1FMRUhheUJQOUV1aUsxaHBlTktnUGhpUzRZVVNwY1BEUUVFTUJWWlRa?=
 =?utf-8?B?Rk5pRldXaWc3RkNjb0UyT2lvelJkL2xTZWFac1pnbUt2WENSeE0xenZoT3dB?=
 =?utf-8?B?WW1wR0dXVmkwNU1jMkc5STdzbHFKRlRGSUJjS2FxMHNCTng4SHJoL0hNdGlT?=
 =?utf-8?B?NjBuUnhqQWpxaW5DdmhqdmltckFWQ0Z3cHU4Mk81SGRHbDJWRWE0c3poKy9O?=
 =?utf-8?B?OEhSTVBFcGhYUEt6bE81alR3WkwvTXdXbWhZVjhDMWdoZlBPUkgyUTNkVmFP?=
 =?utf-8?B?cGg5NWp6OFlPK1lqMzJXVTJLZG1Fa0Y0U0E2aGZxVUs3UUIvdUppMjNkd0R5?=
 =?utf-8?B?NkowaVBuWXpubzZvdHV6L1hJUk9xR3BKY2h5b2pyRnNiQzBnUHVEejdMdk9x?=
 =?utf-8?B?OTdSMnh2eE1GbXphRmxnZzlqUHpuRHdhc3g2RHJDaVRFTWxXUVNHK1pSWEhh?=
 =?utf-8?B?OFBkaXNSd29aamhuanVGNWFGOFFPSEJEczZkL2M0K3Y5R2tEK3BwZnlHRjdh?=
 =?utf-8?B?cENrSDdCNEphamYyQzN5bCs0Y2JCanArRVlad0EzVDBVMW0vUVdsUU9xL0Rr?=
 =?utf-8?B?ZU9nQzg1WGRWTW5xWndEQzNWNS9HeE1WeHZENG01Y0xpRk5RQnF6VW5RNEVE?=
 =?utf-8?B?ajRJRktGRDZRWTcweWZIYjRrby8yS3RJbmlRV0w3RW1XVHR2UUwvdlhFMjNZ?=
 =?utf-8?B?cXpEOTBSNGd4Y3VSRy9mT1V5ZWxrN0MxR3UvaTE4WkcvbFVWcVBaSFVPUEQ5?=
 =?utf-8?B?eFBFK2JVaHJLMjg0N2d3MjlFaXpOcEtVNDNVQVh1NDJiWWNXeUl6Vm5vSi9h?=
 =?utf-8?B?TGg5L0luM1RyMEZqWVJhUTlPOTVZRjFqRkxUQ2pYVXZyblljaTRpM2dROTZT?=
 =?utf-8?B?ZUVSOWhHQlpOSHMwaThDallLWEhCMlF2d25McW0zaFN3N1RKcWFYOWJ3eHEv?=
 =?utf-8?B?VG5PZHNHTDVLUzRSeERoM2hLN1JlYndYQ3o5Wmc3a3k2TDRvdERjdUJyUGc1?=
 =?utf-8?B?dFV2K1FoMG55aHd4UXBXdExrREZMUFRDTEdBNXlsb2xOSTcreGNhOXFKOUtL?=
 =?utf-8?B?bUZFN1c0UXc2M1EzYlg5SXUrNUJCaGpTYjVrcUczbnppV0M2T2FKb0pxWkl4?=
 =?utf-8?B?cjUyeG9CdXVKaWdnSjZHZHRTcFpDdWUzcTV0bDhhTFJBQk5YbFpFOTJjbHYy?=
 =?utf-8?B?OG40N0lFUEtybkVhdTNNL0d3QTBscC96Z1dXNGtvQkd3VDFYRW1pbEVVdWs1?=
 =?utf-8?B?S0ZiMXZKVGxxTnhyOG5VeWVlN3RhdnV2NWFqWFo3MnBXTFc3ZVZkMGZxenU3?=
 =?utf-8?B?UXBYUUVUYXNDcVRRSWNWZHdicnVzN21SZWxZc0ZCRnRkUC9vS1dUNHpTanA4?=
 =?utf-8?B?dzN3dXQrWWszTjZ3L3hDTlR0L0Vza2lka29DQk5FVFdoNVNhK20yb3Y2NHhR?=
 =?utf-8?B?VEwrYXBZZnRRalBJUlR4VzBlWnpkdjNzM2JKNnhjcGdkNEQxeGhEWnpuYVND?=
 =?utf-8?B?dTVLTHFac25WRU5LN29PY3lwRU84bnhvWGMyNVJ2Qy9va0czY0dLTkJsT1Az?=
 =?utf-8?B?ZEVPdTA5dVBpdWxGUCtScUNtYWFrSDFiVVZYeHU4cWoyTjcvc3hvZGJkVGpP?=
 =?utf-8?B?MGp1TXRDczUxUjFHYjJxMFVOWUhWZDdwSXBtdHlTeXl5VUpUSDhDVDFMbWtI?=
 =?utf-8?B?MzJINkx4LzNzdHRYdXp5VCt0aTZxbTFxWnlpOVF6cDlxeHdxMmFiOUJEdE1S?=
 =?utf-8?B?SVh4NkFNVWtjdkxFNkZDWjA3Nks2TEJDT1RueFVPNEVVT0ROMTdBaEVNV2pP?=
 =?utf-8?B?YmFtTlBVbVJwdlZpODNtNnFwTnJwdngyMUNkWXhBdU1LWVVRa0N3QU1BTmlm?=
 =?utf-8?B?b1p5T09jY1BWUzFZbGlmdUxVY2NGeVlVVFlZcFcvUzk4YjQ3a000Y1liaUd3?=
 =?utf-8?B?YzkyTHJ0UDQwbUhPb0tSOUVRcDRjLzJ1ZFI1Rm5LZ0xMV0lCblppMGZ5dURv?=
 =?utf-8?Q?jfMvxrC4JeqVhdKw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c012c8b1-f7b0-432d-d61d-08da10503be1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 00:16:41.7555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOCRrnW94zZvNd8r9NeNCXnem57CmA8qarx1kXTvxEKW83E/Ykl0gvWixBIVE610oiJFWirSVR0Zf9vpoAz0tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4356
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10299 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=979 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203270151
X-Proofpoint-GUID: zHy9WundMYYV6r7EJsYYuILGseI0Q9tj
X-Proofpoint-ORIG-GUID: zHy9WundMYYV6r7EJsYYuILGseI0Q9tj
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

On 22/3/22 1:40 pm, Al Viro wrote:
[...]
> 
> Sorry, misread that thing - the reason it copies the damn thing at all is
> the use of strsep().  Yecch...  Rule of the thumb regarding strsep() use,
> be it in kernel or in the userland: don't.  It's almost never the right
> primitive to use.
> 
> Lookups should use qstr; it has both the length and place for hash.
> Switch kernfs_find_ns() to that (and lift the calculation of length
> into the callers that do not have it - note that kernfs_iop_lookup()
> does) and you don't need the strsep() shite (or copying) anymore.
> 

Regarding using qstr in kernfs_find_ns, do you mean that I should remove
->name and ->hash with a ->qstr in kernfs_node and further modify
kernfs_name_compare to make use of qstr.name and qstr.hash.

Also the suggestion about removing buffer copying from kernfs_walk_ns is
not clear to me because kernfs_walk_ns invokes kernfs_find_ns with
individual path components so we need some mechanism to separate path
components.

Sorry if I have missed or misunderstood something in your suggestion.

Thanks,
-- Imran


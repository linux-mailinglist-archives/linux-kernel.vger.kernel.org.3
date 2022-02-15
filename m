Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1DE4B6B41
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiBOLf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:35:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiBOLfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:35:25 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C7113CFC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:35:14 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FAH3pk007111;
        Tue, 15 Feb 2022 11:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pdPjxT8eDyQFSjzCBeDoEVABDR5PSE7y4JidY0Y09PU=;
 b=CC4Gyd0TkyO/rW85rQ+yv5JIhzX2oiFzV5Get1lGpI6JiGnpwRkxH8FkvqC1xZV9lAzl
 Olb3ozs7xkOhv7h/ZmnH3W8G2keGaUPdPej8nfdGF6SotwSIzpbJdzSGE1ZG35y7JIVx
 BAPcERbNREmzj5uI+dpUo0LoPthCVmE1tcFi5nyWsgi7/oYsV7/JFEJZHkx3vTpDRykM
 GOqV6R/vO7hdsU+e9q9Yv4dPJh1GOJ345D3RBRkbuhtJqELzK5s8iTanDegYbTg5/r0+
 2IbCbMO285qIi08cF4algBJ+DRz8IiYn5F6cyNfQY8UPYhgJw9sC6MYHHkxZsGB+QgsC 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e884r8nfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 11:34:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21FBUfZ4113841;
        Tue, 15 Feb 2022 11:34:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by userp3020.oracle.com with ESMTP id 3e66bndpuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 11:34:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzlCDQcEHN609sEvKgQvg6+iTJVh7EmasfsZm/osYMwIrE4Ey5PygNrLVR/ceLlsKjkMiz0V2RUw2w12HFW53Dr5YzraP60YIosSoptgg8JmzFCenkQ1Fwip3ZR6eBEpP6FsW8IP6ZVt4JpyshSWM3Gz9IWxg5b2iWo0771fv2TPBIJsUQUpJa1AIW9PHkX0ZqBwz0NpTGTfVN0TpisvHgpHaJCf35Om26d6WMjL8AD72kZ5KzD7FbCowAN4pI+x9hE0ntWrhxSEgY9sb3XJNrHWDCHgDPMyrXzSa5uf8ZwGHtE+QL/w/0N4u3aCKLR6pb0yqxyq82J1V4hqm8pKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdPjxT8eDyQFSjzCBeDoEVABDR5PSE7y4JidY0Y09PU=;
 b=nIqeHBzO1DNcmZ/5pTH11XewC/s2mchuvHI7n1nQkEpN7k3REiRVgYiY/atsBrRxl+LiUAl/mGHMV+U4iKUfAsDCWxKimnapJNsTYss/+cVKKONGMXY3xe1I2Zh5BaxMr3Fdtg/noS7tYwpbILe5PuWBZJv/ItwpXx22EsgTt+VbMDABLuienmNu6c0ybg4BrQx6fDSOO0RNBYK1swOFQFhPG3zD0qWrfMRFeX50paEpJGw9r3+CrxZHnNhmBxF4UQ5ENoay66dAsHOQzaZViNdnK18JhPNI28NLLxf2pGAYh6krjlLmQ0HEff02fhSlmuIKhhRRwmSKmhLimZYU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdPjxT8eDyQFSjzCBeDoEVABDR5PSE7y4JidY0Y09PU=;
 b=oL5pKTDdZt8JR5OeH86kWzWYl+S4yl2e+vtV0tw8W2uFgc63+lU5OytcbvioGelCNeMmZe8NWD6lJrusM1YaJmy5fWcKEsws3j7iJTolTHMQxcjSRM+EaVmnNuLaWepqs9Y73DfOXbLAZBcz9ihDUP1NotwE2ah+rWA77nAWrR4=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BL0PR10MB2898.namprd10.prod.outlook.com (2603:10b6:208:75::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.19; Tue, 15 Feb
 2022 11:34:47 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 11:34:47 +0000
Message-ID: <2e584fc4-163a-0af4-abe0-9c14996918f2@oracle.com>
Date:   Tue, 15 Feb 2022 06:34:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] x86/boot: Fix memremap of setup_indirect structures
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        daniel.kiper@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <1643303056-22272-1-git-send-email-ross.philipson@oracle.com>
 <1643303056-22272-2-git-send-email-ross.philipson@oracle.com>
 <YgabtFd4Nkpgi+oW@zn.tnic>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <YgabtFd4Nkpgi+oW@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::29) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8a6ef07-ed14-4d99-0fab-08d9f0772b40
X-MS-TrafficTypeDiagnostic: BL0PR10MB2898:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB28983D9E32CACAC590BB3DC9E6349@BL0PR10MB2898.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wcjX1vi+mJtX80O46B/ggJpJUv5Wl/cinRi92aOWuCo+oVnSldvNZw292llovsAAUfmdiEqtAacxOrW+EXTzn8n6md6mzAMs993oTwesVhaFu8XreER4HfCVIjNKR6z5fk6RTRudFiyd/9N6+9zfrDecBwG5XpJ47HbhfcBhTh2oedvzV6TvsPMe08cCyXeJge4zel6vSHkPzbhG7dovtIBOXoyx9lyjkcO5ka8eLozHh+iW0lUGUJeuLAmCww+guWGi2j3R1hBjk4m9M9P02fgF2bSrUWNJm1SIseevHUe+UNX6QPq+UiYWyj4scJxf17Mjn/ZQjlQhXan1OZmb0L61Qua4K0PYaKtD+0+wq75szfrzvLCRSCnEFr2N68K3uKkQ2qQ8TAETiulP3kPZeaJarlQysomvqXn3yaWVqVGo35MvL6KVJdyaAirhey1P/hE2qJmeo8sb87GPknY2IqNU1iLuO6vjo0yKxk72ywDpYbBXGojH+yAbNWv19JTwQ1yd66gCQMNOTZJNEnnK0n7EymYc1Ag/8/9MM6kTK9cL6d6c2Oqlz2ohlsu5yXpAUYZ2t4NS0Bn3DWUxpnPR8eeuo/Ub3+L00XWirbVvY/uf9nvX25Yt7K8sHLjGm/gxCE5xq4OY7rHL6ywo86SNfm1RyvH6Y/TtDyNOwBOF/IeXIVLEdHRFo092bYvOp7cuw0LKV1DJ87FRNe70tFGS+jbPuJSp+5BMjGn5DO0F+sXkXfHH1FGAaMUH0fyXqAGF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(8676002)(44832011)(4326008)(8936002)(186003)(36756003)(6666004)(6512007)(53546011)(30864003)(2616005)(6506007)(86362001)(83380400001)(38100700002)(316002)(2906002)(6486002)(6916009)(31696002)(66946007)(66476007)(66556008)(5660300002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3VUWWwyNGdrZTVMNFdQWGpMN01ZNjNoTmxONEJsSHlmV3ZNR01OYmpqemp5?=
 =?utf-8?B?dmpCWGx1TDdzUVIzQ3RxeHVEUVdJNUJnQ0k5cTZBcVlObUxLKzJmSjRPVzJS?=
 =?utf-8?B?TzJpSGNUMm9pZ3ZSc1p3YUZISG01WkF3NkJHNDdqYVY2RXhZTFU5UStULzIz?=
 =?utf-8?B?aHprZENudTdQMnhLTEZDRUw3cm1JamMyT1dOYTVzWkdnTHVHQ0tLZVhhcThF?=
 =?utf-8?B?OHV2bFVrN1FwZmhZeDJQMWVEd0daOW80RUJXRi9wTUptNExta1Y1OXhyU0Z1?=
 =?utf-8?B?Wm1uZzBHUVF0bERUMWVPeXlKWFUxUm5NRDFOWUhpWnZyQWxWaHFGVG9yekZI?=
 =?utf-8?B?NkRDTE5Jb3FXeWlwZFBpakg0ZDh0c2ZLaUdjQy9YVlpoclF6K0tZMnErcVVK?=
 =?utf-8?B?a2o1NDN4VmNDOTV1ZElQTVphREZ6a2Fmb21aVmFhQmttK3dWVGdaS0NoTGZV?=
 =?utf-8?B?K1RMRmFic3NOdTQ3Qkl0RUErLzJLRnlFaXNNZjNLN2YvdytLb1FSNlFmejUz?=
 =?utf-8?B?d3NYSWFFelJBYU85OUdSSUtWaktFZ2IxYitLWlBjeFJUQUR0UTN4QnRHZ2l4?=
 =?utf-8?B?VEF0Vy9kNXl5K015bDlaZXFpMWdkRUVaeDE5ZXJZVFR5LzdjcGw3ZENYOFdS?=
 =?utf-8?B?RDRwelRYMVdTaFBjdHlYTUdKbXlib3EveElNTGdUL0NSZUI5Ym5JaS9nb1N6?=
 =?utf-8?B?YWtvRUtYYS8xQlRFS3AwWlNXRW41eXh1NTgvc0EvZ3o4VEJSdVlza0dTbzl4?=
 =?utf-8?B?YkY0dlJBcVFDLy9abng0ZitrOVRUL3RyNnZ2d3ZHQVlZTGI3UkFCWmhKNVpZ?=
 =?utf-8?B?NXJjaGxlMU1iTmg4alNtemRrMHdrQmZRalI1QUhzZWJicDRGSGd5NlRsckhB?=
 =?utf-8?B?b29ERFdNQUJlcVU4d25vQlhlWm1KOEFFeXhXMnVsUXIvWWY4NFNWTkNGV1A1?=
 =?utf-8?B?aEJpMFh1TWhtekZSbkRHUzQwT3ZqYXZNUUZSby9EaWhxdVcyY2JzeVpLYUF2?=
 =?utf-8?B?bTJnays5eVZBb2UrSWkxRUtMOG5RaXZWcGt4MSs0cVdyVU93eFBrMm14empq?=
 =?utf-8?B?S1ZyVGhCN1RoMzAyMXREdlBvakZKYnhQNkJQTmRZdC8xMHZSdFU4TnNsOG9L?=
 =?utf-8?B?bmV2U1lVd29iSVlXUFc4Q3NNSVlKTVk0VW0rdzd5ZytCNlVJNFpDTEhMelln?=
 =?utf-8?B?VkE1YWkyWGRaZnFKeDIvVVNFRXdkYmVRMFZMc0lTMko4TDYySjFhWS9IQmtS?=
 =?utf-8?B?STN3QlhEbzRzSy9PamhnVFU0RmVLVUg5U3ZKUFpXN3VqbVpjODF2cTlBZkYy?=
 =?utf-8?B?S0NJbFFNZzJhNWQwWTBxRE5jUTVqUVI1QkxNSFAxZUpEZGFuWEdadlk5NWpL?=
 =?utf-8?B?VW84ZEhUS2dpS0pqcHp2WUFkbzg5d095UEh4UmJsZUU2d2F1TlFhMlNxWlRt?=
 =?utf-8?B?OGE3VlNPL2VkOVBadXdCeS9zT1ExSmZ3TDZzUjlzSkxBTHByaU44a1BqdUpF?=
 =?utf-8?B?bVhpV1pGMUx1ZytvRXU5NHEzOUZSVGZBemhMNlBqbm94U2JscGtJTndGRFFQ?=
 =?utf-8?B?cmRaSTJVMjRhZkdCOWJJM3U3MnNsblI3cG1RTDAwTXZjWklUYXVBd2dBVkFH?=
 =?utf-8?B?bXhNR2xPNWpQQ3JNYzlzdUJseGZCRGRpS0g5MmZaT21XV2tLOVpUdkQ5R0FM?=
 =?utf-8?B?WEpTeVFJZW1JZkRJMDZYS21EZ2dCY0hIZitUM2xIOTYyWUJrSlBod0dkTnRR?=
 =?utf-8?B?ZTBrbHgrekt2MlNkNk5KQk9KOEZoMDZkRkkzNWh6blB6WGRXZm1sWHIwaUZV?=
 =?utf-8?B?VER5bVlWdmwyZU45UE1HQ1lMR3NrRHZIU0dpWGRPTm9teVN5dHJYVjFab29h?=
 =?utf-8?B?eGFwNnNuR1I3WHIwUHpoL2hUUUtCazlhN0Jya3hBMEJjOGFKakduRGprNTRK?=
 =?utf-8?B?aEdSZnRmNHdzVXJTVEpJcGJWU0gzUGJPYytjdFJyNitKL1VMSHl4TjBOYlZ3?=
 =?utf-8?B?a1orZ0cycHFtMGpvMlViSlk3dW9oTWhzQkg0VWhiQlZnYnIrRWhHRnJVR0VC?=
 =?utf-8?B?d1FwL0ZjNTBsSWtDT1QweVdHdWdjbk9Fb2hZMGRGRUdPVFRrVlV6aSs0Rm1S?=
 =?utf-8?B?STZWUUIreHcwYlB1RUhEL3dFMVdsa1V5bkVCeGdHYTBZejRQbzFzOUdja2dZ?=
 =?utf-8?B?YnlOeUhNREVxbk1CQXdxV2ljRElIUEJZTmE5WHZadzdsNW9vaGtqZVhIRzFH?=
 =?utf-8?B?M1lveVRuRUF4amRoME5hY2hxeHJuR2YzYWc4UGJRMGc2WXRpQ1loRWdCOE1o?=
 =?utf-8?Q?Qs7AqZUQ6x6nKm9ctA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a6ef07-ed14-4d99-0fab-08d9f0772b40
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:34:46.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdKe2a4aU6C0auDnWMY4i5O6G9xYPW8QWyzy+quiBGjfYsIahuvvnLj9jkz/Qy3soUnyx+wOp8QMxAj1+iCRdRjYfUxxPlGe6uZ8Bjrm2Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2898
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10258 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150065
X-Proofpoint-GUID: NPiN_YX2rpNtGaRkxL1t57sBjN15Drc2
X-Proofpoint-ORIG-GUID: NPiN_YX2rpNtGaRkxL1t57sBjN15Drc2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 12:24, Borislav Petkov wrote:
> On Thu, Jan 27, 2022 at 12:04:15PM -0500, Ross Philipson wrote:
>> As documented, the setup_indirect structure is nested inside
>> the setup_data structures in the setup_data list. The code currently
>> accesses the fields inside the setup_indirect structure but only
>> the sizeof(struct setup_data) is being memremapped. No crash
>> occurred but this is just due to how the area is remapped under the
>> covers.
>>
>> The fix is to properly memremap both the setup_data and setup_indirect
> 
> s/The fix is to properly/Properly/

Ack.

> 
>> structures in these cases before accessing them.
>>
>> Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
>>
> 
> No need for that space - Fixes belongs with the rest of the tags.

Got it. Will fix in both.

> 
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>
> 
>> @@ -1015,18 +1019,23 @@ void __init e820__reserve_setup_data(void)
>>  						 sizeof(*data) + data->len,
>>  						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
>>  
>> -		if (data->type == SETUP_INDIRECT &&
>> -		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
>> -			e820__range_update(((struct setup_indirect *)data->data)->addr,
>> -					   ((struct setup_indirect *)data->data)->len,
>> -					   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
>> -			e820__range_update_kexec(((struct setup_indirect *)data->data)->addr,
>> -						 ((struct setup_indirect *)data->data)->len,
>> -						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
>> +		if (data->type == SETUP_INDIRECT) {
>> +			len += data->len;
>> +			early_memunmap(data, sizeof(*data));
>> +			data = early_memremap(pa_data, len);
> 
> Do I see it correctly that early_memremap() can return NULL?

It can if you run out of slots in the fixed map. The only reason I did
not check it for NULL was because it was not checked elsewhere for NULL.
I guess there are two questions:

1. Should I also fix it elsewhere in the code I am touching?
2. What should I do on an allocation failure? In a routine like this it
seems to be a critical early boot failure.

I guess the original intention might have been to let it just blow up
since there is no recovery but that is just conjecture...

> 
>> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
>> +				e820__range_update(((struct setup_indirect *)data->data)->addr,
>> +						   ((struct setup_indirect *)data->data)->len,
>> +						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
>> +				e820__range_update_kexec(((struct setup_indirect *)data->data)->addr,
>> +							 ((struct setup_indirect *)data->data)->len,
>> +							 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
>> +			}
>>  		}
>>  
>> -		pa_data = data->next;
>> -		early_memunmap(data, sizeof(*data));
>> +		pa_data = pa_next;
>> +		early_memunmap(data, len);
>>  	}
>>  
>>  	e820__update_table(e820_table);
>> diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
>> index 64b6da9..e5c72d8 100644
>> --- a/arch/x86/kernel/kdebugfs.c
>> +++ b/arch/x86/kernel/kdebugfs.c
>> @@ -92,7 +92,8 @@ static int __init create_setup_data_nodes(struct dentry *parent)
>>  	struct setup_data *data;
>>  	int error;
>>  	struct dentry *d;
>> -	u64 pa_data;
>> +	u64 pa_data, pa_next;
>> +	u32 len;
>>  	int no = 0;
> 
> The tip-tree preferred ordering of variable declarations at the
> beginning of a function is reverse fir tree order::
> 
> 	struct long_struct_name *descriptive_name;
> 	unsigned long foo, bar;
> 	unsigned int tmp;
> 	int ret;
> 
> The above is faster to parse than the reverse ordering::
> 
> 	int ret;
> 	unsigned int tmp;
> 	unsigned long foo, bar;
> 	struct long_struct_name *descriptive_name;
> 
> And even more so than random ordering::
> 
> 	unsigned long foo, bar;
> 	int ret;
> 	struct long_struct_name *descriptive_name;
> 	unsigned int tmp;
> 
> Please fix all cases in your patch.

Will do.

> 
>>  	d = debugfs_create_dir("setup_data", parent);
>> @@ -112,12 +113,27 @@ static int __init create_setup_data_nodes(struct dentry *parent)
>>  			error = -ENOMEM;
>>  			goto err_dir;
>>  		}
>> -
>> -		if (data->type == SETUP_INDIRECT &&
>> -		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
>> -			node->paddr = ((struct setup_indirect *)data->data)->addr;
>> -			node->type  = ((struct setup_indirect *)data->data)->type;
>> -			node->len   = ((struct setup_indirect *)data->data)->len;
>> +		pa_next = data->next;
>> +
>> +		if (data->type == SETUP_INDIRECT) {
>> +			len = sizeof(*data) + data->len;
>> +			memunmap(data);
>> +			data = memremap(pa_data, len, MEMREMAP_WB);
>> +			if (!data) {
> 
> Yap, you need similar error handling above.
> 
>> +				kfree(node);
>> +				error = -ENOMEM;
>> +				goto err_dir;
>> +			}
>> +
>> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
>> +				node->paddr = ((struct setup_indirect *)data->data)->addr;
>> +				node->type  = ((struct setup_indirect *)data->data)->type;
>> +				node->len   = ((struct setup_indirect *)data->data)->len;
> 
> Pls use a helper variable here to not have this ugly casting on each line.

Will fix here and below.

> 
>> +			} else {
>> +				node->paddr = pa_data;
>> +				node->type  = data->type;
>> +				node->len   = data->len;
>> +			}
>>  		} else {
>>  			node->paddr = pa_data;
>>  			node->type  = data->type;
>> @@ -125,7 +141,7 @@ static int __init create_setup_data_nodes(struct dentry *parent)
>>  		}
>>  
>>  		create_setup_data_node(d, no, node);
>> -		pa_data = data->next;
>> +		pa_data = pa_next;
>>  
>>  		memunmap(data);
>>  		no++;
>> diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
>> index d0a1912..4e8b794 100644
>> --- a/arch/x86/kernel/ksysfs.c
>> +++ b/arch/x86/kernel/ksysfs.c
>> @@ -93,24 +93,35 @@ static int __init get_setup_data_size(int nr, size_t *size)
>>  {
>>  	int i = 0;
>>  	struct setup_data *data;
>> -	u64 pa_data = boot_params.hdr.setup_data;
>> +	u64 pa_data = boot_params.hdr.setup_data, pa_next;
>> +	u32 len;
>>  
>>  	while (pa_data) {
>>  		data = memremap(pa_data, sizeof(*data), MEMREMAP_WB);
>>  		if (!data)
>>  			return -ENOMEM;
>> +		pa_next = data->next;
>> +
>>  		if (nr == i) {
>> -			if (data->type == SETUP_INDIRECT &&
>> -			    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
>> -				*size = ((struct setup_indirect *)data->data)->len;
>> -			else
>> +			if (data->type == SETUP_INDIRECT) {
>> +				len = sizeof(*data) + data->len;
>> +				memunmap(data);
>> +				data = memremap(pa_data, len, MEMREMAP_WB);
>> +				if (!data)
>> +					return -ENOMEM;
>> +
>> +				if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
>> +					*size = ((struct setup_indirect *)data->data)->len;
> 
> Ditto.
> 
>> +				else
>> +					*size = data->len;
>> +			} else
>>  				*size = data->len;
> 
> Put the else branch in {} too pls, even if it is a single statement.
> Below too.
> 
>>  
>>  			memunmap(data);
>>  			return 0;
>>  		}
>>  
>> -		pa_data = data->next;
>> +		pa_data = pa_next;
>>  		memunmap(data);
>>  		i++;
>>  	}
>> @@ -122,6 +133,7 @@ static ssize_t type_show(struct kobject *kobj,
>>  {
>>  	int nr, ret;
>>  	u64 paddr;
>> +	u32 len;
>>  	struct setup_data *data;
>>  
>>  	ret = kobj_to_setup_data_nr(kobj, &nr);
>> @@ -135,9 +147,14 @@ static ssize_t type_show(struct kobject *kobj,
>>  	if (!data)
>>  		return -ENOMEM;
>>  
>> -	if (data->type == SETUP_INDIRECT)
>> +	if (data->type == SETUP_INDIRECT) {
>> +		len = sizeof(*data) + data->len;
>> +		memunmap(data);
>> +		data = memremap(paddr, len, MEMREMAP_WB);
>> +		if (!data)
>> +			return -ENOMEM;
> 
> <---- newline here.

Ok.

> 
>>  		ret = sprintf(buf, "0x%x\n", ((struct setup_indirect *)data->data)->type);
>> -	else
>> +	} else
>>  		ret = sprintf(buf, "0x%x\n", data->type);
>>  	memunmap(data);
>>  	return ret;
>> @@ -165,10 +182,25 @@ static ssize_t setup_data_data_read(struct file *fp,
>>  	if (!data)
>>  		return -ENOMEM;
>>  
>> -	if (data->type == SETUP_INDIRECT &&
>> -	    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
>> -		paddr = ((struct setup_indirect *)data->data)->addr;
>> -		len = ((struct setup_indirect *)data->data)->len;
>> +	if (data->type == SETUP_INDIRECT) {
>> +		len = sizeof(*data) + data->len;
>> +		memunmap(data);
>> +		data = memremap(paddr, len, MEMREMAP_WB);
>> +		if (!data)
>> +			return -ENOMEM;
>> +
>> +		if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
>> +			paddr = ((struct setup_indirect *)data->data)->addr;
>> +			len = ((struct setup_indirect *)data->data)->len;
> 
> Again a helper var pls.
> 
>> +		} else {
>> +			/*
>> +			 * Even though this is technically undefined, return
>> +			 * the data as though it is a normal setup_data struct.
>> +			 * This will at least allow it to be inspected.
>> +			 */
>> +			paddr += sizeof(*data);
>> +			len = data->len;
>> +		}
>>  	} else {
>>  		paddr += sizeof(*data);
>>  		len = data->len;
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index f7a132e..6e29c20 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -370,20 +370,29 @@ static void __init parse_setup_data(void)
>>  static void __init memblock_x86_reserve_range_setup_data(void)
>>  {
>>  	struct setup_data *data;
>> -	u64 pa_data;
>> +	u64 pa_data, pa_next;
>> +	u32 len;
>>  
>>  	pa_data = boot_params.hdr.setup_data;
>>  	while (pa_data) {
>>  		data = early_memremap(pa_data, sizeof(*data));
>> +		len = sizeof(*data);
>> +		pa_next = data->next;
>> +
>>  		memblock_reserve(pa_data, sizeof(*data) + data->len);
>>  
>> -		if (data->type == SETUP_INDIRECT &&
>> -		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
>> -			memblock_reserve(((struct setup_indirect *)data->data)->addr,
>> -					 ((struct setup_indirect *)data->data)->len);
>> +		if (data->type == SETUP_INDIRECT) {
>> +			len += data->len;
>> +			early_memunmap(data, sizeof(*data));
>> +			data = early_memremap(pa_data, len);
>>  
>> -		pa_data = data->next;
>> -		early_memunmap(data, sizeof(*data));
>> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
>> +				memblock_reserve(((struct setup_indirect *)data->data)->addr,
>> +						 ((struct setup_indirect *)data->data)->len);
> 
> Ditto.
> 
>> +		}
>> +
>> +		pa_data = pa_next;
>> +		early_memunmap(data, len);
>>  	}
>>  }
>>  
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index 026031b..b45e86e 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -636,10 +636,15 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
>>  			return true;
>>  		}
>>  
>> -		if (data->type == SETUP_INDIRECT &&
>> -		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
>> -			paddr = ((struct setup_indirect *)data->data)->addr;
>> -			len = ((struct setup_indirect *)data->data)->len;
>> +		if (data->type == SETUP_INDIRECT) {
>> +			memunmap(data);
>> +			data = memremap(paddr, sizeof(*data) + len,
>> +					MEMREMAP_WB | MEMREMAP_DEC);
>> +
>> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
>> +				paddr = ((struct setup_indirect *)data->data)->addr;
>> +				len = ((struct setup_indirect *)data->data)->len;
> 
> Ditto.
> 
> Thx.
> 

Thank you very much for the review.

Ross Philipson


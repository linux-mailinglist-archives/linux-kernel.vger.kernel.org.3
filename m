Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08984D1EE9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349047AbiCHRYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349439AbiCHRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:23:09 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FE85622F;
        Tue,  8 Mar 2022 09:21:29 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228GmswG018604;
        Tue, 8 Mar 2022 17:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sTVguv2PxvF2++CGyjbG8B7i8Aop2IArIuuQRNvu9Zo=;
 b=KWPrJ7NhXkMWpzywMwlfpPZr0lhwyJ2MjQAFfFbXtAvDvBRz3cd8mTe2r60gnQzq3I+Y
 STTF3+02MOkylN7+bBlwm/QOwJfUn8USQzR4ymoo/kjU1NdbmUqhElX2IPN+l5sganjM
 hyoeIVDVUfM8KJcPGY6dRUT5jvFJi4xCrU8R4f1RbKFAcRYbIvVIIMu89f5rGGssDZbI
 JBlsJC6Immh2O4uhLFIu2ddiOxAqx0nMwobM7dVP9Z2adBGfll+NLGAiIbw+fNS1zWaQ
 pNcqcUz1foo+8ERuSJY05iYtBa+hAIw4HwrEDZpDWacbTziIuIJgkt/3AFap372xNpBv eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxn2fra1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 17:20:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 228HKO9q072190;
        Tue, 8 Mar 2022 17:20:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 3ekvyv3sbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Mar 2022 17:20:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4KuTtv05v9hxxo/1v6E5OASpUvoJPawfI2EzWtpIhp/PTMPvYnqsWkRdPzpDOUi9AWnSB7Tn/ziVF6OW+K5BWrFdcXknqYVLZ7hisj6x5Y+V8vgbdMpZYzO9jEeLsDqWuYROoCjSXa2Q6AGOnP5MlZ+y1LSr5yBBjk7P4np6dY71920mmuZ5egaFxd+WxDskHeu0nMxttIj7pPE4qxClTxxZTFb43OTjDv+h60YtWwueOvh5y1WEdkcBc4ZrpOhrbCoSbVOPJjW2xDgDen4eq7U5zurEftAYJENnvBVwRt4Okqfs0SaIiygcySNMdTh4Ellj8cc5VazxP9rcBVr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTVguv2PxvF2++CGyjbG8B7i8Aop2IArIuuQRNvu9Zo=;
 b=Yp533y/V8B/ItHSIaofAWBSFS2O0ruRG+XLo9/Wpoj7EMGXXFCCxmnRyKMz7VjaQb65V1aEFXy+Haz4t3uk72sPoQRDQY9udnK4CImocjPuRhF+f/SB9MJnp2V9TOSd13AmxGodxjOA9KlTHTu3kIo8k5ZeidBwbKM/12Rv70mPcxkHqWgLkcuCUGwA/5PgtI29IMFAfPUQMDkik5XpfMx5IPaOebsZW30ZFKlIwAxCqv4AtfjIVZgtCVuC5IxEa99c3s7TVTcpyZpoFVCm8D233DX8eOPreErBIJsDyflgJrevpxg50qsDGkk+qxLiTQm5X3aCDmVnHHEFZNMj/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTVguv2PxvF2++CGyjbG8B7i8Aop2IArIuuQRNvu9Zo=;
 b=c56wNHn8EOJmqPuShtVTD/Wd6y6kBXhn6Ri2BSbq/qgkjlTPximYEYxtCL+QD/6ZxxX+dZeTRK5Ty6piqhfNrJhwWKeSNOvC5dcFDBONjE0zMRHZOxoit1QUdFEU7pXVSp3ZzUI2zt5P7vjtjQe4Ai98N8VrQchogCumyVqaAGw=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 BYAPR10MB3222.namprd10.prod.outlook.com (2603:10b6:a03:150::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 17:20:49 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3dd8:6b8:e2e6:c3a2%12]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 17:20:48 +0000
Message-ID: <bfd40073-62ae-e458-a869-b0eb60414632@oracle.com>
Date:   Tue, 8 Mar 2022 11:20:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 3/3] scsi:libiscsi: teardown iscsi_cls_conn gracefully
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        linfeilong@huawei.com
References: <20220309030916.2932316-1-haowenchao@huawei.com>
 <20220309030916.2932316-4-haowenchao@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20220309030916.2932316-4-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR19CA0029.namprd19.prod.outlook.com
 (2603:10b6:3:9a::15) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea040348-266c-42ae-d565-08da0127fd04
X-MS-TrafficTypeDiagnostic: BYAPR10MB3222:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB32222EDAFB0BBE53CDF5D6BBF1099@BYAPR10MB3222.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tt6Y8932cDVvET0BpQH/lqL18uvIJCtf52oNfOC7dE3DTpdtz64EyqP+YsTrP6rC3jvVnDmSoscS1y7xFg0RbOTaHMiAlMiiIAtsLr5fobA9eANIRDETaS95wpX4TQLwIsG99xSI2LoSoF/6/dCKU9Grt6P2igkSEgYk7N9eFnz1/gmVcZg2LHK8IehEC1ASf0Uc4NmGe0ZHkldGOQZmSMtiNU7jUxOUMz0nEfeOREBFctjL+P3kVcUZl6UTF6cnX5jJr5AXbGHpX5D1psjEgPD9oonbCDLk8e3NwqeSevkslcJzZmaAxbvGaHMM/E7lhSIAUGfcCtNw2riNUHYd8CdALfVNEcEd+aBFtuAKPS6v8MRMyg/l+j5WDq7wGOysJUkaeofuEmssoJJFQwDxN+OC64PaMbz/4KRggKzUHBffvERJEWLBbm0ial1gwNGqkg90SJSijZfaakBDqYlkqxXiztDzS4/bVl/IaX5X7uV1tyiFrdQgeWcESg30QKBR6G75dIu5pKw5GB42bGwsDplqKP/aFRCSXYudnb+MAwHgmAfTxhGgaUDVo6emjF02S+62iGXwpfBA/0CK94HAIKcwXd3CXL89BtBGyJG3J/Fl5Wsyvj8deMWFhMiU4V/1hxxpu+FxWYi0mR8jxR9N5OWVetg2AXSvNl4FH0llV7yUQcJvA/oNvHyNcXOnBVwEo82528LF4dGHmvilYL0CJ4QKTRCEgnSPHMcc/90Po7ZpRDdZW1MH/F9asSQ5o2QU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(4744005)(66556008)(316002)(6512007)(5660300002)(7416002)(8936002)(54906003)(26005)(66476007)(110136005)(4326008)(508600001)(86362001)(186003)(31696002)(6486002)(8676002)(53546011)(36756003)(38100700002)(6506007)(2906002)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0xCTlg0OEhvYkU4TlBmM2FjcHlHc0lQVkhGb3p2YnZWdW5GdEttQXd6b2xW?=
 =?utf-8?B?UStRK2xJazBacFpVQkFiVEw0WnZrK2Eyckcwb1MyRUpwdlcyUERZUGt3Um42?=
 =?utf-8?B?TmhuRFVhMXIrWWZkRnljVHdNbTlvakdtYjd4eDg3K3h0VnNqWU4rT2xoTFkz?=
 =?utf-8?B?QXRjVWhlOHUzRk1vUkFLK2FHY3RxZzVWeEx0MXBWTWZLL3RXTU1nRUY2UDVy?=
 =?utf-8?B?SytuWXVBQU43SFdWaTl0SGpHMHVLQzFIcnYyL3ZtempQMTlScjdZK3QzSHRm?=
 =?utf-8?B?c0VocHI0b0d6MFBLMnhvUlovSlJWOWtvRStwL21rZlNRTjJ3VVgvRkZtalJu?=
 =?utf-8?B?Y0oyamJCSHJtdkZGQlREVUdVNkEzdHFZcnJRSWdsd1h6NTVwSmhEZjNCc20v?=
 =?utf-8?B?R2lmT2VyQm5lZjNCTkNML3hqZG1vcEZXTm5HdVRwcFlnZEwxMWYvdkRVQWFJ?=
 =?utf-8?B?azRneFdKV3FwbVRsdU5uSzRGemFvalh4dCtoK3BueVFZOHlIWWZLeUxKNE1m?=
 =?utf-8?B?Uks0WVJpVEwvSnlsSm5UNlpqSU1wTitsYU4ybS95VWJRZEFBamJnUWdsdDZy?=
 =?utf-8?B?NDlTbU5rTGxiYVdnc2QzTVI3NHFYc2dEeHZOOU1WczdNb2dmdXBOKzJsKy9n?=
 =?utf-8?B?THpjbDl4TFQvVW5sZEd6Qmordkp6eFR3bndRK3owTkIwcWQyQkZRT3BEYk12?=
 =?utf-8?B?d2kzNzVnY1hBTEFMR25ZV1lhNWlZZTg0TkxuSTJ5MkY5NFAzT3FTZzMvNnlK?=
 =?utf-8?B?eGo2V1NXM1dJRVZvaFlKK0N2UDdKOTcrOFBYb3NNbGJnclNNN2tmM1UxQU1C?=
 =?utf-8?B?L21PYlAyZm5xRW1DdERjdG1qdXlvUVhGaHRMU0hVRmdDNFdMWFM1bzRmZ1h0?=
 =?utf-8?B?NGVZRlZqTGNBNDZ1d1RtcXdxa2czUzFRRjEzT29IeGRyL2I0R1hzNFZ3aUVh?=
 =?utf-8?B?TWxYWG4yTzlSWWNQd2NpL1B4c0hnTXlEcWk4QXRYZzdQYVdBWmhHRnR4clVi?=
 =?utf-8?B?OEpvaWRUbWJwT0N5M0tkK2o1WHA5aTBrTzhvZVZFRDVUUjJWalRmd0JMeW5i?=
 =?utf-8?B?eFB0R0VYR1lHQ3ZYN09sSHFncThLalZjZG9XZ29vejZzbzNSS2dIRTFvSk5y?=
 =?utf-8?B?SFY5eXdYcHlQSVg1c0xPNkxRSWVCUlBrdWQxLzdhQVhyMXZLcDJXS0pwZHNW?=
 =?utf-8?B?UW1uNldWbXJlZkxldC9xRnAzN0lOeFhtRkovVWl6THFpUE5GSDB1SGlQTVRU?=
 =?utf-8?B?STVTOUkwNWdyeWZ3OG9FLzlpb0FuZmVZeFMrRjNEMG9GY21idTR6UkJvU3g3?=
 =?utf-8?B?WlVEamh1RFJWNEg2UDJ3YnN4QVN1Umgzd2g4YUI2VWJjVHlPTGJFa0RpeWx1?=
 =?utf-8?B?REt0NVhlejlpWkVNSjZJZXVZMlFnOGlhUUtOOWZOYlFJeSs1eHZ2bTNkRXBq?=
 =?utf-8?B?RFpsbXJ0dEk4cnBRSXE1WWV3SnNodnV4b1VuMmxCUUV0djhqWkVTRWZzeE1W?=
 =?utf-8?B?WDBGakpoc2VSa2NsSHg0VWI3OVFIUjM0dXdlbVI4aU96cDlvRTZjMjBuWElz?=
 =?utf-8?B?R1R5VkZJYm8zdURrVS8rekVmUklnN1VEL3VRQmNxNEVwVERqRmoxRXBGNFFL?=
 =?utf-8?B?ZFBzTnpNUDZUSXBtTC9ocWlLSFVPbldNWkpabk9IaFV6TFVQV2FCaHNyelM4?=
 =?utf-8?B?RkdzZStEdEdsbXdPS1lWT2grMFpOMXp1cExqckZIa095Tm1iYVJOd0hsU2JQ?=
 =?utf-8?B?UzYwRjhUZkczYVpkSUdGbys2bXYwSmxiNkhZTlFYTFQ3QllJZzhlSVRUYnU3?=
 =?utf-8?B?VUdZa2dwS2VpWGVsTmRWYU5ZM2czcDlCWmJDaFJrYUtKeGU4L2htM25nbmVW?=
 =?utf-8?B?Z0wwMm1ZTllZeWl2YkdLa0UvUlBMN3lQL2pNZkZnTjlleWxkby9pSHJyQkVM?=
 =?utf-8?B?VkxHRHVZU29kTmtGZjgvMlRoWVdoZUhjOC9KVVVJY0FYSTUxRk9WUzVZaDhq?=
 =?utf-8?B?dHdOTHcyWjNzUWtqYUNJZTJnbE1COU1OajhzdnRzUHBMRk9FcEpJNWNwUjNw?=
 =?utf-8?B?YUNZcWhUTUY0ZE11c05uMGwxKzFPY24ySGdVdWN3Ry8yM1ZqNExOUFphU1M4?=
 =?utf-8?B?OEt5NnVsME4zSkJ2N1U2YWs1dFZ0L1ArQ0hPZFg3djY3NWFLY2xFdml2RXlG?=
 =?utf-8?B?dU81RDY1WFZLMVZhdTZVajY2Vk4vNFcxLzZtWm5sQWRrMjlCNC9lQlBZd3l4?=
 =?utf-8?B?U1pVeXhvckNQQThac1JTSFFtcklnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea040348-266c-42ae-d565-08da0127fd04
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 17:20:48.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPciBL5K02uLelMoAuYonBA4wNKVtk5ZLxK84D12ESVtZKS642JrbKrTETgQ5wMUvZ5Xz9WMzbSSJJW1Suodh0hdR3evD43nsd7lXj/Jl2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3222
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080090
X-Proofpoint-ORIG-GUID: y9qDifxzbM0wBvxaz1zWIRXd2IsevSEn
X-Proofpoint-GUID: y9qDifxzbM0wBvxaz1zWIRXd2IsevSEn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 9:09 PM, Wenchao Hao wrote:
> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
> index ca724eed4f4d..7b4d998708e7 100644
> --- a/drivers/scsi/scsi_transport_iscsi.c
> +++ b/drivers/scsi/scsi_transport_iscsi.c
> @@ -2165,6 +2165,7 @@ static int iscsi_iter_destroy_conn_fn(struct device *dev, void *data)
>  {
>  	if (!iscsi_is_conn_dev(dev))
>  		return 0;
> +	iscsi_remove_conn(iscsi_dev_to_conn(dev));
>  	return iscsi_destroy_conn(iscsi_dev_to_conn(dev));

Just do:

iscsi_remove_conn
iscsi_put_conn
return 0;



>  }
>  
> @@ -2463,7 +2464,7 @@ int iscsi_destroy_conn(struct iscsi_cls_conn *conn)
>  
>  	transport_unregister_device(&conn->dev);
>  	ISCSI_DBG_TRANS_CONN(conn, "Completing conn destruction\n");
> -	device_unregister(&conn->dev);
> +	iscsi_free_conn(conn);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iscsi_destroy_conn);


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9CB4DCA1A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbiCQPgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235937AbiCQPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:36:23 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2FE1877D4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1647531304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ak7+Mb4/2OUTc99v/UPWVXrJeIedZsru4FwBXvrIXHY=;
        b=PLoKT7WinShVmAcYtDWA5e9+31zVnw/rm0bLxkf0/m493AL6CfhGZFIxQw4Q1AYlFMPbK8
        oLEtW5XNgxZNix9lieGFM+S8N5P7HH5EfiSkla/sajWoyxgdwC74VH+NVgAVxknun3JxSj
        8Iz71gUtA2CrzF9SI5XoCqB9kiYjlqk=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-mAx8KMb6Oxi4L72o6fiShg-1; Thu, 17 Mar 2022 16:35:03 +0100
X-MC-Unique: mAx8KMb6Oxi4L72o6fiShg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ep9gdM9nrGPK+zftLjqpv6h1q4M5k0Ag8AbVXYAsVvdoY0Lo05/TbJAn532e8y3jwpxJo7nEzt1bjwOwrzRYFJsQh/B+VgO+ORt9VXGlzybNQPCgJU6ksng5J4s4w6gSS37ezTx6kNJREshWr7+qzoWEnE6qMX0tf5vkdBAd+ekPR60apneKETxHb3mrbssL14Lt7qoK6zHc7RxpPgU0WyXMJskbeyAAdbdZDZR2Ak4acw7etky1faxxRQUrpWO5f8B2Ke+MEik6zwdJKSWS5iCwrR1JG0L2EuHcVNTPfMObRBs+HM4wX2g8kabOXBvGGhwFiBtUnOpqWVcsummV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak7+Mb4/2OUTc99v/UPWVXrJeIedZsru4FwBXvrIXHY=;
 b=Lu9+v7oAxvKRZ7ZS/QZ7twLUOm6LdZY67JACW2YhzEq5LHBodMdldTjeEeS6b7/b9VVCwtUdTKj+9UkbFBRa9h1qmmyVb2e4VORPhSWorGzw0epaHl43W7K/A4472u3ygAYCql/Yb/m25wVr59oUXu0Vf9kvGNFfzkYOPhPkv8rN7FQO0HAodVMotlQ5rFjDaWm6XhS/los6TcDeoX7mYL9IWIk2FsmQdIHdxMjugeIdhy9+NpNluI0q7xzEgBCIVJ/Kw373YsZED+6WwKk0oyFXdWumyRHNnnGZyZkxIp7w0c7zG4CAY4TPH2X0SLky8NbGNhSv1lWmg0ebeY+AgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com (2603:10a6:206:b::28)
 by AM0PR04MB4836.eurprd04.prod.outlook.com (2603:10a6:208:cd::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 17 Mar
 2022 15:35:01 +0000
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::14d7:55aa:6af:72d7]) by AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::14d7:55aa:6af:72d7%6]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 15:35:01 +0000
Message-ID: <bb6aefcf-92aa-ef41-27de-1e3e0b227761@suse.com>
Date:   Thu, 17 Mar 2022 08:34:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] scsi:libiscsi: remove unnecessary memset in
 iscsi_conn_setup
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>, Wu Bo <wubo40@huawei.com>,
        linfeilong@huawei.com
References: <20220317150116.194140-1-haowenchao@huawei.com>
From:   Lee Duncan <lduncan@suse.com>
In-Reply-To: <20220317150116.194140-1-haowenchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:20b:127::15) To AM5PR04MB3089.eurprd04.prod.outlook.com
 (2603:10a6:206:b::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b63c3ef-087e-4c2b-7e64-08da082bb339
X-MS-TrafficTypeDiagnostic: AM0PR04MB4836:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB4836D5B7A8F435B536473A7ADA129@AM0PR04MB4836.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqZ5e91ih7lHZZbYaAfjqW+8LTmiVd1bUg0bKWoucgT5OmnjEDSCnEk4ty3aEsyon5Inr3wSrjUiasSfOnns1vScppVrziXTcOHnVbUE5NEZSuU9/pWVAwPQG7sNSv3aYEpaGwJ8BzGuuHIUVmWCo+9DajFbMZIr7fbeHLpL+je6Poy4dzkpgvYTZFhHn3kFeGs9zjdpPHw2m3Ktzg/uS3i1HWWds4kovBbJjFB/IDdT1fVATxw+er6JoPsI2ZekdLT8jshmgcn3tPIQrH3v7BfO96TYM9ruXEl2ZGOrnzZ1pef2sXMR17F4VpvtI2VD0spirnDteGF/t8NRAfwsjZVZp9k0Ts5VoRCVAie9qcLHyi9uO1emTzFWz2c8ezHv1mP7gNEV9e954R1M+YuBxtzUEzfMUnAQqBArSn6jbsEuC+xFJ70Gjv8KaOBgtqdsZFGmomzxcqfkjBQUk8Yy9wv/9TJy0AjeLUZC5BJSJ04d0Ta1f06ozR5Ae2wti0+OaB7Mv8jAsnFPDrPcXiMmt3Yk5eQKhd0dN01p6eFzpdocYj4FR8o85YIhO6RnrvS1sckdK8fxs48GEBuyb9hio38xTCbs153647CVYb4tXKPgCjZaZJcB7SvTYOuawZQR+zwfTEbF7Ihck9EzMRI/VIRU7SjSdeYE4y5dtQ4X3ULAYGUmR22lxHxpjG8K4YGxIHsQi0sGsGLri/jZJieKnADX4G4mVP9CEDgoG0ARkDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(110136005)(2906002)(86362001)(508600001)(83380400001)(6486002)(31696002)(4744005)(31686004)(316002)(2616005)(5660300002)(7416002)(6666004)(6512007)(36756003)(6506007)(53546011)(66946007)(66556008)(66476007)(4326008)(8676002)(186003)(26005)(8936002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTVJdE9zY2g5b3ZCM05NK2hRRlErWUlaMTJCZTZkdTFZRzMxWk5ydjBOaTRs?=
 =?utf-8?B?a3NXRmc2VjJLVEF3a3BQa0ZrQ2RKdGIzZDBOeGJnVUN5cCtNYVFQL3c0b21R?=
 =?utf-8?B?TWhIMTI3dzVRUW0raVcwVnZ5NUpyQi96UEhuQXZMSW94d25GTUpMZWVVY2s0?=
 =?utf-8?B?S1lEeFZiSW14S2xCU0N5M2pqS21kNFdtbU1qdWNNOVdSK3ZjWG1hU3dFcWUr?=
 =?utf-8?B?ZnZRVUg4L2REenJVbTAvaWZoSE53c1FtN2ROVzNNNXZLeHNCbWJCQnVhVm52?=
 =?utf-8?B?MHpja3pUd2VXQlB1RWwvQmNoaUxHTDAxU1puK3hWSWlLSDY4M1I4K3hvOGp0?=
 =?utf-8?B?UXJZUS9yRzFnOVZ5YW1oQ1dYdHRIY2tWcjk1dkNZSkg4SFBXeTBGTjNrZnlN?=
 =?utf-8?B?ZVZzRmJJcGVScFVwUnl6eTNUek40VUlnbWUwc213NExLRDZ6S1p0azBiMDFB?=
 =?utf-8?B?c25BeFhHeldwcEY5dnErd1U2VkliQnBxRGhESDJ1QVlvYjlDMmdJRnNQVk5a?=
 =?utf-8?B?dzIwYncxNmNhYURLV2NsVmZiQW44OWdnVXEwdm9ia25TSGlNK245ZDNkK29k?=
 =?utf-8?B?Yk1KUTZvRS93TlVBTmMzOURzMWtBMTVLc2NXN0RzNkhzTmNzbStTVkI5L2xR?=
 =?utf-8?B?cjVlTFlCb01oUC9xam12ZStFTEFXYUxmM0hzYVJ0UHBWSzB0RXJraHdjMlBI?=
 =?utf-8?B?R1cxUnVNeVZoVFM4MU4zYXNnc1NpWlVzeDQxSDV4Q05jR0IxeUlwc0J4aEgv?=
 =?utf-8?B?eWVUWGV2dXZDMHl2OG5ydjdFUGRoOE5TMWJ6RElWVnlyVkJITFR6VGJTa3l5?=
 =?utf-8?B?ZUhYeGVGeit0UStkODlCSVNLYnBxRk90SUZtb3RwQVd3RDNIb2N5LzU0Ynhs?=
 =?utf-8?B?OFlCeUVwemNiNjkwVXFVL2ozSmppc3FSN3l6UEhsZ1lQYzhrdm1WZGgyZW04?=
 =?utf-8?B?RWxnajVFOEdNd0VRYWxtbE9HSUs1UGQxTGIwUUdEMi82WlZYT3EySWVHUm1t?=
 =?utf-8?B?TnZyRGN2a21ZcUZDazJsbWp4VFM1QUowR0c5N2lTaWNBVC9iTGxFb2w0ZlRo?=
 =?utf-8?B?THdCbmFlVUJKOHZCOTJyTWd1YitUbkpIYk5zQmtuV1RPdWc0SkZ6WTV0NS81?=
 =?utf-8?B?S1dVS1M3enFjSmE5b2dxV1BHb1lSYTY1MVZaNDVMMXE4dXhvZkhjY1d5MjdQ?=
 =?utf-8?B?WEhJYVFDQjZZUlVvTjNFb0VJbml3Q1JHSTRqTnlKVXdaRXFaZUN3WDN4Z0pT?=
 =?utf-8?B?NDZiVkxqWHZZRnl2UVQvUXluMGkvcDRJbWtVYm5Bdzl4d21MMDhweVZqcHg4?=
 =?utf-8?B?VG1GaGtkdklZOTkrdzFBcUo5ZlJGTGUyS1Axd1hldW02NjM5UEhoa3FlbnJY?=
 =?utf-8?B?c0J3QlpMbGVVU3FmVjQwS0h4NGdrY2ROZVoveEorWklRVVZkV2h1T0UvYTJ5?=
 =?utf-8?B?V3pLWUJhMjFEWDc3L2M0OE1QZFByRWVOYkllNkp4RGk3cFRLTlpOWXJLRVEv?=
 =?utf-8?B?aWY4UlJhRWY3ejdSMG5DV0cvdzZsWnFOcDRkWTFERW9CTEJpd0IrYm56NHkx?=
 =?utf-8?B?SWd1SUZnMDNpK2IwUDBRNSt1bHoxdDVzZnlQRHRtUFFRVExPSWtGa2p1K05t?=
 =?utf-8?B?cEVveko0ZldTWmRKRytKWm5tT01LRkVoaTNDaTdtWWI0ZExSRExWeUhBbVNW?=
 =?utf-8?B?cGFxU3l5d1R5QUxLZmlNNzVIUDFQZEdqWC9Rd2dxWk9takJYZkFuZVk0N0VX?=
 =?utf-8?B?VTNmT0xMa2xuMHg0OGZBa1RqQzlLam9yWUl2VzlWODY2NU55QkZqcGRUQUhr?=
 =?utf-8?B?d0FEbldnUnBxbmtJSU1nL0hLcUVHT2F0bEkzQnJWQTJMa2RlYmR0Q0VvemJI?=
 =?utf-8?B?RENUZk5HZWovSDI2cHI3Tk01UWRNT1J5SDNDZFRUK3Qwc3Nqc202N20rQnY4?=
 =?utf-8?Q?F6NHEDq1+lFCtjEF/3k8fKeF+5YVqS7w?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b63c3ef-087e-4c2b-7e64-08da082bb339
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 15:35:01.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuCjvS4ayw1MjAbPfVGCV785+dEMml65Q5TRW8h55e2MUOWjf50uq0IYkLV+rhX/zElwGSO0/U/arOiqi1XXMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4836
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 08:01, Wenchao Hao wrote:
> iscsi_cls_conn is alloced by kzalloc(), the whole iscsi_cls_conn is
> zero filled already including the dd_data. So it is unnecessary to
> call memset again.
> 
> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
> Reviewed-by: Wu Bo <wubo40@huawei.com>
> Reviewed-by: Lee Duncan <lduncan@suse.com>
> ---
>   drivers/scsi/libiscsi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
> index d09926e6c8a8..cf4211c6500d 100644
> --- a/drivers/scsi/libiscsi.c
> +++ b/drivers/scsi/libiscsi.c
> @@ -3045,7 +3045,6 @@ iscsi_conn_setup(struct iscsi_cls_session *cls_session, int dd_size,
>   	if (!cls_conn)
>   		return NULL;
>   	conn = cls_conn->dd_data;
> -	memset(conn, 0, sizeof(*conn) + dd_size);
>   
>   	conn->dd_data = cls_conn->dd_data + sizeof(*conn);
>   	conn->session = session;

Reviewed-by: Lee Duncan <lduncan@suse.com>


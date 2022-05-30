Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91F953863B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 18:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbiE3Qj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 12:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbiE3QjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:39:21 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E576A04F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1653928757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lo8rrvOFCtoWmbh4QQ7mgPpYWqpf7GRnNq5Zq0a8Sjo=;
        b=KOWUo80Tp2RQLgH/TbrAE/vBOuIyejNjD5C6TMwZ+ZsmrczazyZl7FwG9fBQdu6LAB1qNS
        9wljAqSHBKI9tzX2u4UO9YVUcGNxinI7qakgaKbUznpEqVIf8drszANliuwFJwK6prLhXS
        qywhpNuz9rI2+jEHDpeb/7PWlD1TMmA=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2054.outbound.protection.outlook.com [104.47.9.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-38-L5f0fecoM4213Lkw-XwzOw-1; Mon, 30 May 2022 18:39:16 +0200
X-MC-Unique: L5f0fecoM4213Lkw-XwzOw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REi6Ue1A3Jg+yQoIQNhDofte+REXafl+llUZgomQITiPFspFPdQ+B/QiS5GdLBax/BCwnP2lQu+W+yUhxe5Tx7NIrfTjm2cId/ZnOyby9AMpAtjf+EVmL6zAkJHqcWS5AqiKlJ85KYN7T0NS6Y++FpT0+gVrtbwoZ5gg9bUXkbaGWNqKjkIw6kEZEatppZ41pZxv8U3+R9sIcRFF712DECvgsYEZxO8hc85aalIrKdvSFcLSX7CXvOU6sQp44Zo9p+61fmm2fn67XjtpYT0pSTxjxyCSRjb22u3dZe9QaZcFGGQ0J66XCcLobl3xrB3wYWR8z/5kb++tpLl6c71oWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lo8rrvOFCtoWmbh4QQ7mgPpYWqpf7GRnNq5Zq0a8Sjo=;
 b=mkr3WEfPD1KBcE5hMoKZ+K+fXQl69RnucmqdPEgZfHi3JU/UA3CJxBZw4e6WDFh5l7CLa+VTBG+GpIvfPeQv2WSvAm8WbEbKS2xCkLA0zws1pGUJ3JWseQyCEPp/Ayw20UJKgDk4CW6ZIidhKG2TLF3Uz5PhNqA6qEhmjb9zD+CneAAOJF9T3oy6Fb/jwiWRPvOHlIA58v2x/12x8upehWr++PhqqblqSk6bjenI7oJivzL/spJoBQIj3gtDGj5DGxXh7qm5aaRFjgf511FiWnHPxLdFVBSficBcyKSMlHhbYK9jy9ziFQmlJxkoqg1Ob2c45wwPM2/XfeoelQyDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com (2603:10a6:206:b::28)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Mon, 30 May
 2022 16:39:15 +0000
Received: from AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::c49a:9069:bf85:6d47]) by AM5PR04MB3089.eurprd04.prod.outlook.com
 ([fe80::c49a:9069:bf85:6d47%7]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 16:39:15 +0000
Message-ID: <e49b3faa-cdac-3e57-4a7f-be2a899ec2af@suse.com>
Date:   Mon, 30 May 2022 09:39:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drivers: scsi: Directly use ida_alloc()/free()
Content-Language: en-US
To:     keliu <liuke94@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, cleech@redhat.com,
        michael.christie@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, open-iscsi@googlegroups.com
References: <20220527083049.2552526-1-liuke94@huawei.com>
From:   Lee Duncan <lduncan@suse.com>
In-Reply-To: <20220527083049.2552526-1-liuke94@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR0502CA0042.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::19) To AM5PR04MB3089.eurprd04.prod.outlook.com
 (2603:10a6:206:b::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9306a4b2-612b-488f-2e7c-08da425aeede
X-MS-TrafficTypeDiagnostic: AM7PR04MB7189:EE_
X-Microsoft-Antispam-PRVS: <AM7PR04MB718920CF01A93D8C9A12D850DADD9@AM7PR04MB7189.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LsbFcBT4Ne35KOa42oV+48nVeazDZ9lZ4Ylv5S3dY8kAzRI8aj73XJY30xs/eXqlWhoD1Yi9tYtL+qXZV+TAN2p17HskYpA67RWAI/AjI9Dcouf7sh6M13cRrVPtJP8DB3543jM+sREfap7A052Px2BrLAjBcnGaoB5wEaFgCHYQm+RxsXJgvUWsBFY/6QzdyjqjbCSie5XcwAJC4bpg23xfwQH3hm2EF+u9R077O5RA5UfgbL/ONE4XC5yc9BgJ/VKPe+BVg4AVLIg7Gtpc/Th/e1FsmdLlXvSO8RIF1K7OV8g84YmsmwSKX2SXIXsa7NNGEerPds72brXNmkHg5tt1qdEJkFMIK4vYaY2xleJsyTwOUBT3wz61gR8dqa6hlcawKZ6hIOCTEWF6Sb9HHwsZSvVrc9/NxDkndGZt0HthSxVRPETJclogWM89ZDceZnHmtMtkgHedVjS5TD+0PuHhsfCYr1Vd8DEcVNRHVG11zQ6ob6MnkxZ+ewNzsF7oBJKDD73/V6gR4CgFdb8Xx2pPXpsw5FheQxu0Z74LZ7DUz/PiW3w0geUqjMgkomqOCPyyrqzjUd5AjSFi1+UmK8YGcTZawgM3X/ZV4ht2RxVHug+3nCjI23OuzuhzSeU/5KJdMrJkvaCvtIu4yVDbnFLb1cCdb+If9+a0eTWW50ZNtTf6mVMGscEE3jZ6e2cmwT7PUVfBsiXeBSNkPUlP2wxyA1I7U6Ich/FnTHtQYd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3089.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(508600001)(66946007)(66476007)(66556008)(8676002)(6486002)(31696002)(186003)(86362001)(8936002)(83380400001)(26005)(6512007)(38100700002)(2616005)(6506007)(53546011)(6666004)(2906002)(31686004)(36756003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tzk5WUZFUWdlSmNad3VabHpJUWIrdWx4OEw5RCsyYTlEZTU2ZG9qTzlVSmdT?=
 =?utf-8?B?dHRhbXRic0s0WHIwRnhKQ0pSTFdwemxON2REZVFpZmtQNUtNSXhVR0g5dGJD?=
 =?utf-8?B?S2YvWWsvZmJNd0kzQTNBaE4yYWI1QVBHMTBmS0FCd2tlRk1iak82aWs0UnlH?=
 =?utf-8?B?QVdNdk15ZCtabndsRzBnRkpsaXBaUXZ1V3BOSElILy9mWFg5VzkrK1hsc3ow?=
 =?utf-8?B?OWdGUDdqdUFLOHVmTXkybmVaaDBjWW9hRXBLRE1lM1FIMkVUbjFtMGlQU2dX?=
 =?utf-8?B?WWRQdlA4OVJiM0ErRTN4ZWlKVTF2T1duUFkrUEI2OEw0ZVRkK2Y1Nk5hVEpx?=
 =?utf-8?B?Q1UwRkg1eTgxTWE5RG9mVVV6eTNueXAzcGtZUjFzMDErK3JkOEhzUE5rMExG?=
 =?utf-8?B?bGZXbHRHL0JNRFR4bFpDZjBLY2U0ZGRPaGpzMDd2cEpOWmpUSlk3U3JaVzhm?=
 =?utf-8?B?dm1TbXp5L2JQYzNPay9UU2RhSWcxNkZhWlNvT1hqbnlqNWdDaDU0UjhiSkJ6?=
 =?utf-8?B?TEMydnBtb0tjeWJRRWFMYTZ6REJXcU9jUVBiTjF2QW1jME92cTZiR1Radmtq?=
 =?utf-8?B?R0txbmZWbjN3dmY1RkE1ek42bmRBa1kyRFV6a21sTnk5RkkxTVZXRkNKMUVm?=
 =?utf-8?B?bXFtcUw2R0pRT1VHeTlrTHYvckd1b0RKZ2hiQjR5MmRlaFRmcEYxM2dyczJk?=
 =?utf-8?B?VXZXTVJ3akdzQVNkVEM1TFRRV2hZeEpsVmdlbGhEejVFYnE3R2Q5cmk5c1hZ?=
 =?utf-8?B?U3ZNTTdhb1JDek15N0dmSTEzL2dhb05jcTZwNlI2bm1SMFVGOVdzejlwV3da?=
 =?utf-8?B?MjBoa0UzeFFWakJtb1RONzliWTNYRDUweGNxSU9PZHpNRml4MkNyR25Kemlz?=
 =?utf-8?B?TlpURUN2SENxZHBZMnBzNmtKQk5jOVcwWjZ5cERQWVBNQXlaSHhveUVMZW10?=
 =?utf-8?B?UVBkT2lRSWY0QkZwOTFhTnNVVEthZkF0WUY1WVdNSjZTNnFZZE04dU5DVEYw?=
 =?utf-8?B?SWlibjh5cFpKZC9wT2ladTR1SjFMVTk4SW94d0phc3o4ZXI0Z2l2UVprSWtR?=
 =?utf-8?B?b2dDVXYxZk1MYlg5MlNRcUI2TU9RdW9pNkJMSldnQmxjVjVBTzBFdTFRZVVO?=
 =?utf-8?B?S3NRTkJ0MWVkRGJza3d3azllbmE5bERQcjlxQkx6ZWF3aTdQdDJ3Wkx6alhF?=
 =?utf-8?B?K2lsdW96ZlhFb3N3RDFBVTM4N3dUaGNkdHFmYjg2U3EvSWZ0K0FuUFlBclFN?=
 =?utf-8?B?YnBFdjFyeVhOLyt1cm16RmxCSGMwR1lvUmc0OGYzcHl3Wm12anBWdDlWU0JF?=
 =?utf-8?B?VS9lOHFMemxWSExJb2JrdllwTk1GV0dJT0M2ZllWVlBVUzdmRklDY2Y1cWtW?=
 =?utf-8?B?SnNPRFJ3ZmlIamdaL1dvSHRqOVpVRUpXeWpQMWNRMkUwWEVXTFJ5eFRnUERV?=
 =?utf-8?B?azRGazFZUUlZOVRDckdtaVVKQmNOc0ppcWJCT09vemZPZ09ZeUdwRTdseXZ0?=
 =?utf-8?B?TnQ5UzV3V1M3c3RPbVVOeFRUYWJsZ1Z0Z2g5K0tjYlNEMXYyL3Q3Q1hxUWhn?=
 =?utf-8?B?K2c2d1dTWklaTkZjWE9qOFhqb0YxaDJWcXF1bFAwNmZuNVR0cW1SdHJGdFRs?=
 =?utf-8?B?eDI0eTJPNnNiOFd3dU5lS2tHeUdIdDl2OVVZSXNxRkdTWHZrK1ZDeTE0eTBZ?=
 =?utf-8?B?NTV3cVhOSUR6TVhCeHQ3aU4yMnBsVU82cGQ3bXFXOHRmVlhrRXRtbiszWlp5?=
 =?utf-8?B?WlR3TXppTlV2Vk9ycVc3M3p0S3ZlZ3lPVHF6OVdSUGEyQjZlczgwNHNuQUUw?=
 =?utf-8?B?czR5d0VsNUxGcVlubXdlcWc1alZYb0kyZVZRczByMWVNS2loTlNoSWF2NzJu?=
 =?utf-8?B?TGNWREhZV0hJNndUN093ZmhVUWpyU0RoSWNEMlRhWTBIbk9ZVk91KzZicnlV?=
 =?utf-8?B?cW1Sd3N0MkZFdm1EVGUrQmpwUjJyeFQxV29CWEJDNmxnT2tZdWdPSUdEWEtl?=
 =?utf-8?B?YVpzSHRkYmI2SU9GUEpLR1RESzkrWDJVbGJWRnBjbkJBd3lIbk1QaWJQaE41?=
 =?utf-8?B?bGpFcU1qZUNJajRVNktyVmxSclVwcjN1OTQveXh5aVVLU1VDV2JLek5UNU9P?=
 =?utf-8?B?ZWhLVGZiWXdrMW9peUZLa1NHUUpCbGw2Qk1oUmdPaHZleWlLZ2JMMnNEWVBp?=
 =?utf-8?B?MmFXN3dleEJVVzBodjIxM2hiVVdIS1c0YzI3TGYzcENCem4yM2RsMXBBeE9j?=
 =?utf-8?B?TXIyd24vRHI2WTVvdUdDcEZsMjB1NGVkUzIwazZnVGhGdkJCVDV0ZDYwUnNV?=
 =?utf-8?B?bVAxZlBnb0RTd1hRdFpmaFp0amdpeVhmbmhMTmFrZjR1R0toSGp6dz09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9306a4b2-612b-488f-2e7c-08da425aeede
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3089.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 16:39:15.0718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZL+pQLwL69VYj5C9iwBsraSkYAHl1SjuZ6dPD+MbQlmJGNGX4VkCNCVPkZVogDytL0sGHrg7Jxd3FEugEdibw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/22 01:30, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>
> ---
>   drivers/scsi/hosts.c                | 4 ++--
>   drivers/scsi/scsi_transport_iscsi.c | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index f69b77cbf538..ec16cfad034e 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -350,7 +350,7 @@ static void scsi_host_dev_release(struct device *dev)
>   
>   	kfree(shost->shost_data);
>   
> -	ida_simple_remove(&host_index_ida, shost->host_no);
> +	ida_free(&host_index_ida, shost->host_no);
>   
>   	if (shost->shost_state != SHOST_CREATED)
>   		put_device(parent);
> @@ -395,7 +395,7 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>   	init_waitqueue_head(&shost->host_wait);
>   	mutex_init(&shost->scan_mutex);
>   
> -	index = ida_simple_get(&host_index_ida, 0, 0, GFP_KERNEL);
> +	index = ida_alloc(&host_index_ida, GFP_KERNEL);
>   	if (index < 0) {
>   		kfree(shost);
>   		return NULL;
> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
> index 2c0dd64159b0..2578db4c095d 100644
> --- a/drivers/scsi/scsi_transport_iscsi.c
> +++ b/drivers/scsi/scsi_transport_iscsi.c
> @@ -1975,7 +1975,7 @@ static void __iscsi_unbind_session(struct work_struct *work)
>   	scsi_remove_target(&session->dev);
>   
>   	if (session->ida_used)
> -		ida_simple_remove(&iscsi_sess_ida, target_id);
> +		ida_free(&iscsi_sess_ida, target_id);
>   
>   unbind_session_exit:
>   	iscsi_session_event(session, ISCSI_KEVENT_UNBIND_SESSION);
> @@ -2044,7 +2044,7 @@ int iscsi_add_session(struct iscsi_cls_session *session, unsigned int target_id)
>   		return -ENOMEM;
>   
>   	if (target_id == ISCSI_MAX_TARGET) {
> -		id = ida_simple_get(&iscsi_sess_ida, 0, 0, GFP_KERNEL);
> +		id = ida_alloc(&iscsi_sess_ida, GFP_KERNEL);
>   
>   		if (id < 0) {
>   			iscsi_cls_session_printk(KERN_ERR, session,
> @@ -2083,7 +2083,7 @@ int iscsi_add_session(struct iscsi_cls_session *session, unsigned int target_id)
>   	device_del(&session->dev);
>   release_ida:
>   	if (session->ida_used)
> -		ida_simple_remove(&iscsi_sess_ida, session->target_id);
> +		ida_free(&iscsi_sess_ida, session->target_id);
>   destroy_wq:
>   	destroy_workqueue(session->workq);
>   	return err;

Reviewed-by: Lee Duncan <lduncan@suse.com>


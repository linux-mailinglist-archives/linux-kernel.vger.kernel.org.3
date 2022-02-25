Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F3D4C4D88
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiBYSVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiBYSVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:21:48 -0500
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176661FED8A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:21:13 -0800 (PST)
Received: from 104.47.12.58_.trendmicro.com (unknown [172.21.175.6])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 1A67E1000047F;
        Fri, 25 Feb 2022 18:21:11 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1645813270.391000
X-TM-MAIL-UUID: 9044ac78-7047-4251-af1d-0a009ec90b49
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (unknown [104.47.12.58])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 5FB8410000E54;
        Fri, 25 Feb 2022 18:21:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6K1hya3e8HLqXkDfoefT9EEmZA16uKfehiVHAYOf8gH3pU3coJQN4wxG9176id3eZK/yyS0T/takFBSgI2MDED2TNmwSRNBmKDBeQnx+Y0fQ/s3N4uvnDAZWWG/ELKDUE6bt4Vn/eWwWTCuEu1AGrYKz8Kfv2wZnlNBCUZlE3OgW/JNOU+kA+ALTm8oHIuFzWBoi5alEBVFiQnNz4QrKahKgSMjcBd2GTirsDPPuJydBwlTSE8hPRevXO63+ovkEyrXcHim222NkYxlwXab+HuFgsZMIGP7HIDNP3okP/WxnAXGPYGGMQ35NBPUXGWE2YqMBoSD/c9QqSLeaZJM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtodeQfc/jEpGPHVq4yVtVILTKw8+yHpuhNabrRUCoI=;
 b=FgMMqJm6bgc42wpp8IwjZQti+suXnsA1Atqt1TH8sI/AWdkf1ybqcgmyhUrkOm2tyihWefD/Cz7bOVe3vgad7usiNsEpYCgyfACjEQGqa6iEsMnoLWGlT0KXR/WXFgk/TTgp3Rk3A19zC+HqlN0ad6Y3a6Bkxa5kw06vzJy7QqGp+YUvOwkreejLwsccQXD2QcLc/9O1SfUekTOOt0NIe0ZLOqIG5X91PsrC3uaRwRIYtSIVRC2CKIsh5hLtoZgkDDjmiTtmRfvnCTlk9SOLGHlcjK5weTvCxnDSGVrrqGxAcGOyvOEbz5f2eDpyz+PSTMkOLVbzrsUh088tEkk4/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <39955431-2d01-c932-03c7-eecf5265177e@opensynergy.com>
Date:   Fri, 25 Feb 2022 19:21:05 +0100
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20220217131234.50328-1-cristian.marussi@arm.com>
 <20220217131234.50328-2-cristian.marussi@arm.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v5 1/8] firmware: arm_scmi: Add a virtio channel refcount
In-Reply-To: <20220217131234.50328-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR0301CA0055.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::25) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a53cac3e-e277-4f88-eeaf-08d9f88b971b
X-MS-TrafficTypeDiagnostic: DB8PR04MB5707:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB5707756BCE90002713B09D788C3E9@DB8PR04MB5707.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewtbC+JdzfOCGXRbXSVqZteaqMyNUSgJI3rJ+yR5s3ive5vy5zt+Z3nyNNzEGSitMgw7z0GvXZ+viLDFYKBMluv7Q7QW8Km8Brsq/BL5lHNLrzSSY4pJDnL5n1BMTLrgUkmY1abkwP47nyLj4ML2u0i2yaqVLygBo4jgkHTOIOMEjgTPea6RlDqehXs+Csw3LyedR1uKQgZh5fSAq0uwZX8rTLg9lj9TBLRyYnSxibJsiv0zRhX8DvIoaTFqaFL7JAWNR8nBJ1YGx7fGwcV9aAUo+2YrgGqFNlZ5++PHEFFdmbLIEfe7PdYlElunauMgdnEodCWpfilvxLCVF9w4Btb1pSJlMvleItetF6aWxLt8Z2Ja5/W30633kE5nZx2qKU4yZ+Kw+p5U1gPN466Pl4wsDc1GLegVFCDlrNlChh5SFdy0NE4x2ntdCvM7IDq1BG2f4Op2x8W2suXjeD9B4pjVtH5qjlXVrhxl6gKV8twX6yk1Gghprme5xvroPfKG4pOzbuVnXX45E7CQTQkbucPk0HojjGtEvpCUjAl6TwGXaZGXHaRQb9ZZHEjEY73T5IDIDwB7P8h8mgd7i1l9fchR/sg7DXk9yFAbSvXOWhfgdM2iyhOqynGyzMkplDG6KpJrVPI3dvn3PKbSvLzdbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(31686004)(44832011)(5660300002)(83380400001)(316002)(36756003)(508600001)(42186006)(2616005)(186003)(53546011)(8676002)(38100700002)(2906002)(66946007)(66556008)(66476007)(31696002)(8936002)(7416002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlEyczBlWitCZmlqbys2b2MzUmVESDl0ZVV3Wk1sSDhHMkgzWExGTVQ0L0FZ?=
 =?utf-8?B?eDRNdnlGZEN1NlNDaG53emFVUnhQSFJRZis5dXgzK2ppZEtJN0VNdFNYcVZq?=
 =?utf-8?B?cDNidHdTRnBIR3hsYkRPZjhmL0ZTQmdYcUZYaTdqZG16cks3UjhzTmF0Z293?=
 =?utf-8?B?eWFDTzNQYVhxMmNsdE5vR3BPSzI1QnZnR1hKZ0xnTFZWWTQ4RDZaMUdmRUh0?=
 =?utf-8?B?b2NUaVh0eEl3TmppU09icHdKQis0QkM1alB4eURrajVOWEY4TGRVRGMrb0Fp?=
 =?utf-8?B?REhsKzZkZU9NaUdrQkZ6cDJmNjlFNzh1ckc3dnoyeFJObmtPdDJPQ3l2eWlE?=
 =?utf-8?B?ekNvcGJGbXNWS1lzallmSWpWYzNuTlhyelRVR0FKUklRVmlxK3l5eGxGc2o4?=
 =?utf-8?B?MUdML0dYVjlJZzVnMDdMTXl3NkJwUElEcWw1V2g5THpTbjRNVjlVMGEwYmE4?=
 =?utf-8?B?ZDkrNlpTcTRGbU9NNkZLMzRISzcrdmQ2ZVdNT2VRbklWTXozeWpuRXIwc1RV?=
 =?utf-8?B?czZKaUFGVnRmVnVKdCtkeVFpTjVOWHNXeXZsbFVkMHBTNVEzcVZWdTNCbWpM?=
 =?utf-8?B?WnM0REZnUDlnOWFqSll1RHMwTHQzamw2bjB1S0ZKWDdDUzlQeDF5NklkZ0Mz?=
 =?utf-8?B?cFB2aWE0MTU0UjBKNWVJZU9RTFpHV0RuTWV1TlNMSkM1WDMrSUFZaTgrcEg1?=
 =?utf-8?B?UlFudFNlSWhlMm9KSk1OallFaHJUQ3pjd1djV0s5VVdQRllvSmRjbHZwWHJo?=
 =?utf-8?B?WXNEWUcvMW94ZnRRWGlxck8rdHI3MDJ6alhnL1ZodGZXMnlEeTVnS1Jxdjcv?=
 =?utf-8?B?cEM5OWNWVnkra0U1K2VBOGFUV2NsUmxVdlkrWjZlS1VtMFN1TGlQallMOEgv?=
 =?utf-8?B?bjRWZ3pBV1J2VER2Rk85dGNCTi9ZdGREU0N5VWVRalhiQXlwZEVOUUlOKzVi?=
 =?utf-8?B?RUh3NTc3ejBJbUlnQzFKUVZJdGY2ekFHYUsvZHdRMUFueGJqanhHLzgrL216?=
 =?utf-8?B?VFRuRmZGNFIrVk9wRzVUS2ZBM2svSXhNQ3FzMFhxUnM1VE4xVnRsK083TzJt?=
 =?utf-8?B?dUpLSEtZWkxwaHJDSzdJc2w0R0wzMXNCMjlCSkl3Yks4UWR0dFlQUWtnVXNM?=
 =?utf-8?B?dXlVTmxEdWdhcUR5NkdNL0RSU0xBcXpwTEJ1aHc3SWhSUFBLN0pnMFVNZDZY?=
 =?utf-8?B?SnlqY2dLU0NwZHFsTUlVbTVwT3JjTGdVYmtzS3hTc01sbWI3MG1lQjV5c2dP?=
 =?utf-8?B?SGZreTJNRnYvcXM0RGM3SWRqQWNPVkhsNk9EZWhJeDJVRWVBNkxQK1FmbjJi?=
 =?utf-8?B?Tm9MbkV1SllSNy9XSVdTMkk2WlFuR2tMMGVkSU03c0szY1hVTVBOMXBMN3hm?=
 =?utf-8?B?cDYyeFJQNDdMUXJCam1qbjMyT2tLTDBvVUpSQUFKN1AxdmNrVnoydHdza0kr?=
 =?utf-8?B?ZWlkdXdId05IRW16aHdpajBIMkE3cHBXbXpaNTVuSURWWnJnY0RxVEVSVFBX?=
 =?utf-8?B?cjNsOHlrOHU4elZEaW5oNXRudmpDanV2Y3dlVnloaGFEUE5qL050emJ3bDd3?=
 =?utf-8?B?YURodHFPcUlPWXJudmVBaEgvMEFCZWE1OCs4Q2Vwdi9LZm16WjJZWklMV0hl?=
 =?utf-8?B?KzFpSFo2QU5WQlVTOUVIK2I2N3plTGc3RDJSUUFvMnRNb050a0ZMeVE2UXVk?=
 =?utf-8?B?dmRIZS91UmhERzVUU3FteGUyVnZYYVdGeEo5SGMzKzNXamd2VWMzclBzWXN6?=
 =?utf-8?B?bnB2Q1FWMTg3TGNjNVVCdndMdmFidHY3VkUwczdvcVN4bGpBL3EybkZTamNj?=
 =?utf-8?B?ZkpqRXFZdDdpR0lCVUlDODRMWWtRNWo3bWExUnVSbFJnMzcvL05zVFlGTDlE?=
 =?utf-8?B?UEx0ZExXUXhqazNUaE02ak50ak4zMHRWTnJ5dFBBZjlFeU1tRjlJTVhwZ09V?=
 =?utf-8?B?cTdESVlUL1FkWm9sZEdqUkZiTHhwRlFYQ3ZCQzQ5MFFkVnYrR2dONXJuUWVh?=
 =?utf-8?B?VHkrOTBLbHV4L2x6NUFRMnZ6d3JMeUFmODladVQ0cmg3OE41TGc4NTV2Qjcz?=
 =?utf-8?B?Nk5HWThtRGlUa2U4Z2w5YmlHQ3UwZS9qYXRRcTRKOGN5UG10aE1uYitnM2NX?=
 =?utf-8?B?NS9pcjF0Q2VEd0h2clBCQ0toTXBxYkYvNHRXSXRCYm5hUTg3SWpRLzIxOUdU?=
 =?utf-8?B?THNOMUJaYTNJMGNVZC9udDV0UFRKeS9wc0hKcWdSOWk2VW9SUHlYQkkrS0Nn?=
 =?utf-8?Q?Cc8wq/53vsJRPYYDku9MLUONsRbzQJ+Xh/c+7YZUCw=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53cac3e-e277-4f88-eeaf-08d9f88b971b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:21:07.2405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPHZW/iKIsnDg9ecp+FWQdCjEe04vioQmWZHFBZJX1+bbLbZRq7GeaAAiyVYRkmc7xjc4tzpQpswS5S21Y3lig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5707
X-TM-AS-ERS: 104.47.12.58-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26738.002
X-TMASE-Result: 10--5.529700-4.000000
X-TMASE-MatchedRID: gjZGo2H/wj//9O/B1c/Qy65i3jK3KDOoC/ExpXrHizyTsyhw1KPqkKKJ
        8yeXnfHAV620YhTcoiCy30IXTXvfRtIUKEcXjyBBR/j040fRFpK6G/3hYXpyaSt+gViu+UDkZ28
        gEzxS4tJ/jXwcoSRj3UdbuiZ3MdsdKjNqcTucdfhO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BC6k6
        Ky999wUE5KXWxauwqgP4ADLe03b+fzXojwcywrzM36paW7ZnFoYEpG2D2kcRrXFJ7W3lIp42zTR
        lDGU3Pz/t8GtPJsyDaf1JB9epETFkqyi4srEQAuIQrubkFPQdkgoSivyJYQQEYx760ONDcW3Ff7
        +xvoE8GXhTtgl0lKrTY21qAL0RG06B/jgOwSMZe/x8sBfQ/nQLTrV2IG143XkCszjODX6JLQk3h
        FSUm2ZqdHq3Rt1uM3TGg4ykZAAVhmdyCa5id7ahmCYUYerLHrKkd89GqHvUlULhp+W/a9mZjA2k
        GUhLCkasndy/28hYs7QajFbojNNZcFdomgH0lnOX/V8P8ail1ZDL1gLmoa/PoA9r2LThYYKrauX
        d3MZDUaA0E8UdrP6vAhVQMeX3mJfM0FelI66bKA64UdCEZ9HUVB7onZUGIH
X-TMASE-XGENCLOUD: 05bd0edb-ea2a-4d8e-90c0-cdeeeb213cea-0-0-200-0
X-TM-Deliver-Signature: F8AF89DC64E80F49349A396860086AAA
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1645813270;
        bh=UaxWS77BNVRPGjMmWHHubNnoNbmOd0rBlKV7WOG8dEo=; l=10325;
        h=Date:To:From;
        b=FTc6KVTkmH7JK8kLOKbQGZi40drjViZDHDyWuk5W6yUZancMR6RLUhmV2JtRy4Sf5
         FX8sDU3326zE5aDxvkxhKmGm/grC1eGvUI2IedCxeBtzko+rL935u8ActB8/YBbSo1
         KTb+Y0JBmPPK604XD/FAmmyYQ6a0gq9kPFKiYzKBBulaxcaKQh5IvcG+2eOiIytv4l
         ouxa5q66+fOSk6xl6HW9keLE61jYSu7EF4MQYeE1eAKhVUNLq0/L0YWnRbr4/G6gDo
         nlUgBVW3tYq4LGIMwAgtTdq3Sg7MgiRPixMuAuXPWL1HahtjregmnY4ThtZxNdzR6o
         g+JKtwkUm+OuQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.22 14:12, Cristian Marussi wrote:
> Currently SCMI VirtIO channels are marked with a ready flag and related
> lock to track channel lifetime and support proper synchronization at
> shutdown when virtqueues have to be stopped.
> 
> This leads to some extended spinlocked sections with IRQs off on the RX
> path to keep hold of the ready flag and does not scale well especially when
> SCMI VirtIO polling mode will be introduced.
> 
> Add an SCMI VirtIO channel dedicated refcount to track active users on both
> the TX and the RX path and properly enforce synchronization and cleanup at
> shutdown, inhibiting further usage of the channel once freed.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Acked-by: Peter Hilber <peter.hilber@opensynergy.com>

> ---
> v4 --> v5
> - removed unneeded virtqueue re-enable when fail to acquire channel in
>   complete_cb
> v2 --> v3
> - Break virtio device at shutdown while cleaning up SCMI channel
> ---
>  drivers/firmware/arm_scmi/virtio.c | 143 +++++++++++++++++++----------
>  1 file changed, 92 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> index fd0f6f91fc0b..ed00b072e981 100644
> --- a/drivers/firmware/arm_scmi/virtio.c
> +++ b/drivers/firmware/arm_scmi/virtio.c
> @@ -17,7 +17,9 @@
>   * virtqueue. Access to each virtqueue is protected by spinlocks.
>   */
>  
> +#include <linux/completion.h>
>  #include <linux/errno.h>
> +#include <linux/refcount.h>
>  #include <linux/slab.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_config.h>
> @@ -27,6 +29,7 @@
>  
>  #include "common.h"
>  
> +#define VIRTIO_MAX_RX_TIMEOUT_MS	60000
>  #define VIRTIO_SCMI_MAX_MSG_SIZE 128 /* Value may be increased. */
>  #define VIRTIO_SCMI_MAX_PDU_SIZE \
>  	(VIRTIO_SCMI_MAX_MSG_SIZE + SCMI_MSG_MAX_PROT_OVERHEAD)
> @@ -39,23 +42,21 @@
>   * @cinfo: SCMI Tx or Rx channel
>   * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
>   * @is_rx: Whether channel is an Rx channel
> - * @ready: Whether transport user is ready to hear about channel
>   * @max_msg: Maximum number of pending messages for this channel.
> - * @lock: Protects access to all members except ready.
> - * @ready_lock: Protects access to ready. If required, it must be taken before
> - *              lock.
> + * @lock: Protects access to all members except users.
> + * @shutdown_done: A reference to a completion used when freeing this channel.
> + * @users: A reference count to currently active users of this channel.
>   */
>  struct scmi_vio_channel {
>  	struct virtqueue *vqueue;
>  	struct scmi_chan_info *cinfo;
>  	struct list_head free_list;
>  	bool is_rx;
> -	bool ready;
>  	unsigned int max_msg;
> -	/* lock to protect access to all members except ready. */
> +	/* lock to protect access to all members except users. */
>  	spinlock_t lock;
> -	/* lock to rotects access to ready flag. */
> -	spinlock_t ready_lock;
> +	struct completion *shutdown_done;
> +	refcount_t users;
>  };
>  
>  /**
> @@ -76,6 +77,63 @@ struct scmi_vio_msg {
>  /* Only one SCMI VirtIO device can possibly exist */
>  static struct virtio_device *scmi_vdev;
>  
> +static void scmi_vio_channel_ready(struct scmi_vio_channel *vioch,
> +				   struct scmi_chan_info *cinfo)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vioch->lock, flags);
> +	cinfo->transport_info = vioch;
> +	/* Indirectly setting channel not available any more */
> +	vioch->cinfo = cinfo;
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +	refcount_set(&vioch->users, 1);
> +}
> +
> +static inline bool scmi_vio_channel_acquire(struct scmi_vio_channel *vioch)
> +{
> +	return refcount_inc_not_zero(&vioch->users);
> +}
> +
> +static inline void scmi_vio_channel_release(struct scmi_vio_channel *vioch)
> +{
> +	if (refcount_dec_and_test(&vioch->users)) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&vioch->lock, flags);
> +		if (vioch->shutdown_done) {
> +			vioch->cinfo = NULL;
> +			complete(vioch->shutdown_done);
> +		}
> +		spin_unlock_irqrestore(&vioch->lock, flags);
> +	}
> +}
> +
> +static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
> +{
> +	unsigned long flags;
> +	DECLARE_COMPLETION_ONSTACK(vioch_shutdown_done);
> +
> +	/*
> +	 * Prepare to wait for the last release if not already released
> +	 * or in progress.
> +	 */
> +	spin_lock_irqsave(&vioch->lock, flags);
> +	if (!vioch->cinfo || vioch->shutdown_done) {
> +		spin_unlock_irqrestore(&vioch->lock, flags);
> +		return;
> +	}
> +	vioch->shutdown_done = &vioch_shutdown_done;
> +	virtio_break_device(vioch->vqueue->vdev);
> +	spin_unlock_irqrestore(&vioch->lock, flags);
> +
> +	scmi_vio_channel_release(vioch);
> +
> +	/* Let any possibly concurrent RX path release the channel */
> +	wait_for_completion(vioch->shutdown_done);
> +}
> +
>  static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
>  {
>  	return virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
> @@ -119,7 +177,7 @@ static void scmi_finalize_message(struct scmi_vio_channel *vioch,
>  
>  static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  {
> -	unsigned long ready_flags;
> +	unsigned long flags;
>  	unsigned int length;
>  	struct scmi_vio_channel *vioch;
>  	struct scmi_vio_msg *msg;
> @@ -130,27 +188,24 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  	vioch = &((struct scmi_vio_channel *)vqueue->vdev->priv)[vqueue->index];
>  
>  	for (;;) {
> -		spin_lock_irqsave(&vioch->ready_lock, ready_flags);
> -
> -		if (!vioch->ready) {
> -			if (!cb_enabled)
> -				(void)virtqueue_enable_cb(vqueue);
> -			goto unlock_ready_out;
> -		}
> +		if (!scmi_vio_channel_acquire(vioch))
> +			return;
>  
> -		/* IRQs already disabled here no need to irqsave */
> -		spin_lock(&vioch->lock);
> +		spin_lock_irqsave(&vioch->lock, flags);
>  		if (cb_enabled) {
>  			virtqueue_disable_cb(vqueue);
>  			cb_enabled = false;
>  		}
>  		msg = virtqueue_get_buf(vqueue, &length);
>  		if (!msg) {
> -			if (virtqueue_enable_cb(vqueue))
> -				goto unlock_out;
> +			if (virtqueue_enable_cb(vqueue)) {
> +				spin_unlock_irqrestore(&vioch->lock, flags);
> +				scmi_vio_channel_release(vioch);
> +				return;
> +			}
>  			cb_enabled = true;
>  		}
> -		spin_unlock(&vioch->lock);
> +		spin_unlock_irqrestore(&vioch->lock, flags);
>  
>  		if (msg) {
>  			msg->rx_len = length;
> @@ -161,19 +216,14 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  		}
>  
>  		/*
> -		 * Release ready_lock and re-enable IRQs between loop iterations
> -		 * to allow virtio_chan_free() to possibly kick in and set the
> -		 * flag vioch->ready to false even in between processing of
> -		 * messages, so as to force outstanding messages to be ignored
> -		 * when system is shutting down.
> +		 * Release vio channel between loop iterations to allow
> +		 * virtio_chan_free() to eventually fully release it when
> +		 * shutting down; in such a case, any outstanding message will
> +		 * be ignored since this loop will bail out at the next
> +		 * iteration.
>  		 */
> -		spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
> +		scmi_vio_channel_release(vioch);
>  	}
> -
> -unlock_out:
> -	spin_unlock(&vioch->lock);
> -unlock_ready_out:
> -	spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
>  }
>  
>  static const char *const scmi_vio_vqueue_names[] = { "tx", "rx" };
> @@ -273,35 +323,20 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  		}
>  	}
>  
> -	spin_lock_irqsave(&vioch->lock, flags);
> -	cinfo->transport_info = vioch;
> -	/* Indirectly setting channel not available any more */
> -	vioch->cinfo = cinfo;
> -	spin_unlock_irqrestore(&vioch->lock, flags);
> -
> -	spin_lock_irqsave(&vioch->ready_lock, flags);
> -	vioch->ready = true;
> -	spin_unlock_irqrestore(&vioch->ready_lock, flags);
> +	scmi_vio_channel_ready(vioch, cinfo);
>  
>  	return 0;
>  }
>  
>  static int virtio_chan_free(int id, void *p, void *data)
>  {
> -	unsigned long flags;
>  	struct scmi_chan_info *cinfo = p;
>  	struct scmi_vio_channel *vioch = cinfo->transport_info;
>  
> -	spin_lock_irqsave(&vioch->ready_lock, flags);
> -	vioch->ready = false;
> -	spin_unlock_irqrestore(&vioch->ready_lock, flags);
> +	scmi_vio_channel_cleanup_sync(vioch);
>  
>  	scmi_free_channel(cinfo, data, id);
>  
> -	spin_lock_irqsave(&vioch->lock, flags);
> -	vioch->cinfo = NULL;
> -	spin_unlock_irqrestore(&vioch->lock, flags);
> -
>  	return 0;
>  }
>  
> @@ -316,10 +351,14 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  	int rc;
>  	struct scmi_vio_msg *msg;
>  
> +	if (!scmi_vio_channel_acquire(vioch))
> +		return -EINVAL;
> +
>  	spin_lock_irqsave(&vioch->lock, flags);
>  
>  	if (list_empty(&vioch->free_list)) {
>  		spin_unlock_irqrestore(&vioch->lock, flags);
> +		scmi_vio_channel_release(vioch);
>  		return -EBUSY;
>  	}
>  
> @@ -342,6 +381,8 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  
>  	spin_unlock_irqrestore(&vioch->lock, flags);
>  
> +	scmi_vio_channel_release(vioch);
> +
>  	return rc;
>  }
>  
> @@ -416,7 +457,6 @@ static int scmi_vio_probe(struct virtio_device *vdev)
>  		unsigned int sz;
>  
>  		spin_lock_init(&channels[i].lock);
> -		spin_lock_init(&channels[i].ready_lock);
>  		INIT_LIST_HEAD(&channels[i].free_list);
>  		channels[i].vqueue = vqs[i];
>  
> @@ -503,7 +543,8 @@ const struct scmi_desc scmi_virtio_desc = {
>  	.transport_init = virtio_scmi_init,
>  	.transport_exit = virtio_scmi_exit,
>  	.ops = &scmi_virtio_ops,
> -	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
> +	/* for non-realtime virtio devices */
> +	.max_rx_timeout_ms = VIRTIO_MAX_RX_TIMEOUT_MS,
>  	.max_msg = 0, /* overridden by virtio_get_max_msg() */
>  	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
>  };


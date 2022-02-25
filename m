Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B53D4C3FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbiBYIW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiBYIWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:22:55 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E96B180D24;
        Fri, 25 Feb 2022 00:22:21 -0800 (PST)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21P8MB2c027885;
        Fri, 25 Feb 2022 00:22:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=oyw83SQzou6boFo+6ZGJE/nfDZJzA/Kj+SoMo6jCm5k=;
 b=e7+fVdqUGlH1HnPWm2jWxCLs2mem8zWoD88sVIV6iTI2dMt4+xAFms/fwXAdvg81T/vy
 Dutxa9VAITTmQ1CH09ReZtFZQcWN08mYSKIlJVIFnDHVchsXgE3tMHKrppFbJZmEjYOE
 vJT9kkSZDwRyXFxperiybUig3K1TARK3bEYI9GR9WyOIn39WiRUli3BJGWvtrXnIbj9S
 Kr5QzMFD9PFfZ/axThuaHxWH6hv0ndNSef+KKKO80plyKf7O4MQ3tsM4EsNUz/Q71Eun
 oLKIrujTaXAcALcBcNTSIDd0IunePiRiR2PXwM6eQvojDgxe19PPFz8nDvQVMTUwoLRF vA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3eej5b0crd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 00:22:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFvXV68yJjHQjqg9kxxVnXC0inxRY7TMPsIfKRGtj06Hz5cua/qmEFXsl8fv5is/JgkmPn1AmA+qzbgvjXdJC7oq8Oq4jfs4gb/q4DATkPh3bHb2+5t4crfT06tTlRn8ZjGTwxYUXh+r0VNblNQoOmZWixEoqPXaW5r+mxPS7/pLOlw7YnvadaBjMlIMYvWtq0VX5nD8H/E716PY7w1sh+3yhKbfcDzbB1IYT7iYLc09UyeBvFQva8hgWqZugzNZs/qYG1F1WOwg3rPV3v+Kn+YHsY+uGV98N/W/gTKQ3WgHxF1jZIe5PWeKf5wc8dVfZTjUWEee07k4saozS925Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyw83SQzou6boFo+6ZGJE/nfDZJzA/Kj+SoMo6jCm5k=;
 b=Z1XBVnoIQ23JGy8bsia7Ad7nLJ3JcLAJhAfgG1d2WlNrnNDo1ydVqYkrb4N5lWZjDyCKgIE/xITNSCpbPrBLzjOf7VAkpRFhdUPidYpg8Mj6M0uKxsaYFQHSuNCIm7fGLR2Pz7so6ut+YN+o9T/PVcQlayomulSvEapsCwXgC6CySxGUQvYyBkXToOvTQpqGtPYWfqMvgL3gsFtDEXXcddBNYOuwIDhfVzFzWcVmUsUZaRZUtPe27qVb2h6GtBjSEuQ+WWQIjKenF6cF6NglYmoAhrhEo0op9BobQVqbizj4gEIFjJFWgXoflFEGIe3unRFdgUTVKTKK991PaSzwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB3008.namprd11.prod.outlook.com (2603:10b6:805:cf::18)
 by DM6PR11MB4361.namprd11.prod.outlook.com (2603:10b6:5:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 08:22:08 +0000
Received: from SN6PR11MB3008.namprd11.prod.outlook.com
 ([fe80::d8f7:376f:d7ee:cfb3]) by SN6PR11MB3008.namprd11.prod.outlook.com
 ([fe80::d8f7:376f:d7ee:cfb3%5]) with mapi id 15.20.5017.024; Fri, 25 Feb 2022
 08:22:08 +0000
Subject: Re: [v2][PATCH] spi: use specific last_cs instead of last_cs_enable
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ying.xue@windriver.com, richard.danter@windriver.com
References: <20220217141234.72737-1-yun.zhou@windriver.com>
From:   Yun Zhou <yun.zhou@windriver.com>
Message-ID: <4d621283-2a48-35ec-2131-1471a6b94c51@windriver.com>
Date:   Fri, 25 Feb 2022 16:22:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220217141234.72737-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To SN6PR11MB3008.namprd11.prod.outlook.com
 (2603:10b6:805:cf::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df42cee6-3c2c-444c-2001-08d9f837ea06
X-MS-TrafficTypeDiagnostic: DM6PR11MB4361:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB4361CE33F12FF718119C3CBB9F3E9@DM6PR11MB4361.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T0OklDwLgfcjWgJoiXyI9iyeP6iy73YY2cXC8FpzDKXj3AgrlqeOQubJqn8aC34bIP3+tiPf6gki7UZ62Qshxtidupax74u6SpLFKXsCal+OBTkx2jTuiIQpX7DzldqHcy3PbMKg0YSYU4z6O4f9ok2Z2nGofOnGQmEXL0MjGETUVUm5MbCU8bopOp8wneIxlt1G+U76Y+HeW6gzWFppyTNKwB9RcsAUfA+OF/8IVPbkyrxwX/xM+6WSxfDuBYNUM3pzhabhnD4LVne+6jhXWy1/StF6SO884daCGMaYE0UZ67rOQCJEdk+MUj9BpCJIbS/S4qR9sFTJuEKS0yS3gnFj1KPCmIVDBUwY+RMFRFD4cARfVWfRq0+mKS08Tpp5+HrNd03a2HR4SlQH9qe8EoOFNKK7TbEb4W5XqNfv4Dq6KSSU0rTs5Nt+M5yUoj+QoGQWaUKnzMfRHnDaIsC1tsdT1MVbAOtphPVFm80PZdz55VVJosYp9+Wf4sNCRqdYWKPtYjLcOLWINlUJZhnvnJrhVjmmMSfYNwL1ggauzsQcDsDTJpGkRrJ7RHu6KCzhEKQMizr/DB73Zu+qU+fEpYRgWrrTc0+7p8mdl73DzUye1h1x6v69QQNkI1PNXNOmt12JmBhMMDmo8fG/YRyfMjBIuWO0aYikCnaL/qtLYB9DFvGSnRWxZpvhg3MZ0Q+/LobvuMS6312w5XIzWlTJo4834b7vQo+bCnGWRj8ZA1TKDo2Rz7izWA6nDoBzKjpIDdw4CSikQXltnkMpKyEevw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3008.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(508600001)(44832011)(36756003)(6486002)(5660300002)(38100700002)(86362001)(316002)(8936002)(6916009)(31686004)(2616005)(66476007)(66556008)(8676002)(66946007)(4326008)(107886003)(83380400001)(6512007)(6666004)(186003)(6506007)(2906002)(53546011)(31696002)(26005)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUY0dERybW55ZzErNTRBd1ZwaXhPU2UwdUU2eE9SM0dUdmthaG1kTHk2UHBW?=
 =?utf-8?B?bVRIRjZHTmt2ektMYjBSZzZPS0U5UU1jRFV4Z3VZWWc2cC9YWWQ1T0tLVlVH?=
 =?utf-8?B?ZWZwTzhZYVl4Lzl4aHE2VTZHOWRnNi9ILzJGbEE5TmFIYzVpUUhiRlVBeVV5?=
 =?utf-8?B?TWVPNTVnN2IvZ0tjWGQ0OVBkbS9zNkFiOWFSb0xNMmFjSUU3VVRlaXQ2ZHYx?=
 =?utf-8?B?OHppZjZIcytMd2VoWUJMVkZ1U3VxSmNGUnNnYVdKNW1qQ1BxRTRFbGdTKzU1?=
 =?utf-8?B?eEJIekdoOEE5bkFZdTBJd0xEMWZhMEF0ajRZRVg5MlJQcmp1empmUWZhalBO?=
 =?utf-8?B?WGJRWkQ0T2VvVFJOc0JMSkd4ZWFGMUt2TnlZNm9lRlUzckd1ZEhCZHVmcGpu?=
 =?utf-8?B?WEdxSVJ6RHdISlZUK0I4Q29VQ2FuUnFIRjVGakZySUFLNXJHUFM0U0Z1K2Y1?=
 =?utf-8?B?ZzJ4VGJQZ3dVVWhzbWxtWVZkbVFmVTJuS3AvRkVrWUNnOGpSYS9lTmdUM1ZM?=
 =?utf-8?B?S1Z6T0Y4b2xjR1YwV3N5UHlJdFNkbUNMMkpYZ1VOWFBZNVZxR25Ca2kyd0Jm?=
 =?utf-8?B?LzhVeDFsQzJXekdIUWNFbmUvd1I3WE9zYnlRMXhqeVdGczVkSlRPMWxZdXdv?=
 =?utf-8?B?a3pRRGIrZkpxbVVkL1V1WmxubXpNdFc1cks4eDRldTVVUmpmcEdnV1pUb2lH?=
 =?utf-8?B?eGhHRTkvNGtMQVRQd3dCZXUrd2czQ1ZaNlgrdEZKeEQxd3Z1YndXUFV2VmJW?=
 =?utf-8?B?eVdNdnZHWkJ1L29YUlprTW9LckkvOVI0REJYUzVrenpJWWJuRHY0Y2RlV0t6?=
 =?utf-8?B?MWpQK0JuOFNuZmtKK0JUd2RKaE1ncjFUQS94cGV1RzFWK0x3R1NDeFNqQThi?=
 =?utf-8?B?N2tIREZyV3NOYjlEcHVQTkFGTEc2Q3hYeTRDU3AzTEFqLzNkTTVTWVo3MVBq?=
 =?utf-8?B?b05weHBKSGlKV3htVDdqSHRmV3N1eHZnaGV0cXdFcTZmdGNTRk0yVUt6R2R4?=
 =?utf-8?B?TEhUOEM4dEpUWTU1MjY5VTdPWnpkSnpBT21wcitEcnljaTFjbHJSR0dTeUQy?=
 =?utf-8?B?dEQwZGFESUVEZzNWT2EvUllBWkVqRk9OSDZzRGxPNXFpNktHKzh3Zkg5U0ha?=
 =?utf-8?B?UU1HU0lzb1R1N3VyNGFOYlNVWXVlN250d2xkNEorM3dKRWkweWJQeTJFU0Vz?=
 =?utf-8?B?citJUFk5R1BoSXZ4b2NITVBzbVhiL1VrQ0V4WlZZKy9hcWszYUxJZVRCZytp?=
 =?utf-8?B?MG9OZVl2b1RoSWhMcUo4OTNPYnNLV3pSS0I4czFpUEk4UG1DUmdtVTBpWGYx?=
 =?utf-8?B?VHlWcmY4WG1DSnZ5ZjVGUXlQWElQNHdPQmlTSlJLbFcwbTRpMDQyTUNGUjVa?=
 =?utf-8?B?RmRIdkpDU211TkJDRDIxN1JaTUNEZWI0TlBsazFvWENaMkFYMUlra2x5K0Zx?=
 =?utf-8?B?a3ZkTFpyT0s1WFluaEZFYXl1MVgwMTB0d0VtdDlHaWJaMFRwdFlyeGlYNW9H?=
 =?utf-8?B?ei9CTkdIM201Q3hlekllL1RhcWdPTWgrdDJXY3k1a0VxUTdqNnFhN3lrVmgz?=
 =?utf-8?B?aEhjVzBJcEhKUFFGcTVKRGhoQ3pKTjA3WGRIbk1PTm1XTzZST000bWp3WVg0?=
 =?utf-8?B?bFJSUi92YWd2YzZ6Ym0raUc5YTVZb0VmR3JNV3Z5b3FqZG9HemNUL21ucE4x?=
 =?utf-8?B?OHFhV3FOL1hxenNiMUhpaW54Qjg3dy9MUFVta1JrY0kvc3pUNmc4YXJ6RUti?=
 =?utf-8?B?bWdOZ1VlMEprbVVkYjhmN2QweXVMUmpQbXV6aVVBa3lwcWlUMDc1YmRZSDli?=
 =?utf-8?B?UW5FcktXZEFxSUZWOVhJTTh5SGtBamhocS8zYUp1blNDTmV4dTg2eUJGNWJQ?=
 =?utf-8?B?SDkvdXVKT1VDRThWK0o3aUpvazVBak5jaGRhY0Q1bUZ6RWsvdEk3VWdRYW83?=
 =?utf-8?B?MVJYZjFveW9ZYWs4bGFQejVlNXpMMDZ4WFgzNGt2eVF4SXlnVEpBVEFnY1pC?=
 =?utf-8?B?U1J1cjlnNmRlUDR5dW1wSjFzdEVMcEd4MWx0WVlrYWlrMEM3S0ZUdDc3ZkNW?=
 =?utf-8?B?YmdMV0x3UERaem8yL3FLK0llSWNkYlZaYktqSEc3ZWVJKzYwSGY1YmNZR1Bh?=
 =?utf-8?B?YVRORFJIb1NZaFFHTFV4NlNqNXNXbjFJNlAydU1saHY2Um9OZUxETlVJblkv?=
 =?utf-8?Q?/zL+s9xnPKZnFCp1kG77Azo=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df42cee6-3c2c-444c-2001-08d9f837ea06
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:22:08.6076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2mdW3elB7m/yE5+uw/twfs8Azx8UudYBTbPzlDjYDqhYNe8b7f0CvrCqVwYTa+g6L4CiRytMfI3z53lkPSFXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4361
X-Proofpoint-ORIG-GUID: mFXhmDjPHisi9v37vTg5uHPR3r_Qa2OB
X-Proofpoint-GUID: mFXhmDjPHisi9v37vTg5uHPR3r_Qa2OB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_06,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=870 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202250042
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Do you have any comments on the new patch? It just fixes the
regression introduced by d40f0b6f2e21, and it no longer affect cs_change.

Regards,
Yun
On 2/17/22 10:12 PM, Yun Zhou wrote:
> Commit d40f0b6f2e21 instroduced last_cs_enable to avoid setting
> chipselect if it's not necessary, but it also introduces a bug. The
> chipselect may not be set correctly on multi-device SPI busses. The
> reason is that we can't judge the chipselect by bool last_cs_enable,
> since chipselect may be modified after other devices were accessed.
> 
> So we should record the specific state of chipselect in case of
> confusion.
> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>   drivers/spi/spi.c       | 8 ++++++--
>   include/linux/spi/spi.h | 5 +++--
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 4599b121d744..d054229ffdda 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -936,13 +936,14 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>   	 * Avoid calling into the driver (or doing delays) if the chip select
>   	 * isn't actually changing from the last time this was called.
>   	 */
> -	if (!force && (spi->controller->last_cs_enable == enable) &&
> +	if (!force && ((enable && spi->controller->last_cs == spi->chip_select) ||
> +				(!enable && spi->controller->last_cs != spi->chip_select)) &&
>   	    (spi->controller->last_cs_mode_high == (spi->mode & SPI_CS_HIGH)))
>   		return;
>   
>   	trace_spi_set_cs(spi, activate);
>   
> -	spi->controller->last_cs_enable = enable;
> +	spi->controller->last_cs = enable ? spi->chip_select : -1;
>   	spi->controller->last_cs_mode_high = spi->mode & SPI_CS_HIGH;
>   
>   	if ((spi->cs_gpiod || gpio_is_valid(spi->cs_gpio) ||
> @@ -2980,6 +2981,9 @@ int spi_register_controller(struct spi_controller *ctlr)
>   		goto free_bus_id;
>   	}
>   
> +	/* setting last_cs to -1 means no chip selected */
> +	ctlr->last_cs = -1;
> +
>   	status = device_add(&ctlr->dev);
>   	if (status < 0)
>   		goto free_bus_id;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 7ab3fed7b804..5a54ea354053 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -373,7 +373,8 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>    * @cur_msg_prepared: spi_prepare_message was called for the currently
>    *                    in-flight message
>    * @cur_msg_mapped: message has been mapped for DMA
> - * @last_cs_enable: was enable true on the last call to set_cs.
> + * @last_cs: the last chip_select that is recorded by set_cs, -1 on non chip
> + *           selected
>    * @last_cs_mode_high: was (mode & SPI_CS_HIGH) true on the last call to set_cs.
>    * @xfer_completion: used by core transfer_one_message()
>    * @busy: message pump is busy
> @@ -611,7 +612,7 @@ struct spi_controller {
>   	bool				auto_runtime_pm;
>   	bool                            cur_msg_prepared;
>   	bool				cur_msg_mapped;
> -	bool				last_cs_enable;
> +	char				last_cs;
>   	bool				last_cs_mode_high;
>   	bool                            fallback;
>   	struct completion               xfer_completion;
> 

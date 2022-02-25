Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F2F4C4D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiBYSVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiBYSVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:21:49 -0500
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610901F83F1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:21:16 -0800 (PST)
Received: from 104.47.12.51_.trendmicro.com (unknown [172.21.175.6])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 0841C10000623;
        Fri, 25 Feb 2022 18:21:15 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1645813274.552000
X-TM-MAIL-UUID: 3dc8e72d-8f19-49d8-8be8-910a536e1b10
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (unknown [104.47.12.51])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 86FB210005E1E;
        Fri, 25 Feb 2022 18:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3ALP7sW57c/VYGayrhuxlKk7NNS+f/4yGi5fXkeJhastC9VhX7EMgai8ccIyXapAmb8E0A5dqtL3tOLwthovy476/68sv55w9e7ejuujHOAzPBgZ1EP/FNUc0QtNVhXPBLqmnBJ1iE6esB2g1fDSWFl23FST7fE7C95v2nnuuprFInOehyNFRewCcDDOLgWhcskNF7zFXhlxJsEIhgy08O2EXbNESUL0kPbklSGMLddqq3aYpOXMmH2TvLrZYPtx4heQDEKcJ8G+62XknbWkqj+WmkMCBasMKpezDusD/ePr7eLhXDxp9LisPw8DFYuR1YEfQJbryHBAO/EjjmITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxsuvT1lcZvZ+WJa7evzWaOA+2MfmivBOr6fNVlfH4o=;
 b=bNY+G/FUKM6u1B3r4nXijiuqG+tzicZSb41ZWW+I8POPV7e6ncK4h5r4Ou5ItW6OGnlAY/MxFRQp8miXXJaKcS/0zvdqz6O1x4FDRbiWpCJUirn4xKQEslN49Xcx8C1fqZBFsMyVtPO28s5Z0FIoMw/ntnPKih57M2AQc7/Z1YygjPJhfdMjpr+ce8EMe1KL4ux8AKygKVp/+fFBFpCVkqVPwiIw5VeBoWnX8MRroaAD+eHSXErPgF3V99iTrJKDPVPC9oKYlUYdyBqNEqsidR98agrZeFUeRWpNL0+lJtK3qA1yKTNgMYSJAe2wmgUrQ9wBEkjZhArv1GclOMYQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <4381ad02-6b4a-a826-1768-ff541663331c@opensynergy.com>
Date:   Fri, 25 Feb 2022 19:21:12 +0100
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
 <20220217131234.50328-3-cristian.marussi@arm.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v5 2/8] firmware: arm_scmi: Review virtio free_list
 handling
In-Reply-To: <20220217131234.50328-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR0301CA0047.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::27) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84a307fc-9c75-4cc2-9e9e-08d9f88b9af2
X-MS-TrafficTypeDiagnostic: DB8PR04MB5707:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB57074A9FB5BF58E3EB70E66F8C3E9@DB8PR04MB5707.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9zlMZb+Ou3l1wYU1uLI4Bjv2wshwo61yYgIIYVmju2Bd38Wf6/wX/MVF6z4tXiR1I+2H3I059v8mR2r4rdL8CHUIfVg7KaSBYo6azukHT/Gm2CHlaVxL+mVwaCIZEVf41a5Wr4B7xXARsFqO+UzC4rstC7xybS0E4qyqhzSbyiW+mI99CPfg5irQbrzO35D8DRbHxw22vXqBYIuYqJ5bNxmF3ZBIzrK6X7Sdoq65nlpbvVDxNuJ2nhwzxBFzuZg3h7gjdhXRzOtNHcpwJOtaEJjDl2LArsV7luaODa17ViNbMkYier+bU/zVfJ7MJ4IGjKbl7RAP+esbFRp/ZDZ0+7U1Ho9m5ofmmKtZD4z2F6ZsezAp68Q5gFsz6jbPtUt3yLAvv2RqplwbBt0X6lXBnJxQSwxiaXyD/2NSdPVUqyNUoRkOSdz+Xg8pPm0fSVO5UJOPu/yzOUT1Nj22DM7auN0Va1dcpJ4lreZYzALKvoMEKcDRJPz8tlvn+KriuV5viCC2uZ3anoQyNWz/sldLWmUI/emVH8GOkHqRuGB2ehk/7GirSICVzKEZM414RsC0jd20/to/aWDKDhBmVl8tsxcoV5pjK8uSSmK8LeIJV7ulycm2bNcrEmkIUYeK3XftSjp8oNAdoZbytEaDAGopw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(31686004)(44832011)(5660300002)(83380400001)(316002)(36756003)(508600001)(42186006)(2616005)(186003)(53546011)(8676002)(38100700002)(2906002)(66946007)(66556008)(66476007)(31696002)(8936002)(7416002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0RKR2RwM0NmYlowZ244bFowNHN2WHAvdEZCbURSaWpoME9tN1g3cm8vcElY?=
 =?utf-8?B?bzREcHltM2J2Q0pubGROVWRNbnNkczJpd0Z1NmhyZExwbFBuaGg0RHdrKzcv?=
 =?utf-8?B?cnFuZWg3bEJQMjBzVWNvY2V1UnFKV1lmWEppNnpidDFNdFBtT1RiZmxEL1VO?=
 =?utf-8?B?TDdOUmNPUlgrS09WNnBjdG5qa3lRZEt0WmFVZHRYY2x6NGNMd0tXdXBXQ2JR?=
 =?utf-8?B?R2J4cHNXOG9XNTV3dGxsblQ0QXg1aVVuTFprc1hnek5CcDhEemZROC81ajNX?=
 =?utf-8?B?Ry94OUNwbktLN1RXOHE4NG8zREl2SGRWbWh5b2dKZlBuVjRRODBqekJBdzRj?=
 =?utf-8?B?UjV5MzAra1RJVGhnVUVCVDhGeFIrQUNCZE0vOWU0dk96dy9DcDlNVWpBUkJm?=
 =?utf-8?B?NFgyTmlNMkRCK1pBMDVrdTgyckxtRU83L09HN2dxbmpsOVVCZHl5TFZmdGRU?=
 =?utf-8?B?UXc0V1luM1c4S09TY1ZoQnBVS2VrQjJhY3VYT1c3eHA1U2tOMFkxSldyMEFY?=
 =?utf-8?B?SDBXSUQrcWpOSHVwVVhrbUZsWUVpdVVDTzFDN2NHUjZkaUJFVjJOakxLUkFx?=
 =?utf-8?B?WFdJZmVhYmFvdzVnK0VTQVNkVjlUR0I2VjFPa3o2Z0FPUzBCbDFCNEc2SWdi?=
 =?utf-8?B?MlRtU0tDckxFS3RxWGY5b0NrR3hUZzdYdEZ0dEJGNW9YMVFpRkgwUE1kZzFx?=
 =?utf-8?B?eVJkci9GUjVWSGY3UExBUmpwRTBsRk5UYlBESnRvZWNWUjg2aSs4bDIyYzZu?=
 =?utf-8?B?S0JUZ1Joa3JVVEJ6QVZyeVFRWTBsMml5eVBicDRZRENvZlMwSTJ0ZGx0M2Z6?=
 =?utf-8?B?TWhRMVZCbGFBYWJCNWdsN0VJOFZhWVVNQnFGRTNjRG5FMURaRTE0VnBXVzVN?=
 =?utf-8?B?VlRjQlBHL0pwbU9ub3NJVHhodG4wd3R3cy9mTjVPRnFMeFhtenNkWTQ5MDBY?=
 =?utf-8?B?eTVYK0RucmU1VENtYjNXSXpST21pMVRSb25jZzJTSTB1UlBlNzRmSmkxaHR1?=
 =?utf-8?B?cWxySmtsblJBK1dLSDZOTUlickdOdGJLS3VqMVBzM2tIZGpZRGpobzBHVWMv?=
 =?utf-8?B?cjJIdkpOK254d1FwZTVVdTZZUnRPcDRRSHR3cUYzUkpxc256STNPV29CUjRL?=
 =?utf-8?B?bGRlWmdkMlBoVzNDMDY2V1k3amNjTU00QUlVQVV1T21jbnoyWVZUdXNPM0d4?=
 =?utf-8?B?Ujd5aUQ5eThpdVViYnZkMTBzc1h5OWdZVXN4WGRoNE1GYmdyY1NKcGFycDBW?=
 =?utf-8?B?OTlHMGFWNEZnTkM3eWlrREZvUGVQa0Vuc0VJVzFxMmhWVDdMeVVHci9QL1Z4?=
 =?utf-8?B?a1AyZllraUlqSU43dG9WdC94SGFzQ3dJSFhROVNSSXYxZ05OSmEwQlR4VFZm?=
 =?utf-8?B?Tk9CalQySmRCRmN4bGZ5Q2xZSnI2T2tCNVk4MnZraFY1S0JNcSsxYlh3alZL?=
 =?utf-8?B?V1o2blh5SzA5YXY2dkFTellNZVA3d2V0S1BsVUtHbmJKL3lGWmh0blVTYzFu?=
 =?utf-8?B?V2tOMGlhdTNRUmZ1ek51ZlRQM05VL0lDMHhBbVhWUHdETEZveFVEN1VaVHNp?=
 =?utf-8?B?dUFDK2laOHRJdC9tT2lqYWlxLzFucTQzQ3ZVRXdSQUxSN2xQSmpwbzR2Mmpl?=
 =?utf-8?B?MmM1SS95MzROU01jdkthb1BnTkxsTVprQk1SWTEwQXQ3VmorbHlQQ1pNdEp2?=
 =?utf-8?B?VWlmOHNpc0J1UmxIa2ZOL2tnRHFqczdEZHhRL2x1NkQ2cGEzNWZ2TWl0UGtF?=
 =?utf-8?B?djduTWVzQUNxV0NGL011ZG5xQUY5ZDZlQzJBNVo2Z2h3VC9Sc3d5Zjk0cnND?=
 =?utf-8?B?RUpwblVxeTB5RWMyK2NwMFRwTzFLM0pCQy9VaGI4TCtBN1pCTnBpOHBKc1Iw?=
 =?utf-8?B?NnJCK09qNVBJdVR1UGo0TDBoVmZEdW42RjJnSERLbkoyWUhqUVFnWlZOdEcw?=
 =?utf-8?B?S2ljbzF6SHRJZ3NRNEMwYnFwaG1acDY1Vlo5SEhpZXNMTEx2Sy8rN0ExRVFB?=
 =?utf-8?B?YnRsT0JzMFBTejBqODliaHRZUlpZNWd1NG1Iei9wMFg4aGlUWTNVUXlrVHUv?=
 =?utf-8?B?Q3JwNE5mYVpjU2xicG13SGZBV1FacW8xcGRzRklIcnZuL3ZWOHlyUkxEeVhE?=
 =?utf-8?B?S2RZL2VuZS8vTHN5OUN2SGdwbEpDU1ZmcFh6WHQ0dGIydFdtS2JYekhRRkd5?=
 =?utf-8?B?cFFtektSWEdnazdDR1NRcmV1dWxkMHV2NDArOFZIV3RTMW13OG83MkQ4NWhw?=
 =?utf-8?Q?wQ/8NvucbQdd2dzkuRR+gSoNRFc4z19ZG+iDMIRATg=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a307fc-9c75-4cc2-9e9e-08d9f88b9af2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 18:21:13.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2I/VLWq4x2vlBLq8WmqD+v6RWDwzK3PtjI9hIxpNedX+VxECRMZz1Ej6OTBc1vlilkWjnlUiKCO/WRTHPzzM9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5707
X-TM-AS-ERS: 104.47.12.51-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26738.002
X-TMASE-Result: 10--12.268100-4.000000
X-TMASE-MatchedRID: vbSD0OnL8/LDbVDIym9Ieq5i3jK3KDOoC/ExpXrHizzk6Qbi+9i6Dzlq
        WSxu1gNPsZNKmFb43eUh3CJBYZ8abHpdccKwlVHWTuctSpiuWyUUi4Ehat0549VTZaI6TuNocdQ
        cKpNhse3IH0qLJqarAJQWkZcTz2syyV682/wvVhwdZEkR8Y/mecEXY503qgABLX4eLEVMoPr6gA
        3qopxFX+edtM6V90qEkzIu3KN831Y/u57zb+n3uhFbgtHjUWLy0bdjqKOoG3eb7QqAvqLTusi+U
        JljoDHwgcDogF3e9Cw68m5m6HwB1UDek9Bnh47Ts/Hes76OTZAKW68eInZ/hTYspit1Dw9nFjSU
        6JSOTdAMf7Ce+LIFdlQMkg6i1g2RPOqr6B64RIDOvXpg7ONnXVIUfO2TUQOJ6Z2vNpIov1yjxYy
        RBa/qJQPTK4qtAgwIAYt5KiTiutkLbigRnpKlKSPzRlrdFGDwZPoBfoSl/JP8IJXtHoU6nIL3vo
        pE/CZh1paMTUOpVnzgswuYDNQTfw==
X-TMASE-XGENCLOUD: 1cb375c5-8ac1-4493-b8cd-209ac66db016-0-0-200-0
X-TM-Deliver-Signature: 9F44EFE936DCB424730A7515AE7D95B6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1645813274;
        bh=19H+2BbbvEai+j4Zhd7+Qrbjx3QNln+lgVRj6zkk1cI=; l=6862;
        h=Date:To:From;
        b=kFYIJ9ofbtPsxhhYGPiFckrZyMyFslFZWlEzoRgUDsrikvfDDeiK2CXbB6+8PL/Dp
         V/+PhYjdmDz9PvckVdhsraMAqXVf3qSC/zX3crTNubxCTSbCZ33XYjOms04Sg+KycT
         GNck0E7/5XJQ2F0lBaW5Dgm7W9JEIdn3g7uzwZ0614iyGQFQE2OS6ixVk4qPlQf1dw
         /oadTxyrUKa1mjrITKow+cy+s/lS5jxbg3E+E7TZGAejdgWgXBTTJiFtdJgQJDtZt9
         piHyBx2dS5144eV+3f4qnBG3M8CDkTrq13Z/Y2k4Uyi+YBt1T5BI++C3iweQ3ylhQp
         GhvfBaJVLnewA==
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
> Add a new spinlock dedicated to the access of the TX free list and a couple
> of helpers to get and put messages back and forth from the free_list.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Skalkin <igor.skalkin@opensynergy.com>
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Acked-by: Peter Hilber <peter.hilber@opensynergy.com>

> ---
>  drivers/firmware/arm_scmi/virtio.c | 88 +++++++++++++++++++-----------
>  1 file changed, 57 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> index ed00b072e981..7ec4085cee7e 100644
> --- a/drivers/firmware/arm_scmi/virtio.c
> +++ b/drivers/firmware/arm_scmi/virtio.c
> @@ -40,20 +40,23 @@
>   *
>   * @vqueue: Associated virtqueue
>   * @cinfo: SCMI Tx or Rx channel
> + * @free_lock: Protects access to the @free_list.
>   * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
>   * @is_rx: Whether channel is an Rx channel
>   * @max_msg: Maximum number of pending messages for this channel.
> - * @lock: Protects access to all members except users.
> + * @lock: Protects access to all members except users, free_list.
>   * @shutdown_done: A reference to a completion used when freeing this channel.
>   * @users: A reference count to currently active users of this channel.
>   */
>  struct scmi_vio_channel {
>  	struct virtqueue *vqueue;
>  	struct scmi_chan_info *cinfo;
> +	/* lock to protect access to the free list. */
> +	spinlock_t free_lock;
>  	struct list_head free_list;
>  	bool is_rx;
>  	unsigned int max_msg;
> -	/* lock to protect access to all members except users. */
> +	/* lock to protect access to all members except users, free_list  */
>  	spinlock_t lock;
>  	struct completion *shutdown_done;
>  	refcount_t users;
> @@ -134,18 +137,49 @@ static void scmi_vio_channel_cleanup_sync(struct scmi_vio_channel *vioch)
>  	wait_for_completion(vioch->shutdown_done);
>  }
>  
> +/* Assumes to be called with vio channel acquired already */
> +static struct scmi_vio_msg *
> +scmi_virtio_get_free_msg(struct scmi_vio_channel *vioch)
> +{
> +	unsigned long flags;
> +	struct scmi_vio_msg *msg;
> +
> +	spin_lock_irqsave(&vioch->free_lock, flags);
> +	if (list_empty(&vioch->free_list)) {
> +		spin_unlock_irqrestore(&vioch->free_lock, flags);
> +		return NULL;
> +	}
> +
> +	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
> +	list_del_init(&msg->list);
> +	spin_unlock_irqrestore(&vioch->free_lock, flags);
> +
> +	return msg;
> +}
> +
> +/* Assumes to be called with vio channel acquired already */
> +static void scmi_virtio_put_free_msg(struct scmi_vio_channel *vioch,
> +				     struct scmi_vio_msg *msg)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vioch->free_lock, flags);
> +	list_add_tail(&msg->list, &vioch->free_list);
> +	spin_unlock_irqrestore(&vioch->free_lock, flags);
> +}
> +
>  static bool scmi_vio_have_vq_rx(struct virtio_device *vdev)
>  {
>  	return virtio_has_feature(vdev, VIRTIO_SCMI_F_P2A_CHANNELS);
>  }
>  
>  static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
> -			       struct scmi_vio_msg *msg,
> -			       struct device *dev)
> +			       struct scmi_vio_msg *msg)
>  {
>  	struct scatterlist sg_in;
>  	int rc;
>  	unsigned long flags;
> +	struct device *dev = &vioch->vqueue->vdev->dev;
>  
>  	sg_init_one(&sg_in, msg->input, VIRTIO_SCMI_MAX_PDU_SIZE);
>  
> @@ -162,17 +196,17 @@ static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
>  	return rc;
>  }
>  
> +/*
> + * Assume to be called with channel already acquired or not ready at all;
> + * vioch->lock MUST NOT have been already acquired.
> + */
>  static void scmi_finalize_message(struct scmi_vio_channel *vioch,
>  				  struct scmi_vio_msg *msg)
>  {
> -	if (vioch->is_rx) {
> -		scmi_vio_feed_vq_rx(vioch, msg, vioch->cinfo->dev);
> -	} else {
> -		/* Here IRQs are assumed to be already disabled by the caller */
> -		spin_lock(&vioch->lock);
> -		list_add(&msg->list, &vioch->free_list);
> -		spin_unlock(&vioch->lock);
> -	}
> +	if (vioch->is_rx)
> +		scmi_vio_feed_vq_rx(vioch, msg);
> +	else
> +		scmi_virtio_put_free_msg(vioch, msg);
>  }
>  
>  static void scmi_vio_complete_cb(struct virtqueue *vqueue)
> @@ -284,7 +318,6 @@ static bool virtio_chan_available(struct device *dev, int idx)
>  static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  			     bool tx)
>  {
> -	unsigned long flags;
>  	struct scmi_vio_channel *vioch;
>  	int index = tx ? VIRTIO_SCMI_VQ_TX : VIRTIO_SCMI_VQ_RX;
>  	int i;
> @@ -314,13 +347,7 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>  		if (!msg->input)
>  			return -ENOMEM;
>  
> -		if (tx) {
> -			spin_lock_irqsave(&vioch->lock, flags);
> -			list_add_tail(&msg->list, &vioch->free_list);
> -			spin_unlock_irqrestore(&vioch->lock, flags);
> -		} else {
> -			scmi_vio_feed_vq_rx(vioch, msg, cinfo->dev);
> -		}
> +		scmi_finalize_message(vioch, msg);
>  	}
>  
>  	scmi_vio_channel_ready(vioch, cinfo);
> @@ -354,33 +381,31 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  	if (!scmi_vio_channel_acquire(vioch))
>  		return -EINVAL;
>  
> -	spin_lock_irqsave(&vioch->lock, flags);
> -
> -	if (list_empty(&vioch->free_list)) {
> -		spin_unlock_irqrestore(&vioch->lock, flags);
> +	msg = scmi_virtio_get_free_msg(vioch);
> +	if (!msg) {
>  		scmi_vio_channel_release(vioch);
>  		return -EBUSY;
>  	}
>  
> -	msg = list_first_entry(&vioch->free_list, typeof(*msg), list);
> -	list_del(&msg->list);
> -
>  	msg_tx_prepare(msg->request, xfer);
>  
>  	sg_init_one(&sg_out, msg->request, msg_command_size(xfer));
>  	sg_init_one(&sg_in, msg->input, msg_response_size(xfer));
>  
> +	spin_lock_irqsave(&vioch->lock, flags);
> +
>  	rc = virtqueue_add_sgs(vioch->vqueue, sgs, 1, 1, msg, GFP_ATOMIC);
> -	if (rc) {
> -		list_add(&msg->list, &vioch->free_list);
> +	if (rc)
>  		dev_err(vioch->cinfo->dev,
>  			"failed to add to TX virtqueue (%d)\n", rc);
> -	} else {
> +	else
>  		virtqueue_kick(vioch->vqueue);
> -	}
>  
>  	spin_unlock_irqrestore(&vioch->lock, flags);
>  
> +	if (rc)
> +		scmi_virtio_put_free_msg(vioch, msg);
> +
>  	scmi_vio_channel_release(vioch);
>  
>  	return rc;
> @@ -457,6 +482,7 @@ static int scmi_vio_probe(struct virtio_device *vdev)
>  		unsigned int sz;
>  
>  		spin_lock_init(&channels[i].lock);
> +		spin_lock_init(&channels[i].free_lock);
>  		INIT_LIST_HEAD(&channels[i].free_list);
>  		channels[i].vqueue = vqs[i];
>  


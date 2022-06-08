Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43655543975
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343720AbiFHQu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbiFHQuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:50:02 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4121BAF33D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:49:59 -0700 (PDT)
Received: from 104.47.5.55_.trendmicro.com (unknown [172.21.163.172])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 371691000045D;
        Wed,  8 Jun 2022 16:49:57 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1654706996.550000
X-TM-MAIL-UUID: 0a79bb37-d001-427d-81f6-fa382e625a5b
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (unknown [104.47.5.55])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 865D7100024F5;
        Wed,  8 Jun 2022 16:49:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3MZGZTlh4hqTeK+quolpjOhKKJA+d7fT3QUUisEYTTyaVT7eRQS1+nXE4ya212X1IQI1ET2xWIlNZh4AZeVzREGseEKOO6dUYHdRehWeFuRYfs/lXKxjbX1WdRxgD4Y9DWZAwv+ZN1rxAN+nKZe8OwtC+9mPlO9trQi+7U7zdQlAbKGb7IQBFN05l2NVFV9fVakfIJhpH6aCtBN3ud/4VEmxq7pmiEa6wVaoNlU5cO8gwByHjuAZtb4H/yX67tVe5ZnlmnmMFltZHOxApKik78NPoS/I0msdN1QU2VgwhDcuyo8wqSeZJC9JYQufuiiCn03M5nU37FJjxHpI6wbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6ziHTLDkY8j76NgQYiU2wICG3YdEYqcXarJr2dCHaU=;
 b=XQb6APcNjiSzhecEim9ek6V9vDjPnNqTxavfACuDmxHn5d81odbdKpgrKBMhVGvQKEQHn91/sbh0IJb2Nn9TT8Np78a9KkuT7ED4C4/btNIEgbKph7xkErCpHOHl1Bv3ryVhHFfdGgsCfHZoHLHueY1pLZ4bJ4Vg7ORWLf6P3eQQTS/wrEoMBy0pbeBQOAkVns8osizUBn2Ub+RVI4sACIAIvVcSRvqebFohg4UPYPOnHCaM+c20eJw7t2V7Ot5dz3+du8OxwcL5fOY6cpNgb3cPUSNwTBFa0P7/88rmAx06vcJYHnWK72kJV2nZn9zz05qyjSKk6dVEddTQEgVwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <1720e1a8-8bfb-ff9c-a81c-a9af41da3fa9@opensynergy.com>
Date:   Wed, 8 Jun 2022 18:49:53 +0200
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com
References: <20220608095530.497879-2-cristian.marussi@arm.com>
 <20220608164051.2326087-1-cristian.marussi@arm.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v2 2/3] firmware: arm_scmi: Fix SENSOR_AXIS_NAME_GET
 behaviour when unsupported
In-Reply-To: <20220608164051.2326087-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0071.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::39) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc91f5dd-5061-4e85-f2e5-08da496ee9c5
X-MS-TrafficTypeDiagnostic: AS8PR04MB8452:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8452E7DB0398688FC2CA93B18CA49@AS8PR04MB8452.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qkPQDuZgxVKbCBMdAwM3tZ4CEVc/WxTmsHIyTm34uq4pBYwcRclbP4qfz7Q/HU6ASQIVO27mklHEY2wL6EqirRWsVLWvyK/89OaxbIj6NS5qlAC35C52VCj2lbJDtZmG2fEAtifzsu5XS0uZHGAKIk2WaTOeUpxfwyY5OnX7ilYPESyeAuajnV9vrDAQ+WtUcM5y/K8640yRomDLvxiNgt8Z59h9slHRU5SVksHyfKwz/CYBm+xzP8ONnntJMSjaS1aCqu3/nDyQVL2BPCovMBDJGYtBTKSXplHUo0Mge3azZD03h0tfjunK/zKkAxZS3U/09+zlsdjPb2yqq3qft+pOzbQ/JTur6OzHIjA6dsmo/DbQo6GA4jfsQl8bCPWTfdr5y2RuuWeHzp/Nu1/FoBvE3vAyr4KaryvgSfDwz3wveDL5l3amWP/ZIc19bedtG19NdPvo2d9bUsQPG0axfZ9fxDiYmlbbYSe15OzrOe2mpowahg8w4FLWY5UfSQmgLrT8dagtjxKCscxjTqCGpYDBphSrzuDTMAOvjJrHt50942YyM4m5POSBUemPdaOruiqoVreuBpKp/hnZRuBV2hWamfxHgwRRUjijXRF8QcHw/A1VttcRGSBR6t9z9q2Oxvq7jj5uAerKy746sBOniw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(38100700002)(8676002)(66556008)(53546011)(66476007)(5660300002)(4326008)(31696002)(2906002)(66946007)(44832011)(8936002)(508600001)(316002)(42186006)(86362001)(31686004)(186003)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnI5K2ErSWpjeWNnZ0FVQkhnNXN3L0NLaGFwOXdoL0NBUmJQcnNjdFIxRUlM?=
 =?utf-8?B?UFJzbUk5MmpPYjRycXhGU3lEeGpqcnlHQnlxTXk3WUJkazRxMXkvNUFKbFFu?=
 =?utf-8?B?SmJqd1UrLzFYUnZOZUx1SXJMemozUFlXMnowWndkczNOdUdaT1ozU2tvMHc2?=
 =?utf-8?B?ZlR4WnZmcUd5dnJpV3JkYkZGaWZBQnp0M0lobGJMeGdNN3BxZ0lHUDJYSFpl?=
 =?utf-8?B?YXVWN01Jcm5CYk45VEsyVlJsK1hBVDIvY29iQkgwZEtGTE5jMlZTUWNKTFVl?=
 =?utf-8?B?eGREalFlTlpUb0psUjZRUUp4Z051VUFxYzlaS29icWR4aWhRQlVyaEtoTERN?=
 =?utf-8?B?eE5XR0VVcWNUbmZRMzhNSlh4NGVUWlBYaTZkVFFCYzIwOEczUFN0MkRLRE9I?=
 =?utf-8?B?bmN4WEUxYVdoV1d1TWxtbnpEYWpDbjRXOUtPME5FNHUwSHFiSWt6YzVZMzhu?=
 =?utf-8?B?aGNOUkE2dTgzaHBacDhBZDJTbXB5bEJMNnVGN216Q0RUMHU4Q3BDTWZZVlNT?=
 =?utf-8?B?Wk9zd09MWGFUTTVLVWx5NndVYmtQVTJ2OTA0MzBoRk1GYzlZZ01xa3IxODIr?=
 =?utf-8?B?dFBTcWZtNGJpYlVkTEQzdlJuL3RxeTNMekJsOTZ4UW5kKzRhbnNSbFBCemk4?=
 =?utf-8?B?ZXhXTWUyc2JyZ0tKbHM1Wm9UeGNhV2hWUEdKY0ttUU5MQkNadHgzT3htbmJq?=
 =?utf-8?B?L2VSR3Z2a3dyWC9jUEhoUDk3cFhsRzVycWFNNWVUNVA2U09aTVJrV3ZlWmFI?=
 =?utf-8?B?c3p6dWtOc0VDWmN0MEVncTZwK1AyTVg5bGtuNnRvcmxrbDZMdk96Ums0eFVU?=
 =?utf-8?B?QXB1dlIycTcyN2R1M0xrMGgwOTdUQ21PMHFYc2FXZ2s3aDlxTC9yVWYvZTZX?=
 =?utf-8?B?N0JUVHYyOVJHbWpJaEs5Q1crUXJMN0YyUjE5VEw3MXlzby9wWDRRc3JBNkhK?=
 =?utf-8?B?SGpWcjk1RStnNTBCS2hYT0x6SWhBWGY5bStveUpmTWdlaTl4UVpaeDhJT0Nm?=
 =?utf-8?B?ZFhxdVJ0TWFHVkNWeTZpdVErMzdTaW44TnR3eGlDVGRRM295WDNRQ0pQeWxp?=
 =?utf-8?B?eGt3S1V4R1N0MTllR2xERS9vOFFqR3RBRUY4TEYwWHIvaXFpOWZrYWd4Q21w?=
 =?utf-8?B?QUZXa0trMlJmcE9pdHFqc1lCeXJRL2I3WEVLRjFJQldkOUFsWk1VVzZLdG1Z?=
 =?utf-8?B?Z1JUS0tmMERreFUreEJsV0VrRDlZWVdFYjRpZTVLTG1vUTBFQTFxYm9JZWZo?=
 =?utf-8?B?ZHpsVXhEeG8wWkZ2dFpLeTN0RVJ0RGJvUHpLNVpSMGptUlNxVVV6VlM5VXR6?=
 =?utf-8?B?OWF0emJTQ2R4RkdwOXV4RHNoSXVsa3MrMXZzVklaOWE4RE14L2pjVHZtZlQr?=
 =?utf-8?B?Y1h5U0FCMUlrci9JWVJOR0FaZFA5M1htQ0JSVThVMHlIeWpVeVdXL2xNQUFk?=
 =?utf-8?B?dGc4Y0tQQ2lIUFhuSjkzTUQyaFVsRzJ4SVI4QXBRd2dmcGhwS1drTUhaamg1?=
 =?utf-8?B?ajFRMDFic0ZIRlB1dTYweDhacE8zUEMxTS9hcERucklmaW51MWRHMXJEajJI?=
 =?utf-8?B?dGtVT2c1a0JoM2Q1R2tTcHhNWGlJdjZ3T1JPSExlb3VVMjBHMzA3ZFNQdFph?=
 =?utf-8?B?dFFib2p3WjdERmFjVUV1MEw4ZFFmWHdUbDYweFBiTkp3OXk5bXpTdWd1RFdh?=
 =?utf-8?B?V0NURlZIQlVhZGlMQVU4RUphQWx5dlQ3dXovRmtFZHhseldOc1N6SU5Nb3Vv?=
 =?utf-8?B?YWdrbGJMODU0WHNURzZ5Y01VbFNVYndlY2N2cWc4VVZMYVhMeEQ1NzRzbnYy?=
 =?utf-8?B?U2ZVS0loUEtkOXBXdE1HM2pSSy9RcW5tcy9mdUZNNDBDaDducDh6UWdSdm0r?=
 =?utf-8?B?MEFCbmpzNFFEeXBnTUdzd1N5MEp4WFF3NzFFaC9IUVFKYlhSZC9MYXhySFc0?=
 =?utf-8?B?ZzZybk9FaFlXL2lrVEE2S0pzRUh2YnQxcTVKM2dtVUpNdFhrWW9oWFBOUGUv?=
 =?utf-8?B?N3gwNTU5VnlGcUdyNGluQlIyUUhJNWZWOWFGVDBrR1RZYWY2QTlQcXhzeGxR?=
 =?utf-8?B?OTU1TElRVlFOT2xSZHBTa0RJZGd3MVltVTgyK0QwVy8yZUxqRExrUzBZT1Ru?=
 =?utf-8?B?TXhpSXZpMWZhWEdacTY1dWpyV0k1TC9kRlFOR0VSSmFxaW40WjdhOXB6dkI0?=
 =?utf-8?B?K2N4NjFjS0dGdEttS0FaaEJpbW5Uck5ldlJpOXlFb0h5RHhSWDFkVEs5NVVZ?=
 =?utf-8?B?aWFZL1FWMW1WRndEcWNmMkN4S2d1TjFGcW5lb3dKMCt2YkxHVGp5Z0wzV0lv?=
 =?utf-8?B?M1crOXdOaEtrcHp0S2E3NGlCVUlPelFpeGhVR09QVFZJOVYwUDNvRmcyMkdB?=
 =?utf-8?Q?FW4cTrja5TQIsBaXL3gW4PkjekD307aTzm+LHy5cv1PG3?=
X-MS-Exchange-AntiSpam-MessageData-1: tYDOT7K5qb7OOQ==
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc91f5dd-5061-4e85-f2e5-08da496ee9c5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:49:54.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LOXb8MeY3EQPtZFu9j0moHUaoI1AiyuvaqTP1Hai/luTF4/5Cu3iSE3ooGcLwbml4vlM3jlZxTbxQbX/pcVMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8452
X-TM-AS-ERS: 104.47.5.55-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26944.001
X-TMASE-Result: 10--10.740900-4.000000
X-TMASE-MatchedRID: y/2oPz6gbvg6yy6RAAEPc65i3jK3KDOoC/ExpXrHizwM4i3DScf0scNG
        97DfmZl7TPK+KoOivGanTNYQei/0G1nGEjlsas2ye015woyPLfbBOVz0Jwcxl6vCrG0TnfVUvqn
        FtM6Nq/LhphqipnEX3Fs4QZAvccGCSrKLiysRAC4Zca7SN08UZBeN9Hd3TB5GPHMAbjuhwd9zCG
        qWg6PTivyPsndJnGNFSArVrOFmKyHzVhAZtxSZ0s69emDs42dd2FA7wK9mP9e4GyTmeN+AbC15I
        FUNL+ETeIe4HQ8ldFa1k1Md9jc6+pcFdomgH0lnOX/V8P8ail1ZDL1gLmoa/PoA9r2LThYYKrau
        Xd3MZDUHi8CNpq2En1B9GkMY3zTJ4Tt/Pml4SiibFILCA9TJOs7FDNRUTqOA
X-TMASE-XGENCLOUD: 04ff35e4-f31f-42a1-b8dc-ec3e8efa2488-0-0-200-0
X-TM-Deliver-Signature: F8ED72FA0F10F9A24E5E9160619AA086
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1654706997;
        bh=OlJ1OXbE75jdkKCbWSNkWbbRslVh6EQQXEy6H0+vgrA=; l=5854;
        h=Date:To:From;
        b=HEXBJAXCf+BlA1+mKq5pQjY9O2XqitcRsgpDyPlMap72ML4mnfUBAmbOFkHv9rCOj
         B6C1h4QvF8O+/5oiH8qMgrNfr7/Do4TTXAMpBFN7IXyfITnkLc2j/Z/RpZ90mAKhwj
         rqdB1ExsPECoZuepPDZAMBACb/+P2tsXfck9P6JGkfFPGEC0Sn2qKqPcp0wy+rJU3R
         LyaN1sWyFA8+aQE5B+du6Y30erN1UPpzjiFW9gv6US8d2FAx6mC2yP0S966c8xC8Pr
         b47UXH5wbcHLs5LhSlDSSAFAY3yzXfJRsxLmUOQ//z+LZ9CE4tmgUmU4lsfbrFKNxL
         PXcOFjkGN4eXA==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.22 18:40, Cristian Marussi wrote:
> Avoid to invoke SENSOR_AXIS_NAME_GET on sensors that have not declared at
> least one of their axes as supporting extended names.
> 
> Since the returned list of axes supporting extended names is not
> necessarily comprising all the existing axes of the specified sensor,
> take care also to properly pick the ax descriptor from the id embedded
> in the reply.
> 
> Cc: Peter Hilber <peter.hilber@opensynergy.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Fixes: 802b0bed011e ("firmware: arm_scmi: Add SCMI v3.1 SENSOR_AXIS_NAME_GET support")
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Peter Hilber <peter.hilber@opensynergy.com>

> ---
> V1 --> v2
> - fixed missing endianity conversion
> ---
>  drivers/firmware/arm_scmi/sensors.c | 56 +++++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index 75b9d716508e..8a93dd944c49 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -358,15 +358,20 @@ static int scmi_sensor_update_intervals(const struct scmi_protocol_handle *ph,
>  	return ph->hops->iter_response_run(iter);
>  }
>  
> +struct scmi_apriv {
> +	bool any_axes_support_extended_names;
> +	struct scmi_sensor_info *s;
> +};
> +
>  static void iter_axes_desc_prepare_message(void *message,
>  					   const unsigned int desc_index,
>  					   const void *priv)
>  {
>  	struct scmi_msg_sensor_axis_description_get *msg = message;
> -	const struct scmi_sensor_info *s = priv;
> +	const struct scmi_apriv *apriv = priv;
>  
>  	/* Set the number of sensors to be skipped/already read */
> -	msg->id = cpu_to_le32(s->id);
> +	msg->id = cpu_to_le32(apriv->s->id);
>  	msg->axis_desc_index = cpu_to_le32(desc_index);
>  }
>  
> @@ -393,12 +398,14 @@ iter_axes_desc_process_response(const struct scmi_protocol_handle *ph,
>  	u32 attrh, attrl;
>  	struct scmi_sensor_axis_info *a;
>  	size_t dsize = SCMI_MSG_RESP_AXIS_DESCR_BASE_SZ;
> -	struct scmi_sensor_info *s = priv;
> +	struct scmi_apriv *apriv = priv;
>  	const struct scmi_axis_descriptor *adesc = st->priv;
>  
>  	attrl = le32_to_cpu(adesc->attributes_low);
> +	if (SUPPORTS_EXTENDED_AXIS_NAMES(attrl))
> +		apriv->any_axes_support_extended_names = true;
>  
> -	a = &s->axis[st->desc_index + st->loop_idx];
> +	a = &apriv->s->axis[st->desc_index + st->loop_idx];
>  	a->id = le32_to_cpu(adesc->id);
>  	a->extended_attrs = SUPPORTS_EXTEND_ATTRS(attrl);
>  
> @@ -444,10 +451,19 @@ iter_axes_extended_name_process_response(const struct scmi_protocol_handle *ph,
>  					 void *priv)
>  {
>  	struct scmi_sensor_axis_info *a;
> -	const struct scmi_sensor_info *s = priv;
> +	const struct scmi_apriv *apriv = priv;
>  	struct scmi_sensor_axis_name_descriptor *adesc = st->priv;
> +	u32 axis_id = le32_to_cpu(adesc->axis_id);
> +
> +	if (axis_id >= st->max_resources)
> +		return -EPROTO;
>  
> -	a = &s->axis[st->desc_index + st->loop_idx];
> +	/*
> +	 * Pick the corresponding descriptor based on the axis_id embedded
> +	 * in the reply since the list of axes supporting extended names
> +	 * can be a subset of all the axes.
> +	 */
> +	a = &apriv->s->axis[axis_id];
>  	strscpy(a->name, adesc->name, SCMI_MAX_STR_SIZE);
>  	st->priv = ++adesc;
>  
> @@ -458,21 +474,36 @@ static int
>  scmi_sensor_axis_extended_names_get(const struct scmi_protocol_handle *ph,
>  				    struct scmi_sensor_info *s)
>  {
> +	int ret;
>  	void *iter;
>  	struct scmi_iterator_ops ops = {
>  		.prepare_message = iter_axes_desc_prepare_message,
>  		.update_state = iter_axes_extended_name_update_state,
>  		.process_response = iter_axes_extended_name_process_response,
>  	};
> +	struct scmi_apriv apriv = {
> +		.any_axes_support_extended_names = false,
> +		.s = s,
> +	};
>  
>  	iter = ph->hops->iter_response_init(ph, &ops, s->num_axis,
>  					    SENSOR_AXIS_NAME_GET,
>  					    sizeof(struct scmi_msg_sensor_axis_description_get),
> -					    s);
> +					    &apriv);
>  	if (IS_ERR(iter))
>  		return PTR_ERR(iter);
>  
> -	return ph->hops->iter_response_run(iter);
> +	/*
> +	 * Do not cause whole protocol initialization failure when failing to
> +	 * get extended names for axes.
> +	 */
> +	ret = ph->hops->iter_response_run(iter);
> +	if (ret)
> +		dev_warn(ph->dev,
> +			 "Failed to get axes extended names for %s (ret:%d).\n",
> +			 s->name, ret);
> +
> +	return 0;
>  }
>  
>  static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
> @@ -486,6 +517,10 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
>  		.update_state = iter_axes_desc_update_state,
>  		.process_response = iter_axes_desc_process_response,
>  	};
> +	struct scmi_apriv apriv = {
> +		.any_axes_support_extended_names = false,
> +		.s = s,
> +	};
>  
>  	s->axis = devm_kcalloc(ph->dev, s->num_axis,
>  			       sizeof(*s->axis), GFP_KERNEL);
> @@ -495,7 +530,7 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
>  	iter = ph->hops->iter_response_init(ph, &ops, s->num_axis,
>  					    SENSOR_AXIS_DESCRIPTION_GET,
>  					    sizeof(struct scmi_msg_sensor_axis_description_get),
> -					    s);
> +					    &apriv);
>  	if (IS_ERR(iter))
>  		return PTR_ERR(iter);
>  
> @@ -503,7 +538,8 @@ static int scmi_sensor_axis_description(const struct scmi_protocol_handle *ph,
>  	if (ret)
>  		return ret;
>  
> -	if (PROTOCOL_REV_MAJOR(version) >= 0x3)
> +	if (PROTOCOL_REV_MAJOR(version) >= 0x3 &&
> +	    apriv.any_axes_support_extended_names)
>  		ret = scmi_sensor_axis_extended_names_get(ph, s);
>  
>  	return ret;


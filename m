Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C53551BD14
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350771AbiEEKZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbiEEKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:25:46 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3560E4CD57
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 03:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1651746125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8TDl0x7QKVM5gk8Jlym8MmsZwQgTTn/BdzS96aktyio=;
        b=Y7KNAU/bS70LeA/dNGIvBYqj4xwEKCwC6fl8g/sF5AzPznYtcY+v2y4YXfL9B6O5MXcYo1
        BGBRxbdomEZ/sZhf0150hiu+yIMip5mSGv5bpJt87Fe8tYujWm44yrC/JRJmFDyd5+QL21
        0nF70gXCb6GgW6hvn1pMjxu/lhaBU4g=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2053.outbound.protection.outlook.com [104.47.6.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-9P1OMw0kNdmBcpD3ZP_BxQ-1; Thu, 05 May 2022 12:22:00 +0200
X-MC-Unique: 9P1OMw0kNdmBcpD3ZP_BxQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CndbVo2+MkoZWyCpZn64QRnZGh8ubWdd4xgp9A9dMZYp9tdxBnz2MvX7wxbQqCGRRvDnIHMTmMopZKJR2hGDAr0sUkbqyTma6KGVHfqBVWTOxhzwmy/Yc7EVsjIBJ5UE4iOL+yTCcH1SaNJVnix4y/o+DjslkZmOidiUPjm4eqZmYIpPvHS43n2JN7bNGhBocP2dazauseOmb4isgW80c1EA7aVAgEf5YZTLKW2YJWFjoOr0ZEux83lbMcRgo0Le48uXmCL2+bXrcRKZbFL7YXJhZLfV9CbW8v6eNLd0/YrWQrGhPZgl/mrP2fT71V+Dg2hDTbiwgicDHmVeDsn7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzekpFy6m6e8CBsvnZHf8l8gigy4t5miXQzyot4HjQA=;
 b=kSXWvKFR2/r7OpBFnJvMl968Tr7PqY2wUPh29Qk+BK0DGdAxsfT1WJIHn855MUvJazYn3oPA87468wDxuy8FZYaVAvq98C3fUVpy4IhVME9yPupI6SP5ot2ig58X3bQbtixEkOKMRPz1CPDt8+1bBS+nu51y0iDcYxPSbK6gIEkqG0qwNPEVDqwDyPUDu8P6W4VxtAWv86PX9s+j8dbAaZ5qL3jMAb+bA1voyCtNrYxhAqN/NGKA3U9N7c0vmst+PIxjv4VAe9cIoL0/Gpt5eL2sBpbJ2pHnzwK2FvU0PUIBOO3YIW0D+7/7NAwyYOtvWe6+kA/Lin/ZDU1KIiYqOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by DB7PR04MB5482.eurprd04.prod.outlook.com
 (2603:10a6:10:85::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 10:21:58 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::8c82:19c5:ce96:491b]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::8c82:19c5:ce96:491b%4]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 10:21:58 +0000
Message-ID: <4d30b811-b452-cbf0-a3e3-00e400ba76ef@suse.com>
Date:   Thu, 5 May 2022 12:21:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] Add USB_QUIRK_NO_LPM USB_QUIRK_RESET_RESUME quirks for
 Dell usb gen 2 device to not fail during enumeration.
Content-Language: en-US
To:     monish.kumar.r@intel.com, gregkh@linuxfoundation.org,
        olebowle@gmx.com, oneukum@suse.com, vpalatin@chromium.org,
        wangjm221@gmail.com, chris.chiu@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
CC:     abhijeet.rao@intel.com
References: <20220505101459.7804-1-monish.kumar.r@intel.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220505101459.7804-1-monish.kumar.r@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM6P194CA0005.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::18) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64215c63-ec8f-45bd-cc9f-08da2e8115ff
X-MS-TrafficTypeDiagnostic: DB7PR04MB5482:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <DB7PR04MB548216DC208177E4DAB92BD8C7C29@DB7PR04MB5482.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9WQ+1poojCmF4Pf4Wvbf8niUrOtMZXt9fea/aBF88h9VQfmrjxG/ojS5XKER2/IblVyTkMjZ7KCHWJQVSKx+NvMJgEdO6B531RNK/S+4I+s8TWVbeiaLfNM8nNfxLsg8TpwVQhtSbKp8L25NKVjoQiuxqnKenKvSeEofBhYpaGwgdHcVry5fBGex3l4Ar7hhij9SG9FBhUO/t18fnvb2AuHaOV8lguXyHcevNQC09CjZAkLxtfRVbiaPdI4iwINatHgsGErcuuX2ccdxf0xab/G4+7nbEIw6GZS334xBPnxPjo/PX+tXv7yJYDIZjmr11JO/eKGe53xIOQIjuQ4GQecRtmg3/1gbwfY9CzaZ1ZZJFhf1kfz934Kl8ZgQTjj839DpW/OIO2qt4qjn0vUUQz8IX8K7ESPMnl8Jzg0tiG6IG6nDWSJJ1ePimh+ExvbbLdKpI9CrLh9f4U+lkbge0uYyTq53XnU0pf28ktAgiz9x2tJc3eXgjIJPrS6gvUMlVXdNNQU5LB8sZppFNLg84e286PlmZa3iPj5HdC0dR2ays9qc4JgpB5+XvkyfiEzmwH+pFUxlOYv8SyELfen4Yylh0wMbWg58aNx05qf9J324WRMJYTYJFqdKWPn2bxCvE6Wu649c/af5DzDNSmJ87xIKm7kgdwoXJ4AKq2oaS1V1ar9ikvuxjmErN0DjuADHLIaXylSkWHG6cmCm17QVpdDBhxLcNZtdHDDY0aPQKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(31696002)(2616005)(38100700002)(66946007)(8676002)(66476007)(66556008)(4326008)(36756003)(8936002)(186003)(2906002)(316002)(5660300002)(6486002)(53546011)(508600001)(6512007)(31686004)(6506007)(6666004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SkHcT2jgZPGmcifVHuqYWlaH3KNBxVbc+V0BFz00vQltrkR7IAyC+Dq+sYsT?=
 =?us-ascii?Q?36KA0Kq883fLWVeSLUOYWkJlGJE4CE0umC2UJsL8pl/5KJIz40xpX1tNOAe6?=
 =?us-ascii?Q?WYx0gQQAS7/jAE9NuYAqJ9ElZ2X6GaU4ABB70uen/eRp+yennzMG2CdF0QX1?=
 =?us-ascii?Q?omA++uLP2LJAALRLYtolgZc7pyfk0Xadwz0AIZRmGybnSc63xZrD2hcyeqdk?=
 =?us-ascii?Q?q1eKc/6FQK5Rn9ZU9OVR6GYubMg/KKwVBbgCcCko+lecisJc88Hmytk7T86w?=
 =?us-ascii?Q?mczpVz9R1ZT8L+lGlB8IgtOBRjZc/H6pnoERRKID+VSQ7PO0Ea/S75LufRmq?=
 =?us-ascii?Q?BBSiBSXI1A7p4PJ+k23gHuTnicUTNrS+I5UU1nCB0lmRvQBmAKyeQ99L6cKt?=
 =?us-ascii?Q?/1WYXjHAhspmjl6z7rVZ4u1YrWvyGBRnA+mwEwr0F8S21Tktg4Mmsf6TjA97?=
 =?us-ascii?Q?oKu+LmVUzc9uEj09GhnrxiuOfJ0F6DJHcQ12XbfhkrX6M82p3rEX0DVYvaSL?=
 =?us-ascii?Q?c6BI0jcGOeWjChcuO6lm3coAYJonP0EQI9b0FAfd0sOTLmt9BWtRTzaqplZE?=
 =?us-ascii?Q?oGtJ7QhNA8S5h44lU2IO9o+GRGWs5T8XaaLgOfgGJn179tmVaN5Fr6GccZyx?=
 =?us-ascii?Q?v2U327462I8f9c3dPf3LN4lrutP30AXBbKF68frlLnNM/9M0TCX2nl1LZTcO?=
 =?us-ascii?Q?xD7BRJUAGtZqOTUVnnylSjwTuQ6aTEgnQtn80TGwNMacdMPwqz65kuSiLsQq?=
 =?us-ascii?Q?MlmkyYpfBcMDyLJwDcxOyK/qI6GbGJ75IUMKHGYQegR/uW9ZMxUlup6qRlMG?=
 =?us-ascii?Q?LxSIoyjmRkjVzQd/gJLrxlozIDmIL+5N079r5H7aw0kxK8Eb4toP6uBy2U3Q?=
 =?us-ascii?Q?/PwD7nYGSXyVc05D6/ebT0M2m2KHiLmK3i6aabNOvB1HZjWOfWg3MgSA+pCc?=
 =?us-ascii?Q?v6mVBxqrtUzHcWhvbZU1DAsmKNtUNXsK6csXhhoSSdfm8pkhwN4d4QPAWxyy?=
 =?us-ascii?Q?YJQKlzylHppiekbaoqEq9yygS8/3bKpAjI1UALsabskEY7h+Sf1PC8LnAOUs?=
 =?us-ascii?Q?T/dFaqBhfqWEnY2shNvzUD80UCbXnRIqUz08cGt73CW71NFTEYU1u2oqlgYo?=
 =?us-ascii?Q?LXsP0cWIek4TGa1oXqQjV5yqZRcEAoqT3wq/UmaoA/vnhWvMFq+WaTMHbVKl?=
 =?us-ascii?Q?sLZaYYHIoohWU7WzCqicPiFoo1nnD1nanFbK7wjm1TYgTLv5kkDbHfwZ5+VM?=
 =?us-ascii?Q?h9dT6qOXpl6IgDcEPQ9j8R4k8lLi6zmdgjw+EYoCsqACutWzlyTYEmutcwg2?=
 =?us-ascii?Q?CJOOPF6PlTK3wI45hobXYO8UiyIvXVwnyDpPYEq2I8SoLdcruQiuhbJm/STm?=
 =?us-ascii?Q?BGANcsFoNQlE/CqMHDg6EagikaZsEJALdIM2AzuRvFhHdDbWIcE/02Tbik2o?=
 =?us-ascii?Q?WFREtxzDN3zJxvs+zgKMLVmOZb7jyi9pSPovshK0Y7E82q3cei/VcIq5+OxG?=
 =?us-ascii?Q?lys+M6oDbjIQgvR0aQII6C7s/xIz5i1qWZQ4i/zS2fwxFlLnOq5Y5WTLB1Kk?=
 =?us-ascii?Q?YijuE5KWMAh7jib+YFIhgSasgNSCr5mEB9VOTdbb31+Qb0EIfyKP6z1aTjtc?=
 =?us-ascii?Q?S5SD06v8xCCXNhn/+Kr/40tAC+sr/r1qqQO/HnKJFmosQ1p68x4PM/gf6u2B?=
 =?us-ascii?Q?B8Q9MhMa6Nd+ujc92o4XDRXI7WQatk4ymV79Qz7zNga9VMZUJHI7wS32bpbX?=
 =?us-ascii?Q?aA80Rf0Pe2LLzvON2w+LgU8r/q2gu7gaA4zkCgmjWigdzMk5yygenVxdQW0t?=
X-MS-Exchange-AntiSpam-MessageData-1: xHp1fel7PMXdBw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64215c63-ec8f-45bd-cc9f-08da2e8115ff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 10:21:58.2497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Utu2CgSVnUuByOmwNObCPCklPgFd3SCH/sfSrALYJK9VXSIIhzbmYRwhji9OKEHUNmcNmQi2K5zkxeMpfep1nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5482
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.05.22 12:14, monish.kumar.r@intel.com wrote:
> From: Monish Kumar R <monish.kumar.r@intel.com>
>
> Signed-off-by: Monish Kumar R <monish.kumar.r@intel.com>
> ---
>  drivers/usb/core/quirks.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 97b44a68668a..257ac37464e8 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -515,6 +515,10 @@ static const struct usb_device_id usb_quirk_list[] =
=3D {
> =20
>  	/* INTEL VALUE SSD */
>  	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info =3D USB_QUIRK_RESET_RESUME }=
,
>        =20
> +	/*DELL USB GEN2 */
> +	{ USB_DEVICE(0x413c, 0xb062), .driver_info =3D USB_QUIRK_NO_LPM },
> +	{ USB_DEVICE(0x413c, 0xb062), .driver_info =3D USB_QUIRK_RESET_RESUME }=
,
> =20
>

Hi,

could you please

1) keep the list in nummerical order from lowest device ID to largest
2) combine both quirks with a binary OR
3) provide a short reason for this patch like "found in own testing" or
"reported on list"

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 Oliver
=C2=A0


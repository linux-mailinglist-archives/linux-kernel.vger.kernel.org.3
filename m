Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449024B8560
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiBPKQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:16:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiBPKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:15:59 -0500
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F69922B0B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:15:46 -0800 (PST)
Received: from 104.47.8.54_.trendmicro.com (unknown [172.21.201.50])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 9407710001751;
        Wed, 16 Feb 2022 10:15:44 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1645006543.710000
X-TM-MAIL-UUID: 1804db23-24de-41b3-be17-57da99de0c02
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (unknown [104.47.8.54])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id AD7FC10005E17;
        Wed, 16 Feb 2022 10:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KaWHIot1QpffFmM4siGeYyaYDuPaRurkZZQU2VVD1cBkEf/1HvbiMhZluI0wrSva04EvVpXne3LMzD09m1MQbaWEV0U2STDUPk/xpR+V9d2FnKLIgvlJ9VnQ/uYfeH+/9Mm60qDqxjCXnGZMJmid/vXbyfnCfNd+zV8/+dAKswb2sylU5/oTEFWgKrYwXyzxt8R6SLbR/UoPwMq6I4ACjti5FD6nMaTgsU4fCHGXCufIfZXLRnA+wKd8nZmO4SNxnmknBpFUB7Q7H/6JUEoa8d9VMDuP/pNqwYr0gJTyjmXdlXzwzG5ftHDtxgYAOXP9l3H1aBnrwptWVMMb7I19MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71eK5b+4Bb9Kj3Clc6zboOCpVpRhwHLOqSwuXAhMj8Q=;
 b=EE3J1P3FgjxHB9zYx7Y5NdEZNAfNwQAMhlP5g5x+cWbm+KIH7o4TLrGWLdqQtHl0yIJTISRp+Kn3tqJVeodAdvNBlrU9tu56Az7xMI7D4Ini1Zng/RQt+jSkfk5WCyJEknMpcRV57Lu+zEYOEM6RIM84im9N4PzL0ulhx+L7wCwel+tnvQ/3lz0gmy9BO8iEsFq0gFax85K63DpPJdMrXYLiMBvWyNX0iqZZLcxbYJDVWd51nC+d/SVa5tl4my8xP5N+VE2mYtzIGTwY7Sg6u+HollU12dGSACSZqnAP1A0v+JeLUUY3fV7mE468k8vHIQb6mlUvbQyXk86uF8IUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <e63e2331-c30c-7151-9348-7f01850ff82e@opensynergy.com>
Date:   Wed, 16 Feb 2022 11:15:40 +0100
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
References: <20220213195832.27932-1-cristian.marussi@arm.com>
 <20220213195832.27932-2-cristian.marussi@arm.com>
Content-Language: en-US
Subject: Re: [PATCH v4 1/8] firmware: arm_scmi: Add a virtio channel refcount
In-Reply-To: <20220213195832.27932-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0093.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::34) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48503ddd-9645-4ec1-a48b-08d9f1354949
X-MS-TrafficTypeDiagnostic: AM0PR04MB4339:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB43395A2EBC32115CD054CC898C359@AM0PR04MB4339.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FIKGexfDrluHetdzXEBGEOQOmfSGMr2cngDiu7t9Nguol8lIzIvftRXOvF4Yc1KE4YgiwOtU/MpE9SolN2MCVrxkS3sGahOBHQFGLVJUHP0UOMS/LZy23iDQG2PN0A0nPh5errEQyHMxckDVFI3UoMG5rfDwnexAJ/uw9dPXISCNGUnS5GLPPNQfmpKqQKtcGdHfNpo3wOUW2VnNfQy5oYGQiIPbV2e3k4I//oMK9GC4dqIvYmdoF5cPz6X3K8023BA/MCN8aBaSSO9dm1/DDD0eKr0kspGTOxSYK1cpQWYvPs20PIFqxuctQRcR7X8WwY8EUPzm1nw0Wi6rLOOdmZIDHOQvgT6AgB7no41Tac/AUx7i5sWxptCov4tSXWEPhn6C1bIdaA1YiNw05oqRxTdh3to6Zz9z2rYJgcNqCrY+mmXHaYnpsejbGEBGMsLkhWMJI8TAO3CvqUq+4Te7Hu+irZq1+vbEprvrzJDh9cPcaMiXFpT64IHdYuw7AKRW8fhu7ZPdcvxOd1gbXnE+Al2WLNQjzTTjmKLhMX58Lnn/ovcm7P2gci86Y2waWUh/TyHR6wwCvXcdwHqGMMR1u91C2KIghEn9DutuDs5W6yJTNQVIEL8cbpmQ9EnZPSfAq/oldmEYRuFvJbjGw1iYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(2616005)(66476007)(66556008)(66946007)(36756003)(4326008)(316002)(31686004)(44832011)(2906002)(5660300002)(31696002)(186003)(7416002)(86362001)(53546011)(508600001)(42186006)(83380400001)(38100700002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmRXWTNuVWppM3ZXblREOFVsV0Flb2w4MzVONSs5RVFTVGZDVFFQR1liMUxB?=
 =?utf-8?B?RGJhVTl0anByRlJBbVV3REtORjlKblZKcVhBSXNBL3RiZUhNR0xBMEdBazdh?=
 =?utf-8?B?L0xzVFBReDhKb1RZYkVGMm9tMGV4ZmJ1cWFMeUpTcmdKeDI3eVpBdm93dEh1?=
 =?utf-8?B?S25tYmltd0lnT0Q4L3RzYzE0RGhYazhYY1hpb3FEZkl0Vmp3UzIzdDFCclJu?=
 =?utf-8?B?a0FncFJXSlc3RFloeUZNZ2k5ZVlHWUhmcWtScVB5UnRZWndLS2NlZHRXQm1k?=
 =?utf-8?B?UjJ4SmxZWHJXUHIraVp1c1BxcHE0MEZVUDBIVGFrMXZZazFLVkJhNzZDZS9T?=
 =?utf-8?B?VExlVHdlcEo0TmhyZmRYQ0h5VDVsb1pQOFBtSFVuV0Z0dEhuT2l3b0NTSS9i?=
 =?utf-8?B?WWNCYkQ2UlVnMjlzdlc2YW5tbERwUXFNYU0wZzJZR2gxb2g1eTZsQ2VBLzZ5?=
 =?utf-8?B?MkN0N05haXd1NDJDU2E3YnF3Z3ZTYkVpUzlNVERWT1lMaHBZaFAwZXhmaVhG?=
 =?utf-8?B?KzVKeW5YV2lDUyt3Zk1PMmp6V3JPaUhKSitJK3psSGY2YW04a28ySW4wSVB4?=
 =?utf-8?B?NHAzdDZocXlZRWMxbUVMRU9tWXI3enQxM1d5S3ZLbVc5ZXZBQzN5a1ZxS3lJ?=
 =?utf-8?B?RmdMK2VVMDlFdVV5b1kxSWpMaGEwQW9WSW1oQ0Z5MC9ya0lNU1VSbzQ3QURx?=
 =?utf-8?B?V1hqeVNocEMrMGQyNzljMFcwSW1oRjdncVQyclR4Z0VzcVdlUXZvaUFxSnQ1?=
 =?utf-8?B?OXBrMUVDbW0rVGxqNmlPM3NRRVpNNDFYaG5YZTR4VFcza0hEOC9JUTVXTnkr?=
 =?utf-8?B?U2NrOHFrRnJ1RzBBalZnM1MvdkxtRndYWCtISUxWQ3djQWJtQjRrWFlBdUc0?=
 =?utf-8?B?TSsydHV1djVFeWhiTlhtNU1XZW5tRUFHN2JaaEUzOCtSR3RYcFFoamZpUHdT?=
 =?utf-8?B?N0lLWi9rTkNVRm1zR3pieExmTCs2aFIzbE1lalJEZ1ZwdFhNbGFiNjdiUktl?=
 =?utf-8?B?Mi9DWjBQNmkydGJ5ZzZMVHZtYms2UVEzWWlLN1BqRTBkQTZCNjNMQ0VtZFVy?=
 =?utf-8?B?VUdZbG9rYkFNV29BdnZLK2k0TU9veWlpNFB2YjRTbHRWR2tHandDUGhGUC9E?=
 =?utf-8?B?ek1nYTNxSWRCODNKTVF3eWlNZDhoSW9CUEhHbzZkbmlETVdhL3ZMM0hpNjQr?=
 =?utf-8?B?WTdVa2l1QVEzaXV0cVNKdTZ3NnBHRlQvRHFHVjlidjgxSm1zRzNidVY1aFZ3?=
 =?utf-8?B?VENYK3dmZkY3L3g5R0VtU24ydnpJQ1Y0YmxWNUhFb29UNk5uc3lKelZFOVA3?=
 =?utf-8?B?bm1TNVAxY09IaUp4dnJDZTVWNnVPY3RDZUxLdFo2YjMvWFFsSVl1MFRuS2VO?=
 =?utf-8?B?SlNiOTBubFpuSWoyQzZjNmJjTkhNZm43clcyYmxxc3YrbUtCY24rbTdCRWlD?=
 =?utf-8?B?OURUQ1NmcVV1WE9iUHFSS1MraGNBd1BYZFF1b0R6S0R5UEdJS2ZtMFVnK05H?=
 =?utf-8?B?YStkb21IcjdtTHd2ZEVyODJrNTc0K29BVTJMZWJBajVabnlYSU5SSjl6YkNU?=
 =?utf-8?B?L0Myd2x6bllBdzN1QjJYMERXcDVMSXZqVXR5cGRnK2lCUW9iM1lJdzFMT2dI?=
 =?utf-8?B?ZXdmY1pPRCtEcUpueDlCRkRHR1E1bHVRdldjVTl6aTlsNXFhbUtYTTc0OWlr?=
 =?utf-8?B?SE5zVHYxS2NQbjhCTTRVL043WWlibzVYVW5aNGwyWmV0SjA4SXRTalZVRGJQ?=
 =?utf-8?B?cENubEdYTVcvZm90MjlhaStRQjBhMVVOS0UydnNVRWJYS2FRSUNsMjFscmto?=
 =?utf-8?B?eXZZZHJ1QXduRncrQmt5SXFxQjVZUTJscDMvdXhtdlF3ZDVabEhRampFV281?=
 =?utf-8?B?Y01TQ2lGRngzZmw2NHVBVnZ1ZUJ6cTliRmNnMDgwNDB2M2Y5OEFvenIxVDls?=
 =?utf-8?B?OHYvTGJoRkVWdE5EZE84clVtcVRZTWRJNGZ5eldlc0FkQUxLUE9oRlBld1V5?=
 =?utf-8?B?ZE82RklwcW9ZcEZXd1YzNFZNcksrYUtkSW5aOUdJVkRaRUJFY0FQTS8xK2FR?=
 =?utf-8?B?U0NGdWR1Y0pWWmZ5Y2xLckNKajh0SGM1d1JsK1VZQXpGMkk3U2Q1MWZTYzVG?=
 =?utf-8?B?ckUvOTM5TWxmSk9lbG53U3lidENXRndVNk5ybXB6VStQNEI1R1RiMHV4aDFh?=
 =?utf-8?B?TTNwakZJa0pMYjNoNzNTTmRxazlhY1dXU0NoSHdsa2RodDRFQ3l2MWdnTlZs?=
 =?utf-8?Q?lPb2tAOjAv7NkpmDGRa1Ymgfl34iKPw1uifrNHntgY=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48503ddd-9645-4ec1-a48b-08d9f1354949
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 10:15:41.6321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kL6ih7vxFRfPN3PIGfyAu1EcziOd3FZrTZU42di+ofMDJqjUimF/5ikruyQt2k9pH3bCz8zGZ0igi++6G65/tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4339
X-TM-AS-ERS: 104.47.8.54-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26718.007
X-TMASE-Result: 10--8.756900-4.000000
X-TMASE-MatchedRID: gjZGo2H/wj//9O/B1c/Qy65i3jK3KDOoC/ExpXrHizyTsyhw1KPqkKKJ
        8yeXnfHAV620YhTcoiCy30IXTXvfRtIUKEcXjyBBR/j040fRFpK6G/3hYXpyaSt+gViu+UDkZ28
        gEzxS4tI8voXkm0M2YTObYIZTq3V4tVDpc9bC13IReM8i8p3vgEyQ5fRSh265592Swrd60Um4fy
        jZfhYUysMXWyGJ+tal7i7ibx9W3/kpcZda/ugaiJqnULil5JqLjkDrBOJwwnTZGPiiG8TMcw6+r
        PzHX18bYLGH+6Z/m2VOMFJeHBztQFP3I2ELpBKCk9BMOpPKZtJReWnUUdhI9QPHqiqIXxKGUexg
        NDoxdJaTQIFajwqzX+IRcf2G2Sd6RWjg7Zej0d0Zca7SN08UZGUfjhTZG7XakCszjODX6JLQk3h
        FSUm2ZqdHq3Rt1uM3TGg4ykZAAVhmdyCa5id7ahmCYUYerLHrKkd89GqHvUlULhp+W/a9mZjA2k
        GUhLCkasndy/28hYs7QajFbojNNZcFdomgH0lnOX/V8P8ail1ZDL1gLmoa/PoA9r2LThYYKrauX
        d3MZDUGhfRb1Tj8IOM/Zmz6sXpyoK1BImpuDAsGsrNOYz3Ul/skCb58xlo3
X-TMASE-XGENCLOUD: 82ac9a46-5890-4a17-8890-2f3c5aafe2f3-0-0-200-0
X-TM-Deliver-Signature: 3D625CA518442F552EC0C532B39073F1
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1645006544;
        bh=2jgP2Q91UwwGdKgLtEX24bA9WiyjAUclrZziEkYMYmc=; l=10270;
        h=Date:From:To;
        b=JBAM+eAhKDfKjap2UQG6GSsLVT3aC8bWEuPjmdwHcltQ4dhgUnX3u2IkKdLey1LEz
         gvgTmIf5rf2uGuKe6CUYpGzqZyNTaIMuepl1qbvAlfqO3aDFzXrK4ZEfCsjA7il/dw
         ajs7Fa1kcERHOSmjmq+yeRe1jSHQF2cIAyd9GyW2vNnZVNWftNaAFBZqcbGMs/YXCU
         Vd4n9JBMIgYBfop4HIPMdwCIOcRA6NPOXXbtttkJR8DeQ09sDKBRStUpeHxo5KpaZ2
         5fJP4vNpuRF/33WOd/NG8dSl9meGa2UTioa0RSlQa3zVyA/MQW1w5HvHrq/FkNT+9v
         1eOEtWs3UQXng==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.22 20:58, Cristian Marussi wrote:
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
> ---
> v2 --> v3
> - Break virtio device at shutdown while cleaning up SCMI channel
> ---
>  drivers/firmware/arm_scmi/virtio.c | 140 +++++++++++++++++++----------
>  1 file changed, 92 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> index fd0f6f91fc0b..112d6bd4be2e 100644
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
> @@ -130,27 +188,27 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>  	vioch = &((struct scmi_vio_channel *)vqueue->vdev->priv)[vqueue->index];
>  
>  	for (;;) {
> -		spin_lock_irqsave(&vioch->ready_lock, ready_flags);
> -
> -		if (!vioch->ready) {
> +		if (!scmi_vio_channel_acquire(vioch)) {
>  			if (!cb_enabled)
>  				(void)virtqueue_enable_cb(vqueue);

This seems unneeded ATM (in particular since the virtqueue is now broken when
freeing the channel).

> -			goto unlock_ready_out;
> +			return;
>  		}
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
> @@ -161,19 +219,14 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
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
> @@ -273,35 +326,20 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
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
> @@ -316,10 +354,14 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
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
> @@ -342,6 +384,8 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>  
>  	spin_unlock_irqrestore(&vioch->lock, flags);
>  
> +	scmi_vio_channel_release(vioch);
> +
>  	return rc;
>  }
>  
> @@ -416,7 +460,6 @@ static int scmi_vio_probe(struct virtio_device *vdev)
>  		unsigned int sz;
>  
>  		spin_lock_init(&channels[i].lock);
> -		spin_lock_init(&channels[i].ready_lock);
>  		INIT_LIST_HEAD(&channels[i].free_list);
>  		channels[i].vqueue = vqs[i];
>  
> @@ -503,7 +546,8 @@ const struct scmi_desc scmi_virtio_desc = {
>  	.transport_init = virtio_scmi_init,
>  	.transport_exit = virtio_scmi_exit,
>  	.ops = &scmi_virtio_ops,
> -	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
> +	/* for non-realtime virtio devices */
> +	.max_rx_timeout_ms = VIRTIO_MAX_RX_TIMEOUT_MS,
>  	.max_msg = 0, /* overridden by virtio_get_max_msg() */
>  	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
>  };



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCAE5AE3C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbiIFJDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiIFJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:03:32 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20080.outbound.protection.outlook.com [40.107.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22ED3ECC8;
        Tue,  6 Sep 2022 02:03:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo1mFoh4lJYQVzUR0HVK9Fcvp9rrNk56wwWNY+fs3dz/yJgypA9A+ldt7a+nE2tV0wPodUW5BQzAQpg3Xnfk7PMZVfvSu/mo4rfH1VS0Xx3CmNmeA0GKf4l14tNYiNm2WE4jluAZ16bn4Ue/xOGZpr/QBX3mqCOanENyH9bocXqO+XnO35M3EXnnmpbmNNoFeyDIwHME1jbH3qSn0da3ctjJszv1XzzeOn6qhPt3kP4CkY/gyqJRvMAgf42HsWAquEaHtwLP/2Wn3vW1M/IakwpA58CIO3giC1Lpxx5OLpmozZFZAAArwhLnDy0Jtd4VssuYV7Xn6L6oqg+148FJeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHQTZVZwuvuNzCINReNfxf1WGgwyCMCnh1f4aUW117g=;
 b=FFsG7DZ97dxYqJheqEm5cLIYVqA9QFbvgVRct9Oe/AF1yZMMUafsK20aP1yTGPErEhSOJTa9ocnutFM4gNwki0mLn/Z7G1l/F4bjBBZv9f2pyCvZJ10vkqxvSE6+diT36vG82zb0BxtKULP8BvO3TO2omuOJN1m4PcjTG1yPTefLCADzmBTf1vPrrcYyvleS8+pqDoOcL29Uxuil9b8qBjsUIihHX4HH7IJ8n5TBH86XPeyGdFI58yFacL5RAJwjHBloigujqtqyfxL+Rd/AW35mtmxtQbUSylC0mnyQC5ZHKS+x+uDIygQCI3iLxqsMWuSDPuqUgu1SVrPx4crmlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHQTZVZwuvuNzCINReNfxf1WGgwyCMCnh1f4aUW117g=;
 b=NMGBxTj+CjDZHq5psqYQJXeyriyQ55WA1uD6ma7fwrByMzgCtvclisfx+yAR3zFpi1xVt8UwP67An/pAZxpNm4ky70SySsZz+pHKjvqwL7dvcMGgCSmijcIVKYsqkMnIRGgRjYzhmGg6GuNqF+UN2bvyWkmBQ45COIPPgwUljrAA224WKJVMxtfKOqS+nWWVXcf+Jf+5GgJDbHdHAAs1iPL+LbbV7dmlO4aQh63/MFPkmV5ChW1Xp1De2nvtJxauoxCHfkd4Wq4bERZ6Qpb3D1T4TTkLVc2wkD8dLspHlM4MnWwZ4eG/jifGgrbtf6xu2Ep41GWmRdztnffNVGJhoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11)
 by DB7PR04MB4153.eurprd04.prod.outlook.com (2603:10a6:5:20::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Tue, 6 Sep
 2022 09:03:25 +0000
Received: from DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::805a:6e4b:58e0:4d0e]) by DB8PR04MB7097.eurprd04.prod.outlook.com
 ([fe80::805a:6e4b:58e0:4d0e%9]) with mapi id 15.20.5588.016; Tue, 6 Sep 2022
 09:03:25 +0000
Message-ID: <e680adec-5ed6-1cbf-ed80-e4c07bb2ab15@suse.com>
Date:   Tue, 6 Sep 2022 11:03:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] usb: serial: add support for CH348
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org,
        johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        neil.armstrong@linaro.org
References: <20220906082934.2046584-1-clabbe@baylibre.com>
 <20220906082934.2046584-2-clabbe@baylibre.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220906082934.2046584-2-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::7) To DB8PR04MB7097.eurprd04.prod.outlook.com
 (2603:10a6:10:12a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f49c2e20-656d-4a1c-e367-08da8fe6a83d
X-MS-TrafficTypeDiagnostic: DB7PR04MB4153:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRMwjhnE0V9bATvUPoqZK1Hjvgq6OG0qzCrV8B0T/El+cc9g3MFgZ4XJ9OqRC4j56tbrtyxtA5fX1+vUSwnZOKsd+/Ngw09s99sNy7igVUNiH6Il8qOeQxMTM84ss9RKnLuVQXPKGXw9TsOsTBApZZpIZy3Viy6quD/nO0amawcWki57NbXWR9llKxbP7HAdYh1t2LXZ8+CZEeg5Ad+fIPpmB6RZd/cFuOMuDb/4LCFIwEylmm0Amdt0wr4MzHcs1hNgRHb7McsXIihL0ZAAoAAwtA+zKspr26NXu62MgB7sSqTSXtMaVRZ4AFw7MLMSoVCtJhdltcrWvi8FO5nqnv5Xxk5WODNt7uGN87Ee25bLBahULKt/IRspgoQqa8pD+2w3Gi6BBgNnzgj2GleojrNozwjK/6IU3I8z68x0PlTgasajG79G6Q4X0wGEKNRvSRduULNGx1p4ulCwKK5NupgS8PRLdM2z9/ge8inHra0J8vqVEteznnTq/9tyn3nKFfEoxk6iSdT9ylnsgw5FaEEzp0P+4qB7fkKOS2dz2VqALyJ9uIIzzuW+0ZFpOImkDFMPCIP81zN86Vh7OrqEsWfRiMgygOfx+LK4xMiyJ2HMY0uggNHMpjfOIfTMh01+9m4V8xZx/Qx+YgLbz7n0GfiDB9iUXxov/wa9ifTMPAB6/y63vyu/1ESCjJ44Xlbu1nMiMiHErPvO8PX3cehnsevBdZqlEoBRVRUCQoZGjxIfuebAd8gycSqKYauao4F6hWuQ4QU1UKyuoVueF3gax8Pq14GDU8EZmQEcA+xO+jQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7097.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(136003)(366004)(39860400002)(66476007)(66556008)(8676002)(6486002)(66946007)(83380400001)(478600001)(4326008)(8936002)(86362001)(5660300002)(2616005)(186003)(41300700001)(6512007)(36756003)(2906002)(316002)(38100700002)(31686004)(31696002)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjRwSGNxUnQ4YmdueThHODRySEVEemRSWExMeFRKSEI1NnJoZ2JnRE1vdjYv?=
 =?utf-8?B?RVUxbDh5SWNWUUw2a3NRN1hvdGFFL2xVUXVSbXpaREZUL3dmQjJKOUZGUFlS?=
 =?utf-8?B?MDFONmhKTUtaK2dSR3lrTG9EUml5ZFVCZU9PekwyMnhLSDdJaVkyS0dhT3ly?=
 =?utf-8?B?TVdYUGFEaWxUOTU4bktWcGwydVFHci9jQncwNHA2ODU3ckxsajhXWnNPTUp4?=
 =?utf-8?B?ZmwxZXhNTVJ4U0RPR2VGU29UclBqRUdPS1I1UldoVW4rOHFNc0JDL1ZvczBN?=
 =?utf-8?B?b2lQTXhiUlpUd2sySmVEWlJod25mY3Z2d3NkL3ZNeEQ2QkNLMVk4UnMvcWNH?=
 =?utf-8?B?UXZFWDJTR25vNGx0TDAwbm5HakV6emdLNDVEaG53NEZMcGhMNUQ4QXNTdlU5?=
 =?utf-8?B?aU14VUFVQ3FnMmk1aWF0U1pLUEZIck40QVRlWXBvUi9WVEoySzdwOEdMVEMw?=
 =?utf-8?B?bUZobGQrY1NIYVg1NXZ4Z1IyeGNhbGtYV1pkZ0JQTWQ5MCtibjFhSXFtd0Rj?=
 =?utf-8?B?bFlsL0U4TzRkbGFna2lZWlNqMmF1NmdOK3hLakJrNmxOK0hWUGJNeVZ3NlRZ?=
 =?utf-8?B?SEo5MnIzRlV6Q2pleGVGeGZwOG1XOUlzOUY3R1lUNmpQS0lrSER5UTVGd0hB?=
 =?utf-8?B?RWpTN1MyaUlNT3lRRFZnNk9jbmZDdVZ4c1d3c3ZSdzdVbkxnT0l4c1lKU1A1?=
 =?utf-8?B?UTBhcGVtWXA3WnZ3c1lYNzF0dTAvKzZOeTdvWUhFK1U3eU0xRHpMblFvRHpK?=
 =?utf-8?B?QnhiWjFpNUpmYk55NENkZkVwaGNOU2hGaGRZUnc2RVgwUHRjR2IyTUdEWC80?=
 =?utf-8?B?MXFNZ2RUcUJsbnZFRFExTjNqbFlxdkQ2VFFTc0tkT2Y3eEhSN1AvWGpyQUg4?=
 =?utf-8?B?VVptZm9rMUdiSkdNeDlsZm9BZjhkKzI1NGJPY1VYRFg0Wk9jWU0wYTBYbXRk?=
 =?utf-8?B?TGxnSUhaWkgvUXRNQTRqZkRWekZZdmUyMkd2bEZCaERBTXRJRUh1MWl6eWw5?=
 =?utf-8?B?YVpYcm5yT3FrOVBHNm81T0dEOWFJcVdXWHNkMjVmY2dSUUJuaWxUbURrSllj?=
 =?utf-8?B?R2tLOC9ub1BuejZrK0JYSS9MemVlQUp2MWdKN1RIT1JhcXVoQmh3YlhaeVcw?=
 =?utf-8?B?emtKYXRGUzQrOFRSMHpGQ0I4TmtYRUljUGhuTEp2eElwazNIUjExK0tYOTlr?=
 =?utf-8?B?L2RCTGFscWZuUnJJNW1XQ3VFeG9JNUdiRUZhbWJXMERBYllycXlINFNHdVlG?=
 =?utf-8?B?aDhvMTdWckdIUFlBOC90NDdDQU1ZZms1anBkOGVYdGxFbFJ4RXNQazVWT2xX?=
 =?utf-8?B?OFZ5ZG5yV04wbnNwMG5ZenNUSTExUU5BZnZVNkg4bWp0UnBkZjBZRjNXeE8y?=
 =?utf-8?B?MlVqT0I3MnhnK25mUytoOHVuRkF5VkppOWwrR29RQ0N4dXJGZHlBRWo2MG1n?=
 =?utf-8?B?aFNlWHJ4RE1EL0RpNmtKcUNyanRxMzVmeXM3OGpuUGNPb0JMWXRqR1VDdjdT?=
 =?utf-8?B?Nkx3eFVLSllKTElwN2NmTlF6bDZ3cEQxb0tXNHB3UzRZdlY4bERGNlBZM3kz?=
 =?utf-8?B?Y09BMmxkWnkwekNwazNGQXN4bGoxLzY2OXhweXUrRjNVL0NTVVVWQVJNc2p6?=
 =?utf-8?B?MlpGODhnbmg5VGJtWVdNZXl5MjgrUXhITmlUSnF2K0xmOFZmQWovNjd3RXhF?=
 =?utf-8?B?QVR4WnF3ZDhQeEw1SWMwMVJJU3RqYmdaU0h0WGRIa2tXSlU0ZGZ0ZUgzZnpU?=
 =?utf-8?B?UVd2TWNwUUtkYkNsWlhGRWdiUXZsY251T00rOThKNlYyRXRQSkFqWHRXeXpj?=
 =?utf-8?B?MVpBNS9sWllTNm9rVGFWZ2UvSUljVEVkV0pPbWxrblpaeWgwUkpqZkp2d1Q1?=
 =?utf-8?B?cDlVajBQSUgxN0RuRjJhWFdod3ptM0dwWnJ4aEhIQjNPbW5yRmlEK0ZjNkhV?=
 =?utf-8?B?MXdlNDV1dTFHQTA0VDZlN0RqcGFSVi9uN0l3TUY0VEtmek1NbFBaY2Z4NGZn?=
 =?utf-8?B?d3dkdVR4RzVaa0VzZWwycDRhUGg0YWVtMGk3eUNMcnUzK2dtc1ZXK3BVMmpS?=
 =?utf-8?B?eDFpbzc3TkdMRUsvTHRONnQ4eE56bmJqZ0R5RzZNRjZNc3V1bCtLcG1pMnMr?=
 =?utf-8?B?bk1nQ0RNRzMvTFUrY0F0ck5CMmZYS2tGMFFlRENLSU1zMGF3c3llQTF2QUxS?=
 =?utf-8?Q?Fu5eifZBp+kaT7e7BBHtpz0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49c2e20-656d-4a1c-e367-08da8fe6a83d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7097.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 09:03:25.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzcTfxF2GxQ1K7fULcI/hRpC5sFyKvd5sdJtrM81Haa/n1vuFTOyHxOBSRrLDKWrNZ7XrcTWUJZBukYP5lFk/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4153
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.22 10:29, Corentin Labbe wrote:
> The CH348 is an USB octo port serial adapter.
> This patch adds support for it.

Hi,

thanks for the driver. Unfortunately there are a few issues.
Comments inline.

	Regards
		Oliver

> +
> +#define CH348_CTO_D	0x01
> +#define CH348_CTO_R	0x02
> +
> +#define CH348_CTI_C	0x10
> +#define CH348_CTI_DSR	0x20
> +#define CH348_CTI_R	0x40
> +#define CH348_CTI_DCD	0x80
> +
> +#define CH348_LO	0x02
> +#define CH348_LP	0x04
> +#define CH348_LF	0x08
> +#define CH348_LB	0x10
> +
> +#define CMD_W_R		0xC0
> +#define CMD_W_BR	0x80
> +
> +#define CMD_WB_E	0x90
> +#define CMD_RB_E	0xC0
> +
> +#define M_NOR		0x00
> +#define M_HF		0x03
> +
> +#define R_MOD		0x97
> +#define R_IO_D		0x98
> +#define R_IO_O		0x99
> +#define R_IO_I		0x9b
> +#define R_TM_O		0x9c
> +#define R_INIT		0xa1
> +
> +#define R_C1		0x01
> +#define R_C2		0x02
> +#define R_C4		0x04
> +#define R_C5		0x06
> +
> +#define R_II_B1		0x06
> +#define R_II_B2		0x02
> +#define R_II_B3		0x00
> +
> +#define CH348_RX_PORTNUM_OFF		0
> +#define CH348_RX_LENGTH_OFF		1
> +#define CH348_RX_DATA_OFF		2
> +
> +#define CH348_RX_PORT_CHUNK_LENGTH	32
> +#define CH348_RX_PORT_MAX_LENGTH	30
> +
> +#define CH348_TX_PORTNUM_OFF		0
> +#define CH348_TX_LENGTH0_OFF		1
> +#define CH348_TX_LENGTH1_OFF		2
> +#define CH348_TX_DATA_OFF		3

This is, well, horrible. If the device uses a defined package
to transmit data to and from the host, please define a data
structure for it.
An array of u8 and offsets defined as preprocessor constants
is not the clean way to do this.


> +/* Some values came from vendor tree, and we have no meaning for them, this
> + * function simply use them.
> + */
> +static int ch348_do_magic(struct ch348 *ch348, int portnum, u8 action, u8 reg, u8 control)
> +{
> +	int ret = 0, len;
> +	u8 *buffer;

This should probably also be a defined data structure.

> +static void ch348_process_read_urb(struct urb *urb)
> +{
> +	struct usb_serial_port *port = urb->context;
> +	struct ch348 *ch348 = usb_get_serial_data(port->serial);
> +	u8 *buffer = urb->transfer_buffer, *end;
> +	unsigned int portnum, usblen;
> +
> +	if (!urb->actual_length) {
> +		dev_warn(&port->dev, "%s:%d empty rx buffer\n", __func__, __LINE__);
> +		return;
> +	}
> +
> +	end = buffer + urb->actual_length;
> +
> +	for (; buffer < end; buffer += CH348_RX_PORT_CHUNK_LENGTH) {

What happens if you get a partial chunk?

> +		portnum = buffer[CH348_RX_PORTNUM_OFF];
> +		if (portnum >= CH348_MAXPORT) {
> +			dev_warn(&port->dev, "%s:%d invalid port %d\n",
> +				 __func__, __LINE__, portnum);
> +			break;
> +		}
> +
> +		usblen = buffer[CH348_RX_LENGTH_OFF];
> +		if (usblen > 30) {
> +			dev_warn(&port->dev, "%s:%d invalid length %d for port %d\n",
> +				 __func__, __LINE__, usblen, portnum);
> +			break;
> +		}
> +
> +		port = ch348->ttyport[portnum].port;
> +		tty_insert_flip_string(&port->port, &buffer[CH348_RX_DATA_OFF], usblen);
> +		tty_flip_buffer_push(&port->port);
> +		port->icount.rx += usblen;
> +		usb_serial_debug_data(&port->dev, __func__, usblen, &buffer[CH348_RX_DATA_OFF]);
> +	}
> +}
> +
> +static int ch348_prepare_write_buffer(struct usb_serial_port *port, void *dest, size_t size)
> +{
> +	u8 *buf = dest;
> +	int count;
> +
> +	count = kfifo_out_locked(&port->write_fifo, buf + CH348_TX_DATA_OFF,
> +				 size - CH348_TX_DATA_OFF,
> +				 &port->lock);
> +
> +	buf[CH348_TX_PORTNUM_OFF] = port->port_number;
> +	buf[CH348_TX_LENGTH0_OFF] = count;
> +	buf[CH348_TX_LENGTH1_OFF] = count >> 8;

We have macros for this conversion.
> +static void ch348_status_read_bulk_callback(struct urb *urb)
> +{
> +	struct ch348 *ch348 = urb->context;
> +	u8 *data = urb->transfer_buffer;
> +	unsigned int len = urb->actual_length;
> +	int ret;
> +
> +	switch (urb->status) {
> +	case 0:
> +		/* success */
> +		break;
> +	case -ECONNRESET:
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +		/* this urb is terminated, clean up */
> +		dev_dbg(&ch348->udev->dev, "%s - urb shutting down: %d\n",
> +			__func__, urb->status);
> +		return;
> +	default:
> +		dev_dbg(&ch348->udev->dev, "%s - nonzero urb status: %d\n",
> +			__func__, urb->status);
> +		goto exit;
> +	}
> +
> +	usb_serial_debug_data(&ch348->udev->dev, __func__, len, data);
> +	ch348_update_status(ch348, data, len);
> +
> +exit:
> +	ret = usb_submit_urb(urb, GFP_ATOMIC);
> +	if (ret && urb->status == 0) {

Why check urb->status?
> +		dev_err(&ch348->udev->dev, "%s - usb_submit_urb failed: %d\n",
> +			__func__, ret);
> +	}
> +}
> +
> +static int ch348_allocate_status_read(struct ch348 *ch348, struct usb_endpoint_descriptor *epd)
> +{
> +	int buffer_size = usb_endpoint_maxp(epd);
> +
> +	ch348->status_read_urb = usb_alloc_urb(0, GFP_KERNEL);
> +	if (!ch348->status_read_urb)
> +		return -ENOMEM;
> +	ch348->status_read_buffer = kmalloc(buffer_size, GFP_KERNEL);
> +	if (!ch348->status_read_buffer)
> +		return -ENOMEM;
> +
> +	usb_fill_bulk_urb(ch348->status_read_urb, ch348->udev,
> +			  ch348->statusrx_endpoint, ch348->status_read_buffer,
> +			  buffer_size, ch348_status_read_bulk_callback, ch348);
> +
> +	return 0;
> +}
> +
> +static void ch348_release(struct usb_serial *serial)
> +{
> +	struct ch348 *ch348 = usb_get_serial_data(serial);
> +
> +	usb_kill_urb(ch348->status_read_urb);
> +	usb_free_urb(ch348->status_read_urb);
> +}
> +
> +static int ch348_probe(struct usb_serial *serial, const struct usb_device_id *id)
> +{
> +	struct usb_interface *data_interface;
> +	struct usb_endpoint_descriptor *epcmdwrite = NULL;
> +	struct usb_endpoint_descriptor *epstatusread = NULL;
> +	struct usb_endpoint_descriptor *epread = NULL;
> +	struct usb_endpoint_descriptor *epwrite = NULL;
> +	struct usb_device *usb_dev = serial->dev;
> +	struct ch348 *ch348;
> +	int ret;
> +
> +	data_interface = usb_ifnum_to_if(usb_dev, 0);
> +
> +	epread = &data_interface->cur_altsetting->endpoint[0].desc;
> +	epwrite = &data_interface->cur_altsetting->endpoint[1].desc;
> +	epstatusread = &data_interface->cur_altsetting->endpoint[2].desc;
> +	epcmdwrite = &data_interface->cur_altsetting->endpoint[3].desc;

Please check that these endpoints exist.
> +
> +	ch348 = devm_kzalloc(&serial->dev->dev, sizeof(*ch348), GFP_KERNEL);
> +	if (!ch348)
> +		return -ENOMEM;
> +
> +	usb_set_serial_data(serial, ch348);
> +
> +	ch348->readsize = usb_endpoint_maxp(epread);
> +	ch348->writesize = usb_endpoint_maxp(epwrite);
> +	ch348->udev = serial->dev;
> +
> +	spin_lock_init(&ch348->status_lock);
> +
> +	ch348->rx_endpoint = usb_rcvbulkpipe(usb_dev, epread->bEndpointAddress);
> +	ch348->tx_endpoint = usb_sndbulkpipe(usb_dev, epwrite->bEndpointAddress);
> +	ch348->cmdtx_endpoint = usb_sndbulkpipe(usb_dev, epcmdwrite->bEndpointAddress);
> +	ch348->statusrx_endpoint = usb_rcvbulkpipe(usb_dev, epstatusread->bEndpointAddress);
> +
> +	ret = ch348_allocate_status_read(ch348, epstatusread);
> +	if (ret)
> +		return ret;

This leaks an URB in the error case. Either fix it up here or in
ch348_allocate_status_read().

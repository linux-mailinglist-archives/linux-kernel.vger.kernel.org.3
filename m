Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE19F566193
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 04:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiGECz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 22:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGECz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 22:55:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2096.outbound.protection.outlook.com [40.107.94.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93454CC3;
        Mon,  4 Jul 2022 19:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXHWKZeoGmDZ9/4N6vN3s/NEwPDeu0TqfFBBWciyXhz6p5K41NRUnw8zuzk/rMmYqUZzndP/4wcyaZBHTFo8SeDEVMvaC5HO+HdZn8zReSuxc2UE+Bo2+UKBEq29kO4zUe2lj7Bsn+vxM/nBhP/mxHQ7mYTi9xWiHudenC51XJmrBLBKb85UHRgFXOPxcjAFY4pSx3KXWykY8QTPYX9PWuL9/mWF0D0Q+rLbRQh1UewDPnooXwNz8MmbDoIq57jW1ldHOkh05Ea0aDSn1vjftTXvNQcIJ+ZOqo6t8nrYKYWQ8SL/VwlFMCov1hkhH3cpR99hKCAcieCg2J8lwTTrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sOzuqaH+je2bqFfremeQBOXwi7zn+jtsviQPlWWeyY=;
 b=n8Dkz8FDRjKaALiPH8G1YlfOwdHQlImL2WZPNypVJJGgcyZy+Gg0x+qdeVTXemmRgmntJxKyKhvnRUFr1kuaXkeoG/GoFcscoJCfqUtLXOF4SSZlzNbzPXwLE0fFRR08nspPg61fftJhCT157Mj1nbWN8HvUUYg5UEU3PpZNyGSW1PIFUca3mb1jEAbOPuPc2ysyjNQuVswerMqPJFcWyD+X4ynA9DWo5bYWxv5WTNJLkLXDQIG1uv/K1/9bg6Gdjna/UwJZSgnGDD/GswvzmBAXAAjagliS+prVP3OQAWfbergvD/cHvs+r+KCq/k7r1/mtKCPZAnW+SE0mI393dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sOzuqaH+je2bqFfremeQBOXwi7zn+jtsviQPlWWeyY=;
 b=kCC/GywarPFKumUsZ1sU/fr9qjisiXNzKV3ksaYBZRcPEA7cIrZssjr7G1chvc8uWHQjR8SwJohEMTMgYM4H+VRTIpZ0EBH2IeHJyOYFHXchNcdK4vr26uTQZ4ElHuqo7y6BcCYSrgI2qvGTxX9QRo3P9Taz9AURbPA4j3A4Mj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM6PR04MB4137.namprd04.prod.outlook.com (2603:10b6:5:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Tue, 5 Jul
 2022 02:55:56 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::ec96:5112:c2d5:9377%8]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 02:55:56 +0000
Date:   Tue, 5 Jul 2022 10:55:50 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v12 3/3] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220705025550.GC2303286@anxtwsw-Precision-3640-Tower>
References: <20220628044843.2257885-1-xji@analogixsemi.com>
 <20220628044843.2257885-3-xji@analogixsemi.com>
 <Yrqe/3Mpnmw4sfyx@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrqe/3Mpnmw4sfyx@kroah.com>
X-ClientProxiedBy: TYCPR01CA0145.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::18) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 540f31a8-cc81-459d-1494-08da5e31e199
X-MS-TrafficTypeDiagnostic: DM6PR04MB4137:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzVTPzBrbEcSzR7dNQBs2RSEYwEVbz1h54ptElB3qSseMAkkinvJ8FqAfcPlaMvaAR1LJoc/El9ccuFhcMmtXzKKLuARYOxhfacUFA2OxDfjm69UGTVg0IjPsXQmRv2DxtT36yF1z24bjbbbst3WMra7hjtYgVjd+BcCQ+iw9HvlDpFudoSz1v1+av3RCfdEvWtKLiXrAMi+MVk+nGQQqiqaSROK17o27yJhD9z62NmxBiygz5BxjJXKcMYmmSrdUFY/Djka/Y03WPUtu7SojcBLZrTECYw8zgkQSi9vdFoq8HWvKJxeahioup3xwhQHMeN2kbPqmXoRFCfwlFsDvN7jPfm+jJzTS5KC04q/6QEHoyVbWrBliw11+HeGHspLAkS7ZruZKzyfiU+GWTo2WlCRNfhpSvg3mdNAO7QZW1sYmzELhqKhLqFVWBF9qqlTVVy7i2bqy+nSAnIOJ3yJF2NRPVj70yA0OU2G5a1CoJCfsdVL4iWxRESEfD+PRptTY6Eiv97ZEp7G/5EO6o+Rwj/VAtN55sqL9WMN1GBtSkIxMPICa8Z4wIjF94rW4w1tiYOC735FW49rqjlIOy7TnbnhjPIGRF5EmeKvzbU8W2u6WFXnbs+jQuFItd6BgN3H8xDiBwnrPl3M65zRHFvpdwx4eoomG0X/vvUJgOkPTr4qgjyfDahSuhj/UDdaonTQ5f0JcsHfbOX480Do9lmK82S8c6erGACJ+7l4UFp5V99RZHFUr4uUqYTihPfPdtxc84Uva66kseBOO8lsSnanAfGWNtCBKgrAFGyHvmxmeic33/lda0ifF2UxysthpnCT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39840400004)(366004)(136003)(346002)(376002)(396003)(38100700002)(33656002)(66946007)(4326008)(66476007)(316002)(478600001)(8676002)(6486002)(38350700002)(66556008)(6512007)(55236004)(26005)(9686003)(6916009)(52116002)(33716001)(6666004)(8936002)(41300700001)(83380400001)(6506007)(5660300002)(2906002)(1076003)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfDwJlEuzqsqpM06eGy+aqCHYS0/QqjOyaWlkHloqQseVCnzCFWAsJVmGOqY?=
 =?us-ascii?Q?2617Myx1OS3YcqeALDkTMLXZWkZMulnXus5kX5HdGUhwMC9WJkm+01Ko1zjv?=
 =?us-ascii?Q?ONmkN9WuD0pitCHF+keS/PcJCZ6ZMw2u9b5cnFZ/xMAETJKrt10d5ZPtYvyb?=
 =?us-ascii?Q?LG3i9wvB9O/Bh+0Zv/YG/jxAq2WrrC2oLIhyHr/jtskY13naASsL8DIneV0U?=
 =?us-ascii?Q?Y3445qsFKe61YLvFDzQRlDtUXrkLBg/TFEDGW7EkqDIljlodwzL09RGPj1LH?=
 =?us-ascii?Q?JQK3jDBraKrkM3bXdFTmXVMozFpmeurNaoQyq0Cx/NSiO0fsPDhdpO9u14s6?=
 =?us-ascii?Q?/oKAakJ8o9jL9tc1sMrxz7joyZdNXl7pknF8jn/1iU5f5zB0vHsdjELcSboO?=
 =?us-ascii?Q?69lH3Nk/+1tux5EGrpyB/AF4PL4/HcFV7PiRAAT6t/tohzBVhDstG2flTEue?=
 =?us-ascii?Q?WdzQOkjfjhZpye9LpOXtnpd86j1WHSQ1gv5YvCxtrSSO6Vv/7PYeCpuw+/9L?=
 =?us-ascii?Q?Xdsp/cpP04qWn1VpxWnd8CH26JttCSTybbPwppmDAXYXpQf9LPNFxx5tuXW9?=
 =?us-ascii?Q?JGYZMytXLY1Nkm/FVVGn178lDGY86PxMB8WRNktlTht06DummqTHcDbl8f8M?=
 =?us-ascii?Q?1xvZAJ51KCQEu9WalUFO/CBEYr5rjUGbqBu74a5MIfjpMkafFu53WRZbQ4Du?=
 =?us-ascii?Q?EnT9+oc+jtBm/mlwauf7I1DuMSGlokzlTMqoqcb+kMVl86wiOByS+1bVvZFx?=
 =?us-ascii?Q?CD16/jjmsZei4xmiabEl5/CLRNGSPKp6GJQmr/Bpl6nEnR2n/OxQmy3y1ckG?=
 =?us-ascii?Q?GojmB5xCrzVme5IAMCJYaKZhAk5Q8lJDDI/58pkoXSEBx+20sq4/wUQ6vrTt?=
 =?us-ascii?Q?JGJhpo0nxHbWRW4vpmsA580kngbLZLslXI5331s6HACPhXg9t1gKMR6jRqmk?=
 =?us-ascii?Q?kmyeUsOeIpvKRBZ5rLOFwN+GIA4HTkgUGUke0Vlhr6h2fshPZpPYBVEjN/si?=
 =?us-ascii?Q?n5Wx8BrZyJPsrVdQ54A3abRlpboORsFpBlKKsTk9whsOYvIQipPyrFrOCj2c?=
 =?us-ascii?Q?xCRX+sW+Eq6pmDLgMnhBorCvPASMe63IvgNPIVRLzLS7jUaJuoIplXVKDf1F?=
 =?us-ascii?Q?Q5fbPeaYgcW7oIqvLTk0i4jXz2N0xjBTpD9NJNgcD7zqszcQeNusNSvQyC2k?=
 =?us-ascii?Q?df7UxrybURzOQv3lTynlJEpPEAA2xx6hMdTLDIjse/idzNnEwyMuOFcvJPqT?=
 =?us-ascii?Q?kDP0aH/i1Ntstk0cZAZio3J0hEWFQeFJosuHt7a7zuxWniRgokeTFAAa+r4t?=
 =?us-ascii?Q?gnKWuLh0ZmTQ8Qmws4ji1o7AHCTqsYQ3jrFtiJH2G8JNlL2ey1YVsmWSxeVv?=
 =?us-ascii?Q?2zj3klR3o7xG9+DoqKwIwHJBZJBBtpi/iaXIpGcCBwOOC1iWBJWwzeg9nERb?=
 =?us-ascii?Q?GABkcNa1HESWVgDiZYvFEDtzSnkud5IhKMMEUJyUVDalwQ7LhwMxdrjRjZ9i?=
 =?us-ascii?Q?/NeIbJasE0+CMHnpo8d8YYRH1Jmj5cqK7nTJTNp/q7q4P4NjZ1FwwWkDNXwO?=
 =?us-ascii?Q?lQr6KJBymQjXmV+O88a368uCRdkxJcO6yMd5z6Rd?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540f31a8-cc81-459d-1494-08da5e31e199
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 02:55:55.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2lBpJtV2PMqbLwLGLv7CUCodNBGlCd0BPNI2ti19hSirL40JPTOMxHfjt8ZJiBKSzievNE7DueBd0dfzNtWMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4137
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi greg k-h, I'll add return value checking.
Thanks,
Xin

On Tue, Jun 28, 2022 at 08:26:07AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 28, 2022 at 12:48:42PM +0800, Xin Ji wrote:
> > +static int anx7411_process_cmd(struct anx7411_data *ctx)
> > +{
> > +	struct device *dev = &ctx->spi_client->dev;
> > +	struct fw_msg *msg = &ctx->recv_msg;
> > +	u8 len;
> > +	u8 crc;
> > +	int ret;
> > +
> > +	/* Read message from firmware */
> > +	ret = anx7411_reg_block_read(ctx->spi_client, CMD_RECV_BUF,
> > +				     MSG_LEN, (u8 *)msg);
> > +	if (ret < 0)
> > +		return 0;
> > +
> > +	if (!msg->msg_len)
> > +		return 0;
> > +
> > +	anx7411_reg_write(ctx->spi_client, CMD_RECV_BUF, 0);
> 
> Again, you are not checking the return value here.  What happens if this
> failed?
> 
> > +
> > +	len = msg->msg_len & MSG_LEN_MASK;
> > +	crc = checksum(dev, (u8 *)msg, len + HEADER_LEN);
> > +	if (crc) {
> > +		dev_err(dev, "message error crc(0x%.02x)\n", crc);
> > +		return -ERANGE;
> > +	}
> > +
> > +	return anx7411_parse_cmd(ctx, msg->msg_type, msg->buf, len - 1);
> > +}
> > +
> > +static void anx7411_translate_payload(struct device *dev, __le32 *payload,
> > +				      u32 *pdo, int nr, const char *type)
> > +{
> > +	int i;
> > +
> > +	if (nr > PDO_MAX_OBJECTS) {
> > +		dev_err(dev, "nr(%d) exceed PDO_MAX_OBJECTS(%d)\n",
> > +			nr, PDO_MAX_OBJECTS);
> > +
> > +		return;
> > +	}
> > +
> > +	for (i = 0; i < nr; i++)
> > +		payload[i] = cpu_to_le32(pdo[i]);
> > +}
> > +
> > +static void anx7411_config(struct anx7411_data *ctx)
> > +{
> > +	struct device *dev = &ctx->spi_client->dev;
> > +	struct typec_params *typecp = &ctx->typec;
> > +	__le32 payload[PDO_MAX_OBJECTS];
> > +
> > +	/* Config PD FW work under PD 2.0 */
> > +	anx7411_reg_write(ctx->spi_client, PD_REV_INIT, PD_REV20);
> > +	anx7411_reg_write(ctx->tcpc_client, FW_CTRL_0,
> > +			  UNSTRUCT_VDM_EN | DELAY_200MS |
> > +			  VSAFE1 | FRS_EN);
> > +	anx7411_reg_write(ctx->spi_client, FW_CTRL_1,
> > +			  AUTO_PD_EN | FORCE_SEND_RDO);
> 
> Same with all of these, what happens if this fails?
> 
> thanks,
> 
> greg k-h

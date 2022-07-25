Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C366957FC1F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiGYJPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiGYJPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:15:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D34646B;
        Mon, 25 Jul 2022 02:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuwscjruDCE1R3pYS789pwjIpJ1hcaDeDEGGGv7Z/hW+rlhIT/ur5gR0nSNmguFOBzScGoLj/iTy88IrJOriIQCu865i28ebt9w/iu43aO4n3BlIh+RftyyvEwDjOe5SmNezOW1WWUo+ygobJD5mFZCMUQj/xfTM/mCquii7l0uXB8n2KvqjE6HcczQ+Sa2L1OfhplG+rEj5/Y1d5vbJBTojE9OyNKWU49EghhltANXqGWqEz6LW8H0tH5RzHp9PIflb1p2bfljn3dBdMSjvNIhwVFSmNeBZjb51CaU3BHv0/Bo9FA/QDdEjoDZM+jEqm2k2wNQHzsVWguPUQoXUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpyRLom3UBYZlCGAb/GgMSpaj4noxODQ3Q3uzj/spQM=;
 b=EB0y9TGZ916hjhvq+cHU/j/xLQyVQDOAVsD0oU2WBkMBj60YGlWrCe4BgSwAA18GKtVokLrCMA1qdQsAnJxZNWtE9kN+XJJcFKryjvFw5GPm/eYexLwtupUkTWuslxM/wje4l1QcWl8+yUZrO7T2j+sqCkUJ6/klJy0UWKyJkz+2BVGC7pUB8/ujaRwBgT6WRn71XHdQZaSpgHXyc/RwZGFQydNuONkvgE3YOxcKavhlCnylEIwy+yB90sElbB3IKjorpDKjwDdcwJ3frvmcB05d6J1lGbqN/BXl+AsQ6/fntFbuizPVU5JoE+hdFdNZuQK87MB9t1wLLtvoCs5Fbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpyRLom3UBYZlCGAb/GgMSpaj4noxODQ3Q3uzj/spQM=;
 b=a+YBUuBdKhmADdPUenjsYTA6GmcPK7wiMn+u+3jn1qrT2POQS14dILQ6vdm1dxtAOUEy64Srq1Jtd27enziTQim/E5Ua6BLhvBsqQDybIwX0wQXP8iIcxpMRGUjrtJ6xRZhDVHJifDYxEp3mjM07x+x6lQv2LktrlWZRjTNKm/TDPydlTImE6NuJ46HNB6e5pbZS+IN1aFHDOWBD6DkhSNT0eD2o3kRF0zsKM7eRjj7hqTMCDH5zYdzT/dwf6hikaxjjMuXeER6HiAa5Ha3JIaxQQr9mlUYjXQs0H3Ou5mTrUhfitpLnON+dI+OUZ39nIE77ZxC25Lj5TPdixG71cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by AS1PR04MB9382.eurprd04.prod.outlook.com
 (2603:10a6:20b:4da::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 09:15:28 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5458.024; Mon, 25 Jul
 2022 09:15:28 +0000
Message-ID: <5a1ce1ea-2370-310b-e224-0b020a1139ad@suse.com>
Date:   Mon, 25 Jul 2022 11:15:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/7] USB: cdc: add control-signal defines
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Yan Xinyu <sdlyyxy@bupt.edu.cn>, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220725075841.1187-1-johan@kernel.org>
 <20220725075841.1187-2-johan@kernel.org>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220725075841.1187-2-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20f4a198-0ca8-40f8-531b-08da6e1e3737
X-MS-TrafficTypeDiagnostic: AS1PR04MB9382:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiBBVnvdsqDx4AZCyZMT8F8k5xE/pKn1Qnf+rSsH5aAIKN8jrgXKCQ30mObmj+MliJFsVOeimn++jhfrLR1PZaLk3gzSEzF0xzj/x82a53bKxLBUz/OMJ8lbHS2Bun/JfcUDR/ADah8q4NmcT+fa5GS0FMUaeasqDbrJn/n1u66Ro/z4gZHTS8HVcO7IpIsWnknGcJqCKAh26Zosq5vF3USTxizqMLvgB4rscKEgx3nwHBBy9NTlkcJyvDRW/9GZ/3Y7da/yv0ml8ZatvjS7GfRv2fdwXjIL66z1Ye3Q69xB4H9c7cz6obSAKugkd49cWYa1qZ/0TyfoqqDf0zPBhvuxMaUl8aloWgxBq1ssh+rk+OoW/jp+bECMh+jZyUhlmMb5TiSLzCqCDLcK0Tkk3iBpmeuQhmoEabxVWiM1ewqqk/G/YwWpqOI7C26F0xIdEYL4Fs5LgO08Of14/4KtwQZPk5RAJVxMChh0w30Ii96NxLyRf51+hHvR6XOG4l1aXDrje0UWlZlsl+q8syX1iE1tsc8JkGNFJ9IU7GVwzg75BGdE1NtoVkMuv5pB2wXW8zXqVa9lTDT93ty1O+UjoBGMmP5OXaFkNieHhj6ZlwFDFFvv+koAEtZPaLdQ+jfgbAlT5wUQCr6wz2dZvVBfJTpv2OQhWa3/2HFUo6eYkVcd81C7EUiSSMAKHbhwX/wtvNmcSEJh0HsCP/l/jW1oN+JYr7wj5ST8Uty987+oVlrRdWhDfT1JCNRF7ybCoW2M05nXlBjRpTiYTE9cyExlT7HOL+yDI4UO7GEkvON6mEMmYUCRS9s+QERDPNSiy9YWKvw49P+WQ2+aBOoX9CK3EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(366004)(396003)(346002)(66556008)(4326008)(66946007)(66476007)(8676002)(110136005)(6486002)(38100700002)(478600001)(6512007)(53546011)(316002)(558084003)(31696002)(86362001)(41300700001)(2906002)(6666004)(6506007)(8936002)(36756003)(186003)(31686004)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDZwaXliVVpHNms3cjd0ZEs5NURUTnlBRyt0a05XbGpjdmpMdGlPb0V4Y2hD?=
 =?utf-8?B?WUQ4Z3Z4aTVEZytYVWZ5aC91UThFcWFyMUNGYm5paU1selRTQWFERHJGUW8z?=
 =?utf-8?B?UnFhVzNhU0ZGZTd6QVdrTDV1MnJJcjM5TEdHWGZ4SFY0YXcvenNiOHAxQkNZ?=
 =?utf-8?B?MHgwTUxsNFR2U1RETlowd2Z0aTFSSWZkQk8wU1FJWDdPS1p4S3dIQkRtcmNB?=
 =?utf-8?B?OFhRTUxVbVhrSlhYMksxTitjSlUxWmMzTURGblk3T3oyTlVVWTM0ZTNvT0w4?=
 =?utf-8?B?MW9HT0krK2VITm51RkFJeGxOVjBhRnRCYmdwOVNGVkZtdkVEcGlBT3h3VDdw?=
 =?utf-8?B?SkZHMHRrblRjbVFXVVV3SjZMcjliWmlDc0cybGpuS2NnVnNwZHhFaXJBdW9p?=
 =?utf-8?B?VDF6VXFTMXJPVk9ybzNtSVJTQ2pIcGpiNHNjVnBxSy90RzNPeVM0Z3ZaVDFj?=
 =?utf-8?B?d0x1a2tsak9uRU9RU0NwTjdPbExFS1JsR0QvS0JSOXFWVUh6TTB5VUxUWjdx?=
 =?utf-8?B?OENGaDVBKzJ0YnZacnpaRmMrYXBaaHdhbjlPa1dqUm5LYjBYT01rZDZVc3Er?=
 =?utf-8?B?dXNGcVJrNjlrZDVBRXJUUGVrVlFYNmhMYzJ6ZDI0RmdvZTBCK0h5R2V0elhE?=
 =?utf-8?B?TklNTG9XeW1UdDJtK0dnRE9nR2NXLzlOL0wzb09reVc1SkxSV21LTGtlZWxw?=
 =?utf-8?B?WkN1VHZsd1BzdWdUd3F3dHRSZ2F5emFkbCtqamRIMUZTUFZ6TWlhWUVwRlcy?=
 =?utf-8?B?YVY2R0crVGNkS2dvZURwemdZSTdsYUxZTklnT092dndIdDNPaXpUNjZscnc1?=
 =?utf-8?B?N3NMaEV3cmp0aUNSbHVFTHJPU1pSZVFkdXh6ZmxwQko1SEZQRHhtVW56Rk03?=
 =?utf-8?B?MEsyZjdFaURtOU5sOXVaSjdwWC9vQjhmcDh5VXlrMGVyREtuRFRpS3FETnky?=
 =?utf-8?B?OWlYZ1gyUFc2SXNLUHBJbnE4VDhwSUx2Skd4UmtKSFhDa1NDYlgzei9WZXVJ?=
 =?utf-8?B?eDlIQm1UZzFWSWhtK1lWY0FleGZjb2JUdUZYRGNOZDBtS3J5NkZvSWVGYXl5?=
 =?utf-8?B?U0l5U21LNXRkbjUrSCtDeXZwNFdRRFdOeG40YXVKN2VlL2pzWFIwOENuaFMv?=
 =?utf-8?B?RDFyRm0wRmtnei84c0w0bS80ZmpWMUJGL05GNS9EZGQzSzhEVjJ4MExqejRW?=
 =?utf-8?B?UVlLRElSOGVOejdkeE1YN2hvNGZyMGErcUZuaUNtL01yNVp5MHlwTFIxOWlI?=
 =?utf-8?B?dWpPV29zUldPTks5VkUyRGxiYkFjL29iZFZUUkxSRXlHdnJ0c2hSK3A5bU9U?=
 =?utf-8?B?N3ZzRnR6VzlhTU5kcGRxMmlhczZ6K0dUbm1zNnlGMjFKb3NBaFFHVFlCK0RE?=
 =?utf-8?B?eDl5dE5VSnNSMThEcnA3WjZ4UTN2SDJybnVIRU1XREoxbGxLV1pkQnNkV092?=
 =?utf-8?B?K2VuVmNjbU9LcHBaRTJTb3VuaWU1eEFIM08xN05WY25VRDNzYXJvMGFFQUZJ?=
 =?utf-8?B?c254Z3lZclh3clBDenVTSG9Ha3pkaHpaZElObW9QQVVndSswRUpNa3l3d3hD?=
 =?utf-8?B?b2hLRjAvNUtnSGcvL1FocWdHU2l5WTMvY1dHNFVLTHQyaGlmbDVGYjdKeWF2?=
 =?utf-8?B?dkdKSk0rbUN2MVdmMGRuNURzNnV0RE9hRXl5R2pjRnZrT0tEY2h3VXJzQndF?=
 =?utf-8?B?bW1FSTdSeXZFanJUOTRSRENKV0NVRGJtdnQ3aFdYQ1dPSTNiM044d1VoOEp6?=
 =?utf-8?B?cGtTU1JYb3ZzUCt0TlA4K2FGM2Z4VHowVW1ML2dWMk5rN2llY2lxVDkraUg4?=
 =?utf-8?B?aDNvN1JZcGhSa29SQ3VCeTNNdVBJaHVUWVNFS0s4dlZBdzZ0NXM0c0RPQmx6?=
 =?utf-8?B?OUVmdmtSS28rYWtDOE94ZnlHVUpyWXI0R0xkMHJmZWlvVXE2MFZGazlhVWZ3?=
 =?utf-8?B?VFVzdGwxdDIzVW5OTnlNTFFhWmxRTnlrb1N6bmxVUVBuZXBhblhwN3RKbTJ5?=
 =?utf-8?B?THRLaXE4NFo4SUtHbm1QaDJQZ0Ruc2ZpSFJPSGlpNWwzcHpTOFZlR3ZkdGpF?=
 =?utf-8?B?aTR5Qk11cG52THpkWEd6M2hKbUNITnRmS3lYakV5eVJjcE9BRVZIalVkODF6?=
 =?utf-8?B?VVIrV2hsdExtTlFsYmVSRjhxN1hSM1ZOZys5TnN0V3R2akhHTEdlZmd0dlEy?=
 =?utf-8?Q?At40KkBK0t2r5NLJDvWY9vm6jRTPN6TBambH3ZLrI9vo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f4a198-0ca8-40f8-531b-08da6e1e3737
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 09:15:28.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0q0I50Yd0XawBUcmlrnWYO/0El/N/t5vkoczebxdeLAvDT2iYAjLoGrEr+y5RrLVS4yRZKkQucl0O18sNuidA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.07.22 09:58, Johan Hovold wrote:
> Add defines for the Control Signal Bitmap Values from section 6.2.14
> SetControlLineState of the CDC specification version 1.1.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBA457C5A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiGUIAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGUIAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:00:48 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150043.outbound.protection.outlook.com [40.107.15.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87EC2126D;
        Thu, 21 Jul 2022 01:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kSyJbujQHJuyMW64SjphEbgjuWlxbDwOIFWyh3Q/TOAHpLAX9RLFaLbcGbKCw9gw0ExQPFilfXg57JMF8mMylvFcWB2WswzEReMQXqUhn0M1PmCzn7kboz1SNT+RRp7aUx7jqhidYHoWSo8/QX06uyL8oaCtOknwmIZCuemYUY1lEHCDUtUO/kayLfzloskIK71j2YHabARUhsuzft/bEwwvIFjrrL0bvHpksHQYs/2a81m96pCb1vjrBH4sd7y2S3vjP+gCD9dL+dW4RPhCiVxImED1z1mp4X0klrqeYhSJkQ0J82lS4AARwtTduJd97NuLmIDlk+edsxM1nmbEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YJbf5u3xkrz+2dJV2YKLpexyGMUcL9FqYbkEPU7FTw=;
 b=O6JHx8ElWJysUb94Sdwo00koLRdYKctDDY2XeFVRcqy62EijGFEoiL9+Ok/5jDaWK8Yxe7tQv5z+1Y9/CIqrIl0bmyt2/xQaZA5oOKfWbwhPB4Gq+H3WI7hBCtqataVVQFPpLMPQSklmavySAf1dqVFkb2cm5Sn4DNaoXgubVTgKV6RylXF5LfawHV7UxJ2zJ5kWmD+OwVQYx5WZqDcEnniguFf0x764lm3xNsYGdR3z+VGa7GBiPote8arzIE5p6tfqC0jCnKPUtEXwO+J5XXyTc81oAETS79ybir9gqSm4e9jWjrCVpDxbf5AiGyUhJLNX43oRVmJnMgAucI/5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YJbf5u3xkrz+2dJV2YKLpexyGMUcL9FqYbkEPU7FTw=;
 b=DoyOv6WaB1trUNRAmB0ksX1TqoFl+6cJ+USlr8VkwfyAooDhp6kJv1vzeTeFUYSgqO3VA+igdZdMV7XSF74UMNcLmfXDTxbC59c6lh6xWg4fagTDpRaw+b3sEBlszwJUkomT5/qPNvqCUXG9AAj8YtxHU0zgcbaWMXLNWDYnih3fjFKBfuPgd2CNyOAsed/t80bZbgpLCZSxoxz1Z1Z1iNM88y3GixW1hNa9cyQoQBbU8E252Dbkms2AnMsus8uVZGZDwB5G/c5SJhqPP+QdlvrrdknJIwCXAf8KsReqP+sFWbX2fGdSGE9GhjEEZC9e105IlDlZ9gJC+88sx5i16w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by AM0PR0402MB3713.eurprd04.prod.outlook.com
 (2603:10a6:208:d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Thu, 21 Jul
 2022 08:00:45 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5458.018; Thu, 21 Jul
 2022 08:00:45 +0000
Message-ID: <09fed539-909a-f274-1a73-428dc7439d69@suse.com>
Date:   Thu, 21 Jul 2022 10:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] USB: HCD: Fix URB giveback issue in tasklet function
Content-Language: en-US
To:     Weitao Wang <WeitaoWang-oc@zhaoxin.com>, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, kishon@ti.com, dianders@chromium.org,
        s.shtylyov@omp.ru, mka@chromium.org, ming.lei@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tonywwang@zhaoxin.com, weitaowang@zhaoxin.com,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com
References: <20220721060833.4173-1-WeitaoWang-oc@zhaoxin.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220721060833.4173-1-WeitaoWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ee4c98e-c469-44e8-89e1-08da6aef1d81
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3713:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eOG/A3tEbw1pkV+ahjtay02CYr/A/Idk4I7E0wmUalcWJhe3LBYgy1lg3FAHN/cjjgf3WJhQD3LhJ1svt1NSLU3PCnojqaFfHmQkW4HL93IELg4MrF7Nqz3i7RqvMFSRH1mRkAs907Q30vNZ0kZrsjAF0/KlSFQK5vnovwDQ9fgF4JOALf5Eqh3WX19fS/KGdDCwMI05PztWoydtFo4Cy8xlal4KSiKJDm1Qbadz8PDDwtGiUiJOItXm6kfkrPdJHeFZa0+MpaCMBlOfzBTuydoEE2F2GTvYTqDlEKc12ccWHQW8sXp28taUkqCKXRlMBXLn6rY2VwXgUsENInc2ARfEi+eo5coXCxkb6pZxEGPMQtejrSH42IrRqI+uo/lbIM3NQetjvZBSFWPcc/IINw5UVhXizoVDR5LHuZMT+RCQ7qGvGev4QL6iQ1SlU7DCSY7x9AxX2eGxK7ySoMNhTi398PwsCDQgpiWxH1Yt8INK/9IeQFsHRPpFutCQVxPc24LDiXiCIfABDDA7CvOLQeMJbpK4W27ICLB9cTbWMVk6CjeZNO95KyhgstcOyX7hCDnxqILf2FFFtAnaYP/2zCkK1YYMEDGcBWxqNWpTEch3cW8+wtCw8zdhRemUW6wNORosgjytNbOWgnA64lzrpKtJXXgDmfdjV+RQXKfAbRvyTcaZzxtnIM2X+3UTxLqml1vc+UvDcm++r3Wi6gwwv5aTrlJxLBYyrwyJvXyIPsMrlqKXSBJacVe7Z0OdLWza5zDu3fFiSFNMVfW/KrzZaVIV6WAmXYpgGtVUklyjXTunhhAUncW8dMFsciZXEq1hK/I3ZoNUDVHJuweQBml5yQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(346002)(39860400002)(376002)(5660300002)(7416002)(6506007)(4326008)(66476007)(8936002)(66556008)(66946007)(316002)(8676002)(83380400001)(2906002)(31686004)(86362001)(31696002)(38100700002)(921005)(478600001)(36756003)(6486002)(53546011)(2616005)(4744005)(6512007)(186003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGVTR1B0c0JCV0xVQUxpWXFoZlUvUzIwRUdoeUV1Ri9LRDMySkVaS3RGcTJo?=
 =?utf-8?B?eUsra0MwaG9hV0pPdmNCd1AwcURPMG1YcXF3Z08wOTZ5dG53TUFVT2Jtbkt6?=
 =?utf-8?B?NHdjUUVodW1sVDZtWVo5ZXVzSmpOa2oxNWhIRTZlMWZOVDNFZHVZMnZTakFw?=
 =?utf-8?B?cXZTQ05UZmhTOFdyV1h6eHFpTmw5WHdVOGNqR245Mlg3d0pMcHgvT1ViNHdS?=
 =?utf-8?B?MFBKRmR6N1FVZzQ5WmJSakNrMVA3cmlxVnFsZStEYkRWZkluMHRvSWJxbE1t?=
 =?utf-8?B?MkRnT3RFa0U1TDBqYXJzeE5la2liaFRuTU1nU2IwblcyK1RSb25RYzNFbU9R?=
 =?utf-8?B?dkhnRXpKSTdnYkwrQjFWeEYrTlcybVUzUExnTFZ1NjhLelZPdk90dU5ZeGtV?=
 =?utf-8?B?Y1VoenVtYWcxSzRxTGF1WkRXQ1lhUlBpSEoyU1BEVCs4dFZhY3ZIQkhoTFRK?=
 =?utf-8?B?N1JnTVFlR0NPUlJQeWU0ZmFibzN6cm5DU1dya0FocjBCTUJ1cXZWcWJTaCtH?=
 =?utf-8?B?dW1nVUtwbFk5blYzazdHN1FXQ2c5WWtqNE0vQWwxM285Nkt5TmhUcGRQZ2Rk?=
 =?utf-8?B?Z01hRk0rdnBLaVM4YlYyMk1nVDFuUlpQbUJpWWd3SlA4MGRwMy9wQVpZK3B3?=
 =?utf-8?B?aXlzeERzVVh2TVgvU3RHNGhqRVNmU2FxSk5qc2R3RzNYUGdURG1hQTlOWUdl?=
 =?utf-8?B?OGhXTkxxVnhCVFBKeS9uWk5pM1B4R2IyZDlIYlVOUnlEaDNHaVY2MnpMUUJR?=
 =?utf-8?B?QkNLYlRnaGZ4NlJrZnowSTFXUG9ISDFjVGZFTEdueFZGMzdYbXladU5FZXZl?=
 =?utf-8?B?Wno2Vis4cVc2Ui8rRk4rVWpqb1NPVnhNdUJPVDFnNk1DMFQ2L2NzZE5BQ1l0?=
 =?utf-8?B?U1JTWGpIZFdEWUN6dGp4QzVvbktBdmQ3bU51UjhTeGMxNEJDUWtmbnZ5SC9k?=
 =?utf-8?B?RkVtUmNsc0tBRnBDQ1UzaGxFenlYY1NDM3pHNC9NcVU4cnpJSDlacmh2dGMx?=
 =?utf-8?B?c1VNWVFSc2l4SFpNemkvQTFib2JBSmVaVmtMQnVhN2tVUDhpbENzaHU5TUVP?=
 =?utf-8?B?SkpPTmVMN2g3VW1hUE9iWlloaDE1d0ZqNkdscUdyQXJnUlFYTnQ4ZVlBY3NQ?=
 =?utf-8?B?bGlkVkFUS0hFc3lMSDVuNVZLTkxDRGtSNHFzN0UrUVBiamxJNUpFUERUbmhX?=
 =?utf-8?B?MVgxcDNQN2owVUdUWk52eE5RRU1JTG1mcFFXT1cxZDBZemwxTXJxeWRkdzM0?=
 =?utf-8?B?UkU4d29iQ2d0N3p0eXF1RmFEWWR5VVhnSkRPcTN5T1FHWHUwbzhCT0I5RkNp?=
 =?utf-8?B?YnZNeC9xWkNTQjJGYjRKTlRod1dPSkN3Wk4veE4vV2F1QzR5SkVVRkJXRXpG?=
 =?utf-8?B?TnlDdnAyR0JXMEUxVUMvRGxtcTZ1aHg3K1lCK3NlcS9MVDJ4c2VXNmNDTFY2?=
 =?utf-8?B?b2U2c3M4MjRkQi9ObURmYkdRUmdScmQyNEpNUUNDMzUyM0VoK3NVcDIxakYz?=
 =?utf-8?B?RUFIRkNZOE85bmNDZmJDQTdVdkQ5ZFR6ZE9CdHF1WlA3NUpiUS9EdUE3bWRn?=
 =?utf-8?B?TS83RDFOeEV3ajRrQk9YSmd4ZUdtQk5zYlhkenBwdDZLSjRRL0xLTUsvV1lP?=
 =?utf-8?B?STFQcXVoZ2JEUGlZc1NpZVNMVDZXUFFZTXl1QXZaTlpYWUd1a25MY0FSTmF6?=
 =?utf-8?B?MXJ3MUt5UzFGeVRDcnNud0t3eXB0T3poeUQvMjRVOVJxdkJNdEw3S3g1WFpE?=
 =?utf-8?B?RWgrRm1QUzc3M0JnNGp2VTk3cGdVMDlPZEorM3pHczFDVGRjaElYM083OGVJ?=
 =?utf-8?B?Q2xubmN1bkRxNDJUZzRTSDg2QVZHYjJVMzVscU9KcTloK2JWaDJqY015dGNU?=
 =?utf-8?B?ZFNQbHlyR3Y2OGhwZE9sSEJURWF3MXJsTklFREJzaklyWUIxSnVFZ2lETCtZ?=
 =?utf-8?B?S3lwcjRXeXVSZ0xUZTQxSGsxM3JmOE0yODk1TU9zVHBxTlB6N2ZMTmZTT3oz?=
 =?utf-8?B?YzRGL01SbDdSY1hxTVVMQUdoTEUvaDNvMktiZlZ5aDdGYUE2aElGdlAyWWo3?=
 =?utf-8?B?ZmpZMHB2Q21qZXRBd1VuUVR6aEtZaWtseldBcVVCSVp6SVBBWFBlOXZSVzZR?=
 =?utf-8?B?eXY1MmlacXJsaFEvVk5GYzEwOW4zZ2xIZGcvRHgyUEZFNkhFeFVFVGdzcFNj?=
 =?utf-8?Q?Cdz99A50qtu9mmrAN7aBz+4MDOJOi5V6VdlmELK8VBq9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee4c98e-c469-44e8-89e1-08da6aef1d81
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 08:00:45.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiEjCDOGVWgv2IiNuDI0/BEolK3WfyMdDB22k8QIBNsONRgoxKkglGcz61OtkOLFnHWxLu+w5owuY2x33TPOOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.07.22 08:08, Weitao Wang wrote:
> Usb core introduce the mechanism of giveback of URB in tasklet context to
> reduce hardware interrupt handling time. On some test situation(such as
> FIO with 4KB block size), when tasklet callback function called to
> giveback URB, interrupt handler add URB node to the bh->head list also.
> If check bh->head list again after finish all URB giveback of local_list,
> then it may introduce a "dynamic balance" between giveback URB and add URB
> to bh->head list. This tasklet callback function may not exit for a long
> time, which will cause other tasklet function calls to be delayed. Some
> real-time applications(such as KB and Mouse) will see noticeable lag.
> 

Hi,

ow do you know usb_hcd_giveback_urb() will be called in time to process
isoc URBs in time, if you leave them on the list? In fact how do
you be sure it will be called at all? I can see no upper time limit
on that.

	Regards
		Oliver


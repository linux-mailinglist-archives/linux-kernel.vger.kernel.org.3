Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22C354E64E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377993AbiFPPoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377870AbiFPPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:44:12 -0400
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5FF2935F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:44:11 -0700 (PDT)
Received: from 104.47.17.174_.trendmicro.com (unknown [172.21.167.194])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 0B41210000629;
        Thu, 16 Jun 2022 15:44:10 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1655394248.398000
X-TM-MAIL-UUID: 1d5be1b3-1245-4332-9713-5609a3efe9c2
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.174])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 6159610000405;
        Thu, 16 Jun 2022 15:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HonNwRpwGCZueLnBakI9IJmTU2695FgsPQ6ak7iLiXnlSM+MiKQjkguDz6GcW59xpTYY0NxNuu/jT11bFLYc/CWLwTwDgdfcgPmieJS9JVlRI7eEzApGBnUEbndW2hksDWPEiz/uQnYg6vARhWZ36ugdFKx9MlVfiqfEHm+8577toheVpfsqeFTvVwnWkYk9pd0BFCXE8Xs81H2gFJoSPD6YEvFUNkm4uouAd03Mq5SIUWNtrtzncNeppP6gUMjszGX/iyJrJsmIDYfQeR26tXQB8NMvx0jUguyqxJqX5r0TiXHI6lbf8Grp5q1lkODT4FtabfaKhJ8Rty0ZQfOyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7fMrfdztJQEX6s4+f1q0AQaeLnEGpWaEfXbBtcG+Hk=;
 b=LUpf/M08cdql0cX52sgAHGUoDNdBMrEuM7TjH7NO/YEpx83HWPvhxV1vKODFPMfCyrbQjLXhUiBHb0CAvAM8Am+eC3PeERb4XTncinHmspdOSFZYtLuhDaWTHOclNTWa6kzlAqZamqd3J3n0CdQkP4heYEind5pDq8vjoYMXIHYMzLCCa8srmIWi9FuqQ6FT3KLvmlbSavTu4wtRUubuE7AAERB6vy7rX3Fs2mYSVtLOwD+AyMWndqDenN4A2DsXyRb20z8hC6h9DqMHQv1TnHjX2ON6Bym1JxiVGyjb3Ki/Aw7wO2cNL1Mfqe+E7H7Qv0jD4Uh4Fd3x3nL0XGxrcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <b0af6903-6847-93ed-5561-1c43e84ef7e9@opensynergy.com>
Date:   Thu, 16 Jun 2022 17:44:04 +0200
Subject: Re: [PATCH v2 3/4] rpmb: create virtio rpmb frontend driver
Content-Language: en-US
To:     =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     maxim.uvarov@linaro.org, joakim.bech@linaro.org,
        ulf.hansson@linaro.org, ilias.apalodimas@linaro.org,
        arnd@linaro.org, ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
 <20220405093759.1126835-4-alex.bennee@linaro.org>
From:   Harald Mommer <hmo@opensynergy.com>
In-Reply-To: <20220405093759.1126835-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0031.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::7) To DB9PR04MB9627.eurprd04.prod.outlook.com
 (2603:10a6:10:30a::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa8c74d9-e26b-4643-7ca9-08da4faf0bff
X-MS-TrafficTypeDiagnostic: AM0PR04MB7107:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB71070F0B0CEEADA11F6B05B5E5AC9@AM0PR04MB7107.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHRAigZmmByPo1xmE108gWQr3CW+j8BuDV4Xu6yW/WJqh9af0G2unFcFzsqLrtvksMQDFm6NmH2gP23h3XHsYfp6D3CWAdTDrKaAHL4v6B7rn8Yb/Yej7Z5xJhs7/wrGenOfY841R32j9j7licLqEWAjMXHmlOpnS9WMR5mdey0GilyY5BlJP8ilXgRHRWq7mCxVt7BfGAascwB05KKwKmnGPeSizXRb/lkX9pLaCNVqZ3LjTbEc8xux5iFWLNwrjA4b58j5qPCKgw8yLN8d7l1bFjUYdN+sppzFxsQuvdF2HA9anav5uN7QcMukovNPgcsfrl9kEigrPHbDYg+wOAZQ46TIPdY/9oT7zbaxnInd8xmgDUlI8mAoV8F6YmpqhTmwywuqjiS+GzHIIWb4hw3Na/M/ujTs7JfdQD8meDJHDaY636g1gEQiEwyUIYez5IqoTcovPjdB5Gt7fxQAsh6QRHwlP2JLjn9X4vcN71PcqR4yc404adhv7CJdzoAaXmOf7pnFTHQttfvksXGld9yo8yIj5Lv5S+/32SWmB7R4WCHUYUXwvkWoAa2DC+AN6vKLKWAwViBvWH+J+EFyLzkZi6ACeZYHFThofTNRNwctkedTONX2azieO4+V8W6vLc0pwuM8Pk+kHLqg/hchmJca8iM5i+Uh9KXoMGrY2Zqp5nRSevV3WzDkHXRxMzFvBPCjOrNQdtRfWEgVdpa21JAjcPckrfAMC1TusoZm7W4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9627.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66556008)(186003)(53546011)(8676002)(498600001)(5660300002)(7416002)(83380400001)(31696002)(26005)(2906002)(15974865002)(8936002)(42186006)(316002)(66574015)(2616005)(66476007)(4326008)(36756003)(38100700002)(66946007)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3Arb1FVYlVvQkNuaWVZendqQlgxdHlDaTQweG96UkxBSkRIYUFHVEpKNTdV?=
 =?utf-8?B?dzBoMC9CNHcyTE12T3NDU2luUS9ZU1hWb0g4WDAwUFNwR1o4cWtXbkh4Y2pT?=
 =?utf-8?B?SGFieWZ1UzNtMy9MMXF1ZGQwdWUwdDJrM1lZeFNXYlF4QzlmQmZBaDRYK0Yx?=
 =?utf-8?B?c1VHT0dLbWpGc0Y0alRrTjM4QlVOY3RBRXdFSHo0NVBqcnZ4ZGpwV280TndG?=
 =?utf-8?B?SXNHQUVvZ0hJdlhTcnVjbjNzK2VvT2tXcGkrN3FuampINFBhalpsTnNMTzI2?=
 =?utf-8?B?WUtJZElwUW1DS2s2WlRFNlF5WVZGMkpKTnFkcEJwMytnRXRDQWI5VXNjNjFp?=
 =?utf-8?B?cXFpVXJOc1hKaUtrc01HMTl0WHJOeml1a1I2eDJIYkdDYlVEbGdhQjAzV0Na?=
 =?utf-8?B?VlVDdEE0amdVdklZM0s2QVd5VXUxanJHWUM1QzJKOUtsKytLMVMvTmIxZVJL?=
 =?utf-8?B?ZEp6TTl0MXJERjNUVk40OXRoWFpRbGFjSTBqcndVWFRESzIzRkp5M3VQMmhi?=
 =?utf-8?B?RGFsbnJUYUwzeWVQeEEyS1hVa3NiRGRUTGJOUXdsOXU5dnlkMHMya0xDSGlu?=
 =?utf-8?B?QUN0YlRndnlyMnlsUVdlOGZaaGhXMzlPWjJLZmxuTkVJL1FEU0MzZkN2V0dj?=
 =?utf-8?B?N1F2aDE4TGIzYTh6NUNCVzF3RUFLQkZMTW5QZHlxazlOZVhleHdiU2F1T3JH?=
 =?utf-8?B?Y1lHaC92eDRrQmhubmpqcEUrTDJ5Q01nWFNnY1prZkhhbWtqaElVZ3BFd0J1?=
 =?utf-8?B?ZG85NzdZVzZtazVraW8xOFQxc0VIeWZMbXhpNFBQL1JtdHdqdEh6clZrTzVS?=
 =?utf-8?B?bVdKbmY4aTNzU2JXVzQycmd2S29ZQlNiSGdQUHBJME9aM1FkbEdrMlZqTUVq?=
 =?utf-8?B?bTU3Yk1DNC9MbUVuS29qMmF1RStoNWsyc0M1TlhGU1U3d2R3emwxaC9vQWtC?=
 =?utf-8?B?N0VSNkVOd0xoaG1SUDgxcVVMQnRxdmtkeFUvUVFGcUN4SGlkazl3L0poSTl0?=
 =?utf-8?B?MHhaMUdncDlyUmpCWDdzeHJaeW16L3BwY0hJMGJZeVp1bmpoTVArU0FXSWtu?=
 =?utf-8?B?TnNDVzNMVFZLckR1VkRpRDRZYi9TU09qd2ZTOG1vc2pGcC9tQUcwYmgwQjZC?=
 =?utf-8?B?UXM4TUI0Mk1xTEwyZDZKQlEvdE05cFJFK3I5bXpyc1hxUm41UUxtNU0zVkZl?=
 =?utf-8?B?R2h2cTdaQysvRHlubWtNcXBUUHJNN2szN2dPWDg5dTJhYzZYT3pDSlY2ZUpB?=
 =?utf-8?B?TVdGRVIvUmJzQnBySHpLT0Jody9qdXFsTGZVMmhIRWUzTitZZFhMS2xQczdz?=
 =?utf-8?B?S25zRzVIL2FKWFdoME5Sb3k2RFpOUTVyck9CUVlueERBV2d3VkNGN1dkRU1x?=
 =?utf-8?B?MC9BMVB0VGt6bUVpK0hDTG4wQ3RoTEF3c3FBdTVOUFZaa21EbzZaYzkzYW5S?=
 =?utf-8?B?VlRoeUJ0VkhyZXRURGdwMTNUdEtxeWJWSFlpOE5vNGI0VkJyRlRkWWtSUHAz?=
 =?utf-8?B?UXFzVmJlZ3BPM0ZXS1hNT2UyQTFVcG1lRytGaERSL3FISE9mY1lWQ0tKODlm?=
 =?utf-8?B?cEdsZUYxQUJqTU9PZUp5OW50YkxZa2RsbndsRDBxc3pJQWROVEFJdnU4bmgv?=
 =?utf-8?B?eGFyWG9OUjY3MlJEbDNTOFdLVXZIT3pGb05oTGI5TlIvOFZaMndyNEJORlQr?=
 =?utf-8?B?ZkE3YUEyNjQ3TG1xUnlDS0J5SWlQV2hackdvMXdrU0pBSElzbW5LMFZoWS9P?=
 =?utf-8?B?ZUxzNlNlTHhOU2tmOUVmVHU5ZnhZVFJUVXJvc1NjaU1uMGxRMHBndWR2WGlQ?=
 =?utf-8?B?ZGZVRlFINlBxNnUyLzNCT3NIQ1pHaHRiZE9rRldYK1BhVENaeWl1Z00zaGx3?=
 =?utf-8?B?NU1zTWNWYWpLWjkwdTRpMjE5R0RLdUZlYkh1RFN6UWVFNmhWam8zdTZTWlVE?=
 =?utf-8?B?NnFRK0xpTnk4UlhtNzd0QVpHMDl4R3JEZC9BNTVwYUppeHlRZFJTc0Uwa09J?=
 =?utf-8?B?TVlpcnkvRWRtOWF5L0tOckZESGtWeXU5aFJzdXBGL2tscFU0a2dzSytxQ3lM?=
 =?utf-8?B?Y0twSE5QY01TMU1SeEozOGF5QTlXejBKZjkvQ1ZkSGgxc2R4ZE9FL3NFQTdK?=
 =?utf-8?B?emNUY2p1Y1NQT1RkSXBtd21DWjVwQVZnemova3dzRTlzU2MyTEVlRUZXRHRM?=
 =?utf-8?B?ajVsOUlNc1FPemNjYnBITE1yb1ZlWEVNUTIrdXMrWmxkaGZUbnA4ajVmUkNI?=
 =?utf-8?B?ZUZhQUJzR1JhUFFZTzVLb0t6Wi96a0hLQm15YzVoR1VMUzNUdTRpWkNNRFN4?=
 =?utf-8?B?RXlheVZSUGdaOTlJOGhyajBmZjVkSERMZkc2aU41TTh3MmVwVWE3Zz09?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8c74d9-e26b-4643-7ca9-08da4faf0bff
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9627.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 15:44:06.6604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: namHdJyyz2uaWKolTGtzUc8SaZl0+CV+mMpEphJq1wfjy2qXmBeBgCGuV3liDJNEa9Ngv+GrjelBApoZBfXjZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7107
X-TM-AS-ERS: 104.47.17.174-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.0.1004-26958.007
X-TMASE-Result: 10--19.296900-4.000000
X-TMASE-MatchedRID: 6otD/cJAac0Mek0ClnpVp/HkpkyUphL9TJDl9FKHbrlr5Rm/tuDWmSZl
        e49VkKqHl/NSQGlzTvaI2wbE1kC/Xfil247XDr/jN70wXhI0DX4WUg/hm489yN7p0Ru8jKvFmkL
        WHr/qLVhj1j6EhkPl3Ubr6B3Cjpa8RFXsL2iM5nVDRebSlZYuSlkN0eJOT05weGHkpR2WBaJFiF
        hLb5YAixe109oIw0UQcJZqjESB+bACM8j+z0i8j+Q0jDxGUAJDL0UBH3N6CHR3Y7kpVKWrn1oKr
        s4NT7HOePvPVg3PK9n5E1q17Q/Uf9Vuu4SL51B6fsrJIMK37Ash+cXdVp/Twpsoi2XrUn/Jsuf7
        RWbvUtyrusVRy4an8bxAi7jPoeEQftwZ3X11IV0=
X-TMASE-XGENCLOUD: 66e75db2-a75e-4a7f-9e76-1eb1529275d5-0-0-200-0
X-TM-Deliver-Signature: A40BDF1113F8AA790A20509D05483CB7
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1655394249;
        bh=oYElXEWP2Xi/2UemNak2PyLwOqycK0nyt/RnlscHSYg=; l=2573;
        h=Date:To:From;
        b=or+lwT2UWB+a8FqHxOfX9T0KV2jM5aTck70FG3nMYsubblBq0SbGgsEPKAWXHM5Wa
         zx7EIwARX0gZKhqf6SrgZwq7s8M8Ep7QaYJkqGYGv+g1wC5LpOShkM6avDweHKB1cz
         r/rPEkhKX9ounZS0uEJySQiMVhjzxBIiO30/Ez28F50ak1Yn1Yl0GZR/krVVCF012E
         bWCUXzajZL4uekP/Ys4XmMpWC1rX4fdigeFOPVqW8oUl0lR+z6tVV5igOUe3lTO0z/
         IuoRtF+3Qx4FdKPPZRuqntHCHLise1b5JIWC8j9icwq68fPONTbBWVy2HMFQlh4Z1E
         rTI8fgiKlO2uQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.04.22 11:37, Alex Bennée wrote:
> +++ b/drivers/rpmb/virtio_rpmb.c
> ...
> +static int rpmb_virtio_write_blocks(struct device *dev, u8 target,
> +				    int len, u8 *req, int rlen, u8 *resp)
> +{
> +	struct virtio_rpmb_info *vi = dev_get_drvdata(dev);
> +	struct virtio_rpmb_frame *request = (struct virtio_rpmb_frame *) req;
> +	struct virtio_rpmb_frame *response = (struct virtio_rpmb_frame *) resp;
> +	struct scatterlist out_frame;
> +	struct scatterlist in_frame;
> +	struct scatterlist *sgs[2];
> +	int blocks, data_len, received;
> +
> +	if (!len || (len % VIRTIO_RPMB_FRAME_SZ) != 0 || !request)
> +		return -EINVAL;
> +
> +	/* The first frame will contain the details of the request */
> +	if (be16_to_cpu(request->req_resp) != VIRTIO_RPMB_REQ_DATA_WRITE)
> +		return -EINVAL;
> +
> +	blocks = be16_to_cpu(request->block_count);
> +	if (blocks > vi->max_wr)
> +		return -EINVAL;

Not exactly. The virtio specification reserves 0 for "unlimited". And I 
see no special handling for 0 in your code. Damned trap in the 
specification.

What's "unlimited"? As the blocks_count in the rpmb frame is a be16 I 
guess it's 65535. But if you consider this theoretically you have a 
possible max array allocation of 16 MB - 512B max. instead of the 16 KB 
- 512B you have with 255. Getting headache about this "unlimited" in the 
virtio specification. I don't like the theoretical possibility having to 
allocate 16MB dynamically for a moment due to this "unlimited".

And of course there is the same problem in virtio_rpmb_read_blocks() 
with max_rd.

A fix is needed, either 0 is 65535 or 0 is 255. Choosing 255 as 
implementation decision would be limiting down but maybe without any 
practical impact. For UFS it's a single byte bRPMBReadWriteSize only in 
JESD220C-2.2 GEOMETRY DESCRIPTOR and 0 is not defined there as 
"unlimited". Unfortunately I've no idea about the other possible 
underlying technologies (eMMC, NVMe, ...).

> ...
> +}
> +...
> +static int rpmb_virtio_read_blocks(struct device *dev, u8 target,
> +				   int addr, int count, int len, u8 *data)
> +{
> ...
> +	if (count > vi->max_rd)
> +		return -EINVAL;
See above.
> ...

-- 
Dipl.-Ing. Harald Mommer
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone:  +49 (30) 60 98 540-0 <== Zentrale
Fax:    +49 (30) 60 98 540-99
E-Mail: harald.mommer@opensynergy.com

www.opensynergy.com

Handelsregister: Amtsgericht Charlottenburg, HRB 108616B
Geschäftsführer/Managing Director: Regis Adjamah


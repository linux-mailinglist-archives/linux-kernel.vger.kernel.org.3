Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1175A912D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiIAHtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiIAHsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:48:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569361D0E0;
        Thu,  1 Sep 2022 00:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtIM/3J+CoHG0OD+dOg6p3vZhpKqTdngpY1A5HW+CmsX8oonTFLY5TBn1h+sRKDBAT7JiE8DxP5KPdIHns8kQABc1/a2OwBwEf8SoEUoWS8PpvpAcp2JfSjArULzcJaL6Ou1FbTG4VKnOkImr/6ConOcMwe0yUklU5JPszeldWRtruzFd8XnDiUsH9TLzqlojFckfV6d8UdQ937NyjtCGMMtCbf+lvUP7wODw0t8Mx+SBOKDlb15hLDxvSUuRk430u3zS5+HhzLFVNx2CUaMKi4H5DdNS6OsuvOQLjv+2BOKzpBwqNCbw1v8GoJiuiJBx/jYDv+Io6Y7K6ys2byvSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JalDU9dXye+hRKvm1JmJ2lxlyDGjra+rTV6w70xIs4E=;
 b=FzR/i92lT8ews6aBZ2mRXWhtg3LfcqdgEEysghWXRdDIJtc//T2G6+5PLgKOLL5BKkwM9Pcz4KJn8ck7td9TrHkNGf5eUZ/4yinECfF9LUZK4JoJq0VSOUAaRPt2FtEp7NPzFxl+kG08VwMQKgciv9751GzKCRpPy7QUJyWmuyhMHpkSCDfiYLmIQHs6/Sacw5GlG40eT4ym9rTuKW6uKI7IupMm0NORx42bxfhHPYUKXqpL6m5NyT/aP9IF4EvbN5hTFrNdtYGyvzHMKIqBSa1Pbd61kBJ1sCk+e70+dxcQFq9iEV87T2Q9CxqmYm/3/EkYFIwHyhCzk0loK18hoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JalDU9dXye+hRKvm1JmJ2lxlyDGjra+rTV6w70xIs4E=;
 b=X13thvu4y1Jpke7f2ccW+QWdb6UOVb23la7TsrYc0wiAT87R7nurLh23PipTTh8qdhEKNIIUT7zXJkIabEXe0YbrbyAFcRiPny/cWO6EmL2DvNBlJ7ILnSGa4Yt0BFxgKOxiWgWqZkkT8FYiIQaAW3/gEQYdmCF8cXZvIhnPqTMmvOwNALwqgdxWQlyAQgnMzX/ujyIa2uwbgNR3bV5lMGfckWkcf2NZxPJamFADLPpW4Cyr3uxfFggvPpO02MNbjM4dBC2tYokBnJST05ovl8+2g4qx63I9fHLLujnRFqdB685/fmbb42sYxzKextibHPy5ZVWx7hzHqOiskpj2LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 07:47:44 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 07:47:44 +0000
Message-ID: <1a6632f1-5e23-5fb3-1af2-6d653e4338d4@nvidia.com>
Date:   Thu, 1 Sep 2022 00:47:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: linux-next: manual merge of the mm tree with the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220901161722.739d2013@canb.auug.org.au>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220901161722.739d2013@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0181.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::6) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d492bcd-a243-4fed-c22b-08da8bee413b
X-MS-TrafficTypeDiagnostic: PH8PR12MB6892:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tF+3oxtHRa2uxiZ4OaziOJOqRNVDwfRmU7NpCUQrwdd3s6fIry/FP1A/GFQV7DSOJpGx8zcoIBfD1uMa4L1UVantcXA1Lhtr3PTG2t0U239N6b6xul4DytKlwj8Tl/15a6bdZmvpG6wLgIMSUdU5+RJydOZQyrCNBiCQn9l2FqUmDN8jVXhyHgDAZuoPznyUq5pd/maVdfiq0f00VqWEcYQngmJARrejU1TAk1KU5syDMpHwaP1gqMlNkAcxCRQzdpJ0IaxMsxYlycE6Ug9RPsU87AfM+Gy9Q+Xh8HO8g0wVb4t+LrgXniN7Rtz072Dx+RvE5yGtKywXM2ozk2Pd8LbFUaDrERUtSUJ0ZrysOIGTgLQVWsC/UlR0lGRrXSntnS8mG7VSUZ+HOjkIlzZ8Y82aWvTP7udpzLcO96BTioTDCsHcsyXcxqPJKYkDMMQoaxm6Upjf8zsnT8mMuE8w0GBm2qvZjkj7LbJ0NNb6PtJto5GGG/s5wr2h4NHNyk1dAWvUkWl5ThsDwgn07Fh+Mg66mxZ/GbG10RWr8uWTrPFZRnzqSoGitbsj0rNaJH1b2MY0iuCrxgZd0WHbCGqTfv5qYGE3TVSNbaPeVCRBBSs9pD4jEXJ7PtbZLEAymsoAGr9nawuSbcebS4jNH1S3n5WH2ocpd/QoE0mJnkCvYeMUwOD/4lm9Ss8BMXHL4oyX872Vk+EY5e84t+s8T8uruT5Kl6ByCrk0HdOeXQBit0hYC5vDuFPksprJHXanCwR26DyRK3w8rFSFB5PReg2h4Na5myXYsAvVcI0eCP1GBRjx/C6stpHtJiygHjb4PwnX3f4X3HlW383oTh4S9arlmLFseO678KsTHehn4iZHo2wN/sZHjot4G8UGf06R9OBr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(6506007)(53546011)(6512007)(26005)(83380400001)(2616005)(186003)(86362001)(38100700002)(31696002)(36756003)(66946007)(66476007)(8676002)(4326008)(110136005)(54906003)(316002)(8936002)(5660300002)(31686004)(2906002)(966005)(6666004)(478600001)(41300700001)(6486002)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bng0dVhnMit1NlVQNFNjL000SFhwL1RmeVlVNmx2Wkc5eWNFdVIwY2xKQ3RB?=
 =?utf-8?B?Z3Z5MWtFOGZnUHkxUjR2NEhGRGtHNlU2bmNocENFWWtNT01WTXVwSnN1RUhk?=
 =?utf-8?B?dERxenc0TE5KakRndWhxNGsrMmYzc3M5VWpwc1J3SFl6QlJPRW91ODdVYnBK?=
 =?utf-8?B?LzdJVkZlU3lYSWlObEJVTW9nU3oxVG5HcFBNR3E3NGsvUllOdy8zS0JwN3Uz?=
 =?utf-8?B?MGJoQXZQOHo2QUVDSlp2MTVUTUVmcTRVek9GT2dXWklUb0htVGhvMWQ4SFVJ?=
 =?utf-8?B?Z0M5c1FGdGlveE9XOGw5aEJzQW9SeUF1SStYRnMrUVh2OWRuVVdPd0MxZHRL?=
 =?utf-8?B?VU1sUzh2SmQ2bkZLTnQvUXppb2ZITkp6MWh2S3B0Wll6TkVpU0RCaXV4Y2hp?=
 =?utf-8?B?dkpQTGJOZFZDTDNZd25ubWN3eW5INHNxaER5c0hhZ09XbjQ5SWpET3NRMlMx?=
 =?utf-8?B?Q0NrZGlFd3N0eHozMVRaZEpiMGNIYmRUYmlOU2VJR1k1NjJUenJuRnE0dmJq?=
 =?utf-8?B?a21aMmp5b0xTVGJmK2tTcVBIeDVqdWVodURNbnl6R05ZUUpWVFlXblhhUzAw?=
 =?utf-8?B?R01Ody80ZnhBMlU3aEp3NFU2anByNVJ6KzZ5RWh2YW1DTEJkK0N3cy93TkVB?=
 =?utf-8?B?TnZmVU1TclJhRk1Lb2U4Nm1CZVFGaVBqYjlkTjFscVVaTC9aWk52YUd2b2ds?=
 =?utf-8?B?MjRrY21sQThNN1VEcFVQTUxTQ0ViTWUxTHRaOU5RM0EwUEFPM2ZUUHFSUkdt?=
 =?utf-8?B?Z0NOQmlHWG8rVkl0U0p6WnVkMzJDc1ZpR0NWU3FNeXQya3lES3A3V3lnTktF?=
 =?utf-8?B?UExmQXY2elVyVDRXUUliM3ZjSU4xNlEwdS8rV2xNT3dUaWpuU2g2K3VISDZG?=
 =?utf-8?B?d0NKNUN4WmU4WFpubmYrRFg5RmE5NWpXVEN6SkhvK1RKQmxkeXg0NitEZnZE?=
 =?utf-8?B?dFZCZG90ZWdOZGYxdUNlb2VCZ1ZIeTJHRHBvK3ROdEpxY3lXWVNNUVFDeTVZ?=
 =?utf-8?B?SzVNWFEzaDcwVkc0RXNZOFZXWGlrL3pyTndyTm9ZeVkyZTVmUG1rTWFLWWwx?=
 =?utf-8?B?c2todmdqaXNpN1NDeFBEMTBhS0xHL0ZTa2lqaGE1WFlMeHZkTjA0UjFGT0NS?=
 =?utf-8?B?S0tzdlhBT1JEK1dkMGdkbUlHUS9RQzNMZlUvRE9HV2luWXR1N0pGRTZURlpX?=
 =?utf-8?B?T1M0aGZvTXpmRWorWXluZXZMMEJRb3JGYWM3cWNQbm94YlAvdEExbm16cnJZ?=
 =?utf-8?B?dDRSS0V6WUNIcGVYQ3RqbmdLcVRGZHN0MVpiNEJRb2tmQTBXMzBvdHozRHFY?=
 =?utf-8?B?enIwTkJucWd3aStnNVR0SS9DTU8wRGhCQzk4TFVHOEVyRG5MeWt3aURmWEl2?=
 =?utf-8?B?YUZzWm9xME1lV21HeXRsaGpNaDVsOUxGNTJGU2N2SmVUTDZGaGRxRFhRTmh2?=
 =?utf-8?B?MXdyQzZNdCszRWZ5SE5KSHUwQm1BWmIxakJtbnppcWpmNDBUNUNrVzVGc2Vx?=
 =?utf-8?B?dEY5dzAxMWw3SnYxeVBKSi9nZ1JySWlLYmNpNUdoRHpNYnMrY1dQeG9Ic3pO?=
 =?utf-8?B?UDNxVURxMmRRaENKcytWanpWOEMrTGg4Z3E4ZTFZaXpUcTRka0twYjN0d1By?=
 =?utf-8?B?bDhEOW1mTXlWVGZCK1d1Z3RCZWpjTG5LVW5tUll4NnQ2Y28vM0Ywak03Y1pB?=
 =?utf-8?B?aEw0Y1FMSnVmOVdKbkxBUHcxYTd2cUQvQWtXc0FCRmhvSEtaSGpVa3FhZmx5?=
 =?utf-8?B?OEtzY1h2WXcyM2JpWUdQanp3TlBnUnJsNDRhTnV2WGZmN0s5WTNlV1ZZZm92?=
 =?utf-8?B?c0FpYVV3UTFHd3gwVERoVFRJaHVNM1Z1UDJCbFJCczNqenk1cjZWR3VLTkF3?=
 =?utf-8?B?eEx6UlhKcm9NbW1WcFY0QjlCVkpsTHo3bGg2WFBTNTBwNzJkMlNFYkViaGFX?=
 =?utf-8?B?ZVZBbldLVTFlME1KWkJ4aHVKOTkwcFgxOHFMelYrZWdHbG5GVDZqVGNRYUFE?=
 =?utf-8?B?cHJSMWRmc0Y1UVQvRTZYY25sWFY1NTdxaUtkWFFBVFp0MnIzQWtUbXcvekhu?=
 =?utf-8?B?bEJJaGFDNWVMUXRMS2phZGpZVW11VWRnVWszMkZCaUlkV1psZkMzVGFsTER6?=
 =?utf-8?Q?jcjm91ssnFVPTl5hdGfUyyxLg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d492bcd-a243-4fed-c22b-08da8bee413b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 07:47:44.0509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3x3ia/FJUVsoyA1dOG9ZR+8TzcW/+mhG8gZ+0nsw4crUd9sr/OZD//dSCXW6t3X744hDZl5e6ERaSG7dV9dCig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/22 23:17, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mm tree got a conflict in:
> 
>   block/blk-map.c
> 
> between commit:
> 
>   e88811bc43b9 ("block: use on-stack page vec for <= UIO_FASTIOV")
> 
> from the block tree and commit:
> 
>   2e9a2aa23dad ("block, bio, fs: convert most filesystems to pin_user_pages_fast()")
> 
> from the mm tree.
> 
> I fixed it up (I think - see below) and can carry the fix as

The fix up looks correct to me.

> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
> 

Of the 7 patches in my series [1], the first two are in mm, and provide
some prerequisites. The remaining patches apply to block, bio, fs, and
iov_iter, and that's where this merge conflict happened.

Also, there's still some upcoming churn (more patchset revisions are
coming), as reviews are still active and this one isn't perfected yet.

So I see two obvious solutions. Either:

a) Only do the first two patches for now, and leave them in Andrew's
tree. After the next release, do the remaining 5 patches via the block
tree, or

b) Move the whole series to the block tree now, or

c) something else?

Andrew, Jens, any preference here? 


[1] https://lore.kernel.org/r/20220831041843.973026-1-jhubbard@nvidia.com

thanks,

-- 
John Hubbard
NVIDIA

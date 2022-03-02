Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DDE4CB1FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239678AbiCBWMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiCBWMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:12:42 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2053.outbound.protection.outlook.com [40.107.96.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9707DC3373;
        Wed,  2 Mar 2022 14:11:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhUJL/nqtaC+5ghZ+C1btXUi9YQ73ZK1hzYrmYRfXtEzGa6YBhbrbQ2w4EwTYsn5Je6l3o+np6788GKrXlUBshEWAARECfKkpWCpWaKF/sKdVgdkya+KdY70JnbGbRNmV5+/Je4N4rwejLJtbAeBBPZa653+BfJjBfGdnNX0KmDEcasj2wT/XAKDZaZzNKdW36Q21iGJMZHWZpmHvJ4p4pdW/nmqRpNkKK/DkwOKVNPB24XXdkkqPHqk3aJltX3c86hWzY50U4BHdlMNzP+wLCs2TiAQ4dIVSDE/52l3o8pB0W6oIsC8/6u6KFDMyUMmnnjedoEu8szN2EunJ7OmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwOdKmrjEMyh+ZevlDfjLL4uQyJ94Aoz4+x1VHTJLt0=;
 b=YcxeE4VV8H5ypoifpDBdlnHao3GU2qB6kPDLWcqN7j8zNhyQLOWXrkU/KSb+zWriGtKCjp1IePEXCWCsTcllRvZKZpLQoNg9ekbNYPVdlNQTDIZHUXBVcqJNn0OK9oN3eIhK8f/PpqoAlwGGHyQ08IHjNHFkdkYuCgDPT/rsrswA2KHqVimJNxX1fu3NFLzAhqYq6x1N3OHsjIsC7r1LvQGQdm7rtoK1aYeOryIoE2uHsIHlYa8JvrdXpr8XkrWMYyRw3e61GwFG7SO4iZK99GIiTM51xdaYB+YimoZ8sJVL0O/dbXZNPKdFma2VgBexWeX4oycgKKA5PBY+oW/YAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwOdKmrjEMyh+ZevlDfjLL4uQyJ94Aoz4+x1VHTJLt0=;
 b=B/jAV6ToFf+fO/FNvLtdKwd8+/1a0tTMSSX7VVlmnQohhrJaI0IGIlWJHUV9g6naD9J/GISRfxaOt707tethzLMJP/mq0qbHu6yFlhDxP55BOtvUW6/JvbIjc8xJCUx0a0vU0e26J/JvkGG9jEqE0DGQpRIWuXh3IMWXPocCGHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM5PR12MB1820.namprd12.prod.outlook.com (2603:10b6:3:10d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Wed, 2 Mar 2022 22:11:56 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b908:1ec9:3e42:ea00]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b908:1ec9:3e42:ea00%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 22:11:56 +0000
Message-ID: <4804f1e7-8a25-ad8c-dd63-589ed34260c6@amd.com>
Date:   Wed, 2 Mar 2022 17:11:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: linux-next: Fixes tag needs some work in the amdgpu tree
Content-Language: en-CA
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220303075733.481987a8@canb.auug.org.au>
From:   Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220303075733.481987a8@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dbaaa36-66c1-4010-d245-08d9fc99a9b5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1820:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1820E75F190053D45348580799039@DM5PR12MB1820.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SkG1RfbmvledhCpaQTQO5mtY/ok93AKO3uGssVgJrG8WthC9OaWVIJVj8sJYQjCxV9vn3RgpykoKDKcnFSy3g+AIhJgaM5P1SOlBGEYZ639HGrKZtYetZlrVACFk12CdkFJXznzt7aWfSPuWClDPneCra6xrfUISYFfi+pC+/zI6Nd2D9wCmqDUc6MfV6l71GAxyqCEUE66HhMbHtECHCRuefvVlyKrUY/meqBWA/7hfAsCsyk/KFILab7aPb4hExWBnzIjnCFmPzANTCuFuDNM84Oq3lqLI63vVET8QYYgoAX2fOa3FlKJm3P23+RGymVGfNLRvub3lsgYj306RdHOiW4ylVxpJ2toUDZA7sdjI9MU7q+kXoxgi2MsPLnCvOP/LJqbMVT0S+7h8Hd+mZ5ohyxYD1wBCAt+xTDHFb+BcFRuWeFfbocInvjhPsGMkgqCtIGPlEkMH6FfweSGAj82VFbVHxI7YY0fhqRHw+fkL6ZQ8Cj3PT6p/DeCPfnkL0mfnFapk7n74zTWm0yT6ptU3XULzL2gQeTOodaBGY/q8NZlhbac4pZ8mdtKeYxstSczZJc3iA00rnbwglBFZc82YGoRLCojZ4c8jhAkl6uSetwthS6U7PB0J0QnkPrx3Wkkkp15GW7tDh4vRoRAPBJvOnsP3PPplLihPSmvYAX4VGNdDizg3Pog0QAoEw2Zb1e4cpdUIRPbUkrsesswllmEBaasTgX1xe26eMrhIgJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(66556008)(8676002)(66946007)(26005)(4326008)(186003)(2616005)(316002)(508600001)(6486002)(53546011)(110136005)(54906003)(86362001)(6666004)(6506007)(6512007)(31696002)(36756003)(31686004)(2906002)(8936002)(4744005)(5660300002)(44832011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmdWVllRaVhnYVpveG1aTHV3ODZ4RnlrNVZJMmg0YUlEZ1Mzcm8rMStVTWdp?=
 =?utf-8?B?UG9Yd3B0OGRvKzdlUFBXNXl3WlE3MzZBRWpxenN5eDk3SFpJekEyTkZRL3VH?=
 =?utf-8?B?VWw3MmJkV0lsVTFOb0NleGpBT1JTRDI1azc2N205WVNzZEI2Y0JRL3d1TUtj?=
 =?utf-8?B?V2dsZUcyN1hYYjRIZkxZU0p2d0k1aWxPS3VwTklZWk45ODZwWkcyblN0MWFj?=
 =?utf-8?B?SzJ1cTI2SHdMWUk3QjB3UnYwbm5McXRNWFVZK0ZUaWozMzRzTkJ1TVVSYlhN?=
 =?utf-8?B?MG1vaGFnNHVxZENxS29lREZVay9MQlF1VlRVQXZFV1ZiVHlkRy9QYzNZSmVI?=
 =?utf-8?B?bGovVFM1TENKYStTdUtmVWo5YkV4S2FKQnBqeFlDdC9sRjltazZLZGFCRDI1?=
 =?utf-8?B?U1ZCbnQxbGxFbWY1bzhzZmd4ZmNyd0RNSWMxdmlSMWJyZng1YnlLN0NYdDRP?=
 =?utf-8?B?TFU3T3FDZUtnMjN0ejRjaVRLRE9VNXQ1TFF3eGhIRGZ6a3Flck1yYWtKZmtt?=
 =?utf-8?B?Z2NwaFdOSzBJa2RXZ0hLWUFiaDNzejZnUmFRL2wzUXVLMUFzcFBCK0kzcUdz?=
 =?utf-8?B?Z3dCSEx2UXlTUEcrWGpyRGxkZXo3T2l0cjlvTVhkdU9wRjFJRGlkbVBpZWJF?=
 =?utf-8?B?djR2RjNhcllQSzNSK2VVUTBrcXNKTzlrQUgzd05DQmVOQ0Eya0dNWERES21m?=
 =?utf-8?B?bWpwZFNBVndWYlF6bE9lN3VCWVZBRVpwRGdITThYTFlwV1NPTmVIT2FPWlJD?=
 =?utf-8?B?WG1QM3piaTRNY0paalR2dktqUDd1dWFtM3Q4SWtLWXJmVWdVUlBLcXA2UTAz?=
 =?utf-8?B?OUFxbkJheWdhUlQvTUFMTmpjTU9iWThCbXZVdmJuVUZOVkcxUVNjRnlGYVZH?=
 =?utf-8?B?MHJGZnNCVFdVRE9tdlNETkRZcllJTzcwb1ZtdHg0c3ZYYW1sdnFkNStKRXdt?=
 =?utf-8?B?dGRMM2k2emFwRWxYaHpvbUxnMG41a3NGN3o1Z2o4c3l2U1kydEZMUnN1N0NB?=
 =?utf-8?B?R2hUMUU2TkZnUkVxeVFJTTFTNWptWkFKeDkvNzg1d3VXamE4YmlWL0NxZlJn?=
 =?utf-8?B?WVowd1oxRGhvTnphMTkwWlIwL3o2cDI3ZjZSQThiajZrbW1SUHJZbHNwL0VT?=
 =?utf-8?B?MmVtTE1HRjB0K2xaMkRyOXpCZWhmM3dnRkJnc1NNWlh1Q1FTc1NqNDR4RjBU?=
 =?utf-8?B?ZGN4Nmp0cm5LMFFXb2xsWlBZb0FPUkhQbDRrVTRQdWNNUHhlb0QwQkxEa0Nq?=
 =?utf-8?B?TW9RSTZjYytiekVvTnVVakZIaTNnNThHTlN5amtHVUtlb2ZHMllKUk9NU1NZ?=
 =?utf-8?B?cDlaQWZ0N0ZwRTJaSy9GcmRhQ0liSUkxZ0Fkbnp6V3V5Nnd2TDd3U0RhWkhw?=
 =?utf-8?B?dzBlV3FyTzdFSmYzL0ZBSDVzVEhrVlg5WFEzS3MyM2VCK3ZyWlpySkdBZzlI?=
 =?utf-8?B?T1Nmd2xlZ1M0aDVuWGZJTmFxQXU0bk1DWmhrbEJ3S2ZpOVZFTThjVmkyMnBt?=
 =?utf-8?B?TUg2MXBYMWpNMm5oRDVXVzcyWU8zK0ZoQ1loa1cvS0MyVGRxZWFMekc3TlpW?=
 =?utf-8?B?VXViaWlDeG93bEJkN1NncGZCQW14eHhQcGUxRkoraWU3YTRmQ2JHL3AxQkg2?=
 =?utf-8?B?YzdzWjJLU0cvRGh5Ymk3WFVIcEhiWjg0bUxURmJxMUFDNkpPZW4xaTl6OGNu?=
 =?utf-8?B?NTZKSWF2K0N1cnVXanp5NXRrVDRuMmk3aGZBN3RiYXZIWWVWQmtKbURjYW4v?=
 =?utf-8?B?cU9ZSFBiWHhNQmorTElOeExDNFo4RXB6M2E5bzJUaTIxeVRkZ084d29lUzRN?=
 =?utf-8?B?UTdUTzJxblFLd3hVR0hEbDhISWhFVFdKaEM4TzhiTU0yWHFrTE41NGgrVGxt?=
 =?utf-8?B?dmd4NkEyeDJjRjJrS3haN3dpUkVpZVIrWXVHVHRpYkoyclRiWTV6RUFBY0Q3?=
 =?utf-8?B?NU1hVkFUZU9udERiQXArUm0yOTlzZHBIWndQVXB1NkVwYStCeWpCanJrdTZ6?=
 =?utf-8?B?Q00xRC9rcjJtdHZUQXNKaUI2QjU4bzFQKzNtcTlGaFVlRU8vaDRUeHpGVWRi?=
 =?utf-8?B?ZWg3WjZsTVRvTWVkeGl5SlIzVFZjT3N6dlI3SnF4SmJSVWtCK28wYnpsOGVU?=
 =?utf-8?Q?bfIM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbaaa36-66c1-4010-d245-08d9fc99a9b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 22:11:55.9128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrUqXqCqpcbkW8eVoTfzcJHTHD9scY+0bE2jbb8a4xPJz8waTZ03Sb3guTFHXff6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1820
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In our local branch it is:

    60862e45da3b5a drm/amd/display: Don't fill up the logs
    ...
    Fixes: 5898243ba7acdb ("drm/amd/display: Add dsc pre-validation in atomic check")

Which exists:

    5898243ba7acdb drm/amd/display: Add dsc pre-validation in atomic check

So maybe something happened in merging, etc.

Regards,
Luben

On 2022-03-02 15:57, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   d15628d483a5 ("drm/amd/display: Don't fill up the logs")
> 
> Fixes tag
> 
>   Fixes: 5898243ba7acdb ("drm/amd/display: Add dsc pre-validation in atomic check")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Maybe you meant
> 
> Fixes: 17ce8a6907f7 ("drm/amd/display: Add dsc pre-validation in atomic check")
> 

Regards,
-- 
Luben

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1216589525
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbiHDAM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiHDAMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:12:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723E14B0FA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 17:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLhSF+7o+5+P4dCwNnTGwyD51GeWdSnJr0h+XxDFBsmB2RdSpNByE+/soHUAGgr/kXmpGreN8w8GFckJrPcTUhZKYc8bNIcu8rFIEhwurvIQvLrmDX9ykpCZm1IaB0qwFMOwPBerFc8tOGLeTa3L7rVqCEWlPm09iCCpo/g7X/+i8lzoZEXq9DfSI4Qzb/YIS86LaoXUhWTsnF/uoE0+ynqnEvpspvYsvBFRGIfWi+Pa1QHtoumVywE6fONIEaRP+byZYASutQiEursHxF4SCae2YyVs1bJOmx4DmeQcVgrJK8ajC3cRuGFWmv2dc614cI8bpEJc4waLtZxRIR2AUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rl9jYIpVnMOGIwYO7gHNFgvDWOJgDWK3Vw6TfjBoBKc=;
 b=Bj8ZJQCom/leZhK7RS7clP4fDgiwlTA3Va2DfyIuYWEliRXjU3Y1FGH3cyZfpLWakurC1qaUNfjlvDR1x5loI03khMadEbj9VCYdiaGsxMZx1X+JvDIU8khtjDJY/KpCjUf2W5CF+AIJ89fN9Wf4WWpjrXw4+6WntaHylg1Nv43BRbn5HWWtFTrYrfhUAWuISKr8xoQ1XIbpwpXOgvcc1tV0qtd2zQgjAMOeQnU0Sfk2evO+iQ/8c9lC2qySEsSfKZemu62NOmBhOkfULpxF+e92qtAcXGm1fg2AAKgkG3jtREc3P8A3r+FJNMpsV2tHSfr7c9CrEblPpDGRyk59YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl9jYIpVnMOGIwYO7gHNFgvDWOJgDWK3Vw6TfjBoBKc=;
 b=r+rmr6tSQxphcmEEocDKqTMI9OiQD/FoNmjRKNS2hqSB+ZnwyEGC0WQeD5fyS6sEKCshzehG232aXyVDsFAgkqsbNyFXbQ0sGNZYaBTljq6LgGuHbsxi3E5FJIjspc1Gz48vR+HzJlxyPZaQSX6G/JDRJ88BEENhlCNz4L1BqG5gRB3PzELK4wmEE9EerN5/RIwW/FVaAhYMk/S2PcHmQPCRqqpDfJhp+35IL0s3+yF3jdXQSaX+F86HJQvVh4qd+Y5kx0Zojm+Ge8tQC35t30iBrkITZeDLaFOXEJAD6sw+WVNMPzQ79U6QhOiCeJOZhul7RqunR9rnFh6Gton03A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Thu, 4 Aug
 2022 00:12:50 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 00:12:50 +0000
References: <814dee5d3aadd38c3370eaaf438ba7eee9bf9d2b.1659399696.git-series.apopple@nvidia.com>
 <CA+CK2bCxuSs8aDre7B7cr=B1FpD+d1kJL_1uCU1qtNKErpUSSQ@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm <linux-mm@kvack.org>, jgg@nvidia.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm/gup.c: Simplify and fix
 check_and_migrate_movable_pages() return codes
Date:   Thu, 04 Aug 2022 10:01:35 +1000
In-reply-to: <CA+CK2bCxuSs8aDre7B7cr=B1FpD+d1kJL_1uCU1qtNKErpUSSQ@mail.gmail.com>
Message-ID: <87h72s7toh.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0102.ausprd01.prod.outlook.com
 (2603:10c6:10:1::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a175061b-2a66-4e28-a568-08da75ae1177
X-MS-TrafficTypeDiagnostic: BL1PR12MB5351:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WtV+IVOnK3O872BzDsVI+wV+TpQ5S+1cEdFkql5fVJK9C3ou1pJRndEVboRoXAIYch7pxNOqKXQpRpKByIBO+Y24oDW15XhnbNUpZTlB1jwFOvPNVFNC6+Hd097sdUJh/OvCdCCJLdI5uMZcv+jx/crQFMmFqHKHV43zr2OspT9G0RHdJ+HgxDQOPQjSPIAIIkPxjFDdZg40ArR/oVWMMBLPeGkhGN9PgJN42p4w1iVwNe30BmHwnl+JeLQOnPTssLqu5C/zV3l46lcGq5ptcx912WKCJydW7qy4wnf/IxgBCnN5W96tv34rwT5CISRlqxDeINIPQIQlenAVlmtNqsy6Y/CNuIJjN2Gt1ZgefKDF/2aYjSCfxAZjwXgElU1El0dJyfkvc6fo9ac1B/CtOgGZngJkD/YwN+hgKxd0XDvSZLG/0afwM3zuZEsyXDbkTqdxxAkdNOyAZUr24GqPEuLE78uLs3RLLC28mcavUOHTtoFQZ+ioUG8aKCGKf1XsuANvqMXnKKegt5ng/IMow8GrJS5Nu3DjI/cr7yI3elxqyxgpKgsepAVQAemxQTTweqy4DR9u6iV1apZpWt4jXZI9K8z+FvSmtIgKi1OMs5868p/+OKJdmOSPKD36J4ijyjGCzn920lUPSdkeIJxvnOf6iq33C23T+WhRa3af+sP+bTYQQuhCIkzXTlDghQAewKPVVWJ/15eRxeqHX4hQW/y82Zu1whgVZyW3PddEdFGaCR32XggSuHmok2lVQsEgjrvdC7xepnEFEuGXUQexULzTR9H0MTHoLd0Nela87QVovOsEu9ukF0BuBuiy6huhkkn5r8OqOR/geyREpBl2FJJWBtz6ZkOsDAvuz6yTgE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(6916009)(9686003)(53546011)(6512007)(6506007)(86362001)(26005)(41300700001)(6666004)(478600001)(54906003)(316002)(6486002)(966005)(38100700002)(4326008)(186003)(83380400001)(2906002)(66556008)(66946007)(8676002)(66476007)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O8dedp+Mm7NwuXYlqjH9+AXrOgpxoL8VkS4elw3KFDNAcpCeeDMkuyFjQk16?=
 =?us-ascii?Q?ff6Tjn2r/UZfExBNZh9Cj0dgcXwX6dF2ONHysuMtdSOC0uj6yyBieVm8pjvg?=
 =?us-ascii?Q?a3jNDp0PzMZM0G4QNiw1vfOgKwf98oPaLlt2YxEuO50mmpX8yvAthlTQfyTR?=
 =?us-ascii?Q?+4sskiy9MVo3HhBM2VrzjNCDlp6KDI9P8vC2TyuIjEIYGKsNi6Nt//AWrZu/?=
 =?us-ascii?Q?5gyPGikgLIwNUlnVZ2C1M2E15QZm5AqFNi5P8G6DBOJU1pp7SwpQhdpeDYZa?=
 =?us-ascii?Q?4C7AyU/PhLyeg3DcTeMxNbE9BjXMB5xxpG0ZLzhJnRPtZQONHKfN0u96xWE0?=
 =?us-ascii?Q?eoV4ZBDNhyGLD2xFsSXKFQ7NwFykt7dhiCE1aFLTsruSt/yLStej135AaD+b?=
 =?us-ascii?Q?IResDZLewg5d971IJPDmLC93RmNOQ3vLhNhUd3wF2XC6aM/3R+gVR/mRi8Nu?=
 =?us-ascii?Q?Z2ZJ+lX86slTrAqMvWgQQ2jWMRyxbJgIBwv5KLqmsOTRm9/ItEVr0i8KnJvI?=
 =?us-ascii?Q?08nKjPDM/egNYtt1f+UwenGkp+Ht/mRxkAxFNtXDEelbxhWb+9bJAB187/2G?=
 =?us-ascii?Q?K6ShDs0vCvHgYrPHY+Xy9+J555vRc/Yfk9ieZ3NUf7/LOH9WXJYq7gsORe8r?=
 =?us-ascii?Q?BTqkcyzcmou8zszgpeaWGVI/feUvd9INZuhD7lzzL1D8awMV3JYgkF71yByC?=
 =?us-ascii?Q?jnM2wtTiVrwaErbloogqYOKHdHgGplBRitiQ8+SGzRT7V1zqXDrT5RZakYR5?=
 =?us-ascii?Q?txPYqkbwSAkuczNsOWuKzMc2I2A8t6fI2fSKKK45Ce+KKEiJuLi/DBiau6iH?=
 =?us-ascii?Q?359WjUqCkv5HceK5aIHWtFtflRRJBavbnv9cGYFfz7oCrrPKTIGuKOzqSoO3?=
 =?us-ascii?Q?I7HtcPYzP5vNsRgcB8uKJCHnYc1fVlxJhxGgBFrUFRW5hfTZJ02J1x1t6z+7?=
 =?us-ascii?Q?71uSHITtpwh+hQD6GAun8hL8r3qJD7UyxUS+g+fsRjRMD8yNXDECf4SaUI2h?=
 =?us-ascii?Q?HxH3B+MasLimB/UwWQWBf2tns2X68j9ZQwz4018lPTt0jkVhq2aZgaqa5Ltv?=
 =?us-ascii?Q?VuApVhlN7rUekClH+lmovSDwgYFx10ukPxJUDSaCHNtXpzqFvcxBfJBC87e/?=
 =?us-ascii?Q?WoT9gxn+wHzx0taNfm0AsxOaD6B6gqpj9oNQDi7zNC4VrPTCaQmCXZdUJUgb?=
 =?us-ascii?Q?bb/debE8VACa9z3RjYlkOxUq2Z25x6ZjKvCU1aFPlio0rAD8ALEzv2GkimcR?=
 =?us-ascii?Q?DJBE3wLHChXL2uVizSGtonKNZXwUbHEGLn9wu3TA+9kYyMbWxCKlZK3qx0ss?=
 =?us-ascii?Q?lJ0l4lMOXosb/hy+S/k1PO8QWsabYDhgRmHPwdE+NXCCwuV6ReHpwm6HlSs3?=
 =?us-ascii?Q?WACdddRHW2tLFyrcjlCRCAywG3G8QJJPEzC95pqsJfmJ/lOTv60Ebgw1HSJD?=
 =?us-ascii?Q?cYiH2PkrlRRFGI0g7Q2DQOeIx130FRh01UrmOK+gDUW3xAWksYS8NE26bUmY?=
 =?us-ascii?Q?Grb8OSkgybTiwrU6Wwf7IVW8pi5t2xZfWeM/Q/r7f6nZaS94EqxfQwKCLAOu?=
 =?us-ascii?Q?5Q2zWbdTkWkYr0g0WOvf8aeegk+TSgoF1g4E69NW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a175061b-2a66-4e28-a568-08da75ae1177
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 00:12:50.5721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzK9cH2fHgosr2oQKDa02pMg8ct2O3T1EH/wskOd0b2YXmfUEnQQE2rmcufghTdkGU2tJDrIts82TofPxoL1/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Pasha Tatashin <pasha.tatashin@soleen.com> writes:

> On Mon, Aug 1, 2022 at 8:32 PM Alistair Popple <apopple@nvidia.com> wrote:
>>
>> When pinning pages with FOLL_LONGTERM check_and_migrate_movable_pages()
>> is called to migrate pages out of zones which should not contain any
>> longterm pinned pages.
>>
>> When migration succeeds all pages will have been unpinned so pinning
>> needs to be retried. This is indicated by returning zero. When all pages
>> are in the correct zone the number of pinned pages is returned.
>>
>> However migration can also fail, in which case pages are unpinned and
>> -ENOMEM is returned. However if the failure was due to not being unable
>> to isolate a page zero is returned. This leads to indefinite looping in
>> __gup_longterm_locked().
>
> Hi Alistair,
>
> During prohibiting pinning movable zone development, there was a
> discussion where we figured that isolation errors should be transient
> [1]. What isolation errors are you seeing that lead to infinite loop?
> Why do they happen?

Thanks for the pointer Pasha. There were reports of qemu running into
the same zero page problem you reported there, see
https://lore.kernel.org/linux-mm/165490039431.944052.12458624139225785964.stgit@omen/

This doesn't directly fix that problem as we need to allow pinning of
the zero page, but it does prevent the infinite loop. I was going to
re-spin this patch to retry instead of instant failure however reading
that thread it seems the infinite loop is desired behaviour. So will
re-spin this to leave that in-place.

 - Alistair

> Pasha
>
> [1] https://lore.kernel.org/linux-mm/20201218104655.GW32193@dhcp22.suse.cz

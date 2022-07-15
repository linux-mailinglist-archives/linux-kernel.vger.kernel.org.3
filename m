Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0212B575F41
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiGOKVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiGOKVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:21:06 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3A852FCE;
        Fri, 15 Jul 2022 03:21:05 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=SS4aFzs3k+hQ33+NWocWc4qaeey311RwNBurYFOkekOu7zdOmOXCRGRa8+icOli2LqxkH2Ck069TvtjPvm800kzQDvq9Gp3eGZ9+M6fqDSAg2vDegbzIh9PpEtw/jy4DcMTj6gG97pCSUCenFXgcjSyy2IoXA8QqQo/887JmqNBi4Jk1qCRyQ1+kUADgiJ8AJGbgio8I8unwhjvwJIGJnJasSX2298I05GOby2H438sYQZzX8QIdEpzGyXP7FLn9Q42bzcY/sH/Mcnz0lJi4mtVH/rTUIMyVisgrnbJUVWYBBvrvfE4R7a9FRcoEK12/ugBIyxiCezObPqoc1DrwVQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDFHUzg14dB647fDKDIvt6NAJ1ASW5xn0P4HlzbE4Tg=;
 b=VDVIf0XEwWEWlHE44wxdYhX5NYYNVSsVEOPKmJMkY8aXNgRm01O72Z2MQbBs9lHAM8CWLSJRbRbGcTi3jaiUaRtbuYab6yIygsKWzKyl/oI02sb3TryLXvEsWdLJZlpOHyn7mc8Bdr1okUvznHm2KgkAznshLW3EhruslXMMM9b9JS9ZHIZVhKDxIBDmhcjDvo7CrdwmhXr++LZc7+M/A7MMo9k3Nb34sn9r/ZV0BJBLaIw7suRlGdfb9XmMdV5qw+kDLL+5BruinC/0z4NKkOZWLvlpfZKGelGhFJ6b/dhWOUisqwXqMt5HV/SAWwrb0TLQjYVUpNjrBzZP2R4rPA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDFHUzg14dB647fDKDIvt6NAJ1ASW5xn0P4HlzbE4Tg=;
 b=BXZnV0MaytjPrKEF0wd1OAzFKJEeJ45zJPgOzL3iIcOoJ/h0UVN2+TFicePY+Ctd88ArnnhfLVY315ZGYtZLhT5oF6Ui1s/Ffa1ov+2+rqpCYCbEovrHUBcGwXA6vyDWr9cZcyA/fB/qWPYMrQXVZ9c6Xe5kGNEqz0X5heFsYn4=
Received: from DB6PR0601CA0027.eurprd06.prod.outlook.com (2603:10a6:4:17::13)
 by DB6PR0802MB2152.eurprd08.prod.outlook.com (2603:10a6:4:83::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Fri, 15 Jul
 2022 10:21:00 +0000
Received: from DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:17:cafe::3a) by DB6PR0601CA0027.outlook.office365.com
 (2603:10a6:4:17::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Fri, 15 Jul 2022 10:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT012.mail.protection.outlook.com (100.127.142.126) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 10:21:00 +0000
Received: ("Tessian outbound cc6a8ab50b6b:v123"); Fri, 15 Jul 2022 10:21:00 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5f14568ab85f9ba8
X-CR-MTA-TID: 64aa7808
Received: from 8c6cbe42f280.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3A9011D8-FAC4-4CB8-9F3B-E8B1D348B968.1;
        Fri, 15 Jul 2022 10:20:54 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8c6cbe42f280.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 15 Jul 2022 10:20:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+CsUhfJool+aZRQyx3EWpGSyB2ATYlqdaQlzVbLb/GN8+DdQuhSsA1heZoNVT3o1m9mhZNyrkQfPFfIEBM9yWO1GDwcn5Kfg6bPBCNyd44P4QCl/sF9lLupJyInwIRQzYMmlYf42lT45vQ196Ghm2lm13tV6s6J2v1klMq1Q1LRR7wnMVeoULTUd7YtHi3QkmsR4M3zq+HpznMSo14FumNh75BClr1GxEnkAal46kvp2mWIu26LRzm1Mf+A59oEtubFI18++cUpMOQz7//1ed5F4VbuiqobTr5yQm4hRKcb7xYoE7008TI6OpLThz8JuBcLfK9RY3gqWu1pNq4r9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDFHUzg14dB647fDKDIvt6NAJ1ASW5xn0P4HlzbE4Tg=;
 b=NF9kgYYiSIvWOjtooDtTemq8A2VZxSldEtAvhgbydi/IvmHCN31dqiHhY3wnT1pS2IyC//nksYpULY/DM3zNYDFRKJvdAbalYTk88ILzdAnY67Jrjew5cHjlVM3KlLtqHMz9xt9BUcXDBIUSXESBiOnMtu5/+dNsNT65Vu9XzE5ltkmTJL5tDmtQYlxnfzwlBZvtnNE/sa0YWISQ0T1wvxQNjd0yGYfrR+QCYfLjj056cQWK3PMLiUVgPcr1rKDKbwOqkbEqmphPLdSTvL9d40pbNMQpv4SHft6BjmQ3hpq0Yxzr5IGX243vCzg59qgvmbSvqf5Y8Zh72WOjUT1byA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDFHUzg14dB647fDKDIvt6NAJ1ASW5xn0P4HlzbE4Tg=;
 b=BXZnV0MaytjPrKEF0wd1OAzFKJEeJ45zJPgOzL3iIcOoJ/h0UVN2+TFicePY+Ctd88ArnnhfLVY315ZGYtZLhT5oF6Ui1s/Ffa1ov+2+rqpCYCbEovrHUBcGwXA6vyDWr9cZcyA/fB/qWPYMrQXVZ9c6Xe5kGNEqz0X5heFsYn4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB8111.eurprd08.prod.outlook.com (2603:10a6:20b:54d::22)
 by AM5PR0801MB1876.eurprd08.prod.outlook.com (2603:10a6:203:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 10:20:51 +0000
Received: from AS8PR08MB8111.eurprd08.prod.outlook.com
 ([fe80::29cb:67e5:c030:38a6]) by AS8PR08MB8111.eurprd08.prod.outlook.com
 ([fe80::29cb:67e5:c030:38a6%4]) with mapi id 15.20.5417.026; Fri, 15 Jul 2022
 10:20:51 +0000
Message-ID: <7e8856ac-40a1-6fec-042c-c2a01775beeb@arm.com>
Date:   Fri, 15 Jul 2022 11:20:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/1] [RFC] drm/fourcc: Add new unsigned
 R16_UINT/RG1616_UINT formats
Content-Language: en-US
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Simon Ser <contact@emersion.fr>,
        Normunds Rieksts <Normunds.Rieksts@arm.com>, airlied@linux.ie,
        tzimmermann@suse.de, Liviu Dudau <Liviu.Dudau@arm.com>,
        linux-kernel@vger.kernel.org,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        christian.koenig@amd.com, linaro-mm-sig@lists.linaro.org,
        david.harvey-macaulay@arm.com, Lisa Wu <lisa.wu@arm.com>,
        nd <nd@arm.com>, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org
References: <AS8PR08MB81117652E417826E741154B8F8B99@AS8PR08MB8111.eurprd08.prod.outlook.com>
 <20220627175026.6a5dd239@eldfell>
 <05513f59-0bd9-77cd-36d4-41027bc339be@arm.com>
 <o1qcCo8e19pmmNe-YJbPkmu4SBrOQ_E3u7eqdrcXUzdBccLtFswL_ARTpbrX9C10tippuy5ieXAsqdf7H47JuT7Hqa1NlizAPqVuRM0kRt4=@emersion.fr>
 <20220630104725.602bff9a@eldfell>
From:   Dennis Tsiang <dennis.tsiang@arm.com>
In-Reply-To: <20220630104725.602bff9a@eldfell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::10) To AS8PR08MB8111.eurprd08.prod.outlook.com
 (2603:10a6:20b:54d::22)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c0143923-08aa-4558-7a95-08da664bb6e4
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1876:EE_|DBAEUR03FT012:EE_|DB6PR0802MB2152:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: nCq+VuDDxefKa+/dz+xlk/VAVQulq+SGrTpxD1B2XLh9orcUzedpnCJixBe7G6NcM65o51akt9tJRvMzOzATDeBSS7IKa8JGjLeh0p/vGIFR10hqz+loNm++BnctUKuLyys/1qJlyGlEa7pIBnXLjg1AUlyhMKJuw6DYIkNfkOqHw1JQUvjkPgeepK0Z/8xYauVddyG4nhi8C4u2Ym/lo7oGN7Y0zqnIJNEhrpmZre8w0DxXjyoB8ggsdwHnPhF147XFCll2+hQiRd2iB+sDHtwsvXj8oFwR5BqPwNXcSdMevT7X1VmKjqoTYlCmUFPbmyI9aEUEy6L19KYx1R6+cEjZIelAEnE3xt8r7VrQ38ctphH1v6JFYTOStXJ95h5ZIuzmIsfWwP6iXvat08Gh09jzJa1cPNVdo8pRhDVyJl1ANtPHdGFIXfRBJaRpaDkkBulsNJT0r/8fzTUx3fkXY+/oHOWBv3/GAHAoV+xWNXXKVcFo8bQtoUcHQ09tr+dREDo162tWLvTTNQpNOn4m7UMlV4lb+jJD8vjMziBZv2kTXYnIdiuJSz7Mmg0unczzsr1zyAa9hm6B9CvYimSSxIuJZoJFR/1VgrJ3dVuxsS3/p1U9HE14aSR3D5aWgwmQAd4bPh2JobUGRMGzTUknMM1tXpSFYvvNY12e51yzedK7EeDHBAtUDXUt6s3DjyD5F/Q1VDcTfNPNoyve1QBFuQ314dmKPJOZJ/o3r+ql4GBQ6t8rdE1gIjjSCUPEcraj4qGBzC6ocXVWW/ZfQd8T+CI7VDCFOTsoai6hu7RS03fvf8afrDtbVqs7huQdVTkn7pUppvIv5sBI++LKNjCHCalvxQeo54qZ+wG1oIZfGIaI7WzGISVthuWNorCx9s8r
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB8111.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(7416002)(4326008)(8936002)(6506007)(44832011)(2906002)(5660300002)(8676002)(31696002)(86362001)(83380400001)(66476007)(38100700002)(6486002)(478600001)(36756003)(6916009)(316002)(66946007)(54906003)(26005)(66574015)(53546011)(41300700001)(66556008)(186003)(6666004)(31686004)(966005)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1876
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d1e1b94a-891f-4110-3631-08da664bb13c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttZIAjPFon6b+9zRmR3Y6LrSyBdvyf52ADbjOrbNknOF116GPv6/MQTB2LuAzc0q3GVkZ9uT0AmHxQ2Y/PJupiVN9kRbau2t8XTKvr3pekzb9l8mCW+yoRuvTo38eHuMRZP10wA8FPn2gKejkYGSBLD5R/EuTY4hMmGmynuq4ALDjCeAv/jUc63MCoFuOOOArkf8oKBcT7lo02LPN7Kk/cM3lK/JE9n7hMfmxGKBDsIUhP0zS2sTqr058SVwDggLSKBTk9ijNiQh5zBlmEGwPJ4y6f9nTCkS+K42ZrYKcVdpWlFF+LhG/LNrXJKBogqWuQHBbzVHYrIJ7hVaBmQQfbfKiATRJA4Omi24/N3Bmgzppx8QTJcse98AW14gFarVJ3GVUdPY6pUMAX5jp0XL8nsvn8Lyh8tDxw8kCY9FhfdFAV9a/DyVAjAvJi/WR7YsP9bSzGqBC6Do5rXKmRyGiUQcDgSxi9Zk60E8XoI9KhnAO+V9hsqb9lVtr/LF3aXmesanXIObB8FU+Tqj3D1JEMRXKJ6zySFubrXKGoLe/tP6CYzmWTDi5Fp/URPsM9b3q29h449/ksY85c155c0UukAlGwLxcl/6fLYQAgVS1P1L7zsOwLmjYCVAZM8btBdEydX29oeJUrfsLSVi6fEa4vXKq10irOXvbCWh0yqRKTbw+yFshmh+VfURR6WpxM9g6hafekWsZPMpw7WQrMAgcTe7ucs8X8Y3wu4yFISiiXhzojN4fsnufOtEcWu6QuBkTgRhJgMa84RKD8p3qN96ZTYnrB1UZZQswrw0ZNRZxIs2VoW1SLR+246Brn7FY5tm9EtqgUFvadXX9zLfEpEdhe2qzAi6x9D5Y3jINQhsfg/CLloJkIpWMMXW7if1RvDX
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(40470700004)(36840700001)(46966006)(186003)(6512007)(26005)(83380400001)(66574015)(2616005)(2906002)(41300700001)(40480700001)(31686004)(36756003)(82310400005)(53546011)(36860700001)(6506007)(6666004)(44832011)(82740400003)(54906003)(81166007)(356005)(5660300002)(6862004)(8936002)(478600001)(450100002)(47076005)(966005)(70206006)(70586007)(336012)(4326008)(8676002)(6486002)(31696002)(316002)(86362001)(40460700003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 10:21:00.3353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0143923-08aa-4558-7a95-08da664bb6e4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2152
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 08:47, Pekka Paalanen wrote:
> On Wed, 29 Jun 2022 14:53:49 +0000
> Simon Ser <contact@emersion.fr> wrote:
>
>> On Wednesday, June 29th, 2022 at 16:46, Dennis Tsiang <dennis.tsiang@arm=
.com> wrote:
>>
>>> Thanks for your comments. This is not intended to be used for KMS, wher=
e
>>> indeed there would be no difference. This proposal is for other Graphic=
s
>>> APIs such as Vulkan, which requires the application to be explicit
>>> upfront about how they will interpret the data, whether that be UNORM,
>>> UINT .etc. We want to be able to import dma_bufs which create a VkImage
>>> with a "_UINT" VkFormat. However there is currently no explicit mapping
>>> between the DRM fourccs + modifiers combos to "_UINT" VkFormats. One
>>> solution is to encode that into the fourccs, which is what this RFC is
>>> proposing.
>>
>> As a general comment, I don't think it's reasonable to encode all of the
>> VkFormat information inside DRM FourCC. For instance, VkFormat has SRGB/=
UNORM
>> variants which describe whether pixel values are electrical or optical
>> (IOW, EOTF-encoded or not). Moreover, other APIs may encode different
>> information in their format enums.
>
> Yeah, do not add any of that information to the DRM pixel format codes.
>
> There is *so much* other stuff you also need to define than what's
> already mentioned, and which bits you need for the API at hand depends
> totally on the API at hand. After the API has defined some parts of the
> metadata, the API user has to take care of the remaining parts of the
> metadata in other ways, like dynamic range or color space.
>
> Besides, when you deal with dmabuf, you already need to pass a lot of
> metadata explicitly, like the pixel format, width, height, stride,
> modifier, etc. so it's better to add more of those (like we will be
> doing in Wayland, and not specific to dmabuf even) than to try make
> pixel formats a huge mess through combinatorial explosion and sometimes
> partial and sometimes conflicting image metadata.
>
> You might be able to get a glimpse of what all metadata there could be
> by reading
> https://gitlab.freedesktop.org/pq/color-and-hdr/-/blob/main/doc/pixels_co=
lor.md
> .
>
> Compare Vulkan formats to e.g.
> https://docs.microsoft.com/en-us/windows/win32/api/dxgicommon/ne-dxgicomm=
on-dxgi_color_space_type
> and you'll see that while DXGI color space enumeration is mostly about
> other stuff, it also has overlap with Vulkan formats I think, at least
> the SRGB vs. not part.
>
> Btw. practically all buffers you see used, especially if they are 8
> bpc, they are almost guaranteed to be "SRGB" non-linearly encoded, but
> do you ever see that fact being explicitly communicated?
>
> Then there is the question that if you have an SRGB-encoded buffer, do
> you want to read out SRGB-encoded or linear values? That depends on
> what you are doing with the buffer, so if you always mapped dmabuf to
> Vulkan SRGB formats (or always to non-SRGB formats), then you need some
> other way in Vulkan for the app to say whether to sample encoded or
> linear (electrical or optical) values. And whether texture filtering is
> done in encoded or linear space, because that makes a difference too.
>
> IOW, there are cases where the format mapping depends on the user of the
> buffer and not only on the contents of the buffer.
>
> Therefore you simply cannot create a static mapping table between two
> format definition systems when the two systems are fundamentally
> different, like Vulkan and DRM fourcc.
>
>
> Thanks,
> pq

Thanks all for your comments. We'll look into an alternative approach to
achieve what we need.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

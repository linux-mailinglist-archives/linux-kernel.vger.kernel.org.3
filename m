Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B314E55104C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiFTG1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiFTG07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:26:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481063CE;
        Sun, 19 Jun 2022 23:26:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsSIyIpLXytB5qj966v0qnMBCxQtxd4qisDNMCSfg1oMzDEV14NRA1LNMA+GnM/oq4ZR0BdyK+wTScQffU0l88UojSa3FHCQHFlSrxXrKf0yaVY6P0UQnBlW1dROsQisz5RGOAlRGerGCuV9A1vv1h1PNfYrxRDlsC3Zo2E1S98nqszD2IkmslRNtDyJcHBawDakhIVpcfAHjbFlM4CYOnvGEA8L12ZlVyewaZEyZDBd+k/ZkGWfcadeNXea5q7T03raqutO+gcUpwaerK93caLQTQtKRJJRnHT3RTzVT+wgoxZFCKw/Ya4y27xP8Vp0T0dhslDnaQVR3JgnwfHNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0k5h8DfJ9x3nFifAScg0XFtRwmUc8DoJj1cWQL7tnI=;
 b=BNZHc/gQzVy4ua5RlthozBE77GdH/USiNrx9Lr9xoMVPdQJ3lgsHCi9i0rLQY/2K1l/hECWsY+V9nWRw4u9GuKqu2IMI3GNDOvlmlNhsgeVLqrXWv+dpnK7wE/tz1O3GAbnFYo02YnPVEoW73KPwmTXtYM0vIubuiw+72A5JX92IvVfsGxWeyiQ2su3YtUydZhXtuxHO9kK6+O/hosgToUKQwNTtiJilUynnkVXG0PTA9+4UW+HK4XNVv2Mj8+i7+rX8Eq3g0zx6mZ76G/vgj2XFRK3OmC6JhL6k/25I+zZ6oEVa9+dujJCd0UDpKLyVNRYLCYco9CzV/w0+7nqscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0k5h8DfJ9x3nFifAScg0XFtRwmUc8DoJj1cWQL7tnI=;
 b=26aYTRKwmvXHkpSi0ZLvm66roKoeMQaXj32NZAG4waXLE6H1BQ71jz+y8kpg0JHiooAbXH/kJDvGF4N5IbiVZpJlmxbDYqWWl75AlP6Z9V/sPUQpydfcBUVBgsWlcEzumdSfrYFuO6qkHFU3Plt50Qm/33uJ/B/+lr/aaxAzYVE=
Received: from BN6PR22CA0049.namprd22.prod.outlook.com (2603:10b6:404:ca::11)
 by BY5PR12MB3809.namprd12.prod.outlook.com (2603:10b6:a03:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Mon, 20 Jun
 2022 06:26:55 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::f) by BN6PR22CA0049.outlook.office365.com
 (2603:10b6:404:ca::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.21 via Frontend
 Transport; Mon, 20 Jun 2022 06:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 06:26:55 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 20 Jun
 2022 01:26:50 -0500
Message-ID: <d780076d-ed24-f656-46b1-4d78cd0a17c1@amd.com>
Date:   Mon, 20 Jun 2022 08:26:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] gpio: gpio-xilinx: Check return value of
 of_property_read_u32
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Michal Simek" <michal.simek@xilinx.com>,
        <neelisrinivas18@gmail.com>,
        "Shubhrajyoti Datta" <shubhrajyoti.datta@xilinx.com>,
        <srinivas.neeli@amd.com>, "Srinivas Goud" <sgoud@xilinx.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
References: <20220617051921.3801832-1-srinivas.neeli@xilinx.com>
 <CAHp75VfREw2F3bXDeS8O1jm0r1Ksj923jZDne9UE5vaHM+V17w@mail.gmail.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <CAHp75VfREw2F3bXDeS8O1jm0r1Ksj923jZDne9UE5vaHM+V17w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13868718-87af-4c9b-9dd3-08da5285df06
X-MS-TrafficTypeDiagnostic: BY5PR12MB3809:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38097757DE9CC2BF7747CB8988B09@BY5PR12MB3809.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2Dkl8K+x8QhPNSbjBd8BssM9tBnSppsvEBzyxH7dqkacwvUpCXakUl/uVmS/vP2ECN7MQS4I0pKTytW789vnnMKV/y5zc+CBh4a/HG9g7JIa2Sg+pKJVlMSW531KbPGQRJY6Wl08yAxQCvoD2J+hqUTYFSUyRAWgEKJtepZS0IeXWB7VpUzBlDSWiNz709iAoEZdPsso5RX1NutKyunWZLiAzI9slknjjWx3yeNg1tykWlXTT6HQosr/rMkVkT81hDokvAa4BcJCgExDU1eSAEBJoPwn6hE5EpVxEtxxFuKpcsQAEJmKWJ0hIAX0aad864tPpCywQGMu9qbxHKXSGw68x9+Erhppo0w1ALGxAdm8hOM7erHBuibItHpIOodM8MkCKgbo9+u9CDUm23mZhd3ddE82G8sM3D5gPjY/oTTddUB4biDB3NMyQlnEegvs8LeezpTDIdORXV5f5Hco6kn8OdcXssYJV6Ovny4iKMLQhMv4MjhKKOqG0KOd8iymMJTdxQvU2XoD0k4lS0Lshnfl7REryzdPhmZptDI+xbpG7+uPBE/by6lOZzo5yMhj7GFJadoybhofKij6n6JeyUTmvEgHMYYVU07kaBuw7yiBdKlQcJuKLJAVjUNRxKwKCl5o7qTuU/mPqDC3f/og4oMHLMnJ9biwRdEDv8JG2pVl7zba9nfLc8eeobYp+OMKleln5u3NO0GJfc729jULd6QcK9xDNhozbiblbbdTPYCrk6gD0xAfCrSYKjx/xob
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(6666004)(8936002)(110136005)(82310400005)(2906002)(26005)(4326008)(54906003)(356005)(4744005)(36860700001)(86362001)(31696002)(107886003)(5660300002)(426003)(31686004)(336012)(47076005)(40460700003)(70206006)(36756003)(2616005)(16526019)(498600001)(186003)(70586007)(53546011)(81166007)(8676002)(316002)(44832011)(16576012)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 06:26:55.1446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13868718-87af-4c9b-9dd3-08da5285df06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 6/17/22 18:02, Andy Shevchenko wrote:
> 
> 
> On Fri, Jun 17, 2022 at 7:20 AM Srinivas Neeli
> <srinivas.neeli@xilinx.com> wrote:
>>
>> In five different instances the return value of "of_property_read_u32"
>> API was neither captured nor checked.
>>
>> Fixed it by capturing the return value and then checking for any error.
>>
>> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
>> Addresses-Coverity: "check_return"
> 
> I think the best course of action here is to go and fix Coverity while
> marking these as false positives.
> 
> To the idea of castings -- this is not good style and (many?)
> maintainers in kernel do not accept such "workaround" for fixing
> broken tool.

Let's wait for Linus what he will say about it.
I can't see nothing wrong about declaring that I am intentionally ignoring 
return code.

Thanks,
Michal

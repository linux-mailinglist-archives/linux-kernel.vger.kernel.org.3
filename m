Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B17588C4C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiHCMkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiHCMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:40:37 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B34C25FE;
        Wed,  3 Aug 2022 05:40:36 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ZxGiZuEG3Y//t/rQ784RYcblFe08IyhHDxWQvmIDQ9GTuDCEp1sICABJf4kM2sli9b0aWwIrLlb4k9DBBoYopTdLHrmD6kSX3I0xqJfwX7n2DRD+vSJ2w4p2BUigjD81q1h6S+5jFsFyRBA2KNrr7tHwz4v5d1KR3qWWk3/ZfwvbWof6fAyCPCb5evGgMieFe5TMzgYU69Nr7539NX4twOn+ZOaon2pac/uDhjYTF8UraLFUH4Tw7NQMFZ+fKpOXWbLc49YzDNyrOaqtNz47XV15VoTfbGzANUOQ0QYTNaQCXY9QEP13tlXwDnCIBGvCE68/y9SyQgG1aQ2BYxJMYg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjfTQuk2g1WwYBT4t7PT7zN0SqdaSrsNyea9UT8qfXk=;
 b=Y0mMhfgtVuNNOXO4w5ZlbKbQz680gG1mKen/GCp3E5MusfzQck1u1bQqJ9jNvY7usd6TFLmbuyvVnp5m2cxWCfGu3/x+E6Kyf+Z2P6bM45rpbSATjia2eqblWkT0WPMlXw42jUdxUFqId0vfT7ihlzf4KS75hPQlja5cfR0h06gi6AwduqOicd0aeWP8prk0EuEy5/La7E+SxkNd0If+Gjb0u8j53Zj3ocRuVYQyKhbxsxj8bunPIg3dnRCIuyfZoHnltidN5/xvyGeE8sV0Y3XJ8W9m6pgpEw6RdcaH93GeW7gV1dtMdKQvMXpGV1H1bygZr2tuwXbwdqFEmJcjMA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjfTQuk2g1WwYBT4t7PT7zN0SqdaSrsNyea9UT8qfXk=;
 b=zynjBBUJTQ0Dl84ydsLB9RgSXAWmm7+bUA1nII0JUKvDF5ZgIhTp65HRSSWxb9MqhDYWFEmySpkp3lTnr1csy6jUj+jiD3iHVSH2/p43n2XV4arg3sq74VeiuBFrjYxJth4t0I+xcWOG2Y73KmGEXGhHFGVTqxKiWfuZlnqAS6w=
Received: from AS8PR04CA0017.eurprd04.prod.outlook.com (2603:10a6:20b:310::22)
 by DBBPR08MB4808.eurprd08.prod.outlook.com (2603:10a6:10:d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Wed, 3 Aug
 2022 12:40:33 +0000
Received: from VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:310:cafe::c2) by AS8PR04CA0017.outlook.office365.com
 (2603:10a6:20b:310::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Wed, 3 Aug 2022 12:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT043.mail.protection.outlook.com (10.152.19.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.12 via Frontend Transport; Wed, 3 Aug 2022 12:40:32 +0000
Received: ("Tessian outbound c883b5ba7b70:v123"); Wed, 03 Aug 2022 12:40:32 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b6d0c94528ea6eff
X-CR-MTA-TID: 64aa7808
Received: from 6db06d7defb8.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1CDA3B7A-82F8-44DE-AF31-2C5D70D39E72.1;
        Wed, 03 Aug 2022 12:40:26 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6db06d7defb8.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 03 Aug 2022 12:40:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkpX/QeeC4SH/s5p0J49iS3ps8/+ABoJolBSL84BUV0C+iy4VHiS/I6LFK/lI/NJElowiCDTnuuhco53u2R6VmkrLDyOg6zGnjG+i04J0GSPHCGoCh0Sa0o9LgJ85Lc0dsZm/v1EUUN+yq24Zck0WW0qBzQqcDAKYM5XcLiqM9GLOyswYOB4A11qgpCxuv55NEgohrotY2hQM5P246lKVRtJtaICFawJ8tjnejEKf8rnCAs8SE+FP7HkVJz0dXz9RnZ5GZLFrY7q/+087KFFY70wlj1UtL83wVASjpVjwkhVtwU7lh5AuwYOPjZ/7sbrM80PCKNaVS848IlZKbQSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjfTQuk2g1WwYBT4t7PT7zN0SqdaSrsNyea9UT8qfXk=;
 b=h5hWjcUVMHZWYHq2GPGNX7BTfNFav5jmA8E+fCi80YnWwU8HSTN7R/ZSjpMzpHTe3x9D3o+pYOHh8P6ERwTWTZV0+Dh2Eb0Lt+uNZ3Rd2KF+HuNJjXcQZruFMBJbMUzhpb8+DfyjSrvca9wGX7AghJbHOUSZN++Ilr4v6G+a4dm57dfdwWEf6QPj86skB0UFyPy/vFxNfOnZNwRxfL/b+DtIup1m+L4N29qlJMqamNpQMK5yX3yqPjp5afniaE7y1PQZocv7nA5e9wA68RO67ZMIpvkn38YY77RbuA5bHndLC7Y3GRvm/KcRqLv2t72RwmmWrTldJSL7YJh/JNcuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjfTQuk2g1WwYBT4t7PT7zN0SqdaSrsNyea9UT8qfXk=;
 b=zynjBBUJTQ0Dl84ydsLB9RgSXAWmm7+bUA1nII0JUKvDF5ZgIhTp65HRSSWxb9MqhDYWFEmySpkp3lTnr1csy6jUj+jiD3iHVSH2/p43n2XV4arg3sq74VeiuBFrjYxJth4t0I+xcWOG2Y73KmGEXGhHFGVTqxKiWfuZlnqAS6w=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6803.eurprd08.prod.outlook.com (2603:10a6:20b:301::12)
 by PR2PR08MB4667.eurprd08.prod.outlook.com (2603:10a6:101:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Wed, 3 Aug
 2022 12:40:17 +0000
Received: from AM9PR08MB6803.eurprd08.prod.outlook.com
 ([fe80::4cad:8ea2:a247:6bce]) by AM9PR08MB6803.eurprd08.prod.outlook.com
 ([fe80::4cad:8ea2:a247:6bce%8]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 12:40:17 +0000
Date:   Wed, 3 Aug 2022 13:40:03 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     Olivier Masse <olivier.masse@nxp.com>
Cc:     sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
        christian.koenig@amd.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, clement.faure@nxp.com, nd@arm.com
Subject: Re: [PATCH 2/5] ANDROID: dma-buf: heaps: Add a shrinker controlled
 page pool
Message-ID: <20220803124003.jftyp7zj2rnruhsc@000377403353>
References: <20220802095843.14614-1-olivier.masse@nxp.com>
 <20220802095843.14614-3-olivier.masse@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802095843.14614-3-olivier.masse@nxp.com>
X-ClientProxiedBy: SN4PR0501CA0023.namprd05.prod.outlook.com
 (2603:10b6:803:40::36) To AM9PR08MB6803.eurprd08.prod.outlook.com
 (2603:10a6:20b:301::12)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 56848dc6-7c48-4c8d-24a5-08da754d5b45
X-MS-TrafficTypeDiagnostic: PR2PR08MB4667:EE_|VE1EUR03FT043:EE_|DBBPR08MB4808:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qDRDIs8wyfabWCmbO7Wi4+2QwHwpzF486o7bIVHFTGYZam3wvnBALCereqdZB8MCBurwG8pKR2K66tvnjsofcFWHlV5j2Lv4KAvNnBZDYxXqxzWL7SZNBMVJDWfy8kE5KhRYpzmUXazv1DEzVjmvIDnvZSwQxcwKUZnjKKcyapcEiG4059bTFIxH/ypurNJ73BFYetmDbosedJFE/JMPYNUxi93j6waEMNmgU3lQSC2ZQA+0QiX8/CkwDySbTyptiwT8BBDPhmDkUZ7VVqgXXHX+igRgKp8jT0XDk+7aJyk7NdmwC2D0hsDAhet+lZRnEwiea1mHE3PXCkJfKKYFEdxmRIQ9kl4LbM84V04+Zu5lYp32hwectBgmhrBd0n9+ZXmF1+NNSO1nf7aEBe0wf9CrgsquutTkKmOx71s6FoKqniacteL13O21J+75U5QaEW67XnvF8CH0PIKWIcwsejQzcKP9yFJRcEOIZhQSdxJlIPKQC9e1zdSVQUJi773o2ROEhU/flBAJsLdW9M3yvD91dEdEMgsZvqvRDTZjYpnVAvKCmIEMf/a6CILHk+kn8yzuWY16t5xNG2zo/h3jDDsvvxjub/WILYhgeG1ZcstOT2I13JIbAy0z7PTRcCSwPe79k7RHREXI7Fvj//dg7PMuPLVEziwrvKzwMDOAoUyEMupym2nhPSshD2g2zwAgfp8bozlaTCSy8ZxXM+1Xea4JbPlZPn3D0DHCI3n1FF0j0TVcm9UtjuWq3M923aCo
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6803.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(136003)(346002)(366004)(376002)(396003)(4744005)(5660300002)(86362001)(6486002)(4326008)(66946007)(33716001)(66476007)(66556008)(316002)(6916009)(8936002)(6666004)(26005)(6512007)(186003)(9686003)(8676002)(1076003)(38100700002)(44832011)(2906002)(478600001)(41300700001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4667
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 940e4208-0a69-4f46-be5d-08da754d5217
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mkbxA3ZllC+vBX8VE9hL+sRi00AiFaPCyeDqLG5LIen+BuyL+zCmrA5Xb0GE03IYrXG6WMeTWTMT/qU4CVpTZ4sOjr5oU0TXO56OCuOyBrVRlmXb4+wq4mB+zUIf12nsnConZ3vnmgcSpN700Aj+ebLid/HLjSICDZSYJzqVNhot2NnfCQvtveyinzWQKZYZJGgo77wcVF98oQgHWiQ9BLkkjhg8OLBPRC60FQ4vy1yIc6F0DvK2vRvyEHjXzInD62sVbrzI1g0NBXT17+TImHt/nV5AY7jyeSREnBTgbTxnuZ5O91b8xUXtx4u5rJbD5PY6XcfCQtd5EHshvEiRQb/vmGGvUoo35JB+uG35z/FbH+Cxpc19aHaD/Vcd7xZWLZNKjvte71G7yXjN3/jo6KsVXAWI0PsIL33pQjUtpubGzmssMnWCKApmUBd0pz0sBfPndYWr6+sF3ykvYNT3vH7A0+caLc9+ikkmYw4Gn/0ZWfW3dN92TdFVthnasfe1qIHfDztcpHhIoTgowpSIIlPxuVhRiNLuBfurtnfQKIz97kVKfRoLmeUM8zEVXwkpH+8JyiA1v1Cl7YMzjEMee6IapLYWFcOKrV3u17Ypk9SG/T6dgYK3Rlpb1tF8xCgFS4FIgXiUkuRTFvDYFRH8/mRdqlSUY65m/ZP777aa3srV7kUl6Z8I/SF6/2BY+JMcOXdDCcPVqVqc7bJU2/V5KcnoMvsQwDahkXmgVJgyafCRHnYyK461c9emX2iy8Kvve1RZJPxyJvjWMrBNOG0QA22rwUk3CwsGeIuS58gLKobwLFu3CCbEwdWtHg1SkTv
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(376002)(396003)(39860400002)(346002)(40470700004)(46966006)(36840700001)(6506007)(36860700001)(81166007)(6512007)(41300700001)(26005)(5660300002)(9686003)(356005)(82740400003)(82310400005)(33716001)(316002)(186003)(40460700003)(6486002)(44832011)(47076005)(336012)(478600001)(1076003)(40480700001)(70586007)(4326008)(70206006)(8676002)(86362001)(4744005)(6666004)(8936002)(450100002)(6862004)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 12:40:32.9129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56848dc6-7c48-4c8d-24a5-08da754d5b45
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4808
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier,

On Tue, Aug 02, 2022 at 11:58:40AM +0200, Olivier Masse wrote:
> From: John Stultz <john.stultz@linaro.org>
> 
> This patch adds a simple shrinker controlled page pool to the
> dmabuf heaps subsystem.
> 
> This replaces the use of the networking page_pool, over concerns
> that the lack of a shrinker for that implementation may cause
> additional low-memory kills
> 
> TODO: Take another pass at trying to unify this w/ the ttm pool
> 
> Thoughts and feedback would be greatly appreciated!

Did I miss something, or is this not actually used anywhere?

Thanks,
-Brian

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B854DC0A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiCQIKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCQIKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:10:04 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342CFFD3;
        Thu, 17 Mar 2022 01:08:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbKhmSRSXJi67ME5GRuD08frqt+zjM3bXtA4lJt7dhkbh3TCmzzWD03cEf+i+fxlxGKjFwBstT58MNm+bzVBH1z2jj7WrfKloSx0W3v97QZu6oRvGZdGelJVz5NWKcAF9LeavBXARBhVFzUXGW7ARmoXe+OVMc5xUpo2enTtAJI72FCCa+aJkko+e6vm4pb8nvYrEjKxEBYEtgn0fuE7LODJdFSgW8QgG10agf6R0DF7/4BSpmPKGvR11ppEPt/6ppfXFq9yN0vz4rGDSjm388ehdhG+Bv2PII7jZZIOmtLiBp+jRNHxXtkK7l7sCJu+qUB4TJtlXZdrXYnotc0hTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOisuQ8HRTL5O7T2kQInpVOaFPhK11Q9Cp7LbWXvS1w=;
 b=I46jaxu1AQ5iuTFViYriXBpudTiTUj1LUTynvw0Ta69piXJzoIexAgL2jdRsPJI5NOwndoTyUQTb/Cir90JeRGbzGfN9vvYcb3Wydo5euvv1dBWRZZzX1yeD2vNqhejwvFI+d/+r4aP3zO6jiOeST+slLjGMNN9tRqtx+JUrxtER3m6f/hCIrExCKCch5aZoPMwuOjJmE9lQoXfSsxdwOob3PqNU0acb9ycJ35UW3ooLHW6XU36iOD/fAzigWrA+UDf59RdkTjd1Jex923k+gt+jxDKTy2xAEUPCuTDXwGUNLxBl5UgtV1jxnSJMLwYZzVtN8C+WkL0PlqRXcSu4yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOisuQ8HRTL5O7T2kQInpVOaFPhK11Q9Cp7LbWXvS1w=;
 b=2ZKVYj/gpG6vn9/48jk5UVu0K8TkCs1itlkQMJAMKRPChD2VgoiTQFImdC8Vf8putxqb47wh7CvvvCwF4FJSOiswNv2vvv2hliaNi9+C9vzGGbqWeFYuxF0MwHhc/lqh4+WZzEyffinbYevMUO/xCV6LXgRseUbmDcG/vXsR00Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CH0PR12MB5267.namprd12.prod.outlook.com (2603:10b6:610:d2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Thu, 17 Mar 2022 08:08:46 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::38da:2ef6:d863:3c90%6]) with mapi id 15.20.5061.028; Thu, 17 Mar 2022
 08:08:46 +0000
Date:   Thu, 17 Mar 2022 16:08:24 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v1 0/2] ACPI: bus: Fix platform-level _OSC handling and
 avoid CPPC is not supportedg
Message-ID: <YjLseFErjHeKkluI@amd.com>
References: <4734682.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4734682.31r3eYUQgx@kreacher>
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06c0ca76-45ce-435c-3ffb-08da07ed5c66
X-MS-TrafficTypeDiagnostic: CH0PR12MB5267:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB526764F058CAA53DDB00FF44EC129@CH0PR12MB5267.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tSJ+O814WJGR8ZM/WackM4W4/igCaNy/+rP9T0giCFVMiIprlnG0fTLmIu06bVIzDS3SndrAB7PcEe/2RkceUzv735ff76PYeHKLkN1pBQVSRZ1u/WbVd/1NF7AK4tIGbt7B9XhYMhd9/ltMTR6Xnun+e/9YosY6PNBWRo7oJJOPJT2AxwnYGiw2NNyQeTIgJwukRr/cJo6jmlIMa+PdG8+M/4vjEa5QGF+2EV02mA9NSwZidUS6Eh6s0mAmMdAKATXVFbPwuclhb3IijZa6ZEnROEKVlBPEdPUqt13Sidif62BADBGeG+eayRlU0/40EsDI0Rh3q8EA/rL6vy0RDTZ+kvjr0Fpl1AQ8HLrpQVtF8iCnf+YH5EpoPGpAY2W+c8zRA5tfsel0OWCDijsUh1OPSR185IyEQOpr9HtiKtn3fYqn6OOU94cnHCTySjj+VPzylJqWxSo5B3zaCeRl7CNMtHRJErb7Oz57xBzSbkuOOlC3SKYdHA1JIBIqirs8Im3Mvfb1fq3DPPw0crmI0FeZY44tcJNN4hs4JRktnCFYoJGT5LaC0ILrYWg/uGcha4VRyiOzIW2iuaYSjdSPu96DUssPSrEgDA0jCPK5b0kr0ekhKFFwjwQbqLXYa+2BDcvIR/qs7xWA+pK9BPe2QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(4744005)(5660300002)(186003)(2906002)(26005)(8936002)(66476007)(66946007)(66556008)(4326008)(8676002)(6506007)(6512007)(508600001)(86362001)(38100700002)(6916009)(54906003)(6666004)(316002)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jNrbPS6UUFXauKkkAJJZAJnlPh8wbKIxEL0xIV4MPgNCIXjteiJlTgFkKaH1?=
 =?us-ascii?Q?TrUvcF2MMFo/cSjnVEr0pZ4gi8J9FCEsCh1pWQykktdqvpS/ho9kyUuVPZfG?=
 =?us-ascii?Q?wohN03KxS38ujH5UQ++LizhG1XS1n1aApgYM7Ucia4MXU4I9iOYhfXMaQliP?=
 =?us-ascii?Q?AcEtyQam3PR+b7/v0+mAKTe2HlsHaBTXp8vPP5+P1+6jzj36L0YjdfKYl3Uv?=
 =?us-ascii?Q?5brzaOffDCHNjGwqZI//XwN3ejxAx+xP5WAe+4Ls8E8YymJiEYw4XKRawPa5?=
 =?us-ascii?Q?KYJ3Nku2dXFymXIbq7x2dZoyz0Cx0fnQuWyBo8lQ8WJ0fRFjpguA3mLhXR6Q?=
 =?us-ascii?Q?APT5M1RJMldPTfvTcnMXrf0I72BM/tTULwdacu21bA9hv16oDyHPlmpiZjgP?=
 =?us-ascii?Q?/7g4RelSALMY0YWJui0wgo2yUmp8PW/RKkAF6GJRLPh2rKEVna37u16gJVlZ?=
 =?us-ascii?Q?fMhXpv9RaiZ9N3fzyYv6zP5u5SQsxfHg0cTBQQzlRqODC7x1T/npHQ0yHPsV?=
 =?us-ascii?Q?NKlgf0QA2pIOIEidBJksImuJeLkxBsPq0Nl1NFKDil9bLw16zT6IjfM2GNNb?=
 =?us-ascii?Q?vUbtoJBRTX18dLMA4KzXa48R8ZYCjkx+dVotxr4zGBDp+WSNbkpwne6A+OjO?=
 =?us-ascii?Q?ERp/6UtSmtrgZJbOWp0HJIxh7n2PWNUrJyis7c/wKhfpbcqWdZUdqxJCrec3?=
 =?us-ascii?Q?7J1rHaaSXxUsIaUSett5hGqRaUz4SrNdR6rDKFeFC0fhoUWpomCo7mwpA09C?=
 =?us-ascii?Q?vtAaiZaCcMsilr2epNLnhZP1U+Mfw+vJEWsx67p3m8cCH1Y8LC/jMEPP432h?=
 =?us-ascii?Q?9kbeoV86bOuW1YetP+3Ah4NZdBucpcYe4Na0k+UmrxQ7pTxloY2vvkg6GtjE?=
 =?us-ascii?Q?iKG24omvd9wLZAWyAgSri8DajH7Tu8VXd0i3UcPjgX9TfDjl2OxrEPm7/tgY?=
 =?us-ascii?Q?H5ZNUYC9B/kjbGQ2UsEVQUF9yULorbaEgm1mfIKWf3WmnIg6gBpd1H5KCm8V?=
 =?us-ascii?Q?tq2CowhPg7XYMATVCSjpFd3vomz/+/rrCQcpDNjpz9vlbLzQ3e/6pyA3sO8z?=
 =?us-ascii?Q?700vY29CIT8UV56B8S4N3ClLG/zKl8lE1leHjpr7jxeBUryoOsGh2VKMpP+b?=
 =?us-ascii?Q?FXW2R+juSObDSlgAmAM2GkRVK8UicMwwJ5WJvRsx6LxJnAByKNKIigBDaZvw?=
 =?us-ascii?Q?9G5Pwm4DItoK1StEFKnN1EtY0KIKoROxNoNnmmCWhIngzDPQp4ONIdSMVT8C?=
 =?us-ascii?Q?0QTOrn9vL3vGhvwXwWoY+hlgZlMhleCE8T7ZpY4w6d7q6EkFbhoGAsolRR9X?=
 =?us-ascii?Q?Z1z9gTqdIQEntzgOiup1Ag79HlLFUxXHrv29cHnS+p69MIVZuEOXM98872er?=
 =?us-ascii?Q?Ictr+s6zkTD57AzMXpGKuCQkVvBQ38rdgXxusKQa6sGoJYeGqbqwsFiA2IIq?=
 =?us-ascii?Q?pEoA7kXxy4JXcp6VieNajL+oVUGzf20v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c0ca76-45ce-435c-3ffb-08da07ed5c66
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 08:08:46.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6U4YMC2KMR05RguL762hRt07jJqyU9F9MjY64D+gICYZm2hUNvb4kuWIeEg7BJK1P3qBaKHgRpJXMzrAPcMUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5267
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 01:35:23PM +0100, Rafael J. Wysocki wrote:
> Hi All,
> 
> The following two patches revert a commit that caused the handling of
> platform-level _OSC to fail in some legitimate cases and address the
> CPPC handling breakage that was the motivation for the reverted commit.
> 
> Please refer to the patch changelogs for details.
> 

Series are Acked-by: Huang Rui <ray.huang@amd.com>

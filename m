Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0305824F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiG0K5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiG0K5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:57:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F610481FB;
        Wed, 27 Jul 2022 03:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxZlfxjwfYvQoDmjV5sQQNjsx6FbFPQeZnzh1+4Q/kK1CztHfP0N+FoB5vqUH66wGC17A/edGtSTVTu4S5vefLPr2R+4nqz2lFciCdQlWh1sPN3pLR9NWJFO4wSNSXAd6zRnHjIW/ARZ+gxtPPku0xqrDgHn4lMt6UFmNSu4wvyGAs7457R7mnxc0UbmFmDVdVjSmf7yiLbnydJsaWLT89SIPbyz2bRN1Zn9YzRpR2T8FpnqeEF3P0gaeH4z7iBrsx+vbO1dxqzI2DwOjLQ5kXmwVGFPCg74Em2nsue69DqiXThdma2jW1MR6qx2RmxNgZxF2QozUggGEjqniSIlew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8kcF++dkRp9S0tc9xhWmyGGjxGozINc4rkkqP/wL5U=;
 b=Tz2JFKRqK6lJxa8y82YG8EjQjxYQtxyHMEL1ssoRLG5YtiC+YNTWBo7/l1mWQNJfyzaxrvX4z5NBm8r65j121+TE0uAg9igW/DhAszYLUBcjyVJl2eb+J6n1xxsq+7IYaMCOzlC9nyFkDgJRQQKpNCOldOOog/oTme9vv8skagP6Zj0zE3/6Vcn2It0bHdFz44Zf3qoA7TYMBZeYQy7IKH6t3+aWPpCFZzF7R/7ini8z+TOA7xe2Xyt3GeIG8pksHnaju2p4GQJVqRQtVGkdmXlyqxB7znzrZuilTChxwsSgNNBkz1X7gjd7PKWR5PcFdSiO1p2dkDn4aasbiscICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=bootlin.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8kcF++dkRp9S0tc9xhWmyGGjxGozINc4rkkqP/wL5U=;
 b=29WII20LitXTHvSMmm25EUDJ6nAP5OjCwFfLVNndoQVjiUV/nD/KpAKqnSIoNDpJfoGLqYZ8bY8G5clRb6VdjCFaeLZB4ocsZQwMgrKTmXaTtWu29pDBeomTywDhtkHN/BFaeZalUr3A7uMwg1lKTP4RWyqYBNNIsrUcK0flw5M=
Received: from BN9PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:fb::7)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Wed, 27 Jul
 2022 10:57:32 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::3a) by BN9PR03CA0032.outlook.office365.com
 (2603:10b6:408:fb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Wed, 27 Jul 2022 10:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 10:57:32 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 27 Jul
 2022 05:57:29 -0500
Message-ID: <f95f3450-a938-27c4-ecc7-bafbb41f2f9b@amd.com>
Date:   Wed, 27 Jul 2022 12:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] rtc: zynqmp: initialize fract_tick
Content-Language: en-US
To:     <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-rtc@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20220727100018.3301470-1-alexandre.belloni@bootlin.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20220727100018.3301470-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a42f67c-881c-4bec-b950-08da6fbece4c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1146:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dt+JdaRG2hIBFtbcobKzHC5p+nNRLDclj5qRekuEgxoVM2vFK3AO6QZtlzmaSAYMgHgDRrCDcgkc79qr9B2+nyQj7SHAbEwh4CYacToql5uaYyKtj2MbE2wIzelimx4qL6sbvOQEcRGB/P9eCbH/cDFCyXZP7/poUKHA1A0vdoUCJyLSr2gtPN2BHtKg2CVYHtlLiXFYXrFE1kfdKoMutMe9m7TfTvW4GnJMoJln5S6yHuEveaKOxCl8pzvk0HV41eShIMBq1U2fFt8GONEtheoJ8UVbiVBJEgDsrZvHR3JMU4v66NBrY84o9FPlQP+xOQ5OLOHYBWELVP0aPK0HV/27bGO4SRmzPE/PrPuSV/sbyExxDZKcXc990ls7dIFgTMuNCQByo47z3fRCYPm5aTDEAhT0no7R7oduEwh/juZnUNdahlTJAf7rSxDYqNlTz9dU1SZa76O9Gx6YUI8OVij9gBfR9ZuKxc52aBgBL+eu7Rj2dkOQkk2FZesYPLG1XDYqyDaVxY0Nf0Pr792ugwh2l3Db51zD2uI/XOEvHNvjrnyxEyw6/MbAyOsiHs7b/XsLiU6hNnfRpNJl2uX7KMuSQCMbHMIJbXz1vrGl2ayjdL6KFfyRu8e2SAF76HS3MhY4d0K9BdzJvrLBOWNrSfGD2AgihFIt4N7cKxUCVESi2F1DXuN6W+Etk4qD5XJlOeGeCL8DPGQIDMK70ScIC1ceE3mZLu8WlJh4Tw/XzFS+Gmfh+43kmKSPCy+8akVpDqTH8c76U3rfvaJoCrTohQm8XIfDAENYpppMfrncuEVRXFKmEo+3ekpCrozt/qvVlR8oCcQrQMO4HJHTNPd3SAoqMg1DzSyHXk1l+FyNIbUlubEv4bSBu2oKO1NxhX8V
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(40470700004)(46966006)(36840700001)(336012)(426003)(70586007)(186003)(82310400005)(81166007)(6666004)(2616005)(47076005)(16526019)(83380400001)(356005)(36756003)(2906002)(36860700001)(44832011)(40460700003)(4326008)(31696002)(16576012)(54906003)(316002)(110136005)(5660300002)(82740400003)(8676002)(8936002)(31686004)(41300700001)(40480700001)(53546011)(478600001)(70206006)(26005)(86362001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 10:57:32.1169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a42f67c-881c-4bec-b950-08da6fbece4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/22 12:00, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> fract_tick is used uninitialized when fract_offset is 0
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>   drivers/rtc/rtc-zynqmp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
> index 1dd389b891fe..c9b85c838ebe 100644
> --- a/drivers/rtc/rtc-zynqmp.c
> +++ b/drivers/rtc/rtc-zynqmp.c
> @@ -203,7 +203,7 @@ static int xlnx_rtc_set_offset(struct device *dev, long offset)
>          struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev);
>          unsigned long long rtc_ppb = RTC_PPB;
>          unsigned int tick_mult = do_div(rtc_ppb, xrtcdev->freq);
> -       unsigned char fract_tick;
> +       unsigned char fract_tick = 0;
>          unsigned int calibval;
>          short int  max_tick;
>          int fract_offset;
> --
> 2.36.1
> 

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

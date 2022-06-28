Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B89255D32C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbiF1Fn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245055AbiF1Fnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:43:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9351CFEA;
        Mon, 27 Jun 2022 22:43:52 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=mp22rbuapJ0cU4EreN6ayo+fjIhCDVah8RPbLdyL+E6BAN4FQ3ztJl36K2kVgoV6ss5uFoVliYbH1YwOOWeZr/7M1t4nrLtMOMsTycq+juz5kWKymH8/XunuhYWFDl8B55ZT93BA3ltzFRoRbTWFQdtoHAileT/8KWChw6Z0FoIt8jWSwbTMS3mUYIJQgPDL+MiXzyE5RG9vyhWr0LO84fhzeOdBRzUAG/ZMRAYsTzazpFosSm3el2OoUgZXsxhnPBtOR6UGz0DU9qOiLjL88rWwsZXPksqm0i9a6uO/2gFEL0gam9cOI1fXkjW6zlm+7wgBcRLx+KmD+hSnHcrD9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37JVJNOOf6CM1VGEeviQjjr/beTHc6GHfwnQnAYHT9A=;
 b=Lc+qgqZQMLjNbIZuk4B5H8eo4+6faXNgzqrOlm20XjdIA1YKRKWBYfI3+ixaZePjI8degzz6pf0274hs3eiVRk91MrrNfsvsvBISNDGpXJh6JtScNTy+90t+J9kT1gmZQ3RgGB8fpcQatou7cvIWfW4m0RpHOaJ/ywkZKOjFbp1uX9tsON2gnWMLfgAOcvygxOENZnDxZiPqb9uHmJuddTBu/Pqg1eaFSbQ5UlPxieQqqQ00SMh42nLco/GcEBDaYVqTVHspqXrkUTbi/DG4WUIksOdKaFR2xvyqQiX9rUZ90lyFyvsrla2fhyuW3MJ+1rANeOMSL68P781jZip9Dw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.83.241.18) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=xilinx.com; dkim=none
 (message not signed); arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=xilinx.com] dmarc=[1,1,header.from=xilinx.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37JVJNOOf6CM1VGEeviQjjr/beTHc6GHfwnQnAYHT9A=;
 b=AFrVRT+78uMG6BWqxmU9uvyptzR8AzlgxqMC0hxtCRrRYf2myMT+9Eni55SArMezrA7mR32xkAhjlrHHN1Bik1uCoh6hDoUM8X7PTlpWL+TaY+RIuqjjT7xAZe/YNiCG3fgj0aONWzmugxyt/v8FYS4BI3SxM3xqh7Jd2IhsEa8=
Received: from SA9PR13CA0115.namprd13.prod.outlook.com (2603:10b6:806:24::30)
 by MWHPR02MB2541.namprd02.prod.outlook.com (2603:10b6:300:41::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 05:43:49 +0000
Received: from SN1NAM02FT0038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:24:cafe::53) by SA9PR13CA0115.outlook.office365.com
 (2603:10b6:806:24::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.6 via Frontend
 Transport; Tue, 28 Jun 2022 05:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.83.241.18)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 20.83.241.18 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.83.241.18;
 helo=mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;
 pr=C
Received: from
 mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net
 (20.83.241.18) by SN1NAM02FT0038.mail.protection.outlook.com (10.97.5.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 05:43:49 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net (Postfix) with ESMTPS id 85C483F030;
        Tue, 28 Jun 2022 05:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU+0vXj0qyRW7KZ2ZhGy4p075BGAMYnxnCje6Sesws0TxYnxBqiQxCptzjhuDxuS1qwU6lXEnzAEaYdxtk7blrH7/FMsWymWh3t6ZdYKFaiHzu55CIOahg7hiTY1OY0Gu0fePvaXl3Ke8As86F05mcLl0yk/oCTxlSxYY3+aNv3UZ+I3W6jR9mKBFFHDv1D12Y/8yUn0nqe1t4oPt0P15MFvT3f37bdd61T6ozWgOrgXC0zFqVM5qdP8Kil/2ZKPRMGY6Wjv+rNHRNbQ9kEOMOmVVFWwi5+hCtukF82kpK8vC1Mb4aYZecyld6ApNA4P4efwN10xWrLZvFeKsfXlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37JVJNOOf6CM1VGEeviQjjr/beTHc6GHfwnQnAYHT9A=;
 b=OdQPYrmWOVFvx2zQc1CkeAAB1FzdjnwqVgvY5H7m/haUmSXZYuQpj/Ucl1BAPivFZ9rPwOkzjmJVCqz/nH+fiaE/qoPqo4s9Awji7JVhmLaCYwx4VIaSrsbWXPbNHgIhfOJ9sPLv0sJoZ0V5lCVs6lBGuF5ipOsejL/8Al8lAiBlKIEzgrEG+pjhNhvSLyY8kF3jv/Cgmd8oW+BiqEve2B9/AlyDZIFPwrV89NnZOjwV8WcFjGaaOsF07ySJkgH0MW50u7jc2mRx9Q6TC3KzE5YjVA5cBB6pZI6L0ZdQx0g4/0mmUior3tdJK2PQJrLJMYj2P3SyOAd1eTjH2rz9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
Received: from SA9PR13CA0164.namprd13.prod.outlook.com (2603:10b6:806:28::19)
 by CY4PR02MB2824.namprd02.prod.outlook.com (2603:10b6:903:122::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 05:43:46 +0000
Received: from SN1NAM02FT0055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:28:cafe::ad) by SA9PR13CA0164.outlook.office365.com
 (2603:10b6:806:28::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.7 via Frontend
 Transport; Tue, 28 Jun 2022 05:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0055.mail.protection.outlook.com (10.97.5.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 05:43:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 27 Jun 2022 22:43:44 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 27 Jun 2022 22:43:44 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 git@amd.com
Received: from [10.140.6.6] (port=51114 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1o640l-0007Ut-WA; Mon, 27 Jun 2022 22:43:44 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <appana.durga.rao@xilinx.com>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <git@amd.com>, <git@xilinx.com>
Subject: [PATCH 0/4] drivers: misc: Add support for TMR Manager and Inject IPs
Date:   Tue, 28 Jun 2022 11:13:34 +0530
Message-ID: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: c1a65440-1ab8-434a-56b0-08da58c92cf5
X-MS-TrafficTypeDiagnostic: CY4PR02MB2824:EE_|SN1NAM02FT0038:EE_|MWHPR02MB2541:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: X1Ii2pe/nKzpdNqsHZ8Y7MjB5pTdL17iiEJ74X6m84/LuAdLOtvsz7qfvsniC9idRZeFZl5pt5xFCzWMEjysobaZV8ghEGZix/or87cQXXjid7pr8lJxiqlZZETZ0AH/6zH9le3jqNxvTcea8a1VbxPDJp6ytOQEvuepEoK7pMjQHHIv0LH2M6/Lo2GN+/9vpsl6g3uBhTyxTFGniVbEvpJWxMrnL35as347W5z/f/6KMg1j15n8bRn9hyyOMzPp7D/VjuvjaLfUzqUj2bMvPx2UWXCUUI/yV+EjTagDj6ogj4NCA8XHJFO8NUN5v+R6cI+sqOJ3vVpWhjJJjZM0QKbvLRoi/SmhD6jHP1bqfK7L16WqstqsfDSE3tBlQ6EspjM4reahvH2IrQeEg2eqfLIXRFmXIivwiJd3A6Xcb1VI6gOshxYtrU9toWXPs4ijq8+wFM/KYh+JTiXKrvZ7YR3IFbCBLv2B+zJ4Pq8YQ6to+NHXUO6JWlrVIKpdnGidC5+zvlk1AwjVTq3HbmKpXqBc5KPXp1trVYpjZxY9BRp+Et/XLA76eiDDnDkDoJBSLljuoMyWxuy268rMz2aNerroG19UV0NPrRTx3NqzW8xOyblRuQ81bMjMP7fq2ErdIY9tE2ThZzG7BFLgjedQH0WU0YHCYxJ0xHWrAz3/aXicFos+m9gXOgN+JUkQMRlHmRatl6kz9vvC3wk/aUZUAHpTe38Q8GdFO2YASt6TZG8TYApTDWv5iVcL62GVKWQElgS79G3Aunfw3li2fABu+WOEW4gSDklLf0t6TkqpcvrXqk4TZc7BbtpQ7fTyApD+vozoz0hTDHY2nxtQE5M/PP9Rn5VikcoXezJj0xE//cLp70zrKAoeyqB2/sKEswkNWfx6BST9/wcaYmXETKLXja6oGd6/3PTXgQiANCR0CC4=
X-Forefront-Antispam-Report-Untrusted: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(26005)(41300700001)(36756003)(1076003)(966005)(70206006)(40460700003)(110136005)(356005)(6666004)(107886003)(426003)(186003)(4326008)(2616005)(316002)(54906003)(103116003)(70586007)(8676002)(5660300002)(36860700001)(7696005)(921005)(82740400003)(82310400005)(478600001)(2906002)(83380400001)(336012)(8936002)(47076005)(9786002)(7636003)(40480700001)(102446001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2824
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SN1NAM02FT0038.eop-nam02.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7a59ff31-b266-4283-8730-08da58c92b07
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ORKN+w9HQFDkGnqGxF/5m03eRoVMn8JFJM6ZNHtMWAD5CZQG3M1gq2uie7P9?=
 =?us-ascii?Q?RFuEbMDivWi3esugYqaXomkisVxnrFcxhsDgMxmOrVX1GtUVWvkf3LOTkgR3?=
 =?us-ascii?Q?M0kKyT9YN4dLb5Lxg50kBOkoYLHpfL+j7SxfsyLDkvCrnSQ9auZKEt8J1jK7?=
 =?us-ascii?Q?6m/ZTXXPlOhUQfg78MQ68mCruc7Fiea5MD9Jx6/EI2vtl+d5i/OGoWXO+5/H?=
 =?us-ascii?Q?H5ljBzOJ6UzgbPDjtnRjeTqlmNY16WpxcqYady/gmb80xon3FLLzEAiExDwK?=
 =?us-ascii?Q?LaHPjkqAIPukhK/uAKIEbFCIoShXhDbOSdErT532gnObO0Aqn1U+EYJTO0Iz?=
 =?us-ascii?Q?JCtUALo79ddJut8sg7TsfBCFfHwui9/HB38UDQ8pLL70Pd+67zRKdpCwvAHZ?=
 =?us-ascii?Q?3lma93I5RdMvPCHV0jAkxSi4JrnTzakX1ZCEBuONaMg7wU2Vbp3ln9jLDM/b?=
 =?us-ascii?Q?V64aDR/V4EPEKjzKQqR6okRT2Qp7OX+VWnOsL/I3XOOggCUdFvwob6wszdzy?=
 =?us-ascii?Q?ltaOBNXdTLqtV0NpKxxL1wL8wTlf4dHJqV5xUSYFBAWp9OAmbkE5Mv4GlooG?=
 =?us-ascii?Q?6SSFyYi2c8uVyqhpgV6ZvZzk+Wpt+eyO7cQU0lWGTv1a8L/0LZJRsh10L5WB?=
 =?us-ascii?Q?JSYrgF1XjMe84jecUfp6wQo90j7dvX5ygRPm9qAf9ZyiLgffFxVbARtmsSNs?=
 =?us-ascii?Q?eAWglPHzQ7zE6YRAsQ9CwcdL0YcY4JFcyhyFpUb25tD3QiIpg3iMAZ+UyhmD?=
 =?us-ascii?Q?tPD/BMACYXqo19ShA4tkDTWEgGn9wzQWq16oX49482tuziYMSPlLkD12WPyH?=
 =?us-ascii?Q?+LqN2vV3eWa0qOs5Z5DDovDlviGdVpmYolPOsrN01FtAhLPnNDrelt85uxJ/?=
 =?us-ascii?Q?TzGM0ITaqSahtOjSI12hHtgwEXnzFOWZpCBuOdczQllSyiAUQcs4SO2s8b1o?=
 =?us-ascii?Q?/tJYsRUe4bBdsKIebAut9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:20.83.241.18;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(40470700004)(36860700001)(70206006)(5660300002)(36756003)(8936002)(40460700003)(41300700001)(6666004)(47076005)(966005)(103116003)(2906002)(7696005)(2616005)(81166007)(40480700001)(82740400003)(4326008)(478600001)(426003)(110136005)(9786002)(8676002)(921005)(316002)(1076003)(186003)(26005)(107886003)(83380400001)(54906003)(82310400005)(336012)(102446001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 05:43:49.1043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a65440-1ab8-434a-56b0-08da58c92cf5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[20.83.241.18];Helo=[mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1NAM02FT0038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2541
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for TMR Manager and TMR Inject IPs.
The TMR Manager is responsible for handling the TMR subsystem state,
including fault detection and error recovery. The core is triplicated
in each of the sub-blocks in the TMR subsystem, and provides majority
voting of its internal state.
The TMR Inject core provides functional fault injection by changing
selected MicroBlaze instructions, which provides the possibility to
verify that the TMR subsystem error detection and fault recovery logic
is working properly.

For more details about TMR Manager and Inject IPs please refer PG268[1].
[1]: https://docs.xilinx.com/r/en-US/pg268-tmr/Triple-Modular-Redundancy-TMR-v1.0-LogiCORE-IP-Product-Guide-PG268

This patch series has a dependency on the patch series
https://www.spinics.net/lists/arm-kernel/msg991887.html

Appana Durga Kedareswara rao (4):
  dt-bindings: misc: tmr-manager: Add device-tree binding for TMR
    Manager
  drivers: misc: Add Support for TMR Manager
  dt-bindings: misc: tmr-inject: Add device-tree binding for TMR Inject
  drivers: misc: Add Support for TMR Inject IP

 .../testing/sysfs-driver-xilinx-tmr-inject    |  12 +
 .../testing/sysfs-driver-xilinx-tmr-manager   |  18 ++
 .../bindings/misc/xlnx,tmr-inject.yaml        |  47 +++
 .../bindings/misc/xlnx,tmr-manager.yaml       |  48 +++
 MAINTAINERS                                   |  14 +
 drivers/misc/Kconfig                          |  20 ++
 drivers/misc/Makefile                         |   2 +
 drivers/misc/xilinx_tmr_inject.c              | 201 ++++++++++++
 drivers/misc/xilinx_tmr_manager.c             | 288 ++++++++++++++++++
 9 files changed, 650 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
 create mode 100644 drivers/misc/xilinx_tmr_inject.c
 create mode 100644 drivers/misc/xilinx_tmr_manager.c

-- 
2.25.1


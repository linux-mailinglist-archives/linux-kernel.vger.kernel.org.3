Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE46521CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345186AbiEJOxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344720AbiEJOx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:53:27 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E8126CC47;
        Tue, 10 May 2022 07:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOC7E1Z8kHpazh3bVwWDnROO66Jpjx/AtjhArG85UY7DzIrerLILaMAgoXXleSo2vG8GvA5vsspL7tL2M8WIJ2Zg0XVbUDarfSmGdj2zXXKv6+RKM+62UhxAH8lRwCv/7RI88orjZjz2sndRvH/SZwEiODfi89w8rqhm2CeMVHUxUGGxRokC7exaOba1+K+Gbu/RH96hik18VAGE2vlkfjZmsZxmG71vygn23gCO1V9KgNISHiyPy6YIcRnY4N5g2TpxWb93B9W/bg02tnOhF/Yd0e392YlXdhJ0BLdtbrciyUbK6NgTonuz/4FaMMVY5uStlq62gkYIztOPamdO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OmKLPaOVzojWH4HxZllQ+IWyMrJsy0mBifTwmgZkMQ=;
 b=WygVJIhPb2BlY0kk6MI8tRBWN1QmYYfAUrG9mAK8hM9dk7nv/JklwTr8BJGqy1hjRnibA268m95bajxNNke01Y+NKbk8E8IdNQDFKH7j1vzAuSWixxR5Xyc/aAK1Zz4jEGtPPAFF80ezx0W/W7ry4jqrK5kWC9V7tVhwq4QMDfgjSX28z6T7AXWuBQ0MYHfyhToemFYPm0Br/V8F+RTPU8rR+13ooGFBkD0Y+RKDcB3qX7xr4BFDBEAl2a4TIeRO8p+ZaqEr3qI9w8AfvuUr+dyCE3j67OT8AzrH0726DuVaJbZJrX9RkmhYDm3PKC/Poh58HAqpF2pYDq5nwDZb3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=linaro.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OmKLPaOVzojWH4HxZllQ+IWyMrJsy0mBifTwmgZkMQ=;
 b=PSEkzmIvofbaoDI7UCrT4LvhM+WAV5n8jPWV6r7V44tBLnfy3xARNai5edZje8NQIhcbCXy3RLJmsmaTTBtSd3JBw9MQ7w5bhBWH1zSPM09+4v8tLUF7kD26FvF9FazN00kKDVpWYXM2YHwh85ZQ+/QFLYDhvo8q/Di0H0pRK7k=
Received: from AM5PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:206:1::31)
 by AM5PR1001MB1076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:203:12::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 14:13:33 +0000
Received: from AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::d7) by AM5PR04CA0018.outlook.office365.com
 (2603:10a6:206:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Tue, 10 May 2022 14:13:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com;
Received: from eop.bosch-org.com (139.15.153.200) by
 AM5EUR03FT059.mail.protection.outlook.com (10.152.17.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 14:13:33 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Tue, 10 May
 2022 16:13:31 +0200
Received: from FE-HUB2000.de.bosch.com (10.4.103.109) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Tue, 10 May 2022 16:13:31 +0200
Received: from localhost.localdomain (10.167.1.123) by FE-HUB2000.de.bosch.com
 (10.4.103.109) with Microsoft SMTP Server id 15.1.2375.24; Tue, 10 May 2022
 16:13:27 +0200
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <krzysztof.kozlowski+dt@linaro.org>
CC:     <m.felsch@pengutronix.de>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <bcousson@baylibre.com>,
        <tony@atomide.com>, <robh+dt@kernel.org>,
        <dmitry.torokhov@gmail.com>, <mkorpershoek@baylibre.com>,
        <davidgow@google.com>, <swboyd@chromium.org>,
        <fengping.yu@mediatek.com>, <y.oudjana@protonmail.com>,
        <rdunlap@infradead.org>, <colin.king@intel.com>,
        <Gireesh.Hiremath@in.bosch.com>, <sjoerd.simons@collabora.co.uk>,
        <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>
Subject: Re: [PATCH v2 2/4] Input: mt-matrix-keypad: Add Bosch mt matrix keypad driver
Date:   Tue, 10 May 2022 14:13:06 +0000
Message-ID: <20220510141306.2431-1-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
References: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.123]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c010ec4-f57f-4252-abff-08da328f4467
X-MS-TrafficTypeDiagnostic: AM5PR1001MB1076:EE_
X-Microsoft-Antispam-PRVS: <AM5PR1001MB1076A7E25A7FFCB53466BEBCA6C99@AM5PR1001MB1076.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlwVCUplLxWuKFsTFgAdtgJf59gVP5EF9W4vkEkTpKsCvGjF6ycSYclXFW547f3SGqSs3mHUWdvPLSI6EyCG8Htx1PhIcKcOCbjTVICCXnBkgqA9C6daGHiT73LlmWqNRAHReFDRuPEya9q0E0rWh7WKeYp4EsCHujexVV3stL7rXUCt1lmryErMhvQ+nm4YOdkmh6YwMwM+9BVgSiG6uM48gOasBClxUBtuddGH7tRPc1AywcvJdPycgcKBj+vYGQgDhSkXRspY3Dqsae+zjF/4JddmhizHB9YuRMEK9bkHSQpQtHLfUw7sdAdUtEQze2/jKu9qNd5ABtE5w6VJ/dP5DuNDIh214UellQLF+p4eNWtfj6Xdvp9wNwW8hCMGTsBLtCADxZuzHt7Qo3ghewv44RWCkO2xuY0wosZgZDdATwGXPCy5f6eovJCj1XArTXv587EnITxossOU3L6pzM5ohcBzQQtjJVkrALrV2gvnq4JDVX50xUeLqxtK+Zl81wUyTtTpAhOS28+M4j+cHFoeDWWMA8rrMAnlfQ1bHac7vJlV+4vYlabh6x5unonv5KiNAPtXNbQ/sbbqgKjpTwQSWrXCH5o+S9dPYP2TXxml797uJnLOPTiZINgHO8D2zEOjsfGrv0c6uFtDHqcZlJqB6SwNgkMmxNtgAThWjaovWKiVoTyMWdo5Y3x953Qa8u17Y+oYzkb6umI3bOYraw==
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(54906003)(81166007)(82960400001)(4326008)(316002)(508600001)(6666004)(2906002)(40460700003)(82310400005)(7416002)(16526019)(186003)(8936002)(26005)(86362001)(1076003)(70206006)(5660300002)(107886003)(70586007)(2616005)(36860700001)(8676002)(2876002)(83380400001)(336012)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:13:33.4835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c010ec4-f57f-4252-abff-08da328f4467
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

Hi Krzysztof,

>>>> both matric_keypad.c and mt_matrix_kepad.c logically operate differently,
>>>> my openion is not to merge both.
>>>
>>> IMHO from the user/system-integrator pov it is looking the same and so
>>> one driver should be fine. To distinguish between both modes we could
>>> add dt-property or add a new dt-compatible like "gpio-matrix-keypad-v2".
>>>
>> 
>> as mentioned above our keypad is not complete matrix keypad  and it will
>> not be compatible with matrix_keypad diver. that is the reason we derived
>> mt matrix keypad driver.
>> 
>> to avoid confusion, we will rename the driver as bosch_mt_keypad.c
>> if you suggest.
>
>Sending a new version while discussions are ongoing is not how we reach
>consensus.

I apologize for sending new version.

>
>Make the driver as part of matrix-keypad driver or bring real arguments
>why it cannot be merged.

I tryied to put real hardware scenario which used in 
Bosch Power tool measuring devices.
Keypad schematic as below, it is reduced matrix keypad compared
to standard matrix keypad 

                     Pin8 (gpio1 16)-----------------------
                     Pin7 (gpio1 20)--------------------- |
                     Pin6 (gpio1 22)------------------- | |
                     Pin5 (gpio2 21)----------------- | | |
                     Pin4 (ground  )--------------- | | | |
                     Pin3 (gpio1 31)------------- | | | | |
                     Pin2 (gpio1 23)----------- | | | | | |
                     Pin1 (gpio1 24)--------- | | | | | | |
                                            | | | | | | | |
                                            | | | | | | | |
                                            | | | | | | | |
    |------------|---------|----------------- | | | | | | |-----------|
    |  Button1   |         |  Button2         | | | | | |    Button3  | 
    |      _|_   |         |   _|_            | | | | | |       _|_   | 
    |  |--o   o--|         |--o   o-----------| | | | | |------o   o--|       
    |  |                                      | | | | | |             |
    |  |         |----------------------------| | | | | |             |
    |  | Button4 |            Button5           | | | | |  Button6    |
    |  |   _|_   |              _|_             | | | | |    _|_      |
    |  |--o   o--|         |---o   o------------| | | | |---o   o-----|
    |  |                   |                      | | |               |
    |  |                   |------------------|---| | |-----------|   |
    |  |                                      |     |             |   |
    |  |------------------------------|       |     |---------|   |   |
    |                                 |       |               |   |   |
    |   Button7              Button8  |	      |    Button9    |   |   |
    |      _|_                _|_     |	      |       _|_     |   |   |
    |-----o   o-----|--------o   o----|       |------o   o----|   |   |
                    |                 |                           |   |
                    |                 |---------------------------|   |
                    |                                                 |
                    |-------------------------------------------------|


    ____________________________________
    | Button  | Pin activation| Keymap |
    |----------------------------------|
    |Button1  |	    1,6       | KEY_7  |
    |----------------------------------|
    |Button2  |	    1,2       | KEY_8  |
    |----------------------------------|
    |Button3  |	    7,8       | KEY_9  |
    |----------------------------------|
    |Button4  |	    2,6       | KEY_4  |
    |----------------------------------|
    |Button5  |	    3,4       | KEY_5  |
    |----------------------------------|
    |Button6  |	    6,7       | KEY_6  |
    |----------------------------------|
    |Button7  |	    1,8       | KEY_1  |
    |----------------------------------|
    |Button8  |	    6,8       | KEY_2  |
    |----------------------------------|
    |Button9  |	    4,5       | KEY_3  |
    |----------------------------------|
				
for Button5 and Button9 we used standard gpio_keys.c driver.

Button1,2,3,4,6,7,8 are not in standard row and column format,
found difficulty to apply matrix keypad drive to these button.

to solve this we came with vendor specific driver like
mt_matrix_keypad.c by taking matrix_keypad as reference.

after your review comment I felt it should named as
bosch_keypad.c to show as vendor specific.

in this driver all gpio lines act as row as well as column,
a key can be placed at each intersection of a unique row
number not equal to a unique column and they are diagonally
symmetric.
we can skip keymap for the valid intersection of gpio and
invalid keymap for row equal to column.

the matrix table as below for above schematic

    ------------------------------------------------------
    |Row\Col |GPIO 0 | GPIO 1 | GPIO 2 | GPIO 3 | GPIO 4 |
    ------------------------------------------------------
    | GPIO 0 |  X    | KEY_9  | KEY_2  |   X    | KEY_1  |
    ------------------------------------------------------
    | GPIO 1 | KEY_9 |  X     | KEY_6  |   X    |  X     |
    ------------------------------------------------------
    | GPIO 2 | KEY_2 | KEY_6  |  X     | KEY_4  | KEY_7  |
    ------------------------------------------------------
    | GPIO 3 |  X    |  X     | KEY_4  |  X     | KEY_8  |
    ------------------------------------------------------
    | GPIO 4 | KEY_1 |  X     | KEY_7  | KEY_8  |  X     |
    ------------------------------------------------------
    X - invalid key
    KEY_x - preferred key code


in Device tree we avoided row and column 
and passed gpio info as line-gpios

line-gpios = <
          &gpio1 24 1     /*gpio_56*/
          &gpio1 23 1     /*gpio_55*/
          &gpio1 22 1     /*gpio_54*/
          &gpio1 20 1     /*gpio_52*/
          &gpio1 16 1     /*gpio_48*/
        >;
        linux,keymap = <
                0x00000000 /* row 0, col 0, KEY_RESERVED */
                0x0001000a /* row 0, col 1, KEY_9 */
                0x00020003 /* row 0, col 2, KEY_2 */
                0x00030000 /* row 0, col 3, KEY_RESERVED */
                0x00040002 /* row 0, col 4, KEY_1 */
                0x0100000a /* row 1, col 0, KEY_9 */
                0x01010000 /* row 1, col 1, KEY_RESERVED */
                0x01020007 /* row 1, col 2, KEY_6 */
                0x01030000 /* row 1, col 3, KEY_RESERVED */
                0x01040000 /* row 1, col 4, KEY_RESERVED */
                0x02000003 /* row 2, col 0, KEY_2 */
                0x02010007 /* row 2, col 1, KEY_6 */
                0x02020000 /* row 2, col 2, KEY_RESERVED */
                0x02030005 /* row 2, col 3, KEY_4 */
                0x02040008 /* row 2, col 4, KEY_7 */
                0x03000000 /* row 3, col 0, KEY_RESERVED */
                0x03010000 /* row 3, col 1, KEY_RESERVED */
                0x03020005 /* row 3, col 2, KEY_4 */
                0x03030000 /* row 3, col 3, KEY_RESERVED */
                0x03040009 /* row 3, col 4, KEY_8 */
                0x04000002 /* row 4, col 0, KEY_1 */
                0x04010000 /* row 4, col 1, KEY_RESERVED */
                0x04020008 /* row 4, col 2, KEY_7 */
                0x04030009 /* row 4, col 3, KEY_8 */
                0x04040000 /* row 4, col 4, KEY_RESERVED */
        >;

this driver approch may be usefull for the embadded device
which are using reduced matrix keypad
		
>
>Best regards,
>Krzysztof

Best regards,
Gireesh Hiremath

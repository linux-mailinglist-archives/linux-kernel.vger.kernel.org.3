Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0406C599588
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346642AbiHSG5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243277AbiHSG5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:57:00 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80074.outbound.protection.outlook.com [40.107.8.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99790DEB7E;
        Thu, 18 Aug 2022 23:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ19/TYjSC24TqExKYqvKbP7QB5kPtHweVOXwvArybjJu9YhSnFj266CKztld/V0qqsMXm/+jzntRorDvS4BHJPaDkxe4HoCPAgi1smzu0ygrSqdwgPwiEJ4plMFTD7x1xwT4U+6RPfrs1V9Tg+UEZ/QEIHagEMNkszOjWvP/ODIct0gd10DlpEiNgCAA6NuN1TsuFMgCX4xChh2ofDw+AzmWtjZhVNYn1VQtoCiD3l9flPRDi6eH+a6NzT2uschQiwGnE9hfaxTEPR9IRSWZ+N+anVfpC1M/tEoMpkMPY+KzMDWXqi+BkgsNLaFdaCtI9KMUmR3vJ+K+w4MULBNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsUDtTqL0N0P/Sl6KzGG5FV7LIXkfS2//QVG8rdN1h8=;
 b=aF+/f2HbdV8RByJ3iRCSI/C5vgqW33HO++trSI+lLltZ9Akbp2uX/8P2ms6f9syVs3mXg9buJv0Nfg+MG9FMKpw1OlECg706pmh9HLHElwYasU7BpyjyiEAPHkyrAZdWwW63dMsKVg2SlNXWNA13JHhkuYSxD8apvz7J9xp8TdUl0+nrVfiJnY0SjJ32t0h9P5K4gK0Z4b5SVU3ii15aD9qzPcdQczhTdGcYm+/wcVBVCqG2EaVJ6Jv0lwFiNrn2AK+WH4pTfSv+HRN5c7JfUhdzQDbB4LPfB6CEuT9+OFv/Jq+fD9RSGuus4rA6rwr4O2vyZf6muDcS7Dr/eWX0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=linaro.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsUDtTqL0N0P/Sl6KzGG5FV7LIXkfS2//QVG8rdN1h8=;
 b=Y/OLC2l8B4LDz8GjOXm8ZEsWHVr6IoEE+uFiJJwLT0Xr8t+YjIOivOc3FV58W6xCtzomFWPGeUyxajMPgmlpof5q6bZbiK4g138gl8CvYPvTqVCDZmJNC96aP07x27vpeu9MIIsWKX6J2IxFFC+8jBsxVZ1+6Yb9Qu8O4DFg+hA=
Received: from DU2PR04CA0304.eurprd04.prod.outlook.com (2603:10a6:10:2b5::9)
 by AM7PR10MB3463.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:139::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 19 Aug
 2022 06:56:55 +0000
Received: from DBAEUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b5:cafe::68) by DU2PR04CA0304.outlook.office365.com
 (2603:10a6:10:2b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19 via Frontend
 Transport; Fri, 19 Aug 2022 06:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.200) by
 DBAEUR03FT007.mail.protection.outlook.com (100.127.142.161) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Fri, 19 Aug 2022 06:56:54 +0000
Received: from SI-EXCAS2000.de.bosch.com (10.139.217.201) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.31; Fri, 19 Aug
 2022 08:56:54 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2000.de.bosch.com (10.139.217.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 19 Aug 2022 08:56:52 +0200
Received: from localhost.localdomain (10.167.0.81) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.31; Fri, 19 Aug 2022
 08:56:49 +0200
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
Subject: Re: [v2,2/4] Input: mt-matrix-keypad: Add Bosch mt matrix keypad driver
Date:   Fri, 19 Aug 2022 06:56:33 +0000
Message-ID: <20220819065633.9510-1-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
References: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.0.81]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fcf8426-92ed-4e26-baa1-08da81b00097
X-MS-TrafficTypeDiagnostic: AM7PR10MB3463:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sV8A9NqapxdIOyZim5+oXcG4M8lhzxAhyy8Xl4Wyxn3fXh4sSRG/53XkxeIPqk087i+xVJI9uAVY+58e+lyz4Q0zH+tX04Z5cNKsAtwwLSTpmel0svvzGzgAuIujT58pq4pASVJ0sCbH8ZdkjCxUccgzw6fGwApNjnU94vfWzJp1vt7n8MYC6VIsBYmnm2BsRdqNLax54ka6iCKTzonws39pi8EvJH45W9fiLpCQMfOrbrLxMjXdI2BlgHl69Yp7Y/sEOI66qEubu1WVN27n2ZAm9B+0b8ZNAB2mRGF2uPiSirqmFamdfxMD2cXIK3FPZEfUoIdjfMKVUhqsW7/eYHhbotOl6mB6hfCTFSOI7ribNwa1sjPUzBDdpwQ/rjkXU8m+eMrGIYKqbWjg8qvxAIumGp8dbcc6ori6DbZ9khBpQ61HI7+OpSRXM85qKzSzlAWS7LyJepC3OeRoDVbaLqFpAwnw3KlC7uOkrP8xiPXFia0phs3kZtn6gqmoTJDDYipCyGvgoNpzFFcYwJ1e5aNwgvbA4UcHvPn32iwzFuJw/1TAKcO7FYJK51PodG/IOCH9sj3XJWqGS/TVuzOVMM/hiGkTGgRKuZPLcXJAAV/58HrjeDJPrbKKmNcv2Fww2HfZ1mzSJz0EsJUKYAix2oOglHAB5d621m2ZTuslMdazoGTCITLWvTOs8PfB563eOEjy/xaWNXFGAxgzCx8/J5PehfKx2qzX/lZIMp9gNn3RpXNjSObjfmneHqPejU8W/XKVRrGy2XdSaaS9sdkqRVt4L65vycFzYisq5Vy6NMv4rVv0HCnJB4jU8uWK1TuM
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(40470700004)(41300700001)(40480700001)(7416002)(478600001)(86362001)(70586007)(70206006)(2876002)(8676002)(4326008)(316002)(6666004)(5660300002)(54906003)(336012)(186003)(16526019)(1076003)(107886003)(2616005)(47076005)(83380400001)(2906002)(82310400005)(26005)(8936002)(81166007)(36860700001)(82960400001)(356005)(40460700003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 06:56:54.9423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcf8426-92ed-4e26-baa1-08da81b00097
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3463
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

Hi Krzysztof,

>>> You wrote pretty long message explaining how the device works, but I
>>> still do not see the answer to questions - why it cannot be part of
>>> matrix keypad?
>> 
>> Following are the difference between matrix keypad and Bosch keypad
>> make us to add another keypad driver.
>> 
>> matrix keypad:
>> 	- By hardware schematic, a column GPIO line will intersect only
>> 	  with row GPIO lines, not with the other column GPIO lines
>> 	- so, row and column GPIO property are fixed, because of this
>> 	- key scanning work based on interrupt mode
>> 	- and key press is determined based on setting column as output,
>> 	  row GPIO as input and set interrupt to monitor the changes in state,
>> 	  serve the key pressed in ISR
>> 
>> Bosch keypad:
>>     - By hardware schematic column GPIO line can intersect with row GPIO line
>> 	  as well as other column GPIO lines
>> 	- so, all GPIO act as row as well as column, because of this
>> 	- key scanning based on polling mode
>> 	- a key pressed is determined by setting one of GPIO line as output and
>> 	  other as input and poll for change in the state of input GPIO lines.
>> 	  Setting one of a GPIO line as output and remaining GPIO lines as input is on
>> 	  round robin bases.
>
>Which is still not the answer "why it cannot be part of matrix keypad?".
>To me looks similar enough, although maybe not exactly superset of the
>other.

I have merged the Bosch keypad in to the matrix keypad
and sending version v3 patches to support that.

v3-0001-driver-input-matric-keypad-switch-to-gpiod.patch
v3-0002-driver-input-matric-keypad-add-reduced-matrix-sup.patch
v3-0003-dt-bindings-input-gpio-matrix-keypad-add-reduced-.patch 

>
>>>
>>> "It looks like this driver has smaller number of features than
>>> matrix-keypad, so it should be integrated into the matrix-keypad.
>>> matrix-keypad features are superset to this one."
>>>
>>> "But anyway this should be just merged into matrix-keypad. It's a
>>> simpler set of that binding."
>> 
>> This keypad driver specific to Bosch measuring tool or similar devices.
>> Please let me know to send latest patch which resolves build warning
>> and gpiod API support.
>
>That's a poor reason not to merge into existing driver... I am sorry,
>but our entire Linux kernel concept is to integrate, not duplicate. If
>each of vendors wanted their own feature, we would have unmanageable
>monstrosity with millions of drivers doing almost the same...
>
>
>Best regards,
>Krzysztof
>

Best regards,
Gireesh Hiremath

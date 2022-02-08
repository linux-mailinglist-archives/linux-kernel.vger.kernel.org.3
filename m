Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA0A4AD796
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358470AbiBHLg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357467AbiBHLWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:22:47 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300094.outbound.protection.outlook.com [40.107.130.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CC4C03FEC0;
        Tue,  8 Feb 2022 03:22:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKnRcIRNnSR7emk/JHASu4vWF4M6nouAtQjlCje15ZD+IxuaYVXgvABtkr0cowymiPcnfYTum6gzE/p2nsr9dRRFscquzTL1uRhlMBivD0pM9FUQnYL6QmpuiawZPN9c4GOmpDXLDB8CB2Cv9vY3BH550URBMaeDcbyO2Z4ITE6H47RbGhbihqyhor2BN890olbrj9+agcdeD/TOebZsuKOAPid1VtBpdsj3jH0UorQilnJmwJ7a6HzH74PjehF9ku+V/X9Eu+TzAp/UXKcdOkuhqPAvlCv/t4Ptn71uaFt32KyuAX7JU8vEuXzbY1ssNkLS1oS0DvfuS59QiEjhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA2HM5HbEhMUzG408iMnTsgxYTno5FdQJQcDmds9q54=;
 b=HF4WOdpcoObNtJmqH2WJ/rvViXN7K3Rd50EZqNr4Qe9B6HicKTC6c3LS414M2OHEvNfTBKCliBlV2yC3ItMMYG8PvCxG+Cs9MjPqr2dlXFpIlw9ywUaGa1TQNR7XXNkeCiv0spLF87ofWLqmIZliVAfI7+MvEiR3LuvBMXrLDGSEgnosTIfLmboZw6PmPxDk5GCd0Y7XfAcBCDq4wznHTPHtmTwYledoF8UFOlcVfkzEstvsWiu9thjbU3ft2MZ/mWXIoPl/TY0nQTGADCeC5rYNfEqqDx7ZbylF/NFHVlbUJJ2Q+gohKeB6r6BCuLiU3MBfiMmDU+hPxlnU2HDm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA2HM5HbEhMUzG408iMnTsgxYTno5FdQJQcDmds9q54=;
 b=exXrZhLDMlxiLED/UD6aRna2e1/M3tXC4z+VYzPLGoL1MEmOOCRfX7dzK6JI4dJl8L5snd2WbFU7juUzJIHeY2nmhoLCGuhusLYdlLv4u0TcOcNDZd9yM0tzC99WhvhUmQDzAQpKPDmuP3D+GRhZmj1b0+GuwuGvDdLsxBmFkyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TY2PR04MB3805.apcprd04.prod.outlook.com (2603:1096:404:f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Tue, 8 Feb
 2022 11:22:41 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 11:22:41 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH v2 0/2] Add a interface for passing supported PD rev from TCPC
Date:   Tue,  8 Feb 2022 19:22:24 +0800
Message-Id: <20220208112226.9108-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220208082026.4855-1-potin.lai@quantatw.com>
References: <20220208082026.4855-1-potin.lai@quantatw.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0143.apcprd02.prod.outlook.com
 (2603:1096:202:16::27) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebd28446-91ad-4138-1ace-08d9eaf551a6
X-MS-TrafficTypeDiagnostic: TY2PR04MB3805:EE_
X-Microsoft-Antispam-PRVS: <TY2PR04MB3805E00A8F2B665E1A257CAC8E2D9@TY2PR04MB3805.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gMdr8/s3zAIJMMWp0F0EB+j+jE+K5hcllXHhHgI/KAmFhswsiraqkGaMVQ8tIoH4r5o8eYuxKfja17rbiMYXxfNM9flPM87fEsz0s8tslHHGQAkOVQPvIxU82kvu8zsbZy1VDclODkqdm18fbVeRuR3VZWhjfpXDq+j6oWUw5Z/qSozMI7yuofvlCn+YVVOJJXrxA9ZWsmw1/bEAHAUGEsXScXQrvLud5vFSc+ubu2osfyd51P6jQQw+eOq1JUueQJXI31G1QHd0o0yLao/NJH5DVJyvD+gGqTTwHaELVl6lwdN1N5OG0RMuDCLZI8tXUPPoOHaPIx5fSCPmDmWETx+dr4vs4Yx8EGLjrbtVRA0K6YZ2eORPjafTmSWkPSCo5ikJTiRzpELbO4UohW4GchtlYyqOfywu1Xi35OC+iEEa8GP2B+NUrpdT8UkFS7jsXb8f2D2b37ixreGz8G/8OO+5RHIdacPo18rUEHTVXil1yC//A9Yc565+0OTmi6TMsiyQsoUSnCrrMRGmSLsOJVYD1cS3XZZFOTsDHDJq8DwwWBoi8YbjzFgw6B8Pvvc1huev4It8XD+5tdOdzW4DcEiiGsbS01Y1E16D6wvMWWley8hKX9iItSU6uNL8wN49SQ7H/b03SMUweKXj655Hnu4wCrfVGzGAeP+ZtH+YaqzByvYiKwswP2KC4DBwXUhzSpgQCJoryEWYQ5Y31ZbEVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(1076003)(6486002)(38350700002)(38100700002)(2906002)(186003)(44832011)(107886003)(86362001)(2616005)(4744005)(36756003)(8676002)(8936002)(52116002)(5660300002)(66476007)(66556008)(66946007)(54906003)(110136005)(6506007)(6512007)(6666004)(4326008)(508600001)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ucDy0tXHGiFdi7yiaa8+oP9S/JDd5V8aUChnBfUGYtZf3NJGmLOWa41R/aVV?=
 =?us-ascii?Q?cf0Uru4IGnKBDH2s6YhHaU0qW5Qv2XCuskIzCrjcwhKMNnNofYteSAu8frWx?=
 =?us-ascii?Q?RNaSsK/5ryBpftyHXoH/QoFoKFWCoknfiXQIxZ89KyfiiAHT0O8itt1uM9bh?=
 =?us-ascii?Q?I1y3iT0k4QNySpgrsr5epbixAq/uwidzmQOuky65SsXmcYN/xHP8vLlyPr+3?=
 =?us-ascii?Q?Hk0mneEVd3aMeXS1+A2y/tTC/d7Q0lU8fyMvWPAd9XH2D0xpKFlojMI3i92W?=
 =?us-ascii?Q?q419J9MMzRCzRKBOVDmpIjenbiqPcCyZhJ3D6+q3XPkKy6UZqvGVr5sAHKWE?=
 =?us-ascii?Q?aXuveaiwYh/MIcETS8PAV53JnMLzISA+aBEH88+MOGq4Da1GW/HoI4NbYwhx?=
 =?us-ascii?Q?ohS6XmFIECqQIpXscAtv4DzvNIZDC9Kjn79ES6Lq8T5kzZNWHwg250u9lwaf?=
 =?us-ascii?Q?ErLqTeUqVvO8SZjTmFLyYPJJc99XLzo5PRfyxLlrdLFjH5M2sGaV5pQ4VwYs?=
 =?us-ascii?Q?tCQCPfBOC17hlkkdfFscbJLhaW0HnVKUthFz9hrLqA0rQhDM639IyAgXn00S?=
 =?us-ascii?Q?R4FekPnz2YGFUxTY7gdwFgw/1Mnrllrj+Xd/qD+5uF80oB7JHZmoTwaCJxvX?=
 =?us-ascii?Q?7e5vhiBxDXhKxNBKJk2XJBppCt+hK3TRBCNk4Q+2dW13o2t+JPJS2WwPJHfW?=
 =?us-ascii?Q?jvX1AcwwBDkde4PcCLzuUoffJ8x1/R7XP/FgaJcYjw8CipryGezPFygFqQjT?=
 =?us-ascii?Q?U3wfmBRhMaz7pyH0EEjPJHuChd8l7V+WMOLU4fGU8+bQ5lJIt6b0ICg8EMJD?=
 =?us-ascii?Q?pD9xqHNOrHXpI7y47SJw+ehIZqcIMan0bcJKtwga7M9nYEcnBV6cXGyb83qY?=
 =?us-ascii?Q?bAYu5m3AtoNbCo4fy7YneR5ZNS3+8YJsl7JOUu3ndn3XurRzdQWTNKMIkjDR?=
 =?us-ascii?Q?nys5g2xGB86TmpkD+nqgh6sQHXMPZsP6Pf24CyKXdzBjZaW4AAJWWUJXS/0l?=
 =?us-ascii?Q?XebTIY0/Mmg9JOVIpVUOXyOr55t/xi5T9xNOCcQN8StsgWDC2LFuxVHCwjrB?=
 =?us-ascii?Q?xqdNuh3sZE8SOfPqYiM+eidfqO2CyAfJ9RpCfO4mc5O7rDpdOnlIdKNw8FQn?=
 =?us-ascii?Q?MGN+ilHiTUoGUQHCVwTeXX8vu5kWO6mCOOYdVxDaBfRs4cI8mnqxm8vbbEaW?=
 =?us-ascii?Q?CpZCKrRRaZKtAp7J44+tLwaY/vdj97x0m6RszEFJVIctKysCjwIl2U/MXH8i?=
 =?us-ascii?Q?t5UHrbWWW0RuY8u4NcOyWuZMZIMnL8rBtKXPfJUG0xAKmZvuhowXaU7fShww?=
 =?us-ascii?Q?ZX85mw3tyAdHmcm0A+uFG1chkpYVLLCLSCbi7cQfbOwl7S+kIyfC3KfETKlV?=
 =?us-ascii?Q?9Ng8X2Rt2gdv3EUfHj0Kux0BAquv491QnAZ2VwUxnHU/xrfsV1G85xw0F932?=
 =?us-ascii?Q?mFX/fMQuRlUh/AORiQR/vtbElyCZZWFZuEsr2qhJ7Cosz9AeYcJAEEU/HfJ5?=
 =?us-ascii?Q?YBct9h//8/C1/xQECkeHeoJGNr7ENW/uRP2vQac/U0tDn1Uy/3yJkP85dShf?=
 =?us-ascii?Q?gSfp8P90vEnuRq53BlT5q/OzC0kIjwaCe6icqJtrmH8pP/48pZ1Ko6z9d7Mk?=
 =?us-ascii?Q?8BKqCCpwKPKkO940kW7ss+U=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd28446-91ad-4138-1ace-08d9eaf551a6
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 11:22:41.1269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RMgTsCoxZNoUXDIVS5EceYj6yAM9TUA/g3F2SK3tlQykLaSjmDcMfgJ7EliOcs221X762LCRDkNbTRNPfO3OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR04MB3805
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add an interface for TCPC passing supported PD revision.
supported_pd_rev is optional, TCPM will get PD rev for negotiation if
lower level driver has implementaion, otherwise use PD_MAX_REV for
negotiation

changes v1 -> v2:
  - tcpm.c
    * use min() to simplify the statement

Potin Lai (2):
  usb: typec: tcpm: add interface for passing supported_pd_rev from
    tcpc_dev
  usb: typec: fusb302: add support of supported_pd_rev

 drivers/usb/typec/tcpm/fusb302.c | 20 ++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c    | 14 ++++++++++++--
 include/linux/usb/tcpm.h         |  4 ++++
 3 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.17.1


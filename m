Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BCA4B6303
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiBOFn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:43:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiBOFnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:43:22 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2135.outbound.protection.outlook.com [40.107.96.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F26370304;
        Mon, 14 Feb 2022 21:43:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pbr0o5o8jqtFmOPcArbe0obENiv/etXUCzz0gEYhGhqU6V5kDmhUX+C59R6fW9HP34TUZi4UMh3etx8akrbybe3NNQvQug2tDIe3SVmYB9sFz2hb4ush+Nh7rYA1pPiN1dIeIwPwscictzBfWafAhHWg0iKqOoALvvPTB95Qretqo3PI7X4Khw3t3RoaX+nAL938RVC+N5/eA6QQmPOyqXcy+f4KasPtJ2ealubyiUVidyB1GjDxnVz+vrtsPatotYya5k0toeyS7A6GDksVoWykLC3innCwj5THa6Gl3jxdSCP8DK4H4U+hupusgRrAVNXfP80S1doX8T5lrmR/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPXiqKadVX+B69D+QbkWIyH4Z/xnASJS0OZE3aHuZV8=;
 b=lOuqPYfbknetQaZ4mGUBSUXpmNYPc/YS/etPrhUwhkKxWwLY+BTXumxlUOkzsdMqJWFrKvJXt6/Bim4p+uAbKhMzN+V6r54YWpiYebFDnJsckX+8AlQfJ1EhvuYZj2YiyarNeEasQHIDyzPcSEy396ZF6irk4dq3mVSki2MgGNmujFB9ErMtaewDZAF6fioAuLshMIUE4ed1DNWwE5LwlfijsHzRSOn7i4uqzUGb2l5MA6q6N+DYUDWpZ5gp65c2EaTRFvRDk9nkXc7BCvAKGtnBjMa3vdomYDbiUROApScHJbrDV6B6tg9ByQ4NgMWmqTkL6l7U/UqvXaVxsOFQqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPXiqKadVX+B69D+QbkWIyH4Z/xnASJS0OZE3aHuZV8=;
 b=rbcUUodBMAyV/sJ5EfJ+z5FhdlgSGKde0gA7+n0c9Eu7tNEuhsW1IcayROp2BtNHTVXj9iiBLdUMpEqtpRaPf3o5O2rp02Lim8LPt6huZ372mhmdP8bbya6fQuU9/WHt/D027oYhp/LFJOwidmfWo6cNG1AYFTEJUtgGiDJbow8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from CH2PR04MB6741.namprd04.prod.outlook.com (2603:10b6:610:96::19)
 by SN6PR04MB4861.namprd04.prod.outlook.com (2603:10b6:805:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 05:43:09 +0000
Received: from CH2PR04MB6741.namprd04.prod.outlook.com
 ([fe80::75ac:2247:75c4:e65d]) by CH2PR04MB6741.namprd04.prod.outlook.com
 ([fe80::75ac:2247:75c4:e65d%6]) with mapi id 15.20.4975.014; Tue, 15 Feb 2022
 05:43:09 +0000
Date:   Tue, 15 Feb 2022 13:43:00 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 2/2] usb: typec: anx7411: Add Analogix PD ANX7411
 support
Message-ID: <20220215054300.GA3752727@anxtwsw-Precision-3640-Tower>
References: <20220208091621.3680427-1-xji@analogixsemi.com>
 <20220208091621.3680427-2-xji@analogixsemi.com>
 <YgPCLopskwyQ6F4K@kuha.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgPCLopskwyQ6F4K@kuha.fi.intel.com>
X-ClientProxiedBy: SGBP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::27)
 To CH2PR04MB6741.namprd04.prod.outlook.com (2603:10b6:610:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b70e386-7398-4ad1-2a36-08d9f0460bfc
X-MS-TrafficTypeDiagnostic: SN6PR04MB4861:EE_
X-Microsoft-Antispam-PRVS: <SN6PR04MB4861E7661CAC9D72C2DE7487C7349@SN6PR04MB4861.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xs1GQEap6n1o0M8fRKIw4h2PRToAmB2KZ3Ef9CvikVIjsQzFmlm0sABPlyhQY+LISSgkd1LMCTW0NO/xtiUg9DRmfq+mx/8s6VKaCpKTBvs8nkLuxtmJQL9lJdqlsrI/9gSGLI7mPmoyR7d7q75fIqrYookY/+DY47PoiAwWljP/KtUDy6pDdbftdliAEXH01Nt2CGVBinSW3GF3kpz+YnYNf1gop1UQ0LCU2i3fl+QlvOi+P1uXR+7nG/seRVp9TZKHfhcCtX366IINq3LDR4/X6JodotIm2P75F1G6fuPE0M0Tx6tfopofMW9wyDDQjj8BedgMW85GHx5W2xRA5W84SZnN3oIbcfrK9eatpH4121aA7PmuzjMJKR5buZrEDMx/GcEfh7tKoHuJy5YMzDVxbRkpA7M50r/LcOA2oTUzxpEXJWF87PjP0pDGLQgDjkKNpht271Wj+2WkGPp9SizK5HI1hslAg8E+Gt+20hkAjGpwQ/fnpDlGAga2Pg1cBydA0Jmo7as8dFzBE3dNFsoeYLxSxBKBiVlX8/O7KYaeNwvfUCIslIaR4KK6zaJObckssVsOsbtSBJkiuNnZAX3sYbINL3gNkokb6yUqgDZn4n4PUhYS9WYL2DJIJLZI4gVUvgyQT8/XCc/3aJiGEdy01YHqJEsEb86ijVxwg2LXviwcmp3Ub2tb2b2TB1De+rGfm0T/LNC4s3F8PO6Pdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6741.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(9686003)(55236004)(33716001)(52116002)(6506007)(508600001)(6486002)(186003)(6916009)(38100700002)(4326008)(8676002)(86362001)(66946007)(8936002)(66556008)(4744005)(26005)(1076003)(5660300002)(33656002)(2906002)(6666004)(316002)(38350700002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QL3PLQi90wB1yoFmAJ8ltx7OT+kjagLOJd/TwIeipIrXV0M387fggKqBnM9H?=
 =?us-ascii?Q?3+YkjjzlLKFS6xCBrK2TPga4gPaSUnV+enYkWTTXUMDrJPHT/rn4+vi9lEn2?=
 =?us-ascii?Q?8bU9rer+6xDzSGW97onjSj4kehGBO7byqauJSjS9EDxRRTIYTe3DhmSQUj+Q?=
 =?us-ascii?Q?+a4Y4Q5xnI/yeYgy/WKFubNlmbMW9RCqUzvzxO0Es0nhce7NRRabaUtNqF5I?=
 =?us-ascii?Q?wJZFVmAhORQXg6f2UGYKaSxV11CD233aCSTBs7yG3nO/t1risNWjmRKXn553?=
 =?us-ascii?Q?P1OY7rgeSF1To7hKOIkOfJryn0u+bc/5S1bgI1LJ2kWd0Jxca4S9QO5OrUQZ?=
 =?us-ascii?Q?uIJPvFzbG5J2UJHXqsSwse6DfVUup9V+PuwlyEBTqC6aueB2vOpiHPsVRjOW?=
 =?us-ascii?Q?4Jo3KvbZ+0k6F70FlcvqCjEFeB6PTx12mBiBNFlxe9ZR0E3GmMO6oyD9VpAF?=
 =?us-ascii?Q?1bJxsaMw6F3+cx65i8FzomzKdibrVB04IsvC6WazYaKVwJ6VV5tIC3QVoOVD?=
 =?us-ascii?Q?mWxiw+EDS7q8w2+kri/mv+gnhVMfG0XTVf1Fx9ULYeZPKED0wrEMQ0wBsAjX?=
 =?us-ascii?Q?wINI7Zy8DOllycx19zHuUmCqJndfkjhm80Y+jn2d2acoxdoSoGu9U1ymGfBA?=
 =?us-ascii?Q?K0ZTjhjEEq3/1R7vl1yNFfLoRJEfojkDeiVzeOlnmrao28kVfUbiX5lQP8S5?=
 =?us-ascii?Q?96DLWi3tUMtkNvifj7ikXJetKnK86lcXloGoswMpqBOwXNgQPu1hldtQ6ntn?=
 =?us-ascii?Q?IkD/FryxeIBxQVzEUtfde6V7eC9N/0sP8js0fD2TPyHzqzF6aWwFekJU0bLI?=
 =?us-ascii?Q?eputQ9NZ8M1LUvFdok0ciiFCeSEzsE6c/5TSpnZAByRdogjLvQGMwG09hLRP?=
 =?us-ascii?Q?Nb88I/PQpkdiAjzYf9rBLKc4C+5138ONFW4XYgdZEXKzjnRYxweEb8thlFpG?=
 =?us-ascii?Q?7SJoOejH0MXqGTaJ8ASUJa4LTtLcn2GP5IlB9ICLys9nnamwEvvdbzA3+zcW?=
 =?us-ascii?Q?kSTsdCIofKfEtTXcHp3co6lggYlMQHVz4TeE/dOspTLRX5BrWlqFzjqR/aTc?=
 =?us-ascii?Q?IO0RiDhcdDo33HZdNgHC/n+9IzIzvTRYg5FcI1nIq2SeheD9NB7R0LlJedR6?=
 =?us-ascii?Q?c0mkZdo6WsQ4fetMz2dAPyzLAChMbY0/dWbZxHEvlNfIsdS+kJkclmA8/Wgq?=
 =?us-ascii?Q?liDJCneQKEMS4vI7sBXTopY580Ot2DtXXfVhA5/6C5EDtC9PsSblLklehyhZ?=
 =?us-ascii?Q?AkqMNmg/8IuzaXdaWrB7yQHXF4AwZEjsJAm4a7L4twDPY7n1oKBBMP+Kjn6O?=
 =?us-ascii?Q?nSsX54pu5EylOENvSb6AiQ+O5UmToSxKjR+UFpfadZV9PjP998qxXouXRtHP?=
 =?us-ascii?Q?KWL6qGy5CUdv3Cxls7JOYmR4AvUwuwZZMnRl94ghspolSeUt4DBW6RvqGRF5?=
 =?us-ascii?Q?IcnlRkdq6OjI6O0ESfLnsGhmHdsq309PM6p9WhLRYy61/sAni6HUkzuuZuC6?=
 =?us-ascii?Q?+LlruJ9c3fkjFCHT2czAnwdWnJ8xMr6XnK8OC6566J/cqSkXIQU0nMB1Ychg?=
 =?us-ascii?Q?1GzvnOxp4T5yT0fQ/3+vAPZjJiIeBac+/oVCjX8ZmYMfxmhPzsbYh+ZX8/kh?=
 =?us-ascii?Q?VmWPSN8Or3Yc7BT8v3OwMw4=3D?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b70e386-7398-4ad1-2a36-08d9f0460bfc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6741.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 05:43:09.1587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RckdBGafd+x8ofTc1dTOId64iJR2s9ak4ynGFU2MaK2WzqPoOIqox/Ot9iLHASpccN6oqGTxPuik5fwPC7DPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4861
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:31:26PM +0200, Heikki Krogerus wrote:
> On Tue, Feb 08, 2022 at 05:16:21PM +0800, Xin Ji wrote:
> > Add driver for analogix ANX7411 USB Type-C DRP port controller.
> 
> We already have the driver drivers/usb/typec/tcpm/tcpci.c for port
> controllers.
> 
> If you need a glue layer - if there is something specific that you
> need to do with ANX7411 that is not completely TCPC compliant - use
> drivers/usb/typec/tcpm/tcpci_*.c as examples.
Hi heikki, ANX7411 PD controller has 2 applications, the one has embeded
internal firmware, the other is not have. The currently upstream patch
is for the first way, driver mustn't use TCPCI framework(embeded firmware
will control all the TCPCI register). The second way(erased internaly
firmware) can work under TCPCI framework.

Thanks,
Xin
> 
> thanks,
> 
> -- 
> heikki

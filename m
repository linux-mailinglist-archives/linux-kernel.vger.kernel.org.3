Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36654B50E9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353775AbiBNNCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:02:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiBNNCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:02:38 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3034C786;
        Mon, 14 Feb 2022 05:02:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsrMEns0qI03L+SFeaw3i9alCPvg68Z1HQyn4quxvO1KYUpjtTNG8RWEi2DA3OxYaD0K4QypX1GTofLGEwdkcgJHTFmhFLUAi1LfNSFvB77YwtqyPRUvBnsJDvEyy3vBlCeQtW0kf3tR8+LRUfc5r6niNEzGOHn7NmDHP1WzB4EQ0h4GJCcDhUeO6eFHuSHriQDyAhkD7R4rqWSKAML0U+KFXA6+mmXrPut13tIwAYim2sfnoSxW3kbFeH5tiafaXzksnRum+h4kfjSV/Gz6iWVaj6Swtjah83t9Cw1w80/lL5/VGkQslpehGEanU1NlGBt2qx9YWmMwHYFY8Uaxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgLQy+96aY3YVLiqFi9xHtQznrpjeoK9EGkO7zmoKMU=;
 b=Vy6qPLoxfQbVtT8NNgLF8FV0LiAsSHC2HQj9+62vBn5bJmt/2AFEKKrmdAuHyYsLn/FAwaH8WFQwxAeARxYejRbL90KMIR4Xbl6Fxdkc7vowVUNeMWytvyv9BGrZcbtbiSDWs1/1buJEolhOhIEjFAUlpFlkwqE8sGQKkSGicz7ISv5CN2XIjh5TTe2dK40dhOWKaBjC73KO5q9E/b0hcz06B9iLdAXB36HvCAxoeKJBeyguFIc4DCYR+Rf2uoJCEe6x3/hdnKfyOfr4mBhD4idRI0gP7+SQg4JiNx3SlzuFkEKUGeIEci6SmhlZzTN2akgWo0dpB4gpyBR+3+iReQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgLQy+96aY3YVLiqFi9xHtQznrpjeoK9EGkO7zmoKMU=;
 b=F0zi/PQl0D3/F5VBVmK7WbOHVUJc8MvXUyIu09cg5D8pvaAirSUJ/Su9TWwjQzPbv1yhe6fJQ8XgBgQs81hm6tQ6dlIqWsJoXLpkfLMqjkLLVgCbSjELNrZQMm/MXTApuuSgh6rH6G66p/U+mEMmo4Prm1A70Dmj/trmYz1QHtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by DBBPR09MB3173.eurprd09.prod.outlook.com (2603:10a6:10:df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 13:02:26 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::3c7a:2af6:3623:4c3d]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::3c7a:2af6:3623:4c3d%7]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 13:02:26 +0000
Date:   Mon, 14 Feb 2022 14:02:16 +0100
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 4/6] Input: edt-ft5x06 - show model name by sysfs
Message-ID: <20220214130216.GA13510@optiplex>
References: <20220213171532.346270-1-dario.binacchi@amarulasolutions.com>
 <20220213171532.346270-5-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213171532.346270-5-dario.binacchi@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM3PR05CA0119.eurprd05.prod.outlook.com
 (2603:10a6:207:2::21) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a93db5e0-3797-4c64-be08-08d9efba3fc3
X-MS-TrafficTypeDiagnostic: DBBPR09MB3173:EE_
X-Microsoft-Antispam-PRVS: <DBBPR09MB317322C559976E2FAB05D228EB339@DBBPR09MB3173.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZFu9JGR4DE4a4rDqOoyJYz33CtTTReeWSXwMXR1aVYUEj9yQA5Il5NR3uQ5oaMBYf+/ok8CL53VoUv2MW9d/JjVHZHwmhOYidldtJICChL6cWE8xAYaDnx95gIf9SonkfzEGWLeArF3z+dXiYm5WutEAArtCKfrYrQdCGb8K8UxJb5jT0LaBP3bVaISOb7wjESsaXLYzvivb4lTqa6LQ4Eaii3C+ZMnJCclyiHv1YPoYVo+qWmYJq6alMbohzygV5FfAw7Fo7REvYZUBM9z2d8xk18zLTXnFDiRY+7zxBI0zp1r+7SP8LUL4pjExGbM4Zxp0RDdX/LEfL9GJCmIPSuqVz8yKt3I/i7sEM1Vhh8wQTTcsR5W5pQlqgdAIrIRmcn4mwK2sWCexRbv6OP8SaGL6uu3TI2I7aUivvRPlonyHczem3lC2l2qjYdSpB2ih/mUooqtsWnTCmG5AdfKu7SA/1PvXVww/y+DDsm2ENh/49RKi6kzQk+a2WPFPMWkWGB+HVXTtvVfPifebOYuH1moldQ8XQU8j46/RjsqHf8XaWhyPhlXl6HVuCCy6SwfwVqD3tKAneWki7fOVGvs/RacEPSJEUkbH8HvC/s+8wfjvR49jgKH2yvDsZlUxrbn0A0/M42+CT3JYEXv4GHGM+7LuMfnUFVCAWz8twt9qNCBAGABK+0kRLolsWmDMY0S4CN2Hq+OB5HzplWUd0QKQ/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(396003)(376002)(346002)(136003)(39830400003)(366004)(6506007)(5660300002)(52116002)(26005)(44832011)(38100700002)(38350700002)(186003)(6512007)(86362001)(4326008)(2906002)(8676002)(33716001)(8936002)(4744005)(9686003)(508600001)(316002)(66476007)(66946007)(66556008)(6666004)(6486002)(54906003)(1076003)(6916009)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JcvJUEBY2CltZ5PrSjh42AQC11XzC32wc1rLt46ls/VIAwbyJj1tptqEVcqC?=
 =?us-ascii?Q?LdG+SMgrYSVRFwlUXZg2uhoFFN8/+RT/wTNs1QkfAWVDYSHZXzQOEzWWDqxr?=
 =?us-ascii?Q?pCTltyCMo+hEFRspVa5clAvFpnfKmzcvecPSudFdv5O4Xx41TqbIcu1qTomw?=
 =?us-ascii?Q?gDHtHOg57m0FovlVFAs7xvANkDqoXu3PcLx+PU4NJAV0d79ex9MIzAOUdnzO?=
 =?us-ascii?Q?RdcA31OBI84ONzstlAVdyY+dSfTirRMRSl9zCwyeBY1RBKxCIexyyxA8EVM7?=
 =?us-ascii?Q?KzBiJ/JbciCP1E1u8WrpGJWS9PWjwuFUuFIBEKHzk5lhgXBNVVVYG1Vu3X8R?=
 =?us-ascii?Q?Wv1wFU5C4tLOe1Gf6LC33uwq5PV6PtyZnd0GBEDR6g3DZI3JvaZri6Y5vixc?=
 =?us-ascii?Q?CTtqHyjAjOeFqmShwr/pjp+FDZR5hE7SjnwnS2QN9hq1YBhDYqmSNiAbXUGU?=
 =?us-ascii?Q?iRN7Rf83R+hUk1AIG/2kcOOrEeaFClmiJJSF+v+QvYbm9FiKjh28c9SwsKhI?=
 =?us-ascii?Q?2LJIsat8Rhq9S1GCrI2+4kFrJXtjE61CxJJsMLkSuRWurdb6TK4qZ2oiEVnK?=
 =?us-ascii?Q?HjnpCTZhFeH6ajpG5l9MTJuK+sSJ9jZvK7owPRr4gvhzEQwFGTlHFcxzrZeM?=
 =?us-ascii?Q?gafboRpD96Soze02RqqWqU6LvZN19v4aGIf+OtnPt972jAryX+pVdSU+kJ8f?=
 =?us-ascii?Q?lOXsogV+d1SF2T7Z/oYuZpTwuU3glbM8ywA3eZvwZsD1mpW8C6Fzoi/wv/2x?=
 =?us-ascii?Q?QYqyAkktZVfQAK+3FPFZwF8bhOHU3ps/p1jK+hIur88CzbmhAr4znGEf0wCi?=
 =?us-ascii?Q?xblJrhSGUhkpWJz7oG099A7+skbN6M3840YpwUSfECQm4ov+4IL4rmx8F8G4?=
 =?us-ascii?Q?Ed8e64wyOG0EWrdjDsdCDua30Hk93W86P7JYEZM5BMzCVoACjTCMT/lfr3KF?=
 =?us-ascii?Q?IHlO4voK2wP8J8hMMMBX1CupxnpUIJEq2nF1wXT6bGAflysLMKDut2JqDnV7?=
 =?us-ascii?Q?pCQB/ylguEA+cASxstQcivO8l95LHokRFRZ1POJdcn6oDkq+GEZfIHgXpDes?=
 =?us-ascii?Q?xi5rIF44Oubw1ojTpYE6qV6u0XTEwKJ+IucnPQRxUomGrNq+EW3unk8t6ZfF?=
 =?us-ascii?Q?osCl/UCnQxW1QMQ/8h+cE1ygWuMgq7OdWJ4Lc0gnlpGdzmbLLnmZ5omV/VuH?=
 =?us-ascii?Q?DtfY8EzJZv4yjNmGxCDIImNofDQKTbpHptcsyn866qhTgc+RsrEUx+ZelbbB?=
 =?us-ascii?Q?Zx3j68Q8bosFbVRuZFbb4t30wmsQGZmpvevoUXFGHp46vxaSpMBFt0SUEjEQ?=
 =?us-ascii?Q?xqxIJYBmfNRaXb/cpf1zks1Mw7pg2SjvN4D6eoO704PxxzVq9eNwPkPpXZD2?=
 =?us-ascii?Q?5mTB/aL68EAwF98PrIF9LwzavviF2r5X4YZUXDZSZ8E/Bj851b5B17dcRTK/?=
 =?us-ascii?Q?g+T9Q9Z5Wpx3/2ZnpjQFsBNWLSTzCTUCISg1nBZHwqb7QlRJB21R8k104i7z?=
 =?us-ascii?Q?A8psm+ikuXqoDHUw3IjZOP92ocuvGarycyOyN0xT5i5P31h6E7yKXfR1bI3+?=
 =?us-ascii?Q?ds/EWu4BpVgunWEbs9ThvxQJeZOC1OxAE6l1hJBeCzNYQCJEX2oQSmqxlH5I?=
 =?us-ascii?Q?rWcIetBfBzPA2G7IUEfms7I+dRz+bUS+DfPJtx0MArx+0FcY/V7u462Wh4lf?=
 =?us-ascii?Q?6KIa1w=3D=3D?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93db5e0-3797-4c64-be08-08d9efba3fc3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 13:02:26.4415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zK1mSw63dwFZ5XH/mpaZkJZulAWNVSaHQmiNHTQc5guQSLmIiI+x0BtNP/lLX5GMJnV4KePnn1QDgVMNTAgm9wZD+wix5wBlRV+j81O6BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR09MB3173
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/22, Dario Binacchi wrote:
> The model name was printed only if debug mode was enabled. Now you can
> always get it from sysfs.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Acked-by: Oliver Graute <oliver.graute@kococonnector.com>

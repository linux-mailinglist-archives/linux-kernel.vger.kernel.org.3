Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132814BC54F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 05:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbiBSEIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 23:08:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241292AbiBSEIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 23:08:36 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10hn2226.outbound.protection.outlook.com [52.100.155.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E117546B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 20:08:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcqhgN3KrVuShZIl1R+GqN+Q1xnfyVAq5RlF3XqrtPNekymJUTBoFxldXeUGRhlK0ABdOKffUFAVqp1RNBP2j95m66xW4hYmiXOnj3wEbPrFi/uCMKaHYB86N88LTiYoA9eXRuqE/o2TA9MeQrjYZ5hK8Zv/WlsmpjQpYdNMdXz7VgCoSJzqzjyCFPJeGw0oFybdUBBqs+HWHJjCJIjRZAYPdA+08ibTORn0AuV8sHGQ7IVpsK43TTR3zHqZKbqTWIzL/RGsDyFK6aKqCMqzA0T21jchREypQJoSLBpsGm0YeskJo1UwPX0dzsOqN9eKW/OueENCjWyIC/09SuFb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+iJiA0J6jviS6/j+q9zQZlf+odb/fFUug6nr0gp3M4=;
 b=VaN3WwmEeCKASYJk4URd3jG3qG9Z8HUxbGt3KaPInQZFX946TCqwIaDDvwgjgkLl8/EgrrCXkX2latRJCG2uJDtSWaeFzMwriSW/q9JbgceHtMPDDbpgN8nz/xq/nydFJKqNsDtKF2srbeHsdfGLPQ1w+S/rSJnUB1XuV9wC26cU+/L0F0nDqNAoGDI/y2Lgcr81ZnL/cysf50/6gSazEgcrWfVhTQDiruSlUWSDqafXwIeMmVRvLCaxh4e6P+0gXMD3uWVMae77pJ/uhAQLI9CCxApGz+ISS4eqfldQc7i+9rT4SJJceCaddj6DmeggeWvK8mgNCDkfY7K1r+Stbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 216.169.5.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=u-csd.com;
 dmarc=none action=none header.from=u-csd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucsd4.onmicrosoft.com;
 s=selector1-ucsd4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+iJiA0J6jviS6/j+q9zQZlf+odb/fFUug6nr0gp3M4=;
 b=j3H2y71Cw2nmK9jjUfH37WZ1Cnk1aQ+r3NTFfMGhKD7uI1k+EM7+Oh586KD1ttEGQ9HakH31fwEh5qn2UDUnN2TZCxC9qhppphmjd644EiZv8w3hGsXkdxP+XWd8z3tKotucYZaxLONG5CNV03VW28wQGPyAKvzk0XdtxqZ+pyc=
Received: from BN8PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:70::38)
 by BL0PR06MB5042.namprd06.prod.outlook.com (2603:10b6:208:6d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Sat, 19 Feb
 2022 04:08:07 +0000
Received: from BN7NAM10FT031.eop-nam10.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::f5) by BN8PR04CA0025.outlook.office365.com
 (2603:10b6:408:70::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Sat, 19 Feb 2022 04:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 216.169.5.195)
 smtp.mailfrom=u-csd.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=u-csd.com;
Received-SPF: Fail (protection.outlook.com: domain of u-csd.com does not
 designate 216.169.5.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.169.5.195; helo=UCSDEX1.u-csd.local;
Received: from UCSDEX1.u-csd.local (216.169.5.195) by
 BN7NAM10FT031.mail.protection.outlook.com (10.13.156.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.20 via Frontend Transport; Sat, 19 Feb 2022 04:08:06 +0000
Received: from UCSDEX1.u-csd.local (192.168.16.43) by UCSDEX1.u-csd.local
 (192.168.16.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 21:55:12 -0600
Received: from [199.231.186.244] (199.231.186.244) by UCSDEX1.u-csd.local
 (192.168.16.43) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 18 Feb 2022 21:55:12 -0600
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: HI..
To:     <linux-kernel@vger.kernel.org>
From:   "Kristina Pia Johansson " <info@u-csd.com>
Date:   Fri, 18 Feb 2022 22:55:12 -0500
Reply-To: <piakjp2022@gmail.com>
Message-ID: <26f32ae6-28e8-429b-862d-3e7b31b93a70@UCSDEX1.u-csd.local>
X-CrossPremisesHeadersFilteredBySendConnector: UCSDEX1.u-csd.local
X-OrganizationHeadersPreserved: UCSDEX1.u-csd.local
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04cf78e1-0a07-40d2-eefb-08d9f35d6f13
X-MS-TrafficTypeDiagnostic: BL0PR06MB5042:EE_
X-Microsoft-Antispam-PRVS: <BL0PR06MB50428D70474EFC6E06180E7297389@BL0PR06MB5042.namprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Forefront-Antispam-Report: CIP:216.169.5.195;CTRY:US;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:UCSDEX1.u-csd.local;PTR:InfoDomainNonexistent;CAT:OSPM;SFS:(13230001)(136003)(376002)(39860400002)(346002)(396003)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(6916009)(6706004)(186003)(16576012)(26005)(36860700001)(82740400003)(316002)(9686003)(356005)(81166007)(7116003)(82310400004)(956004)(70586007)(70206006)(8676002)(4744005)(8936002)(31686004)(3480700007)(47076005)(5660300002)(86362001)(508600001)(40480700001)(2860700004)(31696002)(336012)(16900700008);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?bzHr59kRt85tCJ9LvT8bzs+bZAqn7kX4mm6R4PJD1y6ZhTHqLvaJgIJC2L?=
 =?iso-8859-1?Q?Q6QNMgC9oHPyNwKqh7nFW44z/hxz6DvR/BjikPrfqe2mI1nyqPWP4Z/Zee?=
 =?iso-8859-1?Q?4PPH8hKpPJWjusytPIpNN5GDMzF8SSGJVBN0hcaB1r9JtMsvw63r6hgxu5?=
 =?iso-8859-1?Q?Lq207G/ig3FWcYWhSBO4q4H3BwNH/zH3h51c6dRHEiQ9ReU8L3CZPEeixn?=
 =?iso-8859-1?Q?rQ8hW0dolwvNWwrfL5VzdeGoSMz+dGMLONIup9RX76AP2KB949Q5QJyH7U?=
 =?iso-8859-1?Q?KKwWiXPrlT9pg2HuHgx7ibg24LRRusThuMa82VgLTH1nt9pZlcoMPyOkmN?=
 =?iso-8859-1?Q?Mcq1FMu/5dgBEfXRM8KHJMxCfpgKi7nb9X9lGr/txZ5c4lZ16g+nnVsDjQ?=
 =?iso-8859-1?Q?aAKZbvD5RC5qMdcAuS1rGSWLgXzh4uMW4Ld+Bge7DmzZI1aMCy2qX8WPmk?=
 =?iso-8859-1?Q?q9q5I5CdX8SYeoYzjyXwFcFelsHtH45CeSWNmYt5hI2umBJ48hEJnzHxpo?=
 =?iso-8859-1?Q?CqNlWJDqUIedwI+ElGJTkH+o3Jtn4kxvNUc8Visunj05uUQHmJWmAoqY2N?=
 =?iso-8859-1?Q?jBAbyyuMyUjhfKb5VS70LuWL0wg5brDjBhtszM/7bmHYquBRuwOUjK00by?=
 =?iso-8859-1?Q?sR4RQ9dAP4lnYeg7h6QHs3dm8UHH19PhSdZ6ctA//H9ra8UzfgQmd/nuIc?=
 =?iso-8859-1?Q?y6CCmvzbzevWZNsiIC+vcl/lTO2h+dtBfkfZfHJGrljbJAt8jthb2uIYtD?=
 =?iso-8859-1?Q?wiknonwt1y2k9zs7282z5dpgqBZyiHHidnktLynKV4pHV5XEKTSlLYmoyU?=
 =?iso-8859-1?Q?QQ0NU0SDSfAI1W2VdpeeA3olllLbnkITkay1HJgY0eWWPEG/BepAMi5sbU?=
 =?iso-8859-1?Q?VM6b9jtu21rC5Z+ry7za+22XJpNdUayFnCg/aTZAXBFFJ4zHO0Eefb2fzm?=
 =?iso-8859-1?Q?vHwy4jG0p8HEShKCm3XeA9Uu41TyYEB8ehqKCDJ4U8ywoJO4VnVUUL5bxF?=
 =?iso-8859-1?Q?I46ZOKU2UxYZZT6aXEnf0EhF9kd0QaA/uPIOPYXxeHohS8j9FLzfFgYxfs?=
 =?iso-8859-1?Q?B2nlMQhPcmPBnJWDrIAVA5M=3D?=
X-OriginatorOrg: u-csd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2022 04:08:06.9940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cf78e1-0a07-40d2-eefb-08d9f35d6f13
X-MS-Exchange-CrossTenant-Id: 663d4886-a028-4654-8be0-f6e600c88247
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=663d4886-a028-4654-8be0-f6e600c88247;Ip=[216.169.5.195];Helo=[UCSDEX1.u-csd.local]
X-MS-Exchange-CrossTenant-AuthSource: BN7NAM10FT031.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR06MB5042
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I hope that you are at your best and doing well. The purpose of this letter=
 is seeking for a pen pal like friendship and I'd love to and be honored to=
 be friends with you if you do not mind.. If the Idea sounds OK with you, j=
ust say yes and we can take it on from there. I look forward to hear hearin=
g from you.. My name is Kristina From Sweden 36 years , this will mean a lo=
t to me to hear back from you.

Warm Regards.

Kristina

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B86654D410
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350121AbiFOV7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347212AbiFOV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:59:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05hn2215.outbound.protection.outlook.com [52.100.175.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA64B53C76
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Botejk7ZBRXDu3gwvAmGuSmPDYmDdXo1oKoXNzKNrwklhmJKAAmB/u1uD4oM906gdQJyAzEZ/8fF+ZWMTWSX60FsG5l2LUP94qYy/4/2Reght3Ac1y/Pr3LLwvASVOxQ2CGdKzpmMpRukISYAHCP9yoN4ndTn1oECZ3m+g2p9Ts2Rq2oy8nNA4p0rlepZJ9sBXI3Vzr0hpv//2nedHsXNpV9i5hMgKHy8a8sirqUkvF1O2abP2KzKA0Qu+k7oN94jCI8HrdaZ8fOeS0V9tBHPsyBTLy2H426U77ZffRob/mAREKR1elaXo/rz9kHcnK32IqzdI9J2bAp3UiWDWDBqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQsm62DnO3DRMaTO7/AWxijWtNxIrL/VW/Qe6xhipJU=;
 b=NoR0IUOvea0jTxp3abTjVX2xobn2TO5yNaVFkG+7GUoDtbYQYF/Ffg839hdmsRsWAipLzffULcP8oqfCpTIUs5qhxatXxxkKTRvTopWJ2dDXZxYMj3Tgq28BfaEjkfzYPnrTtGC5sILq2H4GR3IbQXBtyjy0od+t/jlKYExhXwRzU6bkPRlHb6+Q+/3QXFIGmRKCEZA1lokfzctFLrzQn1m3PcGuF2K9TWKcBw912gCsXL3XK+Md+WYN5RNQ+NxUJDPleULvFA+1XXQt0VaBJ0hnQiLPt114AygPz6e7sV8Ej7eAiyqnyBTwcez6Qu7NsEGsCkqavfkBl82rjwvWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 91.151.71.70) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=solairedirect.co.za; dmarc=none action=none
 header.from=solairedirect.co.za; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solairdirect.onmicrosoft.com; s=selector1-solairdirect-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQsm62DnO3DRMaTO7/AWxijWtNxIrL/VW/Qe6xhipJU=;
 b=5spVSMf1phG9K/gfNTv1qGkKsMO2PAguCpF+aws1oMSvZ8RNfq4euu6Vts69HDkJwCPz0Xnze5l/vN6bZmIw5XT+qrVe+aAnemeytj7KjQVjIbSfQTR8KcnEqcW/4oAPm1UZw4cVlaxC0Rs1RD+gumWI2lARdzmHVwGxFb7NZEw=
Received: from DB6PR0601CA0013.eurprd06.prod.outlook.com (2603:10a6:4:7b::23)
 by VI1PR0601MB2062.eurprd06.prod.outlook.com (2603:10a6:800:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 21:59:38 +0000
Received: from DB5EUR01FT086.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::41) by DB6PR0601CA0013.outlook.office365.com
 (2603:10a6:4:7b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 15 Jun 2022 21:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 91.151.71.70) smtp.mailfrom=solairedirect.co.za; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=solairedirect.co.za;
Received-SPF: PermError (protection.outlook.com: domain of solairedirect.co.za
 used an invalid SPF mechanism)
Received: from SDSV152-VM.solairedirect.lan (91.151.71.70) by
 DB5EUR01FT086.mail.protection.outlook.com (10.152.5.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Wed, 15 Jun 2022 21:59:37 +0000
Received: from [206.72.197.122] ([206.72.197.122] unverified) by SDSV152-VM.solairedirect.lan with Microsoft SMTPSVC(8.5.9600.16384);
         Thu, 16 Jun 2022 00:00:12 +0200
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hi
To:     linux-kernel@vger.kernel.org
From:   "Emerald Johansson" <marketing@solairedirect.co.za>
Date:   Wed, 15 Jun 2022 17:59:34 -0400
Reply-To: emjo680@gmail.com
Message-ID: <SDSV152-VMux8d25zwh00047017@SDSV152-VM.solairedirect.lan>
X-OriginalArrivalTime: 15 Jun 2022 22:00:12.0511 (UTC) FILETIME=[497AF6F0:01D88103]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bd5113f-22f9-4ed9-daec-08da4f1a573d
X-MS-TrafficTypeDiagnostic: VI1PR0601MB2062:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0601MB2062237B270C224B272714FDEBAD9@VI1PR0601MB2062.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?lEbTFHqnTmrIhXGfSU2ApOEqT/SeW+IFZzVtkgqJcWI08iFJCf6DSULozF?=
 =?iso-8859-1?Q?NrHaEEC181nfiSICORFs2avj+frL510kElWCd1kJy8E0XBNQ13VgerbijA?=
 =?iso-8859-1?Q?h9eWVjRhYxi7tjDyniTEyitfXkU7dqN8m6wluzbbXzpDaKmlXUbb41vIZB?=
 =?iso-8859-1?Q?PBu3s7tzdkeVftRYUCh/OX4+5nBrlY4nHyXm7SaScxjBeioYR+RuevvPNg?=
 =?iso-8859-1?Q?jh7WK2uA9ywHIylonpzTZW9NQ1AC80KBUbBGbVLTyFXhNKhKEkWLLtIM39?=
 =?iso-8859-1?Q?yIgBONWlrfrsc+E0Ad8vSQvp0w0PJ8EFdtYR2JMR68AQeZ8iClEKKGi6Cs?=
 =?iso-8859-1?Q?tBm4aC5+hTjBILJnccyBUSd87DcjsVaZrFvurGMjmQqpJcxvvnoWdbp15/?=
 =?iso-8859-1?Q?BNeaXB6KAmLm+ZUUj3utYLBvv2/tdXrmGuynbeyyYqDqF9umUGiuAphiPU?=
 =?iso-8859-1?Q?UyeLO3sbVDqIwNc6POW5NMZD50iYLdrJsO614u1HYyxsJrjI0/fjEvLUv4?=
 =?iso-8859-1?Q?SqPzhmdA2JeqiHfBFkz4VyK+x2qiDKqPRWplNiaAWkT5dyTGLgcyi746jo?=
 =?iso-8859-1?Q?qmPKwpESA5lLflvSVgtYrIPtOKXPJK7l8XAfpq024tIQaQc+Xa/OGN4ehL?=
 =?iso-8859-1?Q?9MmfnPKjQoMSNaR2TKzATZWQLVZugv3ccjajP4gE6vurcJcoCDdVGnZ4ol?=
 =?iso-8859-1?Q?14h1PzfeqFQLsVz4mLjwNvebsa7p23R0cQtl8HUFnAp6ECi1gjH8n6fBoo?=
 =?iso-8859-1?Q?jdFWtICsIJUJkFILnr9kSCQmu0SxBMkk5LgOzCf+zNqHg/nj2QIuCvoLZ9?=
 =?iso-8859-1?Q?sI2tK+OYBG3FhIIBPpF2y0gIRr7K46ZyGAkSTSnuF8bHYCP1hAkb0WW7OD?=
 =?iso-8859-1?Q?W6WTwmSEg8n9NuQ9mRA7l4JnzDesEMmcmHaJZ3SkxBqn1qyuk/YtDsX/T4?=
 =?iso-8859-1?Q?Jh6U/A65sPJymqVQ8hs476BzAfgHBDylDEH3L03Tf4aQ2CSHuLbRR4xJQ7?=
 =?iso-8859-1?Q?3+k2NDlsNgcNAsqMnL0T2Njt4HL4AjrGbiPgXKkejrv5ezlV3rGf+38JP5?=
 =?iso-8859-1?Q?R8Qd+ZcSf29Z/j3DBTVHH/0=3D?=
X-Forefront-Antispam-Report: CIP:91.151.71.70;CTRY:FR;LANG:en;SCL:5;SRV:;IPV:CAL;SFV:SPM;H:SDSV152-VM.solairedirect.lan;PTR:undef-71-70.c-si.fr;CAT:OSPM;SFS:(13230016)(136003)(39860400002)(346002)(396003)(40470700004)(36840700001)(46966006)(82310400005)(40480700001)(40460700003)(956004)(41300700001)(9686003)(6916009)(47076005)(186003)(2906002)(81166007)(8936002)(336012)(70586007)(70206006)(8676002)(4744005)(7116003)(2860700004)(5660300002)(508600001)(356005)(6666004)(316002)(36860700001)(26005)(3480700007)(86362001)(16900700008);DIR:OUT;SFP:1501;
X-OriginatorOrg: solairedirect.co.za
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 21:59:37.6668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd5113f-22f9-4ed9-daec-08da4f1a573d
X-MS-Exchange-CrossTenant-Id: 1c138fa9-0b91-4473-baea-5be5feac0f7e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1c138fa9-0b91-4473-baea-5be5feac0f7e;Ip=[91.151.71.70];Helo=[SDSV152-VM.solairedirect.lan]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT086.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2062
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [52.100.175.215 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4836]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [52.100.175.215 listed in wl.mailspike.net]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [52.100.175.215 listed in bl.score.senderscore.com]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.0 T_SPF_PERMERROR SPF: test of record failed (permerror)
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [emjo680[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  1.0 FORGED_SPF_HELO No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hope that you are at your best and doing well. The purpose of this letter=
 is seeking for a pen pal like friendship and I'd love to and be honored to=
 be friends with you if you do not mind.. If the Idea sounds OK with you, j=
ust say yes and we can take it on from there. I look forward to hear hearin=
g from you.. My name is Emerald From Sweden 36 years , this will mean a lot=
 to me to hear back from you.

Warm Regards.

Emerald

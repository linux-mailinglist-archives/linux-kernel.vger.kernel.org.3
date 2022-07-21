Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9372557D2BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiGURtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGURtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:49:39 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02hn2248.outbound.protection.outlook.com [52.100.9.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E591D33A26
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7puU+UxhjYWuNGvYc156UtwyD6/IbitBoKq5fRgk1myqRRsRSTAMPFsRhaXr1t2RVgY6hTLpkXnRmnTA3fH3h/UTersKaNcc2I1QK8z+WB7Gky/rVRu4EUFg4dJLPBQOUoytgziR0ri0cVRqsCo0Yqc/5t6CtVRFPfhYaB2CwldDFSpljxybOs7qqK4rJIA8/Lcquh+Y7h5IZIPFTbE4VNgWiSQpDtnXwiNIpeRKCsh9Oq+u2FriPB66BcWBekBZrqLSCmldqdWz16yymCbYj6iwJZ/pmPPzYJzRLyBF9LVEoU4PGT3WrjlQ8XkIQhx0E1szTTZ22pS4tpy/wPhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufCI9C68Qdi+z4RWjQt7uDSk6RdinBXtQyNv5C8HqjI=;
 b=bYyyN1g7x4KTBch9VcPJ83Vc55A5YaBYgmsliL4xISZRSJK6i6cKFtnDl+e85AzkehsMYGQGK9INEi0X96d0JG+6HSSWCeFh0nB490kOWfTq9vt6m6qSfBvmmY+URymErxiewvqVQ5o+jS4n+9PSToDuyiP/QkrEH6O2P4qQivCRF/fw9SZA+J2UPmvohcEpbyBmVpD7E0fqALr00FlSeAvxWH0h12tYlWpmm9riu3YujfuEsNLQl+NwIcCM4OP/7EGhS3OlRTsSKuNC7qN6nlf/P1/9ZdvedrkEm66DBhP1EVaql/1tw1JIvcBV2rW5O7CmkMICBnNt/MQI/QGetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 193.183.126.23) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=redington.com; dmarc=none action=none
 header.from=redington.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Husqvarnagroup.onmicrosoft.com; s=selector1-Husqvarnagroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufCI9C68Qdi+z4RWjQt7uDSk6RdinBXtQyNv5C8HqjI=;
 b=b9DiuJzKMAnphT4Fko/tj22U4aueKSBjdUd1i01FX5GwzNt7YIv7J2wsXaa/RWrvLBgy2VHuLFIH7xno93ew0JknBTvRf6gq2pC1G/Q2cjjxyxfjQn6FR3UfEc3X/tiyMJpvqA/JARgIp82kACyl390qNU0IiYyVW8uaAcryAKU=
Received: from OL1P279CA0021.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::8) by
 AM5PR0401MB2450.eurprd04.prod.outlook.com (2603:10a6:203:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 17:49:36 +0000
Received: from HE1EUR02FT046.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:e10:13:cafe::61) by OL1P279CA0021.outlook.office365.com
 (2603:10a6:e10:13::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Thu, 21 Jul 2022 17:49:36 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 193.183.126.23) smtp.mailfrom=redington.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=redington.com;
Received-SPF: PermError (protection.outlook.com: domain of redington.com used
 an invalid SPF mechanism)
Received: from smtp.husqvarnagroup.com (193.183.126.23) by
 HE1EUR02FT046.mail.protection.outlook.com (10.152.11.249) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 17:49:36 +0000
Received: from AS400TGT.CP.ELECTROLUX-NA.COM ([10.80.249.221]) by smtp.husqvarnagroup.com with Microsoft SMTPSVC(8.5.9600.16384);
         Thu, 21 Jul 2022 19:49:25 +0200
Received: from [107.161.81.132](107.161.81.132.static.quadranet.com[107.161.81.132])
        by AS400TGT.CP.ELECTROLUX-NA.COM (IBM i SMTP 7.3.0) with TCP;
        Thu, 21 Jul 2022 12:49:26 -0500
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: Charity Donation From Ms. Gu Kailai....
To:     Recipients <gukailai@redington.com>
From:   "Ms. Gu Kailai" <gukailai@redington.com>
Date:   Fri, 22 Jul 2022 01:49:03 +0800
Reply-To: mail@gukaimail.com
Message-ID: <SW02202QVXwR1IM9QX2000339ce@smtp.husqvarnagroup.com>
X-OriginalArrivalTime: 21 Jul 2022 17:49:26.0990 (UTC) FILETIME=[3885A6E0:01D89D2A]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42885dce-65fd-48e1-1366-08da6b416078
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2450:EE_
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?4JKREVincBsinavREwMxRaKXVx8JmhKN0kG1oawFDNtCvwYqofj7inX68y?=
 =?iso-8859-1?Q?LfgsHr3qn2QNOEh8xz7P1B+G3as/Wkzmnnc3fv8FW1242WUvb1SN102xbJ?=
 =?iso-8859-1?Q?Bb3jUvhetcRCQmzted+6ZwsFa0T/K1d2JxjVjrdnBZafJGbDEkShndp7jI?=
 =?iso-8859-1?Q?5AWlaTJbm1dOjILbOHTPykPdAb2GEt3xBSDAyH7/SYkVWtCHn+pg3bumhN?=
 =?iso-8859-1?Q?TIRxBcTz8+u22hj/Suph3pQS/M1yxgvIF2wIodO5t45CNzc6QgK/d4cgUU?=
 =?iso-8859-1?Q?p89UMSG43ftQzYADaQ75A4aIc5QNyF0RXkm+qUAwFZ+hFGOw8V2mZBYGLB?=
 =?iso-8859-1?Q?z+dufRl6U7N2rDKFCsJj59C1wnJ2VE8uCr/m3kEdSTWgnf9aCYJtbJFWwI?=
 =?iso-8859-1?Q?fHJceeaV3SMKQnHEfWcaGy/WejfC5tsFVAMz0a+xNMM2wDwX+m526dkxk+?=
 =?iso-8859-1?Q?EjejFXIX0e7s6jCx5YHvagAc58mZ62NXgUcRWwP53YlfkBnNaJtjEFdJA7?=
 =?iso-8859-1?Q?q5Rrh4SrkIFHmCnfHD1TlGY6zggZ8m72IPImEEq5Mr47ILVQoJA/jFEzsR?=
 =?iso-8859-1?Q?svuVSg6rnx5Czde1h7F6+cVrXJ10R6CEjrogYv7e/5hHxacRr6dzxFeI6T?=
 =?iso-8859-1?Q?DAyPlEEG/UAXru+gHToOJZDz4PIFT7/31k5vP4f6MeE7Wr52CyNiuNJ8u9?=
 =?iso-8859-1?Q?kSFB05H3lt3TVr2uZNw0SdA3n2j3UpOznUZT3k3XrqxGoWNZo6yj2bzJkK?=
 =?iso-8859-1?Q?sSvqfCgD9Lgw6wLoljDAWXCxuM/ec0MibpRP6WVnhaWh7edy+5vA/BSSam?=
 =?iso-8859-1?Q?IzICoLMd4nUcp8WUFXSStCgc6sKny/zPKF2uUC/hlAGaZCVCaJvIh6Felx?=
 =?iso-8859-1?Q?8sOJsiyvhvl3wuDCAJo4/m7xJYF7JsDXJ4bfjg/MgK+4E7IyI8yH5zR8GT?=
 =?iso-8859-1?Q?MJfZgYavhi9MMyvmrbI+agkYc1mfO93VpdeO05hbkCTLLY5PQec3SS3sxb?=
 =?iso-8859-1?Q?/0Bg+ZJfPWlX5ZAt0GzKsgAo4R0MPwNxNrB4BdzDM0yqB6QNEwfc8k2n+1?=
 =?iso-8859-1?Q?Q6A1woOf1YM5Ep7s+eYuSST2pNb6ImuMAua7FsSQqn/zC/Y19lMUwD4Eau?=
 =?iso-8859-1?Q?ZOuy50mAfCX/7+/8ozdii6MfLnS7UsnTswJPldsDHRuaLab/w+kdTlYY3+?=
 =?iso-8859-1?Q?+00ahLgyUcvsTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:193.183.126.23;CTRY:SE;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:smtp.husqvarnagroup.com;PTR:InfoDomainNonexistent;CAT:OSPM;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(84040400005)(40470700004)(46966006)(86362001)(8936002)(6862004)(356005)(81166007)(82740400003)(2906002)(5660300002)(4744005)(40480700001)(41300700001)(6666004)(26005)(40460700003)(9686003)(498600001)(82310400005)(47076005)(70206006)(336012)(70586007)(8676002)(35950700001)(83380400001)(316002)(956004)(6200100001)(62346012);DIR:OUT;SFP:1501;
X-OriginatorOrg: Husqvarnagroup.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 17:49:36.1093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42885dce-65fd-48e1-1366-08da6b416078
X-MS-Exchange-CrossTenant-Id: 2a1c169e-715a-412b-b526-05da3f8412fa
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=2a1c169e-715a-412b-b526-05da3f8412fa;Ip=[193.183.126.23];Helo=[smtp.husqvarnagroup.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT046.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2450
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,



I want to make a Donation to support Charities in your City, I will need yo=
ur help to achieve it. Reply to this message so I can explain further.


Ms. Gu Kailai


The information in this email may be confidential and/or legally privileged=
. It has been sent for the sole use of the intended recipient(s). If you ar=
e not an intended recipient, you are strictly prohibited from reading, disc=
losing, distributing, copying or using this email or any of its contents, i=
n any way whatsoever. If you have received this email in error, please cont=
act the sender by reply email and destroy all copies of the original messag=
e. Please also be advised that emails are not a secure form for communicati=
on, and may contain errors.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BB64D556D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbiCJXdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbiCJXdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:33:43 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2093.outbound.protection.outlook.com [40.107.114.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DDC9E54C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:32:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7Y1NQvjAIvOHtxDUikTtIoDb33aolU8ghL6jtZLoNl61ewZ3JVpxyGKugvJ311oeS1v+ZeIaLh5xZEgHIcRN+oruuDLnuHJvOXaGIwhXT/cJ+/eayo44UDESnYCLuJ0vSELok5+gWdxPmYlv13A2/u0Xttf6seQSQV4Im8EFOyxjfwS/NG861gSIlpCM4ATiZxIRk/O7sVborjnQ6ryTl4EsUl5a8nstPxirw0hADlDcXUlWbecMpFbhusReGZAm2VBodsqs/kuKvKqpEGhwO8uFMbSo9RCAdPJxugTegXVO9tYdaJBl6PFaG+KsEc6QDXadvmfph/jPeMzhX4zjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzb9iSVH2jPqjsZjpyZkDZ0nRSeebFAjZeacg0KZY4o=;
 b=cELtIJSEdItq1+7MLpCd2hsHzWJnR0luYOi5/DANlHsocafTwt3yWkKHKTWagQwDfEZ6Mjk+DyN8OZVlJe2Hn44Qq3lWoiHCA/+Dwu7iI53MZWgbkjwhPOZGrRNv/3N4/SGo/K2RbJYTjmFYmQcX5FE3ycWVmeiSl/EKZwMJ08IcNz39fUnzzJyQS4lzje4Z2jYuXfWAo9tVgN4vB43vXkxhquh6dmrHukLAS0co4voE3fsvnFW9bnEPta1J5SOSk8Hxbkw8bYDUlsckwqpzYC695SaUTs5cGW7DSJbFPeqf0/aRCCom32vHYzYmrtfWxFbDYo6AZms7exXyKuFMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzb9iSVH2jPqjsZjpyZkDZ0nRSeebFAjZeacg0KZY4o=;
 b=fFWOMpcsChEluh9M6bdddzxjNV7/zYGMo6zhZjFNtHrfspAg8BEJbzSQJWr4z3SdpTbWLVGtRP1VoztikCKpe4KOsKDh7IipxO53pJkciLMzJV2/N12rhUem6kKUtk1ftdYQtxc5B0qqFlnCxKTHCPR8MrvsQTg5csZEeWoLIrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com (2603:1096:604:194::10)
 by OSAPR01MB3475.jpnprd01.prod.outlook.com (2603:1096:604:58::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 23:32:37 +0000
Received: from OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::7c4e:286f:81:97ac]) by OS3PR01MB8426.jpnprd01.prod.outlook.com
 ([fe80::7c4e:286f:81:97ac%3]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 23:32:37 +0000
Message-ID: <87a6dxqt80.wl-kuninori.morimoto.gx@renesas.com>
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robert.hancock@calian.com>,
        <stephan@gerhold.net>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: simple-card-utils: Don't reset clock of active DAI
In-Reply-To: <1646910999-2501-1-git-send-email-spujar@nvidia.com>
References: <1646910999-2501-1-git-send-email-spujar@nvidia.com>
User-Agent: Wanderlust/2.15.9 Emacs/26.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date:   Thu, 10 Mar 2022 23:32:37 +0000
X-ClientProxiedBy: TYWPR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::22) To OS3PR01MB8426.jpnprd01.prod.outlook.com
 (2603:1096:604:194::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88992932-2efe-4646-3564-08da02ee4303
X-MS-TrafficTypeDiagnostic: OSAPR01MB3475:EE_
X-Microsoft-Antispam-PRVS: <OSAPR01MB34757EA7CBB04A904E4173BBD40B9@OSAPR01MB3475.jpnprd01.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akomeCom4X1rjoGLKeTaikBnjmZs+7Ew3UgxOmDlXzS5XFJAMYiMNx0SrCGs1mRH8w/RMHuA2Hv2I6zavB2i7KqzYqrDZpgxVRtWiS3Zk5efPT4dWHptGVywSbkooybcfUUThTaqK69+DkrrPvu1K71DYv5sCZEqVhqGaPlbEQfQT7bd1Z0i17vc0ScqsIWUVePFOODR65E3R4H2Ry/r3TJSxtcruMtCiDL+UCUOmSc5OcYyAopk7qpxTwoFSSrJjvE594mTX6PyQGACStlqHV1wHCs67dpV4GspXevxROMm1Q1J/HZ7uWYYUndwlHjhauQRbbv3LrFGVCiaNdGha8+yxFZgrv68aPT6mHRMzVJkk/Q6lKzkvcm9rWGF1Yn+jmPylVFNcfdzdXA9rSA8zbkqywEltBriVxoPn34Ef/Qc/1X5/RgVG1J4Tfek69ME12D3gUpn/F09ThLBb34JALHxQ9J3xO+UA3yRf1nrZ+HmyzU5gE9MzrxpbVXkpH2Zgi+T7NOcR2yoAdWN+L7SxAxeOrH9UgygI/2huwzFjeBXw8ThS3nBOmawkG4J7Wiy7GaJ4ITL5gzngsi5Dw9tTKPTAuJzoYpyUicJGWsL/AWNru3ZZUfLQp8E33j6L76wsaIsAVnZNZ+9nGwf4+2sDFEiayOQ3K8wQl29bgcP5KpPrBw9I6wOfkLL43I6AHhJU/nOKE87cWwufpIogHnAVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8426.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(54906003)(5660300002)(2616005)(83380400001)(38100700002)(38350700002)(36756003)(6916009)(52116002)(66946007)(8676002)(26005)(8936002)(316002)(508600001)(86362001)(6506007)(66476007)(186003)(66556008)(4326008)(2906002)(6512007)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HZq/IJgP7SVa9lCEqJU7cRxT7UVJK94ba5gExZBZauO03gBkfhLb7Ezn6m0U?=
 =?us-ascii?Q?Wfm7LhG4HeO3R2kT4XptZ+IC8l0Q8IkYvT2+8kkj1ogctQiZULYtU6taMco/?=
 =?us-ascii?Q?cSBIfnU/xlxOxR7qomDIiGJcq9auLgH4u1i4u+swzJ3xsHsFUIcCYjo+Ej1x?=
 =?us-ascii?Q?PToiB5b6CGUjkGvx4VDCJThnyU/6JYBGNe3Sjr9NbIgOORTxPCx1Wrh0/w2c?=
 =?us-ascii?Q?Hw7DwVnIAR781hQioPTuKDNfoaTbim8ct/b9Y7K2N3Q+47nK5UvZK2Rr8ol7?=
 =?us-ascii?Q?VqKCmw0yHQxtnFciHVLnTZqCvlQ/VknZGGEk63FYhMkrxJPLm2N8wXDhZCj6?=
 =?us-ascii?Q?wDgnIqps0lVw4BgqHvviVdbNKs1aJ5jLHpkdQ/d7SCHEo0cOifCHrXQEWuCQ?=
 =?us-ascii?Q?PkHzrv4Sgi8TMmzx9K3nP0z3BPLaD9CHZkxOPzu1OCzIqcokvbxjKEzYj10K?=
 =?us-ascii?Q?zBcuo7SisKltWO2nDjSXaSvk1IVbVsxv77umFmcKzT0he62bm8YVDkmLtZHB?=
 =?us-ascii?Q?3nHuessM9NSXmb9+/b0jUrifzkQP1cp/8WgYJIvBSWxeTq7C8SCK116ILsCe?=
 =?us-ascii?Q?oK+NpSN7GZwZCgnSPMZ/HAfPB6pvo4KI1D7P1SQ+LxaulQR16tneAqV6bqhh?=
 =?us-ascii?Q?+fL1lr0uVrViuJTLv3Z9Y1T+HlYdzBJ/L2wawzsRk+WXRGRUIqjV9YoBGb7x?=
 =?us-ascii?Q?W6y+yHHtXV+SC3psSdDD3vMQQ896DMtE7Ug3LCeL2i/+q+TL61ZShvVWrZDb?=
 =?us-ascii?Q?KaWUr73r4VPXnNm0r8byx/9e7JbMxfdNvpt5CPugh6S6VcyCMf8bnRCEWTbC?=
 =?us-ascii?Q?ip+S4/ozDcbCY5vjf1qlYNhPBUt8pT9CdUtXkghnF0sMEAPT00N5MuSSthUA?=
 =?us-ascii?Q?qrRYIEmIsS1cDGC4ZqM6NFP6nZL1kJbsq+GhcnfIP9O1KpFKGO4Lk0lIffD7?=
 =?us-ascii?Q?o/Ltz05Xkf+atpRxo0/8xPwp+qDHxva8lKTDhbzNgnx/vow2FYGARc2JbvSv?=
 =?us-ascii?Q?8WTFHzGd05H+mv8fPFwo9iRy2s5nank7ACvmckaZ0K+vi55hzIx6WbjGh0Zs?=
 =?us-ascii?Q?kDgeq6jpcAEDo39zmhkEzbEv9XTfnZB0bnRn8y3CkP+FRUYc+KJykhdnSsqM?=
 =?us-ascii?Q?MdASQ++gBK/deLSDKnD2WKpoG8qbbIAYj7iUJjOWxNzGcOB2dor8RewI/QfZ?=
 =?us-ascii?Q?I0LYmcMY0tyzWgSiEDnb1H7XLHFkD1xpxqi4ducAXq5veXiOU8bxCn6k+g2D?=
 =?us-ascii?Q?YDBLWgGN8yi54pUSv8JVuDqTCwhEPBcFhsbnv3j7eR9woQpgyCpd9eefbPp2?=
 =?us-ascii?Q?80wwiWIuvkZ3b5gGNcqCPSZOBpD3dZcJ+7s3qIt7kconlmix9egt8jWRwS6R?=
 =?us-ascii?Q?VUdmPsMQzX1H0IF20+hhP/Nn3nQ93LpGt1e1EqUgzzmLKIJCSuA/P8vgCIPE?=
 =?us-ascii?Q?RYDWE/YBpGm3OGi+COwxw+pbW6V/LpYcB5R6LOEJDWecRoG0f0ffIw/FVrKi?=
 =?us-ascii?Q?S1+Cwd4vu6FVMLs=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88992932-2efe-4646-3564-08da02ee4303
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8426.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 23:32:37.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jF0PFOZJrw3InysuhbXKIlL5Fw12meTDxo1AVZov6Oh3/L2HXjvMTBQOMRQioghnQGvnVaiHcVT7kK1blfLG+z85QlbQlKO4eqbG2I846jZgdKSuaPbVzpDuG96i3P0v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3475
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

> Playback or capture errors are seen when clock is reset during an active
> stage of DAI. Presently this scenario happens when DAI has both playback
> and capture sessions running and one of these finishes first which will
> be followed by clock rate reset. The remaining active session will be
> affected in such case.
> 
> Address this problem by allowing clock rate reset to happen only when
> the DAI is no more active.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---

Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thank you for your help !!

Best regards
---
Kuninori Morimoto

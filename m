Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9785A7787
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiHaHb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHaHbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:31:25 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD27BC804;
        Wed, 31 Aug 2022 00:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDZkSZl0L4aMZd24tzIMQSjr37Mj9fKC9PEduf9qFeUJ95pGKJQUNsrTlkO/wygGlUaZQj8TNM0qOyzL2rB5bCABJ95kId9E5oUrzTa7ZHFbBKpPcVQHpwxFGXhj0FzEtswJR4SJ4ng7uHIaAIvnkyjFxRoCIhxtKcD3klpaog0ozdl//dKFLyakSiJDxAzGIalEOA+NehgUPNKfSe1gGqAGlcwNomxyqTe54GWZ7jKR5OLWWgXMuLPCd2vdyKObIbw2ORWpwJoiX3P7ua4TfU3aCrHMDf9gHQyWJyGJhbNF+x5gOtdhoV+8guEhq69UtkagFLu7NA6hWI4wEUMtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Voqayz6aL/EbEsxEAxQIq0431NzfKFDkfwlR+j3yREY=;
 b=N5gpek+4930O0UflFDOOariWKemmMuVdK1C9142Pi7pajPdM1aofET8FgU/J5wb1LaakBH5Vaqc0Bg7+XurJdm6cek9n+cUApWmdoO+f8leoGcx+rSpoZ3y6JCSO554qEojiG/X+XIhYz/DRdjcSpkWoda1FegWI3L2ipXg6owVZTSqx6Cl3nUTXe727FGOW4Pl/VlvO2vorQWVExoOaFVd98AH7xRCmmrUUXPnWeKYXD5MfHdzHzxfhXjEFf1IQdeAvxVnQbRC1+1LYyG7fcUJRSE15KbkKhJbo2lIC7gQ7hnA7RSulKWYpFbXlbNGkldOLULeM/Yc365WTS7AwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Voqayz6aL/EbEsxEAxQIq0431NzfKFDkfwlR+j3yREY=;
 b=iDO2WMdLvNEqJQyJ7CBzFxEVj2aPqNvntnhLNrdasfk4yLVj/YBMok7ZEckXUcyhYn2RzKrqyVOj3Z0XyQjwq1wcw1jJrtuZxVWgDeXWRaH8tCNXkrYCNdozi7KqByttXwbLCdMksNZv0z744Ns0fb5d4jMl3Ls3gxt5PBI2fA1sHO1coNfLyQ6iawS0zU5K7L4GGM99+cJOmLGjMU1u75g/sbQitY+B1FAXsf8JuBzeKrSrwqN5PAUuVYw/k3OBsl8xns4tLTu549ppcTUz14xcEmQfS1xKywY5cQjI4VNdyTTOvffXw0RDvuok+W+5VtvFIF4hibbZOHhjrAggOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by DB6PR0401MB2328.eurprd04.prod.outlook.com (2603:10a6:4:46::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 07:31:21 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::c1b3:1b0c:46fc:4b2b]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::c1b3:1b0c:46fc:4b2b%3]) with mapi id 15.20.5566.019; Wed, 31 Aug 2022
 07:31:21 +0000
Date:   Wed, 31 Aug 2022 15:31:07 +0800
From:   joeyli <jlee@suse.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Ben Boeckel <me@benboeckel.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Malte Gell <malte.gell@gmx.de>,
        Varad Gautam <varad.gautam@suse.com>,
        Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9,1/4] X.509: Add CodeSigning extended key usage parsing
Message-ID: <20220831073107.GT5247@linux-l9pv.suse>
References: <20220825142314.8406-1-jlee@suse.com>
 <20220825142314.8406-2-jlee@suse.com>
 <YwkrpLPyU0huPduE@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwkrpLPyU0huPduE@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYCP286CA0093.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::6) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc9998ef-d084-4341-acb0-08da8b22ccfc
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2328:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kPW+UMAWTXrgdbF8GPcVWHmgIAc3Lb//ly4xZQ9Zu3FUykwfO/rc+5DUXXiWz3NtHrt9zKs8QQbeIafSoKn8Xd6IKn7yGRQ/3nanHi/VrG+qJjTkjNPY4HyuXLyY+06AsdxMc8+CiMCRvbU3pbP7WfzD1H/UzIj88A1qLwjixq0qWbgQiD6EJv7oQ2oKLanyv6goRl7aWoRLyaAH72YcTTb1Vx0pq98AcAyPCkIAZ0ZThiuHw+vLiYUHBqSTAc2t1XOIGyA8C6k505hPzBC2g0wXpGawpXxvbwoqIfCuHNO0Y5+Nluu+VKcDwl7E1YGpLTisCPyrGsF5PbNvst6rOWOxTZ0YKZTptAb+DkPe5VNsXSq5/p408AxMYl9mskUheWdKpEFgRcNw9m5x7e7ULLlb6ZGstiuHf3dHYa62NbH+40rtVycfb1ojc6G1EZHnu6xJRvkv9yzuCfbXfBhePeUU6e2jLwIT0D08DAFizmM4AJ3e9RS5z5T0jS7n0Q+83inGMv/7HZgkROdYk5hGMWfib3jS3gPo4fugwfIp6dht5t/fj/eG+dfgoDMYJci5mQw1fBbzKwNTHNhbEEzwmCj5gH6PCqf4RB4omV6moCMf2Lvf3T+tJ3ZsHWulIY9frdboIDf8rViu2UZOysqzI4k4iUaLlcFG89e57AgL4jxRMC0LD+9TiZV8AwAsYaSVzuOABcAgRFWcG6ewX9uLUMsWESuuSF5RmzTqqWJyudA4CdRHJS5LH377Q1fTg2V/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(346002)(136003)(39860400002)(396003)(186003)(1076003)(83380400001)(86362001)(38100700002)(8936002)(5660300002)(7416002)(66946007)(66556008)(66476007)(4326008)(8676002)(2906002)(6666004)(6506007)(33656002)(41300700001)(9686003)(6512007)(26005)(478600001)(54906003)(36756003)(316002)(6916009)(6486002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/CghK1t0LX2tV0kPqSPjUbAfjNvCi+WUcL0zej/I8vi1ZFMw4FvTFOoSuMCW?=
 =?us-ascii?Q?2ukvUdopdPm1MRV1dDSi/rh4NLdV/B2dAx2/pRYtr/bBabj2J/FUOP/2RzTV?=
 =?us-ascii?Q?L048Rbg/tlCVqVLhwKvtRR0Cb3H57nX3oR1Bxn9aBIMWWwOXL46UJ1jTGJIP?=
 =?us-ascii?Q?z5OGkUdLTnBMy2Rb6C2Q8gsMGEgQ/+nwxcr9AmoUCVwjpNRXwcd5hiSCud1v?=
 =?us-ascii?Q?bVZ4byrOcWCs1WMR677HYN9WFWrERv8n4Z4v1iIQeLJ1I/aKYiV+K7X+ktWi?=
 =?us-ascii?Q?HX5MIsMX8FzeBbVR/d5gAtUoQsM9kElp2sktpF4QitrN+mFUAaWmchukXYOc?=
 =?us-ascii?Q?oLQXGe/UGCvms1EtDuXPX2aRq5oyrwS21qU4o7qefxtd/KZhvjw8LyguhnQb?=
 =?us-ascii?Q?+O6WAHbArPj3mpZmsO78K1ltpelI8ytR/bgU83Zy21DKlyJNzbLaHBd7ZypD?=
 =?us-ascii?Q?84Uu6+BvFJso8oItmVq+oZ/Vp6UTUaHpiz3P+tkn+l+s29mvcY3bgC2R/X21?=
 =?us-ascii?Q?0KX+QECx7cQeTx1W6WG+8MzoyphmnPYGEzq6lXgW0gs4E69gEpHgW+shJ5Xa?=
 =?us-ascii?Q?0o0Nn2RdCuTe8Rg8hKjonweZQriuGnx5oVjkiHi4EaM5RtPKMdmElfxnaE6h?=
 =?us-ascii?Q?rKz3MKT+Vn8RLgWY874SbNGGjNUEF0eSKpml7WP218HptM6crX3yKNEUQbfP?=
 =?us-ascii?Q?RbGeIikRtGTaBTDcTYeQkKmrqkQ2o+F9EJ8J+ptHirsH5B4mhWvijgjb+A3o?=
 =?us-ascii?Q?Kaox7MFyga0zBkX/0YB7SjBbBHV4wWDKXbHpp4Y+4cKZ6c86X5kJkdkDEHcB?=
 =?us-ascii?Q?nQUgXKaYHrQQ7XQGwalw5cwVs9Sp4wqU4MffEuB1DJ6y7Z5gN6qRjClxsplM?=
 =?us-ascii?Q?PgI14UQt/R5oVvmgp4y/9Emj7AdQ8EQGzm+NEUlqOm7w1biyT27SX3Kjqly4?=
 =?us-ascii?Q?MT719M2A9xvcRelK13VLtfRiSn8SglJAgN3G7tkf7SMi4Q2QdP8Ex3wqV9zJ?=
 =?us-ascii?Q?ChDfXEfxiaFh8xkpCrWThDWH5xuUrtXS/cPfyNKGuVlZCRhhewtpvd8yNqb2?=
 =?us-ascii?Q?SazsMG/QsCWUyXwlr8v9yuo1qbTqwQr72u4ptHPmwuR/vzfxbhnSHj2dsGii?=
 =?us-ascii?Q?k7oq3hWPFxGHmeeOs+vfV13v6QjPIkIj/j9dnMskSBdRd+OKOZGP4x1YInfT?=
 =?us-ascii?Q?6Jja+SErpXV6gZ8aQrM+FORj2k5t3kybSACdTwoaVz8snN8qfqKKCIwMparK?=
 =?us-ascii?Q?O8mpiAwrwb35vqRDjUHpY6iOMgohPk83ROOiU8ThxLgbALZENSpbbBjNI4RS?=
 =?us-ascii?Q?tChQtklnSgPiQOIXDAUbWhp27cjBXXipSVZyOYE7VgN5SYTcT56fp5utk/75?=
 =?us-ascii?Q?AM3evdmoDHptOkB81Yn5Bzhy9NrLGB/4Vq6AieCRjreNt8PSZ4cUylOKImld?=
 =?us-ascii?Q?LZN5GMz8FGinEwT6VYgG/WfUemZ7m8i3OuBQ1kat5io835LuC+N0VcspDeKJ?=
 =?us-ascii?Q?NAPboyQw2AhpwZtkEK6iZMPkAhgkoGsUml5MDkao6BHGTBOVGbCaOASg/6RV?=
 =?us-ascii?Q?vH8O2HOhxxBSG4l8DsA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9998ef-d084-4341-acb0-08da8b22ccfc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 07:31:21.4980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5apQp+PlAvQwmdaJhugMlVqD4aSIwSezwE2Il68zE7E6vSUpn2qEd+yegt3Ypf/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2328
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

Thanks for your review!

On Fri, Aug 26, 2022 at 11:23:00PM +0300, Jarkko Sakkinen wrote:
> On Thu, Aug 25, 2022 at 10:23:11PM +0800, Lee, Chun-Yi wrote:
> > This patch adds the logic for parsing the CodeSign extended key usage
> 
> It's *not* a patch once it is applied.
> 
> And isn't the identifier actually "codeSign", not "CodeSign"? Please,
> format identifier correctly in order not to cause confusion.
> 
> So, how I would rewrite the first sentence, would be:
> 
>   Add the logic for parsing codeSign extended key usage field, as
>   described in RFC2459, section "4.2.1.13  Extended key usage
>   field.
> 
> E.g. it took me 15 minutes to review the commit message alone
> because I could not remember the RFC number off top of my head.
>

Thanks for your suggestion. As your rewrited sentence, Adding RFC2459
and section is better for reader of patch descriptor. 

I will change the patch descriptor.
 
> > extension in X.509. The parsing result will be set to the
> > ext_key_usage
> > flag which is carried by public key. It can be used in the PKCS#7
> > verification.
> > 
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > ---
> >  crypto/asymmetric_keys/x509_cert_parser.c | 25 +++++++++++++++++++++++
> >  include/crypto/public_key.h               |  1 +
> >  include/linux/oid_registry.h              |  5 +++++
> >  3 files changed, 31 insertions(+)
> > 
> > diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> > index 2899ed80bb18..1f67e0adef65 100644
> > --- a/crypto/asymmetric_keys/x509_cert_parser.c
> > +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> > @@ -554,6 +554,8 @@ int x509_process_extension(void *context, size_t hdrlen,
> >  	struct x509_parse_context *ctx = context;
> >  	struct asymmetric_key_id *kid;
> >  	const unsigned char *v = value;
> > +	int i = 0;
> > +	enum OID oid;
> 
> I'd reorder the declarations (suggestion).
>

I will change the order.

Thanks a lot!
Joey Lee

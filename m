Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6245A7833
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiHaHyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiHaHyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:54:52 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0825F6;
        Wed, 31 Aug 2022 00:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CoR/EAqsTn0qvXeV8H6NI5/AgKjosDxs/WG1aGXCRGxQrviLxNe+Lm5ZqVBTXSZpYg9J5QcNxHwwc7rz30D973pa1ZLhZ9Xz0eWOajqR3lnn2MyyHzYp7iXpoigL9PW5pGe0P4BHAhNbreRAC98djtSiS39kxxaqf5HiDDplIAwH9HIj701gDUKOx20M85i42W8fk91d9/11sGaBx+sNRRICKYfhG4yvRFc9JJioPY5s+6itvFgDosqTeAM0zj4elKsyrLD3psvB33/I2UyzVFhRPI75fajwEfNB2dEFlodWUnqujlVpDdSA1E1glx4EC/S7+NrbsmaPAeJJyX9tWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMSlmfRdfD+C9sjZ8f1RIK883IbEWUIZ1h05RnXbP/A=;
 b=iuAcsEaTmNhABeSvUbbpcAYjwAMlMC7mhYCCKbCcnujYQMf80/fUAbGCS1kl4O9t6QQLL8WfFMnzjmq9puBPm7Pz9oaUKXOXL4LIzcwYbYiRBCqctSZbLwTgPLX91pJ6pdxUbJswL9ItVe4yboBkSJdwYSH1J7BgiNpmiGItgcTsfOZqiaPpxQgyoMCBGDm/Nh0r5mZU+Jdh1OH9G/mB/zGcjdtuPMPRfI+93qB7ypu4VoDHdCkGfwE2BtSG6o9sNONHnWrJ3SqezrksNPlpV4GQdLIXD+9pYFYEY96IPZgIxRgHAB3GmoVKONH4PmmQzmZqXLd6hFLDuIrX9VCyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMSlmfRdfD+C9sjZ8f1RIK883IbEWUIZ1h05RnXbP/A=;
 b=KEWnvhX89G6Ch9sP10X7ASBUtcS410AUXZDtB2B9G/ttdOhLyjBxf+AD0vKdkwn9adjwEWsz1JLy6OCyGoonjhKrS+SMtLzw2GdKljGzFYMneFUEpoBZwkBpQVz2SLGnQJO9dSIY8JxhlPpT/raPk10x4Ermg35+CTqMjcn4pBiWzfcGZ4uqT8MdryyJ+sZ06j1X1jS9+KkPXO3Xx5A0kijVtXGQNCr3LKKfarMfTGeqscdrGprn+btLDGrnoNxlph0vIMP7Gey+0QesdDcEgUcdX+1r2wlCSGBrtLCbWvKpGy8OvMhu9IW215gZGZbuj0tINompV59yoonW7ZBaiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by DB6PR0401MB2486.eurprd04.prod.outlook.com (2603:10a6:4:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 07:54:45 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::c1b3:1b0c:46fc:4b2b]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::c1b3:1b0c:46fc:4b2b%3]) with mapi id 15.20.5566.019; Wed, 31 Aug 2022
 07:54:44 +0000
Date:   Wed, 31 Aug 2022 15:54:32 +0800
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
Subject: Re: [PATCH v9,4/4] Documentation/admin-guide/module-signing.rst: add
 openssl command option example for CodeSign EKU
Message-ID: <20220831075432.GV5247@linux-l9pv.suse>
References: <20220825142314.8406-1-jlee@suse.com>
 <20220825142314.8406-5-jlee@suse.com>
 <YwrifCrlJceNG5He@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwrifCrlJceNG5He@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TYAPR01CA0035.jpnprd01.prod.outlook.com
 (2603:1096:404:28::23) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbf7b388-47ff-43ba-61f8-08da8b261193
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2486:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRbzu0Nosd4CXRDmaRWazoRTed2n+ptxYZlVy0JFkRljG2O0fCx9qFIyg2L7fiNSia4RDbPT0EksHTxY9WzCvH3NqhGziH1pAwy8USFfALzbFqcwfG8Hm5Kp2TJ7mEXvPSJZv1fX7eRCVfEaWijLOV4WIxNhFMZauzs3gZRrzF8mQAGDFZMQi8jfcR3hhDeTNXJD8svgY8HdIkauEBdJrQY14kg+fS/t16uc8LpsG8uCqaCl6qhWEDSnsthx0OT//SqmP6mv0GtvS+yeRoqaPytWaKTkE6MlC//PlLKDkrbnMZqfB1qXlYRCCUBJYerY6+Sl/9YCJAU+q6O8tU+K+1n9zTISlMrXuzNygr+CSIAiinxlQb7iUG1iZsMfY5xQVKVVmvPn9hxEOfzHF5G8mQ+LIPxXAPfjZdqPSHgxys+PivgRM2L3eHXr8yQOcuUJ79/FT7DxGV/nPaaaivPPvSkRJmmCymeNqOYyfbJm4R0FWPtbEKr0Cw3P8v22bvL9Dw61j7caN9JSvC9nPv6dp0seXB6omoLFXGqrx0VypAr+kbH9ruKhdLC8LzbmWjxD5qu/MvVQGmwu6yQf2jNowtgy+QMxnGeI3BxfHEzCgjTgmhofZ+Cz2pZQEjQMelsjTuq12bdktkTzuDSGr2JUbujNKD33fi0EuXmVAk52PB12PmGBAe6D3btGTmAsr0EHXp58SK5Uj70CxMqo33cVJOPxfTf5n46QNmvYnRuqi+XdKHt7uAhlCeP53aYSenAi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(396003)(136003)(346002)(7416002)(5660300002)(478600001)(6666004)(33656002)(8936002)(36756003)(83380400001)(26005)(6486002)(316002)(6512007)(9686003)(66946007)(6506007)(66556008)(38100700002)(2906002)(4326008)(8676002)(1076003)(186003)(86362001)(6916009)(66476007)(54906003)(41300700001)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lfOz3T2MM6s/Eq7tKtalwNZpBgIs2cL0tr1vO2BZBvg3BIKM+p6tFLrLDj93?=
 =?us-ascii?Q?rzMxBd5KQn+5VFc26pIqRUgr+kQEWLrMGIQDFq4vu0DkuGSqD8NR28RXQ39h?=
 =?us-ascii?Q?hy0OgPqCsX6ENNNO37Tbke43HKndzkZ7PBxRij1fMtKs6KnGVRQ8n0FWmHu+?=
 =?us-ascii?Q?fcOLz2BoxwtFhKK2bb9NbVINtZ+ZBpe/NQoEZGuLkkUOTLTFukw4c+PIsoso?=
 =?us-ascii?Q?9gAYEwsJmZM2qFCeSXq+7AV5zRd1YF93vJ58mdE99adfYPDNfs/Ri1sd203j?=
 =?us-ascii?Q?VU1IL43bnNFDAycmP+pOh54vQJJN0PliZy2kRwU89A2N37mEofsO2IADycfm?=
 =?us-ascii?Q?le3d3X8csCedlnnIzhlLXYaRhktjV+8TMM9l4Fh18YDtf3z8s1JMhVQxlKMC?=
 =?us-ascii?Q?KtsHiJhysJwTcIW5pIEFl1SsWmNUTNBje5JS17a98NFUWXA92FFytgi/sL/A?=
 =?us-ascii?Q?C/efRNy6SoUyKa+84aMaNYty+D/hDLn5d6QNLv8iHqfynHtWWV7eo9qj/X86?=
 =?us-ascii?Q?RjoWYUgeewTzwstva6L+tROXHdmwGIx65nVKr+ElGKgPOmhWMwbirkR/SUPb?=
 =?us-ascii?Q?6HuV4dRMoO5pYkNo48F/MyMskIqz4fwgaQN5qe1w+h7qojKIYu/0W5SKttzv?=
 =?us-ascii?Q?Pb5UlNQJv4ztW+lDgEFvohF/5aD2c6Z14GNlPxnFjXAWvdZ/abRjMbUJH9dr?=
 =?us-ascii?Q?I3XkS4FUg8UA5xHbc+3HKHPUrCik6rAPhX2qAa/uM1dPGOHj1HJAqcpDFYS3?=
 =?us-ascii?Q?a/I2msMNIGBsvvavqFWOh7VHuyevigK5qDDa23+7hwyW6bIqMAumG9NHnsdO?=
 =?us-ascii?Q?QbhP3VXJsjtbXIgyAZWjLiI9ROcHb/9oUM3xplVh7WFORMWtybGCdQlLbHsj?=
 =?us-ascii?Q?dXJBq7IhEU7HfQA6q/SP0N0bGn3FFAs1jqJy279sKBpoq+74PPoaeDzQxqEE?=
 =?us-ascii?Q?L1fxLCSlr54o/57ca4km5ryCC96yu/9m9SxCjgirstAfDe4tbtMq+bkthd5u?=
 =?us-ascii?Q?GyPgliDTAfFNyayeqIjTF9NwuCk6mmxLmqkHNlAx4jDEGIamUhZt5/nDWxkg?=
 =?us-ascii?Q?xNI6VuYS/y6goou+6P/zUf+Y75N9aDjAE54k3IY0j/iXfnsWkMfwJeh/EU9m?=
 =?us-ascii?Q?BGM7h4UJxWts5Bmemohkw/IU8kf96tZGYLEqSMUfqSMryUZE1605V8VnN6Gt?=
 =?us-ascii?Q?BiIxfzURvx5c3bbpp+ojVFkEQoUHpCdqN0njPp+NgtKlXuUVARyhNTj/CsRh?=
 =?us-ascii?Q?Cb8WkGZHoPOwHwTcHbogto0uPSMA9gaOlXivwH9Z956ju0XiNJKfDmB67ItH?=
 =?us-ascii?Q?s+hysmTrU4dNwFjV60/cYoEMXUkLYlm7LTqlBYJGKaDe+hSJWqGl1q57uqNu?=
 =?us-ascii?Q?qwaHZnXePe1KdUIx5b60f/gICyAalec5FQ8Yt4Q/zik8mMImWTR5fqbpJDwW?=
 =?us-ascii?Q?jdcna1cgHWGBNV3Mia7FA5rdDVp39McpyIAuHKL1Hc84EGJJuky7i153fg5q?=
 =?us-ascii?Q?C+MghcEipwSnALoHis4r/bRbIam8UO5ef371z2Zg7A5XFJO8kImDq2dypltB?=
 =?us-ascii?Q?dX1YRogqmd2TmcwCuxA=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf7b388-47ff-43ba-61f8-08da8b261193
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 07:54:44.8267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbQEyK/txoh2TpH7aQTGlRSzBtMwTYISglwXEPiFnF6FFQpyATfLu4Iy8a/cA0MW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2486
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 06:35:24AM +0300, Jarkko Sakkinen wrote:
> On Thu, Aug 25, 2022 at 10:23:14PM +0800, Lee, Chun-Yi wrote:
> > Add an openssl command option example for generating CodeSign extended
> > key usage in X.509 when CONFIG_CHECK_CODESIGN_EKU is enabled.
> > 
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > ---
> >  Documentation/admin-guide/module-signing.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
> > index 7d7c7c8a545c..ca3b8f19466c 100644
> > --- a/Documentation/admin-guide/module-signing.rst
> > +++ b/Documentation/admin-guide/module-signing.rst
> > @@ -170,6 +170,12 @@ generate the public/private key files::
> >  	   -config x509.genkey -outform PEM -out kernel_key.pem \
> >  	   -keyout kernel_key.pem
> >  
> > +When ``CONFIG_CHECK_CODESIGN_EKU`` option is enabled, the following openssl
> > +command option should be added where for generating CodeSign extended key usage
> 
> You have:
> 
> 1. codeSign
> 2. CodeSign
> 3. CodeSigning
> 
> Why this ambiguity?
>

Sorry for the ambiguity. I will use codeSigning in document and patch
description to sync with RFC2459 and openssl.

Thanks a lot!
Joey Lee
 
> > +in X.509::
> > +
> > +        -addext "extendedKeyUsage=codeSigning"
> > +
> >  The full pathname for the resulting kernel_key.pem file can then be specified
> >  in the ``CONFIG_MODULE_SIG_KEY`` option, and the certificate and key therein will
> >  be used instead of an autogenerated keypair.
> > -- 
> > 2.26.2
> > 
> 
> BR, Jarkko

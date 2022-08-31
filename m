Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035B35A790E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiHaIaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiHaIaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:30:15 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AF227B29;
        Wed, 31 Aug 2022 01:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dt8u4n8UuiPSnqOCmF3uSbJMULs7Hc8gt/Sgyu+cyPvX4QLoIhJzYTVCk5DZt9n0KS+aaOnz8MPwflcb1gW6uhGie9Im4UYHuV7TzshKyZoZBlSCbWla7k6uv6mroqavvrdFtFPwpLZhI+iZeh+AtJgcFxBRvbbgFrNxtTFgZWkZF4Ps0u/PTn7bRaaeJY57xhJPkx36oRlh44L5wlRjf9jbQo7jzN4ayMb0cmisHdyAVj5f4pEb6UkNqZu0u6DClLus4Sfx3UhjuVec8Rz0SySnc+rNAu31gn3KfcfGneDmltyDlJGYxMZEt8PlDk7TU8lyhVuZOWFjizcVdSeDqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9jESb8JvrCsbO1BKWPjsxnveWbFwEinpLHNSHK3YX0=;
 b=KQUNTn1TtWQ2o9GN4GuB3xGYPMMMPqF4RueLTTbXXVSpG7bAQMBJKbKYw2XZr4/ku+irZ32mLut3xLGUaooW/olh5fZdppt37ZBQgzLcgJ96wwQuww/HNH1Z5LCz8ztLEZ0skEDyCMpDv4U6faZWOakdaXQPa3SLKgIlp7Xzq+QQUJnQEf+AhwzA6KaDEgm3VlsEPbmhCefFz4vmxNay9Z8JMsBoOquPF288DkkUb+7Bx2a857YHGhAxMa1WOUvIlQsjDq5C+Jma+Rn/XpDRbFNwayNC4+F8mghbrIrgLxJZUSPF3+77aXmJoQKlo9rzs8ur1Np6dDI6qOkWBLgNPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9jESb8JvrCsbO1BKWPjsxnveWbFwEinpLHNSHK3YX0=;
 b=iXMGjCg7vKVxdvN5l+dRYm5K1UowsSvgfbSyd7E2GKfAeAfwPJcc99VgUm51LSMPdoZyrpf4AOyP5zwUQnQy2P+EBUop2KuH+LitD5Fhhxu/cbrMs2B5qU6EyyqKgLxUmhZ5ohKC4tjrIeieBql58sqo06dmzdLlRUD2X8mf/4cTDeDXI1p2m5kusroi3FJvLE4FABEcpbRCzfDmVIYgn10jrA02B4JzWFdGxdNTC3bnPK8C9fLXYE1LipUlXwGIG/41tRO8aql701UKycK8mgcgUyPApc6VCqSSqBgePGs5rZJHgh0XPdzpPt7A+6Wqi6Z4u2lrACvVFk+4LCqQwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by HE1PR0402MB2906.eurprd04.prod.outlook.com (2603:10a6:3:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:30:10 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::c1b3:1b0c:46fc:4b2b]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::c1b3:1b0c:46fc:4b2b%3]) with mapi id 15.20.5566.019; Wed, 31 Aug 2022
 08:30:10 +0000
Date:   Wed, 31 Aug 2022 16:29:57 +0800
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
Subject: Re: [PATCH v9 0/4] Check codeSigning extended key usage extension
Message-ID: <20220831082957.GW5247@linux-l9pv.suse>
References: <20220825142314.8406-1-jlee@suse.com>
 <YwrhT0YLb87PtuEk@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwrhT0YLb87PtuEk@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TY2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:404:a6::24) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f45fdddd-e004-4d14-54be-08da8b2b04b1
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2906:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iuTdhOBBs9ndaFZCz9+5s9Fz3DDVOteNIh5msLspgltwpHcKnUYg4ZpNlpkwOM2JeipFFmWLUGIivfoUgsoGFVtVcdNvJh9nW5HNCE0RO9JVwRZ0mGJIqBOyiVYudDr/zSZClfeOa67g8wJKl19697nkM7V+L7/wk0lznln3xzqzdA0O52k3bPfSEYdYCGgRh64hDeN+Va84yLW88GsBfAkBpplYegi6UdQztKKIZ/zZlI9EFw0bSmfsDhyzXYvN319jwRq4C3nvfBGJ2AT/6zFzJQ91OGas1Swq8t3B5JrivkAjxzCFvJ727UzYb4W5JvjR2y2kTcFY5h5VZXXdDF7/3RuoDO37255ICILADbw+Di/njmOCToyjCuP4Dqf0DeBc9tausNpF7FKw0fchP7n/9OjIq8WdNegooKo+gIrOfcmOOU7pdUycql+jFxgNqh/8NFXqo0rU7P6h21WhjhhPMagxayg1kAGYxEjOEC7oVbQnqTAXfKgeu39zRV8RUBbTVQMRJ8dJhWG46tMK0b3eCPvA5aa3c76jAJdBYHMQTLlA6R+Jvw7n8tzfU2lKa2avtW2V68PlIaWbAymYcfG/fhNQeSazKkfB+3dSt+/PBwpUaOc49CtWbNASO/AeVaw7PNSZ+x/fCkJ02Xnw7PJ0DylZfJBAKGKDfq+3/NXJB9VTu3phrGJh3l6pLUTyFaFo9e5N0iIRGGGwJbw1UPfz7EoV4EbLgk/5RoW785USZr7slfDV4SKD/3mdcmjKWTpitW3hIJV8yadoG5S3/zByUBW06prtf/0rbIiGTn8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(39860400002)(376002)(136003)(6506007)(6666004)(478600001)(1076003)(26005)(6512007)(966005)(6486002)(41300700001)(83380400001)(9686003)(186003)(8936002)(5660300002)(7416002)(2906002)(6916009)(54906003)(316002)(4326008)(8676002)(66556008)(66476007)(66946007)(33656002)(36756003)(86362001)(38100700002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?935YmOfhM9VMY14TIk5KWPFM8YFgxbql8z3iJuD/JTqiVMnvAQhl5CIqkHg7?=
 =?us-ascii?Q?sbS3BK9sLX6k4O7ZVs12P4Ue8GW1SI+eOh7CmbsgDaIh0sZT4vLjH5laeeW4?=
 =?us-ascii?Q?31bRJvPvlddNV3ZcaCymHGubT6dSRd3HTjBf6nTL83Qj389BC9XzRP9AOS+i?=
 =?us-ascii?Q?uDHGYxEePeBJuM+2yHV/Kz4SSxxlGdLQxn9z8Ao3URQ6gwra96izLso9kpK9?=
 =?us-ascii?Q?ni6sih15zD/x+nkVwVFMc0lmWi8+vWtIdAekZme2/vGdTmI8Tlj4vuOuWSBa?=
 =?us-ascii?Q?ZbArysbGMs2GtC94WFDdKE81JGbmsriXGxKa0pvqQJeQha/I2vhG0utNZwNS?=
 =?us-ascii?Q?XLI7B9uDWNgmqo1E0C9vptJiGC8YHSA2VnrS40yTexOEIGQafupnI2CMWuIg?=
 =?us-ascii?Q?s2nqA1LTfbyopyYrb2boIeiV+jfCGLJw3Uw8S1ywq08SdefBsLuVfYwIFzMi?=
 =?us-ascii?Q?8fESSa2mtfwAN05I/bKQVMUbO4c14hrkmXNnq0mUE6l1/CDVo5GJpXI6NEuS?=
 =?us-ascii?Q?jDb6N1DTjCxSu63yRZ7aO46dsMbiarr3yC5qXef9fa1dB+Qmgz07zMhjllYi?=
 =?us-ascii?Q?w/ElFrUtCSbOn6Xu1nP+xrvpfEAkV4Kvsjml6JtEVoHzsNXYpU06Y2OwY+x4?=
 =?us-ascii?Q?zyj4JGQuSM/h6vPLTQW62jG0gXr7NUkYAFpbW+jMGVNTxtaxGhMa5rvbIC0K?=
 =?us-ascii?Q?zy6kTXRCBlOoNrn25vMGD3wP6vv6tJSZ1a/BtX4sJNgO/NBoAGaCSvBWExtm?=
 =?us-ascii?Q?Eb2AGvKW0ofKICqn5j6Of2UDGYWgHWfuZsHO9XdkNuesgKpCQftzJ93lc8/9?=
 =?us-ascii?Q?H0hz1MRm4Laxc9pqH4SQvNv/8aBh9MrK1EddljuF4+syg0TRxi6/B2/YmLqb?=
 =?us-ascii?Q?RxulMRbgxGWWu//np7xSy3K0nZFMqMx/bIra/+PdhPFQSg7B1bshRd+tnOsC?=
 =?us-ascii?Q?x+G1OR6+HE/9HpxrdFQoct53ICe3uf4LBM2u0YmAx1djVIH867cCOoAzXJGc?=
 =?us-ascii?Q?kYbhwa3/v3V4Aq6mgOWi9PRzczU3d1sC8N0dOglmenZ/+BQexhX5naJT9mfI?=
 =?us-ascii?Q?g6JVnril5KZK+ggf1JkOE3D5wNP3W5mFfh32tRJZ3zzu5r17IEAFe6C0dF4n?=
 =?us-ascii?Q?gyNWd9LZobYNYmi/CJSvJywv/c7QP8jIBErlQfoeZcmCLu1VcPldo22ba+6R?=
 =?us-ascii?Q?UjBc0gwQO2Y5oCfTgKGrPPdnjf50mWenPW8aPihU3x1j0VllF7i9STSIDFt4?=
 =?us-ascii?Q?yJhWak+aEEAz5foad+LxV46CFhK7jkPdFHuw26i2rWcGxf6vjcN0aYlouJHW?=
 =?us-ascii?Q?5ecc0NM0snotmWGxVLpc9RTtHJKGNdlT587N6N4tMHRCUW3Btqdij3wWk6Os?=
 =?us-ascii?Q?JFnQu4qc6zH4XntFsDOrWWJDgA4sY6n/nR+fxYLA7UY1Cbll8xt0DXUX8YXB?=
 =?us-ascii?Q?f/vdCp9xd/BeBqmyB08IxHrtCpKQvH0Eo3er8iwrPmXcK4V6HJ3wcRoCFOw7?=
 =?us-ascii?Q?fqUU0wvLyq5uNdPWbDRW67Lh+oTDcRTVY1Tmx1p190d9kCxo3HPxaOg1MTnU?=
 =?us-ascii?Q?If7uwD+d/aPasd/EAdbfH7JxVZaNzFfnsXs0WtyG?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45fdddd-e004-4d14-54be-08da8b2b04b1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:30:10.6806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iB+6VCatQj/C8CIzkpcIVvWJszBJmJQ5UWARwvHsxxbHgwpyH31c+DhtOYrWKfyV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2906
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

On Sun, Aug 28, 2022 at 06:30:23AM +0300, Jarkko Sakkinen wrote:
> On Thu, Aug 25, 2022 at 10:23:10PM +0800, Lee, Chun-Yi wrote:
> > NIAP PP_OS certification requests that OS need to validate the
> > CodeSigning extended key usage extension field for integrity
> > verifiction of exectable code:
> > 
> >     https://www.niap-ccevs.org/MMO/PP/-442-/
> >         FIA_X509_EXT.1.1
> > 
> > This patchset adds the logic for parsing the codeSigning EKU extension
> > field in X.509. And checking the CodeSigning EKU when verifying
> > signature of kernel module or kexec PE binary in PKCS#7.
> 
> Might be cutting hairs here but you don't really explain
> why we want to support it. It's not a counter argument
> to add the feature. It's a counter argument against adding
> undocumented features.
>

In some cases, a organization may publish different certificates for
difference purposes. When a certificate for a specific purpose is
leaked, it will not affect other certificates.

The function for using a code signing certificate to verify kernel
binary or module can restrict the purpose of the certificate to avoid
attacker uses other leaked non-codeSigning certificate for signing.

Thanks a lot!
Joey Lee 

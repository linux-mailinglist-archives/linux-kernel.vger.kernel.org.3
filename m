Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5874F1BCB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381551AbiDDVXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379195AbiDDQnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:43:06 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB535256
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpELKQ03TWFSYnWPxn6d1kdvhJhK1BAAL/UrlqVGvi6ZEsbi7wJc+QY70KYqqMmSHj3MRhuRxXwCkkz5KwSSn8kXggZzky21h1tb0uz0WuYlTj3l7k8vK+xAiGc6chH7PEZolaV6V/EhIm0/lBsbO1V0iUQnk9+QNt/QP3Wq4nKaYg4obYda7osXoMtEedb5s9XjbqWgsKndHgLgTpDYIoXHO3v1+9mFVgWg2LMZWUB0JhqqM0nHW6tWRJ9d0UFWR/o/+oFsFG6lfEIxcMeggnpsibmgrOVbQnukD894lse+1mgqFuHI2iuFvM6/r9ylaFyDQ521B/xJjkk/PvBO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZjFNGUqm/lD/mRu6+yCV7DiEjx4xJ8dxDqjMJDGFjQ=;
 b=X3DV0B+dFiDcSuHXjd4W1CRv9qU+145f/cVm2ScdmYv8gNTila5AV8pcfXY8Uap468tnHfeMVFWLkvUgsgPbCbcwHrcEj8CJ1vRjhd5SEx154Fez7kzjsQ3MVT1emcCK1XUZhBY7imE67Nz0xpEIpKgFiovS1GJ4uUqRX/yT9kDGTTcTtC3dlA+TG7BcPIKjXvy2GCoJk2424NCyHzC1zVmEWq9ikcJbi7I57qffLpk7mWdNKX+948lE5aVSQd48TCnbWDQLwHK8u7Aj+6uZ8fd1+lzccqAJLrrhfXe5huMiMJebYEgTFmfc5gfyUblvFlOYlf0cuVTfI9vGo3enCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZjFNGUqm/lD/mRu6+yCV7DiEjx4xJ8dxDqjMJDGFjQ=;
 b=k2tMecoGtAgz9HJiz7uRPUgEXG3p8XEhinYtXRIsFiJi0BytfAkfWuWNjWfOXNgUOQgvWb/Q55kfbJ3H+C556j5Bt6utcCZxoNc48sy2g3HvGTzLKUXu72FxA1OsH+rNbAUa5MXWXqzP5kp0nMOANjGSVI/EOHuu/o49zFaNkxqSPejoBHdL2MrEI9JBCvQhzig91WckFmT4wfBelKqN4ufgUTC4cYOKuOfFSZMrXhVwyq5WoCFlZaazUi9IXujxHs+qK9+ZNpPmx+QbYUtNjdHtj1MIb9ALSxMMx0zHsdOdlEavxY7vj0KtF8jM8o5BtfiPmfokDIL4WNtG5PCkJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BYAPR12MB3557.namprd12.prod.outlook.com (2603:10b6:a03:ad::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 4 Apr
 2022 16:41:06 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 16:41:06 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Subject: Re: v5.18-rc1: migratepages triggers VM_BUG_ON_FOLIO(folio_nr_pages(old) != nr_pages)
Date:   Mon, 04 Apr 2022 12:41:04 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <8BCE1B82-6D5E-4E7B-B744-402167D34A3F@nvidia.com>
In-Reply-To: <YksXfckGevTN1QD+@casper.infradead.org>
References: <20220404132908.GA785673@u2004>
 <F3E3F1AE-B421-4463-B032-3F58DF89A5E2@nvidia.com>
 <YksAub9UccPZa9DI@casper.infradead.org>
 <C4792D17-A7F6-4803-B8FC-B8682F50E044@nvidia.com>
 <20220404151805.GA800317@u2004>
 <857E3E12-5C2D-4990-A667-79E1FC000291@nvidia.com>
 <YksXfckGevTN1QD+@casper.infradead.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_08CB150A-C3AA-474D-BCC2-D1226E0C73BD_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::8) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a106ec57-597e-4638-e8fe-08da1659ea15
X-MS-TrafficTypeDiagnostic: BYAPR12MB3557:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35573CE6E9B8F00A5CE48AB6C2E59@BYAPR12MB3557.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zablrefwgrNgXgqtsLHFL4lDbgLZAgtMp5WVzaLTR3OL2kRO+Vfl7mRDj6YwY+fmcYBgFy/7lBv/pG8KkF42XMRf9daI18FHZlq34vBxRiO3I05dr7NVKTog8KnBd27Oc3cSSOmiH5MsyWm1IlHpGxikQn53YI971x712pGxN2kUkWhwcHzIeRLUNB/4GypLp07912b0y/nJrXPPDuFfMLscap+gR++NQWvYKShDVTapSLixuzy5K8WrMrVgTtW/zSIa/FTX9mZTzpcnmenesJLZLkPlsq+cTesyYvHVnRlHc7ycQrfD7aiZcITD48+4hYcUTmhXC7+3IfdpvAQ/3JyRwG/v/faDb6BwkaN5KFMRSlep6R8VSVfwgSYJE+6lEbku5Z3jPyrAh7rZbpDwm2akHlJma7Dyk38IKTz9+jjh2Bm9eNHdZ+7zqyTpHDsDNzlGizW0EPcQc6IzygkC/S8/WnHnNstsHKhPKCa+ibuynkFNvSRXejVg524Kj2ijJVmteCRtcTmTHK/Ea8tAgLcewFWfiFNNLH0QZAKXvPxiiShLCGKB+aHwmv40vriQGEcJXHv1ZQEOlso30JAwgBUGkodtn4oXJoMFCP1jSFL7P/DvbT7+ej/7qNEC9+zF767N7X/oDl/D+C0VqevP/2sRYoj3lrgOJBttoVsZoBT11SJW5Mn5CSP6EdS99cnSpZO8ESO29HQAOPV/YpschiR2gij58oShB5PMZQyjnsQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(4326008)(33656002)(36756003)(186003)(8676002)(86362001)(6512007)(2616005)(21480400003)(26005)(8936002)(316002)(2906002)(6486002)(53546011)(38100700002)(83380400001)(235185007)(5660300002)(66946007)(6916009)(54906003)(6506007)(66556008)(66476007)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y7RHIVkvvI8P4aj/Il30Pgrd3cB2awJxu+9PNCQAjWv+gK8YKgolRFr9d3qc?=
 =?us-ascii?Q?PzZKfDzS+5OyQkh2LB1tvDRQ/nizDyXdjMl9VPj54VFeOGiaRxIRj3ItBOp9?=
 =?us-ascii?Q?MSLEhDGXiDYD68UIFATRQvoUs7FW8hmAF77B8vHN57l8UAYWH4yoqhC/33dn?=
 =?us-ascii?Q?Joi9LCTVRrn51TFYh6cgwSYru/xJf0lYeDCjOPyO8PFiWaarii44uWySVfTP?=
 =?us-ascii?Q?dQXAd53jX3YmVxkt22AgWnwSEHOd8PTlxhmOa4pyWNCdbP+zUQTeG8WYlsBI?=
 =?us-ascii?Q?3xD8IuYYB6GbTWqwzw+HFhyEnPXV0tF/iOf1N161phUG5O+ZtbINtGwf3G1U?=
 =?us-ascii?Q?KPvgz8gplUEyUGL6tXRbzLqqsLW85yyZ8yuRVXaFYvQCQog34QVbwDf8EE9t?=
 =?us-ascii?Q?1/bfk5j0YenuUJSji+1AxGjgemT/O0y68UDkv1typSyJYbG0IjL5iCtR+oUm?=
 =?us-ascii?Q?4z6w2DIz5gL7wdZ4SujS341kpYghXducec7aBIP0adynPh68h7zjQepApBqT?=
 =?us-ascii?Q?OO+g+Aw1DefmQC8/FX3LIRt1CaH9xnqV7Ig5KdzgSsuERMVajdv7f28zgRTZ?=
 =?us-ascii?Q?b1B1Wz9WlAjEVqmvIBuQrrDHJ5moirpZYvQNnICrXSr3mpX7E6NboKbuJnCs?=
 =?us-ascii?Q?bmoiQVWhHabbZOgOsVy+5kxnrQo2kPEica3Ykzrf/bb2dp74/aWSC2mWlBQJ?=
 =?us-ascii?Q?6sV4Yvy+uJs5R1CjmJlCIRxxJA+6ovHV+l8W6IK0zjbIcwFfLmcQ7cTXgpoc?=
 =?us-ascii?Q?HdNFMpNmw800EWX/2F7su/QUGSJ3WGBipDPjd3aeL8KGkrfv4EjtKObsovPL?=
 =?us-ascii?Q?3DDbQiyC3DETO9noh7CR+6gzCMt4WT9aIjJLaO3XCMbxE+aBhKKycI3d2pcJ?=
 =?us-ascii?Q?wLKUG5hfEBfwJksijK3IMcLaf3C27ZvRcOJikb6bDrAImOvPSLWRhQiWMwrY?=
 =?us-ascii?Q?nKolyGelYox4AQ95I1py0+yffE5rULw6vDGjz/9zSjSdxmYVGvr9DKouYieo?=
 =?us-ascii?Q?6zN0AeIaR9tZoEmO55bEqSCjtDimKee7kVPMsKkYfTgvp1E27DwhMTj+2Ro+?=
 =?us-ascii?Q?aKUo3EvmWG/CTKB2Rq5/HmqJ3uqmf+fKug5PWBQpXLqyxDxIKbsnDF+9/vfI?=
 =?us-ascii?Q?UedCVFdcqOCpEoea2Mk5Gd2pjFdFGhTyOF22T9+X0n29UdS6QTi4mfm2TYmu?=
 =?us-ascii?Q?B807yAzsiZ/Ag6yGyRD/GaMiQaSlYDq7Xlkj+Hqmxxi2b22HnW37ReNxziJz?=
 =?us-ascii?Q?tiJuJEmaTw9/hTPAIp5G94Aggfc33aX7I9wZ/CbV3ObsXLCBeJMyHwj/7BLm?=
 =?us-ascii?Q?h24/oyl6gMqUkV5ap2neu9HsAUHQUajE/nujWrJDe8PZVIY3Lw5pxUti2x0C?=
 =?us-ascii?Q?7TfLo8J3zoJkG+JVlXs6/RYtk5epuo4h+uLDbhseoCq6yxKcBjUj3W0uy4cb?=
 =?us-ascii?Q?HS2r+BcnbiWaHBSCOELxuxBZ7f/ik1wi9VEtuJ7dpzp2SH4DPaDOxBRP0aWc?=
 =?us-ascii?Q?pNgX40tHtAiU8AUeNc8c8SQQMDFQgif1eiRLlm8SMQ0xwF/5doMyK74nX11q?=
 =?us-ascii?Q?SSv5yQXZ3FQ+ZAltfSYtTCcgL5CEPSTyqrN33B2c4iutFuNr0TPSbAa8NyU5?=
 =?us-ascii?Q?pG5Tnok3IhxyrSUVbLGp+AZvWsYJ16fqaq+USxjrpmGcbwjwhUCJ2MhKe18V?=
 =?us-ascii?Q?q5bPQNkIe1HfSdSrZEGoAPlyDVRd0FuhihOFqY21byNlgx3vvMKNAmKvxbi/?=
 =?us-ascii?Q?RbkruMhJTA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a106ec57-597e-4638-e8fe-08da1659ea15
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 16:41:06.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcoQ7U/pRTMkafPX+Z/ovAZ+OSxOUMYpYxoHwT4fHZq7lWFaXG5woHrCzaQfWhJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3557
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_08CB150A-C3AA-474D-BCC2-D1226E0C73BD_=
Content-Type: text/plain

On 4 Apr 2022, at 12:06, Matthew Wilcox wrote:

> On Mon, Apr 04, 2022 at 11:44:39AM -0400, Zi Yan wrote:
>> I am wondering if my change is the right fix or not. folios with order>0
>> are still available when CONFIG_TRANSPARENT_HUGEPAGE is not set, right?
>
> That's the eventual plan, but it's not possible today.  We need to
> be able to split large folios (eg in truncation) and that functionality
> is still under CONFIG_TRANSPARENT_HUGEPAGE in mm/huge_memory.c.  So
> large folios depend on CONFIG_TRANSPARENT_HUGEPAGE instead of having a
> clean separation between functionality-to-support-PMD-mapping and
> functionality-to-support-order>0.
>
> So I preferred your earlier patch because it's more obvious.  I mean,
> we could pull in the two or three patches from my tree that convert
> these functions and their callers to folios ... we're only at rc1.
> I can post them and see what others think.

OK, I will send out my initial patch.

--
Best Regards,
Yan, Zi

--=_MailMate_08CB150A-C3AA-474D-BCC2-D1226E0C73BD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJLH6EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUstAQAJmZ3zqv0oHSkl8FPBHTj+chwvtLnnqlG8AA
iQlD1K1nvYeWrCTm1h16A/BOLhpEJFn8clg/09KuXtYlv80rTbmLUutzqauWnLxU
i/dGdNef7t7bJQt5/7eQFT4ablq+kxwIyCyn8flTEiJDxTaxYa6XIyqx+lAJE932
5Lz7Vs/qDGmav9ibpbx4yLIiNYzkSWivzBrsx1TKX8wdOcfUkpkNqd52GIxMtdLU
ody1dLd2ArI0v6bb/onP88PW47zMcm07JQ0RMfiFQZI6Cy+y9GrmOyUO81aVU0qt
6Sofqe+wtnnwAH7EBc+bqf/IxsDbNWa3XchD8A5dALEWctBjElEItIzXnTjU4Pwd
kErC+wxF3weJV9Yqxzt8KvbKzpQp6ZOgh3wryByvmJT5BmJ0eiDeu1EsacsnuKTj
vbTGe2YhjdRG5jvJVMca8MDEPBGhvkNBdsE5uGaIcB1+fdwshYRyjoATjIY6+kK9
n/seac+xs7trW0Z+VcKgjZugy4DnFv8//v+YxdG3dvx4HgC3DOkQr4mG04uhN4QW
Gpmk6ktJ2NmH29apc275p4LR5DRTZVGyGyRcqyLB0P459yetJ6ho3wcJXCmF1c4W
A9RvKcKxg8Tzbu3MW9ogUTS2sEv47h1CzPMQZ8I4FSUN6yIByT4Eeql4NWfds5yu
C20aM5AB
=YWEo
-----END PGP SIGNATURE-----

--=_MailMate_08CB150A-C3AA-474D-BCC2-D1226E0C73BD_=--

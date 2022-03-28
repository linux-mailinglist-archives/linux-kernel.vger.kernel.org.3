Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BF34EA23E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 23:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiC1VKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 17:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiC1VKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 17:10:14 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6908F1FCF4;
        Mon, 28 Mar 2022 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1648501711; x=1649106511;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=vTpezr4NeclYWRYBUmdsIMPgmqZLiBf5F3g3D11Mzis=;
  b=nc12b6QwKBogPVZWhwkPoj0kCzIuHBQ8m5ajhiBdT0QXRcSnPpWZ3vG8
   7eRFvpwIJmiGsVRbjf8Gfhq93JS+QIHPvFgkk7a9A9xeZhu61RzM7XHXA
   HQDoUHCuMw7Pdfn+9dEFUqypdcIdks1g+L6qCW+UL5bqZXHZnj4diNy0l
   Q=;
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 21:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVjLnKxlY1SXcTCZeg4NS8NSPOJbEegvnuLzVihEMDpCeu3b0SDbjBgsGWPWDVOLn3ElnJI7JzyTn09rWI+HQ/CgThnSrLgqQKKdtUb8I6V8oSsE0ixp8gJHYCAqS5PxgUM3nwYFZMWbWlnN2CoM/u2+lF8htUMFtLk0KeSkt3QEbR213fKBD7eycKwbbfm7+FKvaUErF2mTSiOK1vA+uKmrRKlnkxz9wVQyU7Wl5DFD1ggnAaDapJGaZsXtxl1dlAi4L+5w58LskLLzRBP4nZRIkRjDtjGr3pwBkWxNCdIjHVRqNDk49Q6cmtgmtqUWRWqRGyqA8h6jDyLd/x9VkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTpezr4NeclYWRYBUmdsIMPgmqZLiBf5F3g3D11Mzis=;
 b=iPzBwu0Hv6/guZrUXw5C31U/U4E3BP+b2tstA0cQ/Cj3U2oz9WEt09czth/0SQ0LaIfmRciqjQY57nzopiPaVQEhv+wNSVDBZnfywXYrZqh4jPDadaNLS5BNc/mwLRBOop/BPQkhGZpB8KVUevSJ3PS9i2zqcZ8S+eL+bN7llCB5Smc1KVtLCdkl3eB2csxoJdBXyNzWGCjcZiWd5vWHtVv7sz/XOEeLY1xLoT0YfXIulKRYJkfgodnWyUskx2fqiz8qyDYHDFhM8PE2oz5meqIKI3blAk3jnN9gF0NmnKGHqNejdTOUx6C2cBoLXAep95W+Gx7Wu2zE7nzxDjAInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CY4PR02MB3288.namprd02.prod.outlook.com (2603:10b6:910:7d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 21:08:23 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::b0fd:51ea:1e6d:70e8]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::b0fd:51ea:1e6d:70e8%7]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 21:08:23 +0000
From:   Brian Cain <bcain@quicinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] hexagon changes for v5.18
Thread-Topic: [GIT PULL] hexagon changes for v5.18
Thread-Index: AdhC5tP1xtw3JqYDREq1Cw2e8br1Ow==
Date:   Mon, 28 Mar 2022 21:08:23 +0000
Message-ID: <SN6PR02MB42053E6FCED122482A5893D0B81D9@SN6PR02MB4205.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eae81496-0311-42f1-57ca-08da10ff182b
x-ms-traffictypediagnostic: CY4PR02MB3288:EE_
x-microsoft-antispam-prvs: <CY4PR02MB32889DAF54D79CAAF4655FBFB81D9@CY4PR02MB3288.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vSB5yrOvwy06VoLmYR7taWep0NM9AVGTZTaMiZQW7vijCmzX4RJz1s/bEVOFseq7PzUChW2wqpR5EU0UZnkxTurez88aYDLJOTQLQAj4odnJ55Zkg3Qm6hinBpdBLaTQmu2QnAl3MnzejQFq469aAjU6nyomfmwHwlIpyqZGvmCgbz0QrH4S3tlwBYMJ77VsOBM6v0HKP9KMjI6N+NhJFBWfd21vuTlCPwTRkhiyqg0UJwT8JcZAzHurXyS2fxVZcUhs/gvSL5npKJzkijFFxZXbzHjrDPAV1Ol5RHEoNQzPgrj4JGmVvKKEuN4xJCCelN6fP/z6Ae1rPj2Xh5PGw07jFCpGZFuCG/JzNMmxTmV9omFOANbEWc9wWdyzpAKvE86xlzU3tT8NFnCgg8ZZLwvJpuxqhjJQQcv2UTWMfWUTCG9AOYtdyv5mtjnVrW8nYVvEfymuX/AwBUpZgMndA+jXSPP/74UvHmM5GgtLqoEm/1a+/6HbeU1WqIO/Kaec5DZvFVE0m6obPzHH8kuJ/qupwk1t+66roL1W1+v/D9JG7vTnfcxM8R8JoVzuj6X4QhoI9c5quShITTnvs2azFxwL0yibbOVG2YcBiZhJ9irfrjJvJJzJ7jlcmaIgAKPYWP2xVj36cQBkNPQy4EDwSrHYrQ3q/U4NY9CBRWwpGRn0/n4gYzyoJbadELQVl6mOSKsGyQTcICG1fepEYj3xzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4205.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38070700005)(86362001)(316002)(186003)(26005)(110136005)(2906002)(122000001)(8676002)(83380400001)(71200400001)(6506007)(33656002)(55016003)(4744005)(7696005)(9686003)(8936002)(52536014)(5660300002)(38100700002)(64756008)(66446008)(66946007)(76116006)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gNmqlojdOKOkVv2wg+I8x3vdYK59gaPnQLAkIF02q4nSZI1LoPV9/7Y72rWJ?=
 =?us-ascii?Q?aj1Tk7hMmJ0UQX8jHm+KD3YFuTzMkZTSb5Ixvs1Q8LMqytlsWCDKMw5eKRMb?=
 =?us-ascii?Q?4bblJ+aeLYAkHkGzcC8cq2fSSwVTGN1Ta5XUfy4/dvi525iVCFAsEep5xk6r?=
 =?us-ascii?Q?B3keujkJKuCKHAHflbg7ZmJ6ccDt3Cmg2kPU39XAL5MzkxCHZT4bvR1AhrdF?=
 =?us-ascii?Q?XBI/9zWiHr0FVMq64Yjq9PnruujWoKN1KBkUJR3zb6JkZRN1Bc11SvpgY+sQ?=
 =?us-ascii?Q?WBDpBziGneSAIipG9RtTdZ2d+ysFeo7+tiROU8KT4gLvfFoWcEDFLv0oO120?=
 =?us-ascii?Q?4E26QcCX/fMuBxmZiqT4jfTW22Nm7KHAU2QXDULrWJb9hIVofevVzNH/1n31?=
 =?us-ascii?Q?/AtXFcJvVYXWA6lAJ+SvXdlrQ6LLGrPMzWnYM0MWjo2T+ipDZZSvmS/9VGPJ?=
 =?us-ascii?Q?vKn0Zedzm3uu9Or+uB7zmrqT0KcuGQIa4T4gBwmLj9/b98DE7gYBCSMUdZ5k?=
 =?us-ascii?Q?fhkd90TMoS8ZleGe9hUB2bStpDW7Roqu/bfYtIqvTlLcUWU5sT529CwgxINe?=
 =?us-ascii?Q?KEW0RogGKo44uuKzzo1t+flHE/f8S4Mz4MV/be9GseRXOsHMWs62o/YMMJ+1?=
 =?us-ascii?Q?TLCxi8Ks31WagPL8/8qhUSbWI3h0Bi22FhOsUXoMy1Z8wKogUtMlGW9ngLc9?=
 =?us-ascii?Q?PvWy1bprQL/M6y69NY31md+Q0kenmmDQ3+4zKK66xAPr0ZU5anvHEzuonLAJ?=
 =?us-ascii?Q?nuMKkrFOdcaiMbETc0rMPrg9KmW1csBWWYJmN4hU5pBf8Ew+BdJ0CtxEKtro?=
 =?us-ascii?Q?OqE02m1krqum0KNLn98EVQLioStN0Evf9Z1W7nccvadogji6f4+pNH4nFfQa?=
 =?us-ascii?Q?bwKU65DVwWUCY9O2d32LTqA68qS9erIFoFYzLCdLyfiHQ84Ed/4RNgCEFwbF?=
 =?us-ascii?Q?st/9AvA0NZioAzfq8eCTEcRs2h6Ul7IdBO9aRaD5KjYImVc7OSMYrI51Zqqi?=
 =?us-ascii?Q?1+mMKBJU4vBzL0XwbhRVLp7guZd40oUReRIeIaN4whaHea4PwLPdE95hPAY2?=
 =?us-ascii?Q?rQdn6zYr5dPxP3CsT/1emqqWraNk+ervMy0/VcfB8rx/OmCGObYi3jUxssiH?=
 =?us-ascii?Q?jueaODDKqkM4v2c2GcvWcfg9a8zKfqDa5Cx3gkAxeqaatXyZjbTF62vt5ls7?=
 =?us-ascii?Q?Fti+Yj4LWRL16T+2xKgFRXWMv4NnZ71qsQYBpDgqtqulx7rFsD0mVRBualXA?=
 =?us-ascii?Q?QGMya2YYR+P778OkyYiM1bBNGU9F93wa8ud9WUV01NWf4lwU8tWmuzhSgdzC?=
 =?us-ascii?Q?lGY2LyMRrPlIKDrky0b/o4bqeWQ4s4EqRZVVXxtZ0BAhcmI8yOKRqyUg58M9?=
 =?us-ascii?Q?SozRstuUfv7bHekrSUyVRNWXf+8GqdfZE2VIDegRllIANRHOwgTLscJiaHGC?=
 =?us-ascii?Q?ZLB71gGsaXA/yc7Myn9k2nsvaLySmCc/F9sb2K0giXSI8+cOImaEpbExIq78?=
 =?us-ascii?Q?6sYWLiYBDdX4cGyX8W64ZBBELqkybXN0UqrAiSkTWlxE7vTixlpnN9SMauQt?=
 =?us-ascii?Q?kbqKjcg1ZkOENilXzkSaXHvegqWh2xGEinigk7tI9iaMOYFiNC82MPTyGQp1?=
 =?us-ascii?Q?ejFwJYaRZjy4bKw2iPpCpWYwLt1oM3Vgboq6MmtioHkelUqwoJJ3k3XUlndK?=
 =?us-ascii?Q?zcRfBC/AEg/Qfm0P70tkTq9CgTaGeDoUfVzMcAwgvN1fq/uwG7uurJ5o7W8e?=
 =?us-ascii?Q?7I3UHLxNfA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae81496-0311-42f1-57ca-08da10ff182b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 21:08:23.3920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsE4iJxZ9/BFMz7+p54ynszr+7i7myw3Un6XyqS+fDdEheFwZWe4kbZN4WCqK6mel0v0Vab4K0Ni5RT17Qt4Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3288
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following change for Hexagon: it contains a maintainer emai=
l address update.

Thanks,
-Brian

=3D=3D=3D

The following changes since commit 7203062171db6669f746d14148c4af76af619e74=
:

  Merge tag 'tty-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git=
/gregkh/tty (2022-03-28 13:00:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcain/linux tags/hexagon-5.=
18-0

for you to fetch changes up to b0cf9b4b26e697886bf0986579953c16cf92d3d2:

  MAINTAINERS: update hexagon maintainer email, tree (2022-03-28 13:51:54 -=
0700)

----------------------------------------------------------------
Maintainer email update

----------------------------------------------------------------
Brian Cain (1):
      MAINTAINERS: update hexagon maintainer email, tree

MAINTAINERS | 3 ++-
1 file changed, 2 insertions(+), 1 deletion(-)

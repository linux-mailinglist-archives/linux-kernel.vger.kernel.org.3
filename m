Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B2E59B8B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 07:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiHVFVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 01:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiHVFVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 01:21:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CE625596
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661145689; x=1692681689;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BZ0X9clnZn3jI25jp9U8d9MVIXR3u/6Mnrj6UevMdy0=;
  b=Pxc/SYGAjqHGtElHjaNaldj64/Kr/GgK6CYBNbg5X0UweV074MXSIS1Z
   e2C8Z7qvVdDXksN3krkmVQfE/D5fe1afqHjCQVVgXAPQ7zDvc08zDO+fu
   NEhaSCG/rDDT+KRj5+WR3LlDy8T/8ZYucxIJJA/kenpgrOgpg5wyXRDtD
   0G73ORo+ymOoEskxiI0Wb8iFEvYwy7MPUEaw5/hE+Y/vYE7ToESJq1LK9
   sLmHQP7Xk60XVWXCz2MDnRj9CH+x2X5pXts3yb84FSYp4SQuLjdjBGHAS
   pXwx1GdDGp3zMSESKT+tKKzYhKtv2RctT8DY1FP6Mt7oU6YEC8nGfNNoF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="357305302"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="357305302"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 22:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="698152407"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Aug 2022 22:21:28 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 21 Aug 2022 22:21:28 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 21 Aug 2022 22:21:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 21 Aug 2022 22:21:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 21 Aug 2022 22:21:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frTU/z17yj6XSGvmcHpSqY95Hpnxuea/VM9vH2nbJ5BF5NRF/3xGQ+s6GkBufWBsDUPPlbKlD4F9+rbOfqH3AtYpe5S+7W6RBkDGGfURhUoC3JAfNIMqOKCdV9oq+7NHtrA3Jvq4psHyGO2YJHFqmb5uRXZV7Kucuu/f3+bV13VzoPl6/B0uJrD/gnTQA1zxqxMdnOn5RfjocpQJbAsMnFLcMtVNgMeTY944NrsThFY0Lf1WUPe6bxreQD3UwhRrh2HjgrfsFB5n+cKHdwDtzNM1vWGCSUgv659cBvl9JZUbRmjx5wrfKuBpm+qN4SB1owfGYlq9ZAB9ax8+xtEMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok8e6YsqIeJjasR0ierIFeaEfQ125trThdIhKDedBA8=;
 b=O+O+EToetBlVSsLl5DhwN8wI80n8pDzDL/Gc6JjrebNz+c+NI8CFmr4saUBDZ3U9QCoHl5CWUBSjHFexLHUmWg/w+81ZSBN2n2WUqd4TFpaTgzu+8E2SoebDKn3qIM3tpjx1FvbrEGgESpwsWEI5XsSQ9+Hw6tPHxSXlkyV/KU4CU4vP6qGGgTSXaSi5rPKjqLcpDOrgrNoQHH3bYDz/gG0l9TwKcifQrknrnysZVOTCq35xDoAPdDmOIBywrYDzM20l81wtHmFRX/8J1/Dw5kDe18/+eHRLgcHH/2juBgvkDsWyV4MAbiFrAanw6pHOSXiCgxPdimmQTZvrz5KwpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5310.namprd11.prod.outlook.com (2603:10b6:5:391::19)
 by BN6PR11MB1636.namprd11.prod.outlook.com (2603:10b6:405:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Mon, 22 Aug
 2022 05:21:25 +0000
Received: from DM4PR11MB5310.namprd11.prod.outlook.com
 ([fe80::50fb:ef2b:38da:6049]) by DM4PR11MB5310.namprd11.prod.outlook.com
 ([fe80::50fb:ef2b:38da:6049%5]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 05:21:25 +0000
From:   "Zhang, Weihong" <weihong.zhang@intel.com>
To:     "Hu, Robert" <robert.hu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Weihong" <weihong.zhang@linux.intel.com>
Subject: RE: [PATCHv6 08/11] selftests/x86/lam: Add malloc and tag-bits test
 cases for linear-address masking
Thread-Topic: [PATCHv6 08/11] selftests/x86/lam: Add malloc and tag-bits test
 cases for linear-address masking
Thread-Index: AQHYsF2hUCo5VsxKwkKjc98r/prWo621tRyAgAFbJrA=
Date:   Mon, 22 Aug 2022 05:21:24 +0000
Message-ID: <DM4PR11MB5310FC7C28756D79BDB4E9E9EE719@DM4PR11MB5310.namprd11.prod.outlook.com>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
 <20220815041803.17954-9-kirill.shutemov@linux.intel.com>
 <CY5PR11MB618704AA299ED39704B9BD14E06C9@CY5PR11MB6187.namprd11.prod.outlook.com>
In-Reply-To: <CY5PR11MB618704AA299ED39704B9BD14E06C9@CY5PR11MB6187.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f3f2090-5337-47c3-12d9-08da83fe286d
x-ms-traffictypediagnostic: BN6PR11MB1636:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SERs/ojweCFWwT7O+fJBVO3Qc/pn/1WKzfq8WjTGdq2IiVsW6axF8m20hgnlGABVwgxu3mmWdurArT/gMeb6rT0TYIwG84S2hI7u+i7GhbGpTRyDS2/99mjB3knlStSN3VoF8qvMQCzVPWoFxMRLxeu5RJSbQ4WuzSLo1otru+8tYSNyi6X7lXDNgOpyqISD8lptI5pWcSvbwEpWvVFutM6aB6vNiXXkpJGlW8mJv+SG96qBFOajbxfOXAeyJHyKfSPdhOHgtiAeOk/SdmsApeQ7zKFrYf+FqyI9h9+AWKYLo0kooejxHxcNTLu54ETC7aLLt8xml8smNvverBvRD1Bsvlsz4PsfBG2xA6RoEDsR5uGbW6RsKh3OPn5yrMSv/JuM7Hyk7+mseS1ZMn+d/79esbznceHVdeOuxQcnrEfyxXr2CDUOwII3NuvuqHR/UZYITzk6mmX5atECrPs8wlv1eYs8ajYvkD8xCYWE6uVXkK9lmEJYWGINtaMmlzzMsvXyHHzt9pWVQsu6x3BNboNMAL+3ggbze14d9Ab4LSDWptIOtFdNVgJhQ/5hiV8KYq3XOWuDplzb9f8pqvQRZCKpiwKRdURJAo3wnytuJ3Ih61K5giEre/7azrTttEpbDMETzqmrn6OBK1kTyHv5UUJz3ar+t0zvAbIJi0kIvWFSX/9/Ii7EAr0hjiaIFBtEZnXmg6lSfBOywZGYvcjvG2d2LBO5EbkaY8cCjENROnZUf2g7Y8JIkkMciLM9vv0Fcdq1yiSjIKVSiM8QOXPXng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5310.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(39860400002)(366004)(396003)(346002)(7416002)(52536014)(86362001)(30864003)(55016003)(41300700001)(8676002)(316002)(66446008)(66556008)(4326008)(66946007)(64756008)(76116006)(66476007)(7696005)(2906002)(54906003)(33656002)(110136005)(6506007)(8936002)(478600001)(5660300002)(53546011)(9686003)(71200400001)(26005)(186003)(38100700002)(122000001)(38070700005)(83380400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nlhmDnA8vPyv+DsZkIKbP+o5qy1TMiYPJQYOt7fyML+xD+ncLVZ50Sakwo+W?=
 =?us-ascii?Q?1H1gy8108KHW+Qa4TI/Vm5pISwNFK1VikZsf8UvbJoayqMyPe3Pav6wHuCD2?=
 =?us-ascii?Q?B23A/gpdzUQ61G+wfY0Kt1lqWFB8UwrSPxrYc07A7GZXIPcJ5zJ4YlWt9wTY?=
 =?us-ascii?Q?6pqqrM7bYAOBCfSZt2MV+6CswEQ/29+y2IOTozdQ+JvxkjzVZNaqSuCr0iXG?=
 =?us-ascii?Q?w1Q73kFedCWj6Ia0BISf6vO+/6fevUYDU0xGHtexgpn1IqEOuwN1XRk++y8V?=
 =?us-ascii?Q?9dKV8gRbWuGZ/zQKlqHo+fPc2J3lQKcQir8QrcB8wL/8908jC7MmY5oSfiHA?=
 =?us-ascii?Q?1dXj1gjubVNVLPS2Ah5AIBNaK6y1ZdpClCsmLPW2WxGa0xBWrvU1/9Anr7NP?=
 =?us-ascii?Q?VcxNfvdKEi/j8j3aziZOki4fb+y6bSoT2l3EDcV/Vc46yI3JWXZIQ3ZCSHA+?=
 =?us-ascii?Q?3AVZKK6Vn7lg47gO2QJs/eCWMbQVI18ovle7cpanfyPHaAmiFV8JQGtnhwt5?=
 =?us-ascii?Q?TSwhoGBl+DBCurrjar7j4iGhl0Kuj1ZASBJk4nVRSN+o18byMtCsGVbWlYXa?=
 =?us-ascii?Q?vqkfS6DaV6D/pMSpaNT8tKEGY/Bhb7lklr+BRz4yZtg1nxxsyT+C4ICl/sWy?=
 =?us-ascii?Q?z/XtkSJ0bXWn4pro5NNrxBapxAyUsochDuPcHkkg0xmrmMjKtbS9JYzJYe6q?=
 =?us-ascii?Q?lyLt6RvY854jMhU1eOwjJ2IBSywI+4zk1lk1ttYKLudqHegrHUp0RbhlSNFg?=
 =?us-ascii?Q?PYBaISSh0NWIvjmOpYXI+TorFYmgPt4K9qtZrExRVsqY3pAsvm5t78WfVp/m?=
 =?us-ascii?Q?jSXNFnOJJwfskBFPcXJU8x0tfrcYO+R6cYG3X805/cAjStah8XEM9MoqowNT?=
 =?us-ascii?Q?6VrijJn/waHjRn6NZlWAmZsRXeLlk//rZjV5AuY4OBFg3aW+Ak8uhsb2lT8Z?=
 =?us-ascii?Q?1Wvpa8RTp1i9+cAqsmkXrdCe+fa0cL3wRqp5DUlIPrWln9oJ6jLril5gw8t3?=
 =?us-ascii?Q?e2N4OFCHwiZPtq1kM06dU5GD76/zm1/6YS/Jw5gip1rifxkqc/Ip4T3uyi9M?=
 =?us-ascii?Q?0XkSkZnqED3wqJRu/FyJ9qAf+I4eQCDzkRpKs7K/aAGd42EdQ/Fd7CeR6qmf?=
 =?us-ascii?Q?iAbi3UayQjJM8JrvPN3osHu+xvREVGJoffc9bZBcwDZ2vfvoDWdpESd2nv5V?=
 =?us-ascii?Q?wKNV5jHepjNCS8peB5iF4gecOHcrEYPjCCWTKqkJu2HB4h/jvVLUSxuboC1b?=
 =?us-ascii?Q?e7owxE8tyhRvQLRgds/cjsubcUfNmUCYa0ZIBHAn5hyBBAXrm1noYMN+GA2O?=
 =?us-ascii?Q?szNVuvCoiR0O1CmwKMh2OueMX5aqjo5uDqgyVwcjPyN7fs3jc9oF5DJmgyvz?=
 =?us-ascii?Q?16nWj7UwHMC3IpOCEwL4gzrd+9WxiP3XNmjI+3YGOn2OMlDbDM2iWD+8rt7z?=
 =?us-ascii?Q?fJdcARDAw/ssLpbGZqrkzCGQimDjF1qgVVWTqlMvDD62XXbJQ9yvfvxXwJry?=
 =?us-ascii?Q?jsiPVLzj3fUgCEwVhvJq2CV/JDS7S0KupLFAyuCl1Og5zbAdMSVUMHQ9cZDJ?=
 =?us-ascii?Q?3ICWpwiBavZDmPzXqTNKUjz8W231mE3XRQ7TF8En?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5310.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3f2090-5337-47c3-12d9-08da83fe286d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 05:21:24.9294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/LnizhldoAYuD6Oil2Z2SWG66+jKfBUOE45fsMEOfBUkEwOsB6fyceu1WADficIvFbruPLyp7+ZN0Rx6v+d8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1636
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hu, Robert <robert.hu@intel.com>
> Sent: Friday, August 19, 2022 1:17 PM
> To: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>; Dave Hansen
> <dave.hansen@linux.intel.com>; Lutomirski, Andy <luto@kernel.org>; Peter
> Zijlstra <peterz@infradead.org>
> Cc: x86@kernel.org; Kostya Serebryany <kcc@google.com>; Andrey Ryabinin
> <ryabinin.a.a@gmail.com>; Andrey Konovalov <andreyknvl@gmail.com>;
> Alexander Potapenko <glider@google.com>; Taras Madan
> <tarasmadan@google.com>; Dmitry Vyukov <dvyukov@google.com>; H . J .
> Lu <hjl.tools@gmail.com>; Andi Kleen <ak@linux.intel.com>; Edgecombe,
> Rick P <rick.p.edgecombe@intel.com>; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org; Zhang, Weihong <weihong.zhang@intel.com>
> Subject: RE: [PATCHv6 08/11] selftests/x86/lam: Add malloc and tag-bits t=
est
> cases for linear-address masking
>=20
> > -----Original Message-----
> > From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Sent: Monday, August 15, 2022 12:18
> > To: Dave Hansen <dave.hansen@linux.intel.com>; Lutomirski, Andy
> > <luto@kernel.org>; Peter Zijlstra <peterz@infradead.org>
> > Cc: x86@kernel.org; Kostya Serebryany <kcc@google.com>; Andrey
> > Ryabinin <ryabinin.a.a@gmail.com>; Andrey Konovalov
> > <andreyknvl@gmail.com>; Alexander Potapenko <glider@google.com>;
> Taras
> > Madan <tarasmadan@google.com>; Dmitry Vyukov
> <dvyukov@google.com>; H .
> > J . Lu <hjl.tools@gmail.com>; Andi Kleen <ak@linux.intel.com>;
> > Edgecombe, Rick P <rick.p.edgecombe@intel.com>; linux-mm@kvack.org;
> > linux- kernel@vger.kernel.org; Zhang, Weihong
> <weihong.zhang@intel.com>; Kirill A .
> > Shutemov <kirill.shutemov@linux.intel.com>
> > Subject: [PATCHv6 08/11] selftests/x86/lam: Add malloc and tag-bits
> > test cases for linear-address masking
> >
> > From: Weihong Zhang <weihong.zhang@intel.com>
> >
> > LAM is supported only in 64-bit mode and applies only addresses used
> > for data accesses. In 64-bit mode, linear address have 64 bits. LAM is
> > applied to 64-bit linear address and allow software to use high bits fo=
r
> metadata.
> > LAM supports configurations that differ regarding which pointer bits
> > are masked and can be used for metadata.
> >
> > LAM includes following mode:
> >
> >  - LAM_U57, pointer bits in positions 62:57 are masked (LAM width 6),
> >    allows bits 62:57 of a user pointer to be used as metadata.
> >
> > There are two arch_prctls:
> > ARCH_ENABLE_TAGGED_ADDR: enable LAM mode, mask high bits of a
> user
> > pointer.
> > ARCH_GET_UNTAG_MASK: get current untagged mask.
> > ARCH_GET_MAX_TAG_BITS: the maximum tag bits user can request. zero
> if
> > LAM is not supported.
> >
> > The LAM mode is for pre-process, a process has only one chance to set
> > LAM mode.
> > But there is no API to disable LAM mode. So all of test cases are run
> > under child process.
> >
> > Functions of this test:
> >
> > MALLOC
> >
> >  - LAM_U57 masks bits 57:62 of a user pointer. Process on user space
> >    can dereference such pointers.
> >
> >  - Disable LAM, dereference a pointer with metadata above 48 bit or 57 =
bit
> >    lead to trigger SIGSEGV.
> >
> > TAG_BITS
> >
> >  - Max tag bits of LAM_U57 is 6.
> >
> > Signed-off-by: Weihong Zhang <weihong.zhang@intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  tools/testing/selftests/x86/Makefile |   2 +-
> >  tools/testing/selftests/x86/lam.c    | 317
> +++++++++++++++++++++++++++
> >  2 files changed, 318 insertions(+), 1 deletion(-)  create mode 100644
> > tools/testing/selftests/x86/lam.c
> >
> > diff --git a/tools/testing/selftests/x86/Makefile
> > b/tools/testing/selftests/x86/Makefile
> > index 0388c4d60af0..c1a16a9d4f2f 100644
> > --- a/tools/testing/selftests/x86/Makefile
> > +++ b/tools/testing/selftests/x86/Makefile
> > @@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY :=3D entry_from_vm86
> > test_syscall_vdso unwind_vdso \
> >  			test_FCMOV test_FCOMI test_FISTTP \
> >  			vdso_restorer
> >  TARGETS_C_64BIT_ONLY :=3D fsgsbase sysret_rip syscall_numbering \
> > -			corrupt_xstate_header amx
> > +			corrupt_xstate_header amx lam
> >  # Some selftests require 32bit support enabled also on 64bit systems
> > TARGETS_C_32BIT_NEEDED :=3D ldt_gdt ptrace_syscall
> >
> > diff --git a/tools/testing/selftests/x86/lam.c
> > b/tools/testing/selftests/x86/lam.c
> > new file mode 100644
> > index 000000000000..4c6c6dbf7db6
> > --- /dev/null
> > +++ b/tools/testing/selftests/x86/lam.c
> > @@ -0,0 +1,317 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/syscall.h>
> > +#include <time.h>
> > +#include <signal.h>
> > +#include <setjmp.h>
> > +#include <sys/mman.h>
> > +#include <sys/wait.h>
> > +#include <inttypes.h>
> > +
> > +#include "../kselftest.h"
> > +
> > +#ifndef __x86_64__
> > +# error This test is 64-bit only
> > +#endif
> > +
> > +/* LAM modes, these definitions were copied from kernel code */
> > +#define LAM_NONE                0
> > +#define LAM_U57_BITS            6
> > +/* arch prctl for LAM */
> > +#define ARCH_GET_UNTAG_MASK     0x4001
> > +#define ARCH_ENABLE_TAGGED_ADDR 0x4002
> > +#define ARCH_GET_MAX_TAG_BITS   0x4003
> > +
> > +/* Specified test function bits */
> > +#define FUNC_MALLOC             0x1
> > +#define FUNC_BITS               0x2
> > +
> > +#define TEST_MASK               0x3
> > +
> > +#define MALLOC_LEN              32
> > +
> > +struct testcases {
> > +	unsigned int later;
> > +	int expected; /* 2: SIGSEGV Error; 1: other errors */
> > +	unsigned long lam;
> > +	uint64_t addr;
> > +	int (*test_func)(struct testcases *test);
> > +	const char *msg;
> > +};
> > +
> > +int tests_cnt;
> > +jmp_buf segv_env;
> > +
> > +static void segv_handler(int sig)
> > +{
> > +	ksft_print_msg("Get segmentation fault(%d).", sig);
> > +	siglongjmp(segv_env, 1);
> > +}
> > +
> > +static inline int cpu_has_lam(void)
> > +{
> > +	unsigned int cpuinfo[4];
> > +
> > +	__cpuid_count(0x7, 1, cpuinfo[0], cpuinfo[1], cpuinfo[2],
> > +cpuinfo[3]);
> > +
> > +	return (cpuinfo[0] & (1 << 26));
> > +}
> > +
> > +/*
> > + * Set tagged address and read back untag mask.
> > + * check if the untagged mask is expected.
> > + */
> > +static int set_lam(unsigned long lam) {
> > +	int ret =3D 0;
> > +	uint64_t ptr =3D 0;
> > +
> > +	if (lam !=3D LAM_U57_BITS && lam !=3D LAM_NONE)
> > +		return -1;
> > +
> > +	/* Skip check return */
> > +	syscall(SYS_arch_prctl, ARCH_ENABLE_TAGGED_ADDR, lam);
> > +
> > +	/* Get untagged mask */
> > +	syscall(SYS_arch_prctl, ARCH_GET_UNTAG_MASK, &ptr);
> > +
> > +	/* Check mask returned is expected */
> > +	if (lam =3D=3D LAM_U57_BITS)
> > +		ret =3D (ptr !=3D ~(0x3fULL << 57));
>=20
> [Hu, Robert]
> Any special reason not "bool ret"?
>=20
The code didn't involve the type: bool.
error: unknown type name 'bool'

> > +	else if (lam =3D=3D LAM_NONE)
> > +		ret =3D (ptr !=3D -1ULL);
> > +
> > +	return ret;
> > +}
> > +
> > +static unsigned long get_default_tag_bits(void) {
> > +	pid_t pid;
> > +	int lam =3D LAM_NONE;
> > +	int ret =3D 0;
> > +
> > +	pid =3D fork();
> > +	if (pid < 0) {
> > +		perror("Fork failed.");
> > +		ret =3D 1;
> [Hu, Robert]
> In this fault case, at last you "return lam", which inited as 0, not your
> intended "ret".
>=20
Yes, "ret" in here is  redundant, will be optimized.

> > +	} else if (pid =3D=3D 0) {
> > +		/* Set LAM mode in parent process */
> [Hu, Robert]=09
> pid =3D=3D 0 is child process?
>=20
> > +		if (set_lam(LAM_U57_BITS) =3D=3D 0)
> > +			lam =3D LAM_U57_BITS;
> > +		else
> > +			lam =3D LAM_NONE;
> > +		exit(lam);
> > +	} else {
> > +		wait(&ret);
> > +		lam =3D WEXITSTATUS(ret);
> > +	}
> > +
> > +	return lam;
> > +}
> > +
> > +/* According to LAM mode, set metadata in high bits */ static
> > +uint64_t get_metadata(uint64_t src, unsigned long lam) {
> [Hu, Robert]
> This function looks like not "get metadata", but "embed metadata" to
> canonical address.
> Naming looks confusing. Perhaps embed_metadata()?
>=20
The name does not express rightly the purpose of this function.=20
Will rename the function.

> > +	uint64_t metadata;
> > +
> > +	srand(time(NULL));
> > +	/* Get a random value as metadata */
> > +	metadata =3D rand();
> > +
> > +	switch (lam) {
> > +	case LAM_U57_BITS: /* Set metadata in bits 62:57 */
> > +		metadata =3D (src & ~(0x3fULL << 57)) | ((metadata & 0x3f) <<
> [Hu, Robert]
> Looks like "0x3fULL << 57" is frequently used across LAM selftests, why n=
ot
> name a macro for "0x3fULL << 57"?
>=20
Add a macro for (0x3fULL << 57) and (0x7fffULL << 48)?.

> > 57);
> > +		break;
> > +	default:
> > +		metadata =3D src;
> > +		break;
> > +	}
> > +
> > +	return metadata;
> > +}
> > +
> > +/*
> > + * Set metadata in user pointer, compare new pointer with original
> pointer.
> > + * both pointers should point to the same address.
> > + */
> > +static int handle_lam_test(void *src, unsigned int lam) {
> > +	char *ptr;
> > +
> > +	strcpy((char *)src, "USER POINTER");
> > +
> > +	ptr =3D (char *)get_metadata((uint64_t)src, lam);
> > +	if (src =3D=3D ptr)
> > +		return 0;
> > +
> > +	/* Copy a string into the pointer with metadata */
> > +	strcpy((char *)ptr, "METADATA POINTER");
> > +
> > +	return (!!strcmp((char *)src, (char *)ptr)); }
> [Hu, Robert]
> Why "!!" here? now that function return type is int and strcmp() returns =
int.
>=20
The " handle_lam_test" only returns 0 and 1. "!!" used to convert return of=
 strcmp to 0 or 1.
> > +
> > +
> > +int handle_max_bits(struct testcases *test) {
> > +	unsigned long exp_bits =3D get_default_tag_bits();
> > +	unsigned long bits =3D 0;
> > +
> > +	if (exp_bits !=3D LAM_NONE)
> > +		exp_bits =3D LAM_U57_BITS;
> > +
> > +	/* Get LAM max tag bits */
> > +	if (syscall(SYS_arch_prctl, ARCH_GET_MAX_TAG_BITS, &bits) =3D=3D -1)
> > +		return 1;
> > +
> > +	return (exp_bits !=3D bits);
> > +}
> > +
> > +/*
> > + * Test lam feature through dereference pointer get from malloc.
> > + * @return 0: Pass test. 1: Get failure during test 2: Get SIGSEGV
> > +*/ static int handle_malloc(struct testcases *test) {
> > +	char *ptr =3D NULL;
> > +	int ret =3D 0;
> > +
> > +	if (test->later =3D=3D 0 && test->lam !=3D 0)
> > +		if (set_lam(test->lam) =3D=3D -1)
> > +			return 1;
> > +
> > +	ptr =3D (char *)malloc(MALLOC_LEN);
> > +	if (ptr =3D=3D NULL) {
> > +		perror("malloc() failure\n");
> > +		return 1;
> > +	}
> > +
> > +	/* Set signal handler */
> > +	if (sigsetjmp(segv_env, 1) =3D=3D 0) {
> > +		signal(SIGSEGV, segv_handler);
> > +		ret =3D handle_lam_test(ptr, test->lam);
> > +	} else {
> > +		ret =3D 2;
> > +	}
> > +
> > +	if (test->later !=3D 0 && test->lam !=3D 0)
> > +		if (set_lam(test->lam) =3D=3D -1 && ret =3D=3D 0)
> > +			ret =3D 1;
> > +
> > +	free(ptr);
> > +
> > +	return ret;
> > +}
> > +
> > +static int fork_test(struct testcases *test) {
> > +	int ret, child_ret;
> > +	pid_t pid;
> > +
> > +	pid =3D fork();
> > +	if (pid < 0) {
> > +		perror("Fork failed.");
> > +		ret =3D 1;
> > +	} else if (pid =3D=3D 0) {
> > +		ret =3D test->test_func(test);
> > +		exit(ret);
> > +	} else {
> > +		wait(&child_ret);
> > +		ret =3D WEXITSTATUS(child_ret);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void run_test(struct testcases *test, int count) {
> > +	int i, ret =3D 0;
> > +
> > +	for (i =3D 0; i < count; i++) {
> > +		struct testcases *t =3D test + i;
> > +
> > +		/* fork a process to run test case */
> > +		ret =3D fork_test(t);
> > +		if (ret !=3D 0)
> > +			ret =3D (t->expected =3D=3D ret);
> > +		else
> > +			ret =3D !(t->expected);
> > +
> > +		tests_cnt++;
> > +		ksft_test_result(ret, t->msg);
> > +	}
> > +}
> > +
> > +static struct testcases malloc_cases[] =3D {
> > +	{
> > +		.later =3D 0,
> > +		.lam =3D LAM_U57_BITS,
> > +		.test_func =3D handle_malloc,
> > +		.msg =3D "MALLOC: LAM_U57. Dereferencing pointer with
> > metadata\n",
> > +	},
> > +	{
> > +		.later =3D 1,
> > +		.expected =3D 2,
> > +		.lam =3D LAM_U57_BITS,
> > +		.test_func =3D handle_malloc,
> > +		.msg =3D "MALLOC:[Negtive] Disable LAM. Dereferencing
> pointer
> > with metadata.\n",
> > +	},
> > +};
> > +
> > +
> > +static struct testcases bits_cases[] =3D {
> > +	{
> > +		.test_func =3D handle_max_bits,
> > +		.msg =3D "BITS: Check default tag bits\n",
> > +	},
> > +};
> > +
> > +static void cmd_help(void)
> > +{
> > +	printf("usage: lam [-h] [-t test list]\n");
> > +	printf("\t-t test list: run tests specified in the test list,
> > +default:0x%x\n",
> > TEST_MASK);
> > +	printf("\t\t0x1:malloc; 0x2:max_bits;\n");
> > +	printf("\t-h: help\n");
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int c =3D 0;
> > +	unsigned int tests =3D TEST_MASK;
> > +
> > +	tests_cnt =3D 0;
> > +
> > +	if (!cpu_has_lam()) {
> > +		ksft_print_msg("Unsupported LAM feature!\n");
> > +		return -1;
> > +	}
> > +
> > +	while ((c =3D getopt(argc, argv, "ht:")) !=3D -1) {
> > +		switch (c) {
> > +		case 't':
> > +			tests =3D strtoul(optarg, NULL, 16);
> > +			if (!(tests & TEST_MASK)) {
> > +				ksft_print_msg("Invalid argument!\n");
> > +				return -1;
> > +			}
> > +			break;
> > +		case 'h':
> > +			cmd_help();
> > +			return 0;
> > +		default:
> > +			ksft_print_msg("Invalid argument\n");
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	if (tests & FUNC_MALLOC)
> > +		run_test(malloc_cases, ARRAY_SIZE(malloc_cases));
> > +
> > +	if (tests & FUNC_BITS)
> > +		run_test(bits_cases, ARRAY_SIZE(bits_cases));
> > +
> > +	ksft_set_plan(tests_cnt);
> > +
> > +	return ksft_exit_pass();
> > +}
> > --
> > 2.35.1


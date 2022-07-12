Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525BB571290
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiGLGyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiGLGyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:54:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EE117AA2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657608852; x=1689144852;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ooRYkmDAxM2WDU4mkZ7z09+en8RR8ohkrwUwsMYSuqc=;
  b=ZEDOwnRwnmQBfSAchx0hpfJPpc1RHweg+whGaUkvEZ85YIfibkZlMxN5
   cH9jiwkEB+E4FUoeVOM6uoOQbLiWbZIIbNDS+FZejkg6ScCguk+V0a85q
   0LU7fdsdjU1erj6Y3w4v8VCkMemE3OoPag/wDf9Ke9Uaw1bQD5x2+qlD+
   oA2GvXdulJUyisLt8quReI8YbkANWeYGhk46DB2Ce8t+c6xo5gs3tnRpD
   4jBKrD21hOwgbt1F177GmoiTx84pwBIipGj19ICrQ8cBMcHswvt9XYS2t
   WzI1WrTI4ZciwaNaM0DdTOPvv4Od8h6hpQUg4GgLfirZuwsMCpF2flfdl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="284881690"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="284881690"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 23:54:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="922086279"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2022 23:54:01 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 23:53:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Jul 2022 23:53:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Jul 2022 23:53:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F94JRA96VtPi5AND5LGcGGsqHSaDFWL+xJqnS5O/86m4xcozHD6A9GCTSeeCsJe1yBjxLQuHOz16wzfDxaSWpleXyYCnhh5be2ocdl96baifiOtAvdk71E4v2Ikfm11bFZDFaWU3omO3BPDy+lDPG8lMknp4Ym0cA2i0fk14ldj+0J8o1QDgZ4RKv/twji52GJi+ncI6QkDTva/GLqxLqBbP9OhhPGZnut+waoSq/9GgOf8AMs3KI9hxngkKZvbKo5WE4TubvQ0gse2aN9X+5cu0o/i8guGY/hytJv6AqrV94vXk5VoaZuzgfzLlvi3Kv/VI475qb6z85E9BEvmh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnMpWmokYMXenfCqWRLMycwUTp6xmhB5jDEO9JUQFcg=;
 b=IXpDebZZPrBx5h1FoSnIGY1NWcTikTQtC+RlEPRicCpn3bFtbawF0i/ZmdKCCLvc5i55N9tIfBCARx6JVhtP0CD42LmLKRLnNyJVxNUZfgiPY6ylKkIsSZi1BZRr1WtjdR31Qc5tCiKAlNLlCBBTi0LnwSyGjUQQ++xngsnF8KQwOt7ZL8tmbPJjfq7PafwU/TsvztVAZDWre1qniWF8XU0OAd50SuALOQVWLjS61y+zhEF7tYuSjepfX13RhZHQKDu5YKWQE/qY9PBcPb4GE15Mr0RhNk04uE4ikDHxy8G32t9oIHzl8K45ftyx3tEr0925cEO9lvBR1IZMr9iPdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by BN7PR11MB2852.namprd11.prod.outlook.com (2603:10b6:406:a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 06:53:57 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 06:53:57 +0000
Message-ID: <617726d5-d261-adfa-d052-ec02b6e8c0e6@intel.com>
Date:   Tue, 12 Jul 2022 14:53:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-for-viro 5/8]
 fs/cifs/cifssmb.c: cifsfs.h is included more than once.
References: <202207100924.Zh7upmAa-lkp@intel.com>
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
CC:     <kbuild-all@lists.01.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202207100924.Zh7upmAa-lkp@intel.com>
X-Forwarded-Message-Id: <202207100924.Zh7upmAa-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0083.apcprd02.prod.outlook.com
 (2603:1096:4:90::23) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef2daef-2213-411d-281a-08da63d34ad3
X-MS-TrafficTypeDiagnostic: BN7PR11MB2852:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vQDPwZPx5Jt0PYsfjdkqKsZVG0LSTkpJNRBuiDLMpqs8DUpq3y8tl/sfpPN0jqsXL/fX4uLs8qu5EwlHsFoXxUgIsRW+sBH//R+sSaZOQSdhk0q5FGGpkRCtNOGPPh5ynhh2utFI/uG6eTbrQj4wSia6e77jvAFUkhb2f7H6JwvLigH1iJ245xpTgQSI5KMnuddiSBbFHu9k+qeL1GN30SHKNDT0b7tWCqW2iTXpoFkwS1rWrnzRNaqPyRTUVy6XTJPzH/rZRZF70QICrSZjt7C5JaiteTn8Xf817LAGmP5/aWBw2KLkOsEb3FD/+ytJHf62PYxbm2za3TzY8bfIRKILdkkb9DPPy8uR4jC1Opie077m3EwJZ6ZT1j0RUEJFVY/aBOhjgNYgaID2iMnSqKw0T0lPBqfgk+mGG7kKKLcmd1bS+KIiYcq7cV+aHZ/vdAhBHy82yIzkp+l7pbE7oejNChFZOn/AByV/ciJuPOwI6QL2RrpH4ZAMTTuMdOrxLP2D1HaPKoXdQgcTxgVCeMeZXJVRvr55gMsspt363ax1TSb37PBghOfJeIfWJ1p5ieAVsO+txlHJKyM01E+uNJIffn8xGSy71DMxZKW1hLyhlDImPL/cm0DV8zdZYGj4ogPRWbUXZJh59shmwbyykkeTIIdU3ivzLy5xCP5+cJf9Z7/a4pRBgNwucA/AAsi7oywzmqQG6ZT9RsBqV4RL5qfD8VhAz0d4igC6K95Ucbtf/7vXW9wEqjvwf4KtCZitrFWdRUWz3TF6mCSMBXbzkgDaK0S7fcg+iipC2kmdGyZiN1oGK4uFmV8/dy7Mc6Wi1paWwsCfzNMEZubHR2kMKHs1B4rQwPnNUWY/MngBnQxixoq7hj0saw+i1FmKAtT2z3O1Szb3sEG/OP2H6jK+joSVX4e7Y4giUcA23OaUEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(136003)(366004)(376002)(39860400002)(82960400001)(86362001)(31696002)(66946007)(4326008)(8676002)(66476007)(54906003)(316002)(38100700002)(6916009)(66556008)(2616005)(478600001)(5660300002)(186003)(8936002)(41300700001)(2906002)(83380400001)(6486002)(26005)(6512007)(966005)(6506007)(31686004)(6666004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blZTNjRzRzcvZldxQ0lSY0F0cFFqWElnVUN6Qmd3SGdmS1FyeWhaS0tDd3ov?=
 =?utf-8?B?NndMak1yUytYK055YTRXRGMxeUFac0ZSeWI0dkdOczVXVlV1eExWejZzbG5G?=
 =?utf-8?B?cGJ4ZUpDSnU2cWg0cG0rWllHYU1rakFkdUFiQzZKbUl5NlpYWlVTZmJuNERH?=
 =?utf-8?B?Qk5wbFhBZWdha0NwaEYxWmdSaTIwemtmVFlrdWJleUR1b1B0WFFyZ3RTUVhB?=
 =?utf-8?B?Nm5GYXlhSjdjTFhNdCtvS0R0eFgrSUNDS0c2N2l3amRyclZNRjh3eE80K01Q?=
 =?utf-8?B?KzRpK2FQbDlYdlNMeWpVS0ZQbWR3ZEtrSmpMNmJScWZ6dFh3Y3V3ZmpadzFQ?=
 =?utf-8?B?RUJld0d1TDZQUjhaWHhscUtpTDYwOFlobCtrV0FBZzN4dk02U01CMFgzWFFL?=
 =?utf-8?B?VWthbHhUd3pZM1FQN2VtWEFkcEZkL2EyS2hMVWk0ME8xTWlGaGRzVTlzS0NV?=
 =?utf-8?B?YU1oNG9PMXZzcW95RzhaMVpWSVdxblYvU3dMZWVYOWwxWExDcis2cGdlTCto?=
 =?utf-8?B?UFNQOFNWTzFjUnZKMmVBdWdqVVFKalFLbk53Y0hCdXE0QlpBNVVvSGJmSHRX?=
 =?utf-8?B?My9odlFoajcrL0ptYzB6dEJxVmhOYjNSRHE0UG5NKzM0QkZTWjhFbERmQlp4?=
 =?utf-8?B?OTBBZGtSWGVDUU95bFRvV3B0dmhhbE9uWHYzNXByWkwzNCs2NXVLRTBoU3NQ?=
 =?utf-8?B?R05WRGwyR3lCWVVPdXorS3FlU1lqN09rYnhnN0RESVowaHNnaERkem0vTytv?=
 =?utf-8?B?WUVTR3FFeXFnZjFSVVA4aVJLYVhMeXp5d0VaMWlmSE9WWi9JNjRGSDJsV1Mz?=
 =?utf-8?B?NU1kbnNHUmhCU2tabnMzTDhLV1drS3hpeDBEWDZJMXdtODhVeTlKc2g0emdQ?=
 =?utf-8?B?VDRZRmVFVDFKemhTUnExYm5QaERGenpvRVI0aCtncUZaVmFKallMcGRmWlhO?=
 =?utf-8?B?dDZDZDVNUldNeHRxRXVsMmJXS3FvdkZ5NTZzeHQwZFFKL3hoNDZ2c00yOGxG?=
 =?utf-8?B?VXhQMlBPZjdZUUZFY3dNajN2Y1NaNUFtYmczTjA5RnR5WWNNN0tHRERIcE9u?=
 =?utf-8?B?THNUZHN2bktWVEs5UmdudTlCYWhtUVJNZ3paTmw4T1E0cGtBNkxZNFE1UnZC?=
 =?utf-8?B?VDM4aTBRc2JhSUF3R1h4S3RmY08rV1l0YUl3QUNLbnFlazdFdnVMOFdsK1hU?=
 =?utf-8?B?ZzJNeUFsejZrWlNvU1d6OG4zNVc0eUtEVXVBSlhjT2Q0R1hRMUJYZXFHb3Rh?=
 =?utf-8?B?TGs3R2tKYUNVckczM2RWc3JnUzZINWZZUXlDR0hqci83VEkxNlJCV1ViZFdC?=
 =?utf-8?B?T29MU3A5Rm1Jc2Z5TEt5YXRUZ2FxU2h2MXZDQUVFc0UyU1ZDdVRGSkxmY1Yz?=
 =?utf-8?B?QWR4eEVGQ1ZNZHFMOE5tbzA0SlhXWDJTcE9BbDNRVUhUTExVZjZaQm5kM3JK?=
 =?utf-8?B?d1puRmtMWEVBK09iVUY1ajh0cFdHVnB2bm03RldIeWxqdzRCS1gzbzdZcjcr?=
 =?utf-8?B?djUvdDluTUVHL3ZSUVlPMWw1ZGZNMzlYRzJRVmpsaWVESldSYTAzdjVSNTkr?=
 =?utf-8?B?OThWbVZjZkZFdmpKd2pwS09oTEZXTk5ZVVZobzhFYTd3UmZRejJxZFg1UW9J?=
 =?utf-8?B?M1Z0WStoeDRRUENITlFjT0pFOUpkVnFlT2c3MGFVcE80eDVZMDVwc1AvME1l?=
 =?utf-8?B?RFBCcWM1djdWaDlMbG9TS2RIOVpxSkFuc1k4OVlJdHNKQ3MvS2wybk44L1Fr?=
 =?utf-8?B?VzYyQVM0eXM3STBKZzJ0RDVEY3lHMm5PTldOeDBFN283MUJpSGpHVzhhSFBV?=
 =?utf-8?B?R2V0RXd5L0FWTWU5NEJ2R1hyZ3NJd0NDSGhJZjArTFNITU5TRTY5QmJaMVpY?=
 =?utf-8?B?QTF6R0dSbjduTVcvZDFJM2FsTFhXbFlkelpEYmgxMEl6YVBLemRuT0pPeTRh?=
 =?utf-8?B?UC95SjZVSFRNMnVaR0JsTGIxQkd6SVphSklLeFByamlYeDVoUlcvOVpmNDc1?=
 =?utf-8?B?eTBTVSsvR2xJU0NBTE9nVGtxZEVJVHVuZUpuS0tpekZlZmRyYUs5dXJJZDBi?=
 =?utf-8?B?d3B5Zlh2Q1BNWlk4bGg5V2luUUlXbzVTL0IrK2cxQ0Z6MGQyUGZ4M1lPd3pV?=
 =?utf-8?Q?FZs4fx4ULdqdUlZlaEb/3Mqwm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aef2daef-2213-411d-281a-08da63d34ad3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 06:53:57.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFu58rOuBEZ49PAk6h/CEuwLrFDs1p0dhiJXWUPxmWEd0ghQHBd8hd9MWlF+UNLLnU5/qGeF3DtXkzbjLXzkrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2852
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/cifs-for-viro
head:   48e2f381e50cded57926128a7743a21573130f46
commit: d04aeaeed153b194dbc7d67525a59df325f2ce21 [5/8] cifs: Change the I/O paths to use an iterator rather than a page list
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>


includecheck warnings: (new ones prefixed by >>)
 >> fs/cifs/cifssmb.c: cifsfs.h is included more than once.

^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   26) #include "cifspdu.h"
d04aeaeed153b (David Howells           2022-01-24 21:13:24 +0000  @27) #include "cifsfs.h"
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   28) #include "cifsglob.h"
d0d66c443aefa (Shirish Pargaonkar      2007-10-03 18:22:19 +0000   29) #include "cifsacl.h"
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   30) #include "cifsproto.h"
2d2808947f7ea (David Howells           2022-04-06 19:41:28 +0100  @31) #include "cifsfs.h"
^1da177e4c3f4 (Linus Torvalds          2005-04-16 15:20:36 -0700   32) #include "cifs_unicode.h"

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

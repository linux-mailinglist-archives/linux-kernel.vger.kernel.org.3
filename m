Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F0C4FFB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiDMQm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiDMQmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:42:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927AF37A8F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649868033; x=1681404033;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mypMZr1MJCfcTqfwnulMdkK2c/U4gD6NOExS5PjrEGo=;
  b=nNSEyuQr78ACq++etnEkrY1l6X+Qu7kuWO0RDsbtMsXQE3bzSkc2cpaC
   bC+WIe1QJ9xyVOTkdE1L+5JbqWlnB4D17nYTtILIAoSpWWiJ2Hhu/Wi9B
   pNCf3N3Au7eeur6/VW/K7Es6PRMbFQtvQGK8jaGcOT9+puvWxNfNAOoxe
   8WvSfOS6FFdnRlAEbeVc9O3mGtB7P5DzlY+tEOhDwbN1dNFWZOk5wVBNY
   W50LeXKyFgCg36OR+8aXoac1DTeSBL/fkL47w3Q0J+nVrnsdhLcs29X9P
   2D7rnlghYnz246nO0fA3PaA6EKHplooZy7CA3+QDME1/LMN/Ek0pktD/3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="242651250"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="242651250"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 09:40:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="508046217"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2022 09:40:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 09:40:32 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 09:40:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Apr 2022 09:40:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Apr 2022 09:40:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dng89/QZST/TLo0FLd/UWII0afA8s7GFszv/9sK49k8+pFiqGCmlxMnAvZRuthbDi3/0QCnB/FqLYBv+VfvxQWLijfwAmoyfRhB2ipajcnHZ9hVrm93EKRJIKMxNbRaB0SsO525VskZmgtGjYMR1WnZg/sPshakD19b7WhluDpvlzl5Uhj4z3q8Qbrna0pkXlW5tskJOjhdlmlihK5Yjx+vjeoRDMx4izLz1BRG0S1bC0upe6iGzJwGokKqnxlxnkXuBZGHDUdVUqz6GWK/eAK2C/riWx9g/iRNSpD17vx/XTLwegyJozKtw9kZf/VrK0PYymV1k4x3ba5diUD17HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZR2u+hYJW+NBGP6Oca4AwjXL4OH+V6qz6GkbbHQewY=;
 b=b1L18EEsLc5rh8ekzAmkivJi/7m5SbbzoryeRRPiNErPWsCysIFazdxacjOLbVc+HUqwN0PBaAg6aqsxzZdOb+Fhsq5STvf3E6kDktCsEYRj6zPV65CPL8sxoAOCJp6RVIicauqJoGGy0utAivtd/UeAj3nPgSXG5P8Id0qKQzxLorxTQqk2WQQo0iRdqEL9m/tTPvGPdBV/f4n2I64QRlRluL91DfcZv9yjqVMp/Uy5ohvt34xfKUiJN1rX0AuxKBzW/gMhGAIg9OKBJIwLxmvUgfdU0AYFlyDLQtJBciw6P2WpBA8M5J4L/cHAbw2TBmGM4rrs8gQOJGs5Mn90Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3229.namprd11.prod.outlook.com (2603:10b6:805:ba::28)
 by DM6PR11MB4217.namprd11.prod.outlook.com (2603:10b6:5:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Wed, 13 Apr
 2022 16:40:28 +0000
Received: from SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::acf9:f012:22dc:c354]) by SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::acf9:f012:22dc:c354%7]) with mapi id 15.20.5164.019; Wed, 13 Apr 2022
 16:40:28 +0000
Message-ID: <bcdfdf24-bd8c-f487-5a26-88ee0b1bdb43@intel.com>
Date:   Wed, 13 Apr 2022 09:40:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [tnguy-next-queue:dev-queue 235/256]
 drivers/net/ethernet/intel/ice/ice_txrx.c:1971:16: error: redeclaration of
 'protocol' with no linkage
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Joe Damato <jdamato@fastly.com>
CC:     <kbuild-all@lists.01.org>,
        Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <202204140015.MRcE3hbT-lkp@intel.com>
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <202204140015.MRcE3hbT-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::33) To SN6PR11MB3229.namprd11.prod.outlook.com
 (2603:10b6:805:ba::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7910b452-adf3-4641-401d-08da1d6c50ea
X-MS-TrafficTypeDiagnostic: DM6PR11MB4217:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB42178878F0AB5C2FC10103FAC6EC9@DM6PR11MB4217.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZV6OgWMJbaFe+MsnKO3HsugNJYDcxje1NMgGVXwKekiFd3sEyayOGtDX6OlXQ4YyNT/m+zmImvGJoOWWwD7eATZRWZk6gilST9jestr2pNccgTb24YI+x/gLw7devFTLVnYNQRi5S5vVEZK/JczYxf4iQZ69Rv4pvome+tK9ylJnyR2sk159vRMYyWlRZkayQgFwj78NfD+YVGnkbwdCyWMe1V6DLMtRh0zlCw6f6V/SXy07whhYsLMnxgZ32fcBQSsKORJxkawovZqK/7nzJge0eD6WkmkfTyWp5zKTCzmDH4atNnboN3LUsHAhIvR/n721nh9cxbV00EgJDBs0F2nGNrQcwVrAJNLHwCVpgbwlVj3JZ4avdMFbTFj+WAxf/mqfPZXVn+yM0+fKCzyI34krz9EuZX7mrXzPaPOqEJkCyieC6QTh928RzMgBtzQemYsEcz1H5TP4hV2san9fAVpzfO6vS839+udFiDp/l5lSw9aV5FkDpyGeYPK25zCng/+f4ylutax40qH75lG6zl0kNAyuD6iQbbMAEgDlRdYipyCqgNLCTIxZwzLdu2/xUv7A2VksG1+/ua8yH1qsNe8doa/ZEUvl205AgXKbbROXXkMWjYLNanTsCvLM6LXTW78+OwdU4xOqmQCQjZ+mOAwTqhzePPk3pGP3+CcXPUlpxfit4uWXYkVWf9zCxq50CPmaIigjFqayawHG2FUrk6WTIm/yOXPK4fVpDmf4ZP1X641N+CrqnbBMcIeDDnRqDrzGdjRHdj6K8VPxl7u81lW6xghQ7ODqmnjL+4BEJngkaxsDBoR98BNQFGIVygjcpt1DczmswA809eju+qbO5HmagCbjla27nk+M1GnO/vc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3229.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(6512007)(83380400001)(2616005)(31696002)(86362001)(26005)(6506007)(6666004)(53546011)(2906002)(82960400001)(38100700002)(508600001)(966005)(8936002)(6486002)(8676002)(36756003)(316002)(5660300002)(31686004)(186003)(110136005)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWpqZkpaSkRXbmwyd2lST3Z6QWVTajVvSGg3NTJLZTQ3VEJMUEx5eDl5dEd0?=
 =?utf-8?B?WDBISVUxdnN1enJqbThOMktyUzdnT3lmOXU0bUlEMkhYSzA3WWlBMVRkS2tE?=
 =?utf-8?B?QzV3MUF6ZENiT1BwaUh1SlFtbkdQbzdhTkFqa1habWdOSGpCWnBkaXMzdHdu?=
 =?utf-8?B?aEcxQjNJTzN1ekkzK0JUek1rbFFjY3FjN2s5allEUXFVRUVaQmZoQm90RzNM?=
 =?utf-8?B?R0tKaWdNL3dyaVdQNTYyaTh1ckxkK1pQM3MrTUJpajJwSzBDdUorMzdQNURJ?=
 =?utf-8?B?em5lQStRTVFhbmQ5c2todm04djB3ZjZTK1pERGpkWlpDK3lVcVd5Vzd3cVJM?=
 =?utf-8?B?UnZ6dTdlaWpKVmJSWlpaNnVqMzQ5dUFxM3MzcG9jRlJGNGdKcVh3cXhhdVJ5?=
 =?utf-8?B?TzhrUU41cGtxVTFSMDZlRGtnaDcyL2FIKzBsVUFLc3gyQU9PK2x2YnJwWDBr?=
 =?utf-8?B?QkhheTUwUkNrVHpyTUFxaUJ3WEoxUkZsNHJZK1ZKOFpPN0NXNXBXb3NqTTRW?=
 =?utf-8?B?MU43YzNCN25PSFdVTDJyWmVyb2hZZXdsMWFNQ3JoUldsejdFN3ZKeFdOdTFn?=
 =?utf-8?B?Mm1LTzJSMHZoVHNCaWRzZ0Vwa3A3RXdhcFBhZDB1VTBLVWtmWUdQMmhZTEtZ?=
 =?utf-8?B?MnlxYWt2MUc2azhzTm1OMzJIRG9uc2FmOXNDcVQ2bXhaRUF3MldFZlBseldC?=
 =?utf-8?B?RWhDYTMxWnNTWjdBK3JKT0dsSytoZ2RqOGhYeVJWU3A3UUMwRWptQTVlWlhF?=
 =?utf-8?B?OFJaTnYyKzg4eGFPS29tRzNMY1ZtaDZ2TlF3M1ZrZnpEdlNVcml3Mmt1V05O?=
 =?utf-8?B?QytaUXNXR3ZzdWcwQTBTUFhpNmR0MnFFVE5HdE0rbUg4Ry9SR1d1Qk1ZWER6?=
 =?utf-8?B?T3lIZ2I0bFNTczZYS0lrczFXbVozSzBwS1RpWlRQSlpzcFBQcGZMZWhzVmY5?=
 =?utf-8?B?Zms4dEs0SFZSKzgvMjJrZGpaKzdybHU4RzFScUlZcnhCdHA1cjFhdFo3bTkx?=
 =?utf-8?B?ZmdHamlkZ3J0RTkxVzRzY0NhK2kzMkJSeUZyRVZXRzU5K2U2VjhIOE1wTTVL?=
 =?utf-8?B?ME1KaTZTUXlDZ0J5RjlyTUlVSlhySmYxU0RWcXBETGwzcWN6MWovdzdLZzJR?=
 =?utf-8?B?Z3pkV3dOY2lnZ2ROcm9maWkvWDVDRHd0ajNrN3pPY1p3Smt3Wmk4RTdPbEhv?=
 =?utf-8?B?WHU3Q2VTRkxzNVNCT3lHVXlzb1hkTUorellramRiUVhTU0x2dStKdmh2MGtH?=
 =?utf-8?B?QUZvcUFpYkl0b3VseExJMWdDZVpSZUIzV0tKS3Q4ZStZQmloTUcwSkRKOXFC?=
 =?utf-8?B?N1RQdTFOdjhHL3FVS2VRZEczcWl1d0RoTThMMDFVYzBqa3VMY1R4am0yUXF6?=
 =?utf-8?B?Y2JTTzQ5dnNhNHp1bFZiL25PWUZKV3RzN3hYaXZ6WDlWVXlVOGRqbmlHUWdr?=
 =?utf-8?B?cVRUQndsa1NENWlLQWpNRlg0ZGxOZ3JMZitMRjFuWnFzUys3ODBiRUd3QjVR?=
 =?utf-8?B?M2ZCYTU5Qjk1aFRyVG50c3JZRUNZUmRUMVhpT3FmNlozeldyaENLYys3QUdF?=
 =?utf-8?B?dFc3TkVDZk9zQVVyMjQzNmtYU0dKZTMrZDhGRHlsTUNON0tPYldhMXpKRG40?=
 =?utf-8?B?bXl3WjVtMENBcisyUnFNeE9DMnhaVzVCNVpiZmRSSUt2bHEydlJ4dWpkaUZW?=
 =?utf-8?B?MHVBa0IwUjFkTWRyTjF2MVI5WVBveXZOTG51aEovcVdNUWM1bGU4Y0NKTFN1?=
 =?utf-8?B?Wm9hR2dSZFlMeWpFS2NCOUtuazg1QVYwbjdWK25rRjNwUGQ5cFp2VTBIUG91?=
 =?utf-8?B?eGk4MGtxb1Nsa1lsQzZtaTNDZk5Jbm9PU1JxYms0K1VUaUlFclM2NEJ2dGcx?=
 =?utf-8?B?dXZMbFo4dHd0cW93Q29SY0RXbnpYeTRad0p4cFJSYUVUOUlwK2tmeVZscEdv?=
 =?utf-8?B?bS9tVDBkM2J3REw5M294dS9aTit0Z3F4MEh1dGt1bUlmNFVvM2xrVGVQM3JF?=
 =?utf-8?B?SzVCUHdLdk9iSzYwN01VaUh5SS96T3o5R0NGT3pNZHVURmc4RVBSRW9aUUZW?=
 =?utf-8?B?SlR0N3pRTEhzb3dtWHdJbHBKRUtGZC9RSjMzc0RmSGliaDcyeC9jbGJETkFK?=
 =?utf-8?B?WUZaRTBDRDQ4bjQrVVphc3BwQ0kxUGpOWHNDODlSVkNBOXJLNUFXd3FvcDdD?=
 =?utf-8?B?RW1KcXZJRk43M3haUDE5VVpZdlJ5Wm9xZG54OGpVdHBuU2JrUDVad0F6VGh4?=
 =?utf-8?B?SWdJVmZDVVVlbldtcjJ0Zm9wYkxQV0RXSUJDSjd4YW5iVStneFd1ekwrRGd1?=
 =?utf-8?B?RnVWbUJTVTNhZnVxa29JZzFxb09tN1BNQklJc1YyV2VsWmNMUHBoTnF5cGlw?=
 =?utf-8?Q?j/1NVC+57WoxJ0OY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7910b452-adf3-4641-401d-08da1d6c50ea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3229.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 16:40:27.9580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGMppgHYNEaBEHsJ0e65rwowNXT+qlHQi/wvHSqcXVEubgkLm6waGNY2kQQ1Sgp/pLV8dDeEzHdThEPLvgQhgfNd6SZTsT4zadZH1JhpvAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4217
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/13/2022 9:35 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
> head:   faadd15618a12d7b11208f11c54d6ac0f2776486
> commit: 5d4c82c60dd05a844ff582c2c6d4e8c3c3020ebc [235/256] ice: Add mpls+tso support
> config: powerpc-buildonly-randconfig-r003-20220413 (https://download.01.org/0day-ci/archive/20220414/202204140015.MRcE3hbT-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=5d4c82c60dd05a844ff582c2c6d4e8c3c3020ebc
>          git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
>          git fetch --no-tags tnguy-next-queue dev-queue
>          git checkout 5d4c82c60dd05a844ff582c2c6d4e8c3c3020ebc
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/intel/ice/
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     drivers/net/ethernet/intel/ice/ice_txrx.c: In function 'ice_tso':
>>> drivers/net/ethernet/intel/ice/ice_txrx.c:1971:16: error: redeclaration of 'protocol' with no linkage

Hi Joe,

You can ignore this, this was a mistake on my part and I've fixed it.

Thanks,

Tony



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86AA50FFC8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240043AbiDZN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351194AbiDZN6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:58:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EC11EC5B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650981331; x=1682517331;
  h=message-id:date:subject:cc:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=YE173ltdrNKt+ASigTcSZuR+bvKFW86jzUygu6KX5l4=;
  b=YNgRvy6WW3sy4tzVNquA/Ukz6a0uCjIBYG7J3D69bXy5BhhiAD2QWYar
   O06YmML+OUCsNTEyzMoLgkDrV7Aslqo0+16JQoLeDzMGK2ekVrtTZJYEw
   SM8myANK4r1SgpVSaw5u1ppoO1fQqX9zdit18yOm84Fb8MYi6oMDb/+eK
   dzIsDwrIxneeUoWgB/yTMC1essl6Y+u3IEsEOPTxTQOVB495nQE3/8shI
   Q+iVYtX5ZtpwNQ235Ia6HRtEBf3YN6i1RChjdZqmqJKKau2jtJ1irq5ka
   H7bDFaKNj1wP0S3l9qT3VCxSUNf7Yk+KqejJBBQxQpLr07AEYAUdP6TJY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265106906"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="265106906"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 06:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="628536043"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga004.fm.intel.com with ESMTP; 26 Apr 2022 06:55:30 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 26 Apr 2022 06:55:30 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 26 Apr 2022 06:55:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 26 Apr 2022 06:55:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 26 Apr 2022 06:55:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmE93Yx1ch+02Vs+vPDyIV1lz/rnkIWwd9jA/FGdac/uaCAywrb73Nj/W0M6/K4bCrZHXKuUO48+kKrUZGlYw4YljABtHIeoRPAw7VnmwFe7u9BrR2yU7Qd0dQwYDCHzy9twQLLyZIRA0MsYsANJuGOlYA4ksgEFHMmW0tLD9Y1YOGTelTZNG2vMP0Tx5kYAcn8SNoaVrkckfW3JghvtfDAsNQcvTc6sADaYS3+FnaulFr+24fRZi7//FhEQxS83cUCnbmXFObxpzFedDXpV+fTYuN9UnD4u86oPcNJIdl4T8vVgdq6E0iQbtPPVLc0y0DS4Uz0fjtGR5c+lAVLeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mawciNE+7NaDDQdvnL+yKnR6i170OSfP2yQ+TkeKpVs=;
 b=VMuud3HUnHmutoej3Np574iwJDCjkMejufehQm+63iLssdmB2/wbSyCP6TpmDz3NkxlO50pmVhqOoerDtS6v89nRqDpFziSgUfe/RZSiLkIYjXjkZOrta6fQDYJVS0hnf1L8UyS7IT8YkfdOTRmr42yZYulKW//bYPTEBUwj0iNVsfR0R1Mq+Z9EunSp2A0p6WDuE9tO8NpixEb+SttKavXfF8TElft6fGPRvK0qNx170QL4j7z0NJ1x2c3fxZnv9XKZsivDV9BAuJB1UEoRo2HGC8l1qW2Ngx0sd9TXMCePQvpiXff6vCaLbtBq3eOeLdmyzrpHja8T521dRshdmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by BL0PR11MB3218.namprd11.prod.outlook.com (2603:10b6:208:60::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 13:55:25 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::d24:3f52:f41a:529d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::d24:3f52:f41a:529d%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 13:55:25 +0000
Message-ID: <bdf5ee66-a14f-e111-a399-d6eb7e8d9b7e@intel.com>
Date:   Tue, 26 Apr 2022 21:55:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH lkp-cloud] spec/kbuild_bisect_queue: update kismet error
 id format and reproduce command
Content-Language: en-US
CC:     <lkp-devops@eclists.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Philip Li <philip.li@intel.com>
References: <20220426135100.2831-1-yujie.liu@intel.com>
From:   Yujie Liu <yujie.liu@intel.com>
In-Reply-To: <20220426135100.2831-1-yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:202:17::25) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e53d088-81c9-4ba6-678c-08da278c69cb
X-MS-TrafficTypeDiagnostic: BL0PR11MB3218:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR11MB3218432C971D2F0F64EE7242FBFB9@BL0PR11MB3218.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOEUV4sZ8bGOkNn6hz0B+Egrw7voe7c/UjdcijLiIs5Wj21VlU+BBJh6MqwUsvWJEDnfucYLkJS2tLeb88rjwCfWbeF0bxAopil4PPEpyA0vk2vmMBwkVNg8zWkkVsXfSIyMpgHZxwGduNsTRQCgkt1uSI38u2Aww+WoXVpdFofvkTC9McbbJ6Cd7yaCUSrHaWHIqoldTkysvGjK44EVP6rxPk3H+QZ1xbRcQLFPwkSVfsJ9GvvEAJ92f8cU294yDqc309NieEnTMt2EXzn+khlNVuXadarDMq58uT+vUsY8O3LdHljXC109Wcz44gEs53EFPacKtNhAplgk2txwAxx+fvWxPQbJU0qM4TUWEEaNCUPgOHKO9XQtT1BD77VrBWV38Wt61x+bfVkARVZqoXv6XOriwz0tvyIBDlj5ctW7pUgkIPmMRAMPASI3wlg+f6DmXNCK6I+omhEupepe6S46wDVtkO5G/t4y4sYrDd5RWbjXYNin/pcW4oTuZz1nUsaVnL4BZ0+nPja4QOimw5uZyJcOa0K0rC08C9HGhzPlw+U4DGBzt1gA/86rCNzuveffr+H4tT0pG7NmLkSe1YLoJRwHYojGLM9GE5CCz6wX0Wdyb24trL5QezDMEHnq1IlGXkZcvwlMKFoqAlj4WCuVlCcmeHCKDIkyvUiY+wJQPN/xv6zBHhV2axOBhG2cWT6bKE7Mk16pj9RmHUYPwEGXRQcbP5dmP8tYg6KXKc+eVXylaW9cPvqP1tnD5lOdpDPOys67vFSt0t+/pcdLL2AxH2fRnkAdgtzBe3oEtqNAdwmbKeeZ+uaZ7r53ZendvSNWLRN9IcDFWeMRAlyT8+8nkQe8q5rKtRBhaRnI0YQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6666004)(26005)(53546011)(38100700002)(6486002)(6512007)(66556008)(109986005)(508600001)(36756003)(5660300002)(44832011)(2906002)(235185007)(31686004)(8936002)(966005)(2616005)(82960400001)(66946007)(66476007)(8676002)(4326008)(83380400001)(186003)(54906003)(31696002)(316002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTk1REFkMGJ5bm9SQTdlVXRyRVZvbnVUcjMvTzFRYnhYdDBJZVVHWVc3OVVk?=
 =?utf-8?B?dXVLTWZEbU5jdm9lOC9WM25INnFPay9KQTVZRkJaRmdpdVU4MkYxbkI1QSsr?=
 =?utf-8?B?SUl1OTNkUTdRekpNR3hzdnZrdnRiUWkwTjJZM0pzd1Z4bWd2dDhaVnU0TFp3?=
 =?utf-8?B?QjBiTGpEQU9pdm5TaUFFdDNMcC9ZVXg3MmhCL1Rwck90WnhBb2VyUWFVc3VK?=
 =?utf-8?B?NkNhT1VXYzlxS0RDMkVORW44MVdQakpKV1BXR1BLVHhPS0ZwUjJXZ0VJZFZl?=
 =?utf-8?B?VmpVR3FMVjVmb2lobmV5MHE3KzM0b3F0RElEbUVMZDV5L2VuUUxEOFoxMTk0?=
 =?utf-8?B?Q05oWGdSVzJaenF1UXk2bUVtd2FsdGhENXJzaGpvWjRGbmlzUnl6SHF1NTl1?=
 =?utf-8?B?TVlvQ2F1S1ZXRGVyRnZOUHBZTjNzcnhMQTlub1RMb2RlcXppZ3JRNERSQWE2?=
 =?utf-8?B?WXF5dG5iNmQ5VFMydE5kVlFvKzMzbnJwOWUyaCswQWpFUUw5aVFwT3VNVHBs?=
 =?utf-8?B?N0JCcVVUMXFCVFNQSlFTL2MxazBlbHAxeU85M0lQbk9lM3NWNVk4cVl5MFdH?=
 =?utf-8?B?aGhlbnBuRHNSYXBDVjUycGZqM2VUaVhLVWt4eDNrWWorcTRHa0NPa1FUTmgw?=
 =?utf-8?B?ODVwTHZqWWlNTlozeTZpdVlsN1luZTk0Q0FKcHh2U0t2RDFiK0JWOWh5V2hs?=
 =?utf-8?B?NkVDdCtHNVFxakZ2NE9XR0dJdTJucmZQYkl5M3BORklqZVBrNTdZaTdDWDNs?=
 =?utf-8?B?cDJqY0lpR3JrUEJ5LzdHTVg1NStqVUdLaTRseDhCWHgrV1dsbmwzT2Fhak5p?=
 =?utf-8?B?d1lQaGoxdEdOSFRMekZidlhHTWltZTdXM2NNR2hGY1F5eWpWdjBoS0lwQUhu?=
 =?utf-8?B?L3I2aEFFdXRTYldNeGRGbkxrVTBxamRYMXF1SmVSZVVZaC9iV1BMZzJvNmNG?=
 =?utf-8?B?d3hnWmNNS1M4TEF5N0ZjSUxOK3RSSnY0ZlVMVDNTSkQ1YWk5bVdzdEJWUG51?=
 =?utf-8?B?YlpHcW1oblZOSlNQdHNsWklHeldBMy9GaU5rR01JaXQvY3R6OVFKbnM3UDhp?=
 =?utf-8?B?SERVb2U1Y0NMV1Z2MEVFOHcwTlk5dFNYMURzNytnY0YycERkcExyYk5MNk9E?=
 =?utf-8?B?VHVUclpLNzdzV3NnZGV4L2kwQ3NkMnF3c3dDUVhucFcrZDJXQ0h2bjlVQ3Av?=
 =?utf-8?B?RE1CMzNOYmo5M0ZKMlM0N2pLNm5jZGd1aFBFQXF3a3NDdG9mcGZXMURkaFJ2?=
 =?utf-8?B?ZjFOQm1TQmsxZW50Y0JaYlpVdmRQd2hQbUl6a2lEejJJdTZoR3pjNU1CQU5E?=
 =?utf-8?B?dFhwVlBWWDlTTGNRYjZqMWgxelBjVmtRRCswemRLNm9nS05IS05RckJtaVRG?=
 =?utf-8?B?Y1dYS1hqWXREaU81d2ZCRTR2RGtwTGtUZGM2VjE5SE9GcTVxQm5oZVV6aTRK?=
 =?utf-8?B?WDFnRERRZDB5Sld4MUN5RjEzM2hTMUw2ZCtkNGhTR2hMdEZTYUcrWVFoV0dN?=
 =?utf-8?B?OTd5eDMyYWNZS3NOSXdycVlJRWlleGFBcmd2WmNYN01tRVVUaU1tQURZVXFt?=
 =?utf-8?B?VGVhSnIxUkF2UHA0YVY4VlhhQk5BcFVFWHlJOXlVMHRKb2gxN0JnS3M1eHhU?=
 =?utf-8?B?M2IzUXdYUnpaUmdPR2luQVRENURMczJuK0FGSDh2cmgvcFk2SXMzcmh1ZGxx?=
 =?utf-8?B?N0Q4UGVScEN3aWpKTW8raGRWOG1odTc0WmM5Y3N1alh6eGVKR3R1ZDA4M3o2?=
 =?utf-8?B?aDBGaVZwMUQyRmdmbkE2cXB1WWZXaFhUVHdxS1pLLzdjOVEyWnZmUE54N1lt?=
 =?utf-8?B?K3hOOGdQOHI2RDJTVDdkWmNFMG0xL3NjVjJyRnFsa29lR29rY1NOdVQ5RU1L?=
 =?utf-8?B?TC9VeURpMUdnVXpqMFNXT1ZiVVZINUJSOElUSGJjcGhUT21oazdzYTBiSkxv?=
 =?utf-8?B?M0ZtYUFEVTE5QjZJMElDZ3U5K0gwNWV1SisrT0tEYVZwZlNKK0xWNm05M0J3?=
 =?utf-8?B?WXBqVFo5cnRjbUhYdFZMVXg5cDhyOFN3RTl6NjRUcnZqNGZ2SktSQWxRUVNQ?=
 =?utf-8?B?QVhJWUhsMVpwVXVaMGFORjBFWUltdkcybVhlS2FHWGE5Vmp2Y3UvZTJOS3Fh?=
 =?utf-8?B?QmJLTlpDN2lva2p0eitHM1F2NVFPcEpCMGtZN05PeG9sbHNwbkFtSXJucHlW?=
 =?utf-8?B?QjNUdUNXdHNEVld6OUtwZ2ZQdTUrT1pWRnEzejFOZlJUeE1XRGxudG1JZE1v?=
 =?utf-8?B?NDBiUTBJWG5BWWFuTE0rQ1dBbStuOEk5bEVySEZvdDBKck9iaGtWQzVyc3RD?=
 =?utf-8?B?VnQwZzFhOGFLYTZLRUVTSUhvRnNDNHAwNy9ldHVYcko4YW1jcW1TUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e53d088-81c9-4ba6-678c-08da278c69cb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 13:55:25.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+PBEb6YG+zr/woSqH5v+jQPmMqAePUQnYLcVknFdTKrrNqh4LduJMir+gyXiNS2S86f3t+WhAYnHhAi1XvAMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3218
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry this is a mail sent by mistake, please ignore it, thanks.

On 4/26/2022 21:51, Yujie Liu wrote:
> $ rake spec-slow spec=kbuild_bisect_kismet debug=1 code=1 C_ROOT=/home/jenkins/rake-spec-test/kernel-tests
> start spec
> 
> /usr/bin/ruby2.5 -I/var/lib/gems/2.5.0/gems/rspec-support-3.11.0/lib:/var/lib/gems/2.5.0/gems/rspec-core-3.11.0/lib /var/lib/gems/2.5.0/gems/rspec-core-3.11.0/exe/rspec --pattern spec/\*\*\{,/\*/\*\*\}/kbuild_bisect_kismet_spec.rb --tag speed:slow
> Run options: include {:speed=>"slow"}
> /tmp/qa-20220426-21054-w5d450
> latest: Pulling from kbuild
> Digest: sha256:c1bc7056e6b210b81791496bf7987b64edfd12b4d300252edda8f54446c57334
> Status: Image is up to date for lkp-server:5000/kbuild:latest
> lkp-server:5000/kbuild:latest
> .
> 
> Finished in 57 minutes 34 seconds (files took 1.12 seconds to load)
> 1 example, 0 failures
> 
> the final content of report mail is:
> 
> CC: kbuild-all@lists.01.org
> BCC: lkp@intel.com
> CC: linux-kernel@vger.kernel.org
> TO: Artur Rojek <contact@artur-rojek.eu>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d615b5416f8a1afeb82d13b238f8152c572d59c0
> commit: 2c2b364fddd551f0da98953618e264c098dfa140 Input: joystick - add ADC attached joystick driver.
> date:   1 year, 7 months ago
> :::::: branch date: 18 hours ago
> :::::: commit date: 1 year, 7 months ago
> reproduce:
>    download attached .config.gz and extract .config to linux source tree
>    run "make ARCH=x86_64 olddefconfig"
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> kismet warnings: (new ones prefixed by >>)
>>> WARNING: unmet direct dependencies detected, selectee: CONFIG_IIO_BUFFER_CB, selector: CONFIG_JOYSTICK_ADC
> 
>     WARNING: unmet direct dependencies detected for IIO_BUFFER_CB
>       Depends on [n]: IIO [=y] && IIO_BUFFER [=n]
>       Selected by [y]:
>       - JOYSTICK_ADC [=y] && !UML && INPUT [=y] && INPUT_JOYSTICK [=y] && IIO [=y]
> 
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
> 
> --RWj8+mpoThLpL0oB
> Content-Type: application/gzip
> Content-Disposition: attachment; filename=".config.gz"
> Content-Transfer-Encoding: base64
> ...
> 
> Link: https://jira.devtools.intel.com/browse/ZDAYCI-15410
> Signed-off-by: Yujie Liu <yujie.liu@intel.com>
> ---
>   ...d-selectee:CONFIG_IIO_BUFFER_CB-selector:CONFIG_JOYSTICK_ADC | 1 +
>   ...-udd-x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-.config | 1 -
>   spec/kbuild_bisect_queue/kbuild_bisect_kismet_spec.rb           | 2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   create mode 100644 spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd551f0da98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/WARNING:unmet-direct-dependencies-detected-selectee:CONFIG_IIO_BUFFER_CB-selector:CONFIG_JOYSTICK_ADC
>   delete mode 100644 spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd551f0da98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-UNMET_ALARM-True-kismet-test-cases-udd-x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-.config
> 
> diff --git a/spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd551f0da98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/WARNING:unmet-direct-dependencies-detected-selectee:CONFIG_IIO_BUFFER_CB-selector:CONFIG_JOYSTICK_ADC b/spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd551f0da98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/WARNING:unmet-direct-dependencies-detected-selectee:CONFIG_IIO_BUFFER_CB-selector:CONFIG_JOYSTICK_ADC
> new file mode 100644
> index 0000000..64e3ea7
> --- /dev/null
> +++ b/spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd551f0da98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/WARNING:unmet-direct-dependencies-detected-selectee:CONFIG_IIO_BUFFER_CB-selector:CONFIG_JOYSTICK_ADC
> @@ -0,0 +1 @@
> +WARNING: unmet direct dependencies detected, selectee: CONFIG_IIO_BUFFER_CB, selector: CONFIG_JOYSTICK_ADC
> diff --git a/spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd551f0da98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-UNMET_ALARM-True-kismet-test-cases-udd-x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-.config b/spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd551f0da98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-UNMET_ALARM-True-kismet-test-cases-udd-x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-.config
> deleted file mode 100644
> index ec7df3e..0000000
> --- a/spec/kbuild_bisect_queue/kbuild/bisect-queue/2c2b364fddd551f0da98953618e264c098dfa140:gcc-11:x86_64-allnoconfig/.reduce_errors/x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-UNMET_ALARM-True-kismet-test-cases-udd-x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-.config
> +++ /dev/null
> @@ -1 +0,0 @@
> -x86_64,CONFIG_IIO_BUFFER_CB,CONFIG_JOYSTICK_ADC,0,0,UNMET_ALARM,True,kismet-test-cases/udd-x86_64-CONFIG_IIO_BUFFER_CB-CONFIG_JOYSTICK_ADC-0-0.config
> 
> diff --git a/spec/kbuild_bisect_queue/kbuild_bisect_kismet_spec.rb b/spec/kbuild_bisect_queue/kbuild_bisect_kismet_spec.rb
> index 000233b..736bfc6 100644
> --- a/spec/kbuild_bisect_queue/kbuild_bisect_kismet_spec.rb
> +++ b/spec/kbuild_bisect_queue/kbuild_bisect_kismet_spec.rb
> @@ -7,7 +7,7 @@ describe 'kbuild_worker', speed: 'slow' do
>                       commit: '2c2b364fddd551f0da98953618e264c098dfa140',
>                       first_bad_branch: 'linus/master',
>                       first_bad_commit: '2c2b364fddd551f0da98953618e264c098dfa140',
> -                    reproduce_command: 'kismet --linux-ksrc=linux -a=x86_64' }]
> +                    reproduce_command: 'make ARCH=x86_64 olddefconfig' }]
>   
>     define_kbuild_bisect_queue_spec('bisect_kismet', 'kbuild_bisect_queue', test_options)
>   end

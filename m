Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA45638FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 20:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiGASNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 14:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGASN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 14:13:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3322213F50;
        Fri,  1 Jul 2022 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656699207; x=1688235207;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jmcTpz27v26IoEX4us16ojCx/asKDNnZPgBeDCgeOUM=;
  b=kBJpQKrhIJUWWQYZJJBXemqH+AX1MCsQ5QaVM1Af15+jdTVUiuKOCqyj
   P+ol4Myg/oSziXtCAjEKzIOQcJo5QBs0ZU48NPWwDGD3FQ1o0i2eXgQ9P
   FTkDq9YUxI0jlaiosX/qttclxZowZjA1ME7OX5NwjUqud2zc6tt6wFj0a
   erVcErRkq2kUfCmrh+KK7H4Z1WoAXNhA6WUr8cT1a9JOq+xgIdy/VJXf/
   /S0o0YdvXR2cfDnabXRz3oKit22S4u6+hXuNXkkLykJz8co2/mOlm1XIH
   sLqRgdKHm/poM24/WytGU3Ju7/2F1BIRi2wJRmWhkw3l3wo/+4pb7tT1l
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="282741351"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="282741351"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 11:13:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="734145645"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga001.fm.intel.com with ESMTP; 01 Jul 2022 11:13:26 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 11:13:26 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 11:13:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 11:13:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 11:13:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drB753DDkE1Cevb4ZQN7qzkOFW9sdt5mxVEMINZZMv3Ah+6hx6OvmYKcop7LPQhTlvE1AyfbrQR1lkipaKa5pbKVdJe/zws9pCE0s4w1NQ/6idW6ziKdrKAPejhdvwRyVbhHhonbWa6aGYs/WcG7bBl+GNTH4gBwBND55YxbZoHUAJJA/TrRR5IRbdT2iN1x0wPl38NjJzSIGLNnGMyvZxkO/wo/lUHjBXvTyFQncF6dI0+SWDvFyvUvO7aYpR4I97zOyqua+LOF3wR1HsvfMNrRx5RkGsFhfcsOa6NY+vIy59uOT27mcOQNZDNuukGXP+TiQbi4MaaxzHpAeGH7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mHeJDGnPsJv5QjL2T0yo/uFPm1UiXbjE2Pm30ciNOM=;
 b=nBEwDppRhb4J9ubRevc+QkQsBctwwrKmhCrrvV3DxnAFwy/7I3RUOplWXb/oCu9Hve9QJKe1xDxl+7VkNtQWy38hU2pSsE2dTa13xn8Ivy4ww9AiI0o0+ZFmzap+xg8FBUrdGWCEobO+B3FNyWqzcEM9xwcvv6psKlEyP6SD4HUAoYHNfDeelI40HO8qYCfUZ/QHQSSn16P49M9lkB1CKz692ayKKT0M7Iu0m1TuumrJ/zP/o3ZIdtr3S04YV+DDs8uWiBz9jhlmzSpUvVXXVsTAjR0kZvAZTb67D+J1FB0HzKdUZfMClZ5OYR+5o/1jcj/ikRIPaY1969mhVpnwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by BN6PR11MB4164.namprd11.prod.outlook.com (2603:10b6:405:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 18:13:23 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513%7]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 18:13:23 +0000
Date:   Fri, 1 Jul 2022 11:13:21 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     linux-modules <linux-modules@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] kmod 30
Message-ID: <20220701181321.zgzxv7p3zrbzkuf6@ldmartin-desk2>
X-Patchwork-Hint: comment
References: <20220630153621.3fggpqrbyvunhwfu@ldmartin-desk2>
 <Yr4fHBR08VAVbs2E@bombadil.infradead.org>
 <20220630223323.2hko2imx62embtsj@ldmartin-desk2>
 <Yr8zlqicFErzw0dc@bombadil.infradead.org>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <Yr8zlqicFErzw0dc@bombadil.infradead.org>
X-ClientProxiedBy: MW2PR16CA0068.namprd16.prod.outlook.com
 (2603:10b6:907:1::45) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 435003fa-a184-4710-57e7-08da5b8d62e7
X-MS-TrafficTypeDiagnostic: BN6PR11MB4164:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1ZgZGRdTelHDX8pyab9fl7CM7Y/OcbSP7WFL+4uumx3N1XOPB7iQDtV2uDKbMWPntq4RJLmhW4ka3oILygHhMMTh1CHMaBgn56d2ctJ6adzkE7+vT0DXNtklGb88x446KwAjXTD9de6i+0k+GmSsBf6FN7Gc6Nk+VegAinZSPzSEYOGFpZUO0pONa26lGoZ+O3Ukhvqf4xM6PLTS87SoCFzZznBpOqHT55TjlAU/7glfsvmaJyA+srlFi1P0O5LPysHjVa3RWy3qy1nm9zfrktmLdNS5a2WioVIkqjb6I5oCwic27e0fiWNNJfsMWJp91VmjddSBYOb0as/m7mCE2DUSVkyhpjC+GgnbGKWQRhK0luPagElSM/6aajgxcSUan9DTrLDjY/TxZMCPjtRBJy2uSLgOabgT/wTZb7VakWYJqLMKp6kwqplrhqAZWUGhK38PaEO7mPq9If3N2/6q9w4EhRBaoT3qYTJ0dmqnJMG30gzv/ofMRMje7S/4y0j5mP1Dqt3Q/IVj2pX3NSB5jYJBmf3SRgYb6mhmzwnTheaIA5Uxi3RkCGGtz1bYdl9r0S6YS9z/ZoXEnKSgvJISkEa182R3y/ITVOaNGREjCuuBnBM+m3C4etnK72O+PzO4eu/WPXql4f59RgOKl6BnKTeZutqwFZJo9WFJrwvEulrV2XcW9Lm7JMl8SOhkoi4SnJBBS7pwEDzHMWQGkjaIQ9CQkEYAaPbT1a/WyzMbemI2g1bjTVIo8Ad2T6aZ1Qa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(136003)(396003)(366004)(376002)(316002)(8936002)(5660300002)(82960400001)(83380400001)(478600001)(6486002)(1076003)(9686003)(2906002)(186003)(66476007)(26005)(66946007)(8676002)(4326008)(66556008)(33716001)(38100700002)(6916009)(86362001)(41300700001)(54906003)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1NtfLDWXgbjjwS2d+/eETsCZDZI3tfevx5mcaiVvDDgAQij27hCJOcnKgZPj?=
 =?us-ascii?Q?kycZXAkpDTQ7aFSl8Dj8r1TzgSvHnCHmC7zfBaMbRU7UPQmoyPOKQLQ2k8bo?=
 =?us-ascii?Q?qKu1alEYpSN5vnefcRfT3ljmhEXc9jrH1K16HKjXsjgBvOuVrTmfcOeCmBd5?=
 =?us-ascii?Q?Er++iexX7aTYEAQ4raxE5UqKkARYd/kiKfMMRdMMmxgqs7o6m9lp16tgN0Qh?=
 =?us-ascii?Q?9qj+hCJ+n4yGecUZDtvxm25go3BbY7vd+G/ZislqhQ6v1XSd+R6mHxNGwwWT?=
 =?us-ascii?Q?1Oxl3o+wabxU/tvBBohH/o9OIRjT/cts8s6J4ruB6jwEWPoM92v1Lg+eQGcC?=
 =?us-ascii?Q?TTLkpHwbM04g2ZbApD2dvhVdWZ0gpG1KeNnrRHzA7X3GcTET+GKB4doLP4zJ?=
 =?us-ascii?Q?rqFxjS7wkKH9xup/Cvfp89lGotFCbhcNMugm7PkK4T+kU+IESbqEaREC2r7V?=
 =?us-ascii?Q?69O53ecUd1LvTTHqQ+XPjvai6VEY4Vk39yH5GbssNCtTsdHHklZFg+ReC8Zl?=
 =?us-ascii?Q?zD8uMKJWyZdbyVG+4L8ewa2/04Xy+Q8OiVRu0jSaAYOb6D2W6GV8DNeFyPjM?=
 =?us-ascii?Q?pSUXkPG1u9dnQehUc+a1TOGli7SnB+mQeQ3dM5MPVB05oL0cplaze3La2VFs?=
 =?us-ascii?Q?kW5JybAAF+dpZHb+aRR8KM2nkB2GpqS+zia3xoivg4FZwFYKoe0hhaPU+QOT?=
 =?us-ascii?Q?2OxCSJkRty2+Kg6CPkGKGdsYTvpwR3lAezEbcw6kc25+sPohWxf9agL5H1WT?=
 =?us-ascii?Q?fwwB8vxUZGfSbcS5JcnMgQEELIHDuCA27e41vnmSKi0gON361kIN8C+syCUR?=
 =?us-ascii?Q?3bMNnZ/3yeZUNh+3GZNCLiG5JDrudEbhx1JSPv4J3IfHczbIfwfkrgcmMZ+t?=
 =?us-ascii?Q?DgjvPxo6JhkTxGFO3/LBRgcvhuoAYetd93bSURCur+1ljP26OjzjpLxCf+re?=
 =?us-ascii?Q?F20VoccsGduRu1khAKegj9YZ1GGNyfF6m0+KMPCu/waCKmndPqb8Ii0vkHB5?=
 =?us-ascii?Q?USMc6lmCN5q9yXwplO6VsIVpjT7EfFVx4uojThHu6sQ98l7uIAg6dI8qCSAB?=
 =?us-ascii?Q?fmMhPfBtLKvx0tPjh/ySCSlICrkEOXaU2OvWM6Sb8NXn/wFIsgb5usjs6a8M?=
 =?us-ascii?Q?e8D6T59WHpr3J6sZnX69WXFRg6iA/0GHPSGwcMU40ocwGQsBs0H19vHXzcFP?=
 =?us-ascii?Q?SkkCNt+zD+jgvh3d0MeeWw5/6sKn1rZaARV4XD9xkoMBKgqPZev2Ktft9dBz?=
 =?us-ascii?Q?YDwCzK3vunAI3DkcwKlobWL3truUNV/P6iCrr5c3toUSdlDktQtHZo5jgk7w?=
 =?us-ascii?Q?vckJg7WkH8hRZFCjZAD4lSBR4B3RfBKE+qYOtNAXRW92gljNip2UFXR3DMOC?=
 =?us-ascii?Q?DWjbeEMEvThncFr+RasNeY+2p/4suB9O6lcYuIq13a7q1nkiunEfSPo4jjlo?=
 =?us-ascii?Q?lMRWmYhoUkdAb8F3quk9tCMaGEcXDXtbfEWmgpeaxbSG1TpAsaZZZaxfHsNm?=
 =?us-ascii?Q?FkPPhdMEWBHQvS2j/gg/Klr1rOuCxicapbU3KQK+COf1d1zTBV4wV4D82KDG?=
 =?us-ascii?Q?bRt4WjgR1f/8Po8CI4h0YQpJgVBF9rQqn13XE/GSPXGOTt9QmEECRNxYgDuM?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 435003fa-a184-4710-57e7-08da5b8d62e7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 18:13:23.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUsS6X7ZS05jR/gyhijEpkuDHbx/BjSzKLuR0JM1IAN3E55fDVwKygbJfv0gre3BFnjRnAU/I4lrzz/gtU0tiH0lzCANF6trUKORxykdKVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4164
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 10:49:10AM -0700, Luis Chamberlain wrote:
>On Thu, Jun 30, 2022 at 03:33:23PM -0700, Lucas De Marchi wrote:
>> On Thu, Jun 30, 2022 at 03:09:32PM -0700, Luis Chamberlain wrote:
>> > Sorry for the super late review, I was swamped. OK so the only issue
>> > I can think of is that rmmod *used* to support the kernel wait support
>> > with $(rmmod --wait) so wouldn't this be odd?
>>
>> any reason not to use modprobe -r?
>
>I was referring to old scripts which may have used $(rmmod --wait) before.
>But since support for that was ripped, then yeah I can see that should
>not be an issue.
>
>However I can think of *one* issue, did we ever support `modprobe--wait`?

no

>
>Because the way fstests / blktests would implement this feature
>detection is with something like this now:
>
>_has_modprobe_patient()
>{
>	modprobe --help >& /dev/null || return 1
>	modprobe --help | grep -q -1 "remove-patiently" || return 1
>	return 0
>}

the grep would need to be changed to something like "-w, --wait"

>
>> > It is why I had gone with:
>> >
>> > -p | --remove-patiently   patiently removes the module
>> > -t | --timeout            timeout in ms to remove the module
>> >
>> > You would know better though.
>> >
>> > Also just curious, is it really terrible to just support waiting
>> > forever?
>>
>> is there a use case for that? If we are trying to cover some races, I
>> imagine a small timeout would be sufficient. Also notice that if the
>> timeout is too big, so will be the interval between the retries.  On
>> your v2 I had suggested polling the refcnt so we would get notificed
>> on changes, but as you also noticed, that didn't work very well.  So I
>> went back to a time-based retry solution.
>>
>> if there is a use-case, should we cap the interval between retries?
>
>I really can't think of a use case except for catching glaring
>unexpected bugs in test suites where the kernel developer would
>really like to know something really bad happened, but even then
>a timeout is likely desirable.

yeah... if developer wants to possibly wait for a long time, `--wait -1`
is available to wait for years.

>
>So just a heads up the timeout I'll use for fstests / blktests will be
>of 100 seconds.

yeah... 100 seconds still make more sense than -1 IMO


Lucas De Marchi

>
>Thanks for this work!
>
>  Luis

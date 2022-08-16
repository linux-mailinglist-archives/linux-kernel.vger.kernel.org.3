Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758AD596099
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiHPQwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiHPQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:52:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5EC7C315
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660668733; x=1692204733;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6yKG5vKHV+lMccB7gRvRc+mjiQqVVpdkFTg0rr7Bs9w=;
  b=jagtMA+KmSGSkI+kQSpLXDtsHGvdr+ujQFFg1Gxry/0Kw53sYFPKctDm
   N8ze5hFW9A/hY9geMkF+Le14+LmZ3SO5JH2FDXhTJs3zzs1w0Liqp1F/1
   bFEfIwmCJn2Ng3ljAm4OFG9OwHHWYzE+9hwnpBqT8rLFiQ3p9CLEBvJBN
   BCd+2+GTGdVBfD7kSuDojEwdgkAA8xpL1KzwEe7Fw4LyBwxgw3EpiGvuC
   z0nNVUJ4GyrrEDyFTBsMHC4/kymIXbwcBtrF90NUqP5YqoAwH8qb1PorT
   iKFZOeuwMhCJN+vaJTtivmL1tu2enVY6aDkrToz4lrYqfiF1PordjF0Im
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="356274317"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="356274317"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 09:52:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="607107211"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 16 Aug 2022 09:52:11 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 09:52:11 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 09:52:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 09:52:10 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 09:52:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmaC6jmH5VuQ/ZjlJF4PZo7WHJjUsxc+1IgF3gXym7hLJaMyCiU8hugZWMJjmX7QGYDg1fetiY3lho3c+jZXiAS0VrmTXgscDkZhNhxKQqiNCGb/WxW1zchpDHVsaAjCSJZKVZ3VCUZmD/dmihg87J/uNVhiYl5qjHkXyJJtMO4HVKdKEEyaadF7fX/vSD4cWT1gRfzzVbPXKP0ajK7p47oFbSCCzA5ve4xOKMpqKMnMGmgD2ZNsoBxtEQfZIgi9+BgYzq8x4kmHlV6Hwo/Zcr3no2ZZQZ6ebe7BakNjfrQ4ECtjQgeh5ikBbovk1cJjdKVFV7hygOd3bePI2oN67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I/mokz1R5X/3bkeOPNCiffg00qgRf3ip4namUiuwIA=;
 b=nvqf8lTQZf8IOxYOH19FYj66jmWSq9oJ6bdaNYOdULXYstyt9pE2OdFuPAGitNeh+3+ofDOucVti89C9oLs42W6apslpP83QwB2PnsyzTzGbrxMdKArFHf7lXBGpZdbxVqLUA1Y4vQUTlkdxdh4To2MK7SgUVf3dAEEcpbuQBfqMPBrUFh/wJzYPYM2WbS00Jwv4ASDG9a8Q8CZZ3nZFFUxOzg29Jfth5BhMlG6qI2CRK7AarjfA0JuP6dZjPexA/G4u4EctLLK/Ul2cD4WzaKKzZB0+IVNgetWmAFgefGVLmWg2AI+48e1Gln8Bn9GZ7IVqBM6chiFUlVRdzDhjbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by BN6PR11MB1426.namprd11.prod.outlook.com (2603:10b6:405:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 16 Aug
 2022 16:52:08 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::10da:929a:73eb:40ad%6]) with mapi id 15.20.5525.017; Tue, 16 Aug 2022
 16:52:08 +0000
Date:   Tue, 16 Aug 2022 16:51:49 +0000
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Ashok Raj <ashok_raj@linux.intel.com>, X86 ML <x86@kernel.org>,
        "Andrew Cooper" <amc96@srcf.net>,
        LKML <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?=C8=98tefan?= Talpalaru <stefantalpalaru@yahoo.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH] x86/microcode/AMD: Attempt applying on every logical
 thread
Message-ID: <YvvLJZR+8jS7Asnq@araj-dh-work>
References: <20220814120026.16118-1-bp@alien8.de>
 <YvtcGEHX8eSFpALX@araj-dh-work>
 <YvuQgx698T5cgF+C@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YvuQgx698T5cgF+C@zn.tnic>
X-ClientProxiedBy: BYAPR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:74::43) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b966ab5c-2e4b-4743-381d-08da7fa7a819
X-MS-TrafficTypeDiagnostic: BN6PR11MB1426:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVTHUKtkfivSB0Ac3rhlrvCFmkCAtzWS8z24tuuYF1nX2X/G2TPOk2UE1xzs+LL8Vgav/gAXiyJUq/xCkAZ+QTrmsLU+91iNOQrYLC9K6/VXxC0OHhiPKZd9qImEbnCw6pxbfbfSkBiVSdvtw/9bXqQBuCApcrGTKHUT9MZWGLg/kNGNDwuELBPGExZVLnOORCpkC4is6izW+M7kby0PEzVPQjN4ZhcVMdN/mv4dGPLLJOajFymsbyB/McyBqJQRcoTFT+mi3xcxpuE12cHG96yOoOp62K7GXmFTqfSXPLNBDTLV9R6PiRzGi5xymLANTMDAQf0SfumqyJsj+XpQIoD4f26WQaKxZ0WdSt4Bm0sQtgXNNENl1gTRXY7zkA4HrscQ/fHC/QpMOIX6x/aq8SXZ0AMaYzVphSFbS6UvCbWRXBG+2BL198IgRgepFVr6WUh7lYqngL4keT8+RjcBP9oI0EOC7loolw07fdFH6VOqqBepx9fhY8pUDUpiX+GlepaBp4b1wrXq4AfAXR7fAAAyVngIdNXNLV4vcbCEzP3kfH6nSYVLMJXi5/xiYB8+3c+Yh5rdlsLmgEpkdBudAGZdkKl+LNbeV/X6ggGlaRfBBkRr290mimvQyC52e0UlM30MttOZDEKrQyzxxGQajwUhk8IW4a7PxvNcN3Z4VFwavMEJdfgBaVyeReIUMcAPZbQfky6SgidFY/55+KKH+e4cri7v+a0a4EBNhBlsVp14r+lsuo9RWGzejxauqG2dLJGKMwhPCe327kjbUSfakmWCDV7y3ov45r/ZQqR38MA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(376002)(396003)(39860400002)(136003)(346002)(6512007)(6506007)(2906002)(9686003)(82960400001)(8936002)(5660300002)(6666004)(41300700001)(478600001)(44832011)(26005)(33716001)(6916009)(86362001)(38100700002)(83380400001)(186003)(54906003)(4326008)(66476007)(66556008)(66946007)(316002)(8676002)(6486002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kGKGWXeuGjshFyK+/jL6deP46+hFy4UqjR+6nsWmipnf7M0dzWPX9qZGAcGD?=
 =?us-ascii?Q?kIEO7V/cs7DtEgaWXeQE1q67tTXzvWgDZLfYDhLhu8vokoFGD60KoEtZRrpr?=
 =?us-ascii?Q?Cv03xVlBx3VGrTla1NX7LHa6iZWTGqOsuxHbBDNHPksOyj0fHqBZWMJtrQYb?=
 =?us-ascii?Q?T0cPh/Nx8MmDKinWC4VDe7rTRVPHbw11rsvI3QA2le6Ez0dr42hRjGYgvokB?=
 =?us-ascii?Q?QAyEZGatHc3yarrNTlEzR2NtTMx5+GwIONzEea2jM0kZdH5uylLUnJ07Qw8f?=
 =?us-ascii?Q?GWntJ8ogSA+T1nMkGctLfUkByKSbgG4pJE7qynD0m28UjiVS76qXqJQyH5oJ?=
 =?us-ascii?Q?LBYE4cbc6J8C4nOMe2MdYF79MUUiGfM4d08x2ePxWyHGX1qcRvVso26KkY+5?=
 =?us-ascii?Q?K6QEmtI5PXgT88wUvx7ZYObmD5QRRGCzkESfuXHwxt9QPYI8g/brbNru2Evs?=
 =?us-ascii?Q?wtAZlHGUWup4hJHbdC0CoZT56y38IAMis1wmgLh9Y9b4SDDZzZQ1LtgVti0e?=
 =?us-ascii?Q?guxNGuoG9Ox/Xm+49RWRIjoSkg/icus0rOrHT6N/qt1A8qnznOeXRisWvJr4?=
 =?us-ascii?Q?b4jRNj/lnTji/0s5aPtYQjkjm3qhiuS0tdgww5PuDXg0K2t4nhrZD0n7Md0R?=
 =?us-ascii?Q?WawjloTcjFQyaJ4sEQSvwtjuNvK96RJjhInX7gmeT0pCggOrTIbB9HdGdISs?=
 =?us-ascii?Q?8aNXSTkOr1FoSoaLUc3hd2peP2M+ZwWKLOuNBpb4qlVDwrCf05JYUIIBZzX2?=
 =?us-ascii?Q?AdUcTC+TE3mvO6FDMvZdWM10kq0ReSQ3DcE4+8ebCgAw6d5bC4cOj5X+e1XW?=
 =?us-ascii?Q?EMTEPUE3ZLnTtuFcTkp8Iww7eK7lasrHaCzeAAUiIo6LWYTeAFNUwC/wTDN9?=
 =?us-ascii?Q?EqEuGeK73hPMNbkQHYTeCbm2B5TDCAPf02hgdERxJX+WHxaiKBAyGyZ/D43P?=
 =?us-ascii?Q?YwLObNDJG2HTlOIDNld0RgnMsBkw1gD0uDaVUusbkvNg2ZpRXF+yZxvcn1yu?=
 =?us-ascii?Q?PGvlW2ma8+V9XtnUpnTaHT+d3e4HOVMjbfgrvhtAX/dE8xW2S54dyis4gB1g?=
 =?us-ascii?Q?xFwsxsaz3x9krabBjlyxLOc40RwrkTFWftrYRu3u3b87uxexFZdsIGdl/9k2?=
 =?us-ascii?Q?Swq7lB/SarcBjxY+a9qhW+VjAqc+aFxQ74PRxI0b+gaBtplqWSQ3nCTN3Wjg?=
 =?us-ascii?Q?c6WFZoNs7KSEZoO19TfQuOwzAvW4mH0PBgE5vla7ChYl9ernVURW5WQn8g55?=
 =?us-ascii?Q?5HT5VgromrYknphRmt1kDYabRCHuhtn3N218etILa77tmu4rQIhGu8/zdlx4?=
 =?us-ascii?Q?teio1oFEUnY7Abv32j76FS+KZopO5I7nGNSAl6LPzA8gBtx1z/3bHeLXbV0n?=
 =?us-ascii?Q?qhhQE9zFZn/0e6QWBMKf4Fj32eomBDueqk6SJ8q47Xsdim2pESk947L7qZgh?=
 =?us-ascii?Q?+3Y67Jf9dQHfOaNfK9c9sAFORqRyKKtcsOLDydem49sS+gfiJa1GAZP+97oE?=
 =?us-ascii?Q?SCfbJLZsU80k7G29eCNNlaPXbj+vviAa4DlUrd3EzST45SKm9bI5PrzwGQaM?=
 =?us-ascii?Q?j4yrnsqN6EFJsCWJd14jaoavlySCTQmN+Jt2TEsUCNGy37DsPgeehkg11mvP?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b966ab5c-2e4b-4743-381d-08da7fa7a819
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 16:52:08.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6LoxQb7rUHBJhTu1wYGOCcudDuv5InRQKAZ3106X6hdqoToulRx6gYpIrWveqXTBMGYDOfm0AYLl5M2u78BLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1426
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

On Tue, Aug 16, 2022 at 02:41:39PM +0200, Borislav Petkov wrote:
> On Tue, Aug 16, 2022 at 09:00:14AM +0000, Ashok Raj wrote:
> > A re-application means, you want to apply even if the cpu_rev <= patch.rev
> 
> Yes.

I see, so we probably shouldn't remove the rev check completely but just
permit to reload if the rev is equal?

> 
> > if cpu_rev is > patch_rev, clearly its ahead?. say BIOS has a newer
> > version than in the initrd image, do we want to replace the BIOS
> > version since we do no revid checks here.
> 
> Can you even downgrade the microcode through the MSR?

I'm not sure what is true for AMD.

For Intel's there is a Security Version Number in the signed encrypted part
of the microcode. As long as the new image has SVN >= what the CPU's SVN is
you can update the microcode. 

So if a rev2 is loaded, and rev1 is the new MCU, and rev2 and rev1 have the
same SVN, you can go down rev from rev2->rev1 where rev2 > rev1.

Microcode enforcement for rollback protection has been the SVN. Version
number is a SW feel good thing to identifying which image you are running,
not intended for preventing rollback or any security enforcement.

Cheers,
Ashok

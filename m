Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08B35B146D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 08:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiIHGLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 02:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIHGLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 02:11:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1C3ABF0C;
        Wed,  7 Sep 2022 23:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662617476; x=1694153476;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D3wmsa1AKXC7PI6OZb71HqJGjVQNa+srtgwm/9oU8jY=;
  b=buIJY+JuO0PORhYHTtHoC+anCO/z311eM2U7s9HCJrdOX+53VSY0QvcI
   /MCqWfvsjsNdJuFSIzHFUGJWkOX+GEhv1+8z6lOp568t/WUOSn4xntu4x
   XkL2itQFYCwFS8sEFycMvpu+K2bw3aG1ZD5f/kINLfsgaJAoY/Oui3fgL
   z02SpLqeQU4wuNCR3XeshmuUbdQQUUk7X7lT7v8ZOfjsIVcO0WRG16roQ
   9K8C5zjuIm6zflrNI8t9RElnWNgNZGm+RcJble181XpzbJgL8inhezyNQ
   fbxdJ3TLOvl9wvxYrxq6nSw9NrsZVJDBZbIsuXWQs7mzwpSXgdcw+ihTt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297884487"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="297884487"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 23:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="757070007"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2022 23:11:15 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:11:14 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 23:11:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 23:11:14 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 23:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH6UTo9sCmTBtzJZHH60O9sJPJgpgbKSqLLv75Jbyp+TBw3Ew638tTmxS+XXw134zPGq4IchtNU3d7cuWz+zrr9pMAUPZ4EmDvAzDkGwdU7jDdev4VSowFLiZfzEUscO2qDAonXvtcVlJKKC+tK6o1hQMvwFvAV9EIBWirEIaNZ7YhOPpMuynm2HTZ3SR4muYbUgTghLkE3ehM4PKIFsiaeryPib0YGWzVJrJE6Tivj14lfL5c1k1yVU04BmTBrMd60yrTubt59JLjH8Q/33ITapBJmTpxEnVrZQ9rQee5dAKOCgc5uIB5qKfFAWOltJ+48A0CaoCowWiD8vHj4L7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsG5YBa3zOuplV/qFofzDn7OlaX0Onzv97kQMTGM0lE=;
 b=kDao73lSn+VZKZlqbD16KxxqVdZJT0XRAWZRJKstrCjZQy9w+CRoXdjXTpUqp1G72Muo+CruVCyBg9hqpgQSAAsoIAAMp3ymaAawVQPiVBi792EoZ8k+6YFTB7ADaV/gbQDstGIat2Nzyp0O+5iQ5EeXJJtu+pxOdCXjvAeyXR0yjvP50LZwshYUzT4/1e9JmS/E22qVyU6xkXvGoSj+qBQEqdJODZaoCJdBtPus7X5LgXlwE/+kRPklmNQcxW8unIb9x+LiWK4CH+uwSM8vjGxWDmzUWBDxx93d6P8d2gHADS27ZMWUQQwmZ3C4awgIAcSrGg1Wy8yJJF+NGNtVGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN6PR11MB3056.namprd11.prod.outlook.com
 (2603:10b6:805:d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 06:11:12 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 06:11:12 +0000
Date:   Wed, 7 Sep 2022 23:11:09 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Robert Richter <rrichter@amd.com>
Subject: RE: [PATCH 05/15] cxl/acpi: Add probe function to detect restricted
 CXL hosts in RCD mode
Message-ID: <6319877d8dc7e_58016294df@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-6-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220831081603.3415-6-rrichter@amd.com>
X-ClientProxiedBy: BYAPR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::14) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 147415d8-0f12-4733-6949-08da9160ee0e
X-MS-TrafficTypeDiagnostic: SN6PR11MB3056:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E176iQDxHFB6T2lTzXAbbEx01PQqn9VpU4xG40LYFabYkm7TH7eBl57refTwx5eqrQjh9ByjjtuWicElGFKVeiJ7hG4lJJoV5mqT9lTlx3WyLZsvbPHP/sJted+rXEHxeI/ufNPOoWfssirwg3SCD+IiLS1u/sEt7ySmK9evlDwEQEU7QTA4kaMjdty4hDeQ1WuZqfFdL7qusNBZmrZMoDjg7Wd15YbWAzSFDvxSaC5GLiCpZxyoFH+FDnLpMolCq1LoDtswjpLZb13Rc1kKCtMCwTeHNsz8Lwn5mDH/BGxxsayfAeiQQCWE/D+1pnCfbjZce1ftRXUeqqp5kudbbWPalrWDGUsnyCdy+mYljtUsy4EmZb+zrXpkU0sLKZ7T9XyKksZhjIGXAFlm1tWFWrHYoq31oLQePCyJYoeP5L93/8kPAqqBmFtho/EJIRciaOkFp681E3HT+bW3MLvJwEMXKyx1R1h8w7H9vjKCjcbqXnC5WuVx6m9G0f6AlU5kjwtgQVmX9VFPBEEpjitJFwdRTl6j5+lW2e3sYVQQZs9Z/25bqAIYrvf1wBZH/0vQGfQikWgvxLHZvW7AqukPfksePu7G2sywMWBGp4kBB8ySEvOT2LX4K/3JJJLIcBw2snCzsGGKoySeBq63NjPKvYkYdfllka2YrxD/7n0leXrqF2bOkaptRLUaFG9cBYmNqPN4E7iQ1zoaiunFN/QEJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(396003)(376002)(346002)(82960400001)(38100700002)(316002)(110136005)(54906003)(5660300002)(8936002)(8676002)(2906002)(66946007)(66556008)(66476007)(4326008)(186003)(41300700001)(83380400001)(6666004)(478600001)(6486002)(6506007)(9686003)(6512007)(86362001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vd8A6+prqua1SrmGPKZ7M7J3KQZRMQeNDMFvyJTD5SJYOS3OhqkWXZmmMGmb?=
 =?us-ascii?Q?zVIcrlyofMYSk7v/jC5I1Fi7Q1kzIhkDzk/4LA4oyn52ENqd+lGaaDRYmSf8?=
 =?us-ascii?Q?OEdh4y1Cqv/l84bG0WW+Cao9o2im6Xc76C+aCMUF8MDFo+NgZiC13w07C6d0?=
 =?us-ascii?Q?q4lEC9tmW/eU+bjSKHcPIJtWBqbMkohqJGGK10G4fChW4tHsT3LkuYQqgXtM?=
 =?us-ascii?Q?Hod5IbFt8PJkBl40uQUq5d9keBkmd9llc8pnkWRxn+tsySntxgdxI9AIVtM7?=
 =?us-ascii?Q?kHSIrbH9jq52q8BJh8Xc/qRkTMs/5iATYseeBUM7tn5Scak4/EPlIwXUMHz2?=
 =?us-ascii?Q?kdQnBQohVbwldn4+TGl7R8p2A2N3gIOSwT7xAAnkNdGAy+wu9aOOaFNtRavt?=
 =?us-ascii?Q?rp4MJHsH3LsIPMJ8JZDGEtzouvRtdEPSYxtTYIl/sVoSxOFho3LAGsPcsc2K?=
 =?us-ascii?Q?pYumyjT+DhovhkU65oQ/5Zdxycc1PG5g5A9fAtCzsFXmbCrY3lFIPP1wUCKi?=
 =?us-ascii?Q?tAVVGt+ecQDfZbAS6EKEXeG36wgoG7mgKpbFibmXFRsUAb3mcZDOAuRuCgID?=
 =?us-ascii?Q?kUDk0+wHN6qd8Qu54ad7UC4hGckhc0OJInDtysvOpizSnuNL4FlOkoktZ2LG?=
 =?us-ascii?Q?8p9ggMEMf+LeuBZgEIGmJK1K+Y/LjtLf4oPf/Hq54Fd7v4wmBrOm6k5gGK+w?=
 =?us-ascii?Q?/4WBQV/0wdcMHC3xkaeAgNaPBl0CQw8lkjyI11tYwK1Gm1CCYZivPMHtFPOc?=
 =?us-ascii?Q?R6QEn68/QdGv1F6EniAERgX+Mf2hE4w+LrrYKAIusuXAlNdoZr3JhEaEkbC7?=
 =?us-ascii?Q?cEgpERgreshv5Q+Bj8nyl96ebj5HFxMMBjsLBdeBi+H35PPhXY3mMVLD1dgl?=
 =?us-ascii?Q?enGzHMV5iW4J6HHj6fAL7DtcAoHXQExpBc879jkHzR7UQ7id4pAcq7+1/Hgj?=
 =?us-ascii?Q?6raprwssJQl38NwgEDzPZnGNyc2sqUkvI7DY2UDvKqFt52JWAdVP1fkMIGLO?=
 =?us-ascii?Q?3gHKCi8ty43k/Ms6flmWOxQipt2MU21kwehek/ibNlEw2Bm3ujYCIlP69ZYT?=
 =?us-ascii?Q?OlWouYii8Le+AjHVBArhUiypHDp6uz84B/H34Y+3nlyoSx4/WKm/2mYfMYsk?=
 =?us-ascii?Q?5JHrk39Vp7mH89EbmmO3CI4StKN48/YP/8PRbyiO/QnQQnKKdz5UPExBMWCO?=
 =?us-ascii?Q?uDsNuvDQ8kjSzxqutYq3GX8msBukwJUmcb5L+yXeB7xylWlWkHbTNDJfE8H8?=
 =?us-ascii?Q?FowXDsySY0ZNFfu5rwbrAZj+Mg8ghPB+5gWRo5IEwHAw1kpglqy6FSNeaQJl?=
 =?us-ascii?Q?be+tW5CDHEr7BEX068ZHthVX0YtuLrb2M80DQaB9RzaXWWQqzt93P4qfK7HC?=
 =?us-ascii?Q?bY71MPJnG2EWRLJs/Un7hFf1YLrucmE/ruS48FFarjG8oIfiJu9GMhcob/K+?=
 =?us-ascii?Q?68AbeQHMbF+6S5IwvVIz0hvqekttuaJFFiK8OLvNirbU9wVc3NF1ihVasjB5?=
 =?us-ascii?Q?1VtdEDpbbgGdIHzu2jiED69hZ57e/fo7D2Y/h00PLdhvKQBD5jG7hDKZq7Hg?=
 =?us-ascii?Q?G/uyqb9F/EXl6jd2KbC9JaVrQ7KRcTjVQr4Oq+uvunbxS75k76Rh2Xxb5X6l?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 147415d8-0f12-4733-6949-08da9160ee0e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:11:12.4093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XewxYPi0mOG4qL36+GYYuH5oh+nwdy9o5eVuOmod3yUt/iivCZqg/eNm6T9P8q2zgcYQPVxMY7e/jWL3+5qT0eWrC8vM52E8g20KjxrcdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> Restricted CXL device (RCD) mode (formerly CXL 1.1) uses a different
> enumeration scheme other than CXL VH (formerly CXL 2.0). In RCD mode a
> host/device (RCH-RCD) pair shows up as a legal PCIe hierarchy with an
> ACPI host bridge ("PNP0A08" or "ACPI0016" HID) and RCiEP connected to
> it with a description of the CXL device.
> 
> Add function cxl_restricted_host_probe() to probe RCD enumerated
> devices. The function implements a loop that detects all CXL capable
> ACPI PCI root bridges in the system (RCD mode only). The iterator
> function cxl_find_next_rch() is introduced to walk through all of the
> CXL hosts. The loop will then enable all CXL devices connected to the
> host. For now, only implement an empty loop with an iterator that
> returns all pci host bridges in the system.
> 
> The probe function is triggered by adding an own root device for RCHs.
> This is different to CXL VH where an ACPI "ACPI0017" root device
> exists. Its detection starts the CXL host detection. In RCD mode such
> a device does not necessarily exists, so solve this by creating a
> plain platform device that is not an ACPI device and is root only for
> RCHs.

These host bridges should be discovered by add_host_bridge_dport(), no?
Unless the BIOS is failing to emit the expected CEDT along with
ACPI0017.

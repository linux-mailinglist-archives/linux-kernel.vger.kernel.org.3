Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3E457569A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbiGNUuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240622AbiGNUu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:50:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999F16D55A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657831826; x=1689367826;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nNJfJ9TsAcAPTEKJojFJZvNnTJUKJEEpGI0mF/350sk=;
  b=P3VJ4QUoQlJtgUDm8NIdCWPH+NROwR0QVBPLgKi78JtaGNpE8JpRB83W
   YcojIV/eZdmZxCpBLtQBaA0I87woOqu0TcX01LEvyKmYTPiRB12MCaE3m
   RwHTzsQLnXy/sh9j95cRACarhhACHjqGgLAhrsBnUFzHnt707T3A/1Tpl
   X8ulJ+3cfXFz6NrTIl/RRgZQjJLBWm2OG6LtKytMmjd/9jaDicclScpNo
   3bKcP/LRVDHLRzp9AINX5gwVao6XDsypLQ2/WlMoQrl56vwhW/jUEqQj8
   nQFODbCia9GfOgT8pubnnZvc7jwQHTdZpYZQ2jlWf0vdVNbah9UmNX57v
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="283185030"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="283185030"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 13:50:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="663929385"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2022 13:50:26 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 13:50:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 13:50:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 13:50:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 13:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsjZIHPWkMDZnaG/xGYMijp4oWFUjW/X3zCrxKSIh7g0SHf6nf4KVBXeLH5PwJqk3pyt34iCP7c3UtYUhrzoH3pLSIidhPhe+qz3QkZdBoPGewji9/g3Chsb9KwQRzvX39rTbgc7T1x84sSLLj9oTI68qn0DtePxZoDvbqWSRfiDsp5f5xz5LSFbrui08eMx6Giwx8k8o4Ltxa1zwNLe8mM/cfSQzVsqIsjrIc16b1UMxu4Q7KjkOKMU+/ViOl/WZNyvmGQxHyDvRfp7UEL4jZasEqYU9pdQPDyLO+W8/8GvkrCsGk37wRk3VxUUazKapiQkPtH0uIyYuuqgIs+7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkGDfnQYfwPGvFizgOfz0+O7bAedJUQFaTK9gpqi2ic=;
 b=nut4FIXpzk+4bC8+JaYdrfz2paH/zFXPGwt6ybEORWKEO3X41tQAB3fH5zPMQQx1Bkz5U4YhS8QZnjdioUJHuJNZPCSssQ54iE2zLsa79DY1+gHkn9r/0p3nlEHcwAilyeP006l9KUssfpo9K09nV8s6MnzZqi3C8orCadbWazgUcCIeLwPYBu3pBDSBWa/RfdIhBXg6Ff1m8u+MilQNS0Sten3vR8/effHxBtFrW2T7BTrA5nfP6b5LgzCGdBzY2scHCq2QCxi9/pkoITkimIcTa6iUDUb10DlmwUNeumQcYVEE/wWq42hhmGUdBljjm1MaLuDqjtjqE64qfve3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN6PR11MB3280.namprd11.prod.outlook.com
 (2603:10b6:805:bb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Thu, 14 Jul
 2022 20:50:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 20:50:23 +0000
Date:   Thu, 14 Jul 2022 13:50:21 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v1 1/1] nvdimm/namespace: return uuid_null only once in
 nd_dev_to_uuid()
Message-ID: <62d0818dbc1bb_1643dc294e7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220607152525.33468-1-andriy.shevchenko@linux.intel.com>
 <62d05f453b73e_1643dc29412@dwillia2-xfh.jf.intel.com.notmuch>
 <YtBkOo2vME1jgU1C@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YtBkOo2vME1jgU1C@smile.fi.intel.com>
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4ac5b83-6a29-4f7b-1861-08da65da790e
X-MS-TrafficTypeDiagnostic: SN6PR11MB3280:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ye436tuM88vf5bI/VQkwoIorljAwr+lIz3+NyXRbXzfM3Jro9kXnBtjzSUIoEPeGnqLk5kjCyLqJXGDLFHAQ+al/e2OgVA+ulFYE522i7Nklt2YpoaqubgZPIVQ6KXKDJsGzw1Zt4hFlUWzAhuy1Jgxf60umU8EgjQWOa6k52N8OAzfWsCFrfXYpnSpz6COeurcA6yY7UTbCYn3uEm4/P0clu060BNXqCVpD8N5pnsm2WxvfRuS+9BpRz27WsVuHZyNYSDS6PL4pb4KDdB0oVbSrTRugxZsu+oy0XhWYBmRJthaENRL+VysMbtEZzF8+N+CNagQ6TLqavDzRyoZjI4ULbzStd1XyFjOvy3rVdqxUNfehNUDvXNS7wxbdwfwPBGGW6nk7kW+8HRpvf9832y6iFYwmSe+jc34qqgotMF75a64QUj1n8D7yWmJs8lgX0lzXWqqK+gl+7Vp9LsNrzMSx1p/G43eCa0HYNNfurWVRBXUAT1UVmL5YSeMOeDJjOr3Y2HF4DLjNqSiFe7PTM68LcUpisJV1usYfzuhQovIJQQPfMJVilygNPZVnBly6Z2InOgDHvNmDVL9ZBRMqr7ntavfH0I0eo1e+NZtYODZbe40mHe0LTzXH+dz04GyBc9nldP5fIPjty4R9NC1ExQNNCBzR/EmPynSBPy3vJzscqelewmTYeIwTmuHdw6S29pYJ5NNpUjCGZaZhf5MS8tpbrZPSzL5dqToNjFHouqxTqurVfUKzbpb3YPT6+hIXUj0j+sZl2xR8U9JhJrhGew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(39860400002)(396003)(376002)(366004)(4326008)(8676002)(54906003)(66556008)(66946007)(82960400001)(38100700002)(83380400001)(66476007)(5660300002)(110136005)(186003)(9686003)(26005)(8936002)(6512007)(478600001)(4744005)(316002)(2906002)(86362001)(6506007)(6486002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mtne75MnEN2CKNpsZzoFYJ/pw5rFdKsUpNHzT3MAXFnS0+oGJCQ8Xe4WDKhs?=
 =?us-ascii?Q?g9m5owUwN2LiTo9hiyQl31ztvD//5KOK3FrtskeCYutF/J4IAFVDAdXn+G0t?=
 =?us-ascii?Q?8luam36VrjZ9s/iCbj/Ytl/w0l19IObGmbgAJi9+g8mhiVcgTWl2FmcMHuU5?=
 =?us-ascii?Q?s1PGlklAA1QLxlX4Zt1N+FqFasbYaO762DT7XGnpS4FUnQo/4P5cgapgFvfq?=
 =?us-ascii?Q?mQXNdrj3qcaGxD8VBabRCJRNPCz4fFefJF47Y45Iub6Lt3d8aqxQexfx87uN?=
 =?us-ascii?Q?Og79oGW8ZnkZwFuwpybtZkD5K8G58tiwo7/4H6IGUSXlpAtXUpvq/CBu/+Mb?=
 =?us-ascii?Q?4l2rg8PbYtVw6kiwS5yGKNycpxzPO6cfi7gLzMM19blAzWFK2wndP7xPsXuO?=
 =?us-ascii?Q?60nfIWfVj2ZyKuCoHLPg/zXvPDL5cRjA++rhHoaUNx6C/K6QRjkA1k3Jm2Sa?=
 =?us-ascii?Q?GwW63gtUwSctpKAXPHw3IdnSLaIAGs9gwgf+cvyw4y9NY6VgA2hQckDG64nb?=
 =?us-ascii?Q?ho+/nO4BMhjq0NSr4tR6fGW6c8m94fVuPd/WQEuRNdBJWkZTLtYuvMXBsD8D?=
 =?us-ascii?Q?FpcgfDYL0kqzSMNIzsMOVtbJRWjMBgwu/a6Lk2361O0nAglJLZosr25FQ/Dx?=
 =?us-ascii?Q?djwIf1wucxhLcAnT341XwDaRdlk6bg5abf38+dZc6p4BJq261Mwn/dLvNjFI?=
 =?us-ascii?Q?LB6TtjZP7Vnh5YrIE/izNn4siuTKdislWGOavGd3Vg3ao9uzX3+bVEPd4cwt?=
 =?us-ascii?Q?OWrlIHKxU8433+E1t2dwcGqiXJL1jm4YHp4Ea14WP1ZyPtTteWWLQXoJV6rr?=
 =?us-ascii?Q?PcjalS7BmpsTUYzgGVi4YbnDABYYwDxY9lTj9GdXqTGS//VqytQYlwi9fq/R?=
 =?us-ascii?Q?fMGXK1xSFTfqETI9dpQjn9E5l9OSSIaks22zTxs0LvX8Era7G5JrWlrxUhmr?=
 =?us-ascii?Q?tl68m4AJETU4LSCwB1WbY97Q0uO++sIrxaXO01vfGDcyHkCP0mdelLnilMiY?=
 =?us-ascii?Q?76E+xugi8PATav4vjdM7WijFSbwB20tTyvszeXLCSmfnuVkDj/YUrZWcbMNP?=
 =?us-ascii?Q?VMpFiPg4nLlfpuo4LYoM8yEUXI+6KHRdhoTPbC+XQIp6N7IDWfxaLqcLSR7n?=
 =?us-ascii?Q?pKOCOmZgL4pmvoBkFc12/7CTD4Iyq8gNgUsUFgb/taAYOsUKc5QfZSeTMsxs?=
 =?us-ascii?Q?EoogPmKAojdMXvPyoJE/eSwWqoPrsXV9DMPwaNSelYHsX9RMi4ZRYdPYyFZ8?=
 =?us-ascii?Q?rQImCxEyJOwIXHNp9Ftw73V0Asfz1dCYpt1MyEEZaBoQZ1DcVoryn2Ppsd0h?=
 =?us-ascii?Q?ZxtqD6eeOTaZDW52deymD/yNEsbDGd7qTpoJUDz4aIfO/qJGywNKhsCS+WqE?=
 =?us-ascii?Q?t7sm29E5nC5k8qAK/nuLodOSU6agSBzPbVK/HcWel74GMty3iTIsXOFLyWSk?=
 =?us-ascii?Q?wpcvrlm6KoRByXjX6dktwIuD5dwFvbwgkAsTeRqdhqmEzt9pffXhgYcXWGFJ?=
 =?us-ascii?Q?9e25hMakMGhA38BA9bkHx6dNNCaVfJbs33EPCjZPKghrNMX7KiD/zJpHZvW1?=
 =?us-ascii?Q?ODqt44nRNKhU66xDQ8BCQWr3E6fM16qjubqkeUooR3xYpuXTaNQN3USaPpKJ?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ac5b83-6a29-4f7b-1861-08da65da790e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 20:50:23.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+z345Wwy8XaKpFmTt5SJpM5S3KZZe1DnBKAECCGdbpgPXdMZ9SmzUaO9uBiJUNgwc+4mJXzpfKMFX9hhsdHEeHx7A+LMgwpbw8aQSiU2a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3280
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

Andy Shevchenko wrote:
> On Thu, Jul 14, 2022 at 11:24:05AM -0700, Dan Williams wrote:
> > Andy Shevchenko wrote:
> > > Refactor nd_dev_to_uuid() in order to make code shorter and cleaner
> > > by joining conditions and hence returning uuid_null only once.
> > 
> > Apologies for the delay, applied for v5.20.
> 
> No problem and thanks!
> 
> P.S. One patch out of three is a fix, would be nice to have it in v5.19
> release.

Found it, applied it.

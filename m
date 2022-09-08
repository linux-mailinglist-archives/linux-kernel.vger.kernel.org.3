Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57DC5B2727
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiIHTvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIHTvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:51:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE87E7FBE;
        Thu,  8 Sep 2022 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662666698; x=1694202698;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=yy8nhUuVp7ZmF0HNQbKbbh8JbCyJ/q3vXJbnjJbWX6U=;
  b=KCEwkbcumVgdDx+Ga04uk2EVt0jxx4guEQeGDKGmnr6P8VKGKzxR9oTk
   bu2BpsGKGYFGu93R5l2UlOG+lLHR1+RFxoatNqPxkKoo0dv33s+wWQvPk
   lHVkkxYfSUQkBCCEE6o5XIsojeNFKVYLeA67zIdwnVk6RO2J7lcrOEXbM
   CvT8YaGyL1xqROutqyLvD0quYOzp9SpC7HAPiCOgdXif+CxVDLcEPrkMN
   aTLRnglcPAyaJrRnu73EEKziJItEIgKmJr67pIOt0paMaNRn37Dm8hzrC
   EnV8IN4WN5/rJsBJAWiKFHHN7u2Dy6Uifpfb8EO2mL792bnpNu1eEnO1C
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="294889412"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="294889412"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 12:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="648173111"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 08 Sep 2022 12:51:38 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 12:51:37 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 12:51:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 12:51:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 12:51:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqBU2c1l+OdooxKc+MTfZ/s1eWp/J7v/LCdisIpLc+z5xTQxldbgsghw4QASi3YVoqbpwoXdPQ6SmT9Mw77VFYmWIj50CfHXBhxga9/yohRwfA409+iAWRf33BOs6eDyJzB7tgariZjD0Ua1yYtRwifzsiKWwoO5NdmZkJJXzuaN2B4gr24dooAPKZ4fGMRCbbO/Y4KUIqrhZ/N9FMGqYaIrTP05XobYAfy5nJpeBBvlAzjxc8dZnRVPKC+MNeD7SgpumR0eyT3mLcJ5r14OAa1U7ahscRIbQPvJxSnw67RmaBEWF5XVnSkFF3/OwSdsLiXpv7FwSRnnF2BGsYDf2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ly7KbapvIf//umyn1559ozI/8/lo24HV/tA0HC+ok9g=;
 b=NYmpT3v/GwbNrCI6X0Z5MIWJX6pqEAl85YeI9/YKiY9/dmS7sKImMSX1gxpo0RPZbnvs0OX0xemC8OCmAz2ClXgZTP1w0IlLgPRS7Gr8mpEx5YxnKF+cbwbFUvNTPrXiulgKgkZhWYdYbe9Q9OnNz+k1FYkxpQSqU0QgMpKp7flY4tyPMenKSYW4UnEU02fZlCQ/VCgcUaRHZzZ/TDsx1IcbqSYyKv5ToRW+06r2wdiWOIMq9QaEZkJV+rI4Vlpt7qmKSjmttIuBI7CbYTi1UchmEIqE81mLX6/V3gfuHesmJWWgb5pFZZEna3NUOdEa1OOOIebw+FkhBpUjorjq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BYAPR11MB3221.namprd11.prod.outlook.com
 (2603:10b6:a03:1c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 19:51:15 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 19:51:15 +0000
Date:   Thu, 8 Sep 2022 12:51:12 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Jonathan Zhang (Infra)" <jonzhang@fb.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 00/15] cxl: Add support for Restricted CXL hosts (RCD
 mode)
Message-ID: <631a47b0326e_166f294a7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <631980ff90319_58016294cc@dwillia2-xfh.jf.intel.com.notmuch>
 <17F02AD3-D68A-4E6A-A549-A47611B335E7@fb.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17F02AD3-D68A-4E6A-A549-A47611B335E7@fb.com>
X-ClientProxiedBy: BY3PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:217::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fecc14e8-40aa-4c1d-ddfc-08da91d37d09
X-MS-TrafficTypeDiagnostic: BYAPR11MB3221:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5fkj2egDS+GfimKHb+CwlLwmFXxYdCFtcvDBKKf8bfRJI5NPx5K597tByp/DC9SM49RBOqO11FQ9STiMWjxG997yqByQ33bAtSjqVjS+4Ik1mxRzuJBIhdu0LNnBqWAGBynH+c3qH12ia6cseSRq/Rs9+h5FqWGj355hFe9O0S8Df348MTdWKMT6/1D0UEA4kbQmAZLfV7ZR7t88yw8qaGQj12AdohJNypDrrzKFp1tfEEhXaSF3Ztp2PhkaUy/HGy/IrSQcjebWx627ilxFq7dfWwHiPyI4Lf6yCeW0zpFuOoOozXEZ5NG/gqKqXxzg5vor5iaxVNqxLHu8e7dgb3qCdCfJBr9YQhME/CnccY+W6Znuz1eS6KC+jIehSnBdwrfVTeBK/3vROHBAmpmYJJt6qUu8OLB81gGEWSmb5hJ84BEn+532BX7vpZkadYO3nT1QO41/+Ex28ZrF7QoDD5dMJs4hA4k7glOtlnYBpeK4S6YWs2xu3gtCJE8fUWQpKSiIxUHRJEVhO5AS/7qSurSdj0iB1pnOaT9ZF8Z0roVWSBHtZ37Oq021BN9wAWekMGIkqZaSMf4xioVxgr4cVSUETiZFuqOKam+JR8WX5EBTkfqQLUwiRUGopQP7cBNYiuP578j3wDJfUVXLlHl/Yo7hC6216hANPy1OdNkJCo/CXEoFy9Cm4aIUdyg/fBYqXvdIpoIBC9CRb23daBP/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(366004)(396003)(346002)(39860400002)(66556008)(478600001)(83380400001)(66476007)(66946007)(6506007)(186003)(8676002)(6512007)(6666004)(53546011)(9686003)(5660300002)(2906002)(8936002)(86362001)(4326008)(6486002)(26005)(41300700001)(38100700002)(82960400001)(316002)(110136005)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDFkV0IyK2FmMmFLc1FnenIwenNqcDhlWlRUYkNpZUZJNituODdla21rVVBs?=
 =?utf-8?B?NXRqejZzemRaWnptalQ0TmFHRjFwWHplWU1qZVcxMWRZVkZFT0pEOEtXZjZn?=
 =?utf-8?B?OFpEbW4wVHV3S3RWOXQwdTBJT214ek01WisxQ3Npb1JZeityaHNOUmlVK0d3?=
 =?utf-8?B?VGdaSEFpUDFjZzJLTERyeG12QUcvSnc3UTdBNFlhQkRiUTJMVHJpVEtUTSs1?=
 =?utf-8?B?OUNvMytrb2xsRUd3MEJnejZ3TzdSNGxlZEF1dXFlNFhZQks4WGhOaHozRklP?=
 =?utf-8?B?dmZKbFROd3FaZUNCT25jSlBPNHA0WHJPZHYva0d6d0dUZGVTWkRFdlZpYlhh?=
 =?utf-8?B?UEtia3FqbDBJRkxoWk9hb2dLa0RacGYvc3BjVFdtbDBIYWxNUkxza3RYQ1ZP?=
 =?utf-8?B?TTQyVmNCaUxsUjg2TUJDU2hadHczT29DUzBWejFXQ2I1TFVrY0NYeVFjYkpP?=
 =?utf-8?B?UHBmZjdLZTBCTUhmNzJYbTFYUXdHTGhzakdPaWVTQlR5WFBYbnQ3SE1zV1FR?=
 =?utf-8?B?SXFSNWl4dnpISXFXeitydk51YmJvRHVTMXlPMlp3cXpvT0ZFa1d4azcvNDQr?=
 =?utf-8?B?a204NGlISXJGRUFrYmZ5WS9oMVFqSVZ0Y1FveEgvakU4Qy8zSVFxa1pPM1F0?=
 =?utf-8?B?SGUxZWR3WjhMSUx4M0dkckQ3WGRQNHN1UlF3QXV6a3B5MXdPWEdGNW1yVFA3?=
 =?utf-8?B?L2pOT0RiczA1V09tT0VWZ01VRGVvY2JWY1BCb3ZReS9EV3I4ekRoSXd6d0Ja?=
 =?utf-8?B?OEkzVmVCL2ZHYXJud1NsWmxpeGtiYUJjbjJKSktXRTNtY3BJZFZ4NnY2Y3pj?=
 =?utf-8?B?amN0a2RtRSsvcUpEZ0pQRTNBQXoxeFRRaVhqQVlwY0t0UTBXcXB0MUFyOUxS?=
 =?utf-8?B?S2RCbWVmZ2puK2FUVWdEaWtsV3ZvdisyNnNCT3ZIUVZOVm94Z2JCSnh4NXdw?=
 =?utf-8?B?RW5wTnpBL1krZHc5aitRT0lwaVVTdEpwMEh0bzV4WWs5NTRPN1FCUmlsWVRy?=
 =?utf-8?B?REdoaUZxdnlhNEVYZVZVdHJUSS90N2U4a1h0c3dPR080WEdCdjNSaWxiWmdX?=
 =?utf-8?B?cmNKZnlmWFlWbkNWN0g0NnZHT3psTGhVZFN0WmIzN2Jna2JhbXhMWjVHWWVP?=
 =?utf-8?B?aXdpdmhNY29PRkd5UThaWjBVYVloS0ZBS2tOdUVib01KS3NJa1hURDQ5QSs2?=
 =?utf-8?B?TG9laTgwMGFRMVVUQlpiNkhYSG1ScmRjNisrNHA5NmJEa09FaXNTMko0VFBa?=
 =?utf-8?B?RnFrQ3hxRnBHOEQ2U1VUSWd0TUJHTDh1TFIyam9LdVhCM0JRblJiMjc3WG9J?=
 =?utf-8?B?L0pzcmNUN2pVQWJ3NDZnM3E0dlY0cmI5eDkraTYvdE90SU1VNmc5azRWaG9w?=
 =?utf-8?B?enZoTHlLMnVWSE16eUFPc0t5TlRWRDBTRlFxdXo2UWNpbHp0clJtcnRjajZG?=
 =?utf-8?B?dldaQ2FkYmNNY0I5MnlsQmljd0Nhc0dxcEIveDVjSW0rSFhGck50dUhYOXpi?=
 =?utf-8?B?SnBBTzUwZGdPZDlic3cyMlZOaHAwcmFOdThHSjVISjl4TmUvdDFWRXZwc0E5?=
 =?utf-8?B?Q0xFSklqUkh5RFQyTmdqNmpPNkRJa2ZyTktDS3JBV1paTDhoQ2d1S1U5dW1w?=
 =?utf-8?B?NUhaRkJNbGFHajEvd2MrbXFrUlhBMGxFTlZWM1QwK1BBRDlnZHEyOUNSUHBW?=
 =?utf-8?B?RGFXU2RjQytIcXBuMzd2bFhyOGhlVm9lbURHMDM4TzJuN2Y3WjhlZVEzSkw1?=
 =?utf-8?B?VmZWRUR1Yklvek1XNFpnUUQrN3RwSE9TdFI0em9IalFMVEpHMkl1cTFBWCtv?=
 =?utf-8?B?OFQ0ZDNNZVpyQnhsSGxoTWN6d0FETUNxVm1rLzEwTEFCeXVkZUVsc0NYZHE0?=
 =?utf-8?B?MDI4dTJyZFJXcytRWWNBVnhUTDBYcVAzY2gyOGNIZFlWUlJodlk0OTE3bFYx?=
 =?utf-8?B?TWhHQjh0WnQyTGdaRWI3RzlmZWdhejhabzltenZKaEE3QjMvN2lNRjVQa3VK?=
 =?utf-8?B?RHFCSDJCRThodGxGQWllTHoraGhXeFhjRHZhSVhGMVBmZ09XS1lyUU4xUmhz?=
 =?utf-8?B?RHQ0WTJ0TlZyUytJUSt5dmJjSWl2MFR0RkEwVTllR01tcG9DRlRleFhwN0Za?=
 =?utf-8?B?LzJOd3E3OUF4bmFnb0JmcDY4ZWpBcEd1bFg3aHVra1FkN1pwYzAvenF3eHBL?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fecc14e8-40aa-4c1d-ddfc-08da91d37d09
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:51:14.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDTHOk9h86q3BpT2QGtOCt7551GSJI7lGR9ZwCcUWxCORS34J91eMYbRCA1AAlzl/wtzw6of0PB3Dp38NGYa1Htla+Ncb5234MoovNHu35M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3221
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Zhang (Infra) wrote:
> 
> 
> > On Sep 7, 2022, at 10:43 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > Apologies for the delay in getting to this I had hoped to be able to
> > finish up some other DAX work to focus on this, but time is getting
> > short so I will need to do both in parallel.
> > 
> > Robert Richter wrote:
> >> In Restricted CXL Device (RCD) mode (formerly referred to as CXL 1.1)
> >> the PCIe enumeration hierarchy is different from CXL VH Enumeration
> >> (formerly referred to as 2.0, for both modes see CXL spec 3.0: 9.11
> >> and 9.12, [1]). This series adds support for RCD mode. It implements
> >> the detection of Restricted CXL Hosts (RCHs) and its corresponding
> >> Restricted CXL Devices (RCDs). It does the necessary enumeration of
> >> ports and connects the endpoints. With all the plumbing an RCH/RCD
> >> pair is registered at the Linux CXL bus and becomes visible in sysfs
> >> in the same way as CXL VH hosts and devices do already. RCDs are
> >> brought up as CXL endpoints and bound to subsequent drivers such as
> >> cxl_mem.
> >> 
> >> For CXL VH the host driver (cxl_acpi) starts host bridge discovery
> >> once the ACPI0017 CXL root device is detected and then searches for
> >> ACPI0016 host bridges to enable CXL. In RCD mode an ACPI0017 device
> >> might not necessarily exist 
> > 
> > That's a broken BIOS as far as I can see. No ACPI0017 == no OS CXL
> > services and the CXL aspects of the device need to be 100% managed by
> > the BIOS. You can still run the cxl_pci driver in that case for mailbox
> > operation, but error handling must be firmware-first without ACPI0017.
> Firmware-first or OS-first applies to CXL protocol error handling. For CXL 
> memory error handling, the device generates a DRAM error record, the OS
> parses such record and act accordingly. According to CXL spec (section
> 8.2.9.2.1.2 DRAM Event Record), DPA but not HPA is in such record. The OS
> needs to translate such DPA into HPA to act on. I am taking this as an example
> to show that OS CXL services is needed.
> Instead of using ACPI0016 to tell whether the system is under RCH mode,
> I suppose one way is to check “CXL version” field of CHBS structure in CEDT?

Unless the OS has negotiated CXL _OSC the BIOS owns the event retrieval
and translating it from DPA to HPA. I do want to add OS CXL services to
Linux, but only in the case when the BIOS is actively enabling OS native
address translation which includes populating ACPI0017, CFMWS, and
devices with the HDM decoder capability registers instead of DVSEC range
registers. Everything else is early-gen CXL that is 100% BIOS supported,
similar to DDR where a driver is not expected.

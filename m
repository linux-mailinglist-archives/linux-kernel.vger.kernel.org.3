Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE62C5B2825
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiIHVKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiIHVKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:10:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335E99C8D7;
        Thu,  8 Sep 2022 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662671407; x=1694207407;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=g/CbhaOLe8aEv7NN64ozOrs/O+fqr9yAOTeuHeOT0cA=;
  b=Ywyb2cWX6y71froUdvlvf0sA3vvz04v+DX184ufBQET4lFoCOYHU7qxY
   LW39cm03nVn5KtJIK0RhsrjY6USPgYCCkFwk8Xc1jM6GVoVFpi/M0mlQ3
   f4E68o1IBAhAzM8zvMjq4fH1cwtgsjq0QsFmxKOZPJ3MVrU3iCAU213hu
   5RQkB7difzWbadkYpxyV40MrRojtYc2b8q09v5B8AQe/OuYFkHvieXUuS
   5JH63bJoL5N66kfnMdRV6uZC3tdKbpU2ydn057ToglvEGESwwXnxKYMzl
   hR6w8cZE70BRf+deAaOszj+m36UDkt3bS/6r3DbD+nMslpSQGolwieIqK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298128931"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="298128931"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 14:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="645263858"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2022 14:10:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 14:10:05 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 14:10:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 14:10:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 14:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xx0ikZfz/zWUTj2ge6F91alUCKyxcN6RSZDhwU9N3JaJnXTzDyc3KbfwpJzIDnB83onZuRaEipmpHvjudLShYGxA0TGpqKLDznFbx6hW0VCMM0W7x8KizphsYlGOhMrW6yhPwSNWmvmf9Yk3TbdcVst5r0/2tdtkYEOFgsPrit8G3X3aVOQFLqXUG5NlqYpNVciScNgpEoN++UOPJdZjTK0IDkPrqrZByivkJNRviQi428laLcvYHkM1+DRU7gRXBjhvaafpV+radyFdwPcwwf+KT7fmymaNLYyQ5pJ2gDBnlZIr9XHxRzfoopNZerOzU+w4YrLbSayfBfeoBO5u0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9ljj5Km5aKj3zhvsiK1dw1IqKmgnoZiATLFqhawPhU=;
 b=NL7/zLC5w2wSdDSZKUGLjNaz4WX4Nq58cW+Hm5oAIKfzE0mrXPn1/KCJrW7c9S2XmijroDLlnLpCqNVvSegpKqh6mfOc8N0/X577pFKOKTJzrpCjAEjCIwwcCmBCMy1NC4xrDUZb7jDQE/kYfeCXHX4B5A+ndbthm/kxGzPYLeUoyfFL/rz8hAgvvQFOIM01lkq4l/PH7OC3/rvlrTmIes2wOWgris1Y56zHoNJo7d0a3QPieNjXAxU+F4m1sAyZ6rxeV8BJTZn95VLO+dHst38iRsTrbQRFMpvrGQfoojJD/Wl+OeAQa18nxG9l8IIHkDunTOiHS/QBrQylRHVtdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS7PR11MB5968.namprd11.prod.outlook.com
 (2603:10b6:8:73::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Thu, 8 Sep
 2022 21:10:02 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 21:10:02 +0000
Date:   Thu, 8 Sep 2022 14:10:00 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Jonathan Zhang (Infra)" <jonzhang@fb.com>,
        Robert Richter <rrichter@amd.com>
CC:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 09/15] cxl/acpi: Determine PCI host bridge's ACPI UID
Message-ID: <631a5a27f22ac_166f29479@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-10-rrichter@amd.com>
 <DE840F3C-0CBA-49A5-B9B9-9D279FFAAFFA@fb.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DE840F3C-0CBA-49A5-B9B9-9D279FFAAFFA@fb.com>
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8acf2880-cd4f-401d-a233-08da91de7ecf
X-MS-TrafficTypeDiagnostic: DS7PR11MB5968:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AkM3BEinhY8pcXZeBVU2CvgA2Rlnu4t4ytmtf1gpOabZe4Rdw4214N4ZMKmOYnnCq3DtVpA5FMwkJU7NJRys680ZZ6Ay0oJDv+Uyi8Ff48UBnBGPTi7HUpCgg/3zMC73LpAESsRsdyMGNndDqaIKc/8Dz0ppSQZ/szyyxviwfSjIvj6W0m+CdDPMg9vt4FlHkvUDUYrJAUjs60OHFBQ94+caFJ6E4pz7CDV3AO2qPycT+YYDPziWhj3PviR6qk2uC9OosME+WbXpDA4yYpatmdNBxrIMphLm3LSQ/FordBJPfVNQDkQCptrn170o6kY45VDfbIGLypMIHxhayPDI7hAVSQ+/bQl5UnP30lSeoK4dOxE1OAnfu43T+XpZi+ldy0e1AfjWPt5T0OwjYd/Yvuv3GKRhxQi5PoFdkxPfqGX3uBGr9mnaEXGfbLA1rPTkHHkgI5LhCldl6gt6dOrcG7HDxaVGGdUTeSRiCwsdOQFYWlw2Fx/geZ1y862vd7rd/3iBCgsf0CfFlTYCookXCPafhCbTgs0cksAnxrlqjyT9rj4im0wJkf5NNBQG2Ne/WlaJaFV35h186bA0EkGn0ojJdIqzQaKxQoPNTIoHoksveLA2gGtgPpXzFh2rpCYW5BsV11qlOSO3ta2i3pEGjPrnf7eK/L1bPQV7UmcmVF/UxMHY4+8cVGKaHw2HuZv4C0MpDNbRHlIbJW984hrRgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(366004)(136003)(39860400002)(376002)(6486002)(82960400001)(5660300002)(41300700001)(8936002)(8676002)(186003)(478600001)(4326008)(66556008)(66476007)(86362001)(2906002)(6506007)(6512007)(26005)(53546011)(9686003)(38100700002)(110136005)(316002)(54906003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDJ2dDVhY3FJRzRFcFpXOHlPdGJHZU5rQVJVTi9SSHhiUXpuWEJubGk2UUlu?=
 =?utf-8?B?b202NXJ6ZjRpSUFVODRxUTR2bytyRHUyYTBxZVFpb3l3TzdFaUQ3dE5TMXR2?=
 =?utf-8?B?Sy9ZeHFMU1N5QmF5V0tSMjlxSXB6QnNDdEZzREFSelBud0l3WDdTOTEwaS9n?=
 =?utf-8?B?L1RlYnJLeldIbWlxNE9sK25FZVZseHhKTkl5S2FWaU1za1F1OFE5RmdxSEIy?=
 =?utf-8?B?SFpwUXNWVTFJc1RKaVIzaWE5ZncvNUIrL2JXaHpYYXJkV2Z2WjBtRGE3UVk4?=
 =?utf-8?B?RlRpdjJZUGZWK3VvOVFFSEFxRDM1dmMwR1I4dXhtdDZlSlhDL0NzQTI3cHNt?=
 =?utf-8?B?SzBRZDVldndxelY5eFhHZ3BoVVhSRW1qVlltcDdHL0pUdXV2R09VTWZYbEVy?=
 =?utf-8?B?VDZ2RkNkaHZYSUg1L3VQV29HazhscldBa2RqcXZCOG83eFhiQUM5djhqb2JF?=
 =?utf-8?B?WEFJUWtMOEs5dlFlVGFFdjMzUW9mbEt0bUx4OVZmdGxqU1dKTFY5MHNtMnp0?=
 =?utf-8?B?YlM4RE01c01xR0hPUVJJOHN1Rmsva3pOQVpJT3FJL0h4NERJTGYrVWFwaGk1?=
 =?utf-8?B?QndmSjNYQjNRa3RIT0Q5MWtJM0Z4NnJCZXczNTdvRUhzR0tEQllMQU85QUVn?=
 =?utf-8?B?OVFscFdZR2x3UEhzRjRDalpqMng1VkY4WnBoZGZvdUVmd1owaVNQVEYvMy8v?=
 =?utf-8?B?OCtQaVF5WVhpNk1UMXdWcTZzTW1HbzB0S3FtMS9rMks3U2VlSUFGTFV6Tkh1?=
 =?utf-8?B?a1B2NXlqZ204WnBGbWR5MkgvaW1LOExHTk5GaURDVlJlSGl4a0poQksvSVd6?=
 =?utf-8?B?OGorY1I5SzRTdzQrbGUzYitWVm1OWm9ONlhZdUdFbU1aTzNxeG95bmxyNXNO?=
 =?utf-8?B?OGRkeDcxQTlWU1dhME1Wd2ZLalIrQ29RU1dwdW9RYmZKM0JlUXJKV3AxYXVh?=
 =?utf-8?B?SzVPQUgwekNHSi9RbFc3WGUrM25BQzMvT0wwSWF2bHIwR1ZmNWNIdGZzaXpp?=
 =?utf-8?B?YkNudkdSdURRK3lydmx6S29EOCtDNDNTMXEvTnNqVVNOcXBDbmVLcTg4YkdC?=
 =?utf-8?B?L2k5Snd4cFU2SkkxRTZaSVFpTHZSNzRIN0tSQWFBeHl6L2o0anF3aDVld0Ew?=
 =?utf-8?B?cHhIcXNLM282QWYzVi92b0lxL01iQ1NmdE9WNXJSY2o1TnU5SDBVVlBzS21N?=
 =?utf-8?B?K1pldWF0ZER1ZFNnL1V0a3lmMk44bnNXM0l3amttWDJTZC9kUzNZODl0V3RM?=
 =?utf-8?B?MkFVeXlQei9QTlpyOWJ4WU1Ld0hlYzNPb0haWlpMdU1NOVJwRnhNK1JTbGhr?=
 =?utf-8?B?SHEwOWR3UTh4bURxUXkxdXRDWE9OU2U0SjN4TXFqZ2NwQzhIVmcwYSszZ1JR?=
 =?utf-8?B?azlMQW1zNGdCYmRVcnpUbUM3dGxRQVZrd3Y2cVU1SnZ3MUZQbnVscXp2dVhM?=
 =?utf-8?B?VWhTc0lEL25ETzlBRHV3R2V4MHdpUW1qN2dXNUVlZmJHYnZsdmZGK2lxdjF5?=
 =?utf-8?B?ZGJocnpsM0psc3p6eHVqRWJ0VHVVK0p3U2dBTURtQ05wQkJLUStyajJCRlhs?=
 =?utf-8?B?SDVGb2JVQk8xY2lvbzlYdHFzUlQ5aE5GU0hhL2hQbXVkQmxsa3luVGhEMGZV?=
 =?utf-8?B?Nmc4WnRkZVhmNzZoS0I2dE44VjhjZFBjVVFjRnE3RWlKVjd2QUlzUUdid3hL?=
 =?utf-8?B?NExLMzJxYkgxbjFNYWt6UTJReEpTMHVQRVNIRnU2WERSbGltNUVzUnhseEU0?=
 =?utf-8?B?eHdZREpqUzNEd284Z1RieDhaeTJra2pGK1B6TTNRTmFxdCtBMXU4em13cmNS?=
 =?utf-8?B?SGxHTWxkc1FrNzROWlgrSmZDZitUd0dLOHlnc1BRaXhNSjBjTEJYeDZRUlhC?=
 =?utf-8?B?MVZqdzFqQW5BbnJnYUtlT0RVaENNbE9yVDFZZVpBY1lLUFdUSzFickFvMXpN?=
 =?utf-8?B?MDFuVmVLYVF6V0ZYTlhDSXJ2bFdSOUxBOFBUWGNRQ2dRaHU4YkQ0cGs0cEhp?=
 =?utf-8?B?b1hnOWY4b1pBSlY0UnNTMDNtcnUzLzRrZnhsbk1LWFNQdysxY3hSL3hSQXNt?=
 =?utf-8?B?QXM1OEVYVWZpSWpYS1BDSlloY01tSWlDalQ1NnRpelMrNmRwTWYwN25GYVUx?=
 =?utf-8?B?azNadnhwWUFyMVdQNE1wcDNhOStxRnV4cVhZbko0cVQ2S3ZjbTdHMlM0Tkc5?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acf2880-cd4f-401d-a233-08da91de7ecf
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 21:10:02.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aojSmEG52rh1j2b0OQi0BXrN4zRxgiTRB5SSYhYcdzr8zD8ZEqGBG/GjyUOcevQxkknqYYkdODuoI3xa3shJbzqmzETELtC2m6zGr1JZ258=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
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

Jonathan Zhang (Infra) wrote:
> 
> 
> > On Aug 31, 2022, at 1:15 AM, Robert Richter <rrichter@amd.com> wrote:
> > 
> > The UID is needed to read the RCH's CEDT entry with the RCRB base
> > address. Determine the host's UID from its ACPI fw node.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> > drivers/cxl/acpi.c | 12 ++++++++++++
> > 1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index f9cdf23a91a8..b3146b7ae922 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -368,8 +368,20 @@ struct pci_host_bridge *cxl_find_next_rch(struct pci_host_bridge *host)
> > static int __init cxl_restricted_host_probe(struct platform_device *pdev)
> > {
> > 	struct pci_host_bridge *host = NULL;
> > +	struct acpi_device *adev;
> > +	unsigned long long uid = ~0;
> > 
> > 	while ((host = cxl_find_next_rch(host)) != NULL) {
> > +		adev = ACPI_COMPANION(&host->dev);
> > +		if (!adev || !adev->pnp.unique_id ||
> > +			(kstrtoull(adev->pnp.unique_id, 10, &uid) < 0))
> The UID field holds 4 bytes of ASCII characters. kstrtoull() would fail
> if the UID field has value such as ‘CX03’.

The UID field is not 4 ASCII characters.

We went through this before in the original code in
drivers/cxl/acpi.c::add_host_bridge_dport().

The CEDT.CHBS defines _UID as an integer so use acpi_evaluate_integer()
to retrieve the UID to perform the comparison. I thought there was an
errata filed to clarify this, but it seems the current spec still just
says "value". The CFMWS also places _UID values in the target list,
those are also handled as integers.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB0D4DB77A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355905AbiCPRlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbiCPRlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:41:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AAC6AA7E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647452392; x=1678988392;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qsDioldhRtRP/xXGWhXCC7ZIBBv/VgFpJId0K9Yempc=;
  b=bvlg0MFnW62h7ZcHWjwAOKEdXStLu5YIa7EBDlirg6LQY9OSm6jeUa/c
   vP96TLPPYZqU0XXyb2871blbLN7DqR7bbOLHjENmjgIfkRMnlpwKQCHmi
   /YP8h4/NpKP+Gf0fqS34QgAhdKlumgE2d1xve6sRdJdMvIJ38Asovy+nw
   Z9mCcOc6PQAoRS1DCbxnCljjvox66Jylh46iSfGyUEdzjtMfIpQL7osmd
   H3r+5sHgV+ViJXHlfYMe9mL5Sv+d2+GRAHIqsdLSCABwHkP4WlVRFHGi4
   bxyYP2vjpTJAsySpzcwKQ3FVy2a5fv0avE6r85zwuBSlkyRi1lhCunUNe
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236619644"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="236619644"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 10:39:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="613730788"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 16 Mar 2022 10:39:50 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 10:39:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 16 Mar 2022 10:39:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 16 Mar 2022 10:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KF98mMUxnHCz67dMy/ELATaSUsHJMVXGWIScgH6SPnhPLtW9+LPk2ysI4zHLDqbtNoTRQAuSf/jjEGPFaymMWsViYxZIvyqkCjiYnm5hhCZaDM+zCWtfsF8v43okYR4SMASBOm4xidFuEAgpGFrO7uSr527xuTqNE1atXudqs3G/JPYE41KqLR6+P8zHhLNnR6L2sbkdbtI01nKCqz8BT6hVxuIVrNOBZm37/pDfbUA76KEEQal0wRveVZSN0sOK5lZJ66tfrRDZ2PNPL0wi3NB735EqbGIFDQpdEqM6zWdnT4o/C9lMp9xfEReAzPGwKWI4BBTmaoPW4di6s/4aIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApnErPlyemNeHHJCo2fowfgHjumd2XaEwKe2WiK3ddg=;
 b=QMEWYl5wA2uoxtcEEVJ1NN3idRWQ+mxOmbWZU4nS3mTefAqPLyMZJpIc+jVZXFkUAcs34JEZWAVwFOH3gpi0GwEWDv0fRd/Qml+Xd51dcHcLzoyUWahjYEqnsdMOYYXiu5uMbd5hDluXfPFiuAhRGwV6+y5hUH02LSNdfD3pTHbxoDeSw7R54TB3izb/8z5zdBgAmyzEEiXZ6Nu+zBd+H2i9SXp87wBrIWJGJVHDV6ZIZ05DXmulks0y5W7hTkEZ+CcedKDJm4csBQ/jyJQNseZAJ/iY5U5SpY/4FxwykZ5neHX5fcdtFoaPgUPF5tJG+89eu+o8xxuk5OOuRtk1Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by PH7PR11MB6030.namprd11.prod.outlook.com (2603:10b6:510:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 17:39:42 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::c94c:fd5d:2e7f:251d]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::c94c:fd5d:2e7f:251d%12]) with mapi id 15.20.5061.028; Wed, 16 Mar
 2022 17:39:42 +0000
Message-ID: <3840315e-9f78-91a4-cdcd-9bd103c1d144@intel.com>
Date:   Wed, 16 Mar 2022 10:39:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v1 0/8] Extend FW framework for user FW uploads
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
CC:     <mcgrof@kernel.org>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        <trix@redhat.com>, <lgoncalv@redhat.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>, <basheer.ahmed.muddebihal@intel.com>,
        <tianfei.zhang@intel.com>
References: <20220308214932.24477-1-russell.h.weight@intel.com>
 <20220316033206.GA123354@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220316033206.GA123354@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:300:4b::11) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2333413-eb20-4087-f7c6-08da0773f420
X-MS-TrafficTypeDiagnostic: PH7PR11MB6030:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <PH7PR11MB6030537903317AE23B369C01C5119@PH7PR11MB6030.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hylUFdQ5VBHH9zICje7tbo1al1XgBu9dciSL200lvRVKS8nW24QgITgwlTN3omAvqKDyNR/2biHc9EGXnfYXQ2jbOEcSrdgBtdzDl4GiT7DvD+dMFeyoGogC410zZw1LuVGy0fu3AG8xwDxdmqAEXFbsTtChwvaZRKFthLop0+4DO5c41Ju7zGDGll8PGOGtiX0YbRbsTQmBlkL0FM3G9BAStQbdmLMe0lmCNWIBMhyvq8ktcv/SbSc8Gm34Kz2Y4TApdj1LzYyvDkTyd8duKWm4KtN1g9HyHLoX3AVnwVD8j1Lr//nAQSHcBzxAzgZYGIWVDAspTtY78bfLxonlRFS9wllC9NAKgAWzyu4xE4ANZ+SRSuG4w/IjhhRf8+j21aWSHOksVzloR7tNnEH9o4eAvaWClA595hNDR5g3S3byRMfuFu3bq4YVxVVsyIHlc8lohtvG1sWXIZEFp1eUU+REaHCKiv8LCXVfRQaeD/7/7nIXa1FJZCqpqA+1IrhmyNKl4wwTdSaV1wfwdIyIqTwSFiUVhRc5vG7hAYrA+eQoCHcVJPQeLcnlr6bESfQZki9Mkx+mg3k96TTZ9xmZK0u6jJ4RGgEJcchURiJDtbaB2qcK67ZOsMbjEVP5r7ygpEEEO7Q2/fwa1sxCk+RrxU/ehTvf/mZvlr8nlJvwvsTdCLTfhzzpqqig5mTPt7yO9bJ1rSFhWv6Gyz11GH9mq7ovCyZsUu5+1qUp4H1BZCUVMnZEFGsIpnQarQADQRtj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(36756003)(83380400001)(31686004)(2616005)(186003)(107886003)(26005)(8936002)(5660300002)(38100700002)(6636002)(37006003)(66556008)(66946007)(508600001)(86362001)(6512007)(82960400001)(316002)(31696002)(6506007)(53546011)(6666004)(66476007)(6862004)(8676002)(4326008)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elZhVkNlcWxhN3dwaWtVeVd4ZFVNSE5LVTN6RXVrUWVXeVY4QVRUYVg4Q3Y1?=
 =?utf-8?B?MEhyVmhjbTM5NWJoTnhidk1LNFE0QTluRDR0dDRYTzVmTnRUdmprT0Vsemp5?=
 =?utf-8?B?Y3dubDBoRzE1dExza2ZjN1I4dUE4MTM2SVhWNDQ0M0FQUXVTbGorS0xFSU4x?=
 =?utf-8?B?OEVNYVlzQm1LUEJXU1ZaWEZaU0YyNHRTL2pnRGNkbmJEanBuZ3M3cENaVFlU?=
 =?utf-8?B?cXJpL1hIc0lrTTRmTWw5Mnh6MThXblhFRGdHMVBtSGlQVlZxV2F3M1pKSi84?=
 =?utf-8?B?UVNibWh5aTVLRjBGZmZ6LytOam5TSW9lNC9zUmJDSjJCaFZFNnBXbmtTMjhP?=
 =?utf-8?B?Z2trM0JKcVNEbWs5bkE2UkJVbkpYWUZucDJrY3g0cGlXTHBsNExzL2c1V1By?=
 =?utf-8?B?bWlUVnhKUkZiQitYMDJ5K0dFbUd1TjUvMHlwaHhUejNFUkdXU2h5YTdtN0Qz?=
 =?utf-8?B?SVZicWNRQWx3dS84V014RVRacksvNzE4dFU4UUdJUnlQcUlzWEFnRU1YTStL?=
 =?utf-8?B?aUY0RXdjL2lOU1VUekMxMGdta2hid29IK29kNHkrVFA2cXlxTFlGVzB5c1VQ?=
 =?utf-8?B?cytNZlBBaFBVMkp1dnJHVkNzSzJPclRqemc3dzA4NW9LdUdTOWtGSEhoSVFa?=
 =?utf-8?B?dTBUOENsQk1xME4zWlEzdWozci9lT0RBK2pqNGNOd1BsYVE5TmdiZ25BTE1k?=
 =?utf-8?B?aFdQUzBrU3dXTlVjcWJiVDJZMzBRd2ZYVDBrMzlLTVhiM0JTcEtjb0VnMWdp?=
 =?utf-8?B?RERaSkRmSDdGcEdKVDkxb09WaU5CZzg1bVlXTVRmZkpYdnJNYXFHQkhtemx4?=
 =?utf-8?B?dEgvd3lnRmtLRzBiY1RVKzRlVVF5OG5qNVdSME5YVVpZZU9pazZ4eEoxbmRl?=
 =?utf-8?B?cmticHJyU080VGhMS0dLaWZHM21vSHB2RnNuRW9ZMnlZbG5DVzhYUFZvVzBI?=
 =?utf-8?B?Yk0xMDhMektpS082YzAwc2Vyb3AzY3dKYzBFdVdkZmtqTjBuVGV5bVYvNUpH?=
 =?utf-8?B?dXpwNG5nbVUwaEhvMGw1UHpneTgvakE4YzdLSnI0czlRcXlkU3QrYTdWc1Fu?=
 =?utf-8?B?RWNYYXlrM1ljY2I0dTlVVW0wUEN4cXZPZ1gyQmxpWDVpcVdxWFdmQzR6S0cr?=
 =?utf-8?B?QVowMVZZWEsxdmp1S084bmV1c1ZMZjg1a1VWQ3MrWUk4WUlDRy9Yd3U2M25Y?=
 =?utf-8?B?Y2lyZnhTelhLKzhCZ3VvUlU1NFQvMmxKQmlURndZSDVPV2gwemhkaitYcVdm?=
 =?utf-8?B?TmxnS2VmQkh6elYrKy9ValNpQVFRMExDZnUydGxkaW5Cd0NCWUtpWlp2SFNU?=
 =?utf-8?B?djVvWWFSdW9nbHRqSGsyNmZzbllxeEFoUlZqd21OaW1LL1hMUHQ0N2hsd1ZK?=
 =?utf-8?B?V2F0OVdGZytoY1RqbDYrQnF3dSs5aUZRYnFQN0swMlZpUnp1NlJlNk5pSmg2?=
 =?utf-8?B?R0MzcUZ3VnJ0QlAyV0JBdmdMTndGQ0hNeUo4M3pUMXV0YlM3K2YxWnB1WTBm?=
 =?utf-8?B?RFJFL2czNnhycXBrNTZhclBMV1Q3amRXQ0hhZkZ5ZmFBRUhGUkU2eGFjNHRt?=
 =?utf-8?B?UmN2RmgydS9ZOEJ6YmkvSnY2RGhGdWVtem9tQXpMakFWNjFybFl2U2V6ajhz?=
 =?utf-8?B?ZGpTOFV0em4rN0krMzJGUG5WNmJFamZRS3RraGt4V05CWFBBdjMxUnRxSUpw?=
 =?utf-8?B?WHpvOFBmZW9HMThjVEFDNjljcVB4cDNaOXR3bUJOSitqM0lGMkduV1FGWVpB?=
 =?utf-8?B?MVFYS2FJZTZVeXlXWlp5V05Ka25oWjhPVlRST2lMbEI5RW9DRzVxTmhBMzV0?=
 =?utf-8?B?d0xwRlRhSGtZZHRPd1pLMVdDUlRIMDUveVF3VFVzeTc0WSsyZlVLZzNncWpF?=
 =?utf-8?B?UndTcEtuQytHSm8xUi9EODVZYnJGL0lXUTJCOTkwRXRDT0xOQ2xoTHRoT1FH?=
 =?utf-8?B?ZWhMM2d0MlBvc3VhV0tvL2tMa0FUQTBmT25VNTNpNlo1RWtBZ28xMWlTM29L?=
 =?utf-8?B?UlE1SjVWVnFRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2333413-eb20-4087-f7c6-08da0773f420
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 17:39:42.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uI7wym8mWKpth5wAf5Jj6S2YzxvH+WJ/DPsTJDpQgKywDas9+5lhJYtmYt+Zm2yEi6+Im19ZLSyfMIPfqhUtv8p2hBxRZzerVJMNZToD7bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6030
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/22 20:32, Xu Yilun wrote:
> On Tue, Mar 08, 2022 at 01:49:24PM -0800, Russ Weight wrote:
>> Extend the firmware loader subsystem to support a persistent sysfs
>> interface that userspace may use to initiate a firmware update. For
>> example, FPGA based PCIe cards automatically load firmware and FPGA images
>> from local FLASH when the card boots. The images in FLASH may be updated
>> with new images that are uploaded by the user.
>>
>> A device driver may call firmware_upload_register() to expose persistent
>> "loading" and "data" sysfs files at /sys/class/firmare/<NAME>/*. These
>> files are used in the same way as the fallback sysfs "loading" and "data"
>> files. However, when 0 is written to "loading" to complete the write of
>> firmware data, the data is also transferred to the lower-level driver
>> using pre-registered call-back functions. The data transfer is done in
>> the context of a kernel worker thread.
>>
>> Additional sysfs nodes are added in the same location as "loading" and
>> "data" to monitor the transfer of the image data to the device using
>> callback functions provided by the lower-level device driver and to allow
>> the data transfer to be cancelled.
>>
>> Example usage:
>>
>> $ pwd
>> /sys/class/firmware/n3000bmc-sec-update.8
> I'm good with the firmware update API, but have concern about the
> example.
>
> The n3000 bmc secure update engine is the sub device on N3000 PCIe based
> FPGA card, it could be a data xfer engine which helps to update the
> firmware of the N3000. The N3000 PCI driver knows how the firmware
> uploading affects the card.
>
> So maybe the N3000 PCI driver should register the firmware upload. But
> of course it could interact with the n3000bmc-sec-update driver for
> specific firmware upload ops.
Until now, these interfaces (for the firmware-loader) have been created
(i.e. registered) at a granularity of one interface per firmware file (e.g.
/sys/class/firmware/my-firmware-file.bin/). For secure updates, the files
are self describing, so a single interface is sufficient for various
payloads. It sounds like you are suggesting a coarser granularity that
would allow other firmware files (separate from the secure update driver)
to share a single interface for a PCI card?

- Russ
>
> Thanks,
> Yilun
>
>> $ ls
>> cancel  device  loading  remaining_size  subsystem
>> data    error   power    status          uevent
>> $ echo 1 > loading
>> $ cat /tmp/firmware.bin > data
>> $ echo 0 > loading
>> $ while :; do cat status; cat remaining_size ; sleep 3; done
>> preparing
>> 44590080
>> <--snip-->
>> transferring
>> 44459008
>> transferring
>> 44311552
>> <--snip-->
>> transferring
>> 173056
>> <--snip-->
>> programming
>> 0
>> <--snip-->
>> idle
>> 0
>> ^C
>> $ cat error
>>
>> The first two patches in this set make minor changes to enable the
>> fw_priv data structure and the sysfs interfaces to be used multiple times
>> during the existence of the device driver instance. The third patch is
>> mostly a reorganization of existing code in preparation for sharing common
>> code with the firmware-upload support. The fourth and fifth patches provide
>> the code for user-initiated firmware uploads. The final 3 patches extend
>> selftest support to test firmware-upload functionality.
>>
>>
>> Changelog RFC -> v1:
>>   - Renamed files fw_sysfs.c and fw_sysfs.h to sysfs.c and sysfs.h
>>   - Moved "MODULE_IMPORT_NS(FIRMWARE_LOADER_PRIVATE);" from sysfs.c to
>>     sysfs.h to address an error identified by the kernel test robot
>>     <lkp@intel.com>
>>   - renamed fw_upload_register() and fw_upload_unregister() to
>>     firmware_upload_register() and fw_upload_unregister().
>>   - Moved ifdef'd section of code out of firmware_loading_store() in sysfs.c
>>     into a new function, fw_upload_start(), in sysfs_upload.c.
>>   - Changed #defines to enums for error codes and progress states
>>   - Added additional kernel-doc supported symbols into the documentation.
>>     Some rewording in documentation as well.
>>   - Added module reference counting for the parent module in the
>>     firmware_upload_register() and firmware_upload_unregister() functions
>>     to fix problems found when testing with test_firmware module.
>>   - Removed unnecessary module reference counting for THIS_MODULE.
>>   - Added a new patch to modify the test_firmware module to support
>>     testing of the firmware upload mechanism.
>>   - Added a new patch to modify the test_firmware module to support
>>     error injection for firmware upload.
>>   - Added a new patch to extend the existing firmware selftests to cover
>>     firmware upload.
>>
>> Russ Weight (8):
>>   firmware_loader: Clear data and size in fw_free_paged_buf
>>   firmware_loader: Check fw_state_is_done in loading_store
>>   firmware_loader: Split sysfs support from fallback
>>   firmware_loader: Add firmware-upload support
>>   firmware_loader: Add sysfs nodes to monitor fw_upload
>>   test_firmware: Add test support for firmware upload
>>   test_firmware: Error injection for firmware upload
>>   selftests: firmware: Add firmware upload selftests
>>
>>  .../ABI/testing/sysfs-class-firmware          |  77 ++++
>>  .../driver-api/firmware/fw_upload.rst         | 117 +++++
>>  Documentation/driver-api/firmware/index.rst   |   1 +
>>  drivers/base/firmware_loader/Kconfig          |  18 +
>>  drivers/base/firmware_loader/Makefile         |   2 +
>>  drivers/base/firmware_loader/fallback.c       | 430 -----------------
>>  drivers/base/firmware_loader/fallback.h       |  46 +-
>>  drivers/base/firmware_loader/firmware.h       |  11 +
>>  drivers/base/firmware_loader/main.c           |  18 +-
>>  drivers/base/firmware_loader/sysfs.c          | 435 ++++++++++++++++++
>>  drivers/base/firmware_loader/sysfs.h          | 100 ++++
>>  drivers/base/firmware_loader/sysfs_upload.c   | 396 ++++++++++++++++
>>  drivers/base/firmware_loader/sysfs_upload.h   |  47 ++
>>  include/linux/firmware.h                      |  82 ++++
>>  lib/test_firmware.c                           | 378 +++++++++++++++
>>  tools/testing/selftests/firmware/Makefile     |   2 +-
>>  tools/testing/selftests/firmware/config       |   1 +
>>  tools/testing/selftests/firmware/fw_lib.sh    |   7 +
>>  .../selftests/firmware/fw_run_tests.sh        |   4 +
>>  tools/testing/selftests/firmware/fw_upload.sh | 214 +++++++++
>>  20 files changed, 1900 insertions(+), 486 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-firmware
>>  create mode 100644 Documentation/driver-api/firmware/fw_upload.rst
>>  create mode 100644 drivers/base/firmware_loader/sysfs.c
>>  create mode 100644 drivers/base/firmware_loader/sysfs.h
>>  create mode 100644 drivers/base/firmware_loader/sysfs_upload.c
>>  create mode 100644 drivers/base/firmware_loader/sysfs_upload.h
>>  create mode 100755 tools/testing/selftests/firmware/fw_upload.sh
>>
>> -- 
>> 2.25.1


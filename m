Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2144B1C37
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbiBKC3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:29:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiBKC3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:29:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E4210D8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644546561; x=1676082561;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JtYDCj4bKoU+M6Sppr7CicwiuFFNCSRmou6GlGRw4cI=;
  b=COioYhbI8cHGr2UgvY8TfnAtqvA28u//kfi1Z7nilXV8LFvjUZneWnQa
   KX3jqer/q64iCdFe1sTGeQjWqIYmJNy+fZqA6iP5Lcq+eoS8NzT68b5N/
   Q30EpD0FLZ2f4xsGM64hLCFTua+/UFaLLuUv4X5iBbpC+2BaWBx5DMtQM
   UhhT+dGZ+0c7YFDDftAni4WCSvAcCcOq5r5p8zyKfwCNlKXQCi60W1VYN
   oWV31EMfQZ0e7r3+FGGt+ryRjayTXyzSZZC5Nr8qfezVjatxKMJ68uAHa
   z/vW/jzSaGbr3pQLEe6Iv8pA3vI6s9Y9WhRcJoqPX/5st07aFDNSua1Yc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="230284563"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="230284563"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 18:29:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="701931576"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 10 Feb 2022 18:29:20 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 18:29:20 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 18:29:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 10 Feb 2022 18:29:19 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 10 Feb 2022 18:29:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKGan8Agjo3CTaCLGTA0V7OJwU8N5jVxOHlG8H9UXFRwGFG1WtGUHUl1HfqhRwPeuseJyjekegAiCV3ySJljkAIC4oH5EAGMR3wl9z5+jaiF5/NeipA+5CotEhI+VCyDGJtQ8kwAmgApaWRXVVO2nQG7W4FwrWvhMSSuhDiFzOJs7ool0aUolQGQICUdMVxTj3Qi/iwWdHEcqRYxQA2MdlTpnE1F0x9/Vx9R8MrWikXDXz6aRgapMvrV7z+dRG79wosOXhcrbWUCwn3rN5tARProKaWImrjRPjvbrFS6DXbbQrHerckJHZWx5EE25ExIIgAJgYHiwqZjy9wEMpVCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmKV6U/+0fD9oZlac8mb2faJ/WLnD+0NZdApmgERDbw=;
 b=M3QuB9zbyifm2qoN5roligFKQpex5HdpfmBBcVQQuXDgGthsnOqLWbdaCUhs7SN1oSc09iM/5cJ10Zty/FgS3DakxVUn4rKK2tNl45ul6/pCHnCwuerzK65LMWCfGqParc4QXGjzkVCmbeDqjzjxZ5sDVa6H2HE01xsgZQWoIhn2PNUDQ5rycX/SkOo4JSA1ZP8O6kp8t6WDXx53K7HqpFtJLAuGiy4Z89RrFc3CZrPzS1tGUtX4TqMOsmSD8f/RKY+RVbM4ZKhrdmAdaqg9o8iiwOYv5PSncWS9YeGGwpTiSZonk8UKQAgSRIh4eGBD+ORkm3bsGuVOTBiIRycOhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by DM6PR11MB3435.namprd11.prod.outlook.com (2603:10b6:5:68::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 02:29:16 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::5c89:e3da:dfd5:ec7e]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::5c89:e3da:dfd5:ec7e%7]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 02:29:16 +0000
Subject: Re: [RFC PATCH 4/5] firmware_loader: Add firmware-upload support
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>, <basheer.ahmed.muddebihal@intel.com>,
        <tianfei.zhang@intel.com>
References: <20220203213053.360190-1-russell.h.weight@intel.com>
 <20220203213053.360190-5-russell.h.weight@intel.com>
 <YfxeSw5n/qUWGcz8@bombadil.infradead.org>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <4c09bd4b-4ad6-8a09-a94c-59dd422b7420@intel.com>
Date:   Thu, 10 Feb 2022 18:29:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YfxeSw5n/qUWGcz8@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MW4PR04CA0295.namprd04.prod.outlook.com
 (2603:10b6:303:89::30) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c991f3b7-1f01-48b3-1886-08d9ed064cc8
X-MS-TrafficTypeDiagnostic: DM6PR11MB3435:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB3435AAFDFEF48C7087C9DB4EC5309@DM6PR11MB3435.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEvWntMeCgad5LeobixJNCGAsWGnyfP3KVCnOpZ7pUmadBBamQN1dE0Ugd113F+DV72fBmQ6v7JoRrguf/4hMxRWL1Na9x9aXSlSd4LnkzIZt/Crq/8ptRVSedhoPhU1PWdpjxAGjxDMEIOIIYk8CM4+n+qTSzYTApRedI4IMtbRsGGxD87wa4IPdoRPFV0TZ3CNKsBGaFkYOZ32NqqQjOlLZDJSQYXAns4gynRvDBsSOMx67OsLMD+sRaUTOPGdbGj9KLBFKMuqciokzOdpWrR6h9M7dkUc6jXp2DhCtVsPmXqJSxVuj/u+hux8Efk9rDIjvx4ztgYyxNLBOnIkAyDzy3xj3RZf2oYxHRcaxJiMnuhjRNKPD16jor4aQpozUrlM7ll9NxCBy0H9hfjpPLZzNp0j6dE145T6PdR5oTwdo4afOfVuP/eq/asS6AzQ9NyOdHWAKKj/lLowb8mw0Hus7EHXFqWGzIk0Zv6VHPcHKgjorKhW8T5Y7Pj5pTlT8Zg71etmh4xbzrbCBPEkrUOaMui6G4vK0OroyM/e76vlbDY4VSTtEVtTEHvIqtvVrHZjAjC7oZxgad0O9hbcB8dgtlAYOftQVfUEfWWnB1cy4tIcwOUE2nuLvSuaQ92yVKL1hjK74C65qtwdgaWnjkjBlKcUY4uXAIV185OrQ9OReneSh/seDLU/hAIYfL7xQG6TxczSdAdM3QXk0k6b6sQMQjxh35l4J/PXZKxCPXK7kMuf7Vubk324dlVrFU3q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(30864003)(66946007)(82960400001)(8676002)(8936002)(66556008)(2906002)(5660300002)(66476007)(53546011)(186003)(4326008)(6506007)(83380400001)(6486002)(26005)(2616005)(6666004)(31696002)(6512007)(107886003)(38100700002)(508600001)(6916009)(31686004)(316002)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDg2RUc4ajZqUFp3eC93ako1SXJHZEpaUFhldXB1L256VWF5MkRMY1hMOGhJ?=
 =?utf-8?B?OXJXeDVOdm5ZdWtOdnNiMk5COFgxK2xaTXdsckdHS2NjWWF6aGs3RFdsdlNP?=
 =?utf-8?B?QUkybjNsRU8ySUhjbmZJRzB0KzFLcGVNNWpEbEZDZ1BmRnJJemJHZUNOZzlt?=
 =?utf-8?B?cHUwcFFJWnBBQlo0ZDVzN3RRcnk1SzZ3eWVXcG1GMGJ1aDBlSUdGN0lEVS9z?=
 =?utf-8?B?alYydkVaZTZXUklIOGthV0tEMCtsMndHY0h4alpRc1RZZDl0bUQrTFN0dG02?=
 =?utf-8?B?ZWVKTDJtN1ZtcmpDVnBtMWZWR2FuWml5WVBraGFhOFR3eGdMVklKWmxwaVpy?=
 =?utf-8?B?OTlRZms1a3BVNjFlZTdNTldRQXBieE84cVQvYnF3Kzg2eDNmRktFcFI1RTEz?=
 =?utf-8?B?TWUvSks3NzNabTVvbnRvUTdMODAzV2lLVmEzUklkT1FzRWljN05WcEM0bmZE?=
 =?utf-8?B?ajBmSGVkRHJPdXBVcExUYnlqaXB0QkRWaU91b3BnMy9kK1V6ZWZqTm5XNW9q?=
 =?utf-8?B?elVpNkdCTEpZVm5ZTTFWaG1vK3VlRlJ0MXdRaVNtWkJUWUdTa05nVHVBYTQx?=
 =?utf-8?B?OFZVOXVHWXlVTFd2aDhsVWtrNHRva2NBVU9LREQ2eGJuQWl2bWRDRkFNR3lN?=
 =?utf-8?B?NEhJc3A0T3hQYnZwMjZEYm5ONUxGdWgxeU5wVVVmdXM0N21nN1RTSmRxRXRH?=
 =?utf-8?B?MnFKbEI1enZCdkx0dnBubXF3NXhCQkdCQVc3SXdMRTIyQ1ArRnpXWTFVT0Fn?=
 =?utf-8?B?L3IrOUxMc0paNzdudzR4NUM4S3VxZDZKNXZzb3dxaEt4Ulp2MTdJcjlhckxl?=
 =?utf-8?B?bkphYndINnJvYlk3R1dZdE1jcWV0V0s4ZmE3aGwwWk9UU2VsK1hML0NvQytm?=
 =?utf-8?B?cTFaNE9jTnhTS2twUWhRQ1FoRFlKeHVWbVl3ek0vcGdzcFlPRklHS0hTK3Nr?=
 =?utf-8?B?MjNwVXd6Q3ZRY3k5OEhtU1FKbHR2Y1FlV0FtZVNpUUdpdlhJcnNYZmZFUWEw?=
 =?utf-8?B?L2ZJK1JiWFV0Y0ZER3dEZnJEUVVoWlJuOFRMaExwR1ZUWWR0YjlxR0p6MXh5?=
 =?utf-8?B?MjVUUjcvVGQrdVpGV1ZEb3pFWmx6ZHE2Q0dpcWlRRmNNTDBKSFU1OWJSWVRi?=
 =?utf-8?B?MnBMV1NYMkcrZUhJaWJJeVdqeW1PcFgvSGRrcCtKbTJJVExEWExDQ09TWGZx?=
 =?utf-8?B?ZTc2UDQvNHNXYlY3alpkMmxjd1ZwcFIzcUdjUTVBaW5RNjl2THlXR0xVK2dO?=
 =?utf-8?B?U0lLNnF4My94azRRTmpyVitaVnpCZjBxQTd2WElFM1Q3SnFlQmVBQzlKQUY3?=
 =?utf-8?B?TjBycUhXM3ZnUkJtM0lCRGZlT1RWWUFYRDFXYVpQS0ZHd1RwVjZrTm9JRFl5?=
 =?utf-8?B?NkhkclR1N3Bwd2hCMHpoWW1hbzBJU1VNczVYcUJSQ1B2ZlJ5RUVreXNWYUhR?=
 =?utf-8?B?UGNSY1I0aWFoaS9nVWRxL05FMjVkZEJiWldXQmpqSFJ2ak9XOWJqRG1DRUJX?=
 =?utf-8?B?VVJPTElScjZNdnVTdTdaQUo0YmhlaHV5M2xjRXFMaHNTOEk1NGwwRGh1UXJj?=
 =?utf-8?B?QW15TE9ndG5nY2hlUzcwN3BpV0N1U0R5bUpQdHQwYVNqUXlTQ0VybHdFUTlj?=
 =?utf-8?B?T01nRmtoNk51T1ExTlMzV3RWdGJBQUM3RTR3NktkU1NiNGJadWMveUMxeUFP?=
 =?utf-8?B?Z05qNXpvREpNRm55ZEJjVmttK3JqYklwWGc2SjNZZFVpMnJKYjMzS0FGMlBp?=
 =?utf-8?B?dGsvZHM4YklteGpZWVJqQ0NudW5JN2dkZ0s4a1luRjE5MzVmUzU4UkRIOTZm?=
 =?utf-8?B?SkVrYWU3dkd6N3pIRFU1SzZTdjg4cHJ0VGZrN2pqUndFTGI3SURMQjdQWEtp?=
 =?utf-8?B?aUsrQXJXRHNmMko2MXoxZVFlNmh0UXpBYjZXcTc0ajBabVIyMDc2NUF4aXlO?=
 =?utf-8?B?bFU2aWY1WFZhckJNVGZPcmowVjlqOGtpZWlhU0JYd0g1YndCTXVSLzYvaEN2?=
 =?utf-8?B?cSs1NkRtV2tBZUx4WWZHd1FKQ3llakQ1YkpUQTk4T21XUTlrdUtVOUVMZlhE?=
 =?utf-8?B?bUlmeHhibi9SQnA1ZWFPM1dvOURTRG45V0pRdmNocnk4MmgrU3RwVzZTd2Nl?=
 =?utf-8?B?NzdYaU9tcCtZME1nb3QzV21nUkwwR0ZOTmROd0dCT2FLbFNORmZQTjJ2S1Jq?=
 =?utf-8?B?dWtscDFsSUpIZ3IwUWtLT0tiakRDWW8vQmJENlBuK1M2d2grSEZpb0tVK0NZ?=
 =?utf-8?B?VmFNcVFPdTI3NEZnUEdnZFpjb01BPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c991f3b7-1f01-48b3-1886-08d9ed064cc8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 02:29:16.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGaS+OmFlKSHGE/MMxyQ73YtqmIjlLcYX4Qr6j3hgCW4gLOpKNzggNqbXdJeDdi8ovqoSW5arQaSf3zYVuioT9fYmcOaLVwQAxabwj+ThuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3435
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/22 2:59 PM, Luis Chamberlain wrote:
> On Thu, Feb 03, 2022 at 02:30:51PM -0700, Russ Weight wrote:
>> Extend the firmware subsystem to support a persistent sysfs interface that
>> userspace may use to initiate a firmware update. For example, FPGA based
>> PCIe cards load firmware and FPGA images from local FLASH when the card
>> boots. The images in FLASH may be updated with new images provided by the
>> user at his/her convenience.
>>
>> A device driver may call fw_upload_register() to expose persistent
>> "loading" and "data" sysfs files. These files are used in the same way as
>> the fallback sysfs "loading" and "data" files. When 0 is written to
>> "loading" to complete the write of firmware data, the data is transferred
>> to the lower-level driver using pre-registered call-back functions. The
>> data transfer is done in the context of a kernel worker thread.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>>  .../ABI/testing/sysfs-class-firmware          |  32 +++
>>  .../driver-api/firmware/fw_upload.rst         |  86 +++++++
>>  Documentation/driver-api/firmware/index.rst   |   1 +
>>  drivers/base/firmware_loader/Kconfig          |  14 ++
>>  drivers/base/firmware_loader/Makefile         |   1 +
>>  drivers/base/firmware_loader/firmware.h       |   6 +
>>  drivers/base/firmware_loader/fw_sysfs.c       |  50 +++-
>>  drivers/base/firmware_loader/fw_sysfs.h       |   4 +
>>  drivers/base/firmware_loader/fw_upload.c      | 229 ++++++++++++++++++
>>  drivers/base/firmware_loader/fw_upload.h      |  24 ++
>>  drivers/base/firmware_loader/main.c           |  16 +-
>>  include/linux/firmware.h                      |  72 ++++++
>>  12 files changed, 523 insertions(+), 12 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-firmware
>>  create mode 100644 Documentation/driver-api/firmware/fw_upload.rst
>>  create mode 100644 drivers/base/firmware_loader/fw_upload.c
>>  create mode 100644 drivers/base/firmware_loader/fw_upload.h
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-firmware b/Documentation/ABI/testing/sysfs-class-firmware
>> new file mode 100644
>> index 000000000000..a2e518f0bf8a
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-firmware
>> @@ -0,0 +1,32 @@
>> +What: 		/sys/class/firmware/.../data
>> +Date:		Mar 2022
>> +KernelVersion:	5.18
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	The data sysfs file is used for firmware-fallback and for
>> +		firmware uploads. Cat a firmware image to this sysfs file
>> +		after you echo 1 to the loading sysfs file. When the firmware
>> +		image write is complete, echo 0 to the loading sysfs file. This
>> +		sequence will signal the completion of the firmware write and
>> +		signal the lower-level driver that the firmware data is
>> +		available.
>> +
>> +What: 		/sys/class/firmware/.../loading
>> +Date:		Mar 2022
>> +KernelVersion:	5.18
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	The loading sysfs file is used for both firmware-fallback and
>> +		for firmware uploads. Echo 1 onto the loading file to indicate
>> +		you are writing a firmware file to the data sysfs node. Echo
>> +		-1 onto this file to abort the data write or echo 0 onto this
>> +		file to indicate that the write is complete. For firmware
>> +		uploads, the zero value also triggers the transfer of the
>> +		firmware data to the lower-level device driver.
>> +
>> +What: 		/sys/class/firmware/.../timeout
>> +Date:		Mar 2022
>> +KernelVersion:	5.18
>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>> +Description:	This file supports the timeout mechanism for firmware
>> +		fallback.  This file has no affect on firmware uploads. For
>> +		more information on timeouts please see the documentation
>> +		for firmware fallback.
>> diff --git a/Documentation/driver-api/firmware/fw_upload.rst b/Documentation/driver-api/firmware/fw_upload.rst
>> new file mode 100644
>> index 000000000000..bf272f627a1f
>> --- /dev/null
>> +++ b/Documentation/driver-api/firmware/fw_upload.rst
>> @@ -0,0 +1,86 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=============
>> +fw_upload API
>> +=============
>> +
>> +A device driver that registers with the firmware loader will expose
>> +persistent sysfs nodes to enable users to initiate firmware updates for
>> +that device.  It is the responsibility of the device driver and/or the
>> +device itself to perform any validation on the data received. Firmware
>> +upload uses the same *loading* and *data* sysfs files described in the
>> +documentation for firmware fallback.
>> +
>> +Register for firmware upload
>> +============================
>> +
>> +A device driver registers for firmware upload by calling fw_upload_register().
>> +Among the parameter list is a name to identify the device under
>> +/sys/class/firmware. A user may initiate a firmware upload by echoing
>> +a 1 to the *loading* sysfs file for the target device. Next, the user writes
>> +the firmware image to the *data* sysfs file. After writing the firmware
>> +data, the user echos 0 to the *loading* sysfs file to signal completion.
>> +Echoing 0 to *loading* also triggers the transfer of the firmware to the
>> +lower-lever device driver in the context of a kernel worker thread.
>> +
>> +To use the fw_upload API, write a driver that implements a set of ops. The
>> +probe function calls fw_upload_register() and the remove function calls
>> +fw_upload_unregister() such as::
>> +
>> +	static const struct fw_upload_ops m10bmc_ops = {
>> +		.prepare = m10bmc_sec_prepare,
>> +		.write = m10bmc_sec_write,
>> +		.poll_complete = m10bmc_sec_poll_complete,
>> +		.cancel = m10bmc_sec_cancel,
>> +		.cleanup = m10bmc_sec_cleanup,
>> +	};
>> +
>> +	static int m10bmc_sec_probe(struct platform_device *pdev)
>> +	{
>> +		const char *fw_name, *truncate;
>> +		struct m10bmc_sec *sec;
>> +		struct fw_upload *fwl;
>> +		unsigned int len;
>> +
>> +		sec = devm_kzalloc(&pdev->dev, sizeof(*sec), GFP_KERNEL);
>> +		if (!sec)
>> +			return -ENOMEM;
>> +
>> +		sec->dev = &pdev->dev;
>> +		sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>> +		dev_set_drvdata(&pdev->dev, sec);
>> +
>> +		fw_name = dev_name(sec->dev);
>> +		truncate = strstr(fw_name, ".auto");
>> +		len = (truncate) ? truncate - fw_name : strlen(fw_name);
>> +		sec->fw_name = kmemdup_nul(fw_name, len, GFP_KERNEL);
>> +
>> +		fwl = fw_upload_register(sec->dev, sec->fw_name, &m10bmc_ops, sec);
>> +		if (IS_ERR(fwl)) {
>> +			dev_err(sec->dev, "Firmware Upload driver failed to start\n");
>> +			kfree(sec->fw_name);
>> +			return PTR_ERR(fwl);
>> +		}
>> +
>> +		sec->fwl = fwl;
>> +		return 0;
>> +	}
>> +
>> +	static int m10bmc_sec_remove(struct platform_device *pdev)
>> +	{
>> +		struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
>> +
>> +		fw_upload_unregister(sec->fwl);
>> +		kfree(sec->fw_name);
>> +		return 0;
>> +	}
>> +
>> +fw_upload_register
>> +------------------
>> +.. kernel-doc:: drivers/base/firmware_loader/fw_upload.c
>> +   :functions: fw_upload_register
>> +
>> +fw_upload_unregister
>> +--------------------
>> +.. kernel-doc:: drivers/base/firmware_loader/fw_upload.c
>> +   :functions: fw_upload_unregister
>> diff --git a/Documentation/driver-api/firmware/index.rst b/Documentation/driver-api/firmware/index.rst
>> index 57415d657173..9d2c19dc8e36 100644
>> --- a/Documentation/driver-api/firmware/index.rst
>> +++ b/Documentation/driver-api/firmware/index.rst
>> @@ -8,6 +8,7 @@ Linux Firmware API
>>     core
>>     efi/index
>>     request_firmware
>> +   fw_upload
>>     other_interfaces
>>  
>>  .. only::  subproject and html
>> diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
>> index 1bfe18900ed5..cee662f3277b 100644
>> --- a/drivers/base/firmware_loader/Kconfig
>> +++ b/drivers/base/firmware_loader/Kconfig
>> @@ -185,5 +185,19 @@ config FW_CACHE
>>  
>>  	  If unsure, say Y.
>>  
>> +config FW_UPLOAD
>> +	bool "Enable users to initiate firmware updates using sysfs"
>> +	select FW_LOADER_SYSFS
>> +	select FW_LOADER_PAGED_BUF
>> +	help
>> +	  Enabling this option will allow device drivers to expose a persistent
>> +	  sysfs interface that allows firmware updates to be initiated from
>> +	  userspace. For example, FPGA based PCIe cards load firmware and FPGA
>> +	  images from local FLASH when the card boots. The images in FLASH may
>> +	  be updated with new images provided by the user. Enable this device
>> +	  to support cards that rely on user-initiated updates for firmware files.
>> +
>> +	  If unsure, say N.
>> +
>>  endif # FW_LOADER
>>  endmenu
>> diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmware_loader/Makefile
>> index 787c833d0c6e..52ef64bd9357 100644
>> --- a/drivers/base/firmware_loader/Makefile
>> +++ b/drivers/base/firmware_loader/Makefile
>> @@ -7,5 +7,6 @@ firmware_class-objs := main.o
>>  firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) += fallback.o
>>  firmware_class-$(CONFIG_EFI_EMBEDDED_FIRMWARE) += fallback_platform.o
>>  firmware_class-$(CONFIG_FW_LOADER_SYSFS) += fw_sysfs.o
>> +firmware_class-$(CONFIG_FW_UPLOAD) += fw_upload.o
>>  
>>  obj-y += builtin/
>> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
>> index 58768d16f8df..4019f9423de8 100644
>> --- a/drivers/base/firmware_loader/firmware.h
>> +++ b/drivers/base/firmware_loader/firmware.h
>> @@ -87,6 +87,7 @@ struct fw_priv {
>>  };
>>  
>>  extern struct mutex fw_lock;
>> +extern struct firmware_cache fw_cache;
>>  
>>  static inline bool __fw_state_check(struct fw_priv *fw_priv,
>>  				    enum fw_status status)
>> @@ -154,7 +155,12 @@ static inline bool fw_state_is_done(struct fw_priv *fw_priv)
>>  	return __fw_state_check(fw_priv, FW_STATUS_DONE);
>>  }
>>  
>> +int alloc_lookup_fw_priv(const char *fw_name, struct firmware_cache *fwc,
>> +			 struct fw_priv **fw_priv, void *dbuf, size_t size,
>> +			 size_t offset, u32 opt_flags);
>>  int assign_fw(struct firmware *fw, struct device *device);
>> +void free_fw_priv(struct fw_priv *fw_priv);
>> +void fw_state_init(struct fw_priv *fw_priv);
>>  
>>  #ifdef CONFIG_FW_LOADER
>>  bool firmware_is_builtin(const struct firmware *fw);
>> diff --git a/drivers/base/firmware_loader/fw_sysfs.c b/drivers/base/firmware_loader/fw_sysfs.c
>> index 70cb1d67ffb2..9b0cd37c81df 100644
>> --- a/drivers/base/firmware_loader/fw_sysfs.c
>> +++ b/drivers/base/firmware_loader/fw_sysfs.c
>> @@ -6,8 +6,8 @@
>>  #include <linux/slab.h>
>>  #include <linux/types.h>
>>  
>> -#include "firmware.h"
>>  #include "fw_sysfs.h"
>> +#include "fw_upload.h"
>>  
>>  /*
>>   * sysfs support for firmware loader
>> @@ -80,6 +80,10 @@ static void fw_dev_release(struct device *dev)
>>  {
>>  	struct fw_sysfs *fw_sysfs = to_fw_sysfs(dev);
>>  
>> +	if (fw_sysfs->fw_upload_priv) {
>> +		free_fw_priv(fw_sysfs->fw_priv);
>> +		kfree(fw_sysfs->fw_upload_priv);
>> +	}
>>  	kfree(fw_sysfs);
>>  }
>>  
>> @@ -165,6 +169,9 @@ static ssize_t firmware_loading_store(struct device *dev,
>>  				      const char *buf, size_t count)
>>  {
>>  	struct fw_sysfs *fw_sysfs = to_fw_sysfs(dev);
>> +#ifdef CONFIG_FW_UPLOAD
>> +	struct fw_upload_priv *fwlp;
>> +#endif
>>  	struct fw_priv *fw_priv;
>>  	ssize_t written = count;
>>  	int loading = simple_strtol(buf, NULL, 10);
>> @@ -211,6 +218,42 @@ static ssize_t firmware_loading_store(struct device *dev,
>>  				written = rc;
>>  			} else {
>>  				fw_state_done(fw_priv);
>> +
>> +#ifdef CONFIG_FW_UPLOAD
>> +				/*
>> +				 * For fw_uploads, start a worker thread to upload
>> +				 * data to the parent driver.
>> +				 */
>> +				if (!fw_sysfs->fw_upload_priv)
>> +					break;
>> +
>> +				if (!fw_priv->size) {
>> +					fw_free_paged_buf(fw_priv);
>> +					fw_state_init(fw_sysfs->fw_priv);
>> +					break;
>> +				}
>> +
>> +				fwlp = fw_sysfs->fw_upload_priv;
>> +				mutex_lock(&fwlp->lock);
>> +
>> +				/* Do not interfere an on-going fw_upload */
>> +				if (fwlp->progress != FW_UPLOAD_PROG_IDLE) {
>> +					mutex_unlock(&fwlp->lock);
>> +					written = -EBUSY;
>> +					goto out;
>> +				}
>> +
>> +				fwlp->progress = FW_UPLOAD_PROG_RECEIVING;
>> +				fwlp->err_code = 0;
>> +				fwlp->remaining_size = fw_priv->size;
>> +				fwlp->data = fw_priv->data;
>> +				pr_debug("%s: fw-%s fw_priv=%p data=%p size=%u\n",
>> +					 __func__, fw_priv->fw_name,
>> +					 fw_priv, fw_priv->data,
>> +					 (unsigned int)fw_priv->size);
>> +				queue_work(system_long_wq, &fwlp->work);
>> +				mutex_unlock(&fwlp->lock);
>> +#endif
> If you're going to split this work up it'd be nice to avoid to have
> #ifdef stuff here.
Yes - I'll encapsulate the code into another function and move it
to the sysfs-upload.c file.

>
>> diff --git a/drivers/base/firmware_loader/fw_upload.c b/drivers/base/firmware_loader/fw_upload.c
> No need for fw prefix, sysfs-upload.[ch] would make it clearer.
OK - I'll switch to sysfs-upload.[ch]
>
>> +EXPORT_SYMBOL_GPL(fw_upload_register);
> firmware_upload_register()
>
>> +EXPORT_SYMBOL_GPL(fw_upload_unregister);
> firmware_upload_unregister()
Sure - I'll change the register/unregister function names.
>
>> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
>> index 3b057dfc8284..9b109f8ff627 100644
>> --- a/include/linux/firmware.h
>> +++ b/include/linux/firmware.h
>> @@ -17,6 +17,56 @@ struct firmware {
>>  	void *priv;
>>  };
>>  
>
>> +/* Update progress codes */
>> +#define FW_UPLOAD_PROG_IDLE		0
>> +#define FW_UPLOAD_PROG_RECEIVING	1
>> +#define FW_UPLOAD_PROG_PREPARING	2
>> +#define FW_UPLOAD_PROG_TRANSFERRING	3
>> +#define FW_UPLOAD_PROG_PROGRAMMING	4
>> +#define FW_UPLOAD_PROG_MAX		5
> enums with kdoc allows you to nicely document these as well.
OK. I'll switch to enums. I also realised that the FW_UPLOAD_PROG*
constants can be defined in a smaller scope. I'll move these to
sysfs-upload.h.

>> +
>> +/* Update error progress codes */
>> +#define FW_UPLOAD_ERR_HW_ERROR		1
>> +#define FW_UPLOAD_ERR_TIMEOUT		2
>> +#define FW_UPLOAD_ERR_CANCELED		3
>> +#define FW_UPLOAD_ERR_BUSY		4
>> +#define FW_UPLOAD_ERR_INVALID_SIZE	5
>> +#define FW_UPLOAD_ERR_RW_ERROR		6
>> +#define FW_UPLOAD_ERR_WEAROUT		7
>> +#define FW_UPLOAD_ERR_MAX		8
> enums with kdoc allows you to nicely document these as well.
Thanks,
- Russ
>
>   Luis


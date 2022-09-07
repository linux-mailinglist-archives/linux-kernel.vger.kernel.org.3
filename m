Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C7A5B0CC2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 20:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiIGS6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 14:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIGS6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 14:58:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496D29BB54
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662577093; x=1694113093;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PYNbR6GmJBXxjh8i3iPuGSRx7vCkc0b8HSV/SpspWjs=;
  b=GuLtSzAhF+9YpJHt5SGTgRcgU4+P6yxKelPnm8UIZ5B+aUqXR50sYiJb
   9RjgqGg3ZcEJobO23tBn/VFBc143g4w/9BCKlfZBYYjHYtDR7euVNkvgD
   1PE4zaoJD+EJzdFbPvnLsuMlbLcAtxjUL8Q85XDdNotu6khsYNvGsym/h
   2dnd03hNkPJCE9Fn1IoHeI/v9bCivtOvQig08yfvXARpRokJBBFASvF6t
   I7NQPc4qnilcmVa5lKh3jmE/pFHPJZPVWVikJN8dZ/mVKZMSrCKwsHcGA
   PR8HOwUMx+PB5/4btSSUzgf/CsP00kiTLOEJy1az3Fk9tF00A42HFNlFr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="277360065"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="277360065"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 11:58:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="859749744"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 07 Sep 2022 11:58:12 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 11:58:12 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 11:58:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 11:58:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 11:58:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9sPR8cC9FphRCoMa7rncP4xVGSHN2YmJ3/GpQrcbh9bAMWGZv2/00VgjUavJJsca70PW1W1sdfuWAXXZsoxBj7t2wnQvkr1PcP8KPp17hKi2BXiq+7W9iVxcN1HDQLlEpD1deo/uMuyf7CI5HmGCHFrsgA4PIMGjzKGtG3AjahNTFhwGrMAl9YwlsZ2uLusmsm8og88ywga8HmWSDzT68K4rsRP3x1ctkWpFSlqkktASAL3T2TikWepZNX3yJ5onxlfuIS8PvqfoZBJwsMWvfYzze0qQbzQoH3f1s/Y9MmnAEEPo4esv69PBYjsMUyoBNLY6dn115o7ui5mmmi0hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+0SlD5VuHzPZVBn7bsPdtKoudZHa6pvA2MUplK+2hY=;
 b=dUGhynULEC/11n0/dpwHZLEtGLE1puPSKQ9j/FR2BMbs0cvMpgBsks6FXhCoS05HLVKO1rBaO54jlVHSeprvOBf4fFBsDs/gb86x2rPlqyQOYrwM6CE01A38OrFuOZtTAJA6jRCnmgBT7QBJc24brbLJahgRORBFD98fgGKAQMRgsufcIl7ea6Lgzj195Fr4sklS1Nx/6fRsWTrhihrYLDwyhZgiHUSVVeXwstNl9PW24A7urnA4blQ4vM7lWOj3f6zKYo8qF4+NkcQ6gZmxy3i228CW2WeJDKAUvSobAYaGbFecG9bHGQd6ZCrOAxOfhVGGwAGG4biPq04dlNBPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 CY4PR11MB2023.namprd11.prod.outlook.com (2603:10b6:903:30::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.12; Wed, 7 Sep 2022 18:58:09 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.017; Wed, 7 Sep 2022
 18:58:09 +0000
Message-ID: <5e127663-c7e9-a491-3d3b-b057c50eb25a@intel.com>
Date:   Wed, 7 Sep 2022 11:58:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v8 02/16] mei: add kdoc for struct
 mei_aux_device
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220907155813.1427526-1-tomas.winkler@intel.com>
 <20220907155813.1427526-3-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220907155813.1427526-3-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::7) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0eb6dbf-52e7-4d80-a1fc-08da9102e824
X-MS-TrafficTypeDiagnostic: CY4PR11MB2023:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+vDSOBJNdhiBuGqE1fw5hCg6SXQxOWlVYsLUDPaJ4gb34I4WOhG0Mx5ntOLOLoq4PX9mvW9K2JWXhHKbjKBPb2z+oadGstVZnL/UtOmQExTj20mXDIZxcXnG12IRsDuDT2R7nBOkOOjni5euQbVq/YDClinpJAMgMC1O6yGqRLdK3c9z7hTPRaSPwEIjz57bhaP0UBrUAK+TGyFbTURpm71uzde3GtaQgdFC0QurYsLHLYkuH11v5czQ/v462SPkosCtSdnlN70E00CxfbIWJy53IaR9azPFPMJKO9qaScYFtPaFUsZVW6TXcXn1hGCQd67aJLMK4fM2ulCN1vKB/JwBPAnoNatDCE8IfH5kRTg9qelpdn5+1w8jibNj67tlEeM2gQnAn1+jCaVa+izC45CSKEDrPzSlxhnM2/PqIcDX0AePmVV2/Kp3mOQYPLR/q034ET91C5O6fG1CeXFYjNarUaHqwfl9vZpIuy+1w2aSS0LOSGBQ9SUwixd+jEe8SvPQVuHYLp1OcL0ifLLhkGIJYRYu1X3oH5Vo9j0YM2ou7bqZVLe2jTRU43ubdylZ+CsVdgJQ0jim+eHAvm14eAaJT3NCoK+gLqxK+L3ywYPlHqokLNVfHXu8HNMl9VEqK0cm1T4wLLQKpaYW+Jyi6mSnh/mcf3PK78GO8R3PVhAYkZAbHJvOIevAkm8r7DG73uIcv1wtMTTbrxInt3w9nCx4x/VrQjXZMFEwEhaTe8zoE7XFYeForRV4F2JE7kK7uSS1RkkEDlx1HZPa87HQHzdIQWyrJ3LUbh3rcLiyVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(396003)(366004)(346002)(82960400001)(66476007)(66556008)(8676002)(4326008)(66946007)(2616005)(38100700002)(6486002)(41300700001)(186003)(107886003)(478600001)(6512007)(6506007)(26005)(54906003)(316002)(110136005)(31696002)(31686004)(4744005)(86362001)(53546011)(8936002)(2906002)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V016a2pibzJJSUJGay9rdUVJbFBMMjUzVFVmaVlzejJXTUc3blpKeGJZRjBV?=
 =?utf-8?B?cGgzQUdmUW1BOE5iaGpseGpkODlicklWT1cwQ2JMSEFvSEpxOElkN2F4VEFj?=
 =?utf-8?B?eEkxWTAwSFJVRXZTek01aSsra3VEWUtKdVpPUGZSK0lnTTFBVFJkdXA0OE0x?=
 =?utf-8?B?MHFMTVliZytTb3hBUm1FbitBa3BzRmNQY2pRWnBSTEdpWWZZeGUvd0lBMnhB?=
 =?utf-8?B?c2RBdlA5VFRXVUQxTit5cWNhMWJTUERieEY2SHR2OHcyc1dneGEyUUlKam9n?=
 =?utf-8?B?dWJaQ3VENWZ0MDVMRHZCdmpRTHVpOXdiQ3pXQi81Q2gwQkRDUDB2QllkdFVy?=
 =?utf-8?B?Z1ZWclM1Z3ZyOW5WNWJacCtCOS9PMEt5cEhxaVVrOWprMHJ2TnF5dmgrNlY1?=
 =?utf-8?B?Mm5ZbXJRQUhRdGo2eHd0Yjg2Z0tKYW93RlNJK1RRam1hTjk5d0QyMzNVTlVN?=
 =?utf-8?B?ckozZ01FOWFtcVlHaENrUUNTM3REMU1kVnpKR0xaK0c2TE43bHV0OVdJSmdP?=
 =?utf-8?B?QmdXU2VCOGZhT3FKRWYwYXdwZ0NkK3dHcWc4eCszQ29zNnlMQlU2VDJ4M0px?=
 =?utf-8?B?Rm9XS3hpc2h1VVplWTRZQVlBWnpTYndXWXpwRnlkdG82S1JiQ0pSczJsWFhM?=
 =?utf-8?B?dUpucWdJZlFhbTBTd3Z5NnN2djhkckNqMmNBVlM0M05oQ2Z6L2ozL28yVUVx?=
 =?utf-8?B?K3BUWHRmRURpQVU1ZFRzTWhJeUhZWWRtNDVkeEhISC9hTFlKWEg2OU53UUNr?=
 =?utf-8?B?RTNja05qRlVwU0NyV2tZTFBCOXJkekVsWVlQL2JWM2tFeExJOUxXYWVWK3p5?=
 =?utf-8?B?SVpDSWtpQUpBdFJ2S0RBMkNtajZJQ0tCSmtsUFAya2Zhd3lXK3B2Zi9BWFY5?=
 =?utf-8?B?RG5VSHBnUW1mdlJzV2hEOHB5eWhCSEhJcm5iSWVXWWM1OGFldjBPVDFTYkZW?=
 =?utf-8?B?Q0FNajBFWHd1Tm1ybzNWZUdhb3ZFQkhVV2hZaGZIN0hvbVBtemNrTS9KMlhs?=
 =?utf-8?B?TmxlL1NLVHo5STdjOWFQRFFuUDRFbmxSQ09NR29malBYYnQrZWMvblFHaUJE?=
 =?utf-8?B?VlhlcDFPNmNTT1pqQytSZVh4MmpGQjlCSGFZbTc5b1kxUWlLek95RER2UEN0?=
 =?utf-8?B?eDZlKzRGeEgwQXc3dmJTTmJ3WE4wSTZpTnZIRStTNFNpZktVaXdDT3ZUelRl?=
 =?utf-8?B?THpKT204bERHZE5iMXAzeW5RTTJCWC9Sa1NCTWJyWU0xUWRJeU1pRHhmU3B0?=
 =?utf-8?B?RzNFdEE0S3EyMFloWG5TcnlOMGFqb1FFUkVIMm9IL0VPSU52elF4MHpHV3RF?=
 =?utf-8?B?d3F5b1F5Wkg1VVcyRzVmcE95QnJKMnZjVlF1NXZucGxOL0orMzZWZStiWFdE?=
 =?utf-8?B?Vlp5NWJqd2YydFZRZEVlTXFvc0V5Tzdja0V2Y2U5SXJTVis3bGpJMVRja2hS?=
 =?utf-8?B?UnNOSDQ1RlY5MW1FQ2I4cFliTThjOCsyMFN4aXhRYmtDOHVMYk9jTVFMQ0lx?=
 =?utf-8?B?bkM1Uit4WUJOQjI2N0ZaclVLUVpFQlRERmdsc2piSUZCOVh2TFBhbWQ0Mktx?=
 =?utf-8?B?ZmoremZDR1dWTWtJQWo5cHZ0YVdLRXEvdVVVK0doU2J1bWlabEtoVmJrQlRN?=
 =?utf-8?B?V3p1MmdVeXJTSmRvcXZFOXY1bmFWdVJBd0ZvOUwvQzl3am9VTUtVR29TaFBG?=
 =?utf-8?B?QmR5cWhqV2l1eWZYVWRjTkYxVjJTN0ljOGxGRHYraUlieU5zSXBIWlBiTXZZ?=
 =?utf-8?B?Nm9sK00zT3lqSzJpTVEvOXQwQmhiZG80L2l3MjluZWVjeW8zaFRjNDlKL3lm?=
 =?utf-8?B?UFpZc0djMjBPNFlaWXlQN0ZzMkFZTTMvTmZ2SlJaTVcrVkdMR25pZVRQY1Vp?=
 =?utf-8?B?NVJZVXhhMGp4TGxqcXBtR3Y5bVBmVDlDcUN3bytBVTlGTWlOZm10YVRieUhY?=
 =?utf-8?B?L0dUUzhSTDlnYWlwU2t3RVBDQjlzak1rTXEwZ2VlTGVkNXk4WmtVOUFXMEdt?=
 =?utf-8?B?eDZoWWs0cFFtdkVRaERjY1N4Z1lwdjNOSHJMOG50dHFESzNKN0c0a3ZzY1I5?=
 =?utf-8?B?cXZtRmN1MW1OYmVta2tVUUluVThJbkJ4YjdvRGd2NG9Pci9kUk5NUk5IUkJB?=
 =?utf-8?B?SlNidkkvR0hUVGpCZ2VpdjdMclY3THNscERlbGMxMGV5TS9XTGpWd1AzUmls?=
 =?utf-8?Q?aFGEhNHxaPqZ/SVVIrGq77I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eb6dbf-52e7-4d80-a1fc-08da9102e824
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:58:09.8117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jt0pZcBMhChMkpypciY5Ck+SD5HsLoAfGudEtLhus+yaGKYmuiO1qej/OOosjsAslaqR4R7uuT4opshiuf7id0t53XZKJ/ty5FWvtjRj2s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2023
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2022 8:57 AM, Tomas Winkler wrote:
> struct mei_aux_device is an interface structure
> requires proper documenation.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

This is unchanged from the previously reviewed rev, so this still applies:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   include/linux/mei_aux.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
> index 587f25128848..a0cb587006d5 100644
> --- a/include/linux/mei_aux.h
> +++ b/include/linux/mei_aux.h
> @@ -7,6 +7,12 @@
>   
>   #include <linux/auxiliary_bus.h>
>   
> +/**
> + * struct mei_aux_device - mei auxiliary device
> + * @aux_dev: - auxiliary device object
> + * @irq: interrupt driving the mei auxiliary device
> + * @bar: mmio resource bar reserved to mei auxiliary device
> + */
>   struct mei_aux_device {
>   	struct auxiliary_device aux_dev;
>   	int irq;


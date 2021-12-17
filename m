Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541E7478BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhLQM70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:59:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:34704 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232297AbhLQM7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639745965; x=1671281965;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=An0140vkL1Rq+NCDTJgNUNHF4hcc0jHHxG762/hXo3A=;
  b=Gg+uYK0HzO7+/tDNQ+JTFzePuHcbPnhMMB7um/BkJsdiCvjaQCbij5Iv
   YkprQ0xpCClf0xOUI6X6l0GaH53iQ2aW7AWCAYtUqY1Mr5t+w91Ry4ngr
   9b+ov+G2jPdtBKxq/O7qygf/yHFXMhWP83bBqPNnW4p36xmfDZbhNdiX2
   U7R3BCmB6TO9Xr/yW9Kqwd1SdNI8Eq/fIeot8TjRT+1B0qJHl0LovLw69
   GzLPTnxI+WTasZ2/UKQpcRMh4BmpO7nsqXnDCx97+qMSQPsJU7TvbtQy7
   gqESPpKKC3Kiqi8nklq89+DjNn0xRIAi/STzKRz/LWwk0ACcxBTsrFtes
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="303123688"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="303123688"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 04:59:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="662838481"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 17 Dec 2021 04:59:24 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 04:59:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 17 Dec 2021 04:59:24 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 17 Dec 2021 04:59:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7Arm/mrC2bvfTKMdwMohCL5ma3RyyoPxXBWrNinKEqlptnpCC8QLiQnHp50yZxyyslfWUBX9xUwsaFlQ53ms4hRwr8pCPlTgfNMT/Tok1hoJuZCD8Hp88wkbnm60yMMhmT7qJOjNHG0vMoSs42cywGBY71lamkFS+IFqcLk+THhtCXFenz7+CMjY+3DeKZH0i7UwA/yerfdDu82LZPS2EFvlTIx0edmEBtZ7CGDm/oJNYhZJL65bxVzzJEwL2n559PJYhdJ5kA5OSSvIUy5I1cVGBsp3A70XrfJuiIjPgQl7Nk4dDJDnEVHSXjwtp32zriTPHY//zxQDxSr84SC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbGrOdhZz/+HMXYVAs7U4MziIM+YXPuKdEKt8Y/MjGY=;
 b=Ev9MIXxRwmO7PIKVg/3QpodzvFBYN++/vjJvFFRQ8JZSc6RQgh0Fml6ThL+Dh4VJ9hDAn7Qu20xWNP5NsUvhCk6V11nucHIahaaLA+BqgQrKhCtzdKwUun3rDFplBVlj3JEmqHXXVxd+sXbc0skWs1732H5staBBGwKg1Y46WisnzrYwb7/w7D9ehLO7HvT1UNuWpn3VA7mFsEMHCwV4vCQQSHjx/nF2cwrYO7PDLBd+p+o0b3nh85Hc3Kc2p/bDN4iUxt8yQmOhgxzfgPsg8VNv/N+YorQXDY+QPWxDlC6bNDdv1Fj0gUER/7EqFmRqz6f5pCN8eYElYYdb3gqSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
 by BN6PR11MB1282.namprd11.prod.outlook.com (2603:10b6:404:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 12:59:22 +0000
Received: from BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26]) by BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26%4]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 12:59:22 +0000
Message-ID: <0e9c5253-3126-ffca-deb9-c7fc37ba769a@intel.com>
Date:   Fri, 17 Dec 2021 13:59:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH v5 02/10] ASoC: cs35l41: Move cs35l41_otp_unpack to shared
 code
Content-Language: en-US
To:     Lucas Tanure <tanureal@opensource.cirrus.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211216114332.153409-1-tanureal@opensource.cirrus.com>
 <20211216114332.153409-3-tanureal@opensource.cirrus.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20211216114332.153409-3-tanureal@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c15c5288-03d0-4867-cc37-08d9c15d0bab
X-MS-TrafficTypeDiagnostic: BN6PR11MB1282:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB12827277F213665F7F301DE7E3789@BN6PR11MB1282.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRrgGtOj9n1GC4mwubOSPyDgk8y1+F8MT1zODod3dT6WQnqjcSJ8mQxbb96JJLElwLxuF+pc/DRkqGE+2nY1CZxNJYmkqB0vuRRn67uWcHRN5K3T+9bsieMZmD0QTuJ0AdKnO3LzH0ZKnzytB35VsRveiIkd6DyJj0IjYAJNgu5wSIm9DawYOzFM1nNBtjgEyspb1FDGmzudSI2Vb+IoSs4bD5XI4JPxGpM4rtTmRMRr5gI1BcPMvrf5rO68IP4hpZQwzyofjx5L04hqV29w3qQpRPy5PFHu1pweiel0x2rtbVvRNqeGX7dYr2Y0/MgI2KITY0IchGiZnPYrXL0K6TJjwPr4BLpuxqKQB4+t6qf2vcjzsOqZQKIjE5OQLAnQTpyRuiXqqeCH7aiR3rx6bnJBXOfwiBb2qzCTGI0qv6ZkvmFk6Ht+Fc8ZnIe6NbE2XTnFF8C/6IFWYp/00o1YeJIF0HiTA+f8gVW4kdi/XLYh2yJUVt0S0dnv68QToA/ZItX8xYYPsb/SFinCO1Sn+QO/OAeRq8jLVc/tw1HjjiQRfcwHVxOP+H6AdVrT6cpyScwNIGrcSov4HcHDq55rBwU2ycQv2LlndkesrqehY9SrP9U7pB6KSBS7XOkDhcpwp21RAbG8MC1z34tjAY2vidEkZodePyZjStg8aVqKHZiE0pNsjK44gHWjxwg20Ocq3wrC17vHi+ptu4ekPlI0XcScSlFWiUwQMcHyzlDonKLPxHIuLCSxNbXZH3copWA6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4049.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(186003)(5660300002)(2906002)(7416002)(66476007)(66946007)(2616005)(26005)(6666004)(66556008)(31686004)(36756003)(4326008)(31696002)(6486002)(4001150100001)(6506007)(82960400001)(38100700002)(110136005)(83380400001)(53546011)(316002)(8676002)(86362001)(44832011)(508600001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHhLNklRaTN2SUJFNkZoaDlGYWlmcjEwb2ZUOFd0VE50UDRzUVFJMDdLaEZR?=
 =?utf-8?B?Sno3a1lzdXkvOTMxV2d2d0ZEQ3NPSWN2OE03ZnQ2dVEvQ0UrK3EvVzJEeFVR?=
 =?utf-8?B?Q09hU1BxYXMwVitpZVpNUzBHQnFSeXJuU2xoclFiek9YTCtkaFFtV1JVZXVa?=
 =?utf-8?B?bVYyWms2cjBJZm13clFNTzR6QnVGT0ZKaW1tTUtTWkF4aXZCR3dVazBqSVJa?=
 =?utf-8?B?V0FhNEl4RWlpTng5c1NXa2VTWDR6RGRrdlV5RFpFKzk1QlQ2blRuZGQzZk50?=
 =?utf-8?B?NDhzalA3eERZVkhHclBHeFZiWWxNVUJ4RFRsRUQrTk5Gdmp2d1hkRXJaZ3pi?=
 =?utf-8?B?b3ZyMDlkQm54aHNWeHdtNkh2blVQWTFMWGs5QnFqNHk3ekt3dEdYUmg0WE11?=
 =?utf-8?B?Y0xRSWFrcjdUaHRSaytaYzRxZTdnNEtQUURZYUZsN0ZINExCQWpzbHNXSFNS?=
 =?utf-8?B?Rmt4Y2VndXYvc3ljZ2M0M2NSMDhyMWJJYjRuZGNtNUwybnI4bTBkZnVvNE16?=
 =?utf-8?B?TVVPSVBkMDFrR0RmK0xOMHZjSXpRakNya2FrcXdTZkhqTkFsL3FkZXpWODFC?=
 =?utf-8?B?cmtPNUZXMUdmbUpxYlF5OGdwZ1RHdDQwOVhjamxlVVN6bG9kNWlGTVZGY1BD?=
 =?utf-8?B?NnBNemZWNVVhbm5XaHpXSEtYb2VIbG9tSGJPUHRTNWlsSVlZNnJZT3Z1RTNC?=
 =?utf-8?B?Rko4YXhYTFlkNzYvSzJYSnFpaEdpY05GOUhJMk9kQ3phRU1HSjR0RXB4WDNt?=
 =?utf-8?B?aVcvQi9EKzZVcUhTTzJGNDEyR2JiQWRFbk1jcVNqUjRxemtJeEVrS1l1aW5V?=
 =?utf-8?B?UjRoRUMzdzF0Q0dXTFk2WVl5a2w4b24ySi9nblhVWGhkVm1JNGNVNE9sVWVm?=
 =?utf-8?B?M1dsZGg4bElxMGxXR2NjSjJCNXJoa3RzYXdrNHZmbGVuWjdpb0JhK2J5bGFM?=
 =?utf-8?B?YzJzL202S01PdWxTR1ZxbFRveDcwT3F5b2UyYk83R0xqNTRIUlJ4YW9qc2tx?=
 =?utf-8?B?Nno3Z2pBOE5vTG5DN1haMXAwTjlIU25tR2s1NzkyVUlkemZ3eDc1OTJnWTZU?=
 =?utf-8?B?UkMvYjBZQUJUTjdWdGhJUW1XZ2E0N0hXRkpKZzRJenJKQkUvTGl5STZWRWUz?=
 =?utf-8?B?ejMybHVCbk9qa0E2L3EzWmJyeGFCY1ZsSmpOTWpPdytLSXUvVk4rcy8ycndv?=
 =?utf-8?B?ZmJXdGdiUTI4dHA4K0VVemNNdlgyVUNNU3dBY0JiR3RLaVh6Yjd4RkZYcW85?=
 =?utf-8?B?NlFUNkJRWS9hWmZIdWlGM0NtOEM1YlozYmtkRGRYbE1wWGQ3NkhiUjVnM0Q1?=
 =?utf-8?B?cTY1U1VQdWNjUEphRlRNSytCWnlEUTcvTm14eG1MaktzcG1GQ21IUlBSc3RY?=
 =?utf-8?B?ZkljSWpoTzlzbW95L2FnVDU2ZitnYUpzQzUrbXFZandaTldpRXFjM2xZcmxh?=
 =?utf-8?B?MU0xVWg1Vzg0N2hONml2bktENlUraGh2Y1cvODlma3p4bzd3S2RoU2tiUjJS?=
 =?utf-8?B?WU0yd24vREtBVStpTTJjQm94amYvUktNdXQraEJUdit6WVp3aEN6L1dwdkJG?=
 =?utf-8?B?Z2hQWHVTbE5Cb2FIS3EvaytEcjVwOWh2Z1hPNHR5emNIZjRzS2RETlM5Zk5H?=
 =?utf-8?B?ckVCaVpsaUdleXdqaUo2b1JzZi9qUFpjTUErMWVkTW9XczdzRHF4N2d5QklS?=
 =?utf-8?B?VitpVjdIcDdqL21DU1JLbit0UE8yZDBMZXJUenZUdlBMVm1OM3VUVTgydExS?=
 =?utf-8?B?U2I2aFJhdlVuamQxM3l1dGZkR2pSeEpKYmxKdlNNUHpWbTlhZm9rK01aekgw?=
 =?utf-8?B?L0E5NEsxZmJHb1A3TmZhUUgzblp0eU11UW9jZTFJZUpjZnNMQWVmbUw4ZVFV?=
 =?utf-8?B?M2NHU0VxSXpINGNSQzZUQ0o0cUpUUDhrclc5R3M2d3dmTi95VnE3ajJIVC84?=
 =?utf-8?B?RzBzZC9jODlETVBXRXlMeGQ4ampNV1lnKzF3eitiUkQxSjZ5cVErTm9ad2VD?=
 =?utf-8?B?eFdzOWZLMWZldFVMeXgzdFNRTElLSVJ2MUN0NU1RMDZiSTJUcEdXQ1YxNWFh?=
 =?utf-8?B?NEZGZURucE51ZGNkYmsyNTM0Z2x1ZFpURGxFSEJEWTBKSlRYNjU4MzJUZHp5?=
 =?utf-8?B?MGlER3FnZWhpeHo4SWNadm1jZFNUQkZZZG5xb0h2TU91c0g5UHFSSTdiUWoy?=
 =?utf-8?B?OEkyUUxWT0k2TE1POFFPM0xZMm5lUkRVWU5MbmwxV0g1WW40TDE4S0NLVzNv?=
 =?utf-8?Q?iMrfjXmEXUPuMM3yZ1PerduS5McJq8F2Xij0vf8rec=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c15c5288-03d0-4867-cc37-08d9c15d0bab
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 12:59:22.3942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSqBKthuAlGktwMpq8qgDmWZ5+OJr/IqnS6Xpt+PQujNPduXy0I6LXQ3s3E/srkvmVeBTTRG0gsuPfSd9w47hgCZWsMhSpiI+waU01CwopM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1282
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-16 12:43 PM, Lucas Tanure wrote:
> ASoC and HDA will do the same cs35l41_otp_unpack, so move it
> to shared code

...

> +static const struct cs35l41_otp_map_element_t *cs35l41_find_otp_map(u32 otp_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(cs35l41_otp_map_map); i++) {
> +		if (cs35l41_otp_map_map[i].id == otp_id)
> +			return &cs35l41_otp_map_map[i];
> +	}

The parenthesis could be dropped.

> +	return NULL;
> +}
> +int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap)
> +{
> +	const struct cs35l41_otp_map_element_t *otp_map_match;
> +	const struct cs35l41_otp_packed_element_t *otp_map;
> +	int bit_offset, word_offset, ret, i;
> +	unsigned int bit_sum = 8;
> +	u32 otp_val, otp_id_reg;
> +	u32 *otp_mem;
> +
> +	otp_mem = kmalloc_array(CS35L41_OTP_SIZE_WORDS, sizeof(*otp_mem), GFP_KERNEL);
> +	if (!otp_mem)
> +		return -ENOMEM;
> +
> +	ret = regmap_read(regmap, CS35L41_OTPID, &otp_id_reg);
> +	if (ret) {
> +		dev_err(dev, "Read OTP ID failed: %d\n", ret);
> +		goto err_otp_unpack;
> +	}
> +
> +	otp_map_match = cs35l41_find_otp_map(otp_id_reg);
> +
> +	if (!otp_map_match) {
> +		dev_err(dev, "OTP Map matching ID %d not found\n", otp_id_reg);
> +		ret = -EINVAL;
> +		goto err_otp_unpack;
> +	}

This block could be understood as: assign and check. Surrounding blocks 
that carry similar value do not have a newline between assignment and 
check. My suggestion is to drop that newline here so the block looks 
more cohesive when compared with the rest of the function.

> +
> +	ret = regmap_bulk_read(regmap, CS35L41_OTP_MEM0, otp_mem, CS35L41_OTP_SIZE_WORDS);
> +	if (ret) {
> +		dev_err(dev, "Read OTP Mem failed: %d\n", ret);
> +		goto err_otp_unpack;
> +	}
> +
> +	otp_map = otp_map_match->map;
> +
> +	bit_offset = otp_map_match->bit_offset;
> +	word_offset = otp_map_match->word_offset;
> +
> +	ret = regmap_write(regmap, CS35L41_TEST_KEY_CTL, 0x00000055);
> +	if (ret) {
> +		dev_err(dev, "Write Unlock key failed 1/2: %d\n", ret);
> +		goto err_otp_unpack;
> +	}
> +	ret = regmap_write(regmap, CS35L41_TEST_KEY_CTL, 0x000000AA);
> +	if (ret) {
> +		dev_err(dev, "Write Unlock key failed 2/2: %d\n", ret);
> +		goto err_otp_unpack;
> +	}
> +
> +	for (i = 0; i < otp_map_match->num_elements; i++) {
> +		dev_dbg(dev, "bitoffset= %d, word_offset=%d, bit_sum mod 32=%d\n",
> +			bit_offset, word_offset, bit_sum % 32);
> +		if (bit_offset + otp_map[i].size - 1 >= 32) {
> +			otp_val = (otp_mem[word_offset] &
> +					GENMASK(31, bit_offset)) >> bit_offset;
> +			otp_val |= (otp_mem[++word_offset] &
> +					GENMASK(bit_offset + otp_map[i].size - 33, 0)) <<
> +					(32 - bit_offset);
> +			bit_offset += otp_map[i].size - 32;
> +		} else {
> +			otp_val = (otp_mem[word_offset] &
> +				   GENMASK(bit_offset + otp_map[i].size - 1, bit_offset)
> +				  ) >> bit_offset;

The ')' looks off (the '>>' too), at least it does not match the 
convention seen in if-statement above. Choosing single convention could 
improve the readability.

> +			bit_offset += otp_map[i].size;
> +		}
> +		bit_sum += otp_map[i].size;
> +
> +		if (bit_offset == 32) {
> +			bit_offset = 0;
> +			word_offset++;
> +		}
> +
> +		if (otp_map[i].reg != 0) {
> +			ret = regmap_update_bits(regmap, otp_map[i].reg,
> +						 GENMASK(otp_map[i].shift + otp_map[i].size - 1,
> +							 otp_map[i].shift),
> +						 otp_val << otp_map[i].shift);
> +			if (ret < 0) {
> +				dev_err(dev, "Write OTP val failed: %d\n", ret);
> +				goto err_otp_unpack;
> +			}
> +		}
> +	}
> +
> +	ret = regmap_write(regmap, CS35L41_TEST_KEY_CTL, 0x000000CC);
> +	if (ret) {
> +		dev_err(dev, "Write Lock key failed 1/2: %d\n", ret);
> +		goto err_otp_unpack;
> +	}
> +	ret = regmap_write(regmap, CS35L41_TEST_KEY_CTL, 0x00000033);
> +	if (ret) {
> +		dev_err(dev, "Write Lock key failed 2/2: %d\n", ret);
> +		goto err_otp_unpack;
> +	}
> +	ret = 0;

Hmm.. maybe I'm missing something, but isn't the 'ret' already '0' by 
the time we get here?

> +err_otp_unpack:
> +	kfree(otp_mem);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cs35l41_otp_unpack);
> +

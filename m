Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98D858B6A2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbiHFP5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiHFP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:57:16 -0400
X-Greylist: delayed 515 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 Aug 2022 08:57:15 PDT
Received: from freundtech.com (freundtech.com [IPv6:2a01:4f8:c17:2d66::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3896FE0F5;
        Sat,  6 Aug 2022 08:57:15 -0700 (PDT)
Received: from [192.168.178.22] (dslb-002-206-038-062.002.206.pools.vodafone-ip.de [2.206.38.62])
        by freundtech.com (Postfix) with ESMTPSA id 4644D1EABB4;
        Sat,  6 Aug 2022 17:48:38 +0200 (CEST)
Message-ID: <96a8bb05-d2b0-8a98-bdec-426fd5879390@freund.io>
Date:   Sat, 6 Aug 2022 17:48:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/1] HID: amd_sfh: Add keyguard for ASUS ROG X13 tablet
Content-Language: en-US
To:     "Luke D. Jones" <luke@ljones.dev>, linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        jikos@kernel.org, basavaraj.natikar@amd.com,
        nehal-bakulchandra.shah@amd.com
References: <20220803064109.766342-1-luke@ljones.dev>
From:   Adrian Freund <adrian@freund.io>
In-Reply-To: <20220803064109.766342-1-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

I stumbled on this patch while trying to get the tablet mode switch 
working on a Lenovo ThinkPad L13 Yoga Gen2 (AMD), which also uses an 
amd_sfh based switch.

This patch also gets it to work on that device, but there are some problems.

Here's my review:

1. In drivers/hid/amd_sfh_hid/amd_sfh_hid.h you need to increase 
MAX_HID_DEVICES from 5 to 6 or you will run into memory corruption in 
case a device with all types of sensors exists.

2. in drivers/hid/amd_sfh_hid/amd_sfh_client.c you should add 
KBGUARD_IDX to the get_sensor_name() function. I think that's only used 
for debug messages, but it should still be complete.

3. & 4. See in-patch annotations

On 8/3/22 08:41, Luke D. Jones wrote:
> Add support for ROG X13 Flow 2-in-1 to disable the keyboard when
> the lid is flipped.
>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        |  7 ++++-
>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.h        |  1 +
>   .../hid_descriptor/amd_sfh_hid_desc.c         | 27 +++++++++++++++++++
>   .../hid_descriptor/amd_sfh_hid_desc.h         |  9 +++++++
>   .../hid_descriptor/amd_sfh_hid_report_desc.h  | 19 +++++++++++++
>   5 files changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> index dadc491bbf6b..243541d426d8 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> @@ -26,6 +26,7 @@
>   #define ACEL_EN		BIT(0)
>   #define GYRO_EN		BIT(1)
>   #define MAGNO_EN	BIT(2)
> +#define KBGUARD_EN	BIT(15)
>   #define HPD_EN		BIT(16)
>   #define ALS_EN		BIT(19)
>   
> @@ -232,6 +233,9 @@ int amd_mp2_get_sensor_num(struct amd_mp2_dev *privdata, u8 *sensor_id)
>   	if (HPD_EN & activestatus)
>   		sensor_id[num_of_sensors++] = HPD_IDX;
>   
> +	if (KBGUARD_EN & activestatus)
> +		sensor_id[num_of_sensors++] = KBGUARD_IDX;
> +
>   	return num_of_sensors;
>   }
>   
> @@ -373,7 +377,8 @@ static int __maybe_unused amd_mp2_pci_suspend(struct device *dev)
>   
>   	for (i = 0; i < cl_data->num_hid_devices; i++) {
>   		if (cl_data->sensor_idx[i] != HPD_IDX &&
> -		    cl_data->sensor_sts[i] == SENSOR_ENABLED) {
> +			cl_data->sensor_idx[i] != KBGUARD_IDX &&
> +			cl_data->sensor_sts[i] == SENSOR_ENABLED) {
Is there a reason you don't stop the kbguard sensor on suspend? This 
breaks on my device. When not stopping the kbguard sensor my accelerator 
and kbguard sensor are both broken after resume (I don't know about the 
other sensor types, as my device doesn't have them), until reboot. When 
stopping the kbguard sensor on suspend everything still works after resume.
Also the condition continuation lines are indented too much.
>   			mp2->mp2_ops->stop(mp2, cl_data->sensor_idx[i]);
>   			status = amd_sfh_wait_for_response
>   					(mp2, cl_data->sensor_idx[i], SENSOR_DISABLED);
> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
> index 8c760526132a..4a86bc6038a2 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
> @@ -36,6 +36,7 @@
>   #define SENSOR_DISABLED    5
>   
>   #define HPD_IDX		16
> +#define KBGUARD_IDX	15
>   
>   #define AMD_SFH_IDLE_LOOP	200
>   
> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> index 76095bd53c65..f41d28ea7b93 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
> @@ -57,6 +57,11 @@ int get_report_descriptor(int sensor_idx, u8 *rep_desc)
>   		memcpy(rep_desc, hpd_report_descriptor,
>   		       sizeof(hpd_report_descriptor));
>   		break;
> +	case KBGUARD_IDX: /* kbguard ? */
> +		memset(rep_desc, 0, sizeof(kbguard_report_descriptor));
> +		memcpy(rep_desc, kbguard_report_descriptor,
> +		       sizeof(kbguard_report_descriptor));
> +		break;
>   	default:
>   		break;
>   	}
> @@ -116,6 +121,16 @@ u32 get_descr_sz(int sensor_idx, int descriptor_name)
>   			return sizeof(struct hpd_feature_report);
>   		}
>   		break;
> +	case KBGUARD_IDX:
> +		switch (descriptor_name) {
> +		case descr_size:
> +			return sizeof(kbguard_report_descriptor);
> +		case input_size:
> +			return sizeof(struct kbguard_input_report);
> +		case feature_size:
> +			return sizeof(struct kbguard_feature_report);
> +		}
> +		break;
>   
>   	default:
>   		break;
> @@ -139,6 +154,7 @@ u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report)
>   	struct gyro_feature_report gyro_feature;
>   	struct magno_feature_report magno_feature;
>   	struct hpd_feature_report hpd_feature;
> +	struct kbguard_feature_report kbguard_feature;
>   	struct als_feature_report als_feature;
>   	u8 report_size = 0;
>   
> @@ -186,6 +202,11 @@ u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report)
>   		memcpy(feature_report, &hpd_feature, sizeof(hpd_feature));
>   		report_size = sizeof(hpd_feature);
>   		break;
> +	case KBGUARD_IDX:  /* auto disable keyboard when flip out */
> +		get_common_features(&kbguard_feature.common_property, report_id);
> +		memcpy(feature_report, &kbguard_feature, sizeof(kbguard_feature));
> +		report_size = sizeof(kbguard_feature);
> +		break;
>   
>   	default:
>   		break;
> @@ -210,6 +231,7 @@ u8 get_input_report(u8 current_index, int sensor_idx, int report_id, struct amd_
>   	struct accel3_input_report acc_input;
>   	struct gyro_input_report gyro_input;
>   	struct hpd_input_report hpd_input;
> +	struct kbguard_input_report kbguard_input;
>   	struct als_input_report als_input;
>   	struct hpd_status hpdstatus;
>   	u8 report_size = 0;
> @@ -262,6 +284,11 @@ u8 get_input_report(u8 current_index, int sensor_idx, int report_id, struct amd_
>   		report_size = sizeof(hpd_input);
>   		memcpy(input_report, &hpd_input, sizeof(hpd_input));
>   		break;
> +	case KBGUARD_IDX: /* kb guard */
> +		get_common_inputs(&kbguard_input.common_property, report_id);
> +		report_size = sizeof(kbguard_input);
> +		memcpy(input_report, &kbguard_input, sizeof(kbguard_input));
> +break;
Missing indentation
>   	default:
>   		break;
>   	}
> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
> index 70b1b7abe2c6..98571a8597b3 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
> @@ -105,12 +105,21 @@ struct hpd_feature_report {
>   	struct common_feature_property common_property;
>   } __packed;
>   
> +struct kbguard_feature_report {
> +	struct common_feature_property common_property;
> +} __packed;
> +
>   struct hpd_input_report {
>   	struct common_input_property common_property;
>   	 /* values specific to human presence sensor */
>   	u8 human_presence;
>   } __packed;
>   
> +struct kbguard_input_report {
> +	struct common_input_property common_property;
> +} __packed;
> +
> +
>   int get_report_descriptor(int sensor_idx, u8 rep_desc[]);
>   u32 get_descr_sz(int sensor_idx, int descriptor_name);
>   u8 get_feature_report(int sensor_idx, int report_id, u8 *feature_report);
> diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> index 697f2791ea9c..7a62fcec2c73 100644
> --- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> +++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
> @@ -644,6 +644,25 @@ static const u8 als_report_descriptor[] = {
>   0xC0			/* HID end collection */
>   };
>   
> +
> +static const u8 kbguard_report_descriptor[] = {
> +0x06, 0x43, 0xFF,  // Usage Page (Vendor Defined 0xFF43)
> +0x0A, 0x02, 0x02,  // Usage (0x0202)
> +0xA1, 0x01, // Collection (Application)
> +0x85, 0x11, //   Report ID (17)
> +0x15, 0x00, //   Logical Minimum (0)
> +0x25, 0x01, //   Logical Maximum (1)
> +0x35, 0x00, //   Physical Minimum (0)
> +0x45, 0x01, //   Physical Maximum (1)
> +0x65, 0x00, //   Unit (None)
> +0x55, 0x00, //   Unit Exponent (0)
> +0x75, 0x01, //   Report Size (1)
> +0x95, 0x98, //   Report Count (-104)
> +0x81, 0x03, //   Input (Const,Var,Abs,No Wrap,Linear,Preferred State,No Null Position)
> +0x91, 0x03, //   Output (Const,Var,Abs,No Wrap,Linear,Preferred State,No Null Position,Non-volatile)
> +0xC1, 0x00, // End Collection
> +};
> +
>   /* BIOMETRIC PRESENCE*/
>   static const u8 hpd_report_descriptor[] = {
>   0x05, 0x20,          /* Usage page */


Best Regards
Adrian


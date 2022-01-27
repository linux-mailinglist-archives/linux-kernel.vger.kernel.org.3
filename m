Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A7449E78E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243756AbiA0Qbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:31:47 -0500
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:7021
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231582AbiA0Qbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:31:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5gY1bEMVWBNBDREqpSr1yeCnphbzjjk9msCCf79CCDav3W6Jzebc6+e/G6GJgvNIqtOxwsoR/3Ri5KOb8zB8M77QCmaUsYCNCiAK2CR9o/VshybYZ99o83YdaPX4Q6mGnDdqC2oV9a36jAlBZoB/+YF6x4aDh5pNOTPcvGUoJ7PD5zqQ4mST6rdAS6SZC49CDUsrtZO0qLNT89pqTCSDGpTaXCqz9XY0Ba/CMbqScTVoIMQHptCrAH/WNJ1hDM+9RtgnHot759VoCGjzcWbasDeXCvEHFig8wbZoZlty3v5G6hDDsnbRIzZytx6Y2Y7YO0JmWOtZBJlkEmXabNtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCCka6hsxYute1qAGEek2BhCbCbUg4LDEl+ofKkVVV0=;
 b=cMDGGfioGHGEJdJx6zEBYDaGmCTnDv6EPm5C1smkNCyt//4jM3g02BZ0x2XcZR2YnBubRSomL8up5Fvmj/RkeoMACRxrfrAGkInlkTODSrGW2eFT0bUjE+rXFVmlkLbt/gYpPx5bgGExsOzrpHYTVFeGt36GEDgt2JGZEfr2xCeVkLFoGEqYJSRLKk8IoTsewwgsrsnGrOp8fLoC3huqxQPFo7EEHyKncHn090CRd6nX8qnrFzlfqktkniBV5EZj2ffF4b/28A90XboBFEAe5m5mi5bCacxtbiR3fpLD4V/s788ZSJeoUZ3uazDrA0uu/viKIExmXKG5oU3OwO6/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCCka6hsxYute1qAGEek2BhCbCbUg4LDEl+ofKkVVV0=;
 b=ti9GGnhze7GddLfLVm+p8YRpW12IGWdZRdhRMJcErMkhzb+AeBQ6cKWZaoWeiuF2+99fkV1nFWXDM3UVjpzKyX0SzcQqKvcWDF5cPjrn5827+6bnh4GHen9z1ImP3XwNbmffE8TfUQlQDC3fY1vy8eCYT4mTvoIXM+EOLX4TxaLXHy2QawfRo8RSPPl1C4tLVQFHxtSxniqI+LUSYFRcAFyeegMQIe2T7MF/6LyzS3Ws0BQ19OIvgWPpJQCItXxpFOdJ8mgarC7u56CE6yzzZV+n6lA870desrJCajj9JXj00IGz+4lsLj+Opsb5ZTDdxHp1GXJWzhZdYhFAporAfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by PA4PR03MB7055.eurprd03.prod.outlook.com (2603:10a6:102:ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 16:31:36 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 16:31:36 +0000
Subject: Re: [PATCH v2 1/2] usb: ulpi: Add debugfs support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20220124173344.874885-1-sean.anderson@seco.com>
 <YfFHFnPYeW0H8+/Y@kroah.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <725f1031-02eb-998f-46d4-0dd616a35d6a@seco.com>
Date:   Thu, 27 Jan 2022 11:31:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YfFHFnPYeW0H8+/Y@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0099.namprd02.prod.outlook.com
 (2603:10b6:208:51::40) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23397bf8-b124-4421-b5f8-08d9e1b27c8f
X-MS-TrafficTypeDiagnostic: PA4PR03MB7055:EE_
X-Microsoft-Antispam-PRVS: <PA4PR03MB705546F2D5BDA26A73A5C07696219@PA4PR03MB7055.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruiznEapxlXcZVzNpBC2DmflQRlHYGrNhEbucV7H8XDqrK1ShMYipMM6fo8SeKlz/t4H15mIVo80rE7GXiztnWkYa/mTIUStOrh5zs71wmjXI/DgvDmWU6PgylQ1IOWiychE37pDYrVn+NXv/MN1bFz/lBkD+Ud4402zNFU8H5uEqlr4Ge4lWh5fgX/OnZc78ZjgrbwTlmwRddgzL1MubsydHwlMrWvqEsDNkoFuoFmmfclXDhyZKXg8ShhumWDmCP0oTMF9t52ckYcNAZfKYnUsZiRDQjFH3bGdMI1xKSMJMy5ZoIZSxXKEl0OGlNGE9XJU6Kx0nycxOcqqnGl0jKfS4jSURjoNmR1gNYssRQaxuVRPRKWCoHWLQmlvq3EOqhDBhMZtG4dgvvDEIUw7pLu8/FTNFpVq8L1M36A2AVSPEs9PW2Kv28RP33kqk22ahAsxKRtHO5CE3HK353i92BHv/d3C8bM+9YLCSVGuLw++Q2MQibshZPwDwv6ZmRGfm6J4o7ltSAhAzowGOK/QxIzuIkVXmKEZQoBnUpbdppqRWCyBoyMp/oAQqX62fmHTpbzBI7FPHca44vdhL8xPrJBfKGLPWV+Dcr70MkRo6M8lN/CCPn5wsE1uIhIze/s7j/ApDhsk+O1E4W7H5u16COJVaOUOj6VZXJefelZOFW8YXRTGHxWBsPzZoprW2Gyeot9dBHNbyZvwO9WWCiwOIgXzO1VOq9hxBrEA0FDRr9E90te/4JxyOYnWTHYs48Hs5Iiphkm7hB1im+RblUnkzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(186003)(2616005)(66476007)(66556008)(66946007)(8936002)(2906002)(83380400001)(4326008)(8676002)(36756003)(31696002)(86362001)(5660300002)(38350700002)(31686004)(6666004)(6916009)(44832011)(508600001)(6486002)(316002)(38100700002)(6506007)(52116002)(53546011)(6512007)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFRRUjhXNjQ2WDBlNytBZU5UaHhMZlBwYVljRVhTWEVyRjlXcXBaaldTbGxr?=
 =?utf-8?B?K2JXdElUdUtKYWQyVHBvZEZLVkpxM1pOSXJDc056NUlvdE1BL3hmWDRkUmhU?=
 =?utf-8?B?Q09KelFCRllNUmQwNkhYczNHUFVHVlVjaWo3M3ZpcC94SVJFZDdGTjg1OWtK?=
 =?utf-8?B?bHdObFk1UVJaMU80Vk1GcjV6dFV6Tkk3Z3YwemUreVBvdGRzbGxZMnZ6ZHlK?=
 =?utf-8?B?bjJxbWI2eDFZQmZqU3lINlh2Qk1IdXEzNXAzb0tDM0ZWQVVMQ1V5WmtSQ0JE?=
 =?utf-8?B?ZXBoNXBCaVVvUnlEeS9OSHpxa0xLV3lIN2RmU0c2Q3I0Z3FPaWRGay9QV3RC?=
 =?utf-8?B?VXY3elJmNkRDRjZyQ3FUSHBvbTdoZXBBWkpCcGFLRDBPcGhxelc5ejFkNTRp?=
 =?utf-8?B?WUxQa2E5SGJSRlhrNTFwa0RnRlVMUWlkMmNRYjBoODUrNGViRGNCcmZDZWd2?=
 =?utf-8?B?bFZraTZOMCtxSy9PczE5MHNhQ3VEeFlvME4reG1rZ21SYkdOVmRGYTB1S2NM?=
 =?utf-8?B?ZzM3NEkrTnRaRFlGZ1g0ekM5d0RrWUhRcVhWZ1lkamZRNlhPUCs2TElYTVgy?=
 =?utf-8?B?ZFlwY3M4RWpCclJTWHlrQ1RnSk9hVWswMDkvYTBRbzdyVlFkQXkxajJnRVJk?=
 =?utf-8?B?REN3YllTU1JReVp5VGhvOThiOUpxQzZHcUdORmxseTVzbHR3emJkQTFkOFRa?=
 =?utf-8?B?aVBpK0Z1TUJzeTgwTVVaOVZMTEp6dFlqWm9RZWRUUjdTZDlzMFpBZ3NiZHQ0?=
 =?utf-8?B?RVdmSkMySU5ZS28xWlYzV3pCenVNQ05UUXdPSDdhMW95cTRpVE5ldnZ3VFNy?=
 =?utf-8?B?WEdiVnBwRndGOWxpRVp6Q3VXWUlnSFFLK0ZaV2pOSUtiM2NoQmYrUENSWGl3?=
 =?utf-8?B?NCtKWmJHQlNlV1ZRUUl2OWxNbHh3eWpGc1FmU0dnOE5BM2xLcUhXU0NSNVhv?=
 =?utf-8?B?dGJUOEo0Qmwwb1FUL3RoZ3YzZEU0Y29oYkJzU0tpWm5YL3FZdVNWSEpBZ3pp?=
 =?utf-8?B?c2pNaGRLRGpzaFFIdHZLVHB0c2YwWlNxZEFqcjdmRzkvdVdtUWpaV3RRNVdF?=
 =?utf-8?B?eXZTTXRSUy82NC9paUFaODV5cnFuUjJCWTU1bzh6MTRTYXRhZlhaUUp2b1NH?=
 =?utf-8?B?ZUVmbEppaGZyd21HSUREYUlLOEUwbDJtRG5ja2QzbitzYTFEVVZpNjJhK2gr?=
 =?utf-8?B?bFNtNFIvWktMNS9zS0wxYnMxcUdodDdnWGh6UDk5cXh2S21kYUxFQ3N0bHBW?=
 =?utf-8?B?V2lDY0Vaa3hJUnBsbzlHQ3JYVVNyVjlnOStWTUc3MmJSdjZySmhUakx4MXZR?=
 =?utf-8?B?Wkk2Z1BhYk90ZVlaODNCTjF6UFZqcVQvVk1RSUY5cm5RalY1OW1zTVo4Z2Z1?=
 =?utf-8?B?WnRVYlFSUUdNVUR4b1BjZXplUVROS2U2MEVDNHg5eEJ5cEZpeENFODZSWjNX?=
 =?utf-8?B?Qkx0bFlmK2FmNlRyQ1pUeXZrNVNzK1hWUTAwNERPd1MvTkttYmkzYk4vUExD?=
 =?utf-8?B?OEhGbEROME1yTVhuNDV1VnBCT24rMWdMRWpnRUw5YW55Ti9IR0s4bktDNVk5?=
 =?utf-8?B?dzVUMlQyN0VnaXNQd0E3VENlY1YreGhvWlZlM0dZQ05vYjBSU01LNHJjYjNq?=
 =?utf-8?B?SnNZcnR4NEpmaWpsaFRtUk5MWUdkNUVKbHdNMis5cjN3Y21rcjJUV0I1S092?=
 =?utf-8?B?aUZ5WWJQa0tsZ0VnU05ub0p6RitMSERGdVZITUh2ZXBjYU1TbmovazNIek42?=
 =?utf-8?B?eWlmYUZiTjRHTmhtcUFCakdRNkdtL0JvMmJIZXlzMS8zS0F6dzNXeUVzRnYx?=
 =?utf-8?B?Wm5zR2h1MXd2aG9hK2RaZmcyTTY3S1g3TmJucVMrTzQxNnhqN1R6OFJMQXZn?=
 =?utf-8?B?cWEzTi91Ty9MOWVvVzJhVWllZW1ZeU1Xa0ozbXowTnNKMEluNm11d21JMlJ0?=
 =?utf-8?B?bkhHV3BzMjlJVTIyYm5RM1JpVUtEbExhRTB1aG4zRVU5OTBoZ1U3L28rbEZv?=
 =?utf-8?B?a2JONllmYXVNd0hPU3VZVENZSk1oaWVHMlBzY1BwRGpiOEc3T3E3clRndmRW?=
 =?utf-8?B?OVlUd2ZxdzMzTHZ0d1hKWTViSUhhYi95eENDVVVPNTJESDZJRCtUdnUzRWFl?=
 =?utf-8?B?Q0tTcGx5VVdmQStjWlhVbWpNK3dtajZhQ3ZrYWJVMzVHSFNtanoxNkxMTUor?=
 =?utf-8?Q?M1xXWkHKBJs9ptrT/wBr1ak=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23397bf8-b124-4421-b5f8-08d9e1b27c8f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 16:31:36.0794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8N/162wVQig2ZIcarZdJgXuJCu4Ns4qWCS3TXWz+zSl+byUoN8TpXSTlyZ7+7U97rc15KiFWWFrNG3wi13peQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/22 8:05 AM, Greg Kroah-Hartman wrote:
> On Mon, Jan 24, 2022 at 12:33:43PM -0500, Sean Anderson wrote:
>> This adds a debugfs file for ULPI devices which contains a dump of their
>> registers. This is useful for debugging basic connectivity problems. The
>> file is created in ulpi_register because many devices will never have a
>> driver bound (as they are managed in hardware by the USB controller
>> device).
>> 
>> This also modifies the error handling in ulpi_register a bit to ensure
>> that ulpi->dev.of_node is always put.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>> Changes in v2:
>> - Always create debugfs files and ignore errors
>> - Look up dentries dynamically
>> 
>>  drivers/usb/common/ulpi.c | 71 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 70 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
>> index 4169cf40a03b..87deb514eb78 100644
>> --- a/drivers/usb/common/ulpi.c
>> +++ b/drivers/usb/common/ulpi.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/module.h>
>>  #include <linux/slab.h>
>>  #include <linux/acpi.h>
>> +#include <linux/debugfs.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>>  #include <linux/clk/clk-conf.h>
>> @@ -228,9 +229,64 @@ static int ulpi_read_id(struct ulpi *ulpi)
>>  	return 0;
>>  }
>>  
>> +static int ulpi_regs_read(struct seq_file *seq, void *data)
>> +{
>> +	struct ulpi *ulpi = seq->private;
>> +
>> +#define ulpi_print(name, reg) do { \
>> +	int ret = ulpi_read(ulpi, reg); \
>> +	if (ret < 0) \
>> +		return ret; \
>> +	seq_printf(seq, name " %.02x\n", ret); \
>> +} while (0)
>> +
>> +	ulpi_print("Vendor ID Low               ", ULPI_VENDOR_ID_LOW);
>> +	ulpi_print("Vendor ID High              ", ULPI_VENDOR_ID_HIGH);
>> +	ulpi_print("Product ID Low              ", ULPI_PRODUCT_ID_LOW);
>> +	ulpi_print("Product ID High             ", ULPI_PRODUCT_ID_HIGH);
>> +	ulpi_print("Function Control            ", ULPI_FUNC_CTRL);
>> +	ulpi_print("Interface Control           ", ULPI_IFC_CTRL);
>> +	ulpi_print("OTG Control                 ", ULPI_OTG_CTRL);
>> +	ulpi_print("USB Interrupt Enable Rising ", ULPI_USB_INT_EN_RISE);
>> +	ulpi_print("USB Interrupt Enable Falling", ULPI_USB_INT_EN_FALL);
>> +	ulpi_print("USB Interrupt Status        ", ULPI_USB_INT_STS);
>> +	ulpi_print("USB Interrupt Latch         ", ULPI_USB_INT_LATCH);
>> +	ulpi_print("Debug                       ", ULPI_DEBUG);
>> +	ulpi_print("Scratch Register            ", ULPI_SCRATCH);
>> +	ulpi_print("Carkit Control              ", ULPI_CARKIT_CTRL);
>> +	ulpi_print("Carkit Interrupt Delay      ", ULPI_CARKIT_INT_DELAY);
>> +	ulpi_print("Carkit Interrupt Enable     ", ULPI_CARKIT_INT_EN);
>> +	ulpi_print("Carkit Interrupt Status     ", ULPI_CARKIT_INT_STS);
>> +	ulpi_print("Carkit Interrupt Latch      ", ULPI_CARKIT_INT_LATCH);
>> +	ulpi_print("Carkit Pulse Control        ", ULPI_CARKIT_PLS_CTRL);
>> +	ulpi_print("Transmit Positive Width     ", ULPI_TX_POS_WIDTH);
>> +	ulpi_print("Transmit Negative Width     ", ULPI_TX_NEG_WIDTH);
>> +	ulpi_print("Receive Polarity Recovery   ", ULPI_POLARITY_RECOVERY);
>> +
>> +	return 0;
>> +}
>> +
>> +static int ulpi_regs_open(struct inode *inode, struct file *f)
>> +{
>> +	struct ulpi *ulpi = inode->i_private;
>> +
>> +	return single_open(f, ulpi_regs_read, ulpi);
>> +}
>> +
>> +static const struct file_operations ulpi_regs_ops = {
>> +	.owner = THIS_MODULE,
>> +	.open = ulpi_regs_open,
>> +	.release = single_release,
>> +	.read = seq_read,
>> +	.llseek = seq_lseek
>> +};
>> +
>> +#define ULPI_ROOT debugfs_lookup(KBUILD_MODNAME, NULL)
>> +
>>  static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>>  {
>>  	int ret;
>> +	struct dentry *root;
>>  
>>  	ulpi->dev.parent = dev; /* needed early for ops */
>>  	ulpi->dev.bus = &ulpi_bus;
>> @@ -251,6 +307,9 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>>  	if (ret)
>>  		return ret;
>>  
>> +	root = debugfs_create_dir(dev_name(dev), ULPI_ROOT);
>> +	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_ops);
>> +
>>  	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
>>  		ulpi->id.vendor, ulpi->id.product);
>>  
>> @@ -296,6 +355,8 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
>>   */
>>  void ulpi_unregister_interface(struct ulpi *ulpi)
>>  {
>> +	debugfs_remove_recursive(debugfs_lookup(dev_name(&ulpi->dev),
>> +						ULPI_ROOT));
>>  	of_node_put(ulpi->dev.of_node);
>>  	device_unregister(&ulpi->dev);
>>  }
>> @@ -305,13 +366,21 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
>>  
>>  static int __init ulpi_init(void)
>>  {
>> -	return bus_register(&ulpi_bus);
>> +	int ret;
>> +	struct dentry *root;
>> +
>> +	root = debugfs_create_dir(KBUILD_MODNAME, NULL);
> 
> The file could be accesed now, but you don't register the bus until
> after this returns:
> 
>> +	ret = bus_register(&ulpi_bus);
>> +	if (ret)
>> +		debugfs_remove(root);
> 
> Can you flip the order around please?

This is just registering the holding directory. To ensure that we
don't race like

CPU 1			CPU 2

bus_register()
			ulpi_register_interface()
			debugfs_lookup() /* whoops, no directory */

debugfs_create_dir()

By registering the directory first, we ensure that devices added
will always have a directory to put their debugfs files under.

--Sean

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611534984BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbiAXQ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:28:34 -0500
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:53509
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241118AbiAXQ2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:28:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBomobr3lnymkMjZVoGhFhQJ4Lc3xTjmDYDuT1ReMKfnQhdC2pTnC0xORv3HbudE0FrcbpHPke1j5WgR3jmuNmYW9IDiDNo++wkllgD9ZUeufHvY1zw0zRDfHf8HOEGJJR3eIuukxQPDPTQLvYiZinf7vyERkDGsw5mrteQjN9ucLXC6QyZzPFMz/ftgqqWhu3XV1VYE7F7r5h8JQalPzK+OHN6dc5zy1da8sGHC1fMGvElqLQaTHRj5prVOO3glwbBEXavSF1EexsoCor30m939Y/1qOBZQsn2NrBhF7dxKIhJ/lrBq0ywXn3ncMVX1R0f1Vs9i/0+IpM6cOAWkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1mzHAB0xICboyDim3eK8sfCFtUy6SzqgyBcA7H3o+0=;
 b=OnSCuPDB+FsTt3dH1YIwSbJ3gr51HEt2l5JFzTAMHX/9XtRTpxnbJPfTj4ivwR087DAMiNEW+mP4qGrtxS49ch3JUvM8coZFoIzztwtgv14xica/ylzfECmAhTGw7znYmWYfVkTxhkHqEGS1RqrGkQ3P06/PFfvOegjXO6GbGeq90SiRVrlJ6kNJEZ444FWG393tLpvK6gVcX6Gt5xpFYfUNvyVF1nab4Vno4ifDhqyd8xAVuhK9hv/Uh7vhWco/fp4CVYuTNcQW9+P+J0CBCxyaTr4ke2vVhkOsc1dQxhHnwzKn6I2WzA/6IKUHlbsnuJRIGNuVYuQezw4CAn7ChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1mzHAB0xICboyDim3eK8sfCFtUy6SzqgyBcA7H3o+0=;
 b=bCxSGbdLNQxbhaN7c8+wRKrKZGqJj53EajMlOQDN6zYH3/hhW7V4y+6Am7MJ1AyprnoQ/DqLPHw99YzezGWttlNi/3Vxqst8VzN/lEs5udQqfjm5RG7U4OMkCvEyMzGy4WYXIP1ZRiHUwHphYhmzJI39yXIhCxENx6pmusqoJuvPXcvTZ9qJJkVr+pKN1IoQ0jsKO/QM4Xr2ACRPRHZ9PNxnnwp+bEaLDIoGSk3IPTxIbEyuv90wW9FqoeIUvw3tVUwg43nMc5AnlfJufYO0t4vE1VA/pH+BGf9r5DDMwiAibslnDQ6ZOxQsj5ks1Ow7No/3aqdo48yCGdQaVPHVqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5255.eurprd03.prod.outlook.com (2603:10a6:10:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Mon, 24 Jan
 2022 16:28:30 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 16:28:30 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH] usb: ulpi: Add debugfs support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20220114163947.790078-1-sean.anderson@seco.com>
 <Ye07t/O8oOQRILyZ@kroah.com>
Message-ID: <d317e3bb-fe99-d82c-5cab-2f318ed39906@seco.com>
Date:   Mon, 24 Jan 2022 11:28:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <Ye07t/O8oOQRILyZ@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0037.namprd02.prod.outlook.com
 (2603:10b6:207:3d::14) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62dc1b2d-807e-44db-2928-08d9df568e83
X-MS-TrafficTypeDiagnostic: DBBPR03MB5255:EE_
X-Microsoft-Antispam-PRVS: <DBBPR03MB52552E002652DC941329069E965E9@DBBPR03MB5255.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9GHrqIn0AdHbiE6IuYQasMAZshLYdyXGl5g+7+UQZLMkqIO/1Q3ndApA1BSU2V3j/prx3V+sM6hf9p4T1IZ6crkb+nnHh6MmdMC1SgF0FMBncCHZKCVPM7A3POpyhhpD7uYdsmaKfj34ayhWuXFnOW0unepyc+VvrR81/adfHwbwLwqq6MdITBUAEDHsm/AASKMH+r6pSsw40xJKP0B9zZ04CS2nYzwrYBIkiQ0K4TBQfX8tbNA6QY6BlXZMi6SA0CX+ncDy585R0Gbelx2oAvF+6MbEUqJ6XGIdh7FQn2mI1FmhJKkvyqWuP6fmYt10rjcn9qemoWckhab3p6QphxinFgFzpRAJ9rQ3pEwqFhPOBSQ+pHcPc3WA3VD26I4haKmn/Q/8eQeOzevKfjo1T/ts1DY6m/YIFb/bufn7AaBWjXbJGDr+6nzIbdlxSDvNkIdsb4eFN8Gr9uGjglBAep2Z3ZoWdaXsCawsOG6Ua7qhlObsC1gyzMd/8jyG8Vz8eU+Y35QjsugYj+hn8Zjdg+uLb+SBkH/Wk75gP5dqWpnGbl/1u2LD+khv2t74iTZ8EwQZzobpMhiF1RfsvoWEXpVhi3WjBreF4odV0HEPszpOQW3MQq2/Kz+VtaU+Gs5uPvxRfVhEbueePJpRJo9l5qkLVXkDZn5v0UY0wfDQlZQBKvms0gnIo2rDtwOAc065B9Um6TVlGeKBDAesl//cJ1KCeyot8/3Fj5rUShVYpF4R57cFguNxV0F+EZXGcRNK437PypY00VuNCU4+pnDvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(6486002)(6916009)(2616005)(31686004)(53546011)(44832011)(8676002)(66556008)(66946007)(5660300002)(4326008)(316002)(86362001)(8936002)(36756003)(6512007)(26005)(52116002)(186003)(2906002)(508600001)(38350700002)(6506007)(31696002)(38100700002)(83380400001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHRrS0pwaFRJeW05RVFxdkMxVG5NM1lrZWhUUTdOTVlBWjJTT3VBeEJ4UHZv?=
 =?utf-8?B?Wjc0WUdEZ0s2OTBQL1YyUlh0RmNrRkNMZUl5bFYrZTRlbnRCb1FpWWYzS1pn?=
 =?utf-8?B?RWZXenZ3OHFTdHh4R0E3WWJSbDAzNjdQZVY5UVJiTkllUjBsNE43ZHl4bkY4?=
 =?utf-8?B?S0Q3K01HbGp5WEpzNW1MS2c2TGY4Y1JZdndlekllUDhoQzh0dlBsMjFiY2FG?=
 =?utf-8?B?bG9wajZlUGtxUEZ6Mko4Y0MvUG5nOURRWGVVN0tUTmE2a0N5WEhGTmtzTHBK?=
 =?utf-8?B?ZTZPOUk5OFVtcG0rQ0EydXZLUjdaZFBCeUVVUERsTmJTS3NJdnNCQ1hsclpL?=
 =?utf-8?B?SzFuSFBWUzd6L0hKVmN1OHZCbW1NUDZrd0NnM1N2TlkxOWVUSWZ0aXY1V2NO?=
 =?utf-8?B?R0pGM0xDOWdydldYYkhTUng2dlF3M3lxUVlDb1J1c2Nzc2w5OGNWM1c0TUF6?=
 =?utf-8?B?MUhsN1RCd0pMWEwrOG9aaHFnT1pJOEVqWENyMmVySXlqS1c1VStTdFVqUFBn?=
 =?utf-8?B?T0xwQ2VNSUd2R3ZzcEFrWHRpY0R1c1FtelowTGRPNU5zYmp0VVR0RVdGSnkr?=
 =?utf-8?B?cmpwQTFRWlNENndOeE1XVDdpcXBLdnkzQ0l0U1ZwRDBPcTBtWUxkaTd2Q0lQ?=
 =?utf-8?B?WU5qSTNqaXR2a1dwa0RTUE1jR1JEZjlLK2QwRWFyNktVQWdlTk9Cb01ULzhx?=
 =?utf-8?B?T1AvOVZEZWl3cWt1b2hZTkhoQUdmdnVWaUY1U09FVkMxNjJWQlVtSFFQUlFJ?=
 =?utf-8?B?SlNzZmFiUnQ4bWg3VjUyZ1BINTJGakxkcGFrenl4UzJrYW55d1BMZXNCZGZL?=
 =?utf-8?B?RVlZTnNPTVF5NmJOS0ErdG5KOUF1S3FyWE42V1RIaDluTmVQZnJaVk4rdS91?=
 =?utf-8?B?SjgrWEN1SE41c1prRis4SUtRbmoycVhWYUkrSjJFNjdDZ28rcDhxMk05dHg3?=
 =?utf-8?B?d2hGOTd1QzJ4ZVlLUG1sOWpsVDRXdmdKR0hYZU9lUm91UjgxTHZWWCtPZHlt?=
 =?utf-8?B?Yk5lTWhQQU8rU3dPYUdjUTZGTWt5S0hSMmZEcVVVaXdES0JoYTBUZzFuek1W?=
 =?utf-8?B?T1R3SEJYeU93eS9hYWFsekFkc1NLNHlWU2Y4d0R0dUFJRFA0c3FsdGwvRFhZ?=
 =?utf-8?B?dGs1WjhwS1dUS1NpR24rUkZ3Njh5R1lSWU9pRU53Q29jTEdSTEVhNXF0Z3pw?=
 =?utf-8?B?UVhhaTNOTW5zTi9BL1c2YTM2OU4rL0JIMllGcDY2dU1lVGpEdkpodzVZdktF?=
 =?utf-8?B?NUpSckI0QjJUVnE3T2dncHdzcEhETld1OXJtVkZHUk5JakRVazU2VllnaGtn?=
 =?utf-8?B?cVFkRXhYZlN5NWtGVDBPdXNXTTFNT1JMc1NFYXhnQWowTitmcjdVYmdpRHlC?=
 =?utf-8?B?d2o2NkV4Mnc1RUtOcUJndUp4ZjI4Qm9IU1N2RG1Pd3lFaXg1UWN1c2NGNEtm?=
 =?utf-8?B?UDV0aHU4ZnY0azNZVExsSlZiVEZkanRWcUY3bGc5czF3Tk5ONnQxeWV0YjdE?=
 =?utf-8?B?VWZoN0s4ZklNNUFweVE0UlNXVW1IWUhtaTZqTlJvOEZtWlFDc0FMQUtRWHdz?=
 =?utf-8?B?R3VCSmIzaEF0azJtL0JKalFNdEJBZnZkZ3ZibGRRcFlZcUkxM0twSU8zSGpy?=
 =?utf-8?B?NFFWQ2dYaUs4NThUT3ZSTmUyenZ2VCtta1o2bkx6TlpTVEdzNkg3S2RsUWxi?=
 =?utf-8?B?LzF2MVFXbVBqbE00NmtTWkxVVTloenRVdjB6d21KNFBoUWdKZmtzWWM5K1pQ?=
 =?utf-8?B?K2hqQ2szRzRrOHZia1A4WDBuN0RkOXl3eEVESjkrdGprQWROeE51MzhLUTV4?=
 =?utf-8?B?OUhNU3B1ZFZ6UUdtNjRCOHNuVVFYd05tQU1JMkVBV2h5RW56aFNpYzhSeVdU?=
 =?utf-8?B?ay9MZzl4WEdRZ2V3eTdpNUVoWVpzWGlCcUQwSkgvcXhwanNicXdxUWdndm9m?=
 =?utf-8?B?cVVzclVHcml4Q1ppbGZHc29FNGJkTktEQjNOOFBkbTUrOXhScERMNVRWNDlv?=
 =?utf-8?B?N3R2WEwyTjJoamhPQStBMitFSGp3MlQ0bk51U3BHM1VmakJwMDM0ZzVzdURX?=
 =?utf-8?B?MEpDVCtoMWpnTjJhcEZ2ZnMvZHU0TDNUWStVc09GT0RiMlZtZllDVXZWc2NP?=
 =?utf-8?B?NmtFbmh0RHF1K01LY0taMWhDRXdqUzFYWGdLazVucmNoOXZTd1M2amEvd3lT?=
 =?utf-8?Q?2Vw1XfF7lz4TU1sGhz11AFk=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62dc1b2d-807e-44db-2928-08d9df568e83
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 16:28:30.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSEp1uiSdPZ8j/oizwZQGt+/7KbCI6gS3kqPJ9rgFypRTwXzRNHl/i+/aOSZD2a9z9wdVfeNtoq2apq+/27Hbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5255
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/22 6:27 AM, Greg Kroah-Hartman wrote:
> On Fri, Jan 14, 2022 at 11:39:47AM -0500, Sean Anderson wrote:
>> This adds a debugfs file for ULPI devices which contains a dump of their
>> registers. This is useful for debugging basic connectivity problems. The
>> file is created in ulpi_register because many devices will never have a
>> driver bound (as they are managed in hardware by the USB controller
>> device).
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>>  drivers/usb/common/ulpi.c   | 100 ++++++++++++++++++++++++++++++++++--
>>  include/linux/ulpi/driver.h |   3 ++
>>  2 files changed, 99 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
>> index 4169cf40a03b..a39c48e04013 100644
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
>> +static int __maybe_unused ulpi_regs_read(struct seq_file *seq, void *data)
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
>> +static int __maybe_unused ulpi_regs_open(struct inode *inode, struct file *f)
>> +{
>> +	struct ulpi *ulpi = inode->i_private;
>> +
>> +	return single_open(f, ulpi_regs_read, ulpi);
>> +}
>> +
>> +static const struct file_operations __maybe_unused ulpi_regs_ops = {
>> +	.owner = THIS_MODULE,
>> +	.open = ulpi_regs_open,
>> +	.release = single_release,
>> +	.read = seq_read,
>> +	.llseek = seq_lseek
>> +};
>> +
>> +static struct dentry *ulpi_root = (void *)-EPROBE_DEFER;
> 
> There is no need for this variable, nor is there ever a need to set this
> to an error value like this.  If you need to find the root, just look it
> up!

The reason why it is set to a non-zero value is so that it doesn't get
coalesced with other zero-initialized static variables.

>> +
>>  static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>>  {
>>  	int ret;
>> +	struct dentry *regs;
>>  
>>  	ulpi->dev.parent = dev; /* needed early for ops */
>>  	ulpi->dev.bus = &ulpi_bus;
>> @@ -245,16 +301,39 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>>  
>>  	ret = ulpi_read_id(ulpi);
>>  	if (ret)
>> -		return ret;
>> +		goto err_of;
>>  
>>  	ret = device_register(&ulpi->dev);
>>  	if (ret)
>> -		return ret;
>> +		goto err_of;
>> +
>> +	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> 
> This check is not needed, the compiler will handle it all for your
> automatically.
> 
>> +		ulpi->root = debugfs_create_dir(dev_name(dev), ulpi_root);
>> +		if (IS_ERR(ulpi->root)) {
> 
> No need to check this, just keep moving on.  debugfs return values
> shoudl NEVER be checked as your code should not care what happens.

OK. The reason we have the above check is so we don't fail here because
if we don't have CONFIG_DEBUG_FS then debugfs_create_dir() will fail
with -ENODEV.

>> +			ret = PTR_ERR(ulpi->root);
>> +			goto err_dev;
>> +		}
>> +
>> +		regs = debugfs_create_file("regs", 0444, ulpi->root, ulpi,
>> +					   &ulpi_regs_ops);
> 
> Also, there is no need to save the dentry of "root", just make that a
> local variable and look it up when you want to remove it.
> 
>> +		if (IS_ERR(regs)) {
> 
> Again, no need to check this at all.
> 
>> +			ret = PTR_ERR(regs);
>> +			goto err_debugfs;
>> +		}
>> +	}
> 
> All of this logic here can be reduced to 2 lines of code and one
> variable:
> 	struct dentry *dir;
> 
> 	...
> 
> 	dir = debugfs_create_dir(dev_name(dev),
> 			         debugfs_lookup(KBUILD_MODULE_NAME, NULL));
> 	debugfs_create_file("regs", 0444, dir, ulpi, &ulpi_regs_ops);
> 
> and that's it.
> 
> 
> 
>>  
>>  	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
>>  		ulpi->id.vendor, ulpi->id.product);
>>  
>>  	return 0;
>> +
>> +err_debugfs:
>> +	debugfs_remove(ulpi->root);
> 
> debugfs_remove_recursive()?

Well, the former is an alias for the latter, but in the current code flow we will only ever get here if we create the directory but fail to create the file. So either works.

>> +err_dev:
>> +	device_unregister(&ulpi->dev);
>> +err_of:
>> +	of_node_put(ulpi->dev.of_node);
>> +	return ret;
>>  }
>>  
>>  /**
>> @@ -296,8 +375,9 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
>>   */
>>  void ulpi_unregister_interface(struct ulpi *ulpi)
>>  {
>> -	of_node_put(ulpi->dev.of_node);
>> +	debugfs_remove_recursive(ulpi->root);
> 
> again, look up the name you want to remove, no need to store it around
> anywhere:
> 	debugfs_remove_recursive(debugfs_lookup(dev_name(ulpi->dev), debugfs_lookup(KBUILD_MODULE_NAME, NULL)));

Ah, I wasn't aware of debugfs_lookup. Thanks for the suggestion.

> 
>>  	device_unregister(&ulpi->dev);
>> +	of_node_put(ulpi->dev.of_node);
>>  }
>>  EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
>>  
>> @@ -305,13 +385,25 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
>>  
>>  static int __init ulpi_init(void)
>>  {
>> -	return bus_register(&ulpi_bus);
>> +	int ret;
>> +
>> +	if (IS_ENABLED(CONFIG_DEBUG_FS)) {
> 
> Again, no need to check
> 
>> +		ulpi_root = debugfs_create_dir("ulpi", NULL);
> 
> Again, no need to keep this, it can just be:
> 	debugfs_create_dir(KBUILD_MODULE_NAME, NULL);

OK.

>> +		if (IS_ERR(ulpi_root))
>> +			return PTR_ERR(ulpi_root);
>> +	}
>> +
>> +	ret = bus_register(&ulpi_bus);
>> +	if (ret)
>> +		debugfs_remove(ulpi_root);
>> +	return ret;
>>  }
>>  subsys_initcall(ulpi_init);
>>  
>>  static void __exit ulpi_exit(void)
>>  {
>>  	bus_unregister(&ulpi_bus);
>> +	debugfs_remove(ulpi_root);
> 
> 	debugfs_remove_recursive(debugfs_lookup(KBUILD_MODULE_NAME, NULL));
> 
>>  }
>>  module_exit(ulpi_exit);
>>  
>> diff --git a/include/linux/ulpi/driver.h b/include/linux/ulpi/driver.h
>> index c7a1810373e3..083ea2d2e873 100644
>> --- a/include/linux/ulpi/driver.h
>> +++ b/include/linux/ulpi/driver.h
>> @@ -6,6 +6,7 @@
>>  
>>  #include <linux/device.h>
>>  
>> +struct dentry;
>>  struct ulpi_ops;
>>  
>>  /**
>> @@ -13,10 +14,12 @@ struct ulpi_ops;
>>   * @id: vendor and product ids for ULPI device
>>   * @ops: I/O access
>>   * @dev: device interface
>> + * @root: root directory for debugfs files
> 
> No need for this, as pointed out above.
> 
> This should make you patch a _lot_ smaller.

OK, thanks for the suggestions.

--Sean

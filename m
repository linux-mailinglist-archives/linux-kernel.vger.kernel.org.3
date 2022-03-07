Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9684CF38B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbiCGIcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiCGIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:32:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2132.outbound.protection.outlook.com [40.107.223.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93EE433B2;
        Mon,  7 Mar 2022 00:31:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9C2dFH+79zvtQlXTX766cLttTBxNh/6OMJZ/FNKtlxAMafPJJabixZs+YL/+N46IgSEW3i1I/R/JBxRdi6ydgOKDxChTkAmurdDGxmPy/78c6e9csCPK8SB4DXhzhFROZvirAJOOuTL+ZkSRqPWBp2DGWP8RhRlAvtslE2KQMa3cJgnYeSOhqlQzzfivZ16l1K4id4sgk7OzfQ7Di/BneAeA8qJl1BnDKLx0+8Wh8YxQzZLaAFaEJReiryPxAPwejVl4Z9g6qw+XDBOsRNLxOdiEzRgMGeUPgfZ/3f4qxIOLeYrQzNTtCVj/WFYzuUJ5lCUdGBLG9hcVtrTFRL1/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jErWfsy1gYN8zwvhHFheF3l6BbEvlej3mybxvBopXyc=;
 b=fBY0R+mdvnFhH+UtM1xFZQieqhElpbcpreHt/3FWryX05+1UEvu+pcPeQb9ovtGzrljxhU+Q3MUXOhNBzi4zTi3EBUGO7ZiI9cbKcLgIZGb0wvWHKoOpsvp56GVXbpBnERiav8ySsMxSTQaSeRlOuxZu/S7P3Lv+p40lY5wu7IebDuPnwAUj3pmd9PJS2HApZdvhwzHNqqAZKzl5T1ouitGbOPilEno+19kP62cNndBxSvHbElvpBzZH/nvqZVK+JBhxkrSSIcLBbKCQmkMGrCaWLtSZ2CFohrFzYFNKkpy34Pnf9rwafvfw6mnoYWEjwEtHjRCpvrKgeV+Yy6+mAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jErWfsy1gYN8zwvhHFheF3l6BbEvlej3mybxvBopXyc=;
 b=TCLODVN6ei/72FjrZFKtfLuENoZyb5glRlQf0zJsf7yqx725cPwVktKI1TdOPkLBHTf5zZVF2mZfNZAwet8ULFqmFuRayKicrQUUz5TXnct7MHBBLG2lBlYTcLD52mLz4eDa14/g07prfMs94g+mwKSdwa4ZJMmRiJUi/A+76x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ0PR01MB7282.prod.exchangelabs.com (2603:10b6:a03:3f2::24) by
 MW2PR0102MB3498.prod.exchangelabs.com (2603:10b6:302:3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.20; Mon, 7 Mar 2022 08:30:58 +0000
Received: from SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::cd24:39ed:7042:46d6]) by SJ0PR01MB7282.prod.exchangelabs.com
 ([fe80::cd24:39ed:7042:46d6%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 08:30:57 +0000
Message-ID: <e6644ea3-71b2-d045-be74-77792baf6dc2@os.amperecomputing.com>
Date:   Mon, 7 Mar 2022 15:30:42 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
From:   Quan Nguyen <quan@os.amperecomputing.com>
Subject: Re: [PATCH v6 6/9] misc: smpro-errmon: Add Ampere's SMpro error
 monitor driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
References: <20211224041352.29405-1-quan@os.amperecomputing.com>
 <20211224041352.29405-7-quan@os.amperecomputing.com>
 <YcXLGYWx4gYq/Y+J@sirena.org.uk>
Content-Language: en-US
In-Reply-To: <YcXLGYWx4gYq/Y+J@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To SJ0PR01MB7282.prod.exchangelabs.com
 (2603:10b6:a03:3f2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff00c60-fd5d-4ebf-89d1-08da0014cd39
X-MS-TrafficTypeDiagnostic: MW2PR0102MB3498:EE_
X-Microsoft-Antispam-PRVS: <MW2PR0102MB34987F8B8F47B75E152E0FD1F2089@MW2PR0102MB3498.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9lwUh5cA68FHgzmLAQ1xOCJbTKLSlvVkGOt7wqkZwa66oWqkX1MZPmYvcZEOi7uDaBo435nwlh/y6lZS6Ao2rJw3YXy4uUJa8dRiEYZCSX2DPU7ioy0SZMATo2DOF1tUvuCP/e913skp7oEYluKSQI5vtzirhNGiHOsG0v/Ka2gCpsNaLbS3hoagLR4ZfVTQozSHpF+IRs7qoVB3xcJWbG/ID1rz3+/JXWVzsSfrf9SfiJHCRbjXG7xBqhvChgVTeJnDp4MVggxUOmSC9zEwCz0DL2ECiMQh3xgfUg1TvxDP09s1BDcER4MQ9xZZoIFnnmO/eS5QJVkRSSmhiT6ESW5tCwmS+y9wvpSX4OAvrrey7X1l57z78AT5pvlLA4zYvYeMBYP/YttoNCgncy/gKJjVeveogPMoKkaYx0szXLZomXbrR2j9cpkqMb4+GDKA0Ofy/gkTOIems/aisGMzNX5eBoZsXQ2lFWQAHgbhHXuMeFusLTt+V7cwd9+XcaQfEQkobACwin+JuaDTy11DIL73wgvXh8//kmpmWl5g3vbeZm6jw+yiBAPotcIObRyn2QxfnoLS1sZBpHFA5gwd+wULDHLkTin9rltLijWFwqShxYk4Md/BLsbePkUUA5UWPoaX2T/JQdZnrYYiXBsBvacCjtXZs0lg3G6U+ImL6369qo/cTxHKUuRcfyp/OgfQyxi+lsuu9zjheONpZVURxMcW8BUOM8XAjwLvOyqbfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR01MB7282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(5660300002)(52116002)(6916009)(31686004)(6506007)(26005)(38350700002)(8676002)(66476007)(6666004)(86362001)(6486002)(55236004)(53546011)(54906003)(316002)(31696002)(2906002)(186003)(107886003)(66556008)(4326008)(83380400001)(508600001)(8936002)(66946007)(7416002)(38100700002)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTQ3NFQ2c2VuSmJndERLZU0wOFF4VEtramJCcjhWZW5pSzFXNVgvUEJSRmph?=
 =?utf-8?B?dGc0TTVYa3gvUEtyUlZEZFFTM3B3Y1U5L0cyR2RNKzBmMEdzVThNR2k1U1ZB?=
 =?utf-8?B?MUdWVXlYUFB6QVlHSGxDV3dCYnp6b2Y2czVnU0ZWZmxxOVRYZHNKRVhuOTVj?=
 =?utf-8?B?L0plVUtOekxQdVpoaHllOXFCVDhoa3ZMdlZ4dkgwa2xxaW1DMXVIaWNnSUNv?=
 =?utf-8?B?RTZKbXlOVmFncmc1SGZDbThzOTFIeExmdml1NmFiTllEeFFwOVNCZFJ6Um9F?=
 =?utf-8?B?NXdyWEhYbDVzOWc1SnFHemx4N2UrdFREaEdRT29uY2pUditNOWwvNzdnWFVL?=
 =?utf-8?B?elNyUTBoRmhnTk5JeHhnQ2tXbnpXbW1QNnVEcThtQnJOVWREL2k1RXA0K1kr?=
 =?utf-8?B?aitiMnUyNkN6WHhnWFZOWEJhSGNMc0NOSHFUOVo4d3F6Qm1oMUk3bWNTWkpH?=
 =?utf-8?B?YS81bmovbTNXZng4a3hZR2lQbWFhYVJVeEI4UVdPbTM1dmtYWGowM0k3RlFD?=
 =?utf-8?B?RDNVZW1TS3VZWDlJd1lzQlR3Wnk2NXZKblpuNWVTWms4R0lkNzhxWmxReWIz?=
 =?utf-8?B?cjAwN095cTlrWW1Mb0FScnphNnkxMStVWVQweGtRT2E4eU5aa0V0NjN0eUVz?=
 =?utf-8?B?bW1ybFlpSmt5clNQaEg4RTJyQ2hHUnpFL0V6RWlaczRpQ2ozMVZVWUwzWUR0?=
 =?utf-8?B?OVdBeXhka05ZUkp1dThKQUtXQnpESWNqQkRBd2UreGNwNnNpbDdhbnJWNlhl?=
 =?utf-8?B?d2lTNytOcHJQc1FKeEhqbUZ3NXdWeXRTUUcvZ2tIR09uR1NEUWFWNnRFZUNO?=
 =?utf-8?B?UWVzcDdqeXJGRFZRdmV3QzZ1d0RVZEUzRmh3c3pEcGp1bTBRSHB5VmtUQkpB?=
 =?utf-8?B?dk9sWnkzNC9yVzBTY21rMWVlM1hGT3VQYzdsME15Z08rTk1MRGpKa1lrSXNP?=
 =?utf-8?B?dno2YXA5UmhIVDVBbGlWYXg3cktqSG5mRGpNL0JaVThhSWkyMzJpTjk3R3o1?=
 =?utf-8?B?OFBCQmVSWEV6MHpRTjRHYnF4aktpQnNKb0JTY3BzSDlXVVo4WXdSd1B1eVZF?=
 =?utf-8?B?VWIxTUVDVFpoLzYzRG8wL1JxVUxKd2xMMVBKZ1hxcDRBT1Q2N3BYWmdUMU9R?=
 =?utf-8?B?dWplczdPMStxSkRYeWZ5R1Q5Q2dCWC95Q3I0Tll2U09ENW5nUENFcHllV2Ju?=
 =?utf-8?B?RFM3ejA5aWc0RDkyQmdUcjBrbjVQTit3TWRqK01xRmJVekYrdXc3UjlYYzZJ?=
 =?utf-8?B?MzlzNlRLemFYUkRoVWJLNFZBdDRGWXpPUXI4aUVuWWhCSHNiV0szQzNPWVla?=
 =?utf-8?B?MzFQUW80NXJmYUQ3MFVNVVh0V1ZuRUN4T0FzRDRjMldiakl1ZUJtcVVUMEkw?=
 =?utf-8?B?V291UjhBYXVqcGdINFZSQ2lvL0lWMFc1bEtReFN0elVHOEhndmdUTncwVzRa?=
 =?utf-8?B?T1JMQjg0K0NPNERoRFJSdVZkRFpTSUV1N2JmN2oxL05SdGtQMGFDUEwrUUdJ?=
 =?utf-8?B?VkJqN1hHeUI0VExoUlh3RG9PaVlMY01jU0tBNHA3TTFwRElhM3lPQXIrL1lm?=
 =?utf-8?B?NjByNWtvVStIdGduUmlDUHVZbjhTcFZESjMwempRTWdGNzlxZ2dFTDgvSXZr?=
 =?utf-8?B?bEo0MWRtUWJQSmNvNVJDVjh1aDVDcE55Um5RYk1mTW94elh2b0FtMUFOVEc1?=
 =?utf-8?B?TFE3UnVmaHlKMk9SN3ViRnlmcUI0TndweHp5RExZV2tUeEFKZWt5T3lnZ3p1?=
 =?utf-8?B?N1hKc1N6WW14enM0bUo4bmRUd2tpdGwwWlNPMmVBdlA0emhISEx0OGE5VzBl?=
 =?utf-8?B?L3BaSUI4VHRzeTJnT2oxSC8xSEJaS1NKUUp2TUN5dTZKMjhYcmlldVNON29Y?=
 =?utf-8?B?VFJxTWxmNjNjclFVcE5tL2hOUE5MclFxWHY4MGxubCtHK1FXRnNXVm9NQVBx?=
 =?utf-8?B?UUp2V2s1RXdva1ZhNUk2U1hkSkxIVXA4OVJuTGtWZVdORG9sUGNObWY1M2dP?=
 =?utf-8?B?Z0JoTVRYRXRMWWN6MzBraCtrMzBZNkRFV1pseGhDaHl3TzlHVzdrRnpHM1NC?=
 =?utf-8?B?SnQ1VXdhMzk5Q05CWjgvd01SMFFCajhzb3VKTEI2eUh5SmNVRVo4WUFMREEx?=
 =?utf-8?B?MjArSTVCcndHV0VZWUFId3U2MUYwSnhPOFRpeWZnczVsYTZzckd6djBId256?=
 =?utf-8?B?WjdKckJ5MndrcGttUFVGcUk0eWxla1UrVkVwQUFaZzloc0xseis0ZFBKaklH?=
 =?utf-8?Q?YuHWgleXGbMg4PWjWyaLfVCFICzXfQtm3PO3j7HnZ8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff00c60-fd5d-4ebf-89d1-08da0014cd39
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR01MB7282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 08:30:57.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfW+WQqjCOF76GQkIqftVA++XBH0NuSUvK0xzpvB8ThLZHkyZgvd5ZH1taXTAMS2gP1yrtwMQAI1Wz6GoxPF7MD8hkWhxBrcd5yNMsySE5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR0102MB3498
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/12/2021 20:28, Mark Brown wrote:
> On Fri, Dec 24, 2021 at 11:13:49AM +0700, Quan Nguyen wrote:
> 
>> +static int read_i2c_block_data(struct i2c_client *client, u16 address, u16 length, u8 *data)
>> +{
>> +	unsigned char outbuf[MAX_READ_BLOCK_LENGTH];
>> +	unsigned char inbuf[2];
>> +	struct i2c_msg msgs[2];
>> +	ssize_t ret;
>> +
>> +	inbuf[0] = (address & 0xff);
>> +	inbuf[1] = length;
>> +
>> +	msgs[0].addr = client->addr;
>> +	msgs[0].flags = client->flags & I2C_M_TEN;
>> +	msgs[0].len = 2;
>> +	msgs[0].buf = inbuf;
>> +
>> +	msgs[1].addr = client->addr;
>> +	msgs[1].flags = (client->flags  & I2C_M_TEN) | I2C_M_RD;
>> +	msgs[1].len = length;
>> +	msgs[1].buf = outbuf;
>> +
>> +	ret = i2c_transfer(client->adapter, msgs, NUM_I2C_MESSAGES);
>> +	if (ret < 0)
> 
> regmap already supports bulk data access so it's not clear why we
> would open code this.  Given that this is a single I2C transfer
> it's also unclear why we'd need to export the regmap lock - a
> single I2C transfer is atomic at the bus level so the regmap lock
> isn't providing any additional concurrency protection.

Thanks a lot for the review, Mark.
Even though the single i2c transfer is atomic at the bus level, but my 
concerns is that the transfer may be interlaced with some other 
transaction from the regmap which was guarded by regmap's lock. And so 
making these accesses atomic in regmap level should be done as well. 
That is why I need the regmap's lock export for user driver.

But your comment made re-think about the code, and I think we can handle 
multiple types of transfer by using remap_bus->read/write(). The 
read_i2c_block_data() is now replaced by regmap_noinc_read() and hence, 
remove the use of regmap's lock. These changes will be included in my 
next version.

Thanks,
- Quan

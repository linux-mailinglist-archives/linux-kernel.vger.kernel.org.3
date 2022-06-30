Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8984956150C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiF3I11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 04:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiF3I1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 04:27:22 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140084.outbound.protection.outlook.com [40.107.14.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66972102;
        Thu, 30 Jun 2022 01:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9FYBoIJfRIxXOcf8AvqfF7jwEabhJbEFqbK3NwuWxJmbl1FyOnBzyqAIUpk5B4lx43aSylUMavgE04WPavWRJQtZK+FEQRaOmWcOhYWDEjlrHI8ADHPWe7gJ+jTvPaCkwybQInt7Py7CaOy7tQCUwGiPcJIPAaGgYxRbzvDykUfFjhkFkkM4GvZPshBc/um41VkzpHotLGFZ0RTiiJ18nK9j8n5t/b9Kr9+tfLkZ85pWkqvw3s2279VQeGAsypkLK1woOSBOT/00dW+XI5s+2IegqSNH9LfmhP/pAgvluuf37rfsYTT3O+JHKcQS0Bz0EdShTSFB8j2xsWVex3Y2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOFZZZpLTXwil1+MyWfTTZx5F/thlnLkZjH2j0EN8IQ=;
 b=f6HJbddDWbAQiioBKcqb/8/IqkHj3sYYI5RcwIpxn9ZR3Dvr//To5TjxlWTRFrVkVsiFzKKmXLNdOEchQxCVsGEfuVH/ZEzRKC3ESR2rMrI9B/1K87PPq9cvTbyBhffPbzIJsaNP9ZPVW8eKwn5JEqsW7obZdZmMCC1AM5jkQetpNIgAxP8k7tlBpFBWO9a7rZ/G73+oDAowZqUYsDWmEEjG1qNLHUvcvYBesn5asOCz05T7dcpmhIIZK5uMpE6XMa3QLxQdSh2u/j9WOZStgtMat7IpHCdiLlnkH9+JqdLkycIRtj7nAOUF1m8mBb3mTBlJzGYayKQzMwRAuVNPdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOFZZZpLTXwil1+MyWfTTZx5F/thlnLkZjH2j0EN8IQ=;
 b=Jk8j50KdhoMqe4MUx8CD1UVc7UuUxE8bsEKA6vjc8OJJDZ92EtEqD9qeUNscSfmsFaix2KRglBFyyOZY9M9VM3szlwuhqGx2PehTdSEWJMp4PSROCCg/1UJGA6J6hEnLYdQ0At72fTSh2mOxzEWdDaP2AKKvXSfGFZkijl4lqP1zub2J/3OBj6ygpQz3gaRkxXFCySObQfHVniYvETe8oPbZgGLyxyokLRKDJLzwX2Rd3tipHrQJ69vWc6qhmaBUbumO/iz760xYGaXs0yy8/snVU7jTYE/Kxeiojh9e/cToDkI1CW062f/rdPfVCmwN+fQPQsQUlZI3fE2SsFUAUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by AM0PR0402MB3651.eurprd04.prod.outlook.com
 (2603:10a6:208:5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 08:27:18 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::21d5:a855:6e65:cf5d%12]) with mapi id 15.20.5395.014; Thu, 30 Jun
 2022 08:27:18 +0000
Message-ID: <3fe54848-f9ab-9cda-6da2-6f37d8cf337f@suse.com>
Date:   Thu, 30 Jun 2022 10:27:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RESEND v2 1/2] net: usb: cdc_ether: Add Fibocom L610 modem
Content-Language: en-US
To:     Sven Schwermer <sven@svenschwermer.de>, linux-usb@vger.kernel.org,
        oliver@neukum.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org
References: <20220627133620.272716-1-sven@svenschwermer.de>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220627133620.272716-1-sven@svenschwermer.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9cbe7ec-6b29-4ef5-7ca9-08da5a725824
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3651:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMDEjz9Wel1vaDDuIjPheYmusmMekXopHns8E+VkKalAlpptD9y47UMPyhiDfNausWu+uemTDrAalKXWasInwGylEVIoL8E+SKe48aUIDFGuIHWqCFg/WZGP0joBRwAds//ExlEDccrfLHmwqxEu08uD874l35OVJelQLf0Pfr+aoxivQkgflbMLE09ejYhV179rptqBHROQL6HoYXf3f2auuTl+42hRfh/70Sn2jxpvzY5Lc8XyMjUuw+b3Qi/DdJlPdZCiXrIfuaZTQPHs/YQDywAPZ44/xppFz3lek4/VJuXD+JkI7i8+nCwlIL56eZomJX3hpOG5Yrrfqg7W1qPB3z4GSyP4nl0AO+uvTShY2g1m8E3bc5v8KpT9PU6CzB+JaTdakUkxEAyIYwl1ywU3D8DuEl7YOyVd9IR5F8hmXnKJ7kxECFdUM50vibHIE3tTV/zmzRSNHo9bBYF0bMbegmeIfPj+yjHf0fuBZ1rQoJM8To5Au9iFIbEnxmXIYY+37pQG30QIW1gJZqHiEv2o8lR/seD8pQbrvJ+gipAXnvp/zkmqMx9p1DXrv7LOsbzppH31Jyols7uW74io6MHhUdmZvcMIIRf5rKdYt6onJCP6gWYOpDSlJEO8aUiqrHmgN+cv3d7cFlA5Ko3WI8lzS7N0rwo5HdP+xHW0TGOzEGx5k4ozRRItlyuqvIfYdiNTRtK6b5PfRBQw/PNGKK+yGxRt481AJk3Iu8G3Alt7P2vBVGcYiGV0KGF5yyg8GwyrSz/kjSArFjPdBBGPTQDn/AAZNkQW+R6XY4RjzwfMg6khhi/DIleRHZTvuAFRNV4ihM9eaF66eJr7VXcwQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(39860400002)(366004)(136003)(53546011)(66556008)(4326008)(66476007)(66946007)(186003)(8936002)(478600001)(6506007)(6486002)(36756003)(86362001)(31696002)(5660300002)(6512007)(316002)(2906002)(2616005)(31686004)(8676002)(38100700002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW9uT3pmWlhkRnVlbTA5ajhpSHVWZTZvemticjBJbDdnWm1mdGdtaXFMekh6?=
 =?utf-8?B?NFFXTXNmRlAwTktLejdhS1hIU01DbC94L3dSWDNYcnJpb0IwUmViVFo4eTJZ?=
 =?utf-8?B?TmVYSmg2RVFNV3M2QzYzNW1YOGFWYlp0Tkc1d3EzWTFsZE5jSGFYVGk2L0Vr?=
 =?utf-8?B?bGJWY096QWlPS3V3RHNmQWR0OWU5QXVJYmVTc0Roa0VQYlB1ZVF4akpkL3Az?=
 =?utf-8?B?Vzl4KzZhaURSbllOUHFxbkh0TkhDZE41YkxLTU1IOVB3cHp5TkN0T0lscE9E?=
 =?utf-8?B?RDhyZG1iTHR2TVJIaDVtQnI4R1hVSEhDeG1vc3J6dytjOFJGV2xiZTRVeVQ0?=
 =?utf-8?B?SXR5eDBlS1JPSXZGM09yb3BtaW1GTjB3V1ZDS090Y09ab0xBQkRaT0xkZXFS?=
 =?utf-8?B?MGd2eitOUURIdUJMeFFGaEtjUERRU1FsU0w1K2JndzJmTlpnRGp6eUh5Uzl6?=
 =?utf-8?B?OUR6b3BXMmlVZ2lLRlFBcXRFN1NRbUhFVmVBd2NIdDFSL0tZRzZtcjhxeXE5?=
 =?utf-8?B?Q1M5T0lsVEFvTHI2cTJUTCtDMjlybkdFYjJhSXBhaFdwWGsyU1J6Y1RxLzdm?=
 =?utf-8?B?MFV0LzdMbjlxeGxicVdKN29SMHlvenF2d1hQK0pUcVJFdEhFaldsOFpUL1lG?=
 =?utf-8?B?NDVCdWJjci9Md242c3V1Z2ZsTk1rZFhPdlQ4QUY4N2Q3dTIxTk1vaThCUjN3?=
 =?utf-8?B?WHpMUTRrd3p0VllQekZzZTlQbndQU1VVSzNLT1Rrc3NYMElHb0o5VXVBNXoz?=
 =?utf-8?B?ZlF3ZFZhUXdCaG9CWWx4Vmw3Smp4R3A0TlMwRTFNdUEyOXZmU0hNUE1ycDlI?=
 =?utf-8?B?Qi9ncVZKN1QySkhIdmlDalMwTWJGT0U1MnJOeWRTcVVPYnBMQlZMeE1hNWYx?=
 =?utf-8?B?S1RpdE8reFo1N1p1Q3M3VTlDYldSNUFIeUdQdnRmTlBwVzQ3MlFZWEpvb3FM?=
 =?utf-8?B?U21UYTZFdEd2L2xxUEt1SDhJemtoTlBSQVdKSzM1TXRtb2FvUHlDQTFyR1VD?=
 =?utf-8?B?dXVvY2E5ckxUSHdKejUvbTJFYUhzbmNjMzE2OTRQVStyYVdzRDJGYUF5Uzdm?=
 =?utf-8?B?QUdtWWY4TytnazBrMnRJRS9YMGJFR1NJMmQ4OTBMS2w0T3A5L0ZMSFcxUllT?=
 =?utf-8?B?OXBDZTN1M0ZQdmZPQ0hRckZiUnEvbkF6eFA1VkgrSHprcmpiajd0ajludzBr?=
 =?utf-8?B?b05BNU1saEs5Y0cvKzEwSGR2ZjQ1V2VhWUVhbUpFdUVVbU9XeG4wWm9sSVQy?=
 =?utf-8?B?MEVNTzFoQnl6WVNOaTBBK2lnNnYydVBtY2Q0d0tjbmFRT1JhUVZ5QVZLMXdh?=
 =?utf-8?B?cVcwZjV3N1NDdFN5dkdyTllCKzJIWnl2VHhoUXRWcFNNMS90S1dEcmJJMjJx?=
 =?utf-8?B?djJRNWV0Z2h3a3E5dTZyQkRkVlllN2RyYnVlTldLQ0Y0NmJIWk5IdE16bGtl?=
 =?utf-8?B?bGQ5elF1MkZTRHMzOWF6TVNOSmdGTlRSOEt4alVETGlVaUJQK2N1bk85Rlpx?=
 =?utf-8?B?Skk3RWlJSDRRUWFyZnNORjFDdDJuUXhzalBYWW5qejVrbDZKU2dZSlNSSkRj?=
 =?utf-8?B?TzYxR2FQZGFvdlZzL21GK1RoNnVadUFsQmZFREhhamN0VVE3U2V3L3BQNXdF?=
 =?utf-8?B?Wm44Q0hWQ2RaWW1reVB2TEw5QjBmZDNuTWxTY3Nodng5SmNBcnpPYTl1Q1ht?=
 =?utf-8?B?cjNKTkZzak5OK04rcjBxYWg4djNNbFZ0RnNaVkVIZVoxOXZpZ09heStlV1ly?=
 =?utf-8?B?RHB2dlFZRVlqaUtBbncyaXFBd3NHY2ZoaDFHenNaNW1NcGoxandUaDd0WHdF?=
 =?utf-8?B?dmkrbzYzdzFHVXN5TlFKSnpIdFJIdzRXb1pBckJLQzRCV3ZSaUhsK3B4bFRB?=
 =?utf-8?B?Q00yWXIySTBlYzZGUTlrT2Z2VjFiUDhBU3BMcGZjYk9STWRUMXhTZWdiOHQr?=
 =?utf-8?B?cUFvTEthb3VqM092MDFnZTBSdmJmNlBaajRxUkFpeDhlaWRjQ0F2cFk3WVFx?=
 =?utf-8?B?OGtEMnJGQTRtM1JHd0NRWi9Ra2g3d3V3WkxrZG9raGc1ckJBMnhhclpyN1h1?=
 =?utf-8?B?Q0RpS041cUc3d2QwRzduYVBUalM2Z1M5OTN4bmxJRzh3VENVTTNMMVhHbGo4?=
 =?utf-8?B?ZzFHZEsxcDM5eGtDR3hYVXh6eU5HdlJ0TjJtVVl4bklGMXU3V2Q0SXU3b2tF?=
 =?utf-8?Q?JvvoOv1sTEGSZLhdTnHEcMXR+sgcFWIRsfFvUlHcpp54?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cbe7ec-6b29-4ef5-7ca9-08da5a725824
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 08:27:17.9935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdhBBxRZumIUXGV26VN/G+EgitqDsiDZbOujTLhi7Yv00xpo0n8yfWiO+6XhJ96PsVkvU6Dq2M1Sk+3IWlbyYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3651
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.06.22 15:36, Sven Schwermer wrote:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> Since this is a modem device enumerating as an Ethernet adapter, we need
> to whitelist it as a WWAN device which tells userspace that this device
> requires setup (via AT commands) before it can be used.
> 
> The L610 modem has 3 USB configurations that are configurable via the AT
> command AT+GTUSBMODE={31,32,33} which make the modem enumerate with the
> following interfaces, respectively:
> 
> 31: Modem + NV + MOS + Diag + LOG + AT + AT
> 32: ECM + Modem + NV + MOS + Diag + LOG + AT + AT
> 33: RNDIS + Modem + NV + MOS + Diag + LOG + AT + AT
> 
> A detailed description of the USB configuration for the ECM mode
> (+GTUSBMODE=32) follows:
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=06 Cnt=04 Dev#=122 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1782 ProdID=4d11 Rev= 0.00
> S:  Manufacturer=FIBOCOM
> S:  Product=L610
> C:* #Ifs= 9 Cfg#= 1 Atr=e0 MxPwr=400mA
> A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 7 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
Acked-by: Oliver Neukum <oneukum@suse.com>

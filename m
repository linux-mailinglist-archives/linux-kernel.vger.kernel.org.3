Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AA84B5047
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353219AbiBNMgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:36:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiBNMgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:36:04 -0500
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DE24A3CD;
        Mon, 14 Feb 2022 04:35:55 -0800 (PST)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21EBBnp8021014;
        Mon, 14 Feb 2022 04:35:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=hmfkUcwkNVyGJBLvTB9ZnpN9YXnu942aZzVh6FWTJ7c=;
 b=pZQXENLoMKwuhP1CszwlZQnGafd9ucxNfWDy2SgCiixpbZqSbr81lMjdi1U8QzEcLfqT
 lroV/FwrMxogXBc0bxnlcKEFdfr8Ak88KzNpxo9Riq7zpq2U+kGZFs0DIF2U7OI41ciG
 RhjFzWNUSWiYH4xRi0q1ETnJkHukdskXZ0gbmNoL2oAbgzG3jk50e/GESszBjbnOn1r4
 iI8SB13YVveK92hAAjGTCykvN3d9jD6oejghoElu3BEp2grZ+Pb5ukBkXabD08aDQ9QD
 ZPUiuaQ0+xSet1rukQyDiCr0SG8VYiJ5/24DdadTyGepl8TSPxS3lIIOj0EJHXeRNU/t jw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3e6d9n97pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 04:35:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E416rkbzSATYipTNS3CiMRDmBDQ6M3mTD/utYYghx1rH+QsmP9IzeWN5ZKZQQj43w+GoK9FYfKEPQSH80KC0OQGzfzCb2aYwZguToYgnA4bPcpk+ZZeo87rGLl1ZjUAvbQksh3SAQoJkhzmmpD9Xq+GUme5OzNTag0SdED3g6jsCs9hBp7xv8LVa/5WQhQxdWjSzYwxzlr23FpyIQlHJ0xykSEmTTriEJIvzDrjUZRcaErkUKqqgjhZLCT3UJMw0Su0jwNya0MnbkuLI4wfihtXkYeaVOlovAtk5TEcD0+dm3vJ9cT98qd7EPdhE6fmJdC525St28TTRbt51CPIzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5DqPwgtRCcLTzlIFKtvxq3P1PiLuxJgUGNskr/Bbrk=;
 b=iccDuuLIp8gSCFXR/zznpzn8okssM7klYgH9Gj8mvqEdiDK5rk+qw1xSGY5Z3FSiTjNzOClV+UfWLP4IUE87rl1G6OSjhOxm8fQ4LfOqhUSwVT39YRban0Ik3nWXbisZFs6+R3y3HP00GYlK1kdGtTqQ1kta3OjZy93UkF2w3nNjctvfHjlWD26/AVLahHcQ6XS0UHI0yJCz9d2HWNf5KqgxAHmf+NgCOXuTOP0heSgTls8EHHl5hMU/3YfB5RkgpMr+vzmSN44YFtPyfz20/7IfLRX3D0nvT2E48Lb+LuY9OkCF+cNmkDciJ3lrIEIuyPAgsORnC38dzKQlq/jOzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR11MB3008.namprd11.prod.outlook.com (2603:10b6:805:cf::18)
 by SJ0PR11MB5771.namprd11.prod.outlook.com (2603:10b6:a03:424::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 12:35:43 +0000
Received: from SN6PR11MB3008.namprd11.prod.outlook.com
 ([fe80::d8f7:376f:d7ee:cfb3]) by SN6PR11MB3008.namprd11.prod.outlook.com
 ([fe80::d8f7:376f:d7ee:cfb3%5]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:35:42 +0000
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBzcGk6IGRpc2FibGUgY2hpcHNlbGVj?=
 =?UTF-8?Q?t_after_complete_transfer?=
To:     Mark Brown <broonie@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xue, Ying" <Ying.Xue@windriver.com>
References: <SN6PR11MB3008AF5619B0B026836FD7429F2F9@SN6PR11MB3008.namprd11.prod.outlook.com>
 <YgU1+cIlANAkJCAL@sirena.org.uk>
 <19c69765-8584-2e6b-25b8-7053a5afa5d4@windriver.com>
 <YgVH310gQ1sK6dlr@sirena.org.uk>
From:   Yun Zhou <yun.zhou@windriver.com>
Message-ID: <a5aa6dcf-e3dd-e8ff-edcb-edad96f8ddfe@windriver.com>
Date:   Mon, 14 Feb 2022 20:35:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YgVH310gQ1sK6dlr@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR0302CA0017.apcprd03.prod.outlook.com
 (2603:1096:202::27) To SN6PR11MB3008.namprd11.prod.outlook.com
 (2603:10b6:805:cf::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d38a644-99e9-4e34-4a0a-08d9efb683e7
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5771:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5771AE743917B2CBEA7940EA9F339@SJ0PR11MB5771.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wix07bC56diu+nlUTMxNc8EVCIo/nEAWcblLQasaPAM5XM8a2rvMRkXboXUWuBY5USR+Flup3V9V1zy52gt9LH7c1pSzFHP/vybko7KvY0+CPXq/vdNpHAVV7ydg+a2lpwXawWw9WcREbftImqt1SLCQ2W1VInBq+zwhg6XiHjThhQqmSQCOSqsrR0xYjciByQD9Ts3dpbfJXyNeUgu0g75d60ru/KyUSnVsTRY0WbXV6ULcW5OiiexZXFuiIqYAzr42bu6MOibiA1MGR399qNjhO3D2eh8X73EzNn+Iu1c1qZtjbkmiTMhdEuG3hWHXKksDbrW1+Hp2cimAMHbr+Q3FwU+0EpNaLcHu4GYb+uivZSNtKUcQJCioXZC0SYnIkD+UNMaekJI/wB/CF0GYZGBK1oIrk/QilZE71XV9RvupE/2PZnrZZt8rLWPOiSm7BwMtiW+CbMBUAhskih60TgNhvfv/O8ua4NnKa/ie6oZ6VTpcFJ0LA99JdqbZEuX7j/OG8BkIHgbnXVa37Q8aoXUqy9TV+h1ZmuzBQ999hMdNswqRpLMjg8qB0siujsNtKrbqImGgoJkcfaTHA3p8Vz5/uxjmid6mGSULC+n+SJqQfAGNC0bF6tc4QchEQ71pnd7ZZlQ5u6DOhEjw54I3pzvvTS/6Hd230uLl0mzJ5z209N+Xst3La/SH56a0wnFq19YmVPIzd+5avabL9f/VnL6vUFQE9jo7iiXSYq1+NBDlW7Emam9kENRZG/LjLTWSryBh0RzOe5nOlWLoeLDxvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3008.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(66476007)(66946007)(8936002)(224303003)(66556008)(2906002)(5660300002)(6666004)(186003)(38350700002)(83380400001)(6486002)(54906003)(26005)(107886003)(2616005)(31696002)(6512007)(508600001)(6916009)(31686004)(52116002)(6506007)(316002)(4326008)(36756003)(53546011)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?ITkfwNVYQZ/PtljOm1He+qFW2X+tYrZvnVyb6UicPyVgXw2YoRELeoWK?=
 =?Windows-1252?Q?JlAENsPw/nG1J+YfTH/s1XBe5f3i5hARl8+NGJXylKTMzBinmaYiqotR?=
 =?Windows-1252?Q?/ZPDbUnFYnUkpkDuJnECITJG4OzOiTDse3wmWhtiA54rxz0l8WGsYkAc?=
 =?Windows-1252?Q?vUQ9TL//K3WeGNTfSlD01v1a869bOChDg4hV/gqJCmqj6Yt7LxKHgO+N?=
 =?Windows-1252?Q?Zxc3trV091J5qWgHraKJlQ57Ii/JboXGgchRP/tVMyBECmVFxmdG5UNe?=
 =?Windows-1252?Q?TbVmgmqav3J3AnBr/Sl9wIN1tTw5InkxuT2nNRf6FBNeTHKT2vKMKFr5?=
 =?Windows-1252?Q?N8bG6642YVPH45J9sxYSZXVfsjUEzLsJKYwwfJGEiTfdqc83nC9Z/HeD?=
 =?Windows-1252?Q?KqXuBoEMpM5f7w41L2Q/6AhtV8ofNcAvJ0Scs+E/0qNi0ALbhqZ+ni6q?=
 =?Windows-1252?Q?g/6iIBWhbgn0w49ByAPtE2ROGicYJgV4/N80p6F8AFpOoOMRt71mRBhe?=
 =?Windows-1252?Q?gm737fdNVzXM42BeVXfLNbMpN4vT1a2VTdMIps8V+eFXhjOA4vFKD+vY?=
 =?Windows-1252?Q?huNeUtHr/jZYgLPv5YguRtK6tqL5GMk01c1obIAdd1XzNRh5k1M1W9rk?=
 =?Windows-1252?Q?jczZO3Oc6ZPNesxwfcvI/ciHLxI2h8q0l/UOiF+XL8DCf3Vr0rt/s5Ca?=
 =?Windows-1252?Q?04JJ2oT32KO1qp4xUJchUYv+8NzhLNUb/cM//boZIpuhhz8XOzx+2qc4?=
 =?Windows-1252?Q?rgRMqgE+29mtJiDawsUDtcjYCDnf/F8AKIkZENqh/BjrHOu+g7KUtr/e?=
 =?Windows-1252?Q?P39QDW0wB7xv8fJ5gZ5RbTwttp4MI/T9LF5tHgBYLYzJ90VSPxWMTV/j?=
 =?Windows-1252?Q?QGhoC0cXq5kKuZJoW8TQLSik9+ZPIFpfFnZB2uZ2cDVgnY9b1ZGroE5Y?=
 =?Windows-1252?Q?Z58F6GwHsh9DG0lLH9CD7wmTdAW8eqfsTVR5uqOgQZY30m/czSwAfbr4?=
 =?Windows-1252?Q?hijLZMYL9mGtqTkCzeJvG7fn4PiH5+Y8of6w7GVNsJJ+l8CsAYd4wbxc?=
 =?Windows-1252?Q?2gYAeSnZVl80tmN0pRRmTrcgYYAbOiiwnIMLFQS1Rom5UZb+JIlJrroC?=
 =?Windows-1252?Q?jDmQGETQ2NyWGZlVxPuSuW4mhn5DdT6neoLhwwCZMfTwwRnKwphMWdQS?=
 =?Windows-1252?Q?xHJQ8tXaTPcFIqioOfG9R6SpKrcxaS56TBvenztYVIS0mQhqxzNdoA0E?=
 =?Windows-1252?Q?LKPi3bKhBHz11uvtLYiaSqUX/709WoHKxMM5YcBauAWC2ohAReTcMTwU?=
 =?Windows-1252?Q?zTDiL++eqI51W+97kEvGiKyzBq3Qx+9ahKee8203UggBOr/dviLLGB6Z?=
 =?Windows-1252?Q?KLNaSXSfJG3Z5mV2hbl9uP21agZu4I6tZfzIyNf3WzBDXz8EyqXU0AFD?=
 =?Windows-1252?Q?Tc2m7ml0BPgvCSx3U3MKY9m4b8aMHUt5+WyhaOoqW+NirXQTPO4x+bO1?=
 =?Windows-1252?Q?rXhFS9qq7L9mqj82I66hC3CEgw5os8bL2GelRlwtp0CTj+fOuj9CGfl+?=
 =?Windows-1252?Q?J9y6KwEqtfyOB3LcocI8JbL5kanLU/HY9vQ/GOKB3ELkJP86vwNiO8xx?=
 =?Windows-1252?Q?8eStVllQyVKwIpAu3pWteXhY55Ol6p0rxqHTwuzT3J/vv+2TO5qWm0Ym?=
 =?Windows-1252?Q?0iTdCjgs6yv+fS1Um4pv7SdxmRgybJjoPoUp3EANvCf9LD4Uj92xKklx?=
 =?Windows-1252?Q?xpMz5WklaorGs+t9jLg=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d38a644-99e9-4e34-4a0a-08d9efb683e7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3008.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 12:35:42.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ah4oOx3ZJpddRrL5DK+hM5Z/G2Os5tHD/Nw1SdwRdbVsg2rGM2O5XcjtOdFJBBiONf+QUnk4YE8Be//NFUY9wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5771
X-Proofpoint-GUID: EDhwax9q4kqjHdQ_9Tr8FJaeIJSalzhO
X-Proofpoint-ORIG-GUID: EDhwax9q4kqjHdQ_9Tr8FJaeIJSalzhO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_05,2022-02-14_03,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140076
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brown,

The focus of our differences is what the role of cs_change is.
I think the direct effect of cs_change is to change CS to inactive.
Here are some comments from spi.h:
1. Line 573, comments of 'transfer' operation in struct spi_controller:
  572      * + Chipselect stays active during the entire message
  573      *   (unless modified by spi_transfer.cs_change != 0).
It means that if cs_change != 0, chipselect will be changed to inactive.

2. Line 820, comments for struct spi_transfer:
  820  * @cs_change: affects chipselect after this transfer completes
  821  * @cs_change_delay: delay between cs deassert and assert when
  822  *      @cs_change is set and @spi_transfer is not the last in 
@spi_message
It says that the chipselect will be changed after this transfer completes.

3. Line 885, also the comments for struct spi_transfer:
  883  * All SPI transfers start with the relevant chipselect active.  
Normally
  884  * it stays selected until after the last transfer in a message.  
Drivers
  885  * can affect the chipselect signal using cs_change.
It means that we can use cs_change to make chipselect not active.

In the whole SPI subsystem, cs_change is written in several places, but 
only read
in one place: in function spi_transfer_one_message(), which is the only 
place
where cs_change comes into play.
1426     list_for_each_entry(xfer, &msg->transfers, transfer_list) {
...
1441             ret = ctlr->transfer_one(ctlr, msg->spi, xfer);
...
1484         if (xfer->cs_change) {
1485             if (list_is_last(&xfer->transfer_list,
1486                      &msg->transfers)) {
1487                 keep_cs = true;
1488             } else {
1489                 spi_set_cs(msg->spi, false, false);
1490                 _spi_transfer_cs_change_delay(msg, xfer);
1491                 spi_set_cs(msg->spi, true, false);
1492             }
1493         }
1495         msg->actual_length += xfer->len;
1496     }
spi_transfer_one_message() will process one or more transfers in the message
one by one. During this period, if cs_change is true, chipselect will be 
changed
to inactive and then be changed back to active(for next transfer), 
except the
last transfer as we no need to change chipselect back to active after 
the last
transfer. In other words, if cs_change is true, we will make an independent
transmission for each transfer.

I also investigated the role of cs_change in several drivers, the result is
similar, e.g. spi-mpc52xx-psc.c, spi-fsl-spi.c, spi-bcm63xx.c, 
spi-mpc52xx.c, etc.

To sum up, there is no indication and no requirement that when cs_change is
true, we need to keep chipselect active.

I hope you can seriously consider my analysis. If what I said is wrong, 
please
correct it.

Regards,

Yun

On 2/11/22 1:14 AM, Mark Brown wrote:
> On Fri, Feb 11, 2022 at 01:01:20AM +0800, Yun Zhou wrote:
>
>>>> If there are multiple messages, and each message only has one xfer,
>>>> and the cs_change of each xfer is 1, during the transmission of the
>>>> messages, the CS will keep active even until at the end. This must be
>>>> unreasonable.
>>> This is not something that most drivers are expected to use, cs_change
>>> should only be being used at all for very unusual hardware and it should
>>> be used even less frequently for the last transfer in a message.  It is
>>> fragile and anyone using it really needs to know what they're doing but
>>> the feature is there.
>> Maybe it's not normal to set "cs_change" in the last xfer. However, in
>> most cases, SPI messages come from user space, and these messages may
> I would question your use of "most" here...
>
>> come from multiple different applications. We can't make the whole
>> controller fail to work normally due to an inappropriate message of one
>> application.
> This is one of the many hazards of using spidev, it is not an especially
> safe or robust interface.  To the extent that there's an issue here it's
> something that should be addressed at the spidev level, though I expect
> that there will be some users who want this facility and would want a
> way to disable any access controls.  I recommend writing device drivers
> in kernel.
>
>>> The feature predates me working on the SPI stack, the obvious examples
>>> would be a device that doesn't actually use chip select where you want
>>> to avoid all chip select changes or if you need to do some other actions
>>> in the middle of a SPI transaction for some reason (which would need a
>>> bunch of system level considerations to actually be safe/sensible like
>>> making sure you're not sharing the SPI bus).
>> At present, if "cs_change" is not set, CS will be changed back to inactive
>> after the transmission is completed. If "cs_change" is set, CS will not
>> be changed. This obviously violates the definition of "cs_change".
> No, it is exactly the specified behaviour of cs_change.  Please see
> spi.h.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949134DD5BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiCRIBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiCRIBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:01:20 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF01217ECD9;
        Fri, 18 Mar 2022 00:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByrNFm8NVFy5jnJ323SEGxWPqPLJL9HX77Q77DKzSBYq3FKXE/F6iPBzffl3XtEEhDsSc96l8O2j4Dks0WTPRvCryq4xmXooGrkNMc7EFmGj+OPr8uOliG8Xgu/+7dLEeAJvKCRPU1g23f/sNfUV+WYe5B7GRY1PGPyv+eYZ82a8uwvdLP+td7ae3g1A776Qi8MeNS8R5a+4M63K5jJsO3lmQ3t78UprtwV6VTkrCkPYy2ATy7w6fyGxOl+HAfTVxpseMhsD5MIQF9Ebh3/2a4XsZASnLtDceVVzxiTQNCuoQpdbwOl5Lhd7uaUgy8TMJudVBLyJjG63v3rHn+rqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/VMb/ujxO1rsV6hpMIFD0BkcKKpY0lXbc1GnNw8pKc=;
 b=QDN8CyQloFvqdA1s7wE6niLgG1+//HJYxoVOZlcfmc6FVhS1em2UYQlT86eN+jSdg2LX2lWliYhpghxiB6tO3pExxIbzjB0CE8cpFq3kabjdan1PJXJ+VLU7jbG+KVTSljVxJlswibY2RC0SxcxjlUm3J/ThWNplwWXyAzL3a+7BrH+PvffCYmzmakTkeisVVhODIy3TBORuh09UsNlUT1i+Z/a/N9sh3WvDQKdqfc8Xshh91/7Qa0jxmXGaDD45wjNLe/UnwHD6mnWl6imNsrzOPO8yhSZ2GrkHbjInkGqJhmnht0a0G9se9hp6EQDYwnOSg6KPBgdYOroWMwW4hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=canb.auug.org.au smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/VMb/ujxO1rsV6hpMIFD0BkcKKpY0lXbc1GnNw8pKc=;
 b=KKiZhxP20TRr1AQCagxip+ppdFVZYbXy98z1Wp8u0L+i7W3KIgVzk/1Dl8/fw/Q4Hs3AZCkAHWdNNl8dIjm7Q6+kE2EnftynuyJplkcArkWgziqZrBr7p2AfB0BOGCu+d5BaLg+XZ0a2R/8CiEbni4PSxLQOqiF55GYy6p54aqc=
Received: from BN9PR03CA0338.namprd03.prod.outlook.com (2603:10b6:408:f6::13)
 by MW4PR02MB7314.namprd02.prod.outlook.com (2603:10b6:303:65::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 07:59:56 +0000
Received: from BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::61) by BN9PR03CA0338.outlook.office365.com
 (2603:10b6:408:f6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 07:59:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT029.mail.protection.outlook.com (10.13.2.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 07:59:55 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 18 Mar 2022 00:59:53 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 18 Mar 2022 00:59:53 -0700
Envelope-to: sfr@canb.auug.org.au,
 greg@kroah.com,
 olof@lixom.net,
 arnd@arndb.de,
 monstr@monstr.eu,
 david@ixit.cz,
 linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org,
 sean.anderson@seco.com,
 linux-arm-kernel@lists.infradead.org
Received: from [10.254.241.50] (port=58286)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nV7Wb-000755-C7; Fri, 18 Mar 2022 00:59:53 -0700
Message-ID: <cccec2d0-6718-0bad-728b-ae473bbce953@xilinx.com>
Date:   Fri, 18 Mar 2022 08:59:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: manual merge of the usb tree with the xilinx tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        David Heidelberg <david@ixit.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        ARM <linux-arm-kernel@lists.infradead.org>
References: <20220210141550.56359523@canb.auug.org.au>
 <YgTGdwkTkDgx+pan@kroah.com>
 <d7f84e0a-7c3a-116a-0911-2ed5a0bab2d9@xilinx.com>
 <20220318183915.08544653@canb.auug.org.au>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220318183915.08544653@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6fc7832-5b72-4833-abac-08da08b54a8e
X-MS-TrafficTypeDiagnostic: MW4PR02MB7314:EE_
X-Microsoft-Antispam-PRVS: <MW4PR02MB731491FFF269A4C8C01EAC35C6139@MW4PR02MB7314.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4oMg8k/5kVgN6o5iefGsNyY44ItJtCJ9ul3qKHOfTK2d/vlSZZ3WTn+co/5f3Yzz+08lUn4qJOS9geU2v+LbSxO0HWOGwEGjEV8x+rBaNQ0yQK8WfEjCHJ7xHNicQn/5dn23/iVi855Lk8ORpSBg70T8ah/0PHz8hKsP8+S0kWM9Y8TokHjKDmZjsOpAGwL/UjSXlMbPX45RaCABEwgkQmvGg7T1PQtVlVl2JudWnwxXEPgnLm/RaE3tf5P3+C75nOJr5W8YgtrleWsoiPQHSC3kRN/lEN6ZtvSdgzpmWE+28F1xd7wJj9q6JpJkogxrhEfwMjJpD/vUJtRW+QO7Wv5E2t7kweQpN+C/xu+MrkNph8So0diZIfDm7+IkiYaCV97YwC5zF7l1xibd3Sv01VVP2OlCF5zgCSw4ESQVoHmnACzdTDE2oJS78f6S4au4gJPyO6I/swo1qGIXS4tQuCtjS/PqmdptKV976fu5r0TJP5ZpjlA+BlNEAN73SMzKko6BOcVcz3aXm5R2T+V0RZ9RfumFvo2ZfFjhZmxkoJuEaKByTT1W/V4ESMqe5Lfq5VAtczt5sY6j0huOxBxS1oM9qlAyoFamYl5MngBEMX9abN4YpBSEO1IddeQk7PqhlmXsag+xojVqNkjrAlZlFzk3q9ZqmIHAjumChslB7nqLq6xel1LZN3XeQRk2v7j69je73teF+w6PpdtWiEAkGGWgYCfb3q74mCG2VgpevY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(426003)(5660300002)(36860700001)(508600001)(7416002)(2906002)(47076005)(83380400001)(82310400004)(40460700003)(31696002)(44832011)(36756003)(4326008)(31686004)(53546011)(8676002)(70586007)(70206006)(316002)(54906003)(110136005)(356005)(7636003)(2616005)(186003)(26005)(9786002)(8936002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 07:59:55.8063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fc7832-5b72-4833-abac-08da08b54a8e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7314
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/22 08:39, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 10 Feb 2022 13:24:44 +0100 Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> On 2/10/22 09:01, Greg KH wrote:
>>> On Thu, Feb 10, 2022 at 02:15:50PM +1100, Stephen Rothwell wrote:
>>>>
>>>> Today's linux-next merge of the usb tree got a conflict in:
>>>>
>>>>     arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>>
>>>> between commit:
>>>>
>>>>     eceb6f8677d3 ("arm64: xilinx: dts: drop legacy property #stream-id-cells")
>>>>
>>>> from the xilinx tree and commit:
>>>>
>>>>     d8b1c3d0d700 ("arm64: dts: zynqmp: Move USB clocks to dwc3 node")
>>>>
>>>> from the usb tree.
>>>>
>>>> I fixed it up (see below) and can carry the fix as necessary. This
>>>> is now fixed as far as linux-next is concerned, but any non trivial
>>>> conflicts should be mentioned to your upstream maintainer when your tree
>>>> is submitted for merging.  You may also want to consider cooperating
>>>> with the maintainer of the conflicting tree to minimise any particularly
>>>> complex conflicts.
>>>>
>>>> diff --cc arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>> index 056761c974fd,ba68fb8529ee..000000000000
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>> @@@ -823,6 -824,8 +822,7 @@@
>>>>     				interrupt-parent = <&gic>;
>>>>     				interrupt-names = "dwc_usb3", "otg";
>>>>     				interrupts = <0 65 4>, <0 69 4>;
>>>> + 				clock-names = "bus_early", "ref";
>>>>    -				#stream-id-cells = <1>;
>>>>     				iommus = <&smmu 0x860>;
>>>>     				snps,quirk-frame-length-adjustment = <0x20>;
>>>>     				/* dma-coherent; */
>>>> @@@ -849,6 -851,8 +848,7 @@@
>>>>     				interrupt-parent = <&gic>;
>>>>     				interrupt-names = "dwc_usb3", "otg";
>>>>     				interrupts = <0 70 4>, <0 74 4>;
>>>> + 				clock-names = "bus_early", "ref";
>>>>    -				#stream-id-cells = <1>;
>>>>     				iommus = <&smmu 0x861>;
>>>>     				snps,quirk-frame-length-adjustment = <0x20>;
>>>>     				/* dma-coherent; */
>>>> -- >> Cheers,
>>>> Stephen Rothwell
>>>
>>>
>>>
>>> Looks good, thanks!
>>
>> +1 on this.
> 
> This is now a conflict between the usb tree and the arm-soc tree.
> 

yes. I sent pull request to SOC tree and let Arnd know about this conflict.

Thanks,
Michal

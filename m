Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9F7529FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344879AbiEQLGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiEQLGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:06:40 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408596162;
        Tue, 17 May 2022 04:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZisQUjn+DIRnT+FipDUEfuOft4ehe3d1e0/tEac/WFXbbQ1bwSQ393TvBD4Uy5ss8uFPA1D8cfY9fCajG9JxrnVANTjJJNpdpPNS83BNJZTbosyOyYlNgrRabGku5rGyPGxJqjszNwtMwhqXHcTBidUEQn53jFNffYAYUznZ6gIiD1HV7lS5w4X9ukTycbcKBtwDYg+NGWUcaW3y4OifpW71M0VGS1+jgOSr0J9/WKZU4MpSwb7f3EbzdEkqeIIe+LluUCy8jKGZNLW+M1Tt/6GEK5dVCM2l2FPYn8o6EZ60TFYmt0uV3eQsBTvG4Ri6z/a26BblSNORYKofB+ibSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euRvh3G2CFy/kFmRcKHLUfI9v23G/VFBNga8yG5o8s4=;
 b=B3E3/Eq3vh5z//j6swxbWR5tkLJeGZKI9tsMWxVACpU4hOl1WMBkVUEG0T3Jy7ri64+DKXlPtMiNLao7iE2aVstEtlZnHp17+EU5ppMhuAsjeFRDjsQqEI3tjXOEAkTeQ22LDzcs54aHcIPpgo7CBr7Ok4y4ao9vuO/flzZ1cdghjy1fWWAqJ3jCctRcjgrULlwT5jsFvD5gJ+k7jPD+ozVh+J64cuB32scQhAM1DMNVgBHmgFbjeEBDr/UGzQytAvzUHULCKf6eWJ8WOlRRJCRu4TeKwoUR9nw5pvDBXWC3v2fOsNRwbVrDQdEYfDlL4fTuWYVzO9YDyvVpdOJV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euRvh3G2CFy/kFmRcKHLUfI9v23G/VFBNga8yG5o8s4=;
 b=aU/ZmrK2DeOPysQIDZZXyIc8xnAI3l8ff1bWf+omwsvTjcJNFr83PYk2QVQARogll3Szr0oxaPjoGaXjedjNsc6605RtJo77J8w+vjRRqShdW+OhaoQc1Zv63jWDWEnEBpNd+Ft2Sodvj+nL4LABXeL1xWPbUkFCNZF3w/JtBGs=
Received: from SA0PR11CA0209.namprd11.prod.outlook.com (2603:10b6:806:1bc::34)
 by BL3PR02MB8033.namprd02.prod.outlook.com (2603:10b6:208:358::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 11:06:36 +0000
Received: from SN1NAM02FT0006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bc:cafe::52) by SA0PR11CA0209.outlook.office365.com
 (2603:10b6:806:1bc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Tue, 17 May 2022 11:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0006.mail.protection.outlook.com (10.97.5.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 11:06:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 17 May 2022 04:06:35 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 17 May 2022 04:06:35 -0700
Envelope-to: gregkh@linuxfoundation.org,
 mka@chromium.org,
 dianders@chromium.org,
 stern@rowland.harvard.edu,
 robh+dt@kernel.org,
 frowand.list@gmail.com,
 mathias.nyman@intel.com,
 balbi@kernel.org,
 linux-usb@vger.kernel.org,
 ravisadineni@chromium.org,
 rogerq@kernel.org,
 linux-kernel@vger.kernel.org,
 hadess@hadess.net,
 swboyd@chromium.org,
 devicetree@vger.kernel.org,
 krzk@kernel.org,
 peter.chen@kernel.org,
 guozhengkui@vivo.com,
 kishon@ti.com,
 jun.li@nxp.com,
 peter.chen@nxp.com,
 Thinh.Nguyen@synopsys.com
Received: from [10.254.241.50] (port=60022)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nqv2A-0004rq-Dz; Tue, 17 May 2022 04:06:34 -0700
Message-ID: <53f2e0b9-2b5a-51e2-6a71-d831ad6cb484@xilinx.com>
Date:   Tue, 17 May 2022 13:06:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v21 0/3] usb: misc: Add onboard_usb_hub driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Matthias Kaehlcke <mka@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Li Jun <jun.li@nxp.com>, Peter Chen <peter.chen@nxp.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <20220217184254.4141705-1-mka@chromium.org>
 <CAD=FV=XswQj+L6rRuWH-PdoGp9vVsWKTwz1bFM_fagy55tKqEg@mail.gmail.com>
 <YmGetA6Huz4Sj/RL@google.com> <YmffM2XuCiOghOLU@kroah.com>
 <894ea48c-7962-320e-e177-9652701c72fe@xilinx.com>
 <YoN8Ti3xk4ElTiLP@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <YoN8Ti3xk4ElTiLP@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b73007a-ab1b-44e0-e707-08da37f54ef3
X-MS-TrafficTypeDiagnostic: BL3PR02MB8033:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB8033390248DE11C755753FEBC6CE9@BL3PR02MB8033.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbdVAcWGZ1YfVIrGRLws7mfOyaeD/IiV/rTkK3hjzQKAYdBlU4zw5kbfyI7BTOYZBpU4ME09KItHdQkjWCpB6OKQT5i1FR0KyB4pxR80kGm/8hLRbKdWd8zFeM2TtQILeaeKX/RMv9tzOPZVAST88G1nUS2a1UyNF91teuGJp7IqON8WlD86y2734j9QsGQCn99vbEsTgPwkZFNeyP5ShnXsTCkyZ0v+jumdrEMXH8p5iW9K9mpvZzwMvjgcrrFa01auHj0uNAer15Ow0jM3829GSvC9jYg4AmZXb6730DPXyk0LDju+nghpMUwHOaTtePMhFdp0S6X7QhU6e9h6yn6HfLM2gsaeoXLciOls78mFxnmUQBDCztD021XSQTWEWGLSy2CbbLCediBv1LE9coz/FS0ah2GEFinpo240q1HOSFOtIG/httqA6zIeTU5RJg1CFbcaFeBmngiQRiRJ8Hqjk5GCv2Up6bEOLeWlS94keTyhfpE7BUEUdq07yp8hJg3mjllL14+Jg41RcZsyUBx9VMNY8zO+SbwhGG5T36qL7BiquHKHqUd1iP1b0OZBvUfdMa7d5XGipFCJyfwF5uFRbTsAgYm7g0u7/44uYpny9JHPARVZOS2omUBmh9hKTmiFCOO9/ps0MrBtDA5vwsbEpE0mGPSLEPefQNg8puPuac0o4I5Xk0ujgOqk4sUrOQ8USa0kjl7paUyewc12iQk83aRODS7of7pAELlGsWXQUvpKRs/pB0Lx+jecyyxq8E9r8h1nmkN+WpQsPVtPfiK7/3aeKAuRidYgyk1bQLGZLqmqMoWkqi1VW4RRwvAx
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(44832011)(356005)(83380400001)(54906003)(8936002)(40460700003)(31696002)(110136005)(316002)(7636003)(31686004)(508600001)(9786002)(36756003)(70206006)(2616005)(82310400005)(336012)(186003)(2906002)(426003)(966005)(70586007)(4326008)(47076005)(8676002)(5660300002)(7416002)(6666004)(36860700001)(53546011)(26005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 11:06:35.6687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b73007a-ab1b-44e0-e707-08da37f54ef3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8033
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/22 12:43, Greg Kroah-Hartman wrote:
> On Tue, May 17, 2022 at 12:36:03PM +0200, Michal Simek wrote:
>> Hi Greg,
>>
>> On 4/26/22 14:01, Greg Kroah-Hartman wrote:
>>> On Thu, Apr 21, 2022 at 11:13:08AM -0700, Matthias Kaehlcke wrote:
>>>> Hi,
>>>>
>>>> On Thu, Apr 07, 2022 at 12:41:22PM -0700, Doug Anderson wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, Feb 17, 2022 at 10:43 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>>>>>>
>>>>>> This series adds:
>>>>>> - the onboard_usb_hub_driver
>>>>>> - glue in the generic HCD code to create and destroy the
>>>>>>     onboard_usb_hub platform devices if needed
>>>>>> - device tree changes that add RTS5411 entries for the QCA SC7180
>>>>>>     based boards trogdor and lazor
>>>>>> - a couple of stubs for platform device functions to avoid
>>>>>>     unresolved symbols with certain kernel configs
>>>>>>
>>>>>> The main issue the driver addresses is that a USB hub needs to be
>>>>>> powered before it can be discovered. For discrete onboard hubs (an
>>>>>> example for such a hub is the Realtek RTS5411) this is often solved
>>>>>> by supplying the hub with an 'always-on' regulator, which is kind
>>>>>> of a hack. Some onboard hubs may require further initialization
>>>>>> steps, like changing the state of a GPIO or enabling a clock, which
>>>>>> requires even more hacks. This driver creates a platform device
>>>>>> representing the hub which performs the necessary initialization.
>>>>>> Currently it only supports switching on a single regulator, support
>>>>>> for multiple regulators or other actions can be added as needed.
>>>>>> Different initialization sequences can be supported based on the
>>>>>> compatible string.
>>>>>>
>>>>>> Besides performing the initialization the driver can be configured
>>>>>> to power the hub off during system suspend. This can help to extend
>>>>>> battery life on battery powered devices which have no requirements
>>>>>> to keep the hub powered during suspend. The driver can also be
>>>>>> configured to leave the hub powered when a wakeup capable USB device
>>>>>> is connected when suspending, and power it off otherwise.
>>>>>>
>>>>>> Changes in v21:
>>>>>> - dropped patch 'driver core: Export device_is_bound()'
>>>>>> - refactored _find_onboard_hub()
>>>>>> - removed 'onboard_hub_dev' symlinks from USB devices
>>>>>> - dropped patch 'arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub'
>>>>>>     (will be sent separately)
>>>>>> - rebased series on v5.17-rc4
>>>>>>
>>>>>> Changes in v20:
>>>>>> - addressed review comments from Stephen
>>>>>> - changed DT node names for hubs
>>>>>>
>>>>>> Changes in v19:
>>>>>> - added VID:PID pairs and compatible strings for RTS5414 hub
>>>>>> - updated comments with RTS5411 USB versions to reflect those
>>>>>>     reported/supported by the hub
>>>>>> - rebased series on v5.16
>>>>>>
>>>>>> Changes in v18:
>>>>>> - introduced hidden Kconfig option to align module vs. builtin
>>>>>>     choice with CONFIG_USB (thanks Doug!)
>>>>>> - added patch 'driver core: Export device_is_bound()'
>>>>>> - also adjust device tree of pompom rev1
>>>>>> - dropped the following patches, which aren't needed anymore by this
>>>>>>     series (though they might still be useful on their own):
>>>>>>     - usb: Specify dependencies on USB_XHCI_PLATFORM with 'depends on'
>>>>>>     - arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM
>>>>>>     - ARM: configs: Explicitly enable USB_XHCI_PLATFORM where needed
>>>>>>
>>>>>> Changes in v17:
>>>>>> - rebased on top of v5.16-rc1
>>>>>> - moved creation of onboard_hub platform devices from xhci_platform
>>>>>>     to the generic HCD code
>>>>>> - addressed review comments for the onboard_hub driver
>>>>>> - moved Kconfig/defconfig changes to the end of the series. The
>>>>>>     onboard_hub driver doesn't depend on XHCI_PLATFORM anymore,
>>>>>>     hence these changes aren't really required for the driver, but
>>>>>>     they still seem to be a worthwhile improvement
>>>>>>
>>>>>> Changes in v16:
>>>>>> - added patch 'ARM: configs: Explicitly enable USB_XHCI_PLATFORM
>>>>>>     where needed' to keep arm32 defconfigs effectively unchanged
>>>>>>
>>>>>> Changes in v15:
>>>>>> - adjusted dependencies of USB_DWC3_CORE to make sure it can only
>>>>>>     be enabled when at least one of USB_DWC3_HOST, USB_DWC3_GADGET
>>>>>>     or USB_DWC3_DUAL_ROLE is selectable
>>>>>>
>>>>>> Changes in v14:
>>>>>> - rebased on top of v5.14-rc1
>>>>>> - dropped DT binding patch which landed in v5.13
>>>>>>
>>>>>> Changes in v13:
>>>>>> - added patch "usb: Specify dependency on USB_XHCI_PLATFORM with
>>>>>>     'depends on'" to the series to avoid Kconfig conflicts
>>>>>> - added patch "arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM"
>>>>>>     to the series to keep effective defconfig unchanged
>>>>>>
>>>>>> Changes in v12:
>>>>>> - onboard_hub driver: use IS_ENABLED(CONFIG_USB_ONBOARD_HUB_MODULE)
>>>>>>     in onboard_hub.h to also check for the driver built as module
>>>>>> - onboard_hub_driver: include onboard_hub.h again to make sure there
>>>>>>     are prototype declarations for the public functions
>>>>>>
>>>>>> Changes in v11:
>>>>>> - support multiple onboard hubs connected to the same parent
>>>>>> - don't include ‘onboard_hub.h’ from the onboard hub driver
>>>>>>
>>>>>> Changes in v10:
>>>>>> - always use of_is_onboard_usb_hub() stub unless ONBOARD_USB_HUB=y/m
>>>>>> - keep 'regulator-boot-on' property for pp3300_hub
>>>>>>
>>>>>> Changes in v9:
>>>>>> - added dependency on ONBOARD_USB_HUB (or !ONBOARD_USB_HUB) to
>>>>>>     USB_PLATFORM_XHCI
>>>>>>
>>>>>> Changes in v7:
>>>>>> - updated DT binding
>>>>>> - series rebased on qcom/arm64-for-5.13
>>>>>>
>>>>>> Changes in v6:
>>>>>> - updated summary
>>>>>>
>>>>>> Changes in v5:
>>>>>> - cover letter added
>>>>>>
>>>>>> Matthias Kaehlcke (3):
>>>>>>     of/platform: Add stubs for of_platform_device_create/destroy()
>>>>>>     usb: misc: Add onboard_usb_hub driver
>>>>>>     usb: core: hcd: Create platform devices for onboard hubs in probe()
>>>>>>
>>>>>>    .../sysfs-bus-platform-onboard-usb-hub        |   8 +
>>>>>>    MAINTAINERS                                   |   7 +
>>>>>>    drivers/usb/core/hcd.c                        |   6 +
>>>>>>    drivers/usb/misc/Kconfig                      |  23 +
>>>>>>    drivers/usb/misc/Makefile                     |   1 +
>>>>>>    drivers/usb/misc/onboard_usb_hub.c            | 510 ++++++++++++++++++
>>>>>>    include/linux/of_platform.h                   |  22 +-
>>>>>>    include/linux/usb/hcd.h                       |   1 +
>>>>>>    include/linux/usb/onboard_hub.h               |  18 +
>>>>>>    9 files changed, 592 insertions(+), 4 deletions(-)
>>>>>>    create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
>>>>>>    create mode 100644 drivers/usb/misc/onboard_usb_hub.c
>>>>>>    create mode 100644 include/linux/usb/onboard_hub.h
>>>>>
>>>>> With v5.18-rc1 out the door, I wonder if it's a good time to look at
>>>>> this series again. Are there any hidden blockers that it's waiting
>>>>> for?
>>>>
>>>> Greg, please let me know if any further changes are needed or if this
>>>> series can be landed.
>>>
>>> After 21 different versions, there's nothing left for me to object to,
>>> so I'll go queue it up.  Thanks for sticking with it.
>>
>> I just checked linux-next and this series is still not there. Are you going
>> to merge it or are you waiting for v22?
> 
> It was merged, and I had to revert it based on reports of problems with
> it.  See the thread here:
> 	https://lore.kernel.org/r/20220502210728.0b36f3cd@canb.auug.org.au
> for details.

Matthias: Are you going to send v22 version?

Thanks,
Michal



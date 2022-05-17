Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEED529F96
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344496AbiEQKgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344635AbiEQKgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:36:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3D86306;
        Tue, 17 May 2022 03:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIb8qIvYc+JVTq7tj9f81Zu3+iyh0AdDHDrzY+FfNn0I62nJrp5C2w9pQerXRBGN7bbMue6gFbLtZgWfkPAHrO10its6muqShYENQkuo2LsZNebzpwPqENiCpdrx8Tnh9AOehxRs/7qLvaSBjxsMbu+Zdg8pAsNTdtVrRYaCLv7AMwdME7OTIZSN/7HzQU8ICkzKPebYEuCtFn+Z3rlTZeLZEynGMma+SsOZ1asGo17Wuk6ydVvntpX+NEKpFNhG3vPe4+YKI+6CeY04H7/bW0ahJeO2vTLLeN5WtZ8iQhRMZ8UtJm8K5gniqaCbpOyNpgSE+B4gMjZI9o4oWcZYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkpzoLaixMLUs6HnmfelBDKKBMPCzwn924FVEOtKEMI=;
 b=M6nv5PRrzwuQ3fmZH1oShq4HeAaJY8lLdSRgV5dSOLVSCMEaQ1RQGV5ftB3Seh22AbuBsr44Sw0vHSaIl0ly7ntMIZHKve87tkR4uiQanaoak0aJzmow9AjOW3LHR7O9dlbE+58WnOQh3LSJNRmcHYNhaRfUI+zqmAPEoAorUvKl8yPHHgBFJTG50AKizxL9QUxe4AJaErOgECzy2d3jo0jMUyMzRU4QBp6xpPVVO5EyuAEFGbW2WoT9sb0VvJYRbtHfIsQcSFA3yXfok7wirgcTFsN+JF2/BGOf6Hqsz+ptO1yfof8HpPoLbp6StM31lGnjj7o/0TV6G1wJEADV5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkpzoLaixMLUs6HnmfelBDKKBMPCzwn924FVEOtKEMI=;
 b=gt02sQ/m89M+JT43X/19IGYjKHDB2w/+Dmpi1OrKDtS6wGqhwKkwwq4K7Xyv3ERVYhMXL1gh27SU59DHiC2dGkaBm5ZVL4GjfNNgbKbb+GRoVi0BDTLbS4DPGS2F63y1l06CXC0OsyxT9dNKr2qvIy6yTfNnV5BMLVbRCJMDC1o=
Received: from DM6PR12CA0027.namprd12.prod.outlook.com (2603:10b6:5:1c0::40)
 by DM5PR02MB3814.namprd02.prod.outlook.com (2603:10b6:4:b3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 10:36:09 +0000
Received: from DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::e7) by DM6PR12CA0027.outlook.office365.com
 (2603:10b6:5:1c0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Tue, 17 May 2022 10:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT012.mail.protection.outlook.com (10.13.5.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 10:36:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 17 May 2022 03:36:08 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 17 May 2022 03:36:08 -0700
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
Received: from [10.254.241.50] (port=57504)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nquYi-0006He-5T; Tue, 17 May 2022 03:36:08 -0700
Message-ID: <894ea48c-7962-320e-e177-9652701c72fe@xilinx.com>
Date:   Tue, 17 May 2022 12:36:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v21 0/3] usb: misc: Add onboard_usb_hub driver
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     Doug Anderson <dianders@chromium.org>,
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
        Michal Simek <michal.simek@xilinx.com>,
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
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <YmffM2XuCiOghOLU@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f876358-2c42-46bb-a559-08da37f10e4a
X-MS-TrafficTypeDiagnostic: DM5PR02MB3814:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB3814E3E664A7B686869B7B43C6CE9@DM5PR02MB3814.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tl5xoVUUDW+Xfk6OSrjB5h1FGdTeHv+5Abxl/z3PPl2DYciYrUG6IDsJ7qKqZh0PckosR5PWB0qDm21+QY9KUjQhc1sVCk4HlfPaMKbTq4tY8huhUtoshj/A2qSutIsAbPymO00DbPZneuBrDQ00Cv7213iUcjZL0QPxp9yPon5ZwTC69Rgs4t3C4sWBKkkvmJSk/DNRlxz/GCETDosit/o8X2UtdQrG9J9opKbgXP63/E06S9z4f8nv/fk7Y0JbaT9qnaMxDnnMT7WFZz2C4XizPTOw8tbGbdLKLpFthk7TkKRkXXclJd6LyFVQSZrzkF4i1t6YwEfHyP5ixB8Sg9BbSlL2wYrrKAsw13D01kPMTpKMMSsSumhP3n/KQScvL2qLKNKB/TW5KhW/2cw85yAhJby8XwVLii4sP6lRcvsP+Bv28tHv9rr9obnjFE5s1jnu+CF023g/vBqd8HU0aF0wSjnlYUL4cRITf51CZ2mIEFedNqLrJJ+Qb45s4jmDEvKNqOMPtemljL4O8/gve0KJDwkhFuSynojnZu334o7tFKGXTLCa7e7tY874IN1NVvptRIigQHWyi/6thXhRakHJro2dazN6Tz7iYG+o42ukq6eujvGruwERpcFAbKjzkcaT581MFmD8ugxO0lTgA1rAHanNxOQGgQRpUppemloQ1nQV+7KKb9QFF8hxaV1TJhs3tvbbdXRQm1fc6GO3cQxDynI62GRJji5GuBH2ALI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(47076005)(53546011)(82310400005)(6666004)(8936002)(26005)(356005)(316002)(7416002)(83380400001)(110136005)(54906003)(36860700001)(36756003)(40460700003)(9786002)(8676002)(7636003)(4326008)(2616005)(70586007)(70206006)(5660300002)(44832011)(2906002)(31686004)(31696002)(336012)(186003)(426003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 10:36:09.1984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f876358-2c42-46bb-a559-08da37f10e4a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3814
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 4/26/22 14:01, Greg Kroah-Hartman wrote:
> On Thu, Apr 21, 2022 at 11:13:08AM -0700, Matthias Kaehlcke wrote:
>> Hi,
>>
>> On Thu, Apr 07, 2022 at 12:41:22PM -0700, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Thu, Feb 17, 2022 at 10:43 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>>>>
>>>> This series adds:
>>>> - the onboard_usb_hub_driver
>>>> - glue in the generic HCD code to create and destroy the
>>>>    onboard_usb_hub platform devices if needed
>>>> - device tree changes that add RTS5411 entries for the QCA SC7180
>>>>    based boards trogdor and lazor
>>>> - a couple of stubs for platform device functions to avoid
>>>>    unresolved symbols with certain kernel configs
>>>>
>>>> The main issue the driver addresses is that a USB hub needs to be
>>>> powered before it can be discovered. For discrete onboard hubs (an
>>>> example for such a hub is the Realtek RTS5411) this is often solved
>>>> by supplying the hub with an 'always-on' regulator, which is kind
>>>> of a hack. Some onboard hubs may require further initialization
>>>> steps, like changing the state of a GPIO or enabling a clock, which
>>>> requires even more hacks. This driver creates a platform device
>>>> representing the hub which performs the necessary initialization.
>>>> Currently it only supports switching on a single regulator, support
>>>> for multiple regulators or other actions can be added as needed.
>>>> Different initialization sequences can be supported based on the
>>>> compatible string.
>>>>
>>>> Besides performing the initialization the driver can be configured
>>>> to power the hub off during system suspend. This can help to extend
>>>> battery life on battery powered devices which have no requirements
>>>> to keep the hub powered during suspend. The driver can also be
>>>> configured to leave the hub powered when a wakeup capable USB device
>>>> is connected when suspending, and power it off otherwise.
>>>>
>>>> Changes in v21:
>>>> - dropped patch 'driver core: Export device_is_bound()'
>>>> - refactored _find_onboard_hub()
>>>> - removed 'onboard_hub_dev' symlinks from USB devices
>>>> - dropped patch 'arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub'
>>>>    (will be sent separately)
>>>> - rebased series on v5.17-rc4
>>>>
>>>> Changes in v20:
>>>> - addressed review comments from Stephen
>>>> - changed DT node names for hubs
>>>>
>>>> Changes in v19:
>>>> - added VID:PID pairs and compatible strings for RTS5414 hub
>>>> - updated comments with RTS5411 USB versions to reflect those
>>>>    reported/supported by the hub
>>>> - rebased series on v5.16
>>>>
>>>> Changes in v18:
>>>> - introduced hidden Kconfig option to align module vs. builtin
>>>>    choice with CONFIG_USB (thanks Doug!)
>>>> - added patch 'driver core: Export device_is_bound()'
>>>> - also adjust device tree of pompom rev1
>>>> - dropped the following patches, which aren't needed anymore by this
>>>>    series (though they might still be useful on their own):
>>>>    - usb: Specify dependencies on USB_XHCI_PLATFORM with 'depends on'
>>>>    - arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM
>>>>    - ARM: configs: Explicitly enable USB_XHCI_PLATFORM where needed
>>>>
>>>> Changes in v17:
>>>> - rebased on top of v5.16-rc1
>>>> - moved creation of onboard_hub platform devices from xhci_platform
>>>>    to the generic HCD code
>>>> - addressed review comments for the onboard_hub driver
>>>> - moved Kconfig/defconfig changes to the end of the series. The
>>>>    onboard_hub driver doesn't depend on XHCI_PLATFORM anymore,
>>>>    hence these changes aren't really required for the driver, but
>>>>    they still seem to be a worthwhile improvement
>>>>
>>>> Changes in v16:
>>>> - added patch 'ARM: configs: Explicitly enable USB_XHCI_PLATFORM
>>>>    where needed' to keep arm32 defconfigs effectively unchanged
>>>>
>>>> Changes in v15:
>>>> - adjusted dependencies of USB_DWC3_CORE to make sure it can only
>>>>    be enabled when at least one of USB_DWC3_HOST, USB_DWC3_GADGET
>>>>    or USB_DWC3_DUAL_ROLE is selectable
>>>>
>>>> Changes in v14:
>>>> - rebased on top of v5.14-rc1
>>>> - dropped DT binding patch which landed in v5.13
>>>>
>>>> Changes in v13:
>>>> - added patch "usb: Specify dependency on USB_XHCI_PLATFORM with
>>>>    'depends on'" to the series to avoid Kconfig conflicts
>>>> - added patch "arm64: defconfig: Explicitly enable USB_XHCI_PLATFORM"
>>>>    to the series to keep effective defconfig unchanged
>>>>
>>>> Changes in v12:
>>>> - onboard_hub driver: use IS_ENABLED(CONFIG_USB_ONBOARD_HUB_MODULE)
>>>>    in onboard_hub.h to also check for the driver built as module
>>>> - onboard_hub_driver: include onboard_hub.h again to make sure there
>>>>    are prototype declarations for the public functions
>>>>
>>>> Changes in v11:
>>>> - support multiple onboard hubs connected to the same parent
>>>> - don't include ‘onboard_hub.h’ from the onboard hub driver
>>>>
>>>> Changes in v10:
>>>> - always use of_is_onboard_usb_hub() stub unless ONBOARD_USB_HUB=y/m
>>>> - keep 'regulator-boot-on' property for pp3300_hub
>>>>
>>>> Changes in v9:
>>>> - added dependency on ONBOARD_USB_HUB (or !ONBOARD_USB_HUB) to
>>>>    USB_PLATFORM_XHCI
>>>>
>>>> Changes in v7:
>>>> - updated DT binding
>>>> - series rebased on qcom/arm64-for-5.13
>>>>
>>>> Changes in v6:
>>>> - updated summary
>>>>
>>>> Changes in v5:
>>>> - cover letter added
>>>>
>>>> Matthias Kaehlcke (3):
>>>>    of/platform: Add stubs for of_platform_device_create/destroy()
>>>>    usb: misc: Add onboard_usb_hub driver
>>>>    usb: core: hcd: Create platform devices for onboard hubs in probe()
>>>>
>>>>   .../sysfs-bus-platform-onboard-usb-hub        |   8 +
>>>>   MAINTAINERS                                   |   7 +
>>>>   drivers/usb/core/hcd.c                        |   6 +
>>>>   drivers/usb/misc/Kconfig                      |  23 +
>>>>   drivers/usb/misc/Makefile                     |   1 +
>>>>   drivers/usb/misc/onboard_usb_hub.c            | 510 ++++++++++++++++++
>>>>   include/linux/of_platform.h                   |  22 +-
>>>>   include/linux/usb/hcd.h                       |   1 +
>>>>   include/linux/usb/onboard_hub.h               |  18 +
>>>>   9 files changed, 592 insertions(+), 4 deletions(-)
>>>>   create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-onboard-usb-hub
>>>>   create mode 100644 drivers/usb/misc/onboard_usb_hub.c
>>>>   create mode 100644 include/linux/usb/onboard_hub.h
>>>
>>> With v5.18-rc1 out the door, I wonder if it's a good time to look at
>>> this series again. Are there any hidden blockers that it's waiting
>>> for?
>>
>> Greg, please let me know if any further changes are needed or if this
>> series can be landed.
> 
> After 21 different versions, there's nothing left for me to object to,
> so I'll go queue it up.  Thanks for sticking with it.

I just checked linux-next and this series is still not there. Are you going to 
merge it or are you waiting for v22?

Thanks,
Michal


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6FE5A2C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiHZQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbiHZQWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:22:41 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50067.outbound.protection.outlook.com [40.107.5.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E91FDEB5A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 09:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkR92/xcSocKefKty9X/liDrShJ++cNSPPkB45MwXwsxzS0vRjvNyrvE4mAcK4KC5L/PW55fSxRgRh918g8QP+ZQnWgaV43q52x9SQiJtiW7pwedfXTPYGdJ9/SwIFnPWZsdc3AL439DHEXvjWcneBjgqbUr0k6kmyWgSNCfKjFNWBXqwWqj+vzzbb9TYtqZBctpx6g/lD3D0e1/ox+tb9gDj0Ascv9T+h3m3niBJlPyTdJi+euMjnDlVuwUOivH7+0DUQ/atfqkYPgnns/CBSl8WkF8BKJgd14HI//xh0JL0wko0u1Sv14oFKB1R/9Owg2IEmm0KupzsCiBBgBMqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6npxgPA8VspPoslgB7/gyFCvie4rmgRGuMqHbwi+si4=;
 b=LUg+IcY2XN26fLPL1dMDncshX5EvVFN3I/CxQ5EUPB0BB2JZCCWTQujD4fI6SmzXnKCGlrjUiBRLLbhnzG7usojnE/1KPEmMzLmcNAVeqHbaiudJEQXKCGIIKQRV6PJtj3illCKL+KSvGwjj2M6/UnBu3GgWNrXAtdQ1K9rSDEd3p67/S6l0xGMGOK8tLGkdqxE4GbL/IKjnx4sLOcY9MYwIoUi7HMNg+hrcgtZ0wo8J1x5WBs3qJgtgrcmNmcdochv/vNaDX4yB6LO4QO+rJ695AMhjTFogFMHUUc9ZuE6fdvl9tI5+j4ahWWrxdwWpxTIjGENf9Rp5aQtLfwmV0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6npxgPA8VspPoslgB7/gyFCvie4rmgRGuMqHbwi+si4=;
 b=0IZ/6A5PkJ/gIyo44i1A73djTVh4RLB5mOPqb0KWLQ1T+ZfdoOSJmA05cShfljAvYVSOqtmVMA4qR3MyGlNbDW2ICpNjCymLJZwY19/sKwOTjUNgWv6kiht4w3m5acpOtVVfILZsgCZBkl40TKUGs78nD0goAZsvx95FSU8fjZ2SnLJHkW3NU1H9QY/wOzArTBGjyl4syvAQyDthaCEp4rwXDaeUIegnGfUvBTQNkwHSKAOFGa6+uCm5IucaHo0JkQ6/RsZNv+8oH62Yin6qbVu8kw2R3dh3mdZZl8p0OsiFgvXIM9EuB6zSlzCdqz68upwF6KNIHlsHMxbJcWV2Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB7PR03MB3596.eurprd03.prod.outlook.com (2603:10a6:5:4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Fri, 26 Aug 2022 16:22:28 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::ecaa:a5a9:f0d5:27a2]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::ecaa:a5a9:f0d5:27a2%4]) with mapi id 15.20.5504.019; Fri, 26 Aug 2022
 16:22:28 +0000
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Sean Anderson <sean.anderson@seco.com>
Subject: retire_capture_urb: Corrected urb data len
Message-ID: <68a97d61-21bf-b45e-f6ed-c0906dd4b197@seco.com>
Date:   Fri, 26 Aug 2022 12:22:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:208:239::21) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80ce556c-cbfc-40c8-1131-08da877f2af3
X-MS-TrafficTypeDiagnostic: DB7PR03MB3596:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xGTvWw2k9FtTxdb29sgDQOsxYunx2uZ6vEHBHIHaVQ/XiTlHyEh9BGJaYDKVz0Bb05JQgCI9ziV870GxqzV0RfMZ/YCodoo2OsAqq1LLXGCQmw3tCMyG4YR0yIaUlwiw2x0fYWW5wf4H/y5gnqU+ksvRIZCh8FyPS27dn/0gx0Mde7UVPXBjdPKvhy+DCv/pyxx2ijlmJw2Rx/IsUwYMcgFqPRKCW4CNTRNUIsPTimC08r/FW1KWV79rNjebXkSxTGkaUoPgI1d+t2E2M8A8tKtc7EFtPkxNdNjgm0+3N5/Du96wctVVnGU6l/Nrdi78HzjZwBc0ktI9FpoykubwpO6ggC1PEr9NOYU+QK4F03nKpBEHrkCgazmnoDCaAbCmoBlt7q8EtZNeU+TDaCz0wVYS+Q6uksSIuevucqyJtAA49DCSCyluDGS+Id+bZ8xWMaONINkLZYv2hQ5evxW8O7/kJoOGnFp0FWO3EBeY2be0OVMvzEG7hHWVLJexzxnw2XDs+Zo4vmUQ1XbkCneTLzFiS5eOFP3ccEtLMRm0khEftA4tqWhavK43QlUlMnRhd9NwV2w/NI9ejrvwxOJrpQtEVvcChjcG0PdITuN8dV3dqMoPTH0edD8gtAJbOnitTeLSe90QNJw18GJ4amOtcJ2AX0wjDMCMRAV05djK7bAcV/E6smab9k+aOyQiICO48cXmiHMwyMohDHA12qgbQvgSKe2/kf0D5VNnkRBLmfbXjkwrWXr5gyHT1TOKbJnfL5CyQsgyRAMeDeCfp71mtBBaKrvOpLqSBbVxLtXXQwhoI4uPOlGIRUYCTwUIQy5WlLjB34X4y5tT0MNlom27KrxLwUgT4AGOom31Jrab7gM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(396003)(366004)(39840400004)(26005)(44832011)(86362001)(52116002)(6506007)(31696002)(2906002)(110136005)(316002)(36756003)(186003)(41300700001)(478600001)(83380400001)(5660300002)(31686004)(66476007)(38100700002)(2616005)(966005)(6666004)(6512007)(66946007)(8936002)(4326008)(8676002)(6486002)(66556008)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTNuWm5hYk8rVFlXdGRaTkJpdW4yT0pNRXA5ckRKeDh5b3FvR0tkL2lGNTBr?=
 =?utf-8?B?L0VFbkNZdEtjZEJ6cHVtSTc1Zkc3b2Y3aVN4RUtmOFRJZkZKc2xhU240ZitV?=
 =?utf-8?B?RENxTm9WZnlLbi9tbVBsODNyZVB6V05tVURpbDM0c2hSUEI3QVFKTDRmZjA1?=
 =?utf-8?B?UUoxOThIVUI0WldGZUFZSktxdmsxTjY5UEtsdjNBN25NL3Z2QlBIVDBrT1Na?=
 =?utf-8?B?VFFadWlnbFBOdlJJdDZTOEs1YXl6ZUd6NXJKVCs1dkQ3L010WGw4TnQwbGlv?=
 =?utf-8?B?Y0NkL3lFV3c5dWJaUHUwZm1WTDVyRHlSa2g2V3M2VUZ3RTdpRGpMcjQvV3Ny?=
 =?utf-8?B?UEI4TUNESmxiYVc1UG1qU1ViemZXTzhyaUw3TXkwb2w2RzlTb2J4bU5qL2s4?=
 =?utf-8?B?aHczejNEemdiUTg0L3R4bkpoaGtXeDBIc3E1YzhkcmN2em5mM0Evczl1YkpU?=
 =?utf-8?B?aXRGeXVoeDBOTDhsWStlYW03V3N4cEFTUHVQMlp2dStJaVFDeGZueW9YZ0Vw?=
 =?utf-8?B?MGgvVVZhbHFjbTA3SUJGb0dGTXFocCtWMWk2cmI3OVh5NnNuT25yOFRhRVJx?=
 =?utf-8?B?OWRweGErY1EvZXh1S3Uza0FxdVkxdWdFNmxwTFJyZFYwQlJYbEYwaWFidzVX?=
 =?utf-8?B?YWpMa0NERFM2cWhwREdQcFJ3cFdncEI0OWFxUHMxb2pDblVOUG1LR2Mrbk9n?=
 =?utf-8?B?QnRCaVl1RWszMFhQQVRqUEtrbzJNb3h0aEZDQitKZTRZZXliNjgvL2hrZmN2?=
 =?utf-8?B?dS9Cc2F1Ny9xcys3Z012SFhybWZZMVppa0tNMERDQ2NiZm1BUHZKSUt6UHVz?=
 =?utf-8?B?cDhpMnpIY0ZzNW1NNGJldEg5Q2xrVjU5MXBPSXVPZklkOWIwTG1TUmlvWXhh?=
 =?utf-8?B?NlRCV3lJalN4OE4yUHVKamsxMVVsQVBVczV4eTR1dUpvcERXRDMvNWdic0Qv?=
 =?utf-8?B?aDkzREZTL0c1aitHMndWdUt6bDFrOGJSemVxdzc0RTlsM0o2WGRETXpKcTVo?=
 =?utf-8?B?d2NrTi8ya2xhdGFIYXVPa1BpOEg4UlRnS0RoeEducHdzSVV6ZUE5MjZkL3NM?=
 =?utf-8?B?WE4zRFNFRUp3Z2FVcDM0V2dUMkJHTUYxMXorQ1psU3ZpakE2SEZXR2MrOGl4?=
 =?utf-8?B?d244MlBwaFc5QzdQZUUrZWltQURyNjRaWjk5VG5lZEFPaUJ1VkVaTnVxV3lm?=
 =?utf-8?B?NzJDeHNGZVliSFA1bkZiOVdSUjdlTGdzZ2ZuWHRsQVRBUEdtb0JTS0s1Vkxp?=
 =?utf-8?B?Nk9sM2cyNXNmWHJyVjdOU3NTd1FNaVNBb1NkYkM4eXgvVVVqbGNaTXdkUWhO?=
 =?utf-8?B?bkVHeU9SaWJmZVVJOGZFazY1MStNZFBPNlpqMmQ2c3huRzVORzNvV1dmSDV2?=
 =?utf-8?B?SlNIVDFLSUd1L3JmdlJMTnFkOUdTb25jSzlndXo5MlZYTGRZcU8rMXdUMEMw?=
 =?utf-8?B?R3dDMm9hdXQ0WWk3Vlo1Qi9TMVlONjNDYkEwNlNtYzJkWk5MWWlwVUo3OTJl?=
 =?utf-8?B?d1k3YTBCemJZMW11LyszWU5zN0RzbVdHRHo1Slk4eXpyUTg4RmtrYWJKMldk?=
 =?utf-8?B?bC8rRkh5aTBXdXFPSXJqYllFNlZySitTeHprMXByOTgxVmQ3WWR6V1Vxa2Jo?=
 =?utf-8?B?TGl0YWJ1UXUyMUh1UVZ3ZEN5SXZQTHFlc2RZL2hPaEp6VG1maGozNzBuL3g3?=
 =?utf-8?B?WTFoVWU0ZXl2cDJ5dFVVOG1rMFdDRjlvbkgrelpKcXo1RmxvaWt4dkpDdUFr?=
 =?utf-8?B?RHBFeEQyVWovNVI0OXBaZXRXZWthQy9tdjZ1b2tsSm95aTJFcG1jSDRVNS9n?=
 =?utf-8?B?QmFYWlBZSEx2d0IrNzV5a25oakVTKzVNMURNWFhLaTI3R2J1RHNoancyenRD?=
 =?utf-8?B?ejZJcFRxVDlscHdTK2FwZW42bHA0T1pmSmh6dzFUSXh6Y2J1NFFYc2JQQUg5?=
 =?utf-8?B?QnU0Sk5qT1lvRW1JbTNXQXNkYk5NQlpHUnJUTThlSndnQ0JhRnpoQWJzV21R?=
 =?utf-8?B?MXZVSm8vYU0rbzJHa1A0Y2paQmFOdi9iRi9GcFJrdUdTdG8ySWRWS2xZMFVR?=
 =?utf-8?B?elhFc0xWc0lSYUw2UFZ6SjJHUXcxQVlPdXFBOEllblN5K0IybjNuNXFFa0F3?=
 =?utf-8?B?OVh5WVVNYTJkZEJnelllVzhYQjVmQzRBN1N6NWJmWjMweTduUDA4L3V0MjJr?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ce556c-cbfc-40c8-1131-08da877f2af3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 16:22:27.9546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tENj42pl/dIWt+r8WFTQ9st/qnzNkcHt6lW8O9Y5DEcrQSxo1J7eEH3DgpGjk8+9fSWwLPQzx8tKmE2gZiNfXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3596
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a "FiiO DigiHug USB Audio" sound card (1852:7022) [3]. I have had
no problems with the audio, but I did notice a large number of message
like 

retire_capture_urb: 4992 callbacks suppressed

in my dmesg [1]. This is caused by the "Corrected urb data len."
warning. The patch adding this warning [2] makes it seem like
this warning should be an uncommon occurance. However, based on the
number of suppressed callbacks, this seems to be happening at a rate of
around 500 Hz.

Is this buggy hardware? Or is this a bug in the driver? Does there need
to be a quirk? Or perhaps the warning above should be a debug instead?

I'm using 5.15.0-46-generic. I know, I know; this is a vendor
kernel. However, I went through the commits for sound/usb/pcm.c and
didn't see any major differences. I also previously saw this issue on
5.4, so this probably isn't a regression.

--Sean

[1] I would have liked to post the actual message, but I was unable to
figure out how to disable ratelimiting. I tried setting
/proc/sys/kernel/printk_ratelimit to 0,
/proc/sys/kernel/printk_ratelimit_burst to 5000, and
/proc/sys/kernel/printk to 8. However, nothing seemed to have any effect
(except that the callbacks suppressed messages were disabled). I find
this very strange, given that the callbacks suppressed message uses
KERN_WARN, and so does dev_warn_ratelimited.
[2] https://lore.kernel.org/all/4B28A659.6070303@ladisch.de/T/
[3]
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x1852 GYROCOM C&C Co., LTD
  idProduct          0x7022 
  bcdDevice            0.01
  iManufacturer           1 FiiO
  iProduct                2 DigiHug USB Audio
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0182
    bNumInterfaces          4
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      58
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0012  1x 18 bytes
        bInterval              32
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              3 FiiO USB DAC-E10
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength       0x003e
        bInCollection           2
        baInterfaceNr(0)        2
        baInterfaceNr(1)        3
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             5
        wTerminalType      0x0605 SPDIF interface
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                12
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             9
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bNrChannels             2
        wChannelConfig     0x0003
          Left Front (L)
          Right Front (R)
        iChannelNames           0 
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0605 SPDIF interface
        bAssocTerminal          0
        bSourceID              16
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             7
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               5
        iTerminal               0 
      AudioControl Interface Descriptor:
        bLength                10
        bDescriptorType        36
        bDescriptorSubtype      6 (FEATURE_UNIT)
        bUnitID                16
        bSourceID               9
        bControlSize            1
        bmaControls(0)       0x01
          Mute Control
        bmaControls(1)       0x02
          Volume Control
        bmaControls(2)       0x02
          Volume Control
        iFeature                0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           7
        bDelay                  0 frames
        wFormatTag         0x0001 PCM
      AudioStreaming Interface Descriptor:
        bLength                26
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            6 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        16000
        tSamFreq[ 2]        32000
        tSamFreq[ 3]        44100
        tSamFreq[ 4]        48000
        tSamFreq[ 5]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0184  1x 388 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioStreaming Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay         0x0002
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           7
        bDelay                  0 frames
        wFormatTag         0x0001 PCM
      AudioStreaming Interface Descriptor:
        bLength                26
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            6 Discrete
        tSamFreq[ 0]         8000
        tSamFreq[ 1]        16000
        tSamFreq[ 2]        32000
        tSamFreq[ 3]        44100
        tSamFreq[ 4]        48000
        tSamFreq[ 5]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0246  1x 582 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioStreaming Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay         0x0002
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           9
        bDelay                  0 frames
        wFormatTag         0x0001 PCM
      AudioStreaming Interface Descriptor:
        bLength                20
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            4 Discrete
        tSamFreq[ 0]        32000
        tSamFreq[ 1]        44100
        tSamFreq[ 2]        48000
        tSamFreq[ 3]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0184  1x 388 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioStreaming Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay         0x0002
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           9
        bDelay                  0 frames
        wFormatTag         0x0001 PCM
      AudioStreaming Interface Descriptor:
        bLength                20
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             1 (FORMAT_TYPE_I)
        bNrChannels             2
        bSubframeSize           3
        bBitResolution         24
        bSamFreqType            4 Discrete
        tSamFreq[ 0]        32000
        tSamFreq[ 1]        44100
        tSamFreq[ 2]        48000
        tSamFreq[ 3]        96000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x0246  1x 582 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioStreaming Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay         0x0002
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        3
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass         1 Audio
      bInterfaceSubClass      2 Streaming
      bInterfaceProtocol      0 
      iInterface              0 
      AudioStreaming Interface Descriptor:
        bLength                 7
        bDescriptorType        36
        bDescriptorSubtype      1 (AS_GENERAL)
        bTerminalLink           9
        bDelay                  0 frames
        wFormatTag         0x2001 IEC1937_AC-3
      AudioStreaming Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      2 (FORMAT_TYPE)
        bFormatType             3 (FORMAT_TYPE_III)
        bNrChannels             2
        bSubframeSize           2
        bBitResolution         16
        bSamFreqType            1 Discrete
        tSamFreq[ 0]        48000
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            9
          Transfer Type            Isochronous
          Synch Type               Adaptive
          Usage Type               Data
        wMaxPacketSize     0x00c0  1x 192 bytes
        bInterval               1
        bRefresh                0
        bSynchAddress           0
        AudioStreaming Endpoint Descriptor:
          bLength                 7
          bDescriptorType        37
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         2 Decoded PCM samples
          wLockDelay         0x0002
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0000
  (Bus Powered)

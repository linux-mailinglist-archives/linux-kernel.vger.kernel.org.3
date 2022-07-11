Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1462C56913D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiGFR6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiGFR55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:57:57 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AF42A731
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 10:57:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id i190so1986919pge.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oTVz8F7Ca0MOXDZ5SWpx2sZVVYndmC1h9znTKY8D5ig=;
        b=bE06ibmx54YLvpfDkNoAuKn1wNLwZOP/SmQaDANCeM6cQUDhyWbIWxWMJi/dibfihj
         acdCz0Dh7iqKxWZ1QLxycsHnUttEqQKlMsfuwPabce/bGU2PWO8mChHNZrmzeXJOMQkt
         bJV11F3p9jafjQwwKa3SPsrR6eN9bjvR+lV3B+Cel4IowgjBmIka5SaXvN5+AREgSom+
         Qv4mmMJyeyffX4xh1mAYlKlelNnbnd8PofAmiss0ynrEBoExRqnm9KQI2Qcr3FsXg6HU
         jpj1XtMpoOdC+HHfVcE4Q/kPL21ieHkpT4VEHnamLVfJ8OZ4bToog1MsDR1qbvYF0ZWu
         loOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oTVz8F7Ca0MOXDZ5SWpx2sZVVYndmC1h9znTKY8D5ig=;
        b=bMnYhUgk3WSoWRlPAjRrt1K1Q4FNX2viQMrY5Pkkb4kTB2mWzT1xtkDs3nNHsNrG43
         IET6CUKyeT/U3/8kq5Xu/842BrCSHpmiQ+BFy4YTlACv9jKF0ZJvXSKl8Z6tSSaYsatp
         7rKVDzvA44aRMwbLKo2qy9GO3Ah/bHB/5/TxBSqhud3OG0oU9KB+NMHgEvnilMoPgKgf
         vCtXMGJZNKI245yWr6Y2Iu3ioNTDyRnrNA0rDY+aziBhu1lMlJhYZv3FNh3hGkp1Urfv
         fG15lZof1ijGDwCSfWOM7QoAevZ4UE26DcXA1kt/rOOucoBTtZN4lqajlU0l7a+IeOkt
         mNSw==
X-Gm-Message-State: AJIora8nZELxfMx2N1i2HEEQ0MWwMZgL+XZGgy68SvIF+ppOUFh/Gz5e
        HD2CXszvchWZFEqJOJm12ql/Fw==
X-Google-Smtp-Source: AGRyM1vUoA/XvUvHhp99en8TwBkGS87hr4P6umCMfQyq7qDFm3SSgwBIbtzSoWw2mGEMS3VB6pHyAA==
X-Received: by 2002:a05:6a00:1253:b0:525:886a:37df with SMTP id u19-20020a056a00125300b00525886a37dfmr49095419pfi.85.1657130275719;
        Wed, 06 Jul 2022 10:57:55 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902e74d00b0016be596c8afsm6706230plf.282.2022.07.06.10.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:57:54 -0700 (PDT)
Date:   Wed, 6 Jul 2022 11:57:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, alexander.shishkin@linux.intel.com,
        leo.yan@linaro.org, james.clark@arm.com, will@kernel.org,
        robin.murphy@arm.com, acme@kernel.org, jonathan.cameron@huawei.com,
        john.garry@huawei.com, helgaas@kernel.org,
        lorenzo.pieralisi@arm.com, suzuki.poulose@arm.com,
        mark.rutland@arm.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org,
        prime.zeng@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com
Subject: Re: [PATCH v9 7/8] docs: trace: Add HiSilicon PTT device driver
 documentation
Message-ID: <20220706175751.GA2546265@p14s>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <20220606115555.41103-8-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606115555.41103-8-yangyicong@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have started looking at this set.

On Mon, Jun 06, 2022 at 07:55:54PM +0800, Yicong Yang wrote:
> Document the introduction and usage of HiSilicon PTT device driver.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  Documentation/trace/hisi-ptt.rst | 307 +++++++++++++++++++++++++++++++
>  Documentation/trace/index.rst    |   1 +

The "get_maintainer" script clearly indicates that Jonathan Corbet maintains the
Documentation directory and yet he is not CC'ed on this patch, nor is the
linux-doc mainling list.  As such, it would not be possible to merge this
patchset.

>  2 files changed, 308 insertions(+)
>  create mode 100644 Documentation/trace/hisi-ptt.rst
> 
> diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
> new file mode 100644
> index 000000000000..0a3112244d40
> --- /dev/null
> +++ b/Documentation/trace/hisi-ptt.rst
> @@ -0,0 +1,307 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +HiSilicon PCIe Tune and Trace device
> +======================================
> +
> +Introduction
> +============
> +
> +HiSilicon PCIe tune and trace device (PTT) is a PCIe Root Complex
> +integrated Endpoint (RCiEP) device, providing the capability
> +to dynamically monitor and tune the PCIe link's events (tune),
> +and trace the TLP headers (trace). The two functions are independent,
> +but is recommended to use them together to analyze and enhance the
> +PCIe link's performance.
> +
> +On Kunpeng 930 SoC, the PCIe Root Complex is composed of several
> +PCIe cores. Each PCIe core includes several Root Ports and a PTT
> +RCiEP, like below. The PTT device is capable of tuning and
> +tracing the links of the PCIe core.
> +::
> +
> +          +--------------Core 0-------+
> +          |       |       [   PTT   ] |
> +          |       |       [Root Port]---[Endpoint]
> +          |       |       [Root Port]---[Endpoint]
> +          |       |       [Root Port]---[Endpoint]
> +    Root Complex  |------Core 1-------+
> +          |       |       [   PTT   ] |
> +          |       |       [Root Port]---[ Switch ]---[Endpoint]
> +          |       |       [Root Port]---[Endpoint] `-[Endpoint]
> +          |       |       [Root Port]---[Endpoint]
> +          +---------------------------+
> +
> +The PTT device driver registers one PMU device for each PTT device.
> +The name of each PTT device is composed of 'hisi_ptt' prefix with
> +the id of the SICL and the Core where it locates. The Kunpeng 930
> +SoC encapsulates multiple CPU dies (SCCL, Super CPU Cluster) and
> +IO dies (SICL, Super I/O Cluster), where there's one PCIe Root
> +Complex for each SICL.
> +::
> +
> +    /sys/devices/hisi_ptt<sicl_id>_<core_id>

All entries added to sysfs should have corresponding documentation.  See [1] and
[2] for details and [3] for an example.

[1]. https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/README
[2]. https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing
[3]. https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x

> +
> +Tune
> +====
> +
> +PTT tune is designed for monitoring and adjusting PCIe link parameters (events).
> +Currently we support events in 4 classes. The scope of the events
> +covers the PCIe core to which the PTT device belongs.
> +
> +Each event is presented as a file under $(PTT PMU dir)/tune, and
> +a simple open/read/write/close cycle will be used to tune the event.
> +::
> +
> +    $ cd /sys/devices/hisi_ptt<sicl_id>_<core_id>/tune
> +    $ ls
> +    qos_tx_cpl    qos_tx_np    qos_tx_p
> +    tx_path_rx_req_alloc_buf_level
> +    tx_path_tx_req_alloc_buf_level

These look overly long... How about watermark_rx and watermark_tx?

> +    $ cat qos_tx_dp
> +    1
> +    $ echo 2 > qos_tx_dp
> +    $ cat qos_tx_dp
> +    2
> +
> +Current value (numerical value) of the event can be simply read
> +from the file, and the desired value written to the file to tune.
> +
> +1. Tx path QoS control
> +------------------------
> +
> +The following files are provided to tune the QoS of the tx path of
> +the PCIe core.
> +
> +- qos_tx_cpl: weight of Tx completion TLPs
> +- qos_tx_np: weight of Tx non-posted TLPs
> +- qos_tx_p: weight of Tx posted TLPs
> +
> +The weight influences the proportion of certain packets on the PCIe link.
> +For example, for the storage scenario, increase the proportion
> +of the completion packets on the link to enhance the performance as
> +more completions are consumed.
> +
> +The available tune data of these events is [0, 1, 2].
> +Writing a negative value will return an error, and out of range
> +values will be converted to 2. Note that the event value just
> +indicates a probable level, but is not precise.
> +
> +2. Tx path buffer control
> +-------------------------
> +
> +Following files are provided to tune the buffer of tx path of the PCIe core.
> +
> +- tx_path_rx_req_alloc_buf_level: watermark of Rx requested
> +- tx_path_tx_req_alloc_buf_level: watermark of Tx requested
> +
> +These events influence the watermark of the buffer allocated for each
> +type. Rx means the inbound while Tx means outbound. The packets will
> +be stored in the buffer first and then transmitted either when the
> +watermark reached or when timed out. For a busy direction, you should
> +increase the related buffer watermark to avoid frequently posting and
> +thus enhance the performance. In most cases just keep the default value.
> +
> +The available tune data of above events is [0, 1, 2].
> +Writing a negative value will return an error, and out of range
> +values will be converted to 2. Note that the event value just
> +indicates a probable level, but is not precise.

This is useful documentation but it also should be found in the ABI
documentation referred to above.

> +
> +Trace
> +=====
> +
> +PTT trace is designed for dumping the TLP headers to the memory, which
> +can be used to analyze the transactions and usage condition of the PCIe
> +Link. You can choose to filter the traced headers by either requester ID,
> +or those downstream of a set of Root Ports on the same core of the PTT
> +device. It's also supported to trace the headers of certain type and of
> +certain direction.
> +
> +You can use the perf command `perf record` to set the parameters, start
> +trace and get the data. It's also supported to decode the trace
> +data with `perf report`. The control parameters for trace is inputted
> +as event code for each events, which will be further illustrated later.
> +An example usage is like
> +::
> +
> +    $ perf record -e hisi_ptt0_2/filter=0x80001,type=1,direction=1,
> +      format=1/ -- sleep 5
> +
> +This will trace the TLP headers downstream root port 0000:00:10.1 (event
> +code for event 'filter' is 0x80001) with type of posted TLP requests,
> +direction of inbound and traced data format of 8DW.
> +
> +1. filter
> +---------
> +
> +The TLP headers to trace can be filtered by the Root Ports or the requester
> +ID of the endpoints, which are located on the same core of the PTT device.
> +You can set the filter by specifying the `filter` parameter which is required
> +to start the trace. The parameter value is 20 bit. The supported filters and
> +related values are outputted through `available_root_port_filters` and
> +`available_requester_filters` sysfs attributes for Root Ports and Requesters
> +respectively.
> +::
> +
> +    $ cat available_root_port_filters
> +    0000:00:10.0	0x80001
> +    0000:00:11.0	0x80004
> +    $ cat available_requester_filters
> +    0000:01:00.0	0x00100
> +    0000:01:00.1	0x00101

If I remember correctly, one of the rule for sysfs is one line per entry.

> +
> +Note that multiple Root Ports can be specified at one time, but only
> +one Endpoint function can be specified in one trace. Specifying both
> +Root Port and function at the same time is not supported.
> +
> +If no filter is available, reading the related filter sysfs attribute
> +will get an empty string.
> +::
> +
> +    $ cat available_root_port_filters
> +
> +    $ cat available_requester_filters

Those too look overly long, and where to find them is not documented.  As such
users have to guest that it must be somewhere under
/sys/devices/hisi_ptt<sicl_id>_<core_id>/.

More comments tomorrow.

Thanks,
Mathieu

> +
> +Currently the available filters are detected in driver's probe. If the supported
> +devices are removed/added after probe, you may need to reload the driver to update
> +the available filters.
> +
> +2. type
> +-------
> +
> +You can trace the TLP headers of certain types by specifying the `type`
> +parameter, which is required to start the trace. The parameter value is
> +8 bit. Current supported types and related values are shown below:
> +
> +- 8'b00000001: posted requests (P)
> +- 8'b00000010: non-posted requests (NP)
> +- 8'b00000100: completions (CPL)
> +
> +You can specify multiple types when tracing inbound TLP headers, but can only
> +specify one when tracing outbound TLP headers.
> +
> +3. direction
> +------------
> +
> +You can trace the TLP headers from certain direction, which is relative
> +to the Root Port or the PCIe core, by specifying the `direction` parameter.
> +This is optional and the default parameter is inbound. The parameter value
> +is 4 bit. When the desired format is 4DW, directions and related values
> +supported are shown below:
> +
> +- 4'b0000: inbound TLPs (P, NP, CPL)
> +- 4'b0001: outbound TLPs (P, NP, CPL)
> +- 4'b0010: outbound TLPs (P, NP, CPL) and inbound TLPs (P, NP, CPL B)
> +- 4'b0011: outbound TLPs (P, NP, CPL) and inbound TLPs (CPL A)
> +
> +When the desired format is 8DW, directions and related values supported are
> +shown below:
> +
> +- 4'b0000: reserved
> +- 4'b0001: outbound TLPs (P, NP, CPL)
> +- 4'b0010: inbound TLPs (P, NP, CPL B)
> +- 4'b0011: inbound TLPs (CPL A)
> +
> +Inbound completions are classified into two types:
> +
> +- completion A (CPL A): completion of CHI/DMA/Native non-posted requests, except for CPL B
> +- completion B (CPL B): completion of DMA remote2local and P2P non-posted requests
> +
> +4. format
> +--------------
> +
> +You can change the format of the traced TLP headers by specifying the
> +`format` parameter. The default format is 4DW. The parameter value is 4 bit.
> +Current supported formats and related values are shown below:
> +
> +- 4'b0000: 4DW length per TLP header
> +- 4'b0001: 8DW length per TLP header
> +
> +The traced TLP header format is different from the PCIe standard.
> +
> +When using the 8DW data format, the entire TLP header is logged
> +(Header DW0-3 shown below). For example, the TLP header for Memory
> +Reads with 64-bit addresses is shown in PCIe r5.0, Figure 2-17;
> +the header for Configuration Requests is shown in Figure 2.20, etc.
> +
> +In addition, 8DW trace buffer entries contain a timestamp and
> +possibly a prefix for a PASID TLP prefix (see Figure 6-20, PCIe r5.0).
> +Otherwise this field will be all 0.
> +
> +The bit[31:11] of DW0 is always 0x1fffff, which can be
> +used to distinguish the data format. 8DW format is like
> +::
> +
> +    bits [                 31:11                 ][       10:0       ]
> +         |---------------------------------------|-------------------|
> +     DW0 [                0x1fffff               ][ Reserved (0x7ff) ]
> +     DW1 [                       Prefix                              ]
> +     DW2 [                     Header DW0                            ]
> +     DW3 [                     Header DW1                            ]
> +     DW4 [                     Header DW2                            ]
> +     DW5 [                     Header DW3                            ]
> +     DW6 [                   Reserved (0x0)                          ]
> +     DW7 [                        Time                               ]
> +
> +When using the 4DW data format, DW0 of the trace buffer entry
> +contains selected fields of DW0 of the TLP, together with a
> +timestamp.  DW1-DW3 of the trace buffer entry contain DW1-DW3
> +directly from the TLP header.
> +
> +4DW format is like
> +::
> +
> +    bits [31:30] [ 29:25 ][24][23][22][21][    20:11   ][    10:0    ]
> +         |-----|---------|---|---|---|---|-------------|-------------|
> +     DW0 [ Fmt ][  Type  ][T9][T8][TH][SO][   Length   ][    Time    ]
> +     DW1 [                     Header DW1                            ]
> +     DW2 [                     Header DW2                            ]
> +     DW3 [                     Header DW3                            ]
> +
> +5. memory management
> +--------------------
> +
> +The traced TLP headers will be written to the memory allocated
> +by the driver. The hardware accepts 4 DMA address with same size,
> +and writes the buffer sequentially like below. If DMA addr 3 is
> +finished and the trace is still on, it will return to addr 0.
> +::
> +
> +    +->[DMA addr 0]->[DMA addr 1]->[DMA addr 2]->[DMA addr 3]-+
> +    +---------------------------------------------------------+
> +
> +Driver will allocate each DMA buffer of 4MiB. The finished buffer
> +will be copied to the perf AUX buffer allocated by the perf core.
> +Once the AUX buffer is full while the trace is still on, driver
> +will commit the AUX buffer first and then apply for a new one with
> +the same size. The size of AUX buffer is default to 16MiB. User can
> +adjust the size by specifying the `-m` parameter of the perf command.
> +
> +6. decoding
> +-----------
> +
> +You can decode the traced data with `perf report -D` command (currently
> +only support to dump the raw trace data). The traced data will be decoded
> +according to the format described previously (take 8DW as an example):
> +::
> +
> +    [...perf headers and other information]
> +    . ... HISI PTT data: size 4194304 bytes
> +    .  00000000: 00 00 00 00                                 Prefix
> +    .  00000004: 01 00 00 60                                 Header DW0
> +    .  00000008: 0f 1e 00 01                                 Header DW1
> +    .  0000000c: 04 00 00 00                                 Header DW2
> +    .  00000010: 40 00 81 02                                 Header DW3
> +    .  00000014: 33 c0 04 00                                 Time
> +    .  00000020: 00 00 00 00                                 Prefix
> +    .  00000024: 01 00 00 60                                 Header DW0
> +    .  00000028: 0f 1e 00 01                                 Header DW1
> +    .  0000002c: 04 00 00 00                                 Header DW2
> +    .  00000030: 40 00 81 02                                 Header DW3
> +    .  00000034: 02 00 00 00                                 Time
> +    .  00000040: 00 00 00 00                                 Prefix
> +    .  00000044: 01 00 00 60                                 Header DW0
> +    .  00000048: 0f 1e 00 01                                 Header DW1
> +    .  0000004c: 04 00 00 00                                 Header DW2
> +    .  00000050: 40 00 81 02                                 Header DW3
> +    [...]
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index f9b7bcb5a630..dd423113b7b1 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -32,3 +32,4 @@ Linux Tracing Technologies
>     sys-t
>     coresight/index
>     user_events
> +   hisi-ptt
> -- 
> 2.24.0
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1950274F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbiDOJ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbiDOJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:26:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBF81D0E8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:23:53 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id u2so6885626pgq.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 02:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=yaJKtcI79Sr5OPi0ROX2doW6FLEyXaOfN/NlVNVwJrk=;
        b=dhjnpSZ0xDGfB4jrW8GTNHUYqTmw8gXJjsRf8ctVoFqMDUra1ZneE01RZXZkqHYsKO
         uz2/Xl6rPhBChk5zMDNeUk4sf9ZGovLBTGnebEgHqtICREq4Az+SzgM/6Od/8oZ1RnTb
         cq3HPy7Hjh3GPMe3DsJJwPrD8Su7QSKiKlP6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=yaJKtcI79Sr5OPi0ROX2doW6FLEyXaOfN/NlVNVwJrk=;
        b=dxKnfUlY+76yfYs7tDIEN60gp+6Qw5kEZtl3Mf5caCTwzDP2J20Gq/NWASLYAk5moo
         NuoSfM7AHNUQFLGt2+xc79BSxemoWuEM6cwSaSgZi9jKNriqYJfCWiJE9cN0/K/HlgM7
         95koJJz3O0MZyPC8j5mg3LWBXOsidcd/HCa8+cZM/lH3xjCFPwfYxf87VTBbPjq2fVeC
         m/0ig55EM7IGxKZkHK024iRgAu1TDSH/0VkjkScT3uaf+FJIqMW7PyY23YKfsGGfCW3P
         4/SI3jy0pl67cPibfsKteTle5HdBlszo8MKEb/PItqP4Ny7S4N/bWGG2MWnBSEhnhC55
         xFYQ==
X-Gm-Message-State: AOAM531bbHVHo7Wn0vJpZnqAsYKig5xbCADtDXruVwC8cfQvbfCzoj4o
        hGRUSw1GWS3l2mCsXK8Qlhz17FcSVUBW6g==
X-Google-Smtp-Source: ABdhPJxksBlVEoOObfJp2lC3bMnUyL2Cby7j0WZCOZ/gCpA5vO98ZFd5WabroIkjn7Sh9QShaXx5nA==
X-Received: by 2002:a63:cf0c:0:b0:380:fb66:fa2a with SMTP id j12-20020a63cf0c000000b00380fb66fa2amr5715841pgg.273.1650014632902;
        Fri, 15 Apr 2022 02:23:52 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:ff9f:dddf:d1f3:472c])
        by smtp.gmail.com with ESMTPSA id t20-20020a63eb14000000b0039e28245722sm3946395pgh.54.2022.04.15.02.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 02:23:52 -0700 (PDT)
Date:   Fri, 15 Apr 2022 18:23:47 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: out-of-bounds access in sound/soc/sof/topology.c
Message-ID: <Ylk5o3EC/hyX5UQ0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running 5.10.111 LTS, so if this has been fixed already then we definitely
want to cherry pick the fix for -stable.


Anonymous union in this struct is of zero size

/* generic control data */
struct sof_ipc_ctrl_data {
        struct sof_ipc_reply rhdr;
        uint32_t comp_id;

        /* control access and data type */
        uint32_t type;          /**< enum sof_ipc_ctrl_type */
        uint32_t cmd;           /**< enum sof_ipc_ctrl_cmd */
        uint32_t index;         /**< control index for comps > 1 control */

        /* control data - can either be appended or DMAed from host */
        struct sof_ipc_host_buffer buffer;
        uint32_t num_elems;     /**< in array elems or bytes for data type */
        uint32_t elems_remaining;       /**< elems remaining if sent in parts */

        uint32_t msg_index;     /**< for large messages sent in parts */

        /* reserved for future use */
        uint32_t reserved[6];

        /* control data - add new types if needed */
        union {
                /* channel values can be used by volume type controls */
                struct sof_ipc_ctrl_value_chan chanv[0];
                /* component values used by routing controls like mux, mixer */
                struct sof_ipc_ctrl_value_comp compv[0];
                /* data can be used by binary controls */
                struct sof_abi_hdr data[0];
        };
} __packed;

sof_ipc_ctrl_value_chan and sof_ipc_ctrl_value_comp are of the same
size - 8 bytes, while sof_abi_hdr is much larger - _at least_ 32 bytes
(`__u32 data[0]` in sof_abi_hdr suggest that there should be more
payload after header). But they all contribute 0 to sizeof(sof_ipc_ctrl_data).

Now control data allocations looks as follows

	scontrol->size = struct_size(scontrol->control_data, chanv,
				     le32_to_cpu(mc->num_channels));
	scontrol->control_data = kzalloc(scontrol->size, GFP_KERNEL);

Which is sizeof(sof_ipc_ctrl_data) + mc->num_channels * sizeof(sof_ipc_ctrl_value_chan)

For some reason it uses sizeof(sof_ipc_ctrl_value_chan), which is not
the largest member of the union.

And this is where the problem is: in order to make control->data.FOO loads
and stores legal we need mc->num_channels to be of at least 4. So that

   sizeof(sof_ipc_ctrl_data) + mc->num_channels * sizeof(sof_ipc_ctrl_value_chan)

                92           +        4         *            8

will be the same as

   sizeof(sof_ipc_ctrl_data) + sizeof(sof_abi_hdr).

                92           +           32

Otherwise scontrol->control_data->data.FOO will access nearby/foreign
slab object.

And there is at least one such memory access. In sof_get_control_data().

	wdata[i].pdata = wdata[i].control->control_data->data;
	*size += wdata[i].pdata->size;

pdata->size is at offset 8, but if, say, mc->num_channels == 1 then
we allocate only 8 bytes for pdata, so pdata->size is 4 bytes outside
of allocated slab object.

Thoughts?
